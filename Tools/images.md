# Provenance des images

Une ligne par imageset de `Valido/Assets.xcassets/Scenes/`. `Tools/audit.py` refuse une
`illustration` dont l'asset n'a pas sa ligne ici : sans ce relevé une image est orpheline,
donc impossible à remplacer et impossible à re-sourcer si les conditions changent.

L'app est compilée en local, pour un seul usage, et n'est ni distribuée ni vendue. C'est
sur cette base que des images sous licence non permissive sont admissibles. **Le jour où
une diffusion est envisagée, ce tableau est la liste des choses à re-sourcer** — et la
colonne « licence » dit lesquelles passent telles quelles.

## Schémas dessinés

Aucune source externe : générés par `./Tools/render-scenes.sh` (CoreGraphics), quatre
PNG par imageset — clair et sombre, en @2x et @3x. Pour les modifier, on édite la scène
dans le script et on relance `./Tools/render-scenes.sh` ; les fichiers ne
s'éditent jamais à la main. Le script est découpé en plusieurs fichiers sous
`Tools/Scenes/` : les panneaux vivent dans `Tools/Scenes/Panneaux.swift` et sont
réutilisés tels quels par les scènes de carrefour qui les contiennent — un panneau se
dessine une fois, pas une fois par scène.

| asset | scène | licence |
|---|---|---|
| `carrefour-priorite-droite` | croisement nu, véhicule arrivant de la droite | maison, aucune source tierce |
| `carrefour-route-prioritaire` | même croisement, panneau AB6 sur l'approche | maison, aucune source tierce |
| `carrefour-stop` | STOP et ligne d'arrêt continue sur l'approche | maison, aucune source tierce |
| `carrefour-cedez-le-passage` | AB3a et ligne discontinue à traits larges | maison, aucune source tierce |
| `carrefour-en-t` | carrefour en T sans signalisation, insertion à droite | maison, aucune source tierce |
| `rond-point-insertion` | giratoire, véhicule déjà sur l'anneau par la gauche | maison, aucune source tierce |
| `carrefour-feu-en-panne` | même croisement, deux feux tricolores éteints | maison, aucune source tierce |
| `carrefour-tramway` | voie ferrée en travers, tramway venant de la gauche | maison, aucune source tierce |
| `croisement-en-pente` | **vue de profil** : deux véhicules face à face sur une forte pente | maison, aucune source tierce |
| `giratoire-sortie-clignotant` | anneau, trajectoire de sortie une branche plus loin | maison, aucune source tierce |
| `panneau-b14-limitation` | B14 seul, disque à large liseré rouge portant 70 | maison, aucune source tierce |
| `panneau-b33-fin-limitation` | B33 seul, même disque barré d'une oblique montante | maison, aucune source tierce |
| `panneau-b30-zone-30` | B30 seul, carré bordé de rouge, ZONE et disque 30 | maison, aucune source tierce |
| `autoroute-voie-de-gauche` | trois voies d'un même sens, candidat le long de la glissière | maison, aucune source tierce |
| `panneau-a1a-virage` | A1a seul, triangle de danger portant une chaussée qui s'infléchit à droite | maison, aucune source tierce |
| `panneau-a13b-passage-pietons` | A13b seul, piéton marchant sur les bandes d'un passage | maison, aucune source tierce |
| `panneau-a14-panonceau` | A14 « autres dangers » et son panonceau M9 portant CARRIÈRE | maison, aucune source tierce |
| `panneau-b1-sens-interdit` | B1 seul, disque à fond rouge et barre blanche horizontale | maison, aucune source tierce |
| `panneau-b3-interdiction-depasser` | B3 seul, deux voitures vues de dos dans un disque à couronne rouge | maison, aucune source tierce |
| `panneau-b6a1-stationnement-interdit` | B6a1 seul, disque bleu à couronne rouge et **une** oblique | maison, aucune source tierce |
| `panneau-b6d-arret-interdit` | B6d seul, le même disque à **deux** obliques croisées | maison, aucune source tierce |
| `panneau-b21b-tout-droit` | B21b seul, disque bleu à listel blanc et flèche verticale | maison, aucune source tierce |
| `panneau-b31-fin-interdictions` | B31 seul, disque blanc à filet noir barré d'une oblique, sans chiffre | maison, aucune source tierce |
| `panneau-ab4-stop` | AB4 seul, octogone rouge à listel blanc portant STOP | maison, aucune source tierce |
| `panneau-ab7-fin-priorite` | AB7 seul, losange jaune barré dans un carré blanc posé sur la pointe | maison, aucune source tierce |
| `panneau-c1a-parking` | C1a seul, carré bleu à listel blanc portant un P | maison, aucune source tierce |
| `panneau-c113-voie-velo` | C113 seul, carré bleu portant une bicyclette de profil | maison, aucune source tierce |
| `marquage-ligne-mixte` | ligne continue doublée d'une discontinue, la discontinue du côté du candidat | maison, aucune source tierce |
| `marquage-fleches-rabattement` | trois flèches de rabattement à cheval sur une ligne d'annonce, continue au-delà | maison, aucune source tierce |
| `marquage-zebra` | zone non circulable hachurée au milieu de la chaussée, encadrée de deux continues | maison, aucune source tierce |
| `marquage-damier-detresse` | damier rouge et blanc d'une voie de détresse, à droite de la chaussée | maison, aucune source tierce |

