#!/bin/sh
# Rendu des schémas des questions illustrées. Le script a été découpé en plusieurs
# fichiers quand le nombre de scènes a dépassé la dizaine : `swift Fichier.swift` ne
# compile qu'un fichier, d'où `swiftc`. Le code de haut niveau doit rester dans main.swift.
#
# Les PNG ne s'éditent jamais à la main : on édite la scène, on relance ceci.
set -e
BIN="$(mktemp -d)/render-scenes"
DEVELOPER_DIR="${DEVELOPER_DIR:-/Applications/Xcode-26.3.0.app}" \
  swiftc -O "$(dirname "$0")"/Scenes/*.swift -o "$BIN"
exec "$BIN"
