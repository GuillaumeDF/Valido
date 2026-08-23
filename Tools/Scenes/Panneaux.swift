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
