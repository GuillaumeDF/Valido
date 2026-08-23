import Foundation

nonisolated struct ProgressSnapshot: Codable, Sendable, Equatable {
    var serveIndex: Int
    var stats: [Question.ID: QuestionStats]

    init(serveIndex: Int = 0, stats: [Question.ID: QuestionStats] = [:]) {
        self.serveIndex = serveIndex
        self.stats = stats
    }

    func stats(for id: Question.ID) -> QuestionStats {
        stats[id] ?? QuestionStats()
    }

    mutating func recordServe(_ id: Question.ID) {
        serveIndex += 1
        var entry = stats(for: id)
        entry.lastServeIndex = serveIndex
        stats[id] = entry
    }

    mutating func recordAnswer(_ id: Question.ID, correct: Bool) {
        var entry = stats(for: id)
        entry.attempts += 1
        if !correct { entry.failures += 1 }
        stats[id] = entry
    }
}
