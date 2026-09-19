import Foundation
import Testing
@testable import Valido

@Test func répartition70_30() throws {
    let bank = try Fixtures.bank(count: 100)
    let scheduler = CardScheduler()
    var rng = SeededRNG(seed: 42)
    var pondérés = 0

    for _ in 0..<1000 {
        if scheduler.next(bank: bank, progress: ProgressSnapshot(), recent: [], rng: &rng).draw == .weighted {
            pondérés += 1
        }
    }

    #expect(pondérés > 650 && pondérés < 750)
}

@Test func laFenêtreAntiRépétitionEstRespectée() throws {
    let bank = try Fixtures.bank(count: 100)
    let scheduler = CardScheduler()
    var rng = SeededRNG(seed: 7)
    let recent = (1...25).map { "q\($0)" }

    for _ in 0..<200 {
        let carte = scheduler.next(bank: bank, progress: ProgressSnapshot(), recent: recent, rng: &rng)
        #expect(!recent.contains(carte.card.id))
    }
}

@Test func seulesLes25DernièresSontExclues() throws {
    let bank = try Fixtures.bank(count: 30)
    let scheduler = CardScheduler()
    var rng = SeededRNG(seed: 11)
    // 30 identifiants d'historique : les 5 plus anciens redeviennent tirables.
    let recent = (1...30).map { "q\($0)" }

    var vues = Set<String>()
    for _ in 0..<200 {
        vues.insert(scheduler.next(bank: bank, progress: ProgressSnapshot(), recent: recent, rng: &rng).card.id)
    }

    #expect(vues == Set(["q1", "q2", "q3", "q4", "q5"]))
}

@Test func uneQuestionJamaisVuePèsePlusQuUneQuestionMaîtrisée() throws {
    var progress = ProgressSnapshot()
    progress.serveIndex = 100
    progress.stats["maîtrisée"] = QuestionStats(attempts: 10, failures: 0, lastServeIndex: 99)

    let scheduler = CardScheduler()
    let poidsJamaisVue = scheduler.weight(for: "jamais-vue", progress: progress)
    let poidsMaîtrisée = scheduler.weight(for: "maîtrisée", progress: progress)

    #expect(poidsJamaisVue == 3.0)
    #expect(poidsMaîtrisée < poidsJamaisVue)
}

@Test func uneQuestionMaîtriséeResteTirable() throws {
    var progress = ProgressSnapshot()
    progress.serveIndex = 1000
    progress.stats["m"] = QuestionStats(attempts: 50, failures: 0, lastServeIndex: 1000)

    let scheduler = CardScheduler()
    // Plancher d'ancienneté 0.05, poids d'échec de base 0.3 → jamais zéro.
    #expect(scheduler.weight(for: "m", progress: progress) > 0)
}

@Test func uneQuestionRatéePèsePlusQuUneQuestionRéussie() throws {
    var progress = ProgressSnapshot()
    progress.serveIndex = 100
    progress.stats["ratée"] = QuestionStats(attempts: 4, failures: 4, lastServeIndex: 40)
    progress.stats["réussie"] = QuestionStats(attempts: 4, failures: 0, lastServeIndex: 40)

    let scheduler = CardScheduler()
    #expect(scheduler.weight(for: "ratée", progress: progress)
            > scheduler.weight(for: "réussie", progress: progress))
}

@Test func banquePlusPetiteQueLaFenêtre() throws {
    let bank = try Fixtures.bank(count: 3)
    let scheduler = CardScheduler()
    var rng = SeededRNG(seed: 3)
    let recent = ["q1", "q2", "q3", "q1", "q2"]

    // Ne doit ni boucler à l'infini ni planter : la fenêtre est tronquée jusqu'à
    // ce qu'un tirage soit possible.
    let carte = scheduler.next(bank: bank, progress: ProgressSnapshot(), recent: recent, rng: &rng)
    #expect(["q1", "q2", "q3"].contains(carte.card.id))
}

@Test func lesOptionsSontMélangéesAuTirage() throws {
    let bank = try Fixtures.bank(count: 1)
    let scheduler = CardScheduler()
    var rng = SeededRNG(seed: 99)

    var ordres = Set<[String]>()
    for _ in 0..<50 {
        let carte = scheduler.next(bank: bank, progress: ProgressSnapshot(), recent: [], rng: &rng)
        ordres.insert(carte.card.presented!.displayOptions.map(\.id))
    }

    // 4 options → 24 ordres possibles ; en 50 tirages on doit en voir plusieurs.
    #expect(ordres.count > 1)
}

