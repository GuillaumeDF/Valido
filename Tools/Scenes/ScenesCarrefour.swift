import CoreGraphics

// MARK: - Le giratoire, dessiné une fois

/// Rayon extérieur de l'anneau.
private let rayonAnneau = 72.0

/// Le giratoire nu : quatre branches, l'anneau posé par-dessus le croisement, l'îlot
/// central. Extrait quand une deuxième scène en a eu besoin — l'anneau porte la règle,
/// il se dessine une fois.
private func giratoireNu(_ ctx: CGContext, _ p: Palette) {
    fond(ctx, p)
    chausseeHorizontale(ctx, p)
    chausseeVerticale(ctx, p)
    axeHorizontal(ctx, p)
    axeVertical(ctx, p)
    let r = rayonAnneau
    ctx.setFillColor(p.chaussee)
    ctx.fillEllipse(in: CGRect(x: cx - r, y: cy - r, width: r * 2, height: r * 2))
    ctx.setFillColor(p.ilot)
    ctx.fillEllipse(in: CGRect(x: cx - 32, y: cy - 32, width: 64, height: 64))
    ctx.setStrokeColor(p.marquage)
    ctx.setLineWidth(2)
    ctx.setLineDash(phase: 0, lengths: [7, 7])
    ctx.strokeEllipse(in: CGRect(x: cx - r, y: cy - r, width: r * 2, height: r * 2))
    ctx.setLineDash(phase: 0, lengths: [])
}

/// Le giratoire d'insertion : un véhicule déjà engagé sur l'anneau, le candidat qui
/// s'apprête à s'y engager. Partagé par `rond-point-insertion` et `giratoire-sans-panneau`
/// (tâche 4B) : `panneau` est toute la différence entre les deux — avec lui, un
/// cédez-le-passage donne la priorité au véhicule déjà sur l'anneau et sa flèche dit qu'il
/// passe ; sans lui, c'est l'entrant qui aurait la priorité, et laisser la flèche
/// répondrait à sa place. La scène sans panneau pose donc la question sans y répondre : ni
/// panneau, ni flèche sur l'anneau — voir `Tools/images.md` pour la boîte de différence
/// que ce choix ouvre.
private func giratoireInsertion(_ ctx: CGContext, panneau: Bool, _ p: Palette) {
    giratoireNu(ctx, p)
    let r = rayonAnneau
    if panneau {
        panneauCedez(ctx, at: CGPoint(x: cx + voie + 26, y: cy + r + 18), p)
    }
    voiture(ctx, x: voieVous, y: cy + r + demiVoiture, cap: .nord, couleur: p.vous,
            liseree: true, p)
    // Déjà sur l'anneau, et c'est tout l'enjeu : on circule en France dans le sens
    // antihoraire, donc le véhicule qui coupe la route du candidat arrive **par sa
    // gauche**, à neuf heures, en descendant vers la branche sud.
    voiture(ctx, x: cx - 52, y: cy - 6, cap: .sud, couleur: p.autre, p)
    if panneau {
        fleche(ctx, [CGPoint(x: cx - 52, y: cy + 20), CGPoint(x: cx - 34, y: cy + 46),
                     CGPoint(x: cx - 6, y: cy + 56)], couleur: p.autre)
    }
}

// MARK: - Le tramway et les accès privés, partagés par plusieurs scènes

/// La rame de tramway en approche par la gauche du candidat, et sa flèche de mouvement.
/// Posée à cheval sur l'axe de la chaussée : une plateforme de tramway occupe le milieu de
/// la rue, pas une voie de circulation. Partagée par `carrefour-tramway` et
/// `tramway-hors-intersection` — même rame, même côté, par cohérence visuelle entre les
/// deux cartes plutôt que par nécessité : hors intersection, aucune priorité à droite ne
/// rendrait un côté plus parlant que l'autre.
private func tramwayEnApproche(_ ctx: CGContext, _ p: Palette) {
    tramway(ctx, x: cx - voie - 46, y: cy, cap: .est, couleur: p.tiers, p)
    fleche(ctx, [CGPoint(x: cx - voie + 8, y: cy), CGPoint(x: cx + voie + 4, y: cy)],
           couleur: p.tiers)
}

