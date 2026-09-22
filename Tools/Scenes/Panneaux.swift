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

/// Un panneau se dessine en trois anneaux emboîtés — un listel, une bande, puis le fond —
/// parce que c'est ce qui distingue les familles à l'œil : un triangle de danger est
/// « fond blanc, bande rouge **bordée elle-même par un listel blanc** » (2e partie,
/// art. 23), un panneau d'obligation est « fond bleu, listel et symbole blancs »
/// (4e partie, art. 47), une interdiction n'a qu'une couronne rouge sans listel (même
/// article). Le pictogramme est dessiné par l'appelant, par-dessus.
///
/// `rayon` est le rayon du cercle **circonscrit**, et la géométrie de chaque forme en
/// découle exactement : triangle équilatéral à côté inférieur horizontal (2e partie,
/// art. 21), carré inscrit, octogone régulier. Rien n'est plus réglé à l'œil.
///
/// Les angles des polygones sont arrondis : « Les angles des balises et panneaux
/// polygonaux sont remplacés par des arrondis afin d'éviter les accidents du fait de
/// heurt par un piéton » (1re partie, art. 5-1). L'arrondi est proportionnel au rayon —
/// la norme le fixe en millimètres, mais nos panneaux se dessinent à cinq tailles
/// différentes selon la scène.
func panneau(_ ctx: CGContext, forme: Forme, at pt: CGPoint, rayon: Double,
             fond: CGColor, bord: CGColor? = nil, epaisseurBord: Double = 0,
             listel: CGColor? = nil, epaisseurListel: Double = 0) {
    /// L'arrondi des angles au rayon extérieur. Les chemins intérieurs reçoivent un
    /// arrondi réduit d'autant qu'ils sont rentrés : c'est ainsi qu'un contour parallèle
    /// se comporte, et sans ça la bande rouge paraît plus arrondie que le listel.
    let arrondi = rayon * 0.09

    func chemin(_ r: Double) -> CGPath {
        let path = CGMutablePath()
        if forme == .disque {
            path.addEllipse(in: CGRect(x: pt.x - r, y: pt.y - r, width: r * 2, height: r * 2))
            return path
        }
        return cheminPolygone(sommets(forme, at: pt, rayon: r),
                              arrondi: max(arrondi - (rayon - r), 0))
    }

    var r = rayon
    if let listel, epaisseurListel > 0 {
        ctx.setFillColor(listel)
        ctx.addPath(chemin(r))
        ctx.fillPath()
        r -= epaisseurListel
    }
    if let bord, epaisseurBord > 0 {
        ctx.setFillColor(bord)
        ctx.addPath(chemin(r))
        ctx.fillPath()
        r -= epaisseurBord
    }
    ctx.setFillColor(fond)
    ctx.addPath(chemin(r))
    ctx.fillPath()
}

/// Les sommets d'une forme réglementaire, dans son cercle circonscrit de rayon `r`.
/// Le triangle est **équilatéral** : sommet à la verticale du centre, côté inférieur
/// horizontal (2e partie, art. 21). Les deux autres sommets sont donc à ±120°, soit
/// `±r·√3/2` en abscisse et `+r/2` en ordonnée — et non le `±r` / `+0,72 r` réglé à l'œil
/// que ce fichier portait jusqu'au 2026-08-24.
private func sommets(_ forme: Forme, at pt: CGPoint, rayon r: Double) -> [CGPoint] {
    let demiCote = r * sqrt(3.0) / 2   // 0,866 r : la moitié du côté d'un équilatéral
    switch forme {
    case .disque:
        return []
    case .triangle:
        return [CGPoint(x: pt.x, y: pt.y - r),
                CGPoint(x: pt.x + demiCote, y: pt.y + r / 2),
                CGPoint(x: pt.x - demiCote, y: pt.y + r / 2)]
    case .triangleInverse:
        return [CGPoint(x: pt.x - demiCote, y: pt.y - r / 2),
                CGPoint(x: pt.x + demiCote, y: pt.y - r / 2),
                CGPoint(x: pt.x, y: pt.y + r)]
    case .octogone:
        return (0..<8).map { i -> CGPoint in
            let a = Double(i) * .pi / 4 + .pi / 8
            return CGPoint(x: pt.x + cos(a) * r, y: pt.y + sin(a) * r)
        }
    case .carre:
        // Carré **inscrit** : demi-côté r/√2. L'ancien 0,78 r débordait du cercle
        // circonscrit, ce qui rendait la comparaison de tailles entre formes fausse.
        let c = r / sqrt(2.0)
        return [CGPoint(x: pt.x - c, y: pt.y - c), CGPoint(x: pt.x + c, y: pt.y - c),
                CGPoint(x: pt.x + c, y: pt.y + c), CGPoint(x: pt.x - c, y: pt.y + c)]
    case .losange:
        return [CGPoint(x: pt.x, y: pt.y - r), CGPoint(x: pt.x + r, y: pt.y),
                CGPoint(x: pt.x, y: pt.y + r), CGPoint(x: pt.x - r, y: pt.y)]
    }
}

