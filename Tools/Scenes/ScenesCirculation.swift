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
/// glissière à gauche, bande de rive discontinue à droite. La position de la glissière est
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
    // Rive gauche : continue, et c'est la norme — « les lignes de délimitation de
    // terre-plein central sont continues et de largeur 3u » (IISR, 7e partie, art. 114-4, B).
    ctx.setFillColor(p.marquage)
    ctx.fill(CGRect(x: bordGauche - 6, y: 0, width: 3, height: H))
    // Rive droite : **discontinue**, corrigé le 2026-08-25 (tâche 12). Le même art. 114-4, B
    // dit : « Sur autoroute et route à chaussées séparées et à carrefours dénivelés, la ligne
    // délimitant une bande d'arrêt d'urgence est discontinue de type T4 […]. En l'absence de
    // bande d'arrêt d'urgence, la ligne de rive est continue. » La scène montre bien une BAU
    // (la chaussée court jusqu'au bord du cadre au-delà de la rive), donc la continue était
    // une faute de sens, pas un détail : une continue interdit de la franchir, alors qu'on
    // rejoint la BAU en cas de nécessité absolue. La banque le disait déjà — la question
    // « Une ligne discontinue tracée le long du bord de la chaussée délimite : » répond « la
    // bande d'arrêt d'urgence ou l'accotement ».
    //
    // La modulation T4 vaut « 39 m de trait, 13 m d'intervalle » (art. 113-1, B), soit un
    // rapport plein/vide de 3. Ce rapport est tout ce qui se transpose : à l'échelle de la
    // scène une voie de 78 unités vaut 3,5 m, donc 39 m feraient 870 unités pour un cadre
    // haut de 300. C'est ce facteur ~20 entre les deux axes qui a fait renoncer à illustrer
    // la distance de sécurité au sol (voir le rapport de la tâche 12) ; ici seul le rapport
    // 3 pour 1 est dessiné, et il suffit à distinguer la rive d'une T1 de délimitation de
    // voies, dont les vides dominent.
    let rive = bordGauche + largeurVoie * 3 + 3
    var yRive = 0.0
    while yRive < H {
        ctx.fill(CGRect(x: rive, y: yRive, width: 3, height: min(45, H - yRive)))
        yRive += 60
    }
    // Lignes de délimitation de voies : « de type T1 » sur autoroute (art. 114-2, C), et la
    // T1 module « 3 m de trait, 10 m d'intervalle » (art. 113-1, B), soit un rapport
    // plein/vide de 0,3 — les vides dominent. Le premier jet dessinait 18 de trait pour 14
    // de vide, un rapport de 1,3 : proche d'une T2, et surtout indiscernable de la rive.
    // Corrigé en même temps que la rive (2026-08-25) : c'est le contraste des deux
    // modulations, 3 pour 1 en rive contre 1 pour 3 entre voies, qui fait lire le bord droit
    // comme un bord et non comme une quatrième voie.
    for i in 1...2 {
        var y = 6.0
        while y < H {
            ctx.fill(CGRect(x: bordGauche + largeurVoie * Double(i) - 1.5, y: y,
                            width: 3, height: 18))
            y += 78
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

// MARK: - Une scène de profil : le chargement (tâche 13)
//
// Vue **de côté**, comme `croisement-en-pente`. Ce n'est pas un écart de style : la
// question fait travailler un rapport **avant/arrière** — de quel bout le chargement
// déborde — et une vue de dessus ne dit pas « sur le toit ».
//
// `chausseeDeProfil` et `solProfil` ont été écrits pour servir **deux** scènes de profil :
// celle-ci et `siege-enfant-place-avant`, retirée le 2026-08-25 en ronde 1 de revue (voir
// la note à la fin de ce fichier et `Tools/images.md`). L'infrastructure commune reste
// utile telle quelle pour une future scène de profil.
//
// L'échelle est **doublée** par rapport aux vues de dessus : une caisse de 96 unités pour
// 4 m, soit 24 unités par mètre, là où les scènes de carrefour comptent 12 unités par
// mètre. La raison est dans la réponse : les 3 m de débord de R312-21 auraient fait 36
// unités à l'échelle des carrefours, à peine plus qu'une roue, donc indiscernables d'un
// débord d'un mètre. Le débord dessiné vaut 60 unités, soit 2,5 m — dans la limite légale,
// ce qui compte : une scène qui montrerait un chargement hors la loi rendrait fausse la
// bonne réponse.
//
// `solProfil` remonte à 202 au lieu du bas du cadre, pour la même raison que partout
// ailleurs : le bandeau tombe à 18 % au verdict et ne laisse qu'une bande d'environ 110
// unités autour du centre vertical. Tout ce qui porte la réponse — le chargement, la coque
// du véhicule — tient entre y = 116 et y = 202.

/// Surface de la chaussée des deux scènes de profil.
private let solProfil = 202.0

private func chausseeDeProfil(_ ctx: CGContext, _ p: Palette) {
    fond(ctx, p)
    ctx.setFillColor(p.chaussee)
    ctx.fill(CGRect(x: 0, y: solProfil, width: W, height: H - solProfil))
    // Bande de rive : c'est elle qui fait lire une chaussée plutôt qu'un socle gris.
    ctx.setFillColor(p.marquage)
    ctx.fill(CGRect(x: 0, y: solProfil + 26, width: W, height: 3))
}

/// La voiture de profil de `Primitives.swift`, dessinée au double de sa taille.
/// `voitureDeProfil` a des cotes fixes ; on incline le repère plutôt que d'ajouter une
/// seconde géométrie de caisse, comme `voitureEnEpi` le fait pour la vue de dessus.
private func voitureDeProfilDouble(_ ctx: CGContext, x: Double, y: Double,
                                   couleur: CGColor, _ p: Palette) {
    ctx.saveGState()
    ctx.translateBy(x: x, y: y)
    ctx.scaleBy(x: 2, y: 2)
    voitureDeProfil(ctx, x: 0, y: 0, pente: 0, versLaDroite: true, couleur: couleur,
                    liseree: true, p)
    ctx.restoreGState()
}

/// Un noir presque plein, comme les roues de `voitureDeProfil` : il sert aux contours du
/// chargement et aux sièges, et se lit sur le clair comme sur le sombre.
private let traitSombre = CGColor(gray: 0.15, alpha: 1)

// MARK: - Usagers & partage de la route (tâche 15)
//
// Quatre scènes, et une contrainte que les précédentes n'avaient pas : elles mettent en
// présence des usagers de **tailles très différentes** — un poids lourd de dix mètres et un
// cycliste de moins de deux. L'échelle change donc d'une scène à l'autre, et elle est notée
// à chaque fois, parce que c'est elle qui décide de ce qui reste lisible :
//
// - `angle-mort-poids-lourd` et `bus-quittant-arret` : **12 unités par mètre**, l'échelle
//   des scènes de carrefour. C'est la seule qui fasse tenir un véhicule de dix mètres dans
//   le cadre.
// - `sas-cycliste-feu` : **16 unités par mètre**. Le sas mesure 3 à 5 m de long (IISR, 7e
//   partie, art. 118-1, D) ; à 12 unités il serait plus court qu'une voiture, à 32 il
//   déborderait de la bande centrale qui survit au recadrage.
// - `depassement-cycliste-distance` : **32 unités par mètre**, l'échelle des scènes de
//   stationnement. C'est la seule qui rende visible un écart latéral d'un mètre.

/// Rue à double sens bordée de **deux** trottoirs, vue de dessus. Les deux bordures sont
/// des surfaces, comme dans les scènes de stationnement : c'est ce qui fait lire « rue » et
/// non « route », et donc « en agglomération » — le fait dont dépend la réponse de
/// `depassement-cycliste-distance`. Le trottoir lui-même est le `sol`, comme partout.
private func rueBordeeDeDeuxTrottoirs(_ ctx: CGContext, gauche: Double, droite: Double,
                                      bordure: Double, axe: Double, pas: Double,
                                      _ p: Palette) {
    fond(ctx, p)
    ctx.setFillColor(p.chaussee)
    ctx.fill(CGRect(x: gauche, y: 0, width: droite - gauche, height: H))
    ctx.setFillColor(p.bordure)
    ctx.fill(CGRect(x: gauche - bordure, y: 0, width: bordure, height: H))
    ctx.fill(CGRect(x: droite, y: 0, width: bordure, height: H))
    ctx.setFillColor(p.marquage)
    var y = 6.0
    while y < H {
        ctx.fill(CGRect(x: axe - 1.5, y: y, width: 3, height: pas * 0.55))
        y += pas
    }
}

/// Zone hachurée : la convention par laquelle une planche de sécurité routière marque une
/// surface **non vue** depuis un poste de conduite. Le signal est de forme — un remplissage
/// rayé, un contour — et jamais de teinte : un daltonien lit les mêmes rayures. Les
/// hachures sont posées **sous** les véhicules, pour qu'un véhicule pris dedans se lise
/// entouré de rayures plutôt que rayé lui-même.
private func zoneNonVue(_ ctx: CGContext, _ rect: CGRect, _ p: Palette) {
    ctx.saveGState()
    ctx.clip(to: rect)
    ctx.setStrokeColor(p.marquage.copy(alpha: 0.55) ?? p.marquage)
    ctx.setLineWidth(2)
    var d = -rect.height
    while d < rect.width {
        ctx.beginPath()
        ctx.move(to: CGPoint(x: rect.minX + d, y: rect.minY))
        ctx.addLine(to: CGPoint(x: rect.minX + d + rect.height, y: rect.maxY))
        ctx.strokePath()
        d += 9
    }
    ctx.restoreGState()
    ctx.setStrokeColor(p.marquage.copy(alpha: 0.85) ?? p.marquage)
    ctx.setLineWidth(1.5)
    ctx.stroke(rect)
}

/// Un poids lourd vu de dessus, nez vers le haut : cabine courte, caisse longue, et un
/// **joint visible** entre les deux. Ce joint est tout ce qui distingue un poids lourd
/// d'une grosse voiture à cette échelle — sans lui, une caisse de 120 unités se lit comme
/// un bus. Le pare-brise donne le sens de marche, comme sur `voiture`.
private func poidsLourdVuDeDessus(_ ctx: CGContext, x: Double, y: Double, longueur: Double,
                                  largeur: Double, couleur: CGColor, _ p: Palette) {
    let cabine = longueur * 0.28
    let haut = y - longueur / 2
    let corpsCabine = CGRect(x: x - largeur / 2, y: haut, width: largeur, height: cabine)
    let corpsCaisse = CGRect(x: x - largeur / 2, y: haut + cabine + 3,
                             width: largeur, height: longueur - cabine - 3)
    ctx.setFillColor(couleur)
    ctx.addPath(CGPath(roundedRect: corpsCabine, cornerWidth: 5, cornerHeight: 5,
                       transform: nil))
    ctx.addPath(CGPath(roundedRect: corpsCaisse, cornerWidth: 3, cornerHeight: 3,
                       transform: nil))
    ctx.fillPath()
    // Le contour sombre n'est pas décoratif : mesuré avant le rendu, `autre` en mode clair
    // (167,7) et une hachure blanche à 55 % sur la chaussée (173,7) ne sont qu'à 6 points
    // l'un de l'autre. Sans ce contour, la caisse et la zone hachurée qui la longe se
    // fondraient en niveaux de gris — exactement le défaut que le §13 de `methode.md`
    // demande de mesurer avant de rendre, et non après.
    ctx.setStrokeColor(traitSombre)
    ctx.setLineWidth(2)
    ctx.addPath(CGPath(roundedRect: corpsCabine, cornerWidth: 5, cornerHeight: 5,
                       transform: nil))
    ctx.addPath(CGPath(roundedRect: corpsCaisse, cornerWidth: 3, cornerHeight: 3,
                       transform: nil))
    ctx.strokePath()
    ctx.setFillColor(CGColor(gray: 1, alpha: 0.55))
    ctx.fill(CGRect(x: corpsCabine.minX + 5, y: corpsCabine.minY + 5,
                    width: corpsCabine.width - 10, height: 8))
    // Les rétroviseurs : deux moignons de part et d'autre de la cabine. Ils disent où est
    // le poste de conduite, donc d'où part le regard dont la question parle.
    ctx.setFillColor(couleur)
    for dx in [-largeur / 2 - 7, largeur / 2] {
        ctx.fill(CGRect(x: x + dx, y: corpsCabine.minY + 11, width: 7, height: 4))
    }
}

/// Un cycliste vu de dessus : le vélo se réduit à un trait dans l'axe, et c'est le
/// **guidon en travers** plus les épaules qui le font lire comme un cycliste et non comme
/// un poteau. Quatre formes, parce qu'à 55 unités de long un dessin fidèle devient une
/// tache.
///
/// Les cotes du premier jet — guidon à 0,30 de la longueur, épaules à 0,26 — ont été
/// élargies après le premier rendu : à l'écran, l'ensemble se lisait comme un poteau
/// surmonté d'un point. Guidon et épaules valent maintenant 0,34 de la longueur, soit
/// **0,58 m** à l'échelle de `depassement-cycliste-distance` : c'est la largeur réelle d'un
/// guidon de ville, et c'est elle qui borne l'écart latéral que la scène doit rendre juste.
private func cyclisteVuDeDessus(_ ctx: CGContext, x: Double, y: Double, longueur: Double,
                                couleur: CGColor, _ p: Palette) {
    let sombre = CGColor(gray: 0.14, alpha: 1)
    ctx.setFillColor(sombre)
    ctx.fill(CGRect(x: x - 2.5, y: y - longueur / 2, width: 5, height: longueur))
    let guidon = longueur * 0.30
    ctx.fill(CGRect(x: x - guidon / 2, y: y - longueur * 0.24, width: guidon, height: 5))
    // Le buste, **plus long que large** : une ellipse ronde se lisait comme une lentille de
    // feu, et la tête sombre posée dessus n'en faisait qu'un anneau. Le buste allongé donne
    // le sens de la marche, et la tête claire s'y détache au lieu de l'évider.
    ctx.setFillColor(couleur)
    ctx.fillEllipse(in: CGRect(x: x - longueur * 0.15, y: y - longueur * 0.20,
                               width: longueur * 0.30, height: longueur * 0.40))
    ctx.setFillColor(CGColor(gray: 0.93, alpha: 1))
    ctx.fillEllipse(in: CGRect(x: x - longueur * 0.075, y: y - longueur * 0.145,
                               width: longueur * 0.15, height: longueur * 0.15))
    ctx.setStrokeColor(sombre)
    ctx.setLineWidth(1.2)
    ctx.strokeEllipse(in: CGRect(x: x - longueur * 0.075, y: y - longueur * 0.145,
                                 width: longueur * 0.15, height: longueur * 0.15))
}

/// Un piéton vu de dessus : les épaules et la tête, rien d'autre. Sa fonction dans ces
/// scènes n'est pas d'être un usager mais de **qualifier une surface** — un trottoir sur
/// lequel marche quelqu'un ne se confond plus avec une marge de cadre, et c'est ce fait,
/// « on est en agglomération », dont dépend la réponse de deux des quatre scènes de la
/// tâche 15.
///
/// La tête est **claire**, comme celle du cycliste, et non sombre comme au premier jet : sur
/// le trottoir du mode sombre (37 en niveaux de gris), une tête sombre posée sur des épaules
/// claires évidait la silhouette et la réduisait à un anneau. Une tête claire cernée d'un
/// filet sombre se lit dans les deux modes.
private func pietonVuDeDessus(_ ctx: CGContext, x: Double, y: Double, taille: Double,
                              couleur: CGColor, _ p: Palette) {
    ctx.setFillColor(couleur)
    ctx.fillEllipse(in: CGRect(x: x - taille * 0.45, y: y - taille * 0.35,
                               width: taille * 0.90, height: taille * 0.70))
    let tete = CGRect(x: x - taille * 0.24, y: y - taille * 0.24,
                      width: taille * 0.48, height: taille * 0.48)
    ctx.setFillColor(CGColor(gray: 0.93, alpha: 1))
    ctx.fillEllipse(in: tete)
    ctx.setStrokeColor(CGColor(gray: 0.14, alpha: 1))
    ctx.setLineWidth(1.2)
    ctx.strokeEllipse(in: tete)
}

/// Un autobus vu de dessus, nez vers le haut : caisse d'un seul tenant — pas de joint,
/// c'est ce qui le sépare du poids lourd — et **deux portes du côté du trottoir**. Les
/// portes sont l'information : une caisse longue arrêtée le long d'une bordure pourrait
/// être un camion de livraison, une caisse à portes côté trottoir est un transport en
/// commun.
private func busVuDeDessus(_ ctx: CGContext, x: Double, y: Double, longueur: Double,
                           largeur: Double, couleur: CGColor, _ p: Palette) {
    let corps = CGRect(x: x - largeur / 2, y: y - longueur / 2,
                       width: largeur, height: longueur)
    ctx.setFillColor(couleur)
    ctx.addPath(CGPath(roundedRect: corps, cornerWidth: 6, cornerHeight: 6, transform: nil))
    ctx.fillPath()
    // Même raison que pour le poids lourd : `tiers` (98,6 en clair) ne se sépare de la
    // chaussée (74,3) que de 24 points, trop peu pour une caisse de 120 unités.
    ctx.setStrokeColor(traitSombre)
    ctx.setLineWidth(2)
    ctx.addPath(CGPath(roundedRect: corps, cornerWidth: 6, cornerHeight: 6, transform: nil))
    ctx.strokePath()
    ctx.setFillColor(CGColor(gray: 1, alpha: 0.55))
    ctx.fill(CGRect(x: corps.minX + 5, y: corps.minY + 5, width: corps.width - 10, height: 8))
    // Les portes, côté droit : deux encoches claires qui mordent sur un tiers de la largeur.
    ctx.setFillColor(CGColor(gray: 1, alpha: 0.45))
    for t in [0.30, 0.68] {
        ctx.fill(CGRect(x: corps.maxX - largeur * 0.34, y: corps.minY + longueur * t,
                        width: largeur * 0.34, height: longueur * 0.11))
    }
}

/// Un indicateur de changement de direction **allumé et clignotant**, vu de dessus. Les
/// traits rayonnants sont la même convention que sur `lentille` : dans tout le dossier, des
/// traits qui partent d'une source veulent dire « ça clignote ». Le disque est en
/// `panneauJaune`, la teinte la plus claire de la palette après le marquage, pour que la
/// polarité aille dans le bon sens — ce qui est allumé est plus clair que ce qui l'entoure.
private func clignotantAllume(_ ctx: CGContext, at c: CGPoint, rayon r: Double,
                              versLaGauche: Bool, _ p: Palette) {
    let signe = versLaGauche ? -1.0 : 1.0
    ctx.setStrokeColor(p.panneauJaune)
    ctx.setLineWidth(max(r * 0.5, 1.5))
    ctx.setLineCap(.round)
    for a in [-0.7, 0.0, 0.7] {
        let d0 = r * 1.8, d1 = r * 3.1
        ctx.beginPath()
        ctx.move(to: CGPoint(x: c.x + signe * cos(a) * d0, y: c.y + sin(a) * d0))
        ctx.addLine(to: CGPoint(x: c.x + signe * cos(a) * d1, y: c.y + sin(a) * d1))
        ctx.strokePath()
    }
    ctx.setFillColor(p.panneauJaune)
    ctx.fillEllipse(in: CGRect(x: c.x - r, y: c.y - r, width: r * 2, height: r * 2))
    ctx.setStrokeColor(CGColor(gray: 1, alpha: 0.6))
    ctx.setLineWidth(1)
    ctx.strokeEllipse(in: CGRect(x: c.x - r, y: c.y - r, width: r * 2, height: r * 2))
}

/// Ligne d'effet des feux : transversale de type T'2, « alternativement 0,5 m de trait et
/// 0,5 m de vide » (IISR, 7e partie, art. 113-1, B), large de 15 cm (art. 118-1, C). Elle
/// « ne s'étend que sur les voies affectées à la circulation des véhicules auxquels
/// s'adressent les signaux » — d'où les bornes `de`/`a`, qui ne couvrent que la voie
/// d'approche et jamais la chaussée entière.
private func ligneDEffetDesFeux(_ ctx: CGContext, de x0: Double, a x1: Double, y: Double,
                                trait: Double, epaisseur: Double, _ p: Palette) {
    ctx.setFillColor(p.marquage)
    var x = x0
    while x < x1 {
        ctx.fill(CGRect(x: x, y: y - epaisseur / 2, width: min(trait, x1 - x),
                        height: epaisseur))
        x += trait * 2
    }
}

/// Passage pour piétons : « des bandes rectangulaires blanches **parallèles à l'axe de la
/// chaussée** » (IISR, 7e partie, art. 118). Le sens des bandes est le seul point de ce
/// marquage qu'on puisse dessiner faux, et il l'est très souvent.
private func passagePourPietons(_ ctx: CGContext, de x0: Double, a x1: Double,
                                haut: Double, bas: Double, bande: Double, pas: Double,
                                _ p: Palette) {
    ctx.setFillColor(p.marquage)
    var x = x0 + (pas - bande) / 2
    while x + bande <= x1 {
        ctx.fill(CGRect(x: x, y: haut, width: bande, height: bas - haut))
        x += pas
    }
}

/// Marque d'arrêt d'autobus : le tableau de l'art. 113-2, E de la 7e partie la donne en
/// « continue en zigzag de 2u », et l'art. 113-1, A range le jaune du côté des marques
/// qui interdisent l'arrêt. Elle est posée sur la face supérieure de la bordure, comme les
/// deux scènes de ligne jaune : c'est la position, et non la teinte, qui la distingue d'un
/// marquage blanc — aucun blanc n'est jamais peint sur une bordure.
private func zigzagJauneSurLaBordure(_ ctx: CGContext, de x0: Double, a x1: Double,
                                     haut: Double, bas: Double, pas: Double,
                                     _ p: Palette) {
    ctx.setStrokeColor(p.panneauJaune)
    ctx.setLineWidth(5)
    ctx.setLineJoin(.miter)
    ctx.beginPath()
    ctx.move(to: CGPoint(x: x0 + 2, y: haut))
    var y = haut
    var aDroite = true
    while y < bas {
        y += pas
        ctx.addLine(to: CGPoint(x: aDroite ? x1 - 2 : x0 + 2, y: min(y, bas)))
        aDroite = !aDroite
    }
    ctx.strokePath()
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
    // 15. Chargement débordant, vu de profil. L'énoncé est réduit à « Ce chargement : » et
    //     ne dit surtout pas de quel côté il déborde : c'est toute la question. R312-22
    //     n'accorde **rien** à l'avant, R312-21 accorde 3 m à l'arrière, donc sans l'image
    //     « interdit » et « 3 m » sont aussi défendables l'un que l'autre. Le pare-brise de
    //     la caisse et la flèche d'intention donnent le sens de la marche ; le débord est
    //     du côté opposé, et il ne dépasse jamais l'aplomb avant — sinon la scène
    //     contredirait la bonne réponse.
    ("chargement-depassement-arriere", { ctx, p in
        chausseeDeProfil(ctx, p)
        let cxVoiture = 250.0, cyVoiture = solProfil - 28
        voitureDeProfilDouble(ctx, x: cxVoiture, y: cyVoiture, couleur: p.vous, p)
        // Les planches : un bloc à contour sombre, posé sur le pavillon et empiétant sur lui
        // de six unités — sans ce recouvrement le chargement paraît flotter. La teinte est
        // choisie **par la mesure**, pas par goût (§13 de `methode.md`, relevés en fin de
        // ligne dans `images.md`) : la caisse du candidat pèse 128,6 en niveaux de gris et le
        // fond 235,1 en clair, donc `panneauFond` (255,0, à 19,9 points du fond) l'aurait
        // fait disparaître sur le fond et `bordure` (139,1, à 10,5 de la caisse) l'aurait
        // fondu dans la caisse. `panneauJaune` mesure 198,1 en clair et 209,5 en sombre :
        // à 37,0 et 172,3 points du fond, à 69,5 et 80,9 de la caisse.
        let charge = CGRect(x: 142, y: 128, width: 138, height: 18)
        ctx.setFillColor(p.panneauJaune)
        ctx.fill(charge)
        ctx.setStrokeColor(traitSombre)
        ctx.setLineWidth(2)
        ctx.stroke(charge)
        // Un refend, pas deux : à deux, le bloc se lisait comme une barrière plutôt que
        // comme des pièces de grande longueur empilées.
        ctx.setFillColor(traitSombre)
        ctx.fill(CGRect(x: charge.minX + 2, y: 136.5, width: charge.width - 4, height: 1.5))
        // Les sangles, au-dessus du pavillon seulement : c'est là que le chargement est
        // amarré, et l'`alt` le dit.
        for x in [228.0, 262.0] {
            ctx.fill(CGRect(x: x, y: 126, width: 3, height: 22))
        }
        fleche(ctx, [CGPoint(x: 322, y: 168), CGPoint(x: 382, y: 168)], couleur: p.vous)
    }),

    // 16. `siege-enfant-place-avant` a existé ici, en coupe d'habitacle (pare-brise,
    //     tableau de bord, coque asymétrique dos à la route). Retirée le 2026-08-25
    //     (ronde 1 de revue) : la relecture, en clair, en sombre et en niveaux de gris, n'y
    //     voyait que quatre rectangles — rien n'identifiait la coque, pas de silhouette
    //     arrondie, et le rebord de pied se lisait aussi bien comme un petit dossier. Le
    //     §13 de `methode.md` avait mesuré que chaque forme se **détachait** des autres ;
    //     ça ne garantissait pas que la scène se **lise**, et c'est ce que la revue a
    //     tranché. Les deux faits que l'image devait porter — la place (avant) et le sens
    //     (dos à la route) — sont passés dans l'énoncé de la question, qui n'est donc plus
    //     illustrée. Voir `Tools/images.md` pour le détail des trois cadrages essayés.

    // MARK: - Usagers & partage de la route (tâche 15)

    // 17. L'angle mort d'un poids lourd, vu de dessus. Cette scène est la raison d'être du
    //     topic : un angle mort ne se décrit pas, et l'énoncé « À cette place, le mieux est
    //     de : » ne désigne rien sans elle. Ce qui porte la réponse — la voiture du candidat
    //     et la zone hachurée qui l'enveloppe — est au **centre vertical** (y de 120 à 205),
    //     dans la bande qui survit au recadrage à 18 %. Les zones avant et arrière sont, à
    //     l'inverse, aux bords du cadre : elles disparaissent au verdict, et c'est voulu,
    //     elles ne sont que du décor.
    //
    //     Les quatre zones ne sont pas dessinées d'après une norme — aucun texte ne cote un
    //     angle mort. Elles suivent le partage de la signalisation que R313-32-1 rend
    //     obligatoire depuis le 1er janvier 2021 sur les côtés et à l'arrière de tout
    //     véhicule de plus de 3,5 t : flanc droit large, flanc gauche étroit, un carré
    //     devant la cabine, un rectangle derrière la caisse.
    ("angle-mort-poids-lourd", { ctx, p in
        fond(ctx, p)
        ctx.setFillColor(p.chaussee)
        ctx.fill(CGRect(x: 130, y: 0, width: 138, height: H))
        // Rives continues : sans bande d'arrêt d'urgence, « la ligne de rive est continue »
        // (IISR, 7e partie, art. 114-4, B).
        ctx.setFillColor(p.marquage)
        for x in [131.5, 265.5] { ctx.fill(CGRect(x: x, y: 0, width: 3, height: H)) }
        // Deux lignes de délimitation de voies, de type T1 : les vides dominent, trois pour
        // un (art. 113-1, B), et c'est ce rapport qui les distingue d'une rive.
        for xVoie in [176.0, 222.0] {
            var y = 6.0
            while y < H {
                ctx.fill(CGRect(x: xVoie - 1.5, y: y, width: 3, height: 16))
                y += 64
            }
        }
        // Les zones non vues, posées sous les véhicules.
        zoneNonVue(ctx, CGRect(x: 214.5, y: 120, width: 51, height: 120), p)   // flanc droit
        zoneNonVue(ctx, CGRect(x: 158, y: 130, width: 25.5, height: 85), p)    // flanc gauche
        zoneNonVue(ctx, CGRect(x: 183.5, y: 62, width: 31, height: 28), p)     // devant
        zoneNonVue(ctx, CGRect(x: 183.5, y: 210, width: 31, height: 42), p)    // derrière
        poidsLourdVuDeDessus(ctx, x: 199, y: 150, longueur: 120, largeur: 31,
                             couleur: p.autre, p)
        voiture(ctx, x: 245, y: 165, cap: .nord, couleur: p.vous, liseree: true, p)
    }),

    // 18. L'écart latéral de dépassement d'un cycliste. Le §9 de `methode.md` demande qu'une
    //     option renvoie à quelque chose que **seule** l'image apporte : ici c'est le lieu.
    //     R414-4, IV impose un mètre en agglomération et un mètre et demi hors
    //     agglomération ; l'énoncé ne dit pas où l'on est, et c'est la rue — deux trottoirs,
    //     deux bordures — qui le dit. Retirer l'image rendrait la question indécidable, ce
    //     qui est exactement le critère.
    //
    //     L'écart dessiné vaut **32,75 unités, soit 1,02 m** à 32 unités par mètre : le
    //     dépassement montré est donc licite. Une scène qui montrerait un dépassement trop
    //     serré rendrait fausse la bonne réponse de sa propre question — même piège que le
    //     chargement de la scène 15.
    ("depassement-cycliste-distance", { ctx, p in
        // Deux voies de 3,5 m (112 unités) et non de 3 m : au premier jet, une voie de 3 m
        // obligeait la voiture à chevaucher l'axe pour laisser son mètre, ce qui ajoutait à
        // la scène une seconde question — celle du franchissement — que l'énoncé ne pose
        // pas. La voie large garde le dépassement entièrement à droite de l'axe.
        rueBordeeDeDeuxTrottoirs(ctx, gauche: 78, droite: 302, bordure: 22, axe: 190,
                                 pas: 40, p)
        // Trois piétons sur les trottoirs : ils ne jouent aucun rôle dans la manœuvre, ils
        // qualifient le lieu. C'est le seul élément de la scène qui dise « agglomération »
        // autrement que par une bordure, et l'agglomération est ce dont dépend la réponse.
        pietonVuDeDessus(ctx, x: 344, y: 118, taille: 30, couleur: p.tiers, p)
        pietonVuDeDessus(ctx, x: 366, y: 186, taille: 30, couleur: p.tiers, p)
        pietonVuDeDessus(ctx, x: 30, y: 152, taille: 30, couleur: p.tiers, p)
        cyclisteVuDeDessus(ctx, x: 280, y: 125, longueur: 55, couleur: p.autre, p)
        // La voiture au double de sa taille : la primitive est cotée pour les scènes de
        // carrefour, à 12 unités par mètre, et celle-ci en compte 32.
        ctx.saveGState()
        ctx.translateBy(x: 216, y: 172)
        ctx.scaleBy(x: 2, y: 2)
        voiture(ctx, x: 0, y: 0, cap: .nord, couleur: p.vous, liseree: true, p)
        ctx.restoreGState()
    }),

    // 19. Le sas cycliste et ses **deux** lignes d'arrêt. L'IISR, 7e partie, art. 118-1, D
    //     les décrit mot pour mot : le sas est délimité « à l'avant, par une ligne d'effet
    //     des feux (T'2, 15 cm) tracée à l'aplomb ou en retrait du feu tricolore ou par un
    //     passage pour piétons ; à l'arrière, par une seconde ligne d'effet des feux (T'2,
    //     15 cm) tracée de 3 à 5 mètres en amont de la première ». Les deux lignes sont ici
    //     à 48 unités, soit 3 m, la borne basse — c'est la seule qui garde les deux lignes
    //     dans la bande centrale.
    //
    //     Ce que l'image apporte et que l'énoncé ne dit pas : qu'il y a **deux** lignes. Un
    //     énoncé qui l'écrirait aurait déjà donné sa réponse.
    ("sas-cycliste-feu", { ctx, p in
        rueBordeeDeDeuxTrottoirs(ctx, gauche: 136, droite: 264, bordure: 12, axe: 200,
                                 pas: 26, p)
        passagePourPietons(ctx, de: 136, a: 264, haut: 106, bas: 146, bande: 8, pas: 16, p)
        ligneDEffetDesFeux(ctx, de: 200, a: 264, y: 152, trait: 8, epaisseur: 4, p)
        ligneDEffetDesFeux(ctx, de: 200, a: 264, y: 200, trait: 8, epaisseur: 4, p)
        // La bande cyclable d'accès au sas, en aval de la seconde ligne : « en présence
        // d'une bande cyclable ou d'une amorce de bande » (art. 118-1, D).
        ctx.setFillColor(p.marquage)
        var yBande = 204.0
        while yBande < H {
            ctx.fill(CGRect(x: 246.5, y: yBande, width: 3, height: 12))
            yBande += 24
        }
        // La figurine au sol, dans l'axe de la voie automobile (art. 118-1, D). Le
        // pictogramme est celui du C113 : un vélo de profil, ici tourné dans le sens de la
        // marche — un quart de tour, et non un second dessin.
        ctx.saveGState()
        ctx.translateBy(x: 232, y: 176)
        ctx.rotate(by: -.pi / 2)
        silhouetteVelo(ctx, at: .zero, largeur: 30, p.marquage)
        ctx.restoreGState()
        feuTricolore(ctx, at: CGPoint(x: 288, y: 138), largeur: 28,
                     [.allumee, .eteinte, .eteinte], p)
        // Un cycliste remonte la bande d'accès : c'est lui qui explique à quoi sert
        // l'espace réservé, et il est le seul véhicule de la scène. La voiture du candidat
        // y a figuré au premier jet, arrêtée en amont de la seconde ligne — elle **montrait
        // la bonne réponse**. Toute position correcte de cette voiture donne la réponse, et
        // toute position incorrecte contredirait l'explication : la scène se tient mieux
        // sans elle.
        cyclisteVuDeDessus(ctx, x: 256, y: 240, longueur: 27, couleur: p.autre, p)
    }),

    // 20. Le bus qui quitte son arrêt. Trois choses portent la réponse, et toutes trois sont
    //     dans la bande centrale : le **zigzag jaune** sur la bordure, qui fait de cet
    //     emplacement un arrêt « signalé comme tel » au sens de R412-11 ; le **clignotant
    //     allumé** côté chaussée, qui dit l'intention de repartir ; et les **deux
    //     trottoirs**, qui disent l'agglomération — R412-11 ne joue pas ailleurs.
    //
    //     Aucune de ces trois informations ne repose sur une teinte : un zigzag est une
    //     forme, des traits rayonnants sont une forme, une bordure est une surface.
    ("bus-quittant-arret", { ctx, p in
        rueBordeeDeDeuxTrottoirs(ctx, gauche: 152, droite: 248, bordure: 12, axe: 200,
                                 pas: 24, p)
        zigzagJauneSurLaBordure(ctx, de: 248, a: 260, haut: 45, bas: 180, pas: 18, p)
        // Deux piétons à l'abri de l'arrêt : même rôle qu'en scène 18, qualifier le lieu.
        // R412-11 ne joue qu'« en agglomération », et rien d'autre ici ne le dit.
        pietonVuDeDessus(ctx, x: 288, y: 124, taille: 28, couleur: p.autre, p)
        pietonVuDeDessus(ctx, x: 312, y: 152, taille: 28, couleur: p.autre, p)
        busVuDeDessus(ctx, x: 230, y: 110, longueur: 120, largeur: 30, couleur: p.tiers, p)
        clignotantAllume(ctx, at: CGPoint(x: 215, y: 162), rayon: 4.5, versLaGauche: true, p)
        clignotantAllume(ctx, at: CGPoint(x: 215, y: 58), rayon: 4.5, versLaGauche: true, p)
        voiture(ctx, x: 224, y: 215, cap: .nord, couleur: p.vous, liseree: true, p)
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
