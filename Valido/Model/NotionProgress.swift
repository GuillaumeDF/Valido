import Foundation

nonisolated struct NotionProgress: Codable, Sendable, Equatable {
    var cartesDeLaSérie: Set<Question.ID>
    var acquise: Bool

    init(cartesDeLaSérie: Set<Question.ID> = [], acquise: Bool = false) {
        self.cartesDeLaSérie = cartesDeLaSérie
        self.acquise = acquise
    }
}