/// Un polygone fermé dont chaque sommet est remplacé par un arc de rayon `arrondi`.
/// Le tracé démarre au **milieu** du premier côté : `addArc(tangent1End:tangent2End:)`
/// a besoin d'un point courant, et partir d'un milieu de côté garantit qu'aucun sommet
/// n'est sauté.
private func cheminPolygone(_ sommets: [CGPoint], arrondi: Double) -> CGPath {
    let path = CGMutablePath()
    guard sommets.count >= 3 else { return path }
    guard arrondi > 0.4 else {
        path.addLines(between: sommets)
        path.closeSubpath()
        return path
    }
    let n = sommets.count
    path.move(to: CGPoint(x: (sommets[0].x + sommets[1].x) / 2,
                          y: (sommets[0].y + sommets[1].y) / 2))
    for i in 1...n {
        path.addArc(tangent1End: sommets[i % n], tangent2End: sommets[(i + 1) % n],
                    radius: arrondi)
    }
    path.closeSubpath()
    return path
}

/// À gamme égale, la norme ne donne pas la même taille à toutes les formes : en gamme
/// normale, un triangle mesure 1 000 mm de côté, un disque 850 mm de diamètre, un
/// octogone 800 mm entre côtés opposés et un carré 700 mm de côté (1re partie, art. 5-3).
/// Ce facteur convertit une **gamme** — exprimée dans l'unité « côté nominal du
/// triangle » — en rayon du cercle circonscrit de la forme demandée. Deux panneaux
/// dessinés à la même gamme ont donc, d'une scène à l'autre, la taille relative qu'ils
/// ont sur la route : le triangle est le plus grand, le carré le plus petit.
func rayonPourGamme(_ forme: Forme, _ gamme: Double) -> Double {
    switch forme {
    case .triangle, .triangleInverse: return gamme / sqrt(3.0)          // côté 1000
    case .disque:                     return gamme * 0.425             // diamètre 850
    case .octogone:                   return gamme * 0.400 / cos(.pi / 8)  // 800 entre plats
    case .carre, .losange:            return gamme * 0.700 * sqrt(2.0) / 2 // côté 700
    }
}

/// Panonceau de type M : une plaque rectangulaire à fond blanc, **sans listel**
/// (1re partie, art. 9-1, C), placée sous le panneau qu'elle complète. Elle ne prescrit
/// rien par elle-même — « le panonceau est utilisé chaque fois qu'il est nécessaire de
/// donner une ou des informations supplémentaires à celles du signal » (art. 9-1, B).
func panonceau(_ ctx: CGContext, _ inscription: String, at plaque: CGRect, _ p: Palette) {
    ctx.setFillColor(p.panneauFond)
    ctx.fill(plaque)
    ctx.setStrokeColor(p.chaussee)
    ctx.setLineWidth(1)
    ctx.stroke(plaque)
    texte(ctx, inscription, centre: CGPoint(x: plaque.midX, y: plaque.midY),
          taille: plaque.height * 0.55, couleur: p.chaussee)
}

/// AB4, STOP : l'octogone, forme réservée à ce seul panneau dans toute la signalisation
/// française (1re partie, art. 5-1 : « panneaux relatifs aux intersections et notifiant
/// les régimes de priorité : triangulaire (pointe vers le bas), carrée (panneaux placés
/// sur pointe) et **octogonale** »). C'est cette exclusivité qui le rend reconnaissable
/// de dos, sous la neige ou en contre-jour.
func panneauStop(_ ctx: CGContext, at pt: CGPoint, rayon: Double = 15, _ p: Palette) {
    panneau(ctx, forme: .octogone, at: pt, rayon: rayon, fond: p.panneauRouge,
            listel: p.panneauFond, epaisseurListel: max(rayon * 0.055, 1.0))
    texte(ctx, "STOP", centre: pt, taille: rayon * 0.53, couleur: p.panneauFond)
}

