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

// MARK: - La rue bordée d'un trottoir (tâche 11)
//
// Trois scènes de stationnement partagent cette géométrie. Elle diffère de la chaussée des
// scènes de marquage sur un point qui décide de tout : **la bordure du trottoir y est une
// surface**, et non le simple bord de la chaussée.
//
// C'est l'art. 118-2, B de la 7e partie de l'IISR qui l'impose. Le marquage jaune
// d'interdiction « est réalisé sur la face supérieure de la bordure du trottoir ou en rive
// de chaussée ». Des deux emplacements permis, on prend le premier, et pas par goût : c'est
// le seul qui rende le trait reconnaissable **sans distinguer une couleur**. Aucun marquage
// blanc n'est jamais peint sur une bordure — un trait posé là ne peut être qu'un jaune
// d'interdiction d'arrêt ou de stationnement. Un trait posé en rive de chaussée, lui, aurait
// exactement l'allure d'une bande de rive blanche pour qui ne voit pas la teinte.

/// Bord droit de la chaussée et axe médian de la rue vue en long (paire de lignes jaunes).
/// La chaussée court jusqu'au bord **gauche** du cadre : la voie d'en face sort de l'image,
/// et la seule surface claire est alors le trottoir. Un premier jet laissait du sol des deux
/// côtés, et le trottoir ne se distinguait plus de la marge.
private let rueDroite = 244.0, rueAxe = 148.0
/// Largeur de la face supérieure de la bordure. Une vraie bordure en fait 15 à 20 cm ; à
/// l'échelle de la scène (une voie de 96 unités vaut 3 m, donc 32 unités par mètre) cela
/// ferait 5 unités, sur lesquelles un trait de 2u ne laisserait rien voir de la bordure
/// elle-même. Elle est donc élargie à 22 — c'est la licence qui rend lisible le fait que le
/// trait est **posé sur la bordure**, et ce fait est tout ce qui le désigne comme jaune à
/// qui ne voit pas les couleurs.
private let bordureLargeur = 22.0
/// Largeur du trait jaune : 2u de la norme valent 10 cm, soit 3,2 unités. Porté à 7, de sorte
/// qu'il reste 7,5 unités de bordure nue de chaque côté.
private let traitJauneLargeur = 7.0
private let traitJauneX = rueDroite + bordureLargeur / 2 - traitJauneLargeur / 2
/// Modulation T'2 : « alternativement 0,5 m de trait et 0,5 m de vide » (art. 113-1, B).
/// Celle-ci n'est **pas** exagérée — à 32 unités par mètre, 0,5 m fait 16 unités, ce qui se
/// lit très bien. C'est ce rapport 1 pour 1 qui distingue une T'2 d'une T1 ou d'une T3, donc
/// c'est lui qu'il faut respecter au trait près.
private let t2Trait = 16.0

/// La rue : chaussée à double sens, bordure de trottoir à droite, trottoir au-delà (c'est le
/// sol, comme dans toutes les scènes). Le trait jaune est posé ensuite par la scène.
private func rueLeLongDUnTrottoir(_ ctx: CGContext, _ p: Palette) {
    fond(ctx, p)
    ctx.setFillColor(p.chaussee)
    ctx.fill(CGRect(x: 0, y: 0, width: rueDroite, height: H))
    ctx.setFillColor(p.bordure)
    ctx.fill(CGRect(x: rueDroite, y: 0, width: bordureLargeur, height: H))
    // L'axe médian, en blanc : il fait lire l'image comme une rue, et il donne au trait de
    // la bordure un point de comparaison — le blanc du marquage mesure 255 en niveaux de
    // gris, le jaune 190. Le trait de la bordure n'est donc pas blanc, et ça se mesure.
    ctx.setFillColor(p.marquage)
    var y = 6.0
    while y < H {
        ctx.fill(CGRect(x: rueAxe - 1.5, y: y, width: 3, height: 16))
        y += 30
    }
}

