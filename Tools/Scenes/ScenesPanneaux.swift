import CoreGraphics

// MARK: - Marquage et configurations de route
//
// Les panneaux enseignés pour eux-mêmes sont photographiés (voir `Tools/images.md`) : ce
// fichier ne dessine plus qu'un marquage au sol ou une configuration de chaussée.

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

/// Une flèche de rabattement peinte au sol. Rien à voir avec la flèche d'intention des
/// scènes de carrefour : celle-ci est une **marque**, donc blanche, large, et couchée dans
/// l'axe avant de s'infléchir vers la voie à emprunter. C'est la même primitive `fleche`,
/// à cinq fois l'épaisseur.
private func flecheDeRabattement(_ ctx: CGContext, x: Double, y: Double, _ p: Palette) {
    fleche(ctx, [CGPoint(x: x - 11, y: y + 18), CGPoint(x: x - 11, y: y + 1),
                 CGPoint(x: x + 10, y: y - 20)], couleur: p.marquage, epaisseur: 8)
}

/// Une ligne discontinue générique : un trait de 15 unités, répété tous les `cycle`
/// unités. T1, T2 et T3 ne sont que trois valeurs de ce paramètre — les regrouper met les
/// trois cycles côte à côte, ce qu'on relit contre la table de l'IISR, plutôt que trois
/// corps de boucle recopiés qui ne diffèrent que d'une constante.
private func ligneModulee(_ ctx: CGContext, x: Double, de y0: Double, a y1: Double,
                          largeur: Double, cycle: Double, _ p: Palette) {
    ctx.setFillColor(p.marquage)
    var y = y0
    while y < y1 {
        ctx.fill(CGRect(x: x - largeur / 2, y: y, width: largeur, height: min(15, y1 - y)))
        y += cycle
    }
}

/// Une ligne discontinue de type T3 : « à forte prédominance des pleins sur les vides »
/// (7e partie, art. 113, A), modulation 3 m de trait pour 1,33 m d'intervalle. C'est elle
/// qui annonce une ligne continue, et c'est aussi elle qui double la continue dans une
/// ligne mixte.
private func ligneT3(_ ctx: CGContext, x: Double, de y0: Double, a y1: Double,
                     largeur: Double, _ p: Palette) {
    ligneModulee(ctx, x: x, de: y0, a: y1, largeur: largeur, cycle: 27, p)
}

/// Une ligne discontinue de type T1 : « 3 m de trait, 10 m d'intervalle », rapport
/// plein/vide 1/3 (7e partie, art. 113-1, B) — la modulation de l'axe en rase campagne,
/// hors point singulier (art. 113-2 ; art. 114, 114-1, 114-2). Les vides dominent, à
/// l'inverse d'une T3 comme celle de `marquage-fleches-rabattement`, qui annonce une
/// continue. Même cycle que `ligneAxialeT1` de `ScenesCirculation.swift` (15 et 65
/// unités) : deux fichiers, la même norme.
private func ligneT1(_ ctx: CGContext, x: Double, de y0: Double, a y1: Double,
                     largeur: Double, _ p: Palette) {
    ligneModulee(ctx, x: x, de: y0, a: y1, largeur: largeur, cycle: 65, p)
}

/// Une ligne discontinue de type T2 : « 3 m de trait, 3,5 m d'intervalle » (7e partie,
/// art. 113-1, B) — la modulation de la ligne de rive en section courante sur route, hors
/// autoroute : « Sur route, la ligne de rive est de type T2 et de largeur 3u » (art. 114-4,
/// A). L'autoroute marque sa bande d'arrêt d'urgence en T4, pas en T2 — voir
/// `autoroute-voie-de-gauche` dans `images.md`. À la même échelle que `ligneT1` ci-dessus
/// (5 unités par mètre), 3 m et 3,5 m valent 15 et 17,5 unités.
private func ligneT2(_ ctx: CGContext, x: Double, de y0: Double, a y1: Double,
                     largeur: Double, _ p: Palette) {
    ligneModulee(ctx, x: x, de: y0, a: y1, largeur: largeur, cycle: 32.5, p)
}

