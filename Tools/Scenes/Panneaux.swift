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

// MARK: - Feux et panneaux de danger

/// Boîtier d'un feu tricolore, planté au bord de la chaussée : trois lentilles alignées
/// dans un caisson vertical, sur son mât. Renvoie le centre des trois lentilles, **du
/// haut vers le bas**, pour qu'un appelant puisse en allumer une : c'est alors la position
/// dans le caisson qui porte l'information, pas la seule couleur.
///
/// Aucune scène n'allume encore de lampe, et la palette n'a d'ailleurs pas de vert. La
/// tâche qui aura besoin d'un feu allumé ajoutera l'un et l'autre ; le caisson, lui, est
/// dessiné une fois pour toutes.
func boitierDeFeu(_ ctx: CGContext, at pt: CGPoint, _ p: Palette) -> [CGPoint] {
    let l = 13.0, h = 34.0
    let caisson = CGRect(x: pt.x - l / 2, y: pt.y - h / 2, width: l, height: h)
    ctx.setFillColor(p.chaussee)
    ctx.addPath(CGPath(roundedRect: caisson, cornerWidth: 3, cornerHeight: 3, transform: nil))
    ctx.fillPath()
    // Le mât, sans quoi le caisson flotte au-dessus du sol.
    ctx.fill(CGRect(x: pt.x - 1.5, y: caisson.maxY, width: 3, height: 8))
    return (0..<3).map { CGPoint(x: pt.x, y: caisson.minY + 6.5 + Double($0) * 10.5) }
}

/// Feu hors service : les trois lentilles au même gris éteint. Ce qui se lit est
/// l'**absence** de lampe allumée, et non une couleur particulière — un daltonien voit la
/// même chose que tout le monde.
func feuHorsService(_ ctx: CGContext, at pt: CGPoint, _ p: Palette) {
    for centre in boitierDeFeu(ctx, at: pt, p) {
        let lentille = CGRect(x: centre.x - 4, y: centre.y - 4, width: 8, height: 8)
        ctx.setFillColor(CGColor(gray: 1, alpha: 0.28))
        ctx.fillEllipse(in: lentille)
        ctx.setStrokeColor(CGColor(gray: 1, alpha: 0.5))
        ctx.setLineWidth(1)
        ctx.strokeEllipse(in: lentille)
    }
}

/// A16, descente dangereuse, avec son panonceau de déclivité. Il est là pour une raison
/// de droit et non de décor : l'article R414-3 ne fait s'arrêter le véhicule descendant
/// que « sur les routes de montagne et sur les routes à forte déclivité », et c'est
/// l'image qui doit dire qu'on y est.
func panneauDescenteDangereuse(_ ctx: CGContext, _ pourcentage: Int, at pt: CGPoint,
                               rayon: Double, _ p: Palette) {
    panneau(ctx, forme: .triangle, at: pt, rayon: rayon, fond: p.panneauFond,
            bord: p.panneauRouge, epaisseurBord: rayon * 0.17)
    // Le pictogramme réglementaire : une chaussée qui plonge vers la droite.
    ctx.setStrokeColor(encre(p))
    ctx.setLineWidth(rayon * 0.17)
    ctx.setLineCap(.butt)
    ctx.beginPath()
    ctx.move(to: CGPoint(x: pt.x - rayon * 0.45, y: pt.y - rayon * 0.10))
    ctx.addLine(to: CGPoint(x: pt.x + rayon * 0.45, y: pt.y + rayon * 0.36))
    ctx.strokePath()
    // Panonceau de déclivité : un rectangle blanc sous le triangle, comme sur la route.
    let l = rayon * 1.55, h = rayon * 0.64
    let plaque = CGRect(x: pt.x - l / 2, y: pt.y + rayon * 0.95, width: l, height: h)
    ctx.setFillColor(p.panneauFond)
    ctx.fill(plaque)
    ctx.setStrokeColor(encre(p))
    ctx.setLineWidth(1)
    ctx.stroke(plaque)
    texte(ctx, "\(pourcentage) %", centre: CGPoint(x: plaque.midX, y: plaque.midY),
          taille: h * 0.60, couleur: encre(p))
}
