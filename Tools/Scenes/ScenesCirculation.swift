import CoreGraphics

// MARK: - Les scènes de circulation et de vitesse
//
// Trois panneaux de vitesse et une chaussée d'autoroute. Deux règles de cadrage
// commandent tout ce fichier :
//
// - **Le panneau est le sujet**, pas un détail dans une scène. Il est donc dessiné grand
//   et centré, alors que les panneaux des scènes de carrefour tiennent en rayon 15-17.
// - **Il doit survivre au recadrage.** Le bandeau de `QuestionCardView` tombe à 18 % de
//   la carte après le verdict et recadre en `.fill` : seule une bande d'environ 110 unités
//   autour du centre vertical reste visible. Un panneau de rayon 52 (diamètre 104) y
//   tient tout juste ; au-delà, la réponse serait rognée. C'est cette bande qui fixe la
//   taille, pas la place disponible dans le 400 × 300.
//
// Rien d'autre n'est dessiné autour des panneaux : sur un fond neutre, le liseré rouge du
// B14, le filet et l'oblique du B33, le carré du B30 se lisent sans concurrence. Un décor
// de route ne survivrait pas au recadrage de toute façon.

/// Rayon des panneaux circulaires : le plus grand qui tienne dans la bande centrale.
private let rayonPanneau = 52.0

/// Chaussée d'autoroute vue de dessus : trois voies dans un seul sens, terre-plein et
/// glissière à gauche, bande de rive continue à droite. La position de la glissière est
/// la seule chose qui désigne « la voie la plus à gauche » — et c'est une position, pas
/// une couleur : un daltonien la lit comme tout le monde.
private let bordGauche = 96.0, largeurVoie = 78.0
private func voieAutoroute(_ n: Int) -> Double {
    bordGauche + largeurVoie * (Double(n) + 0.5)
}

private func chausseeAutoroute(_ ctx: CGContext, _ p: Palette) {
    fond(ctx, p)
    // Terre-plein central, puis la glissière posée dessus.
    ctx.setFillColor(p.ilot)
    ctx.fill(CGRect(x: 0, y: 0, width: bordGauche - 10, height: H))
    ctx.setFillColor(p.chaussee)
    ctx.fill(CGRect(x: 52, y: 0, width: 7, height: H))
    ctx.setFillColor(p.chaussee)
    ctx.fill(CGRect(x: bordGauche - 10, y: 0, width: W - bordGauche + 10, height: H))
    // Bandes de rive : continues, comme sur la vraie chaussée.
    ctx.setFillColor(p.marquage)
    ctx.fill(CGRect(x: bordGauche - 6, y: 0, width: 3, height: H))
    ctx.fill(CGRect(x: bordGauche + largeurVoie * 3 + 3, y: 0, width: 3, height: H))
    // Lignes de voie discontinues.
    for i in 1...2 {
        var y = 6.0
        while y < H {
            ctx.fill(CGRect(x: bordGauche + largeurVoie * Double(i) - 1.5, y: y,
                            width: 3, height: 18))
            y += 32
        }
    }
}

let scenesCirculation: [(String, Scene)] = [

    // 1. B14 : le disque à large liseré rouge. « Ce panneau impose : » n'a aucun sens sans
    //    l'image — c'est la définition d'une question illustrée.
    ("panneau-b14-limitation", { ctx, p in
        fond(ctx, p)
        panneauLimitation(ctx, 70, at: CGPoint(x: cx, y: cy), rayon: rayonPanneau, p)
    }),

    // 2. B33 : même disque, même nombre, liseré réduit à un filet et oblique en travers.
    //    La paire 1/2 est volontairement identique à un détail près : c'est ce détail que
    //    la question fait travailler, et la réponse est l'inverse exacte.
    ("panneau-b33-fin-limitation", { ctx, p in
        fond(ctx, p)
        panneauFinDeLimitation(ctx, 70, at: CGPoint(x: cx, y: cy), rayon: rayonPanneau, p)
    }),

    // 3. B30 : le carré change tout. Il fait de la limitation une prescription zonale,
    //    valable rues sécantes comprises — c'est la confusion que la question vise, et
    //    elle ne se voit qu'en comparant la forme du panneau, pas son nombre.
    ("panneau-b30-zone-30", { ctx, p in
        fond(ctx, p)
        panneauZone30(ctx, at: CGPoint(x: cx, y: cy), demiCote: 50, p)
    }),

    // 4. Voie la plus à gauche d'une autoroute. Le véhicule du candidat longe la
    //    glissière centrale : c'est cette position — et elle seule — qui déclenche la
    //    vitesse minimale. Sans l'image, « cette voie » ne désigne rien.
    ("autoroute-voie-de-gauche", { ctx, p in
        chausseeAutoroute(ctx, p)
        voiture(ctx, x: voieAutoroute(0), y: cy + 4, cap: .nord, couleur: p.vous,
                liseree: true, p)
        voiture(ctx, x: voieAutoroute(1), y: cy - 58, cap: .nord, couleur: p.autre, p)
        voiture(ctx, x: voieAutoroute(2), y: cy + 62, cap: .nord, couleur: p.tiers, p)
    }),
]
