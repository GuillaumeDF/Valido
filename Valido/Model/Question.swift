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

/// L'image d'une question ETG **porte l'énoncé** : sans elle, « qui passe en premier ? »
/// n'a pas de sens. D'où `alt`, qui n'est pas du confort — c'est l'énoncé lui-même pour
/// qui n'accède pas à l'image. Une illustration sans `alt` rend la question injouable au
/// lecteur d'écran, donc la banque la rejette.
nonisolated struct Illustration: Codable, Sendable, Hashable {
    /// Nom d'un imageset du catalogue d'assets. Toujours local : aucune image ne se
    /// télécharge, l'app n'ouvre pas de connexion.
    let asset: String
    let alt: String

    init(asset: String, alt: String) {
        self.asset = asset
        self.alt = alt
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
    let illustration: Illustration?

    init(
        id: String,
        subject: Subject,
        topic: String,
        difficulty: Difficulty,
        prompt: String,
        options: [Option],
        correctID: Option.ID,
        explanation: String,
        sourceURL: URL? = nil,
        illustration: Illustration? = nil
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
        self.illustration = illustration
    }

    func isCorrect(_ optionID: Option.ID) -> Bool {
        optionID == correctID
    }
}
