import CoreGraphics

/// Les formes réglementaires. La géométrie d'un panneau est une norme publique
/// (Instruction interministérielle sur la signalisation routière) : elle se redessine,
/// elle ne se recopie pas chez un éditeur d'ETG.
enum Forme {
    case disque
    case triangle          // danger : pointe en haut
    case triangleInverse   // cédez le passage
    case octogone          // STOP, et lui seul
    case carre
    case losange           // carré posé sur la pointe : AB6, fin de priorité
}

/// Un panneau se dessine en deux temps — le fond, puis un bord d'épaisseur donnée —
/// parce que c'est le bord qui distingue une interdiction (liseré rouge épais) d'une
/// indication (fond plein). Le pictogramme est dessiné par l'appelant, par-dessus.
///
/// `rayon` est le rayon du cercle circonscrit : à 15-17, un panneau reste lisible dans
/// la bande centrale qui survit au rétrécissement du bandeau à 18 %.
func panneau(_ ctx: CGContext, forme: Forme, at pt: CGPoint, rayon: Double,
             fond: CGColor, bord: CGColor? = nil, epaisseurBord: Double = 0) {
    func chemin(_ r: Double) -> CGPath {
        let path = CGMutablePath()
        switch forme {
        case .disque:
            path.addEllipse(in: CGRect(x: pt.x - r, y: pt.y - r, width: r * 2, height: r * 2))
        case .triangle:
            path.move(to: CGPoint(x: pt.x, y: pt.y - r * 0.95))
            path.addLine(to: CGPoint(x: pt.x + r, y: pt.y + r * 0.72))
            path.addLine(to: CGPoint(x: pt.x - r, y: pt.y + r * 0.72))
        case .triangleInverse:
            path.move(to: CGPoint(x: pt.x - r, y: pt.y - r * 0.72))
            path.addLine(to: CGPoint(x: pt.x + r, y: pt.y - r * 0.72))
            path.addLine(to: CGPoint(x: pt.x, y: pt.y + r * 0.95))
        case .octogone:
            for i in 0..<8 {
                let a = Double(i) * .pi / 4 + .pi / 8
                let q = CGPoint(x: pt.x + cos(a) * r, y: pt.y + sin(a) * r)
                i == 0 ? path.move(to: q) : path.addLine(to: q)
            }
        case .carre:
            let c = r * 0.78
            path.addRect(CGRect(x: pt.x - c, y: pt.y - c, width: c * 2, height: c * 2))
        case .losange:
            path.move(to: CGPoint(x: pt.x, y: pt.y - r))
            path.addLine(to: CGPoint(x: pt.x + r, y: pt.y))
            path.addLine(to: CGPoint(x: pt.x, y: pt.y + r))
            path.addLine(to: CGPoint(x: pt.x - r, y: pt.y))
        }
        path.closeSubpath()
        return path
    }
    if let bord, epaisseurBord > 0 {
        ctx.setFillColor(bord)
        ctx.addPath(chemin(rayon))
        ctx.fillPath()
        ctx.setFillColor(fond)
        ctx.addPath(chemin(rayon - epaisseurBord))
        ctx.fillPath()
    } else {
        ctx.setFillColor(fond)
        ctx.addPath(chemin(rayon))
        ctx.fillPath()
    }
}

func panneauStop(_ ctx: CGContext, at pt: CGPoint, _ p: Palette) {
    panneau(ctx, forme: .octogone, at: pt, rayon: 15, fond: p.panneauRouge)
    texte(ctx, "STOP", centre: pt, taille: 8, couleur: p.panneauFond)
}

func panneauCedez(_ ctx: CGContext, at pt: CGPoint, _ p: Palette) {
    panneau(ctx, forme: .triangleInverse, at: pt, rayon: 17,
            fond: p.panneauFond, bord: p.panneauRouge, epaisseurBord: 17 * 0.38)
}

/// AB6, caractère prioritaire d'une route : un carré posé sur la pointe, fond blanc,
/// losange jaune au centre. C'est le pendant exact de la priorité à droite — même
/// carrefour, réponse inverse.
func panneauRoutePrioritaire(_ ctx: CGContext, at pt: CGPoint, _ p: Palette) {
    panneau(ctx, forme: .losange, at: pt, rayon: 17, fond: p.panneauFond)
    panneau(ctx, forme: .losange, at: pt, rayon: 10, fond: p.panneauJaune)
}

// MARK: - Panneaux de vitesse

/// L'encre d'un panneau : le gris le plus sombre de la palette, celui de la chaussée.
/// Pas de noir pur, qui vibre sur le fond quasi blanc du panneau en mode sombre — et pas
/// de champ supplémentaire dans `Palette`, qui n'a pas besoin d'une deuxième nuance foncée.
private func encre(_ p: Palette) -> CGColor { p.chaussee }

