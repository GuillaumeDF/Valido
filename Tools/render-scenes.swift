import AppKit
import CoreGraphics
import CoreText
import Foundation

// Schémas de situation pour les questions illustrées — mêmes principes que
// `design/logo/render-icon.swift` : CoreGraphics, un repère logique fixe, et des PNG
// posés directement dans le catalogue d'assets.
//
// Repère logique : 400 × 300 (4:3), y vers le bas. Ce ratio n'est pas décoratif — le
// bandeau de `QuestionCardView` passe de 38 % à 18 % de la hauteur de carte au verdict,
// et recadre en `.fill`. La géométrie décisive (le carrefour) est donc au centre
// vertical, dans la bande qui survit au recadrage.
//
// Usage : swift Tools/render-scenes.swift

// MARK: - Repère

let W = 400.0, H = 300.0
/// Demi-largeur de chaussée : une voie de 42 par sens. Chaussée plus étroite que le
/// premier jet, pour une raison de cadrage : les véhicules doivent tenir au seuil du
/// carrefour *et* dans la bande centrale qui survit au recadrage à 18 %.
let voie = 42.0
let cx = W / 2, cy = H / 2

struct Palette {
    let sol, chaussee, marquage, vous, autre, tiers, ilot, panneauRouge, panneauJaune,
        panneauFond: CGColor
}

func rgb(_ r: Double, _ g: Double, _ b: Double, _ a: Double = 1) -> CGColor {
    CGColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
}

let clair = Palette(
    sol: rgb(232, 230, 225), chaussee: rgb(74, 74, 79), marquage: rgb(255, 255, 255),
    vous: rgb(10, 132, 255), autre: rgb(240, 160, 32), tiers: rgb(224, 65, 62),
    ilot: rgb(201, 216, 192), panneauRouge: rgb(200, 30, 40), panneauJaune: rgb(250, 190, 20),
    panneauFond: rgb(255, 255, 255))

let sombre = Palette(
    sol: rgb(28, 28, 30), chaussee: rgb(58, 58, 60), marquage: rgb(229, 229, 234),
    vous: rgb(10, 132, 255), autre: rgb(255, 179, 64), tiers: rgb(255, 105, 97),
    ilot: rgb(44, 58, 44), panneauRouge: rgb(220, 60, 70), panneauJaune: rgb(255, 204, 40),
    panneauFond: rgb(242, 242, 247))

// MARK: - Primitives

func chausseeVerticale(_ ctx: CGContext, _ p: Palette) {
    ctx.setFillColor(p.chaussee)
    ctx.fill(CGRect(x: cx - voie, y: 0, width: voie * 2, height: H))
}

/// Branche sud seule : le pied d'un carrefour en T.
func chausseeSud(_ ctx: CGContext, _ p: Palette) {
    ctx.setFillColor(p.chaussee)
    ctx.fill(CGRect(x: cx - voie, y: cy - voie, width: voie * 2, height: H - cy + voie))
}

func chausseeHorizontale(_ ctx: CGContext, _ p: Palette) {
    ctx.setFillColor(p.chaussee)
    ctx.fill(CGRect(x: 0, y: cy - voie, width: W, height: voie * 2))
}

/// Axe médian en pointillés, interrompu dans le carrefour — c'est ce blanc qui fait lire
/// une image comme une route plutôt que comme deux rectangles gris.
func axeVertical(_ ctx: CGContext, _ p: Palette) {
    ctx.setFillColor(p.marquage)
    var y = 4.0
    while y < H {
        if !(y + 14 > cy - voie && y < cy + voie) {
            ctx.fill(CGRect(x: cx - 1.5, y: y, width: 3, height: 14))
        }
        y += 24
    }
}

func axeSud(_ ctx: CGContext, _ p: Palette) {
    ctx.setFillColor(p.marquage)
    var y = cy + voie + 6
    while y < H {
        ctx.fill(CGRect(x: cx - 1.5, y: y, width: 3, height: 14))
        y += 24
    }
}

func axeHorizontal(_ ctx: CGContext, _ p: Palette) {
    ctx.setFillColor(p.marquage)
    var x = 4.0
    while x < W {
        if !(x + 14 > cx - voie && x < cx + voie) {
            ctx.fill(CGRect(x: x, y: cy - 1.5, width: 14, height: 3))
        }
        x += 24
    }
}

enum Cap { case nord, sud, est, ouest }

