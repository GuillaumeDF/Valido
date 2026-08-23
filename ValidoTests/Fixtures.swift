import Foundation
@testable import Valido

enum Fixtures {
    static func question(
        id: String,
        subject: Subject = .code,
        topic: String = "Vitesse",
        difficulty: Difficulty = .facile
    ) -> Question {
        Question(
            id: id,
            subject: subject,
            topic: topic,
            difficulty: difficulty,
            prompt: "Énoncé \(id)",
            options: [
                Option(id: "A", text: "a"),
                Option(id: "B", text: "b"),
                Option(id: "C", text: "c"),
                Option(id: "D", text: "d"),
            ],
            correctID: "B",
            explanation: "Explication \(id)"
        )
    }

    /// Banque à deux matières, pour tout ce qui touche au filtrage par source.
    static func mixedBank(code: Int, swift: Int) throws -> QuestionBank {
        var questions = (1...code).map { question(id: "c\($0)", subject: .code, topic: "Vitesse") }
        questions += (1...swift).map { question(id: "s\($0)", subject: .swift, topic: "Langage") }
        return try QuestionBank(questions: questions)
    }

    static func bank(count: Int) throws -> QuestionBank {
        try QuestionBank(questions: (1...count).map { question(id: "q\($0)") })
    }
}
