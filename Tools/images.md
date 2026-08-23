# Provenance des images

Une ligne par imageset de `Valido/Assets.xcassets/Scenes/`. `Tools/audit.py` refuse une
`illustration` dont l'asset n'a pas sa ligne ici : sans ce relevé une image est orpheline,
donc impossible à remplacer et impossible à re-sourcer si les conditions changent.

L'app est compilée en local, pour un seul usage, et n'est ni distribuée ni vendue. C'est
sur cette base que des images sous licence non permissive sont admissibles. **Le jour où
une diffusion est envisagée, ce tableau est la liste des choses à re-sourcer** — et la
colonne « licence » dit lesquelles passent telles quelles.

## Schémas dessinés

Aucune source externe : générés par `Tools/render-scenes.swift` (CoreGraphics), quatre
PNG par imageset — clair et sombre, en @2x et @3x. Pour les modifier, on édite la scène
dans le script et on relance `swift Tools/render-scenes.swift` ; les fichiers ne
s'éditent jamais à la main.

| asset | scène | licence |
|---|---|---|
| `carrefour-priorite-droite` | croisement nu, véhicule arrivant de la droite | maison, aucune source tierce |
| `carrefour-route-prioritaire` | même croisement, panneau AB6 sur l'approche | maison, aucune source tierce |
| `carrefour-stop` | STOP et ligne d'arrêt continue sur l'approche | maison, aucune source tierce |
| `carrefour-cedez-le-passage` | AB3a et ligne discontinue à traits larges | maison, aucune source tierce |
| `carrefour-en-t` | carrefour en T sans signalisation, insertion à droite | maison, aucune source tierce |
| `rond-point-insertion` | giratoire, véhicule déjà sur l'anneau par la gauche | maison, aucune source tierce |

Les formes de panneaux sont redessinées d'après la spécification officielle
(Instruction interministérielle sur la signalisation routière) : la géométrie d'un
panneau réglementaire est une norme publique, pas l'œuvre d'un éditeur. Aucun visuel
d'éditeur d'ETG n'a été repris, ni comme source ni comme modèle.

## Photographies

Recadrées en 4:3 puis sorties en @2x/@3x (`sips`), JPEG qualité 82. Le recadrage garde
l'élément décisif dans la bande centrale, celle qui survit au rétrécissement du bandeau
à 18 % (voir `QuestionCardView.hauteurDuBandeau`).

| asset | source | auteur | licence | relevé le |
|---|---|---|---|---|
| `panneau-giratoire-vue-conducteur` | [Commons — Panneau AB25 sur la D 183](https://commons.wikimedia.org/wiki/File:Panneau_AB25_sur_la_D_183.jpg) (2024-09-21) | Marc Mongenet | CC BY-SA 4.0 | 2026-08-23 |
| `ligne-jaune-continue` | [Commons — Marquage stationnement et arrêt interdits](https://commons.wikimedia.org/wiki/File:Marquage_stationnement_et_arr%C3%AAt_interdits_2013-11-17.JPG) (2013-11-17) | Tabl-trai | CC BY-SA 3.0 | 2026-08-23 |

Ces deux-là passeraient une diffusion telles quelles : CC BY-SA demande l'attribution
(ce tableau la porte) et le partage à l'identique des seules œuvres dérivées de l'image.
Un recadrage en est une — donc si l'app est un jour distribuée, l'attribution devra
apparaître dans l'app, pas seulement ici.

## Ajouter une image

1. Schéma : ajouter la scène dans `Tools/render-scenes.swift`, relancer le script.
   Photo : télécharger la source, recadrer en 4:3, sortir @2x/@3x dans un
   `<asset>.imageset` avec son `Contents.json`.
2. Ajouter la ligne ici — asset, source, auteur, licence, date de relevé.
3. Poser l'`illustration` sur la question dans `questions.json` (`asset` + `alt`).
4. `python3 Tools/audit.py`, puis les tests.