/// Une voiture vue de dessus : caisse arrondie, pare-brise clair, et un liseré blanc
/// réservé au véhicule du candidat. Aucune information ne repose sur la seule couleur —
/// les options des questions désignent les véhicules par leur provenance.
func voiture(_ ctx: CGContext, x: Double, y: Double, cap: Cap, couleur: CGColor,
             liseree: Bool = false, _ p: Palette) {
    let long = 40.0, larg = 22.0
    let horizontal = (cap == .est || cap == .ouest)
    let rect = CGRect(x: x - (horizontal ? long : larg) / 2,
                      y: y - (horizontal ? larg : long) / 2,
                      width: horizontal ? long : larg,
                      height: horizontal ? larg : long)
    let corps = CGPath(roundedRect: rect, cornerWidth: 6, cornerHeight: 6, transform: nil)
    ctx.setFillColor(couleur)
    ctx.addPath(corps)
    ctx.fillPath()
    if liseree {
        ctx.setStrokeColor(p.marquage)
        ctx.setLineWidth(2.5)
        ctx.addPath(corps)
        ctx.strokePath()
    }
    // Pare-brise : côté avant, pour que le sens de marche se lise sans flèche.
    ctx.setFillColor(CGColor(gray: 1, alpha: 0.55))
    let e = 5.0
    let pb: CGRect
    switch cap {
    case .nord: pb = CGRect(x: rect.minX + e, y: rect.minY + 5, width: rect.width - 2 * e, height: 7)
    case .sud:  pb = CGRect(x: rect.minX + e, y: rect.maxY - 12, width: rect.width - 2 * e, height: 7)
    case .est:  pb = CGRect(x: rect.maxX - 12, y: rect.minY + e, width: 7, height: rect.height - 2 * e)
    case .ouest: pb = CGRect(x: rect.minX + 5, y: rect.minY + e, width: 7, height: rect.height - 2 * e)
    }
    ctx.fill(pb)
}

/// Flèche d'intention : ce que le véhicule s'apprête à faire. Sans elle, « qui passe en
/// premier » reste indécidable dès qu'un des deux tourne.
func fleche(_ ctx: CGContext, _ points: [CGPoint], couleur: CGColor) {
    guard points.count >= 2 else { return }
    ctx.setStrokeColor(couleur)
    ctx.setLineWidth(3.5)
    ctx.setLineCap(.round)
    ctx.setLineJoin(.round)
    ctx.beginPath()
    ctx.move(to: points[0])
    for pt in points.dropFirst() { ctx.addLine(to: pt) }
    ctx.strokePath()

    let a = points[points.count - 2], b = points[points.count - 1]
    let dx = b.x - a.x, dy = b.y - a.y
    let n = max(hypot(dx, dy), 0.001)
    let ux = dx / n, uy = dy / n
    let t = 8.0
    ctx.setFillColor(couleur)
    ctx.beginPath()
    ctx.move(to: b)
    ctx.addLine(to: CGPoint(x: b.x - ux * t - uy * t * 0.6, y: b.y - uy * t + ux * t * 0.6))
    ctx.addLine(to: CGPoint(x: b.x - ux * t + uy * t * 0.6, y: b.y - uy * t - ux * t * 0.6))
    ctx.closePath()
    ctx.fillPath()
}

func texte(_ ctx: CGContext, _ chaine: String, centre: CGPoint, taille: Double, couleur: CGColor) {
    let font = CTFontCreateWithName("Helvetica-Bold" as CFString, taille, nil)
    let attrs: [NSAttributedString.Key: Any] = [
        .font: font,
        .foregroundColor: couleur,
    ]
    let line = CTLineCreateWithAttributedString(
        NSAttributedString(string: chaine, attributes: attrs))
    let bounds = CTLineGetBoundsWithOptions(line, .useGlyphPathBounds)
    // Le contexte est retourné (y vers le bas) : le texte se dessine dans un repère
    // remis d'aplomb localement, sinon les glyphes sortent en miroir.
    ctx.saveGState()
    ctx.translateBy(x: centre.x, y: centre.y)
    ctx.scaleBy(x: 1, y: -1)
    ctx.textPosition = CGPoint(x: -bounds.width / 2 - bounds.minX,
                               y: -bounds.height / 2 - bounds.minY)
    CTLineDraw(line, ctx)
    ctx.restoreGState()
}

/// Ligne d'arrêt du STOP : un trait continu large, en travers de la voie d'approche.
func ligneDArret(_ ctx: CGContext, _ p: Palette) {
    ctx.setFillColor(p.marquage)
    ctx.fill(CGRect(x: cx, y: cy + voie - 5, width: voie, height: 5))
}

