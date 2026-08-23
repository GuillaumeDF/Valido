import Testing
@testable import Valido

@Test func étatInitial() {
    let combo = ComboEngine()
    #expect(combo.multiplier == 0)
    #expect(combo.isHot == false)
}

@Test func bonneRéponseIncrémente() {
    var combo = ComboEngine()
    combo.answer(correct: true)
    combo.answer(correct: true)
    #expect(combo.multiplier == 2)
}

@Test func mauvaiseRéponseRemetÀZéro() {
    var combo = ComboEngine()
    combo.answer(correct: true)
    combo.answer(correct: true)
    combo.answer(correct: false)
    #expect(combo.multiplier == 0)
}

@Test func leComboDevientChaudÀCinq() {
    var combo = ComboEngine()
    for _ in 0..<4 { combo.answer(correct: true) }
    #expect(combo.isHot == false)
    combo.answer(correct: true)
    #expect(combo.multiplier == 5)
    #expect(combo.isHot == true)
}

@Test func uneBonneRéponseAprèsUneFauteRepartDeUn() {
    var combo = ComboEngine()
    // La série doit exister AVANT la faute, sinon le test ne distingue pas
    // « remise à zéro puis incrément » de « compte repris depuis 0 » : sans
    // ces trois bonnes réponses, supprimer la remise à zéro ne le ferait pas échouer.
    combo.answer(correct: true)
    combo.answer(correct: true)
    combo.answer(correct: true)
    combo.answer(correct: false)
    combo.answer(correct: true)
    #expect(combo.multiplier == 1)
}

// Retirés avec leur sujet : `leSwipeDébloque` et `uneBonneRéponseDébloqueSansBalayage`
// épinglaient le déblocage après une faute. Le verdict symétrique supprime la notion de
// blocage — plus rien n'empêche l'avance, c'est le balayage qui la provoque.
