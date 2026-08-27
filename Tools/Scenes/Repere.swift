import CoreGraphics

// Schémas de situation pour les questions illustrées — mêmes principes que
// `design/logo/render-icon.swift` : CoreGraphics, un repère logique fixe, et des PNG
// posés directement dans le catalogue d'assets.
//
// Repère logique : 400 × 300 (4:3), y vers le bas. Ce ratio n'est pas décoratif — le
// bandeau de `QuestionCardView` passe de 38 % à 18 % de la hauteur de carte au verdict,
// et recadre en `.fill`. La géométrie décisive (le carrefour) est donc au centre
// vertical, dans la bande qui survit au recadrage.
//
// Usage : ./Tools/render-scenes.sh

// MARK: - Repère

let W = 400.0, H = 300.0
/// Demi-largeur de chaussée : une voie de 42 par sens. Chaussée plus étroite que le
/// premier jet, pour une raison de cadrage : les véhicules doivent tenir au seuil du
/// carrefour *et* dans la bande centrale qui survit au recadrage à 18 %.
let voie = 42.0
let cx = W / 2, cy = H / 2

struct Palette {
    let sol, chaussee, marquage, vous, autre, tiers, ilot, panneauRouge, panneauJaune,
        panneauFond, feuVert, bordure: CGColor
}

// `feuVert` est arrivé avec les scènes de feux (2026-08-24) : `boitierDeFeu` réclamait un
// vert depuis la tâche 6 pour qu'une lentille allumée puisse recevoir sa teinte par sa
// **position** dans le caisson — haut rouge, milieu jaune, bas vert (arrêté du 24 novembre
// 1967, art. 7). Aucune scène n'allume encore la lentille du bas, mais `feuTricolore` la
// gère : la teinte vit ici, avec les autres, plutôt qu'en dur dans une primitive.
//
// La valeur claire a été éclaircie le même jour (constat de la tâche 10, §13 de
// `methode.md`) : rgb(24, 154, 82) mesurait une luminance de 121, à un cheveu des 119
// d'une lentille éteinte — un vert allumé aurait été indiscernable en niveaux de gris.
// `rgb(52, 199, 89)` est le systemGreen clair d'Apple ; la valeur sombre, déjà
// rgb(48, 209, 88) — son systemGreen sombre —, n'avait pas ce défaut et n'a pas bougé.
//
// `bordure` est arrivée avec les scènes de stationnement (2026-08-25) : la 7e partie de
// l'IISR (art. 118-2, B) place le marquage jaune d'interdiction « sur la face supérieure de
// la bordure du trottoir ou en rive de chaussée ». Dessiner ce trait **sur la bordure** est
// ce qui le rend reconnaissable sans distinguer une seule couleur — aucun marquage blanc
// n'est jamais peint sur une bordure —, mais il fallait pour cela que la bordure existe
// comme surface. `ilot` ne pouvait pas servir : en mode sombre elle mesure 54 en niveaux de
// gris contre 58 pour la chaussée, donc un ressaut invisible. Les deux valeurs retenues
// sont mesurées à 120 (clair) et 96 (sombre), à plus de 40 points de la chaussée comme du
// sol, et à plus de 70 points du jaune du marquage.

func rgb(_ r: Double, _ g: Double, _ b: Double, _ a: Double = 1) -> CGColor {
    CGColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
}

let clair = Palette(
    sol: rgb(232, 230, 225), chaussee: rgb(74, 74, 79), marquage: rgb(255, 255, 255),
    vous: rgb(10, 132, 255), autre: rgb(240, 160, 32), tiers: rgb(224, 65, 62),
    ilot: rgb(201, 216, 192), panneauRouge: rgb(200, 30, 40), panneauJaune: rgb(250, 190, 20),
    panneauFond: rgb(255, 255, 255), feuVert: rgb(52, 199, 89), bordure: rgb(122, 120, 116))

let sombre = Palette(
    sol: rgb(28, 28, 30), chaussee: rgb(58, 58, 60), marquage: rgb(229, 229, 234),
    vous: rgb(10, 132, 255), autre: rgb(255, 179, 64), tiers: rgb(255, 105, 97),
    ilot: rgb(44, 58, 44), panneauRouge: rgb(220, 60, 70), panneauJaune: rgb(255, 204, 40),
    panneauFond: rgb(242, 242, 247), feuVert: rgb(48, 209, 88), bordure: rgb(96, 96, 100))
