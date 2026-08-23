import Foundation
import Observation

/// Efface le type d'un générateur pour pouvoir le stocker et le passer en `inout`.
/// Sémantique de référence assumée : deux copies partagent la même suite tirée.
nonisolated struct AnyRandomNumberGenerator: RandomNumberGenerator {
    private final class Box<R: RandomNumberGenerator> {
        var base: R
        init(_ base: R) { self.base = base }
    }

    private let advance: () -> UInt64

    init(_ base: some RandomNumberGenerator) {
        let box = Box(base)
        advance = { box.base.next() }
    }

    func next() -> UInt64 { advance() }
}