/// Ligne de cédez-le-passage : discontinue à traits larges, ce qui la distingue à l'œil
/// de la ligne d'arrêt continue du STOP.
func ligneDeCedez(_ ctx: CGContext, _ p: Palette) {
    ctx.setFillColor(p.marquage)
    var x = cx + 3.0
    while x < cx + voie {
        ctx.fill(CGRect(x: x, y: cy + voie - 5, width: 9, height: 5))
        x += 15
    }
}

func panneauStop(_ ctx: CGContext, at pt: CGPoint, _ p: Palette) {
    let r = 15.0
    let path = CGMutablePath()
    for i in 0..<8 {
        let a = Double(i) * .pi / 4 + .pi / 8
        let q = CGPoint(x: pt.x + cos(a) * r, y: pt.y + sin(a) * r)
        i == 0 ? path.move(to: q) : path.addLine(to: q)
    }
    path.closeSubpath()
    ctx.setFillColor(p.panneauRouge)
    ctx.addPath(path)
    ctx.fillPath()
    texte(ctx, "STOP", centre: pt, taille: 8, couleur: p.panneauFond)
}

func panneauCedez(_ ctx: CGContext, at pt: CGPoint, _ p: Palette) {
    let r = 17.0
    func triangle(_ k: Double) -> CGPath {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: pt.x - r * k, y: pt.y - r * k * 0.72))
        path.addLine(to: CGPoint(x: pt.x + r * k, y: pt.y - r * k * 0.72))
        path.addLine(to: CGPoint(x: pt.x, y: pt.y + r * k * 0.95))
        path.closeSubpath()
        return path
    }
    ctx.setFillColor(p.panneauRouge)
    ctx.addPath(triangle(1))
    ctx.fillPath()
    ctx.setFillColor(p.panneauFond)
    ctx.addPath(triangle(0.62))
    ctx.fillPath()
}

/// AB6, caractère prioritaire d'une route : un carré posé sur la pointe, fond blanc,
/// losange jaune au centre. C'est le pendant exact de la priorité à droite — même
/// carrefour, réponse inverse.
func panneauRoutePrioritaire(_ ctx: CGContext, at pt: CGPoint, _ p: Palette) {
    func losange(_ r: Double) -> CGPath {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: pt.x, y: pt.y - r))
        path.addLine(to: CGPoint(x: pt.x + r, y: pt.y))
        path.addLine(to: CGPoint(x: pt.x, y: pt.y + r))
        path.addLine(to: CGPoint(x: pt.x - r, y: pt.y))
        path.closeSubpath()
        return path
    }
    ctx.setFillColor(p.panneauFond)
    ctx.addPath(losange(17))
    ctx.fillPath()
    ctx.setFillColor(p.panneauJaune)
    ctx.addPath(losange(10))
    ctx.fillPath()
}

// MARK: - Les scènes

typealias Scene = (CGContext, Palette) -> Void

/// Voie du candidat : moitié droite de la chaussée verticale, en montant.
let voieVous = cx + voie / 2
/// Demi-longueur d'une voiture. Les véhicules sont posés nez au bord du carrefour :
/// c'est la situation que l'ETG montre, et c'est ce qui les garde dans la bande centrale
/// visible après le rétrécissement du bandeau.
let demiVoiture = 20.0
let seuilSud = cy + voie + demiVoiture
let seuilNord = cy - voie - demiVoiture
let seuilEst = cx + voie + demiVoiture
let seuilOuest = cx - voie - demiVoiture
/// Voie de qui arrive de la droite en allant vers l'ouest : moitié haute.
let voieDepuisLaDroite = cy - voie / 2
/// Voie de qui arrive de la gauche en allant vers l'est : moitié basse.
let voieDepuisLaGauche = cy + voie / 2
/// Voie de qui vient d'en face, en descendant : moitié gauche.
let voieDenFace = cx - voie / 2

func fond(_ ctx: CGContext, _ p: Palette) {
    ctx.setFillColor(p.sol)
    ctx.fill(CGRect(x: 0, y: 0, width: W, height: H))
}

func croisementNu(_ ctx: CGContext, _ p: Palette) {
    fond(ctx, p)
    chausseeHorizontale(ctx, p)
    chausseeVerticale(ctx, p)
    axeHorizontal(ctx, p)
    axeVertical(ctx, p)
}

