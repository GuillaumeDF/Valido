import Foundation
import Testing
@testable import Valido

@Test func decodeUneQuestion() throws {
    let json = Data("""
    [{
      "id": "abc",
      "subject": "code",
      "topic": "Vitesse",
      "difficulty": "facile",
      "prompt": "Sous la pluie, 110 devient :",
      "options": [{"id": "A", "text": "110 km/h"}, {"id": "B", "text": "100 km/h"}],
      "correctID": "B",
      "explanation": "100 km/h. 130 devient 110, 110 devient 100."
    }]
    """.utf8)

    let questions = try JSONDecoder().decode([Question].self, from: json)

    #expect(questions.count == 1)
    #expect(questions[0].subject == .code)
    #expect(questions[0].difficulty == .facile)
    #expect(questions[0].correctID == "B")
    #expect(questions[0].sourceURL == nil)
}

@Test func banqueVideRejetée() {
    #expect(throws: ContentError.emptyBank) {
        try QuestionBank(questions: [])
    }
}

@Test func identifiantDupliquéRejeté() {
    let q = Fixtures.question(id: "dup")
    #expect(throws: ContentError.duplicateID("dup")) {
        try QuestionBank(questions: [q, q])
    }
}

@Test func moinsDeDeuxOptionsRejeté() {
    let q = Question(
        id: "x", subject: .code, topic: "Vitesse", difficulty: .facile,
        prompt: "?", options: [Option(id: "A", text: "seule")],
        correctID: "A", explanation: "parce que"
    )
    #expect(throws: ContentError.tooFewOptions("x")) {
        try QuestionBank(questions: [q])
    }
}

@Test func bonneRéponseAbsenteDesOptionsRejetée() {
    let q = Question(
        id: "y", subject: .code, topic: "Vitesse", difficulty: .facile,
        prompt: "?", options: [Option(id: "A", text: "a"), Option(id: "B", text: "b")],
        correctID: "Z", explanation: "parce que"
    )
    #expect(throws: ContentError.correctIDNotInOptions("y")) {
        try QuestionBank(questions: [q])
    }
}

@Test func explicationVideRejetée() {
    let q = Question(
        id: "z", subject: .code, topic: "Vitesse", difficulty: .facile,
        prompt: "?", options: [Option(id: "A", text: "a"), Option(id: "B", text: "b")],
        correctID: "A", explanation: "   "
    )
    #expect(throws: ContentError.emptyExplanation("z")) {
        try QuestionBank(questions: [q])
    }
}

@Test func indexParIdentifiant() throws {
    let bank = try Fixtures.bank(count: 3)
    #expect(bank.count == 3)
    #expect(bank.question(id: "q1")?.id == "q1")
    #expect(bank.question(id: "inconnu") == nil)
}
