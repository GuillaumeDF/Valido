import Foundation

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
