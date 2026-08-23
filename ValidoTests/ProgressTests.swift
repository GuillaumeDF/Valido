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