/// Le trait jaune sur la face supérieure de la bordure. `interrompu` est **toute** la
/// différence entre les deux scènes de la paire : même rue, même bordure, même voiture, même
/// teinte. Le discriminant est l'interruption, jamais la couleur.
private func traitJauneSurLaBordure(_ ctx: CGContext, interrompu: Bool, _ p: Palette) {
    ctx.setFillColor(p.panneauJaune)
    if !interrompu {
        ctx.fill(CGRect(x: traitJauneX, y: 0, width: traitJauneLargeur, height: H))
        return
    }
    var y = 0.0
    while y < H {
        ctx.fill(CGRect(x: traitJauneX, y: y, width: traitJauneLargeur,
                        height: min(t2Trait, H - y)))
        y += t2Trait * 2
    }
}

// MARK: - Le stationnement en épi (tâche 11)
//
// Géométrie relevée sur la planche jointe à l'art. 118-2, A, a) de la 7e partie (page 44 du
// PDF, image extraite avec `pypdf[image]`) : deux figures côte à côte, perpendiculaire à
// gauche, **en épi** à droite. En suivant un même séparateur de la figure de droite, il
// passe de x = 806 px à y = 100 à x = 724 px à y = 240 : dx = 82 pour dy = 140, soit un
// angle de 59,6° avec la bordure. D'où les 60° ci-dessous — l'angle n'est écrit dans aucun
// article, il se mesure sur la planche.
//
// La planche donne aussi la nature des deux marquages, et ils ne sont pas du même type :
// les **séparateurs** entre places sont continus, le **front** des places est une T'2
// discontinue. L'article autorise l'un ou l'autre pour les limites (« continues de largeur
// 2u ou discontinue de type T'2 de largeur 2u ou simplement amorcées ») ; la planche tranche
// pour ce partage-là, et c'est elle qu'on suit.

private let epiTrottoirBas = 96.0, epiBordureBas = 106.0
private let epiFrontDesPlaces = 158.0, epiAxe = 200.0
private let epiChausseeBas = 242.0, epiBordureOpposeeBas = 252.0
/// Décalage d'un séparateur entre son pied (au front des places) et sa tête (à la bordure) :
/// une profondeur de place divisée par la tangente de 60°.
private let epiDecalage = (epiFrontDesPlaces - epiBordureBas) / tan(60.0 * .pi / 180)
/// Entraxe des séparateurs le long de la bordure. Une place de 2,30 m prise à 60° occupe
/// 2,30 / sin(60°) = 2,66 m de bordure ; à 12 unités par mètre — l'échelle des véhicules du
/// dossier, dont la caisse de 40 unités vaut 3,3 m — cela fait 32 unités.
private let epiEntraxe = 32.0