/// Le marquage qui distingue les trois scènes de ligne ci-dessous : seul ce paramètre
/// change d'une scène à l'autre, tout le reste — chaussée, cadrage, absence de véhicule —
/// est partagé par `sceneLigne`. Cf. `images.md`, « La paire de lignes jaunes » : deux
/// cartes d'une même notion qui se distinguent par autre chose que ce qu'elles enseignent
/// font apprendre l'écart, pas la règle.
private enum MarquageDeLigne { case continueAxiale, discontinueAxialeT1, discontinueRiveT2 }

private func sceneLigne(_ marquage: MarquageDeLigne) -> Scene {
    { ctx, p in
        chausseeDeMarquage(ctx, p)
        switch marquage {
        case .continueAxiale:
            ligneContinue(ctx, x: cx, de: 0, a: H, largeur: 5, p)
        case .discontinueAxialeT1:
            ligneT1(ctx, x: cx, de: 0, a: H, largeur: 5, p)
        case .discontinueRiveT2:
            ligneContinue(ctx, x: cx, de: 0, a: H, largeur: 5, p)
            // La rive droite de `chausseeDeMarquage` est continue par défaut : on l'efface
            // à la couleur de la chaussée avant d'y poser la T2, seul endroit où cette
            // scène diffère des deux précédentes.
            let riveDroite = bordDroitChaussee - 7 + 1.5
            ctx.setFillColor(p.chaussee)
            ctx.fill(CGRect(x: riveDroite - 1.5, y: 0, width: 3, height: H))
            ligneT2(ctx, x: riveDroite, de: 0, a: H, largeur: 3, p)
        }
    }
}

/// La zone de chevrons, sans véhicule : partagée par les deux scènes qui la montrent, celle
/// où l'on circule de part et d'autre et celle où un véhicule s'y arrête — c'est cette
/// occupation-là que la seconde interroge, la zone qui la porte doit donc être la même.
private func zoneChevrons(_ ctx: CGContext, _ p: Palette) {
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
        // Chaque bras : 26 unités en travers pour 52 dans l'axe — la même pente 2 pour 1
        // que l'ancienne ligne unique, appliquée séparément à chaque moitié pour que les
        // deux sens reçoivent chacun l'inclinaison qui les ramène vers leur propre axe, au
        // lieu d'une seule pente valable pour un seul des deux (art. 117-2, A, 7e partie).
        ctx.addLine(to: CGPoint(x: cx, y: y - 52))
        ctx.addLine(to: CGPoint(x: droite, y: y))
        ctx.strokePath()
        y += 26
    }
    ctx.restoreGState()
}

// MARK: - Les trois types de route hors agglomération
//
// Trois fondations de `Vitesse` décrivent en mots une configuration de chaussée dont la
// vitesse par défaut hors agglomération dépend entièrement : une voie par sens, deux voies
// dans le sens du candidat sans terre-plein, ou deux chaussées séparées par un terre-plein
// central. Ce qui les distingue est la chaussée et rien d'autre — même raisonnement que
// `sceneLigne` plus haut pour les trois lignes de la tâche 3B-1 : une seule fonction, la
// configuration en paramètre, `ligneT1` et `ligneContinue` réutilisées telles quelles.
//
// **La voie du candidat, sa voiture et tout ce qui est à sa droite restent au même point
// dans les trois.** C'est elle qui reste fixe, à droite ; la chaussée s'étend vers la
// gauche à mesure que la configuration se charge, jusqu'à deux voies de plus et un
// terre-plein pour la troisième. Aucun panneau : la carte demande la limite par défaut, un
// panneau y répondrait déjà.
//
// **Un véhicule d'en face, dans la voie la plus à gauche, toujours cap sud.** Sans lui,
// rien ne dit dans quel sens on roule au-delà du T1 posé à `voieCandidat` : la même
// modulation sépare deux sens dans la première scène et deux voies du même sens dans les
// deux suivantes (c'est l'IISR, pas un choix de dessin — art. 114 et 114-2, C citées plus
// bas), si bien que `route-double-sens`, vue seule, se lirait aussi bien comme
// `route-deux-voies-par-sens`. Ce véhicule n'est pas du décor : à retirer, l'ambiguïté
// revient.
//
// Échelle et largeur de voie : celles de `depassement-ligne-discontinue`
// (`ScenesCirculation.swift`) — 16 unités par mètre, voie de 56 unités pour 3,50 m. Le T1,
// posé au même `x` (`routeDroite - routeVoie`) dans les trois scènes, y joue deux rôles :
// délimitation de voies du même sens (art. 114-2, C) dans les deux dernières, axe séparant
// les deux sens (art. 114, en rase campagne) dans la première — la même modulation pour un
// rôle différent, exactement ce que `ligneAxialeT1` de `ScenesCirculation.swift` fait déjà en
// partageant son cycle avec `ligneT1` d'ici. Le terre-plein central est bordé de continues
// des deux côtés, « de largeur 3u » (art. 114-4, B, déjà relevé pour
// `autoroute-voie-de-gauche`) ; sa largeur elle-même — 40 unités, 2,5 m — n'est cotée par
// aucun texte de signalisation, une largeur de chaussée étant un fait de conception routière
// et non de l'IISR : retenue pour rester lisible à cette échelle. Aucune ligne de rive :
// elle n'entre dans ce qu'aucune des trois cartes ne distingue, et en ajouter poserait une
// question de plus que l'énoncé ne pose pas — même raisonnement que l'axe absent de
// `croisement-chaussee-etroite`.

