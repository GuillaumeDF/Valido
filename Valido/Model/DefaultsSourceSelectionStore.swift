import Foundation

/// `UserDefaults` plutôt qu'un fichier JSON : c'est une préférence, pas de la progression.
///
/// `load()` ne lance jamais, comme `FileProgressStore.load()` et pour la même raison —
/// perdre une préférence se reclique en deux secondes, bloquer l'app sur une valeur
/// illisible ne se pardonne pas. Une valeur absente ou corrompue rend « tout coché ».
nonisolated struct DefaultsSourceSelectionStore: SourceSelectionStore, @unchecked Sendable {
    static let key = "valido.sourceSelection"

    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func load() -> SourceSelection {
        guard let data = defaults.data(forKey: Self.key),
              let selection = try? JSONDecoder().decode(SourceSelection.self, from: data)
        else { return SourceSelection() }
        return selection
    }

    func save(_ selection: SourceSelection) throws {
        defaults.set(try JSONEncoder().encode(selection), forKey: Self.key)
    }
}
