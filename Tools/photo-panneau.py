#!/usr/bin/env python3
"""Prépare un imageset photographique à partir d'une source Commons.

    uv run --with pillow Tools/photo-panneau.py source.jpg panneau-b21b-tout-droit \
        --centre 1840,1120 --largeur 2400

Recadre en 4:3 autour du centre donné, sort les deux échelles, et dérive la
variante sombre. `sips` ne sait pas baisser une luminosité, d'où Pillow.
"""
import argparse
import json
import os

from PIL import Image, ImageEnhance

# La taille @3x du bandeau sur l'iPhone visé : 378 pt de large, ratio 4:3.
LARGEUR_3X, HAUTEUR_3X = 1152, 864
LARGEUR_2X, HAUTEUR_2X = 768, 576
QUALITE = 82
# Le mode sombre d'une photographie est dérivé, pas photographié : une image
# livrée telle quelle éblouit dans une app sombre.
EXPOSITION_SOMBRE = 0.62

SCENES = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                      '..', 'Valido', 'Assets.xcassets', 'Scenes')


def recadre(im, cx, cy, largeur):
    hauteur = round(largeur * 3 / 4)
    gauche, haut = cx - largeur // 2, cy - hauteur // 2
    if gauche < 0 or haut < 0 or gauche + largeur > im.width or haut + hauteur > im.height:
        raise SystemExit(f"recadrage hors de l'image ({im.width} × {im.height})")
    if largeur < LARGEUR_3X:
        raise SystemExit(f"recadrage de {largeur} px : il en faut {LARGEUR_3X}")
    return im.crop((gauche, haut, gauche + largeur, haut + hauteur))


def ecris(im, chemin, taille):
    im.resize(taille, Image.LANCZOS).convert("RGB").save(
        chemin, "JPEG", quality=QUALITE, optimize=True)


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("source")
    ap.add_argument("asset")
    ap.add_argument("--centre", required=True, metavar="X,Y")
    ap.add_argument("--largeur", required=True, type=int)
    args = ap.parse_args()

    cx, cy = (int(v) for v in args.centre.split(","))
    clair = recadre(Image.open(args.source), cx, cy, args.largeur)
    sombre = ImageEnhance.Brightness(clair).enhance(EXPOSITION_SOMBRE)

    dossier = os.path.join(SCENES, args.asset + ".imageset")
    os.makedirs(dossier, exist_ok=True)
    for im, nom in ((clair, "clair"), (sombre, "sombre")):
        ecris(im, os.path.join(dossier, f"{nom}@3x.jpg"), (LARGEUR_3X, HAUTEUR_3X))
        ecris(im, os.path.join(dossier, f"{nom}@2x.jpg"), (LARGEUR_2X, HAUTEUR_2X))

    contents = {"images": [
        {"filename": "clair@2x.jpg", "idiom": "universal", "scale": "2x"},
        {"filename": "clair@3x.jpg", "idiom": "universal", "scale": "3x"},
        {"appearances": [{"appearance": "luminosity", "value": "dark"}],
         "filename": "sombre@2x.jpg", "idiom": "universal", "scale": "2x"},
        {"appearances": [{"appearance": "luminosity", "value": "dark"}],
         "filename": "sombre@3x.jpg", "idiom": "universal", "scale": "3x"},
    ], "info": {"author": "xcode", "version": 1}}
    with open(os.path.join(dossier, "Contents.json"), "w") as f:
        json.dump(contents, f, indent=2)
        f.write("\n")
    print(f"{args.asset} : quatre JPEG écrits dans {dossier}")


if __name__ == "__main__":
    main()
