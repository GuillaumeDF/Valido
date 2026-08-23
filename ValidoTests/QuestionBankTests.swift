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
    #expect(questions[0].illustration == nil)
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

@Test func decodeUneQuestionIllustrée() throws {
    let json = Data("""
    [{
      "id": "img",
      "subject": "code",
      "topic": "Priorités & intersections",
      "difficulty": "moyen",
      "prompt": "Qui passe en premier ?",
      "options": [{"id": "A", "text": "vous"}, {"id": "B", "text": "la voiture jaune"}],
      "correctID": "B",
      "explanation": "Priorité à droite : la jaune arrive de votre droite.",
      "illustration": {
        "asset": "carrefour-priorite-droite-01",
        "alt": "Carrefour en croix sans panneau ; une voiture jaune arrive de votre droite."
      }
    }]
    """.utf8)

    let questions = try JSONDecoder().decode([Question].self, from: json)

    #expect(questions[0].illustration?.asset == "carrefour-priorite-droite-01")
    #expect(questions[0].illustration?.alt.isEmpty == false)
}

@Test func assetDIllustrationVideRejeté() {
    let q = Question(
        id: "i1", subject: .code, topic: "Vitesse", difficulty: .facile,
        prompt: "?", options: [Option(id: "A", text: "a"), Option(id: "B", text: "b")],
        correctID: "A", explanation: "parce que",
        illustration: Illustration(asset: "  ", alt: "Une scène décrite")
    )
    #expect(throws: ContentError.invalidIllustration("i1")) {
        try QuestionBank(questions: [q])
    }
}

/// Sans `alt`, une question dont l'énoncé est porté par l'image est injouable
/// au lecteur d'écran : l'énoncé y est littéralement absent.
@Test func altDIllustrationVideRejeté() {
    let q = Question(
        id: "i2", subject: .code, topic: "Vitesse", difficulty: .facile,
        prompt: "?", options: [Option(id: "A", text: "a"), Option(id: "B", text: "b")],
        correctID: "A", explanation: "parce que",
        illustration: Illustration(asset: "une-scene", alt: "\n ")
    )
    #expect(throws: ContentError.invalidIllustration("i2")) {
        try QuestionBank(questions: [q])
    }
}