/// Une voiture garée dans l'axe d'une place en épi : la primitive `voiture` ne connaît que
/// les quatre points cardinaux, donc on incline le repère plutôt que d'ajouter une seconde
/// géométrie de caisse. Le nez pointe vers la bordure, comme une place en épi se prend en
/// marche avant.
private func voitureEnEpi(_ ctx: CGContext, x: Double, y: Double, couleur: CGColor,
                          _ p: Palette) {
    ctx.saveGState()
    ctx.translateBy(x: x, y: y)
    // Repère en y vers le bas : un angle positif fait tourner le nez vers la droite.
    ctx.rotate(by: (90.0 - 60.0) * .pi / 180)
    voiture(ctx, x: 0, y: 0, cap: .nord, couleur: couleur, p)
    ctx.restoreGState()
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
    // MARK: - Arrêt et stationnement (tâche 11)

    // 8 et 9. La paire de lignes jaunes. Continue, elle interdit l'arrêt — donc aussi le
    //    stationnement ; discontinue, elle n'interdit que le stationnement (7e partie,
    //    art. 118-2, B, et tableau de l'art. 113-2 E). Les deux scènes sont **identiques
    //    au trait près** : la banque ne portait que la continue, et sous forme de
    //    photographie, ce qui laissait le candidat trancher sur « photo contre schéma »
    //    plutôt que sur le marquage. Les deux sont donc dessinées, du même point de vue et
    //    avec la même voiture, et seule l'interruption les sépare.
    ("stationnement-ligne-jaune-continue", { ctx, p in
        rueLeLongDUnTrottoir(ctx, p)
        traitJauneSurLaBordure(ctx, interrompu: false, p)
        voiture(ctx, x: 196, y: 250, cap: .nord, couleur: p.vous, liseree: true, p)
    }),

    ("stationnement-ligne-jaune-discontinue", { ctx, p in
        rueLeLongDUnTrottoir(ctx, p)
        traitJauneSurLaBordure(ctx, interrompu: true, p)
        voiture(ctx, x: 196, y: 250, cap: .nord, couleur: p.vous, liseree: true, p)
    }),

    // 10. Le stationnement en épi. Ici l'image ne dit pas une règle mais une **géométrie**,
    //     et une géométrie ne se voit que de dessus : c'est l'inclinaison des séparateurs
    //     qui distingue l'épi de la perpendiculaire (« en bataille ») et du longitudinal
    //     (« en créneau »). Rien de la réponse ne repose sur une teinte — les séparateurs
    //     sont blancs, la bordure grise, et les deux voitures garées ne servent qu'à faire
    //     lire des places plutôt que des hachures.
    ("stationnement-en-epi", { ctx, p in
        fond(ctx, p)
        ctx.setFillColor(p.chaussee)
        ctx.fill(CGRect(x: 0, y: epiBordureBas, width: W, height: epiChausseeBas - epiBordureBas))
        ctx.setFillColor(p.bordure)
        ctx.fill(CGRect(x: 0, y: epiTrottoirBas, width: W, height: epiBordureBas - epiTrottoirBas))
        ctx.fill(CGRect(x: 0, y: epiChausseeBas, width: W,
                        height: epiBordureOpposeeBas - epiChausseeBas))
        // Les séparateurs de places : continus, obliques à 60° de la bordure, du front des
        // places jusqu'à la bordure.
        ctx.setStrokeColor(p.marquage)
        ctx.setLineWidth(4)
        ctx.setLineCap(.butt)
        var pied = -40.0
        while pied < W + epiDecalage {
            ctx.beginPath()
            ctx.move(to: CGPoint(x: pied, y: epiFrontDesPlaces))
            ctx.addLine(to: CGPoint(x: pied + epiDecalage, y: epiBordureBas))
            ctx.strokePath()
            pied += epiEntraxe
        }
        // Le front des places, en T'2 : 0,5 m de trait pour 0,5 m de vide, à 12 unités par
        // mètre comme le reste de cette scène.
        ctx.setFillColor(p.marquage)
        var x = 0.0
        while x < W {
            ctx.fill(CGRect(x: x, y: epiFrontDesPlaces - 2, width: min(6, W - x), height: 4))
            x += 12
        }
        // L'axe médian de la rue.
        var xAxe = 4.0
        while xAxe < W {
            ctx.fill(CGRect(x: xAxe, y: epiAxe - 1.5, width: 16, height: 3))
            xAxe += 30
        }
        // Deux places occupées, deux vides : sans voiture, des obliques partant d'une
        // bordure se liraient comme des hachures.
        // Milieu de l'axe d'une place : pied du séparateur + un demi-entraxe + un demi-
        // décalage. Une caisse de 40 unités dans une place de 60 laisse 10 unités devant et
        // derrière, donc aucun débord sur la bordure ni sur le front.
        //
        // Trois places contiguës occupées et la moitié droite vide : c'est ce partage qui
        // fait la lecture. Des obliques nues partant d'une bordure se prendraient pour des
        // hachures de zone non circulable ; des places toutes occupées cacheraient
        // l'inclinaison qui porte la réponse. Les voitures disent « du stationnement », les
        // places vides disent « en épi ».
        for (i, pied) in [24.0, 56.0, 88.0].enumerated() {
            voitureEnEpi(ctx, x: pied + epiEntraxe / 2 + epiDecalage / 2, y: 132,
                         couleur: i == 1 ? p.tiers : p.autre, p)
        }
        // Vous circulez dans la voie qui longe les places : c'est ce qui donne le sens de la
        // marche, et donc pourquoi le nez des voitures garées pointe de ce côté-là.
        voiture(ctx, x: 320, y: epiFrontDesPlaces + 21, cap: .est, couleur: p.vous,
                liseree: true, p)
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