private let routeVoie = 56.0
/// Rive droite de la voie du candidat : fixe dans les trois scènes.
private let routeDroite = 328.0
private let routeTerrePlein = 40.0
private let routeY = cy + 4.0
/// Hauteur du véhicule d'en face : décalée de celle du candidat (`routeY`), comme
/// `marquage-ligne-mixte` et `marquage-zebra` décalent déjà leurs deux voitures opposées —
/// deux véhicules à la même hauteur, sur deux voies qui ne sont pas encore visiblement
/// opposées dans la première scène, se liraient comme un face-à-face plutôt que comme une
/// circulation ordinaire.
private let routeYOpposee = 100.0
private let routeYOpposeeLointaine = 30.0

private enum ConfigurationDeRoute {
    case uneVoieParSens, deuxVoiesParSens, chausseesSeparees
    // Tâche 7 : la chaussée à double sens de trois voies de `depassement/manoeuvre`, dont
    // la voie centrale est réservée au dépassement — pas affectée à un sens comme la
    // seconde voie de `deuxVoiesParSens`. Voir `sceneRoute` : seule cette configuration pose
    // un second T1 là où les trois autres posent une continue ou rien.
    case troisVoiesDoubleSens
}

/// Un véhicule à l'échelle de cette famille (16 unités par mètre) : même procédé que
/// `voitureAgrandie` de `ScenesCirculation.swift`, dans un fichier différent — on agrandit
/// le repère plutôt que d'ajouter une seconde géométrie de caisse. Partagée par le candidat
/// et le véhicule d'en face plutôt que dupliquée : seuls `cap`, `couleur` et `liseree`
/// changent d'un appel à l'autre.
private func voitureRoute(_ ctx: CGContext, x: Double, y: Double, cap: Cap, couleur: CGColor,
                          liseree: Bool, _ p: Palette) {
    ctx.saveGState()
    ctx.translateBy(x: x, y: y)
    ctx.scaleBy(x: 1.25, y: 1.25)
    voiture(ctx, x: 0, y: 0, cap: cap, couleur: couleur, liseree: liseree, p)
    ctx.restoreGState()
}

