import Foundation

nonisolated struct FileProgressStore: ProgressStore {
    private let url: URL

    init(url: URL) {
        self.url = url
    }

    static func defaultURL() throws -> URL {
        let directory = try FileManager.default.url(
            for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
        .appending(path: "Valido", directoryHint: .isDirectory)

        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        return directory.appending(path: "progress.json")
    }

    func load() -> ProgressSnapshot {
        guard let data = try? Data(contentsOf: url),
              let snapshot = try? JSONDecoder().decode(ProgressSnapshot.self, from: data)
        else {
            return ProgressSnapshot()
        }
        return snapshot
    }

    func save(_ snapshot: ProgressSnapshot) throws {
        let data = try JSONEncoder().encode(snapshot)
        try data.write(to: url, options: .atomic)
    }
}
