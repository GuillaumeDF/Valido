import CoreGraphics

// MARK: - Les scènes de circulation et de vitesse
//
// Deux familles : les panneaux de vitesse et la chaussée d'autoroute (tâche 5), puis les
// signaux lumineux (tâche 10, plus bas). Deux règles de cadrage commandent tout ce
// fichier :
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

    // MARK: - Les signaux lumineux (tâche 10)
    //
    // Ces trois scènes ont une contrainte que les panneaux n'ont pas : **la réponse ne
    // doit jamais reposer sur une teinte.** Un feu rouge et un feu vert, pour un
    // daltonien, sont deux ronds identiques. Trois choses portent donc l'information à la
    // place de la couleur, et elles sont toutes de forme et non de teinte :
    //
    // - la **position** de la lampe allumée dans le caisson — haut rouge, milieu jaune,
    //   bas vert, ordre fixé par l'art. 7 de l'arrêté du 24 novembre 1967 ;
    // - le **halo** autour de la lentille, qui dit qu'elle brûle, là où les autres restent
    //   au gris éteint ;
    // - les **traits rayonnants**, qui disent qu'elle clignote — la convention de l'IISR
    //   sur ses propres planches.
    //
    // L'`alt` de chaque question nomme la position, jamais la teinte. Et le nombre de
    // lentilles est lui-même une information : le signal d'arrêt R24 du passage à niveau
    // n'en a **qu'une**, un tricolore en a trois.

    // 5. Le jaune clignotant, seul et grand — même traitement que les panneaux ci-dessus,
    //    parce que la question porte sur la signification du signal et non sur une
    //    situation. La lampe allumée est celle du **milieu** : l'art. 7 réserve cette
    //    position au cas où « l'ensemble de l'installation est en panne, en cours de mise
    //    en activité ou volontairement géré avec ce seul message », qui est le cas que
    //    rencontre un candidat. Le jaune clignotant *permanent*, lui, est en bas, à la
    //    place du vert (signal R11j) — l'IISR recommande d'ailleurs de l'éviter.
    ("feu-jaune-clignotant", { ctx, p in
        fond(ctx, p)
        feuTricolore(ctx, at: CGPoint(x: cx, y: cy), largeur: 38,
                     [.eteinte, .clignotante, .eteinte], p)
    }),

    // 6. Rouge fixe + flèche jaune clignotante : le signal d'anticipation R16. La
    //    combinaison entière est le sujet, d'où deux caissons côte à côte et rien
    //    d'autre. Le tricolore n'a que sa lampe du **haut** allumée, et sans traits —
    //    le rouge d'un tricolore ne clignote pas ; c'est la flèche, et elle seule, qui
    //    clignote. La flèche est accolée à la hauteur de la lampe du bas, comme
    //    l'impose l'art. 110-5 de la 6e partie de l'IISR.
    ("feu-fleche-clignotante", { ctx, p in
        fond(ctx, p)
        feuTricolore(ctx, at: CGPoint(x: 168, y: cy), largeur: 34,
                     [.allumee, .eteinte, .eteinte], p)
        brasDeSupport(ctx, de: 185, a: 213, y: cy + 27.6, epaisseur: 6, p)
        signalDAnticipation(ctx, at: CGPoint(x: 222, y: cy + 27.6), largeur: 30,
                            versLaDroite: true, p)
    }),

    // 7. Passage à niveau au signal d'arrêt R24. Ici la scène compte, contrairement aux
    //    deux précédentes : la réponse (« l'arrêt absolu, train visible ou non ») demande
    //    de reconnaître **et** le signal **et** la voie ferrée. Les deux sont donc au
    //    centre vertical, dans la bande qui survit au recadrage ; la voiture du candidat,
    //    qui n'est que du décor, est en bas et disparaît au verdict.
    ("passage-niveau-feu-rouge-clignotant", { ctx, p in
        fond(ctx, p)
        chausseeVerticale(ctx, p)
        axeInterrompuSurLaVoieFerree(ctx, p)
        railsHorizontaux(ctx, p)
        signalDArret(ctx, at: CGPoint(x: cx + voie + 30, y: cy + 32), rayon: 15, p)
        voiture(ctx, x: voieVous, y: 248, cap: .nord, couleur: p.vous, liseree: true, p)
    }),
]

/// L'axe médian de la chaussée, interrompu juste au-dessus et au-dessous des rails.
/// `axeVertical` ménage un trou de la largeur d'un carrefour entier (± une demi-chaussée) :
/// sur un passage à niveau, ce trou-là se lirait comme une intersection.
private func axeInterrompuSurLaVoieFerree(_ ctx: CGContext, _ p: Palette) {
    ctx.setFillColor(p.marquage)
    var y = 4.0
    while y < H {
        if !(y + 14 > cy - 17 && y < cy + 17) {
            ctx.fill(CGRect(x: cx - 1.5, y: y, width: 3, height: 14))
        }
        y += 24
    }
}
