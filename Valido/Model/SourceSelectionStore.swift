import Foundation

nonisolated protocol SourceSelectionStore: Sendable {
    func load() -> SourceSelection
    func save(_ selection: SourceSelection) throws
}

nonisolated final class InMemorySourceSelectionStore: SourceSelectionStore, @unchecked Sendable {
    private let lock = NSLock()
    private var selection: SourceSelection

    init(selection: SourceSelection = SourceSelection()) {
        self.selection = selection
    }

    func load() -> SourceSelection {
        lock.withLock { selection }
    }

    func save(_ selection: SourceSelection) throws {
        lock.withLock { self.selection = selection }
    }
}
