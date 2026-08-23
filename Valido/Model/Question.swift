import Foundation

nonisolated enum Subject: String, Codable, Sendable, CaseIterable {
    case code
    case swift
}

nonisolated enum Difficulty: String, Codable, Sendable, CaseIterable {
    case facile
    case moyen
    case costaud
}

nonisolated struct Option: Identifiable, Codable, Sendable, Hashable {
    let id: String   // la lettre d'origine Notion : "A", "B", "C", "D"
    let text: String

    init(id: String, text: String) {
        self.id = id
        self.text = text
    }
}

nonisolated struct Question: Identifiable, Codable, Sendable, Hashable {
    let id: String   // ID de page Notion
    let subject: Subject
    let topic: String
    let difficulty: Difficulty
    let prompt: String
    let options: [Option]
    let correctID: Option.ID
    let explanation: String
    let sourceURL: URL?

    init(
        id: String,
        subject: Subject,
        topic: String,
        difficulty: Difficulty,
        prompt: String,
        options: [Option],
        correctID: Option.ID,
        explanation: String,
        sourceURL: URL? = nil
    ) {
        self.id = id
        self.subject = subject
        self.topic = topic
        self.difficulty = difficulty
        self.prompt = prompt
        self.options = options
        self.correctID = correctID
        self.explanation = explanation
        self.sourceURL = sourceURL
    }

    func isCorrect(_ optionID: Option.ID) -> Bool {
        optionID == correctID
    }
}