/// Un accès privé étroit — parking, station-service, propriété — débouchant sur la
/// chaussée en section courante : plus étroit qu'une voie, sans marquage, et qui ne
/// rejoint le bord du cadre que d'un seul côté, pour ne pas se lire comme une rue
/// perpendiculaire. Partagé par `tourne-a-gauche-hors-intersection` et
/// `sortie-de-parking` : les deux cartes interrogent la même famille de règle — la
/// priorité à droite ne joue qu'entre voies de même nature, un accès privé n'en est pas
/// une.
private func accesPrive(_ ctx: CGContext, y: Double, largeur: Double, _ p: Palette) {
    ctx.setFillColor(p.chaussee)
    ctx.fill(CGRect(x: 0, y: y - largeur / 2, width: cx - voie, height: largeur))
}

// MARK: - Le feu et le panneau qui se contredisent, partagé par deux scènes

/// Le croisement nu de la scène 1, un tricolore planté au-delà du candidat et un second
/// signal sur son approche. `feu` isole l'état des trois lentilles, `panneau` la fonction
/// qui dessine le signal d'approche (`panneauStop` en scène 13, `panneauCedez` en scène 16) :
/// c'est tout ce que les deux scènes font varier, au même point — la disposition, le
/// véhicule et sa flèche restent ceux de la scène 1.
private func carrefourFeuEtPanneau(_ ctx: CGContext, feu: [Lentille],
                                    panneau: (CGContext, CGPoint, Palette) -> Void,
                                    _ p: Palette) {
    croisementNu(ctx, p)
    feuTricolore(ctx, at: CGPoint(x: cx + voie + 20, y: cy - voie - 26), feu, p)
    panneau(ctx, CGPoint(x: cx + voie + 24, y: cy + voie + 22), p)
    voiture(ctx, x: voieVous, y: seuilSud, cap: .nord, couleur: p.vous, liseree: true, p)
    fleche(ctx, [CGPoint(x: voieVous, y: cy + voie - 6), CGPoint(x: voieVous, y: cy - voie + 8)],
           couleur: p.vous)
}

// MARK: - Le croisement en pente, vu de profil

// Seule scène du dossier dessinée **de côté**, et ce n'est pas un caprice de cadrage :
// une pente ne se voit pas en vue aérienne. Or c'est le sens de la déclivité — qui monte,
// qui descend — qui décide de la réponse ; la vue de profil est le seul cadrage qui le
// porte. Les deux véhicules restent au centre vertical, comme partout ailleurs.
private let penteHaut = 108.0, penteBas = 200.0
private func altitudeRoute(_ x: Double) -> Double {
    penteHaut + (x / W) * (penteBas - penteHaut)
}
/// L'inclinaison de la chaussée, en radians : les véhicules s'y posent avec.
private let anglePente = atan2(penteBas - penteHaut, W)

// MARK: - Les scènes

