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

    // 1. `panneau-a1a-virage` a existé ici, triangle et courbe dessinés. Remplacée par
    //    une photographie Commons le 2026-09-22 (tâche 3A-2 du chantier illustrations).
    //    Voir `Tools/photo-panneau.py` et `Tools/images.md`.

    // 2. `panneau-a13b-passage-pietons` a existé ici, triangle et silhouette de piéton
    //    dessinés. Remplacée par une photographie Commons le 2026-09-22 (tâche 3A-2) : le
    //    piéton dessiné était une silhouette à cinq traits, là où le vrai pictogramme est
    //    une figure pleine. Voir `Tools/photo-panneau.py` et `Tools/images.md`.

    // 3. `panneau-a14-panonceau` a existé ici, triangle, point d'exclamation et panonceau
    //    « CARRIÈRE » dessinés. Remplacée par une photographie Commons le 2026-09-22
    //    (tâche 3A-2), qui porte le même texte de panonceau. Voir `Tools/photo-panneau.py`
    //    et `Tools/images.md`.

    // MARK: Panneaux de prescription (type B) — disque

    // 4. `panneau-b1-sens-interdit` a existé ici, disque rouge et barre blanche dessinés.
    //    Remplacée par une photographie Commons le 2026-09-22 (tâche 3A-1 du chantier
    //    illustrations). Voir `Tools/photo-panneau.py` et `Tools/images.md`.

    // 5. `panneau-b3-interdiction-depasser` a existé ici, disque et deux voitures dessinés.
    //    Remplacée par une photographie Commons le 2026-09-22 (tâche 3A-1) : les voitures
    //    dessinées étaient des blocs sans roues ni pare-brise. Voir `Tools/photo-panneau.py`
    //    et `Tools/images.md`.

    // 6. `panneau-b6a1-stationnement-interdit` a existé ici, disque bleu et une oblique
    //    dessinés. Remplacée par une photographie Commons le 2026-09-22 (tâche 3A-1). Voir
    //    `Tools/photo-panneau.py` et `Tools/images.md`.

    // 7. `panneau-b6d-arret-interdit` a existé ici, le même disque à deux obliques
    //    croisées dessinées. Remplacée par une photographie Commons le 2026-09-22
    //    (tâche 3A-1) : la paire 6/7 reste distinguée par le même compte d'obliques, choisi
    //    sans ambiguïté sur les deux photographies. Voir `Tools/photo-panneau.py` et
    //    `Tools/images.md`.

    // 8. `panneau-b21b-tout-droit` a existé ici, disque et flèche dessinés. Remplacée par
    //    une photographie Commons le 2026-09-22 (tâche 2 du chantier illustrations) : la
    //    flèche dessinée était une aiguille fine, là où la vraie est large et trapézoïdale.
    //    Voir `Tools/photo-panneau.py` et `Tools/images.md` pour le protocole et la source.

    // 9. `panneau-b31-fin-interdictions` a existé ici, disque et oblique dessinés.
    //    Remplacée par une photographie Commons le 2026-09-22 (tâche 3A-2). Voir
    //    `Tools/photo-panneau.py` et `Tools/images.md`.

    // MARK: Panneaux d'intersection (type AB)

    // 10. `panneau-ab4-stop` a existé ici, octogone et STOP dessinés. Remplacée par une
    //     photographie Commons le 2026-09-22 (tâche 3A-3 du chantier illustrations). Voir
    //     `Tools/photo-panneau.py` et `Tools/images.md`.

    // 11. `panneau-ab7-fin-priorite` a existé ici, losange barré dessiné. Remplacée par
    //     une photographie Commons le 2026-09-22 (tâche 3A-3) : le losange jaune et sa
    //     barre noire y sont ceux du panneau réglementaire, pas la simplification dessinée.
    //     Voir `Tools/photo-panneau.py` et `Tools/images.md`.

    // MARK: Panneaux d'indication (type C) — carré

    // 12. `panneau-c1a-parking` a existé ici, carré bleu et P dessinés. Remplacée par une
    //     photographie Commons le 2026-09-22 (tâche 3A-3). Voir `Tools/photo-panneau.py`
    //     et `Tools/images.md`.

    // 13. `panneau-c113-voie-velo` a existé ici, carré bleu et bicyclette dessinés.
    //     Remplacée par une photographie Commons le 2026-09-22 (tâche 3A-3) : le vélo
    //     dessiné était les six traits de `silhouetteVelo`, là où la vraie bicyclette du
    //     panneau est un pictogramme plein. Voir `Tools/photo-panneau.py` et
    //     `Tools/images.md`.

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
        // Vous, dans la voie qui se termine — à gauche, puisque les flèches s'infléchissent
        // vers la droite — et non déjà dans celle qu'elles désignent : sinon « rejoindre la
        // voie qu'il désigne » ne vous imposerait rien, la manœuvre serait déjà faite. La
        // position sort de la bande centrale ; ce sont les flèches qui portent la réponse,
        // la voiture ne fait que rendre la manœuvre nécessaire plutôt qu'accomplie.
        let voieQuiSeTermine = cx - 63.0
        voiture(ctx, x: voieQuiSeTermine, y: 262, cap: .nord, couleur: p.vous,
                liseree: true, p)
    }),

    // 16. Zébras : une zone non circulable au milieu de la chaussée, délimitée par deux
    //     continues de 3u et couverte de hachures blanches « inclinées à 2 parallèlement
    //     à la rive pour 1 perpendiculairement » (7e partie, art. 117-2 A — numérotée
    //     « 117 A » dans une édition antérieure de l'IISR, même texte). Cette zone sépare
    //     deux sens opposés : la voiture d'en face descend, la vôtre monte. L'article est
    //     explicite sur ce cas précis — « Aux points de convergence ou de divergence, les
    //     hachures se présentent donc sous forme de chevrons convenablement orientés
    //     (pointe toujours dirigée vers le conducteur) » — donc **pas** une pente unique :
    //     une pente unique ramènerait un des deux sens vers l'axe de l'AUTRE voie. Chaque
    //     chevron est symétrique par rapport à l'axe de la zone (la bissectrice de
    //     l'article), une moitié par sens, chacune à la pente 2 pour 1 de la norme.
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
            // Chaque bras : 26 unités en travers pour 52 dans l'axe — la même pente
            // 2 pour 1 que l'ancienne ligne unique, appliquée séparément à chaque moitié
            // pour que les deux sens reçoivent chacun l'inclinaison qui les ramène vers
            // leur propre axe, au lieu d'une seule pente valable pour un seul des deux.
            ctx.addLine(to: CGPoint(x: cx, y: y - 52))
            ctx.addLine(to: CGPoint(x: droite, y: y))
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
