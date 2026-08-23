import Foundation

nonisolated struct PresentedQuestion: Identifiable, Sendable, Equatable {
    let question: Question
    let displayOptions: [Option]

    init(question: Question, displayOptions: [Option]) {
        self.question = question
        self.displayOptions = displayOptions
    }

    var id: Question.ID { question.id }
}

nonisolated enum Card: Identifiable, Sendable, Equatable {
    case question(PresentedQuestion)

    var id: String {
        switch self {
        case .question(let presented): presented.id
        }
    }

    var presented: PresentedQuestion? {
        switch self {
        case .question(let presented): presented
        }
    }
}

nonisolated enum Draw: Sendable, Equatable {
    case weighted
    case uniform
}

nonisolated struct ScheduledCard: Sendable, Equatable {
    let card: Card
    let draw: Draw

    init(card: Card, draw: Draw) {
        self.card = card
        self.draw = draw
    }
}