private func sceneRoute(_ configuration: ConfigurationDeRoute) -> Scene {
    { ctx, p in
        fond(ctx, p)
        func poserVoie(_ gauche: Double) {
            ctx.setFillColor(p.chaussee)
            ctx.fill(CGRect(x: gauche, y: 0, width: routeVoie, height: H))
        }
        let voieCandidat = routeDroite - routeVoie
        poserVoie(voieCandidat)

        // Le véhicule d'en face : sans lui, le T1 posé à `voieCandidat` ne dit pas de quel
        // côté on roule — la même modulation sépare deux sens ici et deux voies du même sens
        // dans les deux scènes suivantes, et l'IISR ne donne aucun autre moyen de le
        // distinguer sur le dessin d'une seule voie. Toujours dans la voie la **plus à
        // gauche** de la chaussée, cap sud, sans liseré — seule sa position sur la chaussée
        // change d'une scène à l'autre, jamais sa hauteur ni sa teinte.
        let voieOpposeeLaPlusAGauche: Double
        // Un véhicule lent, dans la voie du candidat : seule `troisVoiesDoubleSens` en pose
        // un, pour la même raison que le véhicule d'en face — c'est lui qui pose la
        // situation de dépassement, sans lui la voie centrale vide ne motive rien.
        var vehiculeLentY: Double?
        var opposeeY = routeYOpposee

        switch configuration {
        case .uneVoieParSens:
            let voieOpposee = voieCandidat - routeVoie
            poserVoie(voieOpposee)
            ligneT1(ctx, x: voieCandidat, de: 0, a: H, largeur: 5, p)
            voieOpposeeLaPlusAGauche = voieOpposee

        case .deuxVoiesParSens:
            let secondeVoie = voieCandidat - routeVoie
            let voieOpposee = secondeVoie - routeVoie
            poserVoie(secondeVoie)
            poserVoie(voieOpposee)
            ligneT1(ctx, x: voieCandidat, de: 0, a: H, largeur: 5, p)
            ligneContinue(ctx, x: secondeVoie, de: 0, a: H, largeur: 5, p)
            voieOpposeeLaPlusAGauche = voieOpposee

        case .chausseesSeparees:
            let secondeVoie = voieCandidat - routeVoie
            poserVoie(secondeVoie)
            ligneT1(ctx, x: voieCandidat, de: 0, a: H, largeur: 5, p)
            let terrePleinDroite = secondeVoie
            let terrePleinGauche = terrePleinDroite - routeTerrePlein
            // `ilot`, déjà réservé au terre-plein de `autoroute-voie-de-gauche`, ne se
            // sépare de `chaussee` que de 5,9 points en niveaux de gris en mode sombre
            // (mesuré avant ce choix) — un ressaut invisible, le même défaut que celui
            // relevé sur `bordure` (`Repere.swift`) quand elle a remplacé `ilot` pour les
            // scènes de stationnement. `bordure` est prise ici pour la même raison : plus
            // de 40 points de la chaussée dans les deux modes, et c'est elle qui porte déjà
            // la mention « pas par le vert » ci-dessus.
            ctx.setFillColor(p.bordure)
            ctx.fill(CGRect(x: terrePleinGauche, y: 0,
                            width: terrePleinDroite - terrePleinGauche, height: H))
            ligneContinue(ctx, x: terrePleinDroite, de: 0, a: H, largeur: 3, p)
            ligneContinue(ctx, x: terrePleinGauche, de: 0, a: H, largeur: 3, p)
            let opposeeVoie1 = terrePleinGauche - routeVoie
            let opposeeVoie2 = opposeeVoie1 - routeVoie
            poserVoie(opposeeVoie1)
            ligneT1(ctx, x: opposeeVoie1, de: 0, a: H, largeur: 5, p)
            poserVoie(opposeeVoie2)
            voieOpposeeLaPlusAGauche = opposeeVoie2

        case .troisVoiesDoubleSens:
            // R414-8 : qui dépasse ne peut pas emprunter la voie la plus à gauche d'une
            // chaussée à double sens de plus de deux voies — elle revient à ceux qui
            // viennent en face. La voie centrale est donc réservée au dépassement, jamais
            // affectée à un sens : art. 114-1 de la 7e partie de l'IISR la borde de deux T1
            // (« comprises dans le tiers central de la chaussée »), pas d'une continue comme
            // `deuxVoiesParSens`, où la seconde voie appartient au candidat.
            let voieMilieu = voieCandidat - routeVoie
            let voieOpposee = voieMilieu - routeVoie
            poserVoie(voieMilieu)
            poserVoie(voieOpposee)
            ligneT1(ctx, x: voieCandidat, de: 0, a: H, largeur: 5, p)
            ligneT1(ctx, x: voieMilieu, de: 0, a: H, largeur: 5, p)
            voieOpposeeLaPlusAGauche = voieOpposee
            vehiculeLentY = 90
            opposeeY = routeYOpposeeLointaine
        }

        voitureRoute(ctx, x: voieOpposeeLaPlusAGauche + routeVoie / 2, y: opposeeY,
                    cap: .sud, couleur: p.autre, liseree: false, p)
        voitureRoute(ctx, x: voieCandidat + routeVoie / 2, y: routeY,
                    cap: .nord, couleur: p.vous, liseree: true, p)
        // Devant le candidat, dans sa voie : sans lui rien n'appelle à dépasser, et la voie
        // centrale vide resterait un fait sans question. `p.tiers` (déjà le troisième
        // véhicule de `croisement-chaussee-etroite`) le distingue du véhicule d'en face.
        if let vehiculeLentY {
            voitureRoute(ctx, x: voieCandidat + routeVoie / 2, y: vehiculeLentY,
                        cap: .nord, couleur: p.tiers, liseree: false, p)
        }
    }
}

