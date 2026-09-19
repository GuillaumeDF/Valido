import Foundation
import Testing
@testable import Valido

@Test func instantanéVideRendDesStatsNeutres() {
    let snapshot = ProgressSnapshot()
    let stats = snapshot.stats(for: "inconnue")
    #expect(stats.attempts == 0)
    #expect(stats.failures == 0)
    #expect(stats.lastServeIndex == nil)
    #expect(stats.failureRate == 0)
}

@Test func servirIncrémenteLeCompteurEtHorodateLaQuestion() {
    var snapshot = ProgressSnapshot()
    snapshot.recordServe("q1")
    snapshot.recordServe("q2")
    #expect(snapshot.serveIndex == 2)
    #expect(snapshot.stats(for: "q1").lastServeIndex == 1)
    #expect(snapshot.stats(for: "q2").lastServeIndex == 2)
}

@Test func répondreAgrègeLesTentatives() {
    var snapshot = ProgressSnapshot()
    snapshot.recordAnswer("q1", correct: false)
    snapshot.recordAnswer("q1", correct: true)
    snapshot.recordAnswer("q1", correct: true)
    let stats = snapshot.stats(for: "q1")
    #expect(stats.attempts == 3)
    #expect(stats.failures == 1)
    #expect(abs(stats.failureRate - 1.0 / 3.0) < 0.0001)
}

@Test func répondreNeTouchePasAuCompteurDeService() {
    var snapshot = ProgressSnapshot()
    snapshot.recordAnswer("q1", correct: true)
    #expect(snapshot.serveIndex == 0)
}

@Test func allerRetourSurFichier() throws {
    let url = FileManager.default.temporaryDirectory
        .appending(path: "valido-test-\(UUID().uuidString).json")
    defer { try? FileManager.default.removeItem(at: url) }

    let store = FileProgressStore(url: url)
    var snapshot = ProgressSnapshot()
    snapshot.recordServe("q1")
    snapshot.recordAnswer("q1", correct: false)
    try store.save(snapshot)

    let rechargé = FileProgressStore(url: url).load()
    #expect(rechargé == snapshot)
}

@Test func fichierCorrompuRepartDeZéro() throws {
    let url = FileManager.default.temporaryDirectory
        .appending(path: "valido-test-\(UUID().uuidString).json")
    defer { try? FileManager.default.removeItem(at: url) }
    try Data("ceci n'est pas du json".utf8).write(to: url)

    let snapshot = FileProgressStore(url: url).load()
    #expect(snapshot == ProgressSnapshot())
}

@Test func fichierAbsentRepartDeZéro() {
    let url = FileManager.default.temporaryDirectory
        .appending(path: "valido-absent-\(UUID().uuidString).json")
    #expect(FileProgressStore(url: url).load() == ProgressSnapshot())
}

@Test func magasinEnMémoire() throws {
    let store = InMemoryProgressStore()
    var snapshot = ProgressSnapshot()
    snapshot.recordServe("q1")
    try store.save(snapshot)
    #expect(store.load() == snapshot)
}

@Test func laSérieNeCompteQueDesCartesDistinctes() {
    var progress = ProgressSnapshot()
    for _ in 0..<4 {
        progress.recordAnswer("q1", correct: true, notion: "panneaux/formes", masteryStreak: 4)
    }
    #expect(progress.estAcquise("panneaux/formes") == false)
}

@Test func quatreCartesDistinctesAcquièrentLaNotion() {
    var progress = ProgressSnapshot()
    for i in 1...4 {
        progress.recordAnswer("q\(i)", correct: true, notion: "panneaux/formes", masteryStreak: 4)
    }
    #expect(progress.estAcquise("panneaux/formes"))
}

@Test func uneFauteRemetLaSérieÀZéro() {
    var progress = ProgressSnapshot()
    for i in 1...3 {
        progress.recordAnswer("q\(i)", correct: true, notion: "marquage/lignes", masteryStreak: 4)
    }
    progress.recordAnswer("q4", correct: false, notion: "marquage/lignes", masteryStreak: 4)
    progress.recordAnswer("q5", correct: true, notion: "marquage/lignes", masteryStreak: 4)
    #expect(progress.estAcquise("marquage/lignes") == false)
}

@Test func uneFauteNeRetirePasUneNotionAcquise() {
    var progress = ProgressSnapshot()
    for i in 1...4 {
        progress.recordAnswer("q\(i)", correct: true, notion: "marquage/lignes", masteryStreak: 4)
    }
    progress.recordAnswer("q5", correct: false, notion: "marquage/lignes", masteryStreak: 4)
    #expect(progress.estAcquise("marquage/lignes"))
}

@Test func uneNotionNulleEstTraitéeCommeAcquise() {
    let progress = ProgressSnapshot()
    #expect(progress.estAcquise(nil))
}

@Test func uneProgressionÉcriteAvantLesNotionsSeDécodeEncore() throws {
    let ancien = """
    {"serveIndex":42,"stats":{"q1":{"attempts":3,"failures":1,"lastServeIndex":40}}}
    """.data(using: .utf8)!

    let progress = try JSONDecoder().decode(ProgressSnapshot.self, from: ancien)
    #expect(progress.serveIndex == 42)
    #expect(progress.stats(for: "q1").attempts == 3)
    #expect(progress.notions.isEmpty)
}
