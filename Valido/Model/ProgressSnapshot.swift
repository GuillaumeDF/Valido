import Foundation

nonisolated struct ProgressSnapshot: Codable, Sendable, Equatable {
    var serveIndex: Int
    var stats: [Question.ID: QuestionStats]
    var notions: [String: NotionProgress]

    init(
        serveIndex: Int = 0,
        stats: [Question.ID: QuestionStats] = [:],
        notions: [String: NotionProgress] = [:]
    ) {
        self.serveIndex = serveIndex
        self.stats = stats
        self.notions = notions
    }

    // `decodeIfPresent` et non le Codable synthétisé : un fichier écrit avant cette version
    // n'a pas la clé, et `FileProgressStore.load()` avale l'erreur avec `try?` — toute la
    // progression serait remise à zéro sans que rien ne le signale.
    init(from decoder: any Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        serveIndex = try c.decode(Int.self, forKey: .serveIndex)
        stats = try c.decode([Question.ID: QuestionStats].self, forKey: .stats)
        notions = try c.decodeIfPresent([String: NotionProgress].self, forKey: .notions) ?? [:]
    }

    func stats(for id: Question.ID) -> QuestionStats {
        stats[id] ?? QuestionStats()
    }

    func estAcquise(_ notion: String?) -> Bool {
        guard let notion else { return true }
        return notions[notion]?.acquise ?? false
    }

    mutating func recordServe(_ id: Question.ID) {
        serveIndex += 1
        var entry = stats(for: id)
        entry.lastServeIndex = serveIndex
        stats[id] = entry
    }

    mutating func recordAnswer(
        _ id: Question.ID,
        correct: Bool,
        notion: String?,
        masteryStreak: Int
    ) {
        var entry = stats(for: id)
        entry.attempts += 1
        if !correct { entry.failures += 1 }
        stats[id] = entry

        guard let notion else { return }
        var n = notions[notion] ?? NotionProgress()
        if correct {
            n.cartesDeLaSérie.insert(id)
            if n.cartesDeLaSérie.count >= masteryStreak { n.acquise = true }
        } else {
            n.cartesDeLaSérie.removeAll()
        }
        notions[notion] = n
    }
}
