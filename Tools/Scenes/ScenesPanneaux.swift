import CoreGraphics

// MARK: - Les scènes de panneaux et de marquage
//
// Un panneau se reconnaît, il ne se récite pas : c'est la raison d'être de ce fichier. Les
// questions du domaine nommaient toutes leur panneau dans l'énoncé, ce qui les rendait
// solubles sans regarder ; l'énoncé cède désormais ce que l'image porte.
//
// Trois règles de cadrage commandent tout le fichier.
//
// - **Le panneau est le sujet**, seul sur le fond neutre. Un décor de route ne survivrait
//   pas au recadrage et entrerait en concurrence avec le liseré, le listel et le
//   pictogramme, qui sont précisément ce qu'il faut lire.
// - **Une seule gamme pour tous les panneaux.** `rayonPourGamme` traduit une gamme en
//   rayon selon l'article 5-3 de la 1re partie : à gamme égale, le triangle est le plus
//   grand des panneaux et le carré le plus petit, exactement comme sur la route. D'une
//   scène à l'autre, la taille ne renseigne donc sur rien — elle ne peut pas devenir un
//   indice parasite.
// - **La boîte englobante est centrée, pas le cercle circonscrit.** Le bandeau de
//   `QuestionCardView` tombe à 18 % de la carte au verdict et recadre en `.fill` : seule
//   une bande d'environ 110 unités autour du centre vertical survit. Un triangle
//   équilatéral déborde de son centre de `1 rayon` vers le haut et de `0,5 rayon` vers le
//   bas ; centrer son cercle circonscrit lui ferait perdre la pointe. D'où `centreCadre`.

/// La gamme commune : 106 unités de « côté nominal du triangle ». C'est le losange AB7 qui
/// la plafonne — un carré posé sur la pointe a la plus grande hauteur hors tout de toutes
/// les formes (2 rayons, soit 0,99 gamme), et il doit tenir dans la bande de 110.
private let gammePanneau = 106.0

/// Le centre à donner au panneau pour que sa boîte englobante, et non son cercle
/// circonscrit, soit centrée verticalement sur la scène.
private func centreCadre(_ forme: Forme, rayon r: Double) -> CGPoint {
    switch forme {
    case .triangle:        return CGPoint(x: cx, y: cy + r / 4)
    case .triangleInverse: return CGPoint(x: cx, y: cy - r / 4)
    default:               return CGPoint(x: cx, y: cy)
    }
}

/// Une scène de panneau isolé : le fond, puis le panneau centré à la gamme commune.
private func scenePanneau(
    _ forme: Forme,
    _ dessin: @escaping (CGContext, CGPoint, Double, Palette) -> Void
) -> Scene {
    { ctx, p in
        fond(ctx, p)
        let r = rayonPourGamme(forme, gammePanneau)
        dessin(ctx, centreCadre(forme, rayon: r), r, p)
    }
}

// MARK: - La chaussée des scènes de marquage
//
// Plus large que celle des scènes de carrefour : là-bas le marquage est un détail qui
// qualifie un croisement, ici c'est le sujet, et une ligne mixte ou des hachures doivent
// se distinguer l'une de l'autre à 90 points de haut.

private let bordGaucheChaussee = 100.0, bordDroitChaussee = 300.0
/// Voie de qui descend, c'est-à-dire d'en face. Voie de qui monte : la vôtre, à droite.
private let voieDenFaceMarquage = 137.0, voieVousMarquage = 263.0

/// Chaussée à double sens, bandes de rive continues, sans marquage axial : chaque scène
/// pose ensuite le sien, et c'est lui qu'il faut lire.
private func chausseeDeMarquage(_ ctx: CGContext, _ p: Palette) {
    fond(ctx, p)
    ctx.setFillColor(p.chaussee)
    ctx.fill(CGRect(x: bordGaucheChaussee, y: 0,
                    width: bordDroitChaussee - bordGaucheChaussee, height: H))
    ctx.setFillColor(p.marquage)
    for x in [bordGaucheChaussee + 4, bordDroitChaussee - 7] {
        ctx.fill(CGRect(x: x, y: 0, width: 3, height: H))
    }
}

/// Une ligne longitudinale continue, dans l'axe donné.
private func ligneContinue(_ ctx: CGContext, x: Double, de y0: Double, a y1: Double,
                           largeur: Double, _ p: Palette) {
    ctx.setFillColor(p.marquage)
    ctx.fill(CGRect(x: x - largeur / 2, y: y0, width: largeur, height: y1 - y0))
}

