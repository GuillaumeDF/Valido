import AppKit
import CoreGraphics
import Foundation

typealias Scene = (CGContext, Palette) -> Void

let scenes: [(String, Scene)] = scenesCarrefour + scenesCirculation

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
