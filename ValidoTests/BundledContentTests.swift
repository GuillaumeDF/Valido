import Foundation
import Testing
@testable import Valido

/// Seuils volontairement sous le volume livré : quelques rejets à l'import sont
/// acceptables, un effondrement du volume ne l'est pas.
@Test func leContenuLivréEstValide() throws {
    let bank = try QuestionBank.bundled()
    #expect(bank.count >= 295)
}

@Test func lesDeuxMatièresSontPrésentes() throws {
    let bank = try QuestionBank.bundled()
    let code = bank.questions.filter { $0.subject == .code }
    let swift = bank.questions.filter { $0.subject == .swift }
    #expect(code.count >= 125)
    #expect(swift.count >= 170)
}

@Test func aucuneExplicationNeCommenceParUneLettreDeRéponse() throws {
    let bank = try QuestionBank.bundled()
    let motif = try Regex("^[A-D]\\s*[—–\\-.)]")
    let fautives = bank.questions.filter {
        $0.explanation.firstMatch(of: motif) != nil
    }
    #expect(fautives.map(\.id) == [])
}

@Test func chaqueQuestionAAuMoinsDeuxOptionsEtUneBonneRéponse() throws {
    let bank = try QuestionBank.bundled()
    for question in bank.questions {
        #expect(question.options.count >= 2)
        #expect(question.options.contains { $0.id == question.correctID })
    }
}

/// L'option la plus longue étant la bonne est l'indice le plus fiable de tout QCM.
/// Les options sont mélangées à l'affichage : ce déséquilibre est donc lisible
/// par n'importe qui, sans rien connaître au sujet.
@Test func laBonneRéponseNeDépassePasLaDeuxièmePlusLongueDeDixCaractères() throws {
    let bank = try QuestionBank.bundled()
    var fautives: [String] = []
    for question in bank.questions {
        guard let bonne = question.options.first(where: { $0.id == question.correctID })
        else { continue }
        let autres = question.options
            .filter { $0.id != question.correctID }
            .map(\.text.count)
            .sorted(by: >)
        guard let plusLongue = autres.first else { continue }
        if bonne.text.count - plusLongue > 10 { fautives.append(question.id) }
    }
    #expect(fautives == [])
}

/// Aucune option ne doit s'ouvrir par une lettre de réponse : elle désignerait
/// une position qui n'existe plus une fois les options mélangées.
@Test func aucuneOptionNeCommenceParUneLettreDeRéponse() throws {
    let bank = try QuestionBank.bundled()
    let motif = try Regex("^\\s*[A-D]\\s*[—–\\-.)]")
    let fautives = bank.questions.filter { question in
        question.options.contains { $0.text.firstMatch(of: motif) != nil }
    }
    #expect(fautives.map(\.id) == [])
}