/// Une ligne discontinue de type T3 : « à forte prédominance des pleins sur les vides »
/// (7e partie, art. 113, A), modulation 3 m de trait pour 1,33 m d'intervalle. C'est elle
/// qui annonce une ligne continue, et c'est aussi elle qui double la continue dans une
/// ligne mixte.
private func ligneT3(_ ctx: CGContext, x: Double, de y0: Double, a y1: Double,
                     largeur: Double, _ p: Palette) {
    ctx.setFillColor(p.marquage)
    var y = y0
    while y < y1 {
        ctx.fill(CGRect(x: x - largeur / 2, y: y, width: largeur, height: min(15, y1 - y)))
        y += 27
    }
}

/// Une flèche de rabattement peinte au sol. Rien à voir avec la flèche d'intention des
/// scènes de carrefour : celle-ci est une **marque**, donc blanche, large, et couchée dans
/// l'axe avant de s'infléchir vers la voie à emprunter. C'est la même primitive `fleche`,
/// à cinq fois l'épaisseur.
private func flecheDeRabattement(_ ctx: CGContext, x: Double, y: Double, _ p: Palette) {
    fleche(ctx, [CGPoint(x: x - 11, y: y + 18), CGPoint(x: x - 11, y: y + 1),
                 CGPoint(x: x + 10, y: y - 20)], couleur: p.marquage, epaisseur: 8)
}

// MARK: - Les scènes

