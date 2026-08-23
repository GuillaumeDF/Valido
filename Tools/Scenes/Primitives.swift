import CoreGraphics
import CoreText
import Foundation

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

/// Un tramway vu de dessus : caisse deux fois plus longue qu'une voiture, deux
/// articulations en travers, pare-brise à l'avant. C'est la longueur et les rails
/// dessous — jamais la teinte — qui le désignent comme tramway.
func tramway(_ ctx: CGContext, x: Double, y: Double, cap: Cap, couleur: CGColor,
             _ p: Palette) {
    let long = 88.0, larg = 26.0
    let horizontal = (cap == .est || cap == .ouest)
    let rect = CGRect(x: x - (horizontal ? long : larg) / 2,
                      y: y - (horizontal ? larg : long) / 2,
                      width: horizontal ? long : larg,
                      height: horizontal ? larg : long)
    ctx.setFillColor(couleur)
    ctx.addPath(CGPath(roundedRect: rect, cornerWidth: 7, cornerHeight: 7, transform: nil))
    ctx.fillPath()
    // Les articulations : c'est ce qui fait lire une rame plutôt qu'un camion.
    ctx.setFillColor(CGColor(gray: 0, alpha: 0.22))
    for t in [1.0 / 3, 2.0 / 3] {
        if horizontal {
            ctx.fill(CGRect(x: rect.minX + rect.width * t - 1.5, y: rect.minY,
                            width: 3, height: rect.height))
        } else {
            ctx.fill(CGRect(x: rect.minX, y: rect.minY + rect.height * t - 1.5,
                            width: rect.width, height: 3))
        }
    }
    ctx.setFillColor(CGColor(gray: 1, alpha: 0.55))
    let e = 6.0
    switch cap {
    case .nord: ctx.fill(CGRect(x: rect.minX + e, y: rect.minY + 5, width: rect.width - 2 * e, height: 8))
    case .sud:  ctx.fill(CGRect(x: rect.minX + e, y: rect.maxY - 13, width: rect.width - 2 * e, height: 8))
    case .est:  ctx.fill(CGRect(x: rect.maxX - 13, y: rect.minY + e, width: 8, height: rect.height - 2 * e))
    case .ouest: ctx.fill(CGRect(x: rect.minX + 5, y: rect.minY + e, width: 8, height: rect.height - 2 * e))
    }
}

/// Une voiture vue **de côté**, posée sur une chaussée inclinée de `pente` radians.
/// Vue de dessus, une pente ne se voit pas : c'est toute la raison d'être de cette
/// primitive, et la seule scène de profil du dossier s'en sert. Le pavillon est décalé
/// vers l'avant, comme le pare-brise sur la vue de dessus, pour que le sens de marche se
/// lise sans flèche.
func voitureDeProfil(_ ctx: CGContext, x: Double, y: Double, pente: Double,
                     versLaDroite: Bool, couleur: CGColor, liseree: Bool = false,
                     _ p: Palette) {
    ctx.saveGState()
    ctx.translateBy(x: x, y: y)
    ctx.rotate(by: pente)
    // Miroir plutôt qu'une seconde géométrie : la caisse est symétrique, seul le pavillon
    // et le pare-brise portent le sens de marche.
    if !versLaDroite { ctx.scaleBy(x: -1, y: 1) }
    let caisse = CGPath(roundedRect: CGRect(x: -24, y: -8, width: 48, height: 16),
                        cornerWidth: 5, cornerHeight: 5, transform: nil)
    let pavillon = CGPath(roundedRect: CGRect(x: -13, y: -17, width: 25, height: 11),
                          cornerWidth: 4, cornerHeight: 4, transform: nil)
    ctx.setFillColor(couleur)
    ctx.addPath(caisse)
    ctx.addPath(pavillon)
    ctx.fillPath()
    if liseree {
        ctx.setStrokeColor(p.marquage)
        ctx.setLineWidth(2.5)
        ctx.addPath(caisse)
        ctx.addPath(pavillon)
        ctx.strokePath()
    }
    ctx.setFillColor(CGColor(gray: 1, alpha: 0.55))
    ctx.fill(CGRect(x: 3, y: -15, width: 7, height: 7))
    // Roues : un noir presque plein, cerné d'un filet clair pour rester visible sur la
    // chaussée du mode sombre.
    for rx in [-14.0, 14.0] {
        let roue = CGRect(x: rx - 6, y: 2, width: 12, height: 12)
        ctx.setFillColor(CGColor(gray: 0.10, alpha: 1))
        ctx.fillEllipse(in: roue)
        ctx.setStrokeColor(CGColor(gray: 1, alpha: 0.35))
        ctx.setLineWidth(1)
        ctx.strokeEllipse(in: roue)
    }
    ctx.restoreGState()
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

/// Voie ferrée posée dans l'axe de la chaussée horizontale : deux rails continus qui
/// traversent le carrefour de part en part. Ils **remplacent** l'axe médian en
/// pointillés — une rue à plateforme de tramway n'a pas les deux — et c'est leur
/// continuité, opposée au pointillé d'un marquage, qui les fait lire comme des rails.
func railsHorizontaux(_ ctx: CGContext, _ p: Palette) {
    ctx.setFillColor(p.marquage)
    for dy in [-9.0, 9.0] {
        ctx.fill(CGRect(x: 0, y: cy + dy - 1.5, width: W, height: 3))
    }
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