// MARK: - Les scènes

let scenesPanneaux: [(String, Scene)] = [

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
        zoneChevrons(ctx, p)
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

    // 18-20. Une même chaussée, une même vue, trois marquages : c'est la paire de lignes
    //        jaunes (voir `images.md`) élargie à trois — si deux cartes d'une même notion
    //        se distinguaient par autre chose que le marquage, c'est cet écart-là qu'on
    //        apprendrait, pas la règle. `sceneLigne` porte donc les trois à la fois ; seul
    //        le paramètre change.

    // 18. Continue seule dans l'axe : « Ligne axiale ou de délimitation des voies »,
    //     continue, 2u (7e partie, art. 113-2, A.1). Aucun véhicule — la carte se limite
    //     au trait, sans qu'une manœuvre vienne s'y ajouter.
    ("marquage-ligne-continue-axiale", sceneLigne(.continueAxiale)),

    // 19. La même chaussée, la même vue : seul l'axe passe en discontinue T1 (art. 113-2,
    //     A.2 ; modulation à l'art. 113-1, B).
    ("marquage-ligne-discontinue-axiale", sceneLigne(.discontinueAxialeT1)),

    // 20. La même chaussée, la même vue : l'axe reste continu, et c'est la rive droite qui
    //     passe en discontinue T2 — « Sur route, la ligne de rive est de type T2 et de
    //     largeur 3u » en section courante (art. 114-4, A). Delimite l'accotement, pas un
    //     sens de circulation : le candidat qui lirait ce trait comme un axe se tromperait
    //     de question.
    ("marquage-ligne-discontinue-rive", sceneLigne(.discontinueRiveT2)),

    // 21. La zone de chevrons de la scène 16, avec un véhicule arrêté dessus au lieu de la
    //     circulation de part et d'autre : c'est cette occupation-là que la carte interroge,
    //     pas la géométrie du marquage, déjà posée par `marquage-zebra`. Asset distinct :
    //     aucun des deux ne sert les deux cartes.
    ("marquage-zebra-vehicule-arrete", { ctx, p in
        zoneChevrons(ctx, p)
        voiture(ctx, x: cx, y: cy, cap: .nord, couleur: p.vous, liseree: true, p)
    }),

    // MARK: Route hors agglomération

    // 22. Une voie par sens, séparées par une seule ligne axiale discontinue T1 (art. 114,
    //     en rase campagne) : la route ordinaire, sans terre-plein ni seconde voie. 80 km/h
    //     par défaut, la limite qui s'applique dès qu'aucune des deux autres configurations
    //     n'est réunie.
    ("route-double-sens", sceneRoute(.uneVoieParSens)),

    // 23. La voie du candidat inchangée, une seconde voie de son sens ajoutée à sa gauche
    //     (T1 la délimite, au même endroit que l'axe de la scène précédente), et une
    //     continue sépare le tout de la voie inverse — restée unique : 90 km/h, sans
    //     terre-plein.
    ("route-deux-voies-par-sens", sceneRoute(.deuxVoiesParSens)),

    // 24. Les deux voies du candidat de la scène précédente inchangées, mais la voie
    //     inverse en gagne une seconde et les deux chaussées se séparent par un terre-plein
    //     central bordé de continues des deux côtés (art. 114-4, B) : 110 km/h.
    ("route-chaussees-separees", sceneRoute(.chausseesSeparees)),

    // MARK: Croisement & dépassement

    // 25. La chaussée à double sens de trois voies de `depassement/manoeuvre` : la voie du
    //     candidat inchangée, un véhicule lent devant lui qui pose la situation, la voie
    //     centrale libre jusqu'à elle, puis un véhicule d'en face loin devant dans la voie
    //     la plus à gauche — restée vide près du candidat, pour que « prenez la voie de
    //     gauche, la plus dégagée » reste un distracteur tentant. Voir `sceneRoute`, cas
    //     `.troisVoiesDoubleSens`, pour la marque à deux T1 qui distingue cette voie
    //     centrale réservée d'une seconde voie affectée à un sens.
    ("route-trois-voies-double-sens", sceneRoute(.troisVoiesDoubleSens)),
]
