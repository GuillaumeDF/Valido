#!/usr/bin/env python3
"""Relevé de luminance sur une image livrée.

Rec. 709 — `Y = 0,2126 R + 0,7152 G + 0,0722 B` — jamais Rec. 601 : c'est la
convention de tous les relevés de `images.md`, et les deux formules divergent de
vingt points sur un rouge de panneau.

    uv run --with pillow Tools/luminance.py image.png --point 251,138 --zone 100,100,30
"""
import argparse

from PIL import Image


def luminance(pixel):
    r, g, b = pixel[:3]
    return 0.2126 * r + 0.7152 * g + 0.0722 * b


def point(im, x, y):
    return luminance(im.convert("RGB").getpixel((x, y)))


def zone(im, x, y, cote):
    rgb = im.convert("RGB")
    valeurs = [
        luminance(rgb.getpixel((i, j)))
        for i in range(x, x + cote)
        for j in range(y, y + cote)
    ]
    return sum(valeurs) / len(valeurs), min(valeurs), max(valeurs)


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("image")
    ap.add_argument("--point", action="append", default=[], metavar="X,Y")
    ap.add_argument("--zone", action="append", default=[], metavar="X,Y,COTE")
    args = ap.parse_args()

    im = Image.open(args.image)
    print(f"{args.image} — {im.width} × {im.height}")
    for spec in args.point:
        x, y = (int(v) for v in spec.split(","))
        print(f"  point {x},{y} : {point(im, x, y):.1f}")
    for spec in args.zone:
        x, y, cote = (int(v) for v in spec.split(","))
        moyenne, mini, maxi = zone(im, x, y, cote)
        print(f"  zone {x},{y} ({cote}×{cote}) : moyenne {moyenne:.1f}, "
              f"min {mini:.1f}, max {maxi:.1f}")


if __name__ == "__main__":
    main()
