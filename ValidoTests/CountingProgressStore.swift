import Foundation
@testable import Valido

/// Compte les appels à `save` pour vérifier que les écritures sont groupées
/// et non faites à chaque réponse.
final class CountingProgressStore: ProgressStore, @unchecked Sendable {
    private let lock = NSLock()
    private var snapshot: ProgressSnapshot
    private(set) var saveCount = 0

    // `init` explicite, calqué sur `InMemoryProgressStore` : la cible app compile avec
    // `SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor`, ce que le paquet n'avait pas. Une valeur
    // par défaut de propriété stockée est alors évaluée dans un contexte nonisolated (la
    // classe est `@unchecked Sendable`, donc hors du MainActor) alors que `ProgressSnapshot()`
    // y est isolé au MainActor — d'où « main actor-isolated default value in a nonisolated
    // context ». Assigner dans l'init lève l'ambiguïté.
    init() {
        snapshot = ProgressSnapshot()
    }

    func load() -> ProgressSnapshot { lock.withLock { snapshot } }

    func save(_ snapshot: ProgressSnapshot) throws {
        lock.withLock {
            self.snapshot = snapshot
            saveCount += 1
        }
    }
}
