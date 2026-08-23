import Foundation
import Testing
@testable import Valido

@Test func toutEstCochéParDéfaut() {
    let s = SourceSelection()
    #expect(s.subjects == Set(Subject.allCases))
    for subject in Subject.allCases { #expect(s.includes(subject)) }
}

@Test func décocherRetireLaSource() {
    var s = SourceSelection()
    s.toggle(.swift)
    #expect(s.includes(.swift) == false)
    #expect(s.includes(.code) == true)
}

@Test func recocherRemetLaSource() {
    var s = SourceSelection()
    s.toggle(.swift)
    s.toggle(.swift)
    #expect(s.subjects == Set(Subject.allCases))
}

@Test func décocherLaDernièreSourceEstRefusé() {
    // L'invariant vit dans le type : un vivier vide ne laisserait rien à tirer au
    // scheduler. L'interface n'a donc pas à s'en préoccuper.
    var s = SourceSelection()
    s.toggle(.swift)
    s.toggle(.code)
    #expect(s.includes(.code) == true)
    #expect(s.subjects.count == 1)
}

@Test func allerRetourEnMémoire() throws {
    let store = InMemorySourceSelectionStore()
    var s = SourceSelection()
    s.toggle(.code)
    try store.save(s)
    #expect(store.load() == s)
}

@Test func rienDEnregistréDonneToutCoché() {
    #expect(InMemorySourceSelectionStore().load() == SourceSelection())
}

@Test func allerRetourDansUserDefaults() throws {
    let suite = "valido.test.\(UUID().uuidString)"
    let defaults = UserDefaults(suiteName: suite)!
    defer { defaults.removePersistentDomain(forName: suite) }

    #expect(DefaultsSourceSelectionStore(defaults: defaults).load() == SourceSelection())
    var s = SourceSelection()
    s.toggle(.swift)
    try DefaultsSourceSelectionStore(defaults: defaults).save(s)
    #expect(DefaultsSourceSelectionStore(defaults: defaults).load() == s)
}

@Test func uneValeurCorrompueRetombeSurToutCoché() {
    // Même principe que `FileProgressStore.load()` : perdre une préférence se reclique,
    // bloquer l'app sur une valeur illisible ne se pardonne pas.
    let suite = "valido.test.\(UUID().uuidString)"
    let defaults = UserDefaults(suiteName: suite)!
    defer { defaults.removePersistentDomain(forName: suite) }
    defaults.set("ceci n'est pas du json", forKey: DefaultsSourceSelectionStore.key)
    #expect(DefaultsSourceSelectionStore(defaults: defaults).load() == SourceSelection())
}

@Test func leSchedulerNeTireJamaisHorsDeLaSélection() throws {
    let bank = try Fixtures.mixedBank(code: 60, swift: 60)
    var sel = SourceSelection()
    sel.toggle(.swift)
    let scheduler = CardScheduler()
    var rng = SeededRNG(seed: 5)

    for _ in 0..<500 {
        let c = scheduler.next(bank: bank, progress: ProgressSnapshot(),
                               recent: [], selection: sel, rng: &rng)
        #expect(c.card.presented?.question.subject == .code)
    }
}

@MainActor
@Test func changerLaSélectionJetteLesCartesNonRépondues() throws {
    let model = FeedViewModel(
        bank: try Fixtures.mixedBank(code: 60, swift: 60),
        store: InMemoryProgressStore(),
        selectionStore: InMemorySourceSelectionStore(),
        scheduler: CardScheduler(),
        rng: SeededRNG(seed: 3)
    )
    model.start()
    for i in 0..<4 { model.ensureCards(currentIndex: i) }

    var sel = SourceSelection()
    sel.toggle(.swift)
    model.apply(sel, currentIndex: 2)

    // Tout ce qui vient APRÈS la carte courante respecte le filtre immédiatement,
    // sans attendre que les 3 cartes de lookahead déjà préparées défilent.
    for i in 3..<12 {
        model.ensureCards(currentIndex: i)
        #expect(model.card(at: i)?.presented?.question.subject == .code,
                "carte hors sélection à l'index \(i)")
    }
}

@MainActor
@Test func laSélectionEstPersistéeEtRelue() throws {
    let selectionStore = InMemorySourceSelectionStore()
    var sel = SourceSelection()
    sel.toggle(.code)
    try selectionStore.save(sel)

    let model = FeedViewModel(
        bank: try Fixtures.mixedBank(code: 60, swift: 60),
        store: InMemoryProgressStore(),
        selectionStore: selectionStore,
        scheduler: CardScheduler(),
        rng: SeededRNG(seed: 9)
    )
    model.start()
    #expect(model.selection == sel)
    #expect(model.card(at: 0)?.presented?.question.subject == .swift)
}