/// AB3a, cédez le passage : le triangle **pointe en bas**, l'autre forme triangulaire de
/// la signalisation (1re partie, art. 5-1). La 3e partie ne porte pas d'article de
/// couleurs ; le listel blanc suit celui des triangles de danger (2e partie, art. 23),
/// dont l'AB3a partage la bande rouge.
func panneauCedez(_ ctx: CGContext, at pt: CGPoint, rayon: Double = 19, _ p: Palette) {
    panneau(ctx, forme: .triangleInverse, at: pt, rayon: rayon, fond: p.panneauFond,
            bord: p.panneauRouge, epaisseurBord: rayon * 0.31,
            listel: p.panneauFond, epaisseurListel: max(rayon * 0.05, 0.9))
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

/// Le disque des « fin de » : fond blanc, filet et barre noirs (4e partie, art. 47 :
/// « Les panneaux de fin d'interdiction sont à fond blanc, symbole, inscription, listel
/// et barre noirs »). Partagé par le B31 (fin de toutes les interdictions) et le B33 (fin
/// de limitation de vitesse), qui ne diffèrent que par le nombre porté au centre.
///
/// Le filet est tracé **à l'intérieur** du disque blanc, pas à sa place : posé au bord, il
/// disparaissait sur le fond sombre du mode nuit, et le panneau perdait le cerne qui le
/// distingue d'une pastille blanche.
private func disqueDeFin(_ ctx: CGContext, at pt: CGPoint, rayon: Double, _ p: Palette) {
    let filet = max(rayon * 0.05, 1.5)
    panneau(ctx, forme: .disque, at: pt, rayon: rayon, fond: p.panneauFond)
    ctx.setStrokeColor(encre(p))
    ctx.setLineWidth(filet)
    let cerne = rayon - filet / 2
    ctx.strokeEllipse(in: CGRect(x: pt.x - cerne, y: pt.y - cerne,
                                 width: cerne * 2, height: cerne * 2))
    obliqueDeBarre(ctx, at: pt, rayon: rayon * 0.95, montante: true, couleur: encre(p),
                   epaisseur: rayon * 0.24)
}

/// B33, fin de limitation de vitesse (4e partie, art. 68-2) : le **même** disque que le
/// B14, liseré réduit à un filet et barré d'une oblique montante. Le pendant exact du
/// B14 — même géométrie, réponse inverse — et c'est la paire que le candidat confond
/// réellement.
func panneauFinDeLimitation(_ ctx: CGContext, _ valeur: Int, at pt: CGPoint, rayon: Double,
                            _ p: Palette) {
    disqueDeFin(ctx, at: pt, rayon: rayon, p)
    chiffres(ctx, "\(valeur)", at: pt, taille: rayon * 1.0, halo: true, p)
}

/// B30, entrée d'une zone 30 : un carré à fond blanc bordé de rouge, le mot ZONE en haut
/// et un disque de limitation en dessous. Le carré n'est pas un détail de style — c'est
/// lui qui dit que la prescription est **zonale** : elle vaut pour tout le périmètre, rues
/// sécantes comprises, là où un disque seul ne vaut que sur l'axe où il est planté.
func panneauZone30(_ ctx: CGContext, at pt: CGPoint, demiCote: Double, _ p: Palette) {
    // Le carré est inscrit dans son cercle circonscrit (demi-côté r/√2) depuis la
    // correction du 2026-08-24 : on remonte donc du demi-côté voulu au rayon par √2.
    let rayonCarre = demiCote * sqrt(2.0)
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
/// `largeur` échelonne tout le caisson, mât et lentilles compris. La valeur par défaut de
/// 13 est celle du feu-décor de `carrefour-feu-en-panne`, où le feu n'est qu'un détail de
/// la scène ; les scènes où le feu **est** le sujet demandent trois fois cette taille pour
/// que la lentille allumée se distingue à l'écran. Le rapport des proportions est figé, si
/// bien qu'un appel sans `largeur` rend le pixel pour pixel ce qu'il rendait avant.
///
/// Ce que la norme fixe, et qui est donc relevé plutôt que dessiné à l'œil : les lentilles
/// sont **circulaires** et leur ordre est rouge en haut, jaune au milieu, vert en bas
/// (arrêté du 24 novembre 1967, art. 7, et IISR 6e partie, art. 109-3). Le contour du
/// caisson autour d'elles, lui, n'est normalisé nulle part — cf. `Tools/images.md`.
func boitierDeFeu(_ ctx: CGContext, at pt: CGPoint, largeur l: Double = 13,
                  _ p: Palette) -> [CGPoint] {
    let u = l / 13   // tout le caisson est coté en unités de sa largeur d'origine
    let h = 34 * u
    let caisson = CGRect(x: pt.x - l / 2, y: pt.y - h / 2, width: l, height: h)
    ctx.setFillColor(p.chaussee)
    ctx.addPath(CGPath(roundedRect: caisson, cornerWidth: 3 * u, cornerHeight: 3 * u,
                       transform: nil))
    ctx.fillPath()
    // Le mât, sans quoi le caisson flotte au-dessus du sol.
    ctx.fill(CGRect(x: pt.x - 1.5 * u, y: caisson.maxY, width: 3 * u, height: 8 * u))
    return (0..<3).map { CGPoint(x: pt.x, y: caisson.minY + (6.5 + Double($0) * 10.5) * u) }
}

/// Rayon d'une lentille dans un caisson de `largeur` donnée.
func rayonDeLentille(_ largeur: Double) -> Double { largeur * 4 / 13 }

/// État d'une lentille. Trois états et non deux : le **clignotement** est une information
/// à part entière — c'est lui qui sépare le jaune clignotant du jaune fixe et le signal
/// d'arrêt R24 du feu rouge d'un tricolore — et il se dessine, il ne s'anime pas.
enum Lentille { case eteinte, allumee, clignotante }

/// Une lentille dans son caisson. Trois couches de signal, **aucune ne reposant sur la
/// luminance de la lentille elle-même** :
///
/// - le **filet clair** cerne la lentille dans les **trois** états : ce n'est donc jamais
///   lui qui distingue allumée d'éteinte, seulement ce qui reste **lisible en dessous**.
///   Correction du 2026-08-24 (constat de la tâche 10, §13 de `methode.md`) : il n'ornait
///   avant que l'état éteint, ce qui rendait la lentille éteinte plus claire en niveaux de
///   gris qu'une lentille rouge allumée — polarité inversée, mesurée à 119 contre 96 sur
///   `feu-fleche-clignotante` en mode clair ;
/// - allumée : la teinte pleine, entourée d'un **halo elliptique** de la même teinte et
///   d'un reflet décentré qu'une lentille éteinte n'a ni l'un ni l'autre ;
/// - clignotante : la même chose, plus des traits rayonnants — la convention de l'IISR
///   pour figurer un feu clignotant sur ses propres planches (6e partie, fig. 6 : « Ce
///   symbole signifie qu'il s'agit d'un feu clignotant »).
///
/// D'où le contrat de daltonisme : la **position** dans le caisson donne la couleur, le
/// **halo** (et le reflet qui l'accompagne) donnent l'allumage, les **traits** donnent le
/// clignotement. Aucune des trois informations ne repose sur une teinte, et depuis la
/// correction du filet (2026-08-24), aucune ne repose non plus sur la luminance relative
/// de la lentille — le filet ne permet plus de la déduire, il est le même partout.
///
/// **Le halo est elliptique, pas circulaire, depuis le 2026-08-25 (ronde 2 de la
/// tâche 10) — et c'est un correctif de forme, pas de luminance.** Un halo isotrope à
/// 1,55r reste, à 4,6 % près, inscrit dans le caisson pour toute valeur de `largeur`
/// (`1,55r` contre une demi-largeur de caisson de `1,625r` — cf. `boitierDeFeu`) : il ne
/// déborde jamais, donc il ne se voit jamais. Mesuré sur `feu-fleche-clignotante`, ce
/// halo « invisible » ne produisait que 90,6 contre 93,0 de fond nu sur l'anneau
/// 1,15–1,5r — 2,4 sur 255, perceptivement nul — alors même que la lentille rouge allumée
/// mesurait 92,5 (plus **sombre** que ses voisines éteintes, 138,1) quand la lentille
/// jaune de la flèche voisine, elle, mesurait 176,9 allumée (plus **claire**) : deux
/// polarités contradictoires dans la même image, aucune fiable en niveaux de gris.
///
/// L'agrandir sans le déformer ne réglait rien : le rayon qui ferait déborder un halo
/// **isotrope** du caisson (`largeur / 2 = 1,625r`) est **exactement** celui qui ferait
/// toucher le disque de la lentille voisine (les deux se déduisent de `10.5u - r = l/2`).
/// D'où l'ellipse — `debordH` porte le demi-axe **horizontal** à `2,2r`, largement au-delà
/// de `1,625r` (le halo déborde donc réellement, dans le fond de la scène, où le
/// contraste est net) ; `debordV` laisse le demi-axe **vertical** à `1,4r`, sous `1,545r`
/// (le rayon qui toucherait le **filet** de la lentille voisine) avec 9 % de marge. Les
/// deux bornes viennent de la même géométrie que ci-dessus et valent pour tout `largeur`.
///
/// Ce que ça change, mesuré à l'identique (bande horizontale ±12°, rayon 1,75–2,05r,
/// hors du caisson à tout angle de la bande) : le
/// fond juste au-delà du caisson, à hauteur de la lentille rouge allumée, passe de 235,1
/// (fond nu, identique à une lentille éteinte) à 189,5 en clair (écart 45,6) et de 37,2 à
/// 60,6 en sombre (écart 23,4, signe inversé — le rouge sombre est plus clair que le fond
/// sombre). Le signe change d'un mode à l'autre, la **présence du débord** non : c'est elle
/// qui porte l'information, pas son sens. La bande 1,15–1,5r du constat initial, elle, ne
/// bouge quasiment pas (90,6 → 90,7) — elle est structurellement **incapable** de voir un
/// débord, puisqu'elle s'arrête à 1,5r, avant même le bord du caisson (1,625r) : ce n'est
/// pas cette bande qui mesure le correctif.
///
/// `departRayons` est la distance au centre où les traits commencent, à la charge de
/// l'appelant : une lentille prise dans un caisson à trois lampes doit les faire partir
/// **au-delà** du caisson, sinon ils mordent sur les lentilles voisines et s'y lisent
/// comme un second allumage.
private func lentille(_ ctx: CGContext, at c: CGPoint, rayon r: Double, etat: Lentille,
                      couleur: CGColor, departRayons: Double? = nil) {
    let cadre = CGRect(x: c.x - r, y: c.y - r, width: r * 2, height: r * 2)
    func filet() {
        ctx.setStrokeColor(CGColor(gray: 1, alpha: 0.5))
        ctx.setLineWidth(max(r / 4, 1))
        ctx.strokeEllipse(in: cadre)
    }
    guard etat != .eteinte else {
        ctx.setFillColor(CGColor(gray: 1, alpha: 0.28))
        ctx.fillEllipse(in: cadre)
        filet()
        return
    }
    // Halo elliptique : demi-axe horizontal `2,2r`, demi-axe vertical `1,4r` — voir le
    // commentaire de `lentille` ci-dessus pour la mesure et le choix des deux bornes.
    let debordH = r * 1.2, debordV = r * 0.4
    ctx.setFillColor(couleur.copy(alpha: 0.30) ?? couleur)
    ctx.fillEllipse(in: cadre.insetBy(dx: -debordH, dy: -debordV))
    ctx.setFillColor(couleur)
    ctx.fillEllipse(in: cadre)
    filet()
    // Un reflet décentré vers le haut : une lampe allumée n'est pas un disque plat.
    ctx.setFillColor(CGColor(gray: 1, alpha: 0.32))
    ctx.fillEllipse(in: CGRect(x: c.x - r * 0.34, y: c.y - r * 0.52,
                               width: r * 0.68, height: r * 0.5))
    guard etat == .clignotante else { return }
    let d0 = departRayons ?? r * 1.7
    ctx.setStrokeColor(couleur)
    ctx.setLineWidth(max(r * 0.24, 1.2))
    ctx.setLineCap(.round)
    // Six traits, tous dans le secteur **horizontal** : c'est la seule place libre autour
    // d'une lentille de caisson, et le même geste sert partout pour que « clignotant » se
    // lise pareil d'une scène à l'autre.
    for a in [-0.5, 0.0, 0.5, .pi - 0.5, .pi, .pi + 0.5] {
        ctx.beginPath()
        ctx.move(to: CGPoint(x: c.x + cos(a) * d0, y: c.y + sin(a) * d0))
        ctx.addLine(to: CGPoint(x: c.x + cos(a) * (d0 + r * 0.85),
                                y: c.y + sin(a) * (d0 + r * 0.85)))
        ctx.strokePath()
    }
}

/// Signal tricolore R11, vu de face : le caisson et ses trois lentilles, dont l'état est
/// donné **du haut vers le bas**. La teinte de chacune découle de sa position — rouge,
/// jaune, vert (arrêté du 24 novembre 1967, art. 7) — et jamais de l'appelant : c'est ce
/// qui garantit qu'aucune scène ne puisse allumer un vert en haut du caisson.
func feuTricolore(_ ctx: CGContext, at pt: CGPoint, largeur l: Double = 13,
                  _ etats: [Lentille], _ p: Palette) {
    let teintes = [p.panneauRouge, p.panneauJaune, p.feuVert]
    for (i, centre) in boitierDeFeu(ctx, at: pt, largeur: l, p).enumerated() {
        lentille(ctx, at: centre, rayon: rayonDeLentille(l),
                 etat: i < etats.count ? etats[i] : .eteinte, couleur: teintes[i],
                 departRayons: l * 0.62)
    }
}

/// Feu hors service : les trois lentilles au même gris éteint. Ce qui se lit est
/// l'**absence** de lampe allumée, et non une couleur particulière — un daltonien voit la
/// même chose que tout le monde.
func feuHorsService(_ ctx: CGContext, at pt: CGPoint, _ p: Palette) {
    feuTricolore(ctx, at: pt, [.eteinte, .eteinte, .eteinte], p)
}

/// Signal d'anticipation directionnel R16 : **une seule** lentille jaune clignotante,
/// munie d'une flèche, dans un caisson carré accolé au tricolore. Sa signification est
/// citée mot pour mot par l'art. 7 de l'arrêté du 24 novembre 1967 : « le feu jaune
/// clignotant signifie aux usagers concernés qu'ils peuvent franchir la ligne d'arrêt du
/// signal tricolore circulaire R11 associé, bien que celui-ci soit au rouge, mais en toute
/// prudence et en respectant la priorité de passage accordée aux autres usagers. »
///
/// Il se place « à la même hauteur que le feu vert du signal R11v associé, soit juste en
/// dessous » (IISR 6e partie, art. 110-5) : c'est pour cela que la scène l'accole en bas
/// du caisson et non en haut. `versLaDroite` retourne la flèche, rien d'autre.
func signalDAnticipation(_ ctx: CGContext, at pt: CGPoint, largeur l: Double,
                         versLaDroite: Bool, _ p: Palette) {
    let u = l / 13
    let caisson = CGRect(x: pt.x - l / 2, y: pt.y - l / 2, width: l, height: l)
    ctx.setFillColor(p.chaussee)
    ctx.addPath(CGPath(roundedRect: caisson, cornerWidth: 3 * u, cornerHeight: 3 * u,
                       transform: nil))
    ctx.fillPath()
    let r = rayonDeLentille(l)
    lentille(ctx, at: pt, rayon: r, etat: .clignotante, couleur: p.panneauJaune,
             departRayons: l * 0.62)
    // La flèche est peinte en sombre sur la lentille : c'est un pictogramme, comme sur un
    // panneau, et non une seconde lampe. Elle est tracée en dur plutôt qu'avec `fleche`,
    // dont la pointe est calibrée pour une flèche d'intention au sol : à l'échelle d'une
    // lentille, la pointe y mangeait la hampe et le tout se lisait comme une tache.
    ctx.saveGState()
    ctx.translateBy(x: pt.x, y: pt.y)
    if !versLaDroite { ctx.scaleBy(x: -1, y: 1) }
    ctx.setFillColor(encre(p))
    let hampe = r * 0.30, pointe = r * 0.62
    ctx.fill(CGRect(x: -r * 0.72, y: -hampe / 2, width: r * 0.72, height: hampe))
    ctx.beginPath()
    ctx.move(to: CGPoint(x: r * 0.74, y: 0))
    ctx.addLine(to: CGPoint(x: r * 0.74 - pointe, y: -pointe * 0.72))
    ctx.addLine(to: CGPoint(x: r * 0.74 - pointe, y: pointe * 0.72))
    ctx.closePath()
    ctx.fillPath()
    ctx.restoreGState()
}

/// Le bras qui rattache un signal d'anticipation au support du tricolore. Sans lui, deux
/// caissons voisins se lisent comme deux installations distinctes, alors que l'art. 110-5
/// de la 6e partie de l'IISR les veut sur le **même** support.
func brasDeSupport(_ ctx: CGContext, de x0: Double, a x1: Double, y: Double,
                   epaisseur: Double, _ p: Palette) {
    ctx.setFillColor(p.chaussee)
    ctx.fill(CGRect(x: min(x0, x1), y: y - epaisseur / 2,
                    width: abs(x1 - x0), height: epaisseur))
}

/// Signal d'arrêt R24 : « un feu circulaire rouge clignotant » (IISR 6e partie,
/// art. 109-3, B), et lui seul — pas de caisson à trois lentilles. C'est la différence
/// qu'un candidat doit voir : au passage à niveau, au pont mobile ou devant une sortie de
/// pompiers, le signal n'a **qu'une** lampe, et elle clignote.
///
/// La norme ne fixe ici que le diamètre minimal (160 mm, art. 109-4) ; le caisson rond
/// autour de la lentille est un choix de dessin.
func signalDArret(_ ctx: CGContext, at pt: CGPoint, rayon r: Double, _ p: Palette) {
    ctx.setFillColor(p.chaussee)
    ctx.fillEllipse(in: CGRect(x: pt.x - r * 1.32, y: pt.y - r * 1.32,
                               width: r * 2.64, height: r * 2.64))
    // Le mât : le signal est planté au bord de la chaussée, pas suspendu.
    ctx.fill(CGRect(x: pt.x - r * 0.16, y: pt.y + r * 1.2, width: r * 0.32, height: r * 2.6))
    lentille(ctx, at: pt, rayon: r, etat: .clignotante, couleur: p.panneauRouge)
}

/// A16, descente dangereuse, avec son panonceau de déclivité. Il est là pour une raison
/// de droit et non de décor : l'article R414-3 ne fait s'arrêter le véhicule descendant
/// que « sur les routes de montagne et sur les routes à forte déclivité », et c'est
/// l'image qui doit dire qu'on y est.
///
/// Le listel blanc autour de la bande rouge est arrivé le 2026-08-24, avec la lecture de
/// l'article 23 de la 2e partie ; le pictogramme de chaussée qui plonge, lui, n'a toujours
/// pas de planche relevée (cf. `Tools/images.md`).
func panneauDescenteDangereuse(_ ctx: CGContext, _ pourcentage: Int, at pt: CGPoint,
                               rayon: Double, _ p: Palette) {
    panneauDeDanger(ctx, at: pt, rayon: rayon, p)
    // Le pictogramme réglementaire : une chaussée qui plonge vers la droite.
    ctx.setStrokeColor(encre(p))
    ctx.setLineWidth(rayon * 0.17)
    ctx.setLineCap(.butt)
    ctx.beginPath()
    ctx.move(to: CGPoint(x: pt.x - rayon * 0.42, y: pt.y - rayon * 0.02))
    ctx.addLine(to: CGPoint(x: pt.x + rayon * 0.42, y: pt.y + rayon * 0.32))
    ctx.strokePath()
    // Panonceau de déclivité : sous le triangle, comme sur la route. Le côté inférieur du
    // triangle équilatéral est à +0,5 rayon (et non +0,72 comme avant la correction de
    // géométrie), d'où la plaque à +0,62 : le même jeu de 0,12 rayon sous l'arête.
    let l = rayon * 1.55, h = rayon * 0.64
    panonceau(ctx, "\(pourcentage) %",
              at: CGRect(x: pt.x - l / 2, y: pt.y + rayon * 0.62, width: l, height: h), p)
}

// MARK: - Les panneaux de la tâche 7
//
// Une fonction par panneau, du fond au pictogramme. Trois familles, trois habillages, et
// c'est l'habillage qui porte le sens — pas la teinte :
//
// - **danger (type A)** : triangle pointe en haut, fond blanc, bande rouge bordée d'un
//   listel blanc (2e partie, art. 23) ;
// - **prescription (type B)** : disque. Interdiction = fond blanc et couronne rouge, sans
//   listel ; obligation = fond bleu, listel et symbole blancs ; fin d'interdiction = fond
//   blanc, listel, symbole et barre noirs (4e partie, art. 47) ;
// - **indication (type C)** : carré (5e partie, art. 69-1).
//
// Ce que la norme **ne** donne pas en texte : le dessin des pictogrammes, qui vit dans les
// planches jointes aux arrêtés et non dans les articles. Chaque pictogramme ci-dessous est
// donc une simplification du symbole connu, dessinée pour être lisible à ~90 points de
// haut ; aucun visuel d'éditeur d'ETG n'a servi de modèle. Le détail est dans
// `Tools/images.md`.

/// L'habillage commun des panneaux de danger : triangle, fond blanc, bande rouge, listel
/// blanc. Extrait parce que cinq panneaux le partagent et que l'article 23 ne l'écrit
/// qu'une fois.
func panneauDeDanger(_ ctx: CGContext, at pt: CGPoint, rayon: Double, _ p: Palette) {
    panneau(ctx, forme: .triangle, at: pt, rayon: rayon, fond: p.panneauFond,
            bord: p.panneauRouge, epaisseurBord: rayon * 0.13,
            listel: p.panneauFond, epaisseurListel: max(rayon * 0.045, 0.9))
}

/// Une barre oblique tracée **dans** le disque, donc écrêtée par lui : posée sans `clip`
/// elle dépasserait du panneau, ce qui n'existe sur aucun panneau réglementaire.
private func obliqueDeBarre(_ ctx: CGContext, at pt: CGPoint, rayon: Double,
                            montante: Bool, couleur: CGColor,
                            epaisseur: Double? = nil) {
    ctx.saveGState()
    ctx.addEllipse(in: CGRect(x: pt.x - rayon, y: pt.y - rayon,
                              width: rayon * 2, height: rayon * 2))
    ctx.clip()
    ctx.setStrokeColor(couleur)
    ctx.setLineWidth(epaisseur ?? rayon * 0.22)
    ctx.setLineCap(.butt)
    ctx.beginPath()
    // Repère en y vers le bas : « montante vers la droite » part du plus grand y.
    ctx.move(to: CGPoint(x: pt.x - rayon, y: pt.y + (montante ? rayon : -rayon)))
    ctx.addLine(to: CGPoint(x: pt.x + rayon, y: pt.y + (montante ? -rayon : rayon)))
    ctx.strokePath()
    ctx.restoreGState()
}

/// AB7, fin du caractère prioritaire d'une route (3e partie, art. 42-3, B) : le carré posé
/// sur la pointe de l'AB6, barré. Le panneau « sans panonceau de distance annonce la perte
/// de priorité au prochain carrefour ». La 3e partie ne porte pas d'article de couleurs :
/// le losange jaune vient de l'AB6 déjà dessiné dans ce fichier, la barre du symbole
/// n'a pas de planche relevée (cf. `Tools/images.md`).
func panneauFinPriorite(_ ctx: CGContext, at pt: CGPoint, rayon: Double, _ p: Palette) {
    panneau(ctx, forme: .losange, at: pt, rayon: rayon, fond: p.panneauFond)
    panneau(ctx, forme: .losange, at: pt, rayon: rayon * 0.59, fond: p.panneauJaune)
    // La barre est écrêtée par le losange extérieur, pas par un disque : elle doit longer
    // la forme du panneau.
    ctx.saveGState()
    ctx.addPath(cheminLosange(at: pt, rayon: rayon * 0.93))
    ctx.clip()
    ctx.setStrokeColor(encre(p))
    ctx.setLineWidth(rayon * 0.15)
    ctx.setLineCap(.butt)
    ctx.beginPath()
    ctx.move(to: CGPoint(x: pt.x - rayon, y: pt.y + rayon))
    ctx.addLine(to: CGPoint(x: pt.x + rayon, y: pt.y - rayon))
    ctx.strokePath()
    ctx.restoreGState()
}

private func cheminLosange(at pt: CGPoint, rayon r: Double) -> CGPath {
    let path = CGMutablePath()
    path.addLines(between: [CGPoint(x: pt.x, y: pt.y - r), CGPoint(x: pt.x + r, y: pt.y),
                            CGPoint(x: pt.x, y: pt.y + r), CGPoint(x: pt.x - r, y: pt.y)])
    path.closeSubpath()
    return path
}

/// C1a, lieu aménagé pour le stationnement (5e partie, art. 70). « Les panneaux de type C
/// sont généralement de forme carrée » (art. 69-1), et cette forme est tout le sujet de la
/// question qu'il illustre : un **carré** renseigne, un **disque** prescrit (4e partie,
/// art. 45). Un daltonien lit la différence sans voir une seule couleur.
func panneauParking(_ ctx: CGContext, at pt: CGPoint, rayon: Double, _ p: Palette) {
    panneau(ctx, forme: .carre, at: pt, rayon: rayon, fond: p.vous,
            listel: p.panneauFond, epaisseurListel: max(rayon * 0.055, 1.0))
    texte(ctx, "P", centre: pt, taille: rayon * 1.05, couleur: p.panneauFond)
}

/// C113, voie conseillée et réservée aux cyclistes (5e partie, art. 75-3). Panneau
/// d'**indication** : il réserve la voie sans obliger le cycliste à la prendre. La piste
/// ou bande *obligatoire* relève de la prescription et se signale par un panneau rond
/// (art. 66 de la 4e partie) — c'est la paire que la question fait travailler.
func panneauVoieVelo(_ ctx: CGContext, at pt: CGPoint, rayon: Double, _ p: Palette) {
    panneau(ctx, forme: .carre, at: pt, rayon: rayon, fond: p.vous,
            listel: p.panneauFond, epaisseurListel: max(rayon * 0.055, 1.0))
    silhouetteVelo(ctx, at: pt, largeur: rayon * 1.10, p.panneauFond)
}

/// Une bicyclette vue de profil : deux roues, un cadre en triangle, un guidon, une selle.
/// Le pictogramme réglementaire est plus fin ; à 90 points de haut, ces six traits sont ce
/// qui reste lisible.
///
/// Rendue non privée le 2026-08-26 (tâche 15) : la **figurine peinte au sol** d'une voie
/// cyclable est le même dessin que celui du panneau C113 — un vélo de profil, vu de dessus
/// mais dessiné de côté (IISR, 7e partie, art. 118-1, C, « des figurines au sol : la
/// figurine indiquant l'accès d'une voie conseillée aux cyclistes »). Un pictogramme se
/// dessine une fois : `sas-cycliste-feu` réutilise celui-ci au lieu d'en redessiner un.
func silhouetteVelo(_ ctx: CGContext, at pt: CGPoint, largeur l: Double,
                            _ encre: CGColor) {
    let r = l * 0.20, e = l * 0.055
    ctx.setStrokeColor(encre)
    ctx.setLineWidth(e)
    ctx.setLineCap(.round)
    ctx.setLineJoin(.round)
    let arriere = CGPoint(x: pt.x - l * 0.28, y: pt.y + l * 0.16)
    let avant = CGPoint(x: pt.x + l * 0.28, y: pt.y + l * 0.16)
    for c in [arriere, avant] {
        ctx.strokeEllipse(in: CGRect(x: c.x - r, y: c.y - r, width: r * 2, height: r * 2))
    }
    // Cadre : du moyeu arrière à la selle, à la boîte de pédalier, au moyeu avant.
    let selle = CGPoint(x: pt.x - l * 0.08, y: pt.y - l * 0.16)
    let pedalier = CGPoint(x: pt.x, y: pt.y + l * 0.16)
    let guidon = CGPoint(x: pt.x + l * 0.20, y: pt.y - l * 0.20)
    ctx.beginPath()
    ctx.move(to: arriere)
    ctx.addLine(to: selle)
    ctx.addLine(to: pedalier)
    ctx.addLine(to: arriere)
    ctx.move(to: selle)
    ctx.addLine(to: guidon)
    ctx.move(to: guidon)
    ctx.addLine(to: avant)
    // Le guidon en travers, sans quoi la fourche se lit comme un simple trait.
    ctx.move(to: CGPoint(x: guidon.x - l * 0.09, y: guidon.y - l * 0.02))
    ctx.addLine(to: CGPoint(x: guidon.x + l * 0.06, y: guidon.y - l * 0.02))
    ctx.strokePath()
}
