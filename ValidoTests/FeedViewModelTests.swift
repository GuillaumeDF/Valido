import Foundation
import Testing
@testable import Valido

@MainActor
private func modèle(questions: Int = 100, store: any ProgressStore = InMemoryProgressStore())
throws -> FeedViewModel {
    FeedViewModel(
        bank: try Fixtures.bank(count: questions),
        store: store,
        scheduler: CardScheduler(),
        rng: SeededRNG(seed: 1)
    )
}

@MainActor
@Test func démarrageRemplitLaFenêtre() throws {
    let model = try modèle()
    model.start()
    #expect(model.cards.count == FeedViewModel.lookahead)
}

@MainActor
@Test func leDefilementNeRogneJamaisLAvantDeLaFenetre() throws {
    let model = try modèle()
    model.start()

    // Remplace `lAvanceAlimenteEtLaFenêtreResteBornée`, dont la prémisse était fausse.
    // Rogner l'avant retirait une carte entière de contenu AU-DESSUS de la zone visible
    // pendant la transition de défilement, forçant le ScrollView à recalculer son décalage :
    // c'est le saut visible signalé à partir de la 6e carte, puis à chaque balayage.
    // Ce qui rend le flux infini est la paresse du LazyVStack, pas la longueur du tableau.
    // `firstIndex` a disparu avec la restructuration : l'invariant s'exprime maintenant
    // par l'identité de la première carte, qui ne doit jamais changer. Si la fenêtre était
    // rognée par l'avant, `card(at: 0)` désignerait une autre question.
    let premiere = model.card(at: 0)!.id
    for index in 0..<200 {
        model.ensureCards(currentIndex: index)
        #expect(model.card(at: 0)?.id == premiere, "la fenêtre a été rognée par l'avant à l'index \(index)")
        #expect(model.card(at: index) != nil, "carte absente à l'index \(index)")
    }

    // La fenêtre couvre la position courante plus le lookahead, et rien de plus.
    #expect(model.cards.count == 200 + FeedViewModel.lookahead)
}

@MainActor
@Test func bonneRéponseMonteLeCombo() throws {
    let model = try modèle()
    model.start()
    let carte = model.cards[0].presented!
    let juste = model.answer(carte.question.correctID, at: 0)
    #expect(juste == true)
    #expect(model.combo.multiplier == 1)
}

@MainActor
@Test func mauvaiseRéponseRemetLeComboÀZéro() throws {
    // Anciennement `mauvaiseRéponseBloque` : le blocage n'existe plus (verdict symétrique),
    // donc ce test n'épingle que ce qui reste — la mise perdue. La série est construite
    // avant la faute, sinon la remise à zéro n'aurait rien à défaire.
    let model = try modèle()
    model.start()
    for index in 0..<2 {
        model.ensureCards(currentIndex: index)
        let juste = model.card(at: index)!.presented!
        _ = model.answer(juste.question.correctID, at: index)
    }
    #expect(model.combo.multiplier == 2)

    model.ensureCards(currentIndex: 2)
    let carte = model.card(at: 2)!.presented!
    let fausse = carte.displayOptions.first { $0.id != carte.question.correctID }!
    let juste = model.answer(fausse.id, at: 2)
    #expect(juste == false)
    #expect(model.combo.multiplier == 0)
}

@MainActor
@Test func lesRéponsesSontAgrégéesDansLaProgression() throws {
    let store = InMemoryProgressStore()
    let model = try modèle(store: store)
    model.start()

    for index in 0..<5 {
        model.ensureCards(currentIndex: index)
        let carte = model.card(at: index)!.presented!
        _ = model.answer(carte.question.correctID, at: index)
    }
    model.flush()

    let snapshot = store.load()
    let tentatives = snapshot.stats.values.reduce(0) { $0 + $1.attempts }
    #expect(tentatives == 5)
}

@MainActor
@Test func répondreDeuxFoisÀLaMêmeCarteNeCompteQuUneFois() throws {
    let store = InMemoryProgressStore()
    let model = try modèle(store: store)
    model.start()
    let carte = model.cards[0].presented!

    _ = model.answer(carte.question.correctID, at: 0)
    _ = model.answer(carte.question.correctID, at: 0)
    model.flush()

    let snapshot = store.load()
    #expect(snapshot.stats(for: carte.id).attempts == 1)
}