/// Un nombre posé sur un panneau, avec ou sans halo de la couleur du panneau. Le halo
/// n'est pas décoratif et ne sert qu'au B33 : l'oblique y passe **sous** les chiffres, et
/// sans ce blanc de séparation le nombre et la barre fusionnent en une tache illisible.
private func chiffres(_ ctx: CGContext, _ n: String, at pt: CGPoint, taille: Double,
                      halo: Bool, _ p: Palette) {
    if halo {
        let d = max(taille * 0.07, 2.0)
        for dx in [-d, 0, d] {
            for dy in [-d, 0, d] where !(dx == 0 && dy == 0) {
                texte(ctx, n, centre: CGPoint(x: pt.x + dx, y: pt.y + dy), taille: taille,
                      couleur: p.panneauFond)
            }
        }
    }
    texte(ctx, n, centre: pt, taille: taille, couleur: encre(p))
}

/// B14, limitation de vitesse : disque à fond blanc, **large** liseré rouge, nombre au
/// centre. L'épaisseur du liseré (0,29 rayon) est ce qui distingue à l'œil une
/// interdiction d'un « fin de » — c'est la forme qui porte le sens, pas la couleur seule.
/// Les chiffres tiennent à 1,0 rayon et non 0,84 comme sur le vrai panneau : Helvetica-Bold
/// est bien plus large que la fonte réglementaire, et « 70 » y débordait sur le liseré.
func panneauLimitation(_ ctx: CGContext, _ valeur: Int, at pt: CGPoint, rayon: Double,
                       _ p: Palette) {
    panneau(ctx, forme: .disque, at: pt, rayon: rayon, fond: p.panneauFond,
            bord: p.panneauRouge, epaisseurBord: rayon * 0.29)
    chiffres(ctx, "\(valeur)", at: pt, taille: rayon * 1.0, halo: false, p)
}

/// B33, fin de limitation de vitesse : le **même** disque, liseré réduit à un filet et
/// barré d'une oblique montante. Le pendant exact du B14 — même géométrie, réponse
/// inverse — et c'est la paire que le candidat confond réellement.
func panneauFinDeLimitation(_ ctx: CGContext, _ valeur: Int, at pt: CGPoint, rayon: Double,
                            _ p: Palette) {
    // Le filet est tracé **à l'intérieur** du disque blanc, pas à sa place : posé au bord,
    // il disparaissait sur le fond sombre du mode nuit, et le panneau perdait le cerne qui
    // le distingue d'une pastille blanche.
    let filet = max(rayon * 0.05, 1.5)
    panneau(ctx, forme: .disque, at: pt, rayon: rayon, fond: p.panneauFond)
    ctx.setStrokeColor(encre(p))
    ctx.setLineWidth(filet)
    let cerne = rayon - filet / 2
    ctx.strokeEllipse(in: CGRect(x: pt.x - cerne, y: pt.y - cerne,
                                 width: cerne * 2, height: cerne * 2))
    // L'oblique est tracée dans le disque, donc écrêtée par lui : sans ce `clip` elle
    // dépasserait du panneau, ce qui n'existe sur aucun panneau réglementaire.
    ctx.saveGState()
    let interieur = rayon * 0.95
    ctx.addEllipse(in: CGRect(x: pt.x - interieur, y: pt.y - interieur,
                              width: interieur * 2, height: interieur * 2))
    ctx.clip()
    ctx.setStrokeColor(encre(p))
    ctx.setLineWidth(rayon * 0.24)
    ctx.setLineCap(.butt)
    ctx.beginPath()
    // Repère en y vers le bas : « montante vers la droite » part du plus grand y.
    ctx.move(to: CGPoint(x: pt.x - rayon, y: pt.y + rayon))
    ctx.addLine(to: CGPoint(x: pt.x + rayon, y: pt.y - rayon))
    ctx.strokePath()
    ctx.restoreGState()
    chiffres(ctx, "\(valeur)", at: pt, taille: rayon * 1.0, halo: true, p)
}

/// B30, entrée d'une zone 30 : un carré à fond blanc bordé de rouge, le mot ZONE en haut
/// et un disque de limitation en dessous. Le carré n'est pas un détail de style — c'est
/// lui qui dit que la prescription est **zonale** : elle vaut pour tout le périmètre, rues
/// sécantes comprises, là où un disque seul ne vaut que sur l'axe où il est planté.
func panneauZone30(_ ctx: CGContext, at pt: CGPoint, demiCote: Double, _ p: Palette) {
    let rayonCarre = demiCote / 0.78
    panneau(ctx, forme: .carre, at: pt, rayon: rayonCarre, fond: p.panneauFond,
            bord: p.panneauRouge, epaisseurBord: rayonCarre * 0.055)
    texte(ctx, "ZONE", centre: CGPoint(x: pt.x, y: pt.y - demiCote * 0.60),
          taille: demiCote * 0.42, couleur: encre(p))
    panneauLimitation(ctx, 30, at: CGPoint(x: pt.x, y: pt.y + demiCote * 0.28),
                      rayon: demiCote * 0.60, p)
}
