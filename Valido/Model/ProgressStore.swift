import Foundation

nonisolated protocol ProgressStore: Sendable {
    func load() -> ProgressSnapshot
    func save(_ snapshot: ProgressSnapshot) throws
}

nonisolated final class InMemoryProgressStore: ProgressStore, @unchecked Sendable {
    private let lock = NSLock()
    private var snapshot = ProgressSnapshot()

    init(snapshot: ProgressSnapshot = ProgressSnapshot()) {
        self.snapshot = snapshot
    }

    func load() -> ProgressSnapshot {
        lock.withLock { snapshot }
    }

    func save(_ snapshot: ProgressSnapshot) throws {
        lock.withLock { self.snapshot = snapshot }
    }
}
