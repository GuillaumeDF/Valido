import Foundation
import Observation

@MainActor
@Observable
final class FeedViewModel {
    /// Cartes préparées devant la position courante.
    static let lookahead = 3
    /// Nombre de réponses entre deux écritures disque.
    static let saveEvery = 5

    private(set) var cards: [Card] = []
    private(set) var combo = ComboEngine()

    private(set) var selection: SourceSelection

    private let bank: QuestionBank
    private let store: any ProgressStore
    private let selectionStore: any SourceSelectionStore
    private let scheduler: CardScheduler
    private var rng: AnyRandomNumberGenerator
    private var progress: ProgressSnapshot
    private var recent: [Question.ID] = []
    private var answered: Set<Int> = []
    private var unsavedAnswers = 0

    init(
        bank: QuestionBank,
        store: any ProgressStore,
        selectionStore: any SourceSelectionStore = InMemorySourceSelectionStore(),
        scheduler: CardScheduler = CardScheduler(),
        rng: some RandomNumberGenerator = SystemRandomNumberGenerator()
    ) {
        self.bank = bank
        self.store = store
        self.selectionStore = selectionStore
        self.selection = selectionStore.load()
        self.scheduler = scheduler
        self.rng = AnyRandomNumberGenerator(rng)
        self.progress = store.load()
    }

    func start() {
        guard cards.isEmpty else { return }
        for _ in 0..<Self.lookahead { appendCard() }
    }

    /// Le tableau n'est délibérément **pas** rogné par l'avant : retirer `cards[0]` pendant
    /// que le `ScrollView` résout un calage lui fait recalculer son décalage, d'où un saut
    /// visible à chaque balayage. C'est la paresse du `LazyVStack` qui rend le flux infini,
    /// pas la brièveté du tableau.
    func ensureCards(currentIndex: Int) {
        while cards.count <= currentIndex + Self.lookahead {
            appendCard()
        }
    }

    func answer(_ optionID: Option.ID, at index: Int) -> Bool {
        guard let card = card(at: index), let presented = card.presented else { return false }
        let correct = presented.question.isCorrect(optionID)

        guard !answered.contains(index) else { return correct }
        answered.insert(index)

        combo.answer(correct: correct)
        let notion = presented.question.notion
        progress.recordAnswer(
            presented.id,
            correct: correct,
            notion: notion,
            masteryStreak: min(scheduler.config.masteryStreak, bank.count(notion: notion))
        )
        unsavedAnswers += 1
        if unsavedAnswers >= Self.saveEvery { flush() }

        return correct
    }

    func apply(_ newSelection: SourceSelection, currentIndex: Int) {
        guard newSelection != selection else { return }
        selection = newSelection
        try? selectionStore.save(newSelection)

        if cards.count > currentIndex + 1 {
            cards.removeSubrange((currentIndex + 1)...)
        }
        // Ces index vont recevoir de nouvelles questions : sans ça, une carte déjà
        // répondue à cet index resterait muette pour toujours.
        answered = answered.filter { $0 <= currentIndex }

        ensureCards(currentIndex: currentIndex)
    }

    func count(of subject: Subject) -> Int {
        bank.questions.count { $0.subject == subject }
    }

    var notionsAcquises: Int {
        notionsServies.count { progress.estAcquise($0) }
    }

    var notionsTotal: Int {
        notionsServies.count
    }

    private var notionsServies: Set<String> {
        Set(bank.questions.filter { selection.includes($0.subject) }.compactMap(\.notion))
    }

    func flush() {
        try? store.save(progress)
        unsavedAnswers = 0
    }

    func card(at index: Int) -> Card? {
        guard cards.indices.contains(index) else { return nil }
        return cards[index]
    }

    private func appendCard() {
        let scheduled = scheduler.next(bank: bank, progress: progress, recent: recent,
                                       selection: selection, rng: &rng)
        cards.append(scheduled.card)
        progress.recordServe(scheduled.card.id)
        recent.append(scheduled.card.id)
        if recent.count > scheduler.config.recentWindow {
            recent.removeFirst(recent.count - scheduler.config.recentWindow)
        }
    }
}