let scenesCarrefour: [(String, Scene)] = [

    // 1. Priorité à droite pure : aucun panneau, aucun marquage. La seule règle qui joue.
    ("carrefour-priorite-droite", { ctx, p in
        croisementNu(ctx, p)
        voiture(ctx, x: voieVous, y: seuilSud, cap: .nord, couleur: p.vous, liseree: true, p)
        fleche(ctx, [CGPoint(x: voieVous, y: cy + voie - 6), CGPoint(x: voieVous, y: cy - voie + 8)],
               couleur: p.vous)
        voiture(ctx, x: seuilEst, y: voieDepuisLaDroite, cap: .ouest, couleur: p.autre, p)
        fleche(ctx, [CGPoint(x: cx + voie - 6, y: voieDepuisLaDroite),
                     CGPoint(x: cx - voie + 8, y: voieDepuisLaDroite)], couleur: p.autre)
    }),

    // 2. STOP sur l'approche du candidat, ligne d'arrêt continue à l'appui.
    ("carrefour-stop", { ctx, p in
        croisementNu(ctx, p)
        ligneDArret(ctx, p)
        panneauStop(ctx, at: CGPoint(x: cx + voie + 24, y: cy + voie + 22), p)
        voiture(ctx, x: voieVous, y: seuilSud + 4, cap: .nord, couleur: p.vous, liseree: true, p)
        voiture(ctx, x: seuilOuest, y: voieDepuisLaGauche, cap: .est, couleur: p.autre, p)
        fleche(ctx, [CGPoint(x: cx - voie + 6, y: voieDepuisLaGauche),
                     CGPoint(x: cx + voie - 8, y: voieDepuisLaGauche)], couleur: p.autre)
    }),

    // 3. Cédez le passage : même situation que le STOP, marquage discontinu à la place du
    //    continu. C'est exactement la confusion que la question fait travailler.
    ("carrefour-cedez-le-passage", { ctx, p in
        croisementNu(ctx, p)
        ligneDeCedez(ctx, p)
        panneauCedez(ctx, at: CGPoint(x: cx + voie + 26, y: cy + voie + 22), p)
        voiture(ctx, x: voieVous, y: seuilSud + 4, cap: .nord, couleur: p.vous, liseree: true, p)
        fleche(ctx, [CGPoint(x: voieVous, y: cy + voie - 6), CGPoint(x: voieVous, y: cy - voie + 8)],
               couleur: p.vous)
    }),

    // 4. Même carrefour que la scène 1, un panneau en plus, réponse inverse. C'est la
    //    paire qui fait travailler la règle : la priorité à droite n'est le défaut que
    //    quand rien ne la remplace.
    ("carrefour-route-prioritaire", { ctx, p in
        croisementNu(ctx, p)
        panneauRoutePrioritaire(ctx, at: CGPoint(x: cx + voie + 26, y: cy + voie + 24), p)
        voiture(ctx, x: voieVous, y: seuilSud + 6, cap: .nord, couleur: p.vous, liseree: true, p)
        fleche(ctx, [CGPoint(x: voieVous, y: cy + voie - 6), CGPoint(x: voieVous, y: cy - voie + 8)],
               couleur: p.vous)
        voiture(ctx, x: seuilEst, y: voieDepuisLaDroite, cap: .ouest, couleur: p.autre, p)
        fleche(ctx, [CGPoint(x: cx + voie - 6, y: voieDepuisLaDroite),
                     CGPoint(x: cx - voie + 8, y: voieDepuisLaDroite)], couleur: p.autre)
    }),

    // 5. Carrefour en T sans aucun panneau. La réponse est contre-intuitive et c'est tout
    //    l'intérêt : le véhicule qui vient de la gauche du candidat doit lui céder le
    //    passage, alors même qu'il roule sur la route qui traverse.
    ("carrefour-en-t", { ctx, p in
        fond(ctx, p)
        chausseeHorizontale(ctx, p)
        chausseeSud(ctx, p)
        axeHorizontal(ctx, p)
        axeSud(ctx, p)
        voiture(ctx, x: voieVous, y: seuilSud, cap: .nord, couleur: p.vous, liseree: true, p)
        // Le candidat tourne à droite : il rejoint la voie de droite, celle qui va vers
        // l'est — donc exactement celle qu'occupe déjà le véhicule venant de sa gauche.
        // C'est ce recouvrement qui montre le conflit.
        fleche(ctx, [CGPoint(x: voieVous, y: cy + voie - 6),
                     CGPoint(x: voieVous, y: voieDepuisLaGauche),
                     CGPoint(x: cx + voie + 34, y: voieDepuisLaGauche)], couleur: p.vous)
        voiture(ctx, x: seuilOuest, y: voieDepuisLaGauche, cap: .est, couleur: p.autre, p)
        fleche(ctx, [CGPoint(x: cx - voie + 6, y: voieDepuisLaGauche),
                     CGPoint(x: cx - 6, y: voieDepuisLaGauche)], couleur: p.autre)
    }),

    // 6. Insertion sur un giratoire, un véhicule déjà engagé sur l'anneau.
    ("rond-point-insertion", { ctx, p in giratoireInsertion(ctx, panneau: true, p) }),

    // 7. Le même croisement que la scène 1, avec deux feux éteints. La paire dit ce que
    //    la question fait travailler : un feu hors service ne prescrit plus rien, et la
    //    règle qui reprend est celle du croisement nu. Réponse identique à la scène 1,
    //    par un chemin différent — c'est le pendant de la scène 4, où l'ajout d'un
    //    panneau inversait la réponse.
    ("carrefour-feu-en-panne", { ctx, p in
        croisementNu(ctx, p)
        // Deux têtes en diagonale, comme sur un vrai carrefour : celle qui vous fait face
        // et celle de l'approche opposée. Une seule laisserait douter d'un carrefour à
        // feux.
        feuHorsService(ctx, at: CGPoint(x: cx + voie + 20, y: cy + voie + 26), p)
        feuHorsService(ctx, at: CGPoint(x: cx - voie - 20, y: cy - voie - 26), p)
        voiture(ctx, x: voieVous, y: seuilSud, cap: .nord, couleur: p.vous, liseree: true, p)
        fleche(ctx, [CGPoint(x: voieVous, y: cy + voie - 6), CGPoint(x: voieVous, y: cy - voie + 8)],
               couleur: p.vous)
        voiture(ctx, x: seuilEst, y: voieDepuisLaDroite, cap: .ouest, couleur: p.autre, p)
        fleche(ctx, [CGPoint(x: cx + voie - 6, y: voieDepuisLaDroite),
                     CGPoint(x: cx - voie + 8, y: voieDepuisLaDroite)], couleur: p.autre)
    }),

    // 8. Voie ferrée en travers du carrefour, tramway arrivant par la **gauche** du
    //    candidat. Le côté est choisi : par la droite, priorité à droite et priorité du
    //    tramway diraient la même chose et la question ne travaillerait rien. Par la
    //    gauche, l'intuition du candidat est prise à contre-pied.
    ("carrefour-tramway", { ctx, p in
        fond(ctx, p)
        chausseeHorizontale(ctx, p)
        chausseeVerticale(ctx, p)
        axeVertical(ctx, p)
        railsHorizontaux(ctx, p)
        voiture(ctx, x: voieVous, y: seuilSud, cap: .nord, couleur: p.vous, liseree: true, p)
        fleche(ctx, [CGPoint(x: voieVous, y: cy + voie - 6), CGPoint(x: voieVous, y: cy - voie + 8)],
               couleur: p.vous)
        tramwayEnApproche(ctx, p)
    }),

    // 9. Croisement difficile sur une forte déclivité, vu de profil. Le panneau A16 et son
    //    panonceau ne sont pas du décor : l'article R414-3 ne joue que sur les routes de
    //    montagne et à forte déclivité, et c'est l'image qui doit dire qu'on y est.
    ("croisement-en-pente", { ctx, p in
        fond(ctx, p)
        // Le versant sous la chaussée : il donne l'échelle et fait lire une route taillée
        // dans la pente plutôt qu'un trait oblique.
        let versant = CGMutablePath()
        versant.move(to: CGPoint(x: 0, y: altitudeRoute(0) + 18))
        versant.addLine(to: CGPoint(x: W, y: altitudeRoute(W) + 18))
        versant.addLine(to: CGPoint(x: W, y: H))
        versant.addLine(to: CGPoint(x: 0, y: H))
        versant.closeSubpath()
        ctx.setFillColor(p.ilot)
        ctx.addPath(versant)
        ctx.fillPath()
        // Une seule voie, sans axe médian : c'est ce qui rend le croisement impossible.
        ctx.setLineCap(.butt)
        ctx.setStrokeColor(p.chaussee)
        ctx.setLineWidth(36)
        ctx.beginPath()
        ctx.move(to: CGPoint(x: 0, y: altitudeRoute(0)))
        ctx.addLine(to: CGPoint(x: W, y: altitudeRoute(W)))
        ctx.strokePath()
        // Bande de rive côté aval, du côté du vide.
        ctx.setStrokeColor(p.marquage)
        ctx.setLineWidth(2.5)
        ctx.beginPath()
        ctx.move(to: CGPoint(x: 0, y: altitudeRoute(0) + 15))
        ctx.addLine(to: CGPoint(x: W, y: altitudeRoute(W) + 15))
        ctx.strokePath()
        // À x=110, l'ensemble panneau + panonceau tient entre y≈81 et y≈119 : encore avant
        // vous sur la pente, mais dans la bande centrale qui survit au recadrage du
        // bandeau à 18 % — la version d'origine (y≈38-90) en sortait par le haut. Le
        // centre est descendu de 95 à 98 et le rayon monté de 17 à 19 le 2026-08-24 : le
        // triangle est devenu équilatéral, donc plus haut au-dessus de son centre (1 rayon
        // contre 0,95) mais aussi plus étroit (côté 1,73 rayon contre 2,0). À 19, il
        // retrouve exactement l'encombrement qu'il avait, dans une géométrie juste.
        panneauDescenteDangereuse(ctx, 12, at: CGPoint(x: 110, y: 98), rayon: 19, p)
        // Vous descendez — liseré blanc — et un véhicule monte à votre rencontre.
        voitureDeProfil(ctx, x: 160, y: altitudeRoute(160) - 4, pente: anglePente,
                        versLaDroite: true, couleur: p.vous, liseree: true, p)
        fleche(ctx, [CGPoint(x: 190, y: altitudeRoute(190) - 26),
                     CGPoint(x: 214, y: altitudeRoute(214) - 26)], couleur: p.vous)
        voitureDeProfil(ctx, x: 250, y: altitudeRoute(250) - 4, pente: anglePente,
                        versLaDroite: false, couleur: p.autre, liseree: false, p)
        // Les deux flèches du même côté de la chaussée, pointées l'une vers l'autre :
        // c'est ce face-à-face qui dit qu'il n'y a pas la place.
        fleche(ctx, [CGPoint(x: 306, y: altitudeRoute(306) - 26),
                     CGPoint(x: 282, y: altitudeRoute(282) - 26)], couleur: p.autre)
    }),

    // 10. Sortie de giratoire : vous êtes **déjà** sur l'anneau, une branche s'ouvre avant
    //     celle que vous prenez, et un véhicule attend à l'entrée de votre sortie. Les
    //     trois éléments sont nécessaires : sans la branche intermédiaire, « après la
    //     sortie qui précède » ne désigne rien ; sans le véhicule qui attend, le
    //     clignotant n'a personne à renseigner.
    ("giratoire-sortie-clignotant", { ctx, p in
        giratoireNu(ctx, p)
        let r = rayonAnneau
        // L'entrée de la branche du haut : le cédez-le-passage est à la droite de qui
        // descend vers l'anneau, donc à l'ouest.
        panneauCedez(ctx, at: CGPoint(x: cx - voie - 26, y: cy - r - 18), p)
        voiture(ctx, x: cx - voie / 2, y: cy - r - demiVoiture, cap: .sud, couleur: p.autre, p)
        // Vous, sur l'anneau côté est, avant la branche de droite. On circule dans le sens
        // antihoraire : la sortie du haut vient après celle de droite.
        voiture(ctx, x: cx + 52, y: cy + 26, cap: .nord, couleur: p.vous, liseree: true, p)
        // La trajectoire longe l'anneau avant de sortir : découpée en quatre segments, elle
        // épouse la courbe assez pour qu'on voie qu'elle **passe devant** la branche de
        // droite au lieu de la prendre.
        fleche(ctx, [CGPoint(x: cx + 53, y: cy + 8), CGPoint(x: cx + 49, y: cy - 23),
                     CGPoint(x: cx + 31, y: cy - 44), CGPoint(x: cx + voie / 2, y: cy - 76),
                     CGPoint(x: cx + voie / 2, y: cy - r - 26)], couleur: p.vous)
    }),

    // Les cinq scènes de configuration de la tâche 4B (2026-09-23).

    // 11. Le même giratoire que la scène 6, sans le panneau — voir `giratoireInsertion`.
    //     Sans signalisation, un giratoire relève de la priorité à droite ordinaire, et
    //     c'est l'entrant qui passe : exactement l'inverse de la scène 6.
    ("giratoire-sans-panneau", { ctx, p in giratoireInsertion(ctx, panneau: false, p) }),

    // 12. La même règle que la scène 8 (`carrefour-tramway`), hors intersection : aucune
    //     chaussée ne croise celle-ci, seuls les rails traversent une route à double sens
    //     en section courante — voir `tramwayEnApproche`. La priorité du tramway ne tient
    //     pas à un carrefour, et c'est ce que la carte interroge.
    ("tramway-hors-intersection", { ctx, p in
        fond(ctx, p)
        chausseeVerticale(ctx, p)
        axeVertical(ctx, p)
        railsHorizontaux(ctx, p)
        voiture(ctx, x: voieVous, y: seuilSud, cap: .nord, couleur: p.vous, liseree: true, p)
        fleche(ctx, [CGPoint(x: voieVous, y: cy + voie - 6), CGPoint(x: voieVous, y: cy - voie + 8)],
               couleur: p.vous)
        tramwayEnApproche(ctx, p)
    }),

    // 13. Même croisement que la scène 1, feu du candidat allumé au **vert** — lampe du
    //     bas, la position qui la distingue sans teinte — et, sur son approche, un STOP
    //     qui ordonne l'inverse. Le feu, réglage le plus récent des deux, l'emporte sur le
    //     panneau, réglage permanent — sauf jaune clignotant, qui n'attribue lui-même
    //     aucune priorité et laisse justement les panneaux trancher.
    ("carrefour-feu-contre-panneau", { ctx, p in
        carrefourFeuEtPanneau(ctx, feu: [.eteinte, .eteinte, .allumee],
                              panneau: { c, pt, pal in panneauStop(c, at: pt, pal) }, p)
    }),

    // 14. Un tourne-à-gauche vers un accès riverain, hors de toute intersection réglée —
    //     voir `accesPrive`. Le candidat traverse la voie opposée pour l'atteindre, d'où le
    //     véhicule qui vient en face : c'est à lui, et non à un vis-à-vis de carrefour,
    //     qu'il doit céder le passage.
    ("tourne-a-gauche-hors-intersection", { ctx, p in
        fond(ctx, p)
        chausseeVerticale(ctx, p)
        axeVertical(ctx, p)
        accesPrive(ctx, y: cy, largeur: 30, p)
        voiture(ctx, x: voieVous, y: cy + 34, cap: .nord, couleur: p.vous, liseree: true, p)
        fleche(ctx, [CGPoint(x: voieVous, y: cy + 14), CGPoint(x: voieVous, y: cy),
                     CGPoint(x: cx - voie - 20, y: cy)], couleur: p.vous)
        voiture(ctx, x: voieDenFace, y: cy - 70, cap: .sud, couleur: p.autre, p)
        fleche(ctx, [CGPoint(x: voieDenFace, y: cy - 50), CGPoint(x: voieDenFace, y: cy - 20)],
               couleur: p.autre)
    }),

    // 15. Le symétrique de la scène précédente : le candidat sort d'un accès identique
    //     pour rejoindre la chaussée. La priorité à droite ne joue qu'entre voies de même
    //     nature — la carte fondation de la règle que les scènes 14 et 15 partagent.
    ("sortie-de-parking", { ctx, p in
        fond(ctx, p)
        chausseeVerticale(ctx, p)
        axeVertical(ctx, p)
        accesPrive(ctx, y: cy + 40, largeur: 30, p)
        voiture(ctx, x: cx - voie - 34, y: cy + 40, cap: .est, couleur: p.vous, liseree: true, p)
        fleche(ctx, [CGPoint(x: cx - voie - 10, y: cy + 40), CGPoint(x: voieDenFace, y: cy + 40)],
               couleur: p.vous)
        voiture(ctx, x: voieDenFace, y: cy - 70, cap: .sud, couleur: p.autre, p)
        fleche(ctx, [CGPoint(x: voieDenFace, y: cy - 50), CGPoint(x: voieDenFace, y: cy - 6)],
               couleur: p.autre)
    }),

    // La scène 16 (tâche 5A, 2026-09-23).

    // 16. Le pendant de la scène 13 : même croisement, même véhicule, même flèche — voir
    //     `carrefourFeuEtPanneau`. Deux différences, et deux seulement : le feu passe au
    //     jaune clignotant (lampe du milieu, sans priorité propre) et le STOP devient un
    //     cédez-le-passage. Un STOP y rendrait vraie l'option D de la carte (« impose en
    //     plus un arrêt avant la ligne d'effet »), qui aurait alors deux bonnes réponses.
    ("carrefour-feu-jaune-cedez", { ctx, p in
        carrefourFeuEtPanneau(ctx, feu: [.eteinte, .clignotante, .eteinte],
                              panneau: { c, pt, pal in panneauCedez(c, at: pt, pal) }, p)
    }),
]