### D'où vient la géométrie des panneaux

Les formes, les proportions et les couleurs viennent de l'**Instruction interministérielle
sur la signalisation routière** (IISR), qui les normalise. Elle est approuvée par arrêté
publié au JO et publiée en parties PDF par le Cerema ; ces PDF ont été relevés le
**2026-08-24**, article par article. Le Cerema n'a qu'une valeur documentaire — c'est une
**référence de dessin**, jamais une autorité sur un chiffre de droit, et elle n'apparaît
donc dans aucune colonne `source` de [`sources.md`](sources.md).

| partie | ce qu'elle a fixé | URL relevée |
|---|---|---|
| 1re | art. 5-1 forme de chaque famille et **arrondi des angles des panneaux polygonaux** ; art. 5-2 palette ; art. 5-3 gammes de dimensions (en gamme normale : triangle 1000 mm de côté, disque 850 de diamètre, octogone 800 entre côtés opposés, carré 700 de côté) ; art. 9-1 panonceaux, rectangulaires et **sans listel** | [IISR_1ePARTIE_VC_20160215](https://equipementsdelaroute.cerema.fr/IMG/pdf/IISR_1ePARTIE_VC_20160215_cle2e3a4d.pdf) |
| 2e | art. 21 « les panneaux de danger ont la forme de **triangles équilatéraux** dont le côté inférieur est horizontal » ; art. 23 « fond blanc […] entourés par une bande rouge **bordée elle-même par un listel blanc** » ; art. 25 implantation 100 à 200 m en amont hors agglomération ; art. 27 A1a ; art. 40 A13b ; art. 41 A14 | [IISR_2ePARTIE_VC_20160215](https://equipementsdelaroute.cerema.fr/IMG/pdf/IISR_2ePARTIE_VC_20160215_cle215ce2.pdf) |
| 3e | art. 42-2 AB3a, AB4, AB25 ; art. 42-3 AB6 et AB7. **Cette partie ne comporte aucun article de couleurs** : le listel blanc des panneaux AB à bande rouge suit celui des triangles de danger, par analogie | [iisr_3epartie_vc_201901](https://equipementsdelaroute.cerema.fr/IMG/pdf/iisr_3epartie_vc_201901_cle09e7a7.pdf) |
| 4e | art. 45 forme circulaire ; art. 47 couleurs, au mot : interdiction « fond blanc, couronne et barre d'interdiction rouges » **sans listel**, B1 « fond rouge […] barre horizontale blanche », B6a et B6d « à fond bleu », obligation « fond bleu, listel et symbole blancs », fin d'interdiction « fond blanc, symbole, inscription, listel et barre noirs » ; art. 50-1, 52, 55, 55-3, 65 et 68-1 pour la portée de chaque panneau | [iisr_4epartie_vc_20220613](https://equipementsdelaroute.cerema.fr/IMG/pdf/iisr_4epartie_vc_20220613_cle22c5b5.pdf) |
| 5e | art. 69-1 « les panneaux de type C sont généralement de forme carrée » ; art. 70 C1a, art. 71-1 C13a, art. 75-3 C113, art. 75-4 C207 | [IISR_5ePARTIE_vc20121231](https://equipementsdelaroute.cerema.fr/IMG/pdf/IISR_5ePARTIE_vc20121231_cle5ce2b1.pdf) |
| 7e | art. 113-1 couleurs des marques et modulations T1/T2/T3 ; ligne mixte = une continue doublée d'une T1 ou T3 espacée de 2u ; art. 115-3 B **trois** flèches de rabattement, à cheval sur la ligne d'annonce sur route à deux voies ; art. 117 A hachures blanches « inclinées à 2 pour 1 », 0,50 m de large, 1,35 m d'espacement ; art. 118 passages piétons ; art. 118-10 damier de voie de détresse, carreaux de 1,5 × 3 m | [IISR_7ePARTIE_VC_20160215](https://equipementsdelaroute.cerema.fr/IMG/pdf/IISR_7ePARTIE_VC_20160215_cle217e65.pdf) |
| 8e | art. 120 B principe de cohérence — le panneau permanent contredit « doit être masqué provisoirement » ; art. 122 A fond jaune des types AK, KC, KD et KM, et B marquage temporaire jaune | [IISR_8ePARTIE_VC20130621](https://equipementsdelaroute.cerema.fr/IMG/pdf/IISR_8ePARTIE_VC20130621_cle5d9b18.pdf) |

Ces PDF ne se lisent pas avec l'outil `Read` : `WebFetch` les enregistre sur disque et
donne le chemin dans son message, puis `pypdf` en extrait le texte (`uv run`). Deux d'entre
eux dépassent la limite de taille de `WebFetch` dans leur version la plus récente — on
prend alors une version consolidée antérieure, dont les articles cités n'ont pas bougé.

### Ce que la norme ne dit pas, et qu'on a donc dessiné

L'IISR **décrit** en texte les formes et les couleurs ; les **pictogrammes**, eux, vivent
dans les planches jointes aux arrêtés, que l'extraction de texte n'atteint pas. Chaque
pictogramme de `Tools/Scenes/Panneaux.swift` est donc une simplification du symbole connu,
dessinée pour rester lisible à ~90 points de haut : le point d'exclamation de l'A14, la
courbe de l'A1a, le piéton de l'A13b, les deux voitures du B3, les obliques des B6, la
flèche du B21b, la barre de l'AB7, le P du C1a, la bicyclette du C113, et le pictogramme
de descente de l'A16. Le caisson de feu tricolore n'a lui non plus aucune planche relevée.
**Aucun visuel d'éditeur d'ETG n'a servi de modèle**, ni comme source ni comme référence :
ce qui est public, c'est la norme, pas le fichier image d'un site.

Trois licences prises sur la géométrie, toutes pour la lisibilité :

- les chiffres des B14 et B33 tiennent 1,0 rayon au lieu de 0,84, Helvetica-Bold étant
  bien plus large que la fonte réglementaire ;
- l'arrondi des angles est proportionnel au rayon (0,09) là où la norme le fixe en
  millimètres : nos panneaux se dessinent à cinq tailles selon la scène ;
- dans `marquage-ligne-mixte`, l'écart entre la continue et la discontinue va bien au-delà
  des 2u de la norme — à cette échelle, 2u fusionnent en un seul trait et la question
  devient injouable.

Un défaut connu, hors périmètre de la passe sur les panneaux : le **B30** de
`panneau-b30-zone-30` est dessiné carré, alors que l'art. 45 de la 4e partie place le B14
« dans un **rectangle** pour les zones 30 » et que l'art. 5-3 lui donne 700 × 900 mm en
gamme normale. Le carré porte quand même le point de la question — une prescription
zonale, pas ponctuelle — mais la forme est fausse.

`croisement-en-pente` est la seule scène **de profil** et non vue de dessus. Ce n'est pas
un écart de style : une pente ne se voit pas en vue aérienne, et c'est le sens de la
déclivité qui décide de la réponse. La règle de cadrage tient quand même — les deux
véhicules sont au centre vertical, dans la bande qui survit au rétrécissement du bandeau.

Le B14, le B33 et le B30 avaient été redessinés d'après la planche de la page 4 du [guide
technique « la zone 30 »](https://www.securite-routiere.gouv.fr/sites/default/files/2019-02/guide_techn_fiche4_technique_zone30_cle29ec98.pdf)
publié par la Sécurité routière (relevé le 2026-08-23), faute de mieux : Cloudflare rendait
alors le téléchargement des parties de l'IISR inaccessible. L'IISR relevée depuis (voir
plus haut) les confirme, et corrige la forme du B30.

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

1. Schéma : ajouter la scène dans `Tools/Scenes/`, relancer `./Tools/render-scenes.sh`.
   Photo : télécharger la source, recadrer en 4:3, sortir @2x/@3x dans un
   `<asset>.imageset` avec son `Contents.json`.
2. Ajouter la ligne ici — asset, source, auteur, licence, date de relevé.
3. Poser l'`illustration` sur la question dans `questions.json` (`asset` + `alt`).
4. `python3 Tools/audit.py`, puis les tests.