let scenesPanneaux: [(String, Scene)] = [

    // MARK: Panneaux de danger (type A) — triangle, bande rouge, listel blanc

    // 1. A1a : le virage. Le triangle et sa courbe disent tous deux la même chose — un
    //    danger annoncé en amont — et c'est la forme, non la teinte, qui porte la réponse.
    ("panneau-a1a-virage", scenePanneau(.triangle) { ctx, pt, r, p in
        panneauVirage(ctx, at: pt, rayon: r, p)
    }),

    // 2. A13b : passage pour piétons. Panneau **avancé** (2e partie, art. 40) : la
    //    question porte précisément sur le fait qu'il ne prescrit rien à sa hauteur.
    ("panneau-a13b-passage-pietons", scenePanneau(.triangle) { ctx, pt, r, p in
        panneauPassagePietons(ctx, at: pt, rayon: r, p)
    }),

    // 3. A14 et son panonceau. L'assemblage est plus haut qu'un panneau seul : la gamme
    //    descend donc à 90 et le centre remonte de 3 unités, pour que la pointe du
    //    triangle et le bas de la plaque tiennent tous deux dans la bande de 110 qui
    //    survit au recadrage. Sans le panonceau la question n'aurait pas d'objet — c'est
    //    lui qui nomme le danger que le point d'exclamation laisse ouvert.
    ("panneau-a14-panonceau", { ctx, p in
        fond(ctx, p)
        let r = rayonPourGamme(.triangle, 90)
        let pt = CGPoint(x: cx, y: cy - 3)
        panneauAutresDangers(ctx, at: pt, rayon: r, p)
        let l = r * sqrt(3.0), h = r * 0.50
        panonceau(ctx, "CARRIÈRE",
                  at: CGRect(x: pt.x - l / 2, y: pt.y + r * 0.62, width: l, height: h), p)
    }),

    // MARK: Panneaux de prescription (type B) — disque

    // 4. B1 : le seul panneau d'interdiction à fond rouge, et le seul dont la couronne ne
    //    porte rien (4e partie, art. 47). C'est la barre blanche en travers qui le nomme.
    ("panneau-b1-sens-interdit", scenePanneau(.disque) { ctx, pt, r, p in
        panneauSensInterdit(ctx, at: pt, rayon: r, p)
    }),

    // 5. B3 : interdiction de dépasser. Les deux voitures sont côte à côte et décalées —
    //    un dépassement en cours — et se distinguent par leur position et leur cerne, pas
    //    par leur teinte.
    ("panneau-b3-interdiction-depasser", scenePanneau(.disque) { ctx, pt, r, p in
        panneauInterdictionDepasser(ctx, at: pt, rayon: r, p)
    }),

    // 6. B6a1 : stationnement interdit, **une** oblique.
    ("panneau-b6a1-stationnement-interdit", scenePanneau(.disque) { ctx, pt, r, p in
        panneauStationnementInterdit(ctx, at: pt, rayon: r, p)
    }),

    // 7. B6d : arrêt et stationnement interdits, **deux** obliques croisées. La paire 6/7
    //    est volontairement identique à une barre près : c'est cette barre que la question
    //    fait travailler, et c'est un compte, pas une couleur.
    ("panneau-b6d-arret-interdit", scenePanneau(.disque) { ctx, pt, r, p in
        panneauArretEtStationnementInterdits(ctx, at: pt, rayon: r, p)
    }),

    // 8. B21b : direction obligatoire tout droit à la prochaine intersection.
    ("panneau-b21b-tout-droit", scenePanneau(.disque) { ctx, pt, r, p in
        panneauDirectionObligatoire(ctx, at: pt, rayon: r, p)
    }),

    // 9. B31 : fin de toutes les interdictions. Aucun rouge, aucun chiffre — c'est
    //    l'absence qui fait le sens, et elle se voit en noir et blanc.
    ("panneau-b31-fin-interdictions", scenePanneau(.disque) { ctx, pt, r, p in
        panneauFinDInterdictions(ctx, at: pt, rayon: r, p)
    }),

    // MARK: Panneaux d'intersection (type AB)

    // 10. AB4 : l'octogone, seul de son espèce. Le mot STOP y est écrit, donc la question
    //     ne peut pas porter sur son nom : elle porte sur ce qu'il impose.
    ("panneau-ab4-stop", scenePanneau(.octogone) { ctx, pt, r, p in
        panneauStop(ctx, at: pt, rayon: r, p)
    }),

    // 11. AB7 : fin du caractère prioritaire. Le pendant du B31 pour la priorité, et la
    //     confusion que la question fait travailler : deux panneaux barrés, deux portées
    //     différentes.
    ("panneau-ab7-fin-priorite", scenePanneau(.losange) { ctx, pt, r, p in
        panneauFinPriorite(ctx, at: pt, rayon: r, p)
    }),

    // MARK: Panneaux d'indication (type C) — carré

    // 12. C1a : le carré. La question ne porte pas sur le parking mais sur la forme —
    //     un carré renseigne là où un disque prescrit — et un carré se reconnaît sans
    //     distinguer une seule couleur.
    ("panneau-c1a-parking", scenePanneau(.carre) { ctx, pt, r, p in
        panneauParking(ctx, at: pt, rayon: r, p)
    }),

    // 13. C113 : voie conseillée et réservée aux cyclistes. Carré, donc indication : la
    //     voie est réservée sans que le cycliste soit obligé de la prendre. La piste
    //     obligatoire, elle, est ronde.
    ("panneau-c113-voie-velo", scenePanneau(.carre) { ctx, pt, r, p in
        panneauVoieVelo(ctx, at: pt, rayon: r, p)
    }),

    // MARK: Marquage

    // 14. Ligne mixte : une continue doublée d'une T3 espacée de 2u (7e partie, art. 113,
    //     tableau des lignes longitudinales). La discontinue est posée **de votre côté**,
    //     donc le dépassement vous est permis et interdit au véhicule d'en face : c'est
    //     la même ligne qui dit deux choses opposées selon qui la lit, et c'est tout
    //     l'objet de la question.
    ("marquage-ligne-mixte", { ctx, p in
        chausseeDeMarquage(ctx, p)
        // La norme espace les deux lignes de 2u, soit une dizaine de centimètres : à cette
        // échelle elles fusionneraient en un seul trait. Écart et largeur sont donc
        // exagérés — c'est la seule licence prise sur la géométrie de cette scène, et elle
        // est nécessaire pour que « la continue » et « la discontinue » se distinguent.
        ligneContinue(ctx, x: cx - 14, de: 0, a: H, largeur: 5, p)
        ligneT3(ctx, x: cx + 14, de: 6, a: H, largeur: 5, p)
        voiture(ctx, x: voieDenFaceMarquage, y: cy - 22, cap: .sud, couleur: p.autre, p)
        voiture(ctx, x: voieVousMarquage, y: cy + 28, cap: .nord, couleur: p.vous,
                liseree: true, p)
    }),

    // 15. Flèches de rabattement : trois, comme l'impose l'article 115-3, B, 2 de la 7e
    //     partie, à cheval sur la ligne d'annonce et pointant vers la voie à rejoindre.
    //     La continue commence au bout des flèches — c'est ce qu'elles annoncent, et c'est
    //     pour ça que la ligne d'annonce doit rester visible sous elles.
    ("marquage-fleches-rabattement", { ctx, p in
        chausseeDeMarquage(ctx, p)
        ligneT3(ctx, x: cx, de: 100, a: H, largeur: 5, p)
        ligneContinue(ctx, x: cx, de: 0, a: 96, largeur: 5, p)
        for y in [202.0, 155.0, 108.0] { flecheDeRabattement(ctx, x: cx, y: y, p) }
        // Vous, en bas de la scène : votre position ne décide de rien, seules les flèches
        // le font. C'est pourquoi elle peut sortir de la bande centrale.
        voiture(ctx, x: voieVousMarquage, y: 262, cap: .nord, couleur: p.vous,
                liseree: true, p)
    }),

    // 16. Zébras : une zone non circulable au milieu de la chaussée, délimitée par deux
    //     continues de 3u et couverte de hachures blanches « inclinées à 2 parallèlement
    //     à la rive pour 1 perpendiculairement » (7e partie, art. 117, A). L'inclinaison
    //     n'est pas décorative : elle « tend à ramener l'usager vers l'axe de la voie
    //     qu'il emprunte », donc elle penche vers la droite pour qui monte.
    ("marquage-zebra", { ctx, p in
        chausseeDeMarquage(ctx, p)
        let gauche = cx - 26.0, droite = cx + 26.0
        ligneContinue(ctx, x: gauche, de: 0, a: H, largeur: 6, p)
        ligneContinue(ctx, x: droite, de: 0, a: H, largeur: 6, p)
        ctx.saveGState()
        ctx.clip(to: CGRect(x: gauche + 5, y: 0, width: droite - gauche - 10, height: H))
        ctx.setStrokeColor(p.marquage)
        ctx.setLineWidth(4)
        ctx.setLineCap(.butt)
        var y = -60.0
        while y < H + 120 {
            ctx.beginPath()
            ctx.move(to: CGPoint(x: gauche, y: y))
            // 52 unités en travers pour 104 dans l'axe : la pente 2 pour 1 de la norme.
            ctx.addLine(to: CGPoint(x: droite, y: y - 104))
            ctx.strokePath()
            y += 26
        }
        ctx.restoreGState()
        voiture(ctx, x: voieDenFaceMarquage, y: cy - 26, cap: .sud, couleur: p.autre, p)
        voiture(ctx, x: voieVousMarquage, y: cy + 26, cap: .nord, couleur: p.vous,
                liseree: true, p)
    }),

    // 17. Damier de voie de détresse : « un marquage en damiers de couleur rouge et
    //     blanche. Chaque carreau du damier mesure 1,5 m de large sur 3 m de long »
    //     (7e partie, art. 118-10). Les carreaux sont donc deux fois plus longs que
    //     larges, et c'est le **damier** — un motif, pas une teinte — qui distingue ce
    //     marquage des hachures de la scène précédente.
    ("marquage-damier-detresse", { ctx, p in
        fond(ctx, p)
        // La chaussée courante, deux voies dans le même sens.
        ctx.setFillColor(p.chaussee)
        ctx.fill(CGRect(x: 56, y: 0, width: 194, height: H))
        ctx.setFillColor(p.marquage)
        ctx.fill(CGRect(x: 60, y: 0, width: 3, height: H))
        ctx.fill(CGRect(x: 247, y: 0, width: 3, height: H))
        var y = 6.0
        while y < H {
            ctx.fill(CGRect(x: 153, y: y, width: 3, height: 18))
            y += 32
        }
        // La voie de détresse, qui « débute en limite extérieure de la bande d'arrêt
        // d'urgence ou de la bande dérasée de droite » : donc à droite, et son marquage
        // s'arrête « devant le lit d'arrêt », d'où le pavé fini haut et bas.
        let x0 = 256.0, y0 = 70.0, carreauL = 20.0, carreauH = 40.0
        ctx.setFillColor(p.chaussee)
        ctx.fill(CGRect(x: 250, y: 60, width: 132, height: 180))
        for col in 0..<6 {
            for rang in 0..<4 {
                ctx.setFillColor((col + rang) % 2 == 0 ? p.panneauRouge : p.marquage)
                ctx.fill(CGRect(x: x0 + Double(col) * carreauL,
                                y: y0 + Double(rang) * carreauH,
                                width: carreauL, height: carreauH))
            }
        }
        voiture(ctx, x: 200, y: cy + 24, cap: .nord, couleur: p.vous, liseree: true, p)
    }),
]