/// Le scheduler ressert délibérément une question faible une fois qu'elle sort de la
/// fenêtre anti-répétition (`recentWindow`) — `Card.id == Question.id`, donc si `answered`
/// est clé par identifiant de question plutôt que par position dans le flux, la deuxième
/// présentation de la même question est prise pour "deuxième tap sur la même carte" et
/// silencieusement ignorée : `combo` ne bouge plus, `progress.recordAnswer` n'est pas
/// appelé, et le verdict asymétrique s'inverse. Ce test force ce scénario avec
/// `recentWindow: 0` (aucune exclusion, donc l'unique question de la banque revient
/// immédiatement) et vérifie que les deux présentations comptent bien séparément.
@MainActor @Test func laMêmeQuestionServieDeuxFoisCompteDeuxFois() throws {
    let store = InMemoryProgressStore()
    let model = FeedViewModel(bank: try Fixtures.bank(count: 1), store: store,
                          scheduler: CardScheduler(config: SchedulerConfig(recentWindow: 0)),
                          rng: SeededRNG(seed: 1))
    model.start()
    for index in 0..<2 {
        model.ensureCards(currentIndex: index)
        let carte = try #require(model.card(at: index)?.presented)
        _ = model.answer(carte.question.correctID, at: index)
    }
    model.flush()
    #expect(store.load().stats.values.reduce(0) { $0 + $1.attempts } == 2)
    #expect(model.combo.multiplier == 2)
}

/// Répond à `count` cartes distinctes, en avançant l'index à chaque fois pour que
/// `ensureCards` alimente la fenêtre et que le scheduler serve une question différente.
@MainActor
private func répondreÀDesCartesDistinctes(_ model: FeedViewModel, from start: Int, count: Int) throws {
    for index in start..<(start + count) {
        model.ensureCards(currentIndex: index)
        let carte = try #require(model.card(at: index)?.presented)
        _ = model.answer(carte.question.correctID, at: index)
    }
}

@MainActor
@Test func moinsDeSaveEveryRéponsesNÉcritRien() throws {
    let store = CountingProgressStore()
    let model = try modèle(store: store)
    model.start()

    try répondreÀDesCartesDistinctes(model, from: 0, count: FeedViewModel.saveEvery - 1)

    #expect(store.saveCount == 0)
}

@MainActor
@Test func laRéponseNuméroSaveEveryDéclencheUneÉcriture() throws {
    let store = CountingProgressStore()
    let model = try modèle(store: store)
    model.start()

    try répondreÀDesCartesDistinctes(model, from: 0, count: FeedViewModel.saveEvery)

    #expect(store.saveCount == 1)
}

@MainActor
@Test func répondreJusteFaitProgresserLaNotion() throws {
    let annotées = (1...4).map { i in
        Question(
            id: "f\(i)", subject: .code, topic: "Panneaux & marquage", difficulty: .facile,
            prompt: "Énoncé \(i)",
            options: [Option(id: "A", text: "a"), Option(id: "B", text: "b"),
                      Option(id: "C", text: "c"), Option(id: "D", text: "d")],
            correctID: "B", explanation: "Explication",
            notion: "panneaux/formes", role: .fondation
        )
    }
    let model = FeedViewModel(
        bank: try QuestionBank(questions: annotées),
        store: InMemoryProgressStore()
    )
    model.start()
    #expect(model.notionsAcquises == 0)

    var index = 0
    while model.notionsAcquises == 0 && index < 40 {
        model.ensureCards(currentIndex: index)
        _ = model.answer("B", at: index)
        index += 1
    }

    #expect(model.notionsAcquises == 1)
}

@MainActor
@Test func flushÉcritLeResteEtRéinitialiseLeCompteur() throws {
    let store = CountingProgressStore()
    let model = try modèle(store: store)
    model.start()

    let reste = FeedViewModel.saveEvery - 2
    try répondreÀDesCartesDistinctes(model, from: 0, count: reste)
    model.flush()
    #expect(store.saveCount == 1)

    // Le compteur doit être reparti de zéro après le flush explicite : encore
    // `saveEvery - 1` réponses ne doivent déclencher aucune nouvelle écriture.
    try répondreÀDesCartesDistinctes(model, from: reste, count: FeedViewModel.saveEvery - 1)
    #expect(store.saveCount == 1)

    // La réponse suivante complète le lot de `saveEvery` et déclenche la deuxième écriture.
    try répondreÀDesCartesDistinctes(model, from: reste + FeedViewModel.saveEvery - 1, count: 1)
    #expect(store.saveCount == 2)
}