/// Test de bout en bout de la promesse centrale de l'app ("le feed révise ce qu'on rate") :
/// tous les autres tests de `CardScheduler.next` passent `progress: ProgressSnapshot()`, où
/// chaque poids vaut 3.0 — `weightedPick` n'y fait donc rien d'observable, et remplacer son
/// corps par un tirage uniforme laisserait ces tests verts. Celui-ci construit une vraie
/// disparité de poids et vérifie qu'elle se voit sur `next`, pas seulement sur `weight(for:)`.
@Test func laQuestionFaibleEstTiréeBienPlusSouventQueLaMoyenne() throws {
    let bank = try Fixtures.bank(count: 10)
    var progress = ProgressSnapshot()
    progress.serveIndex = 1000
    // Question faible : ratée à chaque tentative → poidsÉchec = 0.3 + 2.7×(5/5) = 3.0 ;
    // servie il y a longtemps (écart 900 ≥ l'horizon de 60) → poidsAncienneté plafonne à 1.0.
    // poids("q1") = 3.0 × 1.0 = 3.0.
    progress.stats["q1"] = QuestionStats(attempts: 5, failures: 5, lastServeIndex: 100)
    // Les neuf autres : maîtrisées (aucune faute) et servies l'instant d'avant.
    // poidsÉchec = 0.3 + 2.7×0 = 0.3 ; poidsAncienneté = max(0.05, min(1, 1/60)) ≈ 0.0167.
    // poids ≈ 0.3 × 0.0167 ≈ 0.005 chacune.
    for i in 2...10 {
        progress.stats["q\(i)"] = QuestionStats(attempts: 20, failures: 0, lastServeIndex: 999)
    }

    let scheduler = CardScheduler()
    var rng = SeededRNG(seed: 123)
    var tiragesFaible = 0
    for _ in 0..<500 {
        let carte = scheduler.next(bank: bank, progress: progress, recent: [], rng: &rng)
        if carte.card.id == "q1" { tiragesFaible += 1 }
    }

    // Probabilité attendue, calculée depuis la même formule que `weight(for:)`, pas devinée :
    // P(faible | tirage pondéré, 70 % des tours) = 3.0 / (3.0 + 9×0.005) ≈ 0.985
    // P(faible | tirage uniforme, 30 % des tours) = 1/10 = 0.1
    // P(faible) ≈ 0.7×0.985 + 0.3×0.1 ≈ 0.72 → ≈360 tirages attendus sur 500, très loin des
    // ~50 qu'un tirage purement uniforme sur 10 questions donnerait. La borne ci-dessous (200)
    // laisse une marge large pour la variance du RNG tout en restant hors de portée d'un
    // `weightedPick` cassé (qui retomberait sur ~50, la moyenne du tirage uniforme seul).
    #expect(tiragesFaible > 200)
}

@Test func uneFondationNonAcquiseSortPlusSouventQueSesApplications() throws {
    var questions = [Fixtures.question(id: "f1", topic: "Panneaux & marquage")]
    questions += (1...9).map { Fixtures.question(id: "a\($0)", topic: "Panneaux & marquage") }
    let annotées = questions.enumerated().map { i, q in
        Question(
            id: q.id, subject: q.subject, topic: q.topic, difficulty: q.difficulty,
            prompt: q.prompt, options: q.options, correctID: q.correctID,
            explanation: q.explanation,
            notion: "panneaux/formes", role: i == 0 ? .fondation : .application
        )
    }
    let bank = try QuestionBank(questions: annotées)
    let scheduler = CardScheduler()
    var rng = SeededRNG(seed: 3)
    var fondations = 0

    for _ in 0..<1000 {
        let tiré = scheduler.next(bank: bank, progress: ProgressSnapshot(), recent: [], rng: &rng)
        if tiré.draw == .weighted && tiré.card.id == "f1" { fondations += 1 }
    }

    // Une carte sur dix, mais boostée : nettement au-dessus du dixième des ~700 pondérés.
    #expect(fondations > 150)
}

@Test func uneNotionAcquiseNeSortPasDuVivier() throws {
    let fondation = Question(
        id: "f1", subject: .code, topic: "Panneaux & marquage", difficulty: .facile,
        prompt: "Énoncé", options: [Option(id: "A", text: "a"), Option(id: "B", text: "b"),
                                    Option(id: "C", text: "c"), Option(id: "D", text: "d")],
        correctID: "B", explanation: "Explication",
        notion: "panneaux/formes", role: .fondation
    )
    let bank = try QuestionBank(questions: [fondation])
    var progress = ProgressSnapshot()
    progress.notions["panneaux/formes"] = NotionProgress(cartesDeLaSérie: ["f1"], acquise: true)

    let scheduler = CardScheduler()
    #expect(scheduler.boost(for: fondation, progress: progress) == 1.0)

    var rng = SeededRNG(seed: 5)
    let tiré = scheduler.next(bank: bank, progress: progress, recent: [], rng: &rng)
    #expect(tiré.card.id == "f1")
}

@Test func uneCarteSansNotionNEstJamaisBoostée() throws {
    let scheduler = CardScheduler()
    let nue = Fixtures.question(id: "q1")
    #expect(scheduler.boost(for: nue, progress: ProgressSnapshot()) == 1.0)
}

@Test func leMélangePréserveLesOptions() throws {
    let bank = try Fixtures.bank(count: 1)
    let scheduler = CardScheduler()
    var rng = SeededRNG(seed: 5)

    let carte = scheduler.next(bank: bank, progress: ProgressSnapshot(), recent: [], rng: &rng)
    let présentée = carte.card.presented!
    #expect(Set(présentée.displayOptions) == Set(présentée.question.options))
    #expect(présentée.displayOptions.contains { $0.id == présentée.question.correctID })
}
