import Foundation
import Testing
import UIKit
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

/// Une `illustration` qui ne se résout pas rend la question injouable : l'énoncé
/// est dans l'image. Le nom d'asset est une chaîne dans le JSON, donc rien
/// n'empêche une faute de frappe — sauf ce test.
@Test func chaqueIllustrationRéférencéeExisteDansLeBundle() throws {
    let bank = try QuestionBank.bundled()
    let manquantes = bank.questions.compactMap { question -> String? in
        guard let asset = question.illustration?.asset else { return nil }
        return UIImage(named: asset) == nil ? "\(question.id) → \(asset)" : nil
    }
    #expect(manquantes == [])
}

/// Même exigence que sur `explanation` : un `alt` de trois mots ne remplace pas
/// une scène. Seuil aligné sur celui de l'explication.
@Test func chaqueAltDécritVraimentLaScène() throws {
    let bank = try QuestionBank.bundled()
    let tropCourts = bank.questions.compactMap { question -> String? in
        guard let alt = question.illustration?.alt else { return nil }
        return alt.count < 40 ? question.id : nil
    }
    #expect(tropCourts == [])
}

/// Le bandeau de `QuestionCardView` réclame jusqu'à 38 % de la carte avant réponse et
/// 18 % après, et il **cède** quand le texte n'a plus la place — aucun texte de la carte
/// n'est compressible, donc l'image est le seul élément qui puisse reculer. Mesuré sur
/// les huit premières illustrées : à 220 caractères d'explication et un énoncé de trois
/// lignes, le bandeau descend à 8 % et il ne reste qu'une bande de la scène.
///
/// Les chiffres viennent du §7 de `Tools/questions.md`, où ils n'étaient que de la prose.
/// À quarante questions illustrées, la prose ne tient plus.
@Test func leBudgetDeHauteurDesQuestionsIllustréesEstTenu() throws {
    let bank = try QuestionBank.bundled()
    var fautives: [String] = []
    for question in bank.questions where question.illustration != nil {
        if question.prompt.count > 70 {
            fautives.append("\(question.id) énoncé \(question.prompt.count)")
        }
        for option in question.options where option.text.count > 50 {
            fautives.append("\(question.id) option \(option.text.count)")
        }
        if question.explanation.count > 220 {
            fautives.append("\(question.id) explication \(question.explanation.count)")
        }
    }
    #expect(fautives == [])
}
