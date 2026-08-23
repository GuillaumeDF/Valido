import AppKit
import CoreGraphics

// Icône Valido — « la carte cochée » : la carte du feed, avec la coche du verdict dedans.
// Repère de 100×100 en coordonnées SVG (y vers le bas), converties pour CoreGraphics.
struct Palette {
    let bg: CGColor, card: CGColor, check: CGColor, peek: CGColor
}

let anyP = Palette(
    bg:    CGColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1),
    card:  CGColor(red: 1, green: 1, blue: 1, alpha: 1),
    check: CGColor(red: 52/255, green: 199/255, blue: 89/255, alpha: 1),
    peek:  CGColor(red: 1, green: 1, blue: 1, alpha: 0.32))

let darkP = Palette(
    bg:    CGColor(red: 0, green: 0, blue: 0, alpha: 1),
    card:  CGColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1),
    check: CGColor(red: 48/255, green: 209/255, blue: 88/255, alpha: 1),
    peek:  CGColor(red: 1, green: 1, blue: 1, alpha: 0.22))

// Teintée : le système mappe la luminance sur sa teinte, donc tout en gris.
let tintedP = Palette(
    bg:    CGColor(red: 0, green: 0, blue: 0, alpha: 1),
    card:  CGColor(gray: 0.94, alpha: 1),
    check: CGColor(gray: 0.42, alpha: 1),
    peek:  CGColor(gray: 1, alpha: 0.24))

func rounded(_ x: CGFloat, _ ySVG: CGFloat, _ w: CGFloat, _ h: CGFloat, _ r: CGFloat) -> CGPath {
    CGPath(roundedRect: CGRect(x: x, y: 100 - ySVG - h, width: w, height: h),
           cornerWidth: r, cornerHeight: r, transform: nil)
}

func render(_ p: Palette, size: Int, to url: URL) {
    let s = CGFloat(size)
    guard let ctx = CGContext(data: nil, width: size, height: size, bitsPerComponent: 8,
                              bytesPerRow: 0, space: CGColorSpaceCreateDeviceRGB(),
                              bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else { return }
    ctx.setFillColor(p.bg)
    ctx.fill(CGRect(x: 0, y: 0, width: s, height: s))
    ctx.scaleBy(x: s / 100, y: s / 100)
    ctx.setLineCap(.round); ctx.setLineJoin(.round)

    // L'amorce de la carte suivante, derrière : ce qui dit « ça défile ».
    ctx.addPath(rounded(20, 76, 60, 40, 13)); ctx.setFillColor(p.peek); ctx.fillPath()
    // La carte courante.
    ctx.addPath(rounded(13, 17, 74, 52, 15)); ctx.setFillColor(p.card); ctx.fillPath()
    // La coche du verdict, dans la carte.
    ctx.setStrokeColor(p.check); ctx.setLineWidth(10)
    ctx.move(to: CGPoint(x: 36, y: 57))
    ctx.addLine(to: CGPoint(x: 46, y: 47))
    ctx.addLine(to: CGPoint(x: 65, y: 66))
    ctx.strokePath()

    guard let img = ctx.makeImage(),
          let dest = CGImageDestinationCreateWithURL(url as CFURL, "public.png" as CFString, 1, nil)
    else { return }
    CGImageDestinationAddImage(dest, img, nil)
    CGImageDestinationFinalize(dest)
}

let out = URL(fileURLWithPath: "/tmp/valido-icons")
for (name, p) in [("icon-any", anyP), ("icon-dark", darkP), ("icon-tinted", tintedP)] {
    render(p, size: 1024, to: out.appendingPathComponent("\(name).png"))
    // Aperçus pour contrôle à l'œil.
    for s in [180, 87, 58] {
        render(p, size: s, to: out.appendingPathComponent("\(name)-\(s).png"))
    }
}
print("rendu terminé")
