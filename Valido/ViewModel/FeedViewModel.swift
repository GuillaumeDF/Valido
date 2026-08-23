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

    /// Les sources activées. Tout coché par défaut ; persisté entre les lancements.
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

    /// Alimente la fenêtre devant `currentIndex`. Le tableau ne fait que croître.
    ///
    /// La fenêtre n'est délibérément PAS rognée par l'avant. Retirer `cards[0]` supprimait
    /// une carte entière de contenu au-dessus de la zone visible, pendant que
    /// `onChange(of: position)` traitait une transition en cours : le ScrollView devait
    /// alors recalculer son décalage en pleine résolution de calage, ce qui produisait un
    /// saut visible à partir de la 6e carte, puis à chaque balayage.
    ///
    /// Ce qui rend le flux infini est la paresse du `LazyVStack` — il ne matérialise que
    /// les lignes visibles, quelle que soit la longueur du tableau — et non la brièveté de
    /// ce tableau. Le coût mémoire est négligeable : une session d'une heure à une carte
    /// par seconde donne ~3600 `Card`, dont les chaînes sont partagées avec la banque.
    ///
    /// Terminaison : `cards.count` croît strictement à chaque tour, donc la condition
    /// finit par être fausse.
    func ensureCards(currentIndex: Int) {
        while cards.count <= currentIndex + Self.lookahead {
            appendCard()
        }
    }

    /// Rend `true` si la réponse est bonne. Une deuxième réponse sur la même carte est ignorée.
    func answer(_ optionID: Option.ID, at index: Int) -> Bool {
        guard let card = card(at: index), let presented = card.presented else { return false }
        let correct = presented.question.isCorrect(optionID)

        guard !answered.contains(index) else { return correct }
        answered.insert(index)

        combo.answer(correct: correct)
        progress.recordAnswer(presented.id, correct: correct)
        unsavedAnswers += 1
        if unsavedAnswers >= Self.saveEvery { flush() }

        return correct
    }

    /// Change les sources activées et rend l'effet immédiat.
    ///
    /// Les cartes préparées devant `currentIndex` peuvent venir d'une source qu'on vient
    /// de décocher : elles sont jetées et réalimentées, parce que décocher Swift et en
    /// recevoir quand même se lirait comme un bug. Retirer par l'ARRIÈRE ne déplace rien
    /// à l'écran — c'était retirer par l'avant qui causait le saut visible corrigé plus tôt.
    func apply(_ newSelection: SourceSelection, currentIndex: Int) {
        guard newSelection != selection else { return }
        selection = newSelection
        try? selectionStore.save(newSelection)

        if cards.count > currentIndex + 1 {
            cards.removeSubrange((currentIndex + 1)...)
        }
        // Les index au-delà de la position courante vont recevoir de nouvelles questions :
        // sans ça, une carte déjà répondue à cet index resterait muette pour toujours.
        answered = answered.filter { $0 <= currentIndex }

        ensureCards(currentIndex: currentIndex)
    }

    /// Nombre de questions disponibles pour une source, affiché dans la feuille de filtres.
    func count(of subject: Subject) -> Int {
        bank.questions.count { $0.subject == subject }
    }

    func flush() {
        try? store.save(progress)
        unsavedAnswers = 0
    }

    /// L'index est absolu dans le flux. Depuis la suppression du rognage par l'avant,
    /// `cards[0]` est toujours la première carte servie, donc index et position dans le
    /// tableau coïncident — il n'y a plus de décalage à corriger.
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