let scenes: [(String, Scene)] = [

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
    ("rond-point-insertion", { ctx, p in
        fond(ctx, p)
        chausseeHorizontale(ctx, p)
        chausseeVerticale(ctx, p)
        axeHorizontal(ctx, p)
        axeVertical(ctx, p)
        // L'anneau recouvre le croisement : c'est lui qui porte la règle.
        let r = 72.0
        ctx.setFillColor(p.chaussee)
        ctx.fillEllipse(in: CGRect(x: cx - r, y: cy - r, width: r * 2, height: r * 2))
        ctx.setFillColor(p.ilot)
        ctx.fillEllipse(in: CGRect(x: cx - 32, y: cy - 32, width: 64, height: 64))
        ctx.setStrokeColor(p.marquage)
        ctx.setLineWidth(2)
        ctx.setLineDash(phase: 0, lengths: [7, 7])
        ctx.strokeEllipse(in: CGRect(x: cx - r, y: cy - r, width: r * 2, height: r * 2))
        ctx.setLineDash(phase: 0, lengths: [])
        panneauCedez(ctx, at: CGPoint(x: cx + voie + 26, y: cy + r + 18), p)
        voiture(ctx, x: voieVous, y: cy + r + demiVoiture, cap: .nord, couleur: p.vous,
                liseree: true, p)
        // Déjà sur l'anneau, et c'est tout l'enjeu : on circule en France dans le sens
        // antihoraire, donc le véhicule qui coupe la route du candidat arrive **par sa
        // gauche**, à neuf heures, en descendant vers la branche sud.
        voiture(ctx, x: cx - 52, y: cy - 6, cap: .sud, couleur: p.autre, p)
        fleche(ctx, [CGPoint(x: cx - 52, y: cy + 20), CGPoint(x: cx - 34, y: cy + 46),
                     CGPoint(x: cx - 6, y: cy + 56)], couleur: p.autre)
    }),
]

// MARK: - Sortie

func rendre(_ scene: Scene, _ p: Palette, echelle: Double) -> CGImage? {
    let px = Int(W * echelle), py = Int(H * echelle)
    guard let ctx = CGContext(data: nil, width: px, height: py, bitsPerComponent: 8,
                              bytesPerRow: 0, space: CGColorSpaceCreateDeviceRGB(),
                              bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
    else { return nil }
    // Repère logique en y vers le bas, comme un SVG : toutes les scènes sont écrites ainsi.
    ctx.translateBy(x: 0, y: CGFloat(py))
    ctx.scaleBy(x: CGFloat(echelle), y: CGFloat(-echelle))
    ctx.setShouldAntialias(true)
    scene(ctx, p)
    return ctx.makeImage()
}

func ecrire(_ image: CGImage, _ url: URL) throws {
    let rep = NSBitmapImageRep(cgImage: image)
    guard let data = rep.representation(using: .png, properties: [:]) else {
        throw NSError(domain: "render-scenes", code: 1)
    }
    try data.write(to: url)
}

let racine = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    .appendingPathComponent("Valido/Assets.xcassets/Scenes")

let contents = """
{
  "images" : [
    { "filename" : "clair@2x.png", "idiom" : "universal", "scale" : "2x" },
    { "filename" : "clair@3x.png", "idiom" : "universal", "scale" : "3x" },
    { "appearances" : [ { "appearance" : "luminosity", "value" : "dark" } ],
      "filename" : "sombre@2x.png", "idiom" : "universal", "scale" : "2x" },
    { "appearances" : [ { "appearance" : "luminosity", "value" : "dark" } ],
      "filename" : "sombre@3x.png", "idiom" : "universal", "scale" : "3x" }
  ],
  "info" : { "author" : "xcode", "version" : 1 }
}

"""

try FileManager.default.createDirectory(at: racine, withIntermediateDirectories: true)
let contentsDeDossier = """
{
  "info" : { "author" : "xcode", "version" : 1 }
}

"""
try contentsDeDossier.write(to: racine.appendingPathComponent("Contents.json"),
                            atomically: true, encoding: .utf8)

for (nom, scene) in scenes {
    let dossier = racine.appendingPathComponent("\(nom).imageset")
    try FileManager.default.createDirectory(at: dossier, withIntermediateDirectories: true)
    try contents.write(to: dossier.appendingPathComponent("Contents.json"),
                       atomically: true, encoding: .utf8)
    for (suffixe, palette) in [("clair", clair), ("sombre", sombre)] {
        for echelle in [2.0, 3.0] {
            guard let image = rendre(scene, palette, echelle: echelle) else {
                FileHandle.standardError.write("échec du rendu \(nom) \(suffixe)\n".data(using: .utf8)!)
                exit(1)
            }
            try ecrire(image, dossier.appendingPathComponent("\(suffixe)@\(Int(echelle))x.png"))
        }
    }
    print("\(nom).imageset")
}
