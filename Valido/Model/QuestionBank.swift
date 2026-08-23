import Foundation

nonisolated struct QuestionBank: Sendable {
    let questions: [Question]
    private let byID: [Question.ID: Question]

    init(questions: [Question]) throws {
        guard !questions.isEmpty else { throw ContentError.emptyBank }

        var index: [Question.ID: Question] = [:]
        for question in questions {
            guard index[question.id] == nil else {
                throw ContentError.duplicateID(question.id)
            }
            guard question.options.count >= 2 else {
                throw ContentError.tooFewOptions(question.id)
            }
            guard question.options.contains(where: { $0.id == question.correctID }) else {
                throw ContentError.correctIDNotInOptions(question.id)
            }
            guard !question.explanation.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                throw ContentError.emptyExplanation(question.id)
            }
            index[question.id] = question
        }

        self.questions = questions
        self.byID = index
    }

    init(json: Data) throws {
        try self.init(questions: try JSONDecoder().decode([Question].self, from: json))
    }

    static func bundled() throws -> QuestionBank {
        guard let url = Bundle.main.url(forResource: "questions", withExtension: "json") else {
            throw ContentError.resourceMissing
        }
        return try QuestionBank(json: try Data(contentsOf: url))
    }

    var count: Int { questions.count }

    func question(id: Question.ID) -> Question? { byID[id] }
}
