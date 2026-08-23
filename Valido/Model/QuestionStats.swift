import Foundation

nonisolated struct QuestionStats: Codable, Sendable, Equatable {
    var attempts: Int
    var failures: Int
    var lastServeIndex: Int?

    init(attempts: Int = 0, failures: Int = 0, lastServeIndex: Int? = nil) {
        self.attempts = attempts
        self.failures = failures
        self.lastServeIndex = lastServeIndex
    }

    var failureRate: Double {
        attempts == 0 ? 0 : Double(failures) / Double(attempts)
    }
}
