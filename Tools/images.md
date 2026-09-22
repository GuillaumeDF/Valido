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
| `autoroute-voie-de-gauche` | trois voies d'un même sens, candidat le long de la glissière ; rive droite en **T4** (traits longs, vides courts) le long de la bande d'arrêt d'urgence, délimitation de voies en **T1** (vides longs, traits courts) | maison, aucune source tierce |
| `panneau-a1a-virage` | A1a seul, triangle de danger portant une chaussée qui s'infléchit à droite | maison, aucune source tierce |
| `panneau-a13b-passage-pietons` | A13b seul, piéton marchant sur les bandes d'un passage | maison, aucune source tierce |
| `panneau-a14-panonceau` | A14 « autres dangers » et son panonceau M9 portant CARRIÈRE | maison, aucune source tierce |
| `panneau-b31-fin-interdictions` | B31 seul, disque blanc à filet noir barré d'une oblique, sans chiffre | maison, aucune source tierce |
| `panneau-ab4-stop` | AB4 seul, octogone rouge à listel blanc portant STOP | maison, aucune source tierce |
| `panneau-ab7-fin-priorite` | AB7 seul, losange jaune barré dans un carré blanc posé sur la pointe | maison, aucune source tierce |
| `panneau-c1a-parking` | C1a seul, carré bleu à listel blanc portant un P | maison, aucune source tierce |
| `panneau-c113-voie-velo` | C113 seul, carré bleu portant une bicyclette de profil | maison, aucune source tierce |
| `marquage-ligne-mixte` | ligne continue doublée d'une discontinue, la discontinue du côté du candidat | maison, aucune source tierce |
| `marquage-fleches-rabattement` | trois flèches de rabattement à cheval sur une ligne d'annonce, continue au-delà ; le candidat démarre dans la voie qui se termine, pas déjà dans celle désignée | maison, aucune source tierce |
| `marquage-zebra` | zone non circulable en chevrons au milieu de la chaussée, encadrée de deux continues | maison, aucune source tierce |
| `marquage-damier-detresse` | damier rouge et blanc d'une voie de détresse, à droite de la chaussée | maison, aucune source tierce |
| `feu-jaune-clignotant` | signal tricolore seul, la lampe du **milieu** allumée et cerclée de traits de clignotement | maison, aucune source tierce |
| `feu-fleche-clignotante` | tricolore à lampe du **haut** allumée, et un signal d'anticipation à flèche droite clignotante sur le même support | maison, aucune source tierce |
| `passage-niveau-feu-rouge-clignotant` | voie ferrée en travers de la chaussée, signal d'arrêt R24 à lentille **unique** allumée et clignotante | maison, aucune source tierce |
| `stationnement-ligne-jaune-continue` | rue vue de dessus, trait jaune **continu** posé sur la face supérieure de la bordure du trottoir | maison, aucune source tierce |
| `stationnement-ligne-jaune-discontinue` | la **même** rue, le même trait en tirets T'2 (0,5 m de plein pour 0,5 m de vide) | maison, aucune source tierce |
| `stationnement-en-epi` | places obliques à 60° de la bordure, séparateurs continus et front en T'2, trois voitures rangées | maison, aucune source tierce |
| `chargement-depassement-arriere` | **vue de profil** : voiture roulant vers la droite, pièces de grande longueur sanglées sur le pavillon et débordant derrière elle | maison, aucune source tierce |
| `angle-mort-poids-lourd` | vue de dessus : poids lourd de dix mètres, quatre surfaces **hachurées** marquant les angles morts, la voiture du candidat prise dans celle du flanc droit | maison, aucune source tierce |
| `depassement-cycliste-distance` | rue à deux trottoirs et deux bordures, piétons dessus ; cycliste le long du bord droit, la voiture du candidat à sa hauteur, **écart dessiné à 1,055 m** | maison, aucune source tierce |
| `sas-cycliste-feu` | sas cycliste : **deux** lignes d'effet des feux en T'2, figurine de vélo entre elles, bande cyclable d'accès à droite, tricolore à lampe du haut allumée (IISR 7e partie, art. 118-1, C et D) | maison, aucune source tierce |
| `bus-quittant-arret` | autobus le long d'un **zigzag jaune** de bordure, indicateurs de changement de direction allumés côté chaussée, la voiture du candidat derrière lui (IISR 7e partie, tableau de l'art. 113-2, E) | maison, aucune source tierce |
| `depassement-ligne-discontinue` | vue de dessus : chaussée à double sens, axe **discontinu de type T1**, la voiture du candidat déjà dans la moitié gauche à la hauteur de celle qu'elle double, trajectoire figurée par une flèche | maison, aucune source tierce |
| `depassement-sommet-de-cote` | **vue de profil** : la chaussée monte vers un sommet, la portion qui redescend au-delà est **hachurée** (convention « non vu depuis le poste de conduite »), ligne de visée en pointillés depuis l'œil du conducteur | maison, aucune source tierce |
| `croisement-chaussee-etroite` | vue de dessus : chaussée de 84 unités sans axe médian, voiture arrêtée **feux de détresse allumés** contre le bord droit, véhicule venant en sens inverse, candidat derrière l'obstacle | maison, aucune source tierce |
| `rabattement-apres-depassement` | vue de dessus : même chaussée que `depassement-ligne-discontinue`, la voiture du candidat **déjà revenue à droite** à un mètre du pare-chocs de celle qu'elle vient de doubler | maison, aucune source tierce |
| `tunnel-arret-urgence` | vue de dessus : deux voies entre deux piédroits pleins, **renfoncement** creusé dans le piédroit de droite (emplacement d'arrêt d'urgence) et poste d'appel au fond, la voiture du candidat en aval | maison, aucune source tierce |
| `passage-a-niveau-immobilise` | vue de dessus : voie ferrée en travers, **quatre demi-barrières** abaissées barrant toute la largeur, la voiture du candidat prise sur les rails entre elles | maison, aucune source tierce |
| `passage-a-niveau-balises` | balise **J10** vue de face, plaque blanche haute et étroite barrée d'**une seule** bande rouge oblique descendant vers la gauche | maison, aucune source tierce |

### Les quatre scènes d'usagers (tâche 15, 2026-08-26)

Premier lot de scènes qui mettent en présence des usagers de **tailles très différentes** —
un poids lourd de dix mètres et un cycliste de moins de deux. L'échelle change donc d'une
scène à l'autre, et c'est elle qui décide de ce qui est lisible :

| scène | unités par mètre | pourquoi cette échelle |
|---|---:|---|
| `angle-mort-poids-lourd` | 12 | la seule qui fasse tenir un véhicule de 10 m dans le cadre |
| `bus-quittant-arret` | 12 | idem, pour un autobus de 10 m |
| `sas-cycliste-feu` | 16 | à 12, le sas (3 m) serait plus court qu'une voiture ; à 32, il déborderait de la bande centrale |
| `depassement-cycliste-distance` | 32 | la seule qui rende visible un écart latéral d'un mètre |

**Ce que l'IISR a fourni, et ce qu'elle ne pouvait pas fournir.** L'art. 118-1, D de la 7e
partie décrit le sas mot pour mot — « à l'avant, par une ligne d'effet des feux (T'2, 15 cm)
tracée à l'aplomb ou en retrait du feu tricolore ou par un passage pour piétons ; à
l'arrière, par une seconde ligne d'effet des feux (T'2, 15 cm) tracée de 3 à 5 mètres en
amont de la première », et « A l'intérieur du sas, le marquage de la figurine […] est mis en
place dans l'axe de chaque voie de circulation automobile ». Les deux lignes de la scène sont
donc à 48 unités, soit **3 m**, la borne basse : c'est la seule qui les garde toutes les deux
dans la bande centrale. Le même art. 118-1, C dit que la figurine au sol est celle du C113 —
d'où la réutilisation de `silhouetteVelo`, rendue non privée pour l'occasion : un pictogramme
se dessine une fois. Le zigzag de `bus-quittant-arret` vient du tableau de l'art. 113-2, E
(« arrêt d'autobus : continue en zigzag de 2u ») et le jaune de l'art. 113-1, A. En revanche
**aucune source ne cote un angle mort** : les quatre surfaces hachurées suivent le partage de
la signalisation que R313-32-1 rend obligatoire depuis le 1er janvier 2021 (côtés et arrière
de tout véhicule de plus de 3,5 t), pas un texte coté. Et le chiffre « 3 à 5 mètres » sert
ici à **dessiner**, jamais à affirmer : le Cerema n'est pas dans la liste blanche (§8 de
`methode.md`), donc ni l'énoncé ni l'explication de la question du sas ne le portent, et sa
ligne de registre est `stable`.

Relevé de luminance (§13 de `methode.md`) — Rec. 709 sur les valeurs sRGB des PNG **@3x**
livrés, `Y = 0,2126 R + 0,7152 G + 0,0722 B`, coordonnées en **unités de scène** (le pixel lu
est `3 ×` celles-ci). Les zones **hachurées** ne se mesurent pas à un pixel près : on donne la
moyenne et le maximum sur un carré de 30 unités de côté.

**Rec. 709, pas Rec. 601**, et le rappel n'est pas de la pédanterie : `0,299 / 0,587 / 0,114`
est le coefficient que la plupart des outils appellent « luma » par défaut. Sur un gris les
deux formules coïncident, sur un rouge ou un bleu saturé elles divergent de dix à quinze
points — assez pour faire croire qu'un chiffre du tableau ne se reproduit pas (c'est arrivé
en revue de branche, sur trois lignes de couleur saturée). Les **69 lignes de mesure à
coordonnées** de ce fichier, tous tableaux confondus, ont été revérifiées le 2026-08-27 sur
les PNG livrés : toutes reproduisent à `0,05` près.

| zone | x, y | clair | sombre |
|---|---|---|---|
| `angle-mort` — zone hachurée, carré 30×30 : moyenne / max | 240, 215 | 120,8 / 181,9 | 102,6 / 163,2 |
| `angle-mort` — chaussée nue, même carré témoin | 152, 255 | 93,1 / 93,1 | 75,1 / 75,1 |
| `angle-mort` — caisse du poids lourd | 199, 180 | 180,0 | 196,6 |
| `angle-mort` — contour sombre du poids lourd | 183,5, 180 | 51,0 | 51,0 |
| `angle-mort` — voiture du candidat | 245, 168 | 128,6 | 128,6 |
| `depassement` — bordure du trottoir | 67, 150 | 139,1 | 115,3 |
| `depassement` — trottoir (`sol`) | 12, 250 | 235,1 | 37,2 |
| `depassement` — chaussée | 120, 150 | 93,1 | 75,1 |
| `depassement` — cycliste, buste | 280, 130 | 180,0 | 196,6 |
| `depassement` — cycliste, tête | 280, 119 | 241,0 | 241,0 |
| `depassement` — piéton, épaules | 354, 118 | 118,6 | 154,1 |
| `depassement` — piéton, tête | 344, 118 | 241,0 | 241,0 |
| `sas` — ligne d'effet, au niveau d'un plein | 204, 152 | 255,0 | 234,3 |
| `sas` — ligne d'effet, au niveau d'un vide | 212, 152 | 93,1 | 75,1 |
| `sas` — lentille du haut, **allumée** | 288, 119 | 86,0 | 115,1 |
| `sas` — lentilles du milieu et du bas, éteintes | 288, 138 / 161 | 138,1 | 125,1 |
| `bus` — clignotant allumé | 215, 162 | 198,1 | 209,5 |
| `bus` — caisse du bus | 230, 110 | 118,6 | 154,1 |
| `bus` — contour sombre du bus | 215, 110 | 51,0 | 51,0 |
| `bus` — zigzag jaune, sur un segment | 254, 54 | 198,1 | 209,5 |
| `bus` — bordure nue, hors zigzag | 250, 205 | 139,1 | 115,3 |

Ce que le relevé établit :

- **Les hachures vont dans le bon sens.** Ce qui est marqué est plus **clair** que ce qui ne
  l'est pas : +27,7 en clair et +27,5 en sombre sur la moyenne du carré, +88,8 et +88,1 sur le
  trait lui-même. La polarité est la même dans les deux modes.
- **Le contour sombre du poids lourd n'est pas décoratif.** Sa caisse mesure 180,0 en clair et
  le maximum d'une hachure 181,9 : **1,9 point d'écart**. Sans contour, la caisse et la zone
  hachurée qui la longe fusionneraient en niveaux de gris, et la scène perdrait justement la
  frontière dont dépend sa réponse. Le contour est à 51,0, soit 129 points de la caisse et
  131 de la hachure. Le même contour a été ajouté au bus, dont la caisse (118,6) ne se sépare
  de la chaussée (93,1) que de 25,5 points en clair. **Ce contour a été mis en place d'après
  la mesure, avant le premier rendu**, et non après.
- **Le clignotant et le zigzag ont la bonne polarité.** L'indicateur allumé est à +79,5 de la
  caisse du bus en clair et +55,4 en sombre ; le zigzag est à +59,0 et +94,2 de la bordure nue,
  comme les deux scènes de ligne jaune déjà livrées.
- **Les deux lignes du sas sont le signal le plus franc du lot** : +161,9 en clair et +159,2 en
  sombre entre un plein et un vide. C'est celui dont dépend la réponse de la question.

Et **une inversion de polarité constatée, qui ne porte aucune réponse et qui est antérieure à
ces scènes** : la lentille **allumée** du tricolore mesure 86,0 en clair contre 138,1 pour une
lentille éteinte, soit −52,1 ; en sombre, 115,1 contre 125,1, soit −10,0. C'est mécanique — le
rouge de la palette est sombre par nature, et le halo à 30 % ne compense pas. Le défaut est
donc celui de `feuTricolore`, partagé avec `feu-fleche-clignotante` déjà livrée, et non de
`sas-cycliste-feu` ; ce qui dit ici « allumée » reste de la **forme** : la position dans le
caisson (haut = rouge, arrêté du 24 novembre 1967, art. 7), le halo qui déborde et le reflet
que les lentilles éteintes n'ont pas. Surtout, **la réponse de la question du sas ne s'y joue
pas** : l'énoncé dit « Ce feu passe au rouge », et ce qu'il faut lire dans l'image, ce sont les
deux lignes d'arrêt. Corriger la primitive dépasse le cadre de la tâche 15 et changerait un PNG
déjà livré ; le constat est posé ici pour la tâche 21.

**Deux renoncements de dessin, et pourquoi.**

- La **voiture du candidat a été retirée de `sas-cycliste-feu`.** Au premier jet elle était
  arrêtée en amont de la seconde ligne — c'est-à-dire **exactement à la bonne réponse**. Toute
  position correcte de cette voiture donne la réponse, et toute position incorrecte
  contredirait l'explication : la scène se tient mieux sans elle. Un cycliste remontant la
  bande d'accès y avait été ajouté ensuite pour expliquer à quoi sert l'espace réservé, mais à
  27 unités il était illisible et n'expliquait plus rien — **retiré en revue round 1** : les
  deux lignes d'arrêt et la figurine au sol suffisent à porter le sens du sas.
- Le **cycliste vu de dessus a été redessiné deux fois**, et les deux fois la mesure ne
  suffisait pas à trancher : la première version (guidon et épaules à 0,30 de la longueur) se
  lisait comme un poteau surmonté d'un point, la seconde (tête sombre sur épaules colorées)
  comme un anneau — l'écart de luminance était pourtant bon dans les deux cas. Ce qui a réglé
  la question est un buste **plus long que large** et une tête **claire** cernée d'un filet
  sombre. Même remarque pour le piéton, dont la tête sombre du premier jet évidait la
  silhouette sur le trottoir du mode sombre (37,2). La mesure prouve la visibilité, pas
  l'intelligibilité : elle se relit à l'œil, dans les deux modes.

  **Revue round 1 :** ce même défaut « anneau » avait été corrigé sur le cycliste mais laissé
  sur le piéton — tête à 0,48 de `taille`, sur des épaules à 0,90, soit un rapport de 0,53
  qui réduisait les épaules à un anneau autour d'un gros disque central. La mesure de
  contraste passait (+136 en clair, +99 en sombre au centre du piéton) sans que la lecture y
  soit ; tête ramenée à 0,27 de `taille`, soit environ 0,30 de la largeur d'épaules.

**Ce que chaque scène apporte que l'énoncé ne peut pas dire (§9 de `methode.md`).**

| scène | l'option qui en dépend | ce que seule l'image donne |
|---|---|---|
| `angle-mort-poids-lourd` | « ralentir pour vous laisser distancer » | « à cette place » ne désigne rien sans l'image : c'est elle qui dit que la voiture longe le **flanc droit** du poids lourd, dans la plus large des zones non vues |
| `depassement-cycliste-distance` | « 1 m de son guidon » | le **lieu**. R414-4 impose 1 m en agglomération et 1,50 m hors ; l'énoncé ne dit pas où l'on est, et ce sont les deux trottoirs, leurs bordures et les piétons qui le disent. Sans l'image, « 1,50 m » serait aussi défendable |
| `sas-cycliste-feu` | « à la ligne la plus en retrait » | qu'il y a **deux** lignes d'arrêt. Un énoncé qui l'écrirait aurait déjà donné sa réponse |
| `bus-quittant-arret` | « ralentir et le laisser reprendre la file » | les trois conditions de R412-11 réunies : un arrêt **signalé comme tel** (le zigzag), l'intention de repartir (l'indicateur allumé) et l'**agglomération** (les deux trottoirs et leurs piétons) |

**Le §10, et c'est `angle-mort-poids-lourd` qui le contraint le plus.** Le bandeau tombe à
18 % de la carte au verdict et recadre en `.fill` : il ne survit qu'une bande d'environ 110
unités autour du centre vertical, soit y de 95 à 205. Y tiennent : la zone hachurée du flanc
droit (y de 120 à 240, donc sa moitié haute), la voiture du candidat (y de 145 à 185, en
entier) et le corps du poids lourd, cabine comprise (y de 90 à 210). Les zones **avant**
(y de 62 à 90) et **arrière** (y de 210 à 252) sont hors bande, et c'est voulu : elles ne sont
que du décor, aucune option n'y renvoie. Même règle pour les trois autres — les deux lignes du
sas sont à y = 152 et 200, le clignotant arrière du bus à y = 162, le cycliste et la voiture de
la scène de dépassement entre y = 97 et 212.

### Les quatre scènes de croisement et dépassement (tâche 16, 2026-08-26)

Trois vues de dessus et **une vue de profil**, et ce partage est le point à comprendre
avant tout le reste. Le brief demandait une paire — même route, visibilité coupée par le
relief, réponse inverse — mais un **sommet de côte ne se voit pas d'en haut**, exactement
comme la pente de `croisement-en-pente`. La paire est donc écrite dans deux registres :
`depassement-ligne-discontinue` en vue de dessus, `depassement-sommet-de-cote` de profil.

Le risque que ce partage crée est celui que ce fichier nomme à propos des deux lignes
jaunes : si le registre visuel était corrélé à la réponse, on apprendrait le registre au
lieu de la règle (« photo, donc arrêt interdit »). Ici il ne l'est pas, et ça se vérifie —
les deux scènes de profil déjà livrées répondent l'une « vous cédez le passage »
(`croisement-en-pente`) et l'autre « c'est admis » (`chargement-depassement-arriere`).
« Profil » ne prédit donc rien. La différence avec le cas des lignes jaunes est qu'il
s'agissait là de **deux scènes par ailleurs identiques** dont le registre était le seul
écart stable.

| scène | unités par mètre | pourquoi cette échelle |
|---|---:|---|
| `depassement-ligne-discontinue` | 16 | voie de 56 unités pour 3,50 m, voiture de 50 × 27,5 pour 3,13 × 1,72 m : elle laisse un peu moins d'un mètre de part et d'autre dans sa voie, comme sur la route |
| `rabattement-apres-depassement` | 16 | la même, à dessein : les deux scènes se lisent comme deux instants d'une même manœuvre |
| `croisement-chaussee-etroite` | 14 | voies de 42 unités, soit **3 m** : la voiture arrêtée en laisse 15 unités jusqu'à l'axe, soit 1,10 m là où il en faudrait 1,80. L'impossibilité de passer est dessinée à l'échelle |
| `depassement-sommet-de-cote` | — | vue de profil ; la chaussée y est un trait de 30 unités d'épaisseur, la voiture de profil est celle de `croisement-en-pente`, à l'identique |

**L'axe médian est une T1, et ce n'est pas un détail de dessin.** La modulation de l'axe
des deux scènes de dépassement est 15 unités de trait pour 50 de vide, soit le rapport 0,3
de la T1 (« 3 m de trait, 10 m d'intervalle », IISR 7e partie, art. 113-1, B). Une
discontinue à pleins dominants serait une **ligne de dissuasion**, qui n'a pas la même
portée ; la dessiner ainsi aurait posé sous la question une seconde question que l'énoncé
ne pose pas. C'est le même raisonnement que la correction de la rive d'autoroute du
2026-08-25 : ce qui se transpose d'une norme de marquage à une scène, c'est le rapport
plein/vide, jamais la longueur.

**`croisement-chaussee-etroite` n'a au contraire aucun axe médian**, et c'est délibéré :
une chaussée étroite n'en porte pas, et son absence garde la question sur la manœuvre au
lieu de la ramener à la signification d'un trait — cinq questions du topic
`Panneaux & marquage` traitent déjà ce que la ligne autorise, et `audit.py` ne verrait pas
le doublon.

**Deux ajouts de primitive, tous deux motivés par une mesure.**

- `voiture` accepte un `contour` sombre optionnel. La voiture arrêtée de
  `croisement-chaussee-etroite` est en `tiers`, qui ne se sépare de la chaussée que de
  **25,5 points** en niveaux de gris en mode clair — le constat qui avait déjà valu un
  contour au bus et au poids lourd de la tâche 15. Le paramètre a une valeur par défaut :
  aucune scène déjà rendue ne change d'un pixel, vérifié après rendu.
- `zoneNonVue` accepte un **chemin** quelconque et non plus seulement un rectangle : la
  portion de chaussée qui plonge derrière le sommet est oblique. Le pas et l'inclinaison
  des hachures se calculent sur la boîte englobante, si bien qu'un chemin rectangulaire
  redonne exactement le dessin d'avant — `angle-mort-poids-lourd` est resté identique au
  fichier près.

Relevé de luminance (§13 de `methode.md`) — Rec. 709 sur les valeurs sRGB des PNG **@3x**
livrés, `Y = 0,2126 R + 0,7152 G + 0,0722 B`, coordonnées en **unités de scène** (le pixel
lu est `3 ×` celles-ci). Les zones **hachurées** se donnent en moyenne et maximum sur un
carré de 20 unités centré sur l'axe de la chaussée. Le préfixe de la première scène est
`depassement-discontinue` et non `depassement` : celui-ci désigne déjà
`depassement-cycliste-distance` dans le tableau de la tâche 15 plus haut, et un `grep` sur ce
fichier ne fait pas la différence entre deux sections (ronde 1 de revue).

| zone | x, y | clair | sombre |
|---|---|---|---|
| `depassement-discontinue` — axe T1, au niveau d'un plein | 200, 76 | 255,0 | 234,3 |
| `depassement-discontinue` — axe T1, au niveau d'un vide | 200, 110 | 93,1 | 75,1 |
| `depassement-discontinue` — chaussée nue | 190, 250 | 93,1 | 75,1 |
| `depassement-discontinue` — votre voiture, caisse | 172, 148 | 128,6 | 128,6 |
| `depassement-discontinue` — votre voiture, liseré blanc | 158, 148 | 255,0 | 234,3 |
| `depassement-discontinue` — voiture doublée | 228, 185 | 180,0 | 196,6 |
| `depassement-discontinue` — flèche de trajectoire | 228, 240 | 128,6 | 128,6 |
| `rabattement` — intervalle entre les deux voitures | 228, 161 | 93,1 | 75,1 |
| `croisement` — voiture arrêtée, caisse | 232, 140 | 118,6 | 154,1 |
| `croisement` — voiture arrêtée, contour sombre | 215,5, 140 | 51,0 | 51,0 |
| `croisement` — feu de détresse, disque et rayons | 214, 126 / 203, 126 | 198,1 | 209,5 |
| `croisement` — chaussée libre entre l'obstacle et l'axe | 206, 140 | 93,1 | 75,1 |
| `croisement` — véhicule d'en face | 179, 108 | 180,0 | 196,6 |
| `cote` — chaussée **cachée**, carré 20×20 : moyenne / max | 300, 167,7 | 129,7 / 255,0 | 111,3 / 235,2 |
| `cote` — chaussée **vue**, même carré témoin | 200, 148,4 | 105,0 / 255,0 | 89,2 / 234,3 |
| `cote` — contour de la zone non vue | 236, 128 | 231,1 | 210,2 |
| `cote` — ligne de visée | 330, 119,3 | 128,6 | 128,6 |
| `cote` — `sol` de part et d'autre de la visée | 330, 100 | 235,1 | 37,2 |
| `cote` — versant (`ilot`) | 200, 250 | 219,0 | 69,2 |

Ce que ce relevé établit :

- **Les hachures vont dans le bon sens, et dans les deux modes.** La chaussée cachée est
  plus **claire** que la chaussée vue de +24,7 en clair et +22,1 en sombre sur la moyenne
  du carré — la même polarité, et le même ordre de grandeur, que les angles morts de la
  tâche 15 (+27,7 / +27,5). C'est ce contraste-là qui porte la réponse de la question.
- **Le contour de la voiture arrêtée était nécessaire, et la mesure le chiffre.** Sa caisse
  mesure 118,6 en clair contre 93,1 pour la chaussée : 25,5 points, la valeur même qui avait
  fait ajouter un contour au bus. Le filet à 51,0 la borne à 67,6 points de la caisse et
  42,1 de la chaussée. En mode sombre la caisse (154,1) se détache seule de la chaussée
  (75,1), le contour n'y sert qu'à ne pas changer de dessin d'un mode à l'autre.
- **Les feux de détresse ont la bonne polarité, et surtout la bonne place.** Le disque et
  ses rayons mesurent 198,1 / 209,5 ; les rayons sont tracés **sur la chaussée** (93,1 /
  75,1), soit +105,0 et +134,4 — et non sur la caisse, dont ils ne se sépareraient que de
  18,1 points en clair. C'est la position du disque, à cheval sur l'arête de la caisse, qui
  fait tenir les deux lectures à la fois.

Et **une réserve mesurée**, sur la ligne de visée de `depassement-sommet-de-cote` : en
`vous` elle mesure 128,6 dans les deux modes, donc **plus sombre** que le `sol` du mode
clair (235,1) et **plus claire** que celui du mode sombre (37,2). Sa polarité s'inverse
d'un mode à l'autre. C'est assumé pour deux raisons : aucune teinte de la palette n'est à
la fois franche sur 235 et sur 37, et surtout **la réponse ne s'y joue pas** — elle se joue
sur les hachures, dont la polarité, elle, est la même des deux côtés. La visée n'explique
que le *pourquoi* de la zone cachée, et elle le fait par sa forme : un pointillé oblique qui
rase la crête, qui disparaît derrière la voiture qui précède et ressort devant elle.

**Ce que chaque scène apporte que l'énoncé ne peut pas dire (§9 de `methode.md`).**

| scène | l'option qui en dépend | ce que seule l'image donne |
|---|---|---|
| `depassement-ligne-discontinue` | « oui, la voie de gauche est libre devant vous » | que la manœuvre est **déjà engagée** — vous êtes dans la moitié gauche, à hauteur du véhicule doublé — et que rien n'occupe la voie devant. Un énoncé qui l'écrirait aurait donné sa réponse |
| `depassement-sommet-de-cote` | « interdit : vous ne voyez pas la route au-delà » | que la route **se dérobe** au-delà du sommet. C'est le fait que R414-11 érige en condition, et il n'existe qu'en image |
| `croisement-chaussee-etroite` | « vous arrêter et laisser passer celui d'en face » | **de quel côté** est l'obstacle. Rien d'autre ne décide de la réponse, et l'écrire dans l'énoncé la donnerait |
| `rabattement-apres-depassement` | « trop tôt : le véhicule dépassé doit ralentir » | la **distance** au véhicule doublé. R414-10 n'en fixe aucune : la manœuvre se juge, et on ne juge que ce qu'on voit |

**Le §10, et c'est `croisement-chaussee-etroite` qui le contraint le plus.** Trois véhicules
ne tiennent pas dans la bande d'environ 110 unités (y de 95 à 205) qui survit au recadrage
du bandeau à 18 %. Le partage a été fait selon ce que chacun porte : la voiture arrêtée
(y de 117 à 163) et le véhicule d'en face (y de 95 à 141) y sont entiers — ce sont eux qui
décident —, la voiture du candidat n'y entre qu'à moitié (y de 182 à 228), ce qui suffit
puisqu'elle n'a que deux choses à dire, son liseré et sa voie. Pour les autres : les deux
voitures de `depassement-ligne-discontinue` tiennent entre y = 123 et 203, celles de
`rabattement-apres-depassement` entre 103 et 220 (seule la queue du véhicule doublé sort),
et le sommet de côte est à y = 138, la zone hachurée entre 123 et 229.

**Un écart assumé au brief : aucun véhicule ne vient en face dans
`depassement-ligne-discontinue`.** Le brief en demandait un. Le dessiner ferait reposer la
réponse sur une **distance**, or le cadre 4:3 compresse l'axe longitudinal d'un facteur ~20
par rapport à l'axe transversal — c'est le motif exact pour lequel la tâche 12 a renoncé à
illustrer la distance de sécurité. Un tiers dessiné « assez loin » rendrait défendable le
distracteur « renoncez, un véhicule vient », ce que la règle 2 du §1 de `questions.md`
interdit. Même raison pour l'absence de véhicule derrière le sommet de côte : on ne peut pas
dessiner un véhicule caché, et le montrer ferait croire que c'est sa présence qui interdit
le dépassement, alors que R414-11 interdit précisément parce qu'on l'ignore.

### Les trois scènes de tunnel et de passage à niveau (tâche 17, 2026-08-26)

Deux vues de dessus et **un objet vu de face**, et ce partage n'est pas un choix de style :
le seul fait que porte la troisième scène est le **nombre de bandes** d'une balise, qui est
peint sur une plaque verticale et n'existe donc pas en vue aérienne. Elle rejoint les
quatorze panneaux du dossier — fond neutre, l'objet seul, grand et centré.

| scène | unités par mètre | pourquoi cette échelle |
|---|---:|---|
| `tunnel-arret-urgence` | 16 | voies de 56 unités pour 3,50 m et voiture agrandie 1,25 fois, l'échelle des deux scènes de dépassement de la tâche 16. À 12, la chaussée et son refuge tiendraient dans un tiers du cadre et le refuge se lirait comme une encoche plutôt que comme une place |
| `passage-a-niveau-immobilise` | 12 | l'échelle des scènes de carrefour, réutilisée telle quelle : la scène partage sa chaussée, ses rails et son axe interrompu avec `passage-niveau-feu-rouge-clignotant`, et deux cartes du même lieu doivent se lire à la même taille |
| `passage-a-niveau-balises` | — | vue de face ; la plaque fait 106 unités de haut pour 30 de large, soit exactement l'encombrement vertical d'un panneau circulaire de rayon 52 |

**Ce que l'IISR a fourni.** L'art. 34 de la 2e partie donne les balises J10 mot pour mot :
« des balises J10 comportant des bandes rouges obliques sur fond blanc. La pente descendante
de ces bandes est orientée vers l'axe de la chaussée », puis « La première balise confondue
avec le support du panneau A7 comporte trois bandes rouges ; les deux autres, implantées aux
deux tiers et au tiers de la distance séparant le panneau A7 du passage à niveau comportent
respectivement deux et une seule bande rouge. » Le **sens** de la pente vient donc du texte
et non de l'œil : la balise étant plantée à droite de la chaussée, l'axe est à sa gauche,
donc la bande descend vers la gauche. Le même article donne aussi les barrières « peintes en
blanc et rouge ». L'arrondi des angles vient de l'art. 5-1 de la 1re partie, qui nomme les
**balises** avant les panneaux. Enfin, l'art. 70-5, 1 de la 5e partie rend obligatoire la
signalisation des emplacements d'arrêt d'urgence dans les tunnels (panneau C8, panonceau M9e
quand l'emplacement comporte un poste d'appel d'urgence) et l'art. 78-27, 1 celle des issues
de secours.

Ce que l'IISR n'a **pas** fourni, et qui est donc dessiné : le combiné de téléphone du poste
d'appel (l'idéogramme ID5a, dont la planche n'a pas été relevée), le renfoncement lui-même,
les luminaires de paroi, et la géométrie d'une demi-barrière vue de dessus. Aucun visuel
d'éditeur d'ETG n'a servi de modèle, ici comme ailleurs.

**Ce que ces scènes ne dessinent pas, et pourquoi.** Ni signal d'arrêt R24, ni croix de
Saint-André, alors qu'un vrai passage à niveau automatique porte les deux. Le R24 est déjà
le sujet de `passage-niveau-feu-rouge-clignotant` et de la question qu'elle illustre
(« l'arrêt absolu, train visible ou non ») ; le remettre dans `passage-a-niveau-immobilise`
ferait répondre la carte voisine à la place de celle-ci. La croix de Saint-André n'a
toujours pas de planche relevée, et les demi-barrières suffisent à dire le lieu.

**Les quatre demi-barrières ne sont pas un choix de dessin.** L'art. 9 de l'arrêté du
18 mars 1991 n'impose au minimum qu'une demi-barrière à droite de la chaussée par sens. Avec
ce minimum, la moitié gauche de la chaussée resterait libre au-delà de la voie ferrée : un
véhicule pris sur les rails n'aurait rien à forcer pour dégager, et la question de la scène
n'existerait pas. Le même article réserve d'ailleurs au cas des **quatre** demi-barrières
l'obligation faite à l'exploitant d'« informer visuellement les usagers du caractère cassable
de la barrière » — c'est-à-dire exactement le fait dont dépend la bonne réponse.

Relevé de luminance (§13 de `methode.md`) — Rec. 709 sur les valeurs sRGB des PNG **@3x**
livrés, `Y = 0,2126 R + 0,7152 G + 0,0722 B`, un pixel par zone, coordonnées en **unités de
scène** (le pixel lu est `3 ×` celles-ci).

| zone | x, y | clair | sombre |
|---|---|---|---|
| `tunnel` — roche des piédroits (`bordure`) | 50, 60 | 139,1 | 115,3 |
| `tunnel` — chaussée du tube | 120, 60 | 93,1 | 75,1 |
| `tunnel` — **refuge**, chaussée creusée dans la roche | 240, 137 | 93,1 | 75,1 |
| `tunnel` — arête sombre du refuge | 278, 137 | 51,0 | 51,0 |
| `tunnel` — poste d'appel, fond | 246, 147 | 128,6 | 128,6 |
| `tunnel` — poste d'appel, filet et combiné | 244,5, 137 | 255,0 | 234,3 |
| `tunnel` — bande de rive continue | 102,5, 60 | 255,0 | 234,3 |
| `tunnel` — axe T1, plein / vide | 152, 145 / 152, 110 | 255,0 / 93,1 | 234,3 / 75,1 |
| `tunnel` — luminaire de paroi | 81,5, 26 | 255,0 | 234,3 |
| `tunnel` — voiture du candidat, caisse / liseré | 180, 230 / 166,5, 230 | 128,6 / 255,0 | 128,6 / 234,3 |
| `immobilise` — lisse, segment **rouge** | 240, 110 | 86,0 | 115,1 |
| `immobilise` — lisse, segment **blanc** | 229, 110 | 255,0 | 245,3 |
| `immobilise` — lisse, filet sombre de contour | 229, 106 | 51,0 | 51,0 |
| `immobilise` — chaussée | 170, 90 | 93,1 | 75,1 |
| `immobilise` — fût de la demi-barrière | 250, 110 | 93,1 | 75,1 |
| `immobilise` — rail | 100, 141 | 255,0 | 234,3 |
| `immobilise` — traverse / intervalle entre deux traverses | 98, 150 / 89, 150 | 153,0 / 235,1 | 24,1 / 37,2 |
| `immobilise` — voiture du candidat, caisse / liseré | 221, 150 / 210,3, 150 | 128,6 / 255,0 | 128,6 / 234,3 |
| `balise` — fond de la plaque | 200, 120 | 255,0 | 245,3 |
| `balise` — **bande rouge oblique** | 200, 150 | 86,0 | 115,1 |
| `balise` — filet sombre de la plaque | 185,2, 120 | 51,0 | 51,0 |
| `balise` — `sol` autour de la plaque | 60, 60 | 235,1 | 37,2 |

Ce que ce relevé établit :

- **La bande de la balise est le signal le plus sûr des trois scènes, et c'est celle dont
  dépend la réponse.** Elle mesure 86,0 sur un fond de 255,0 en clair (−169,0) et 115,1 sur
  245,3 en sombre (−130,2) : même polarité, écart franc des deux côtés. Compter les bandes ne
  demande donc de distinguer aucune teinte — c'est une barre sombre en travers d'une plaque
  claire, et rien d'autre.
- **Le filet sombre de la plaque n'est pas décoratif.** En mode clair, le fond de la balise
  (255,0) et le `sol` qui l'entoure (235,1) ne sont qu'à **19,9 points** l'un de l'autre : sans
  ce filet à 51,0, la silhouette de la balise se dissoudrait dans le fond là même où la
  question demande de la lire. En mode sombre, où le `sol` tombe à 37,2, il ne sert qu'à ne
  pas changer de dessin d'un mode à l'autre.
- **Le rouge d'une demi-barrière est indiscernable de la chaussée en mode clair**, et c'est
  mesuré, pas supposé : 86,0 contre 93,1, soit **7,1 points**. Ce qui fait lire la lisse est
  l'alternance de ses segments **blancs** (255,0, soit +161,9 sur la chaussée) et son filet de
  contour à 51,0 (−42,1). En mode sombre le rouge remonte à 115,1 contre 75,1 et l'écart
  redevient franc, mais le dessin ne change pas : la lecture repose des deux côtés sur le
  blanc et le filet, jamais sur le rouge.
- **La polarité du tunnel est la même dans les deux modes.** Le tube et le refuge, tous deux
  en `chaussee`, sont plus **sombres** que la roche des piédroits de 46,0 points en clair et
  de 40,2 en sombre. Le refuge se lit donc comme une avancée du sol du tunnel dans la paroi, et
  cette lecture ne dépend d'aucune teinte. L'arête à 51,0 la borne des deux côtés.
- **Une inversion connue, sans conséquence ici** : la caisse du candidat mesure 128,6 dans les
  deux modes (le bleu `vous` est identique en clair et en sombre), donc plus sombre que le
  `sol` du mode clair et plus claire que celui du mode sombre. Le constat est déjà porté par la
  section du chargement ci-dessus ; aucune des trois réponses ne s'y joue.

**Ce que chaque scène apporte que l'énoncé ne peut pas dire (§9 de `methode.md`).**

| scène | l'option qui en dépend | ce que seule l'image donne |
|---|---|---|
| `passage-a-niveau-balises` | « un passage à niveau, désormais tout proche » | le **nombre de bandes**, et il n'existe qu'en image. Un énoncé qui écrirait « cette balise à une bande » aurait donné sa réponse à qui connaît la règle ; un énoncé qui ne l'écrirait pas rendrait la question insoluble. Il n'y a pas de troisième rédaction — c'est le cas le plus net du §9 dans tout le dossier |
| `passage-a-niveau-immobilise` | « avancez en forçant le bras, conçu pour céder » | que la voiture est **déjà sur les rails**. L'énoncé dit seulement que les demi-barrières viennent de s'abaisser, ce qui est vrai des deux situations ; en deçà on attend, sur la voie on dégage. La position retourne la réponse |
| `tunnel-arret-urgence` | « rejoindre l'emplacement d'arrêt d'urgence » | qu'il **y a un refuge à portée**. Sans ce fait, « vous arrêter sur place » serait défendable — c'est ce qu'on fait quand il n'y a rien d'autre. Et l'écrire dans l'énoncé (« un refuge est signalé un peu plus loin ») aurait donné la réponse |

**Le §10.** La bande d'environ 110 unités qui survit au rétrécissement du bandeau (y de 95 à
205) contient, dans l'ordre des trois scènes : la plaque entière de la balise (y de 97 à 203,
son support seul en sort) — et c'est la contrainte qui **fixe sa taille**, puisqu'une plaque
recadrée laisserait croire à des bandes hors champ, c'est-à-dire détruirait la question ; le
refuge entier du tunnel (y de 96 à 178), la voiture du candidat restant hors bande à y = 230
parce qu'elle ne dit que « vous êtes ici » ; les deux lisses (y = 110 et 190), les rails
(y de 141 à 159) et la voiture prise entre elles (y de 130 à 170).

**Un renoncement, et il porte sur une scène que le plan demandait.** `tunnel-intervalle` —
deux véhicules en marche dans un tunnel, l'intervalle en question — **n'a pas été dessinée**.
Le motif n'est pas graphique mais documentaire : aucune source de rang 1 ne chiffre
l'intervalle propre au tunnel (cf. la ligne `a88bdac8` de [`sources.md`](sources.md)), si bien
qu'un schéma qui montrerait « le bon intervalle » inventerait la valeur qu'il prétend
illustrer. La question qui subsiste porte sur le **régime** — l'autorité de police peut
allonger l'intervalle sur un ouvrage à risques particuliers — et une règle de compétence ne se
dessine pas. S'y ajoute le motif déjà retenu par la tâche 12 : le cadre 4:3 compresse l'axe
longitudinal d'un facteur ~20 par rapport à l'axe transversal, donc un schéma ne peut pas
montrer honnêtement une distance entre deux véhicules.

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
| 6e | art. 109-3 A signal tricolore R11 « composé de trois feux circulaires vert, jaune, rouge », les R13 les donnant « dans cet ordre de bas en haut », et R11j « le vert peut être remplacé par du jaune clignotant » ; art. 109-3 B signal d'arrêt R24 « composé d'un feu circulaire rouge clignotant », employé « devant un obstacle ou un danger particulier (passage à niveau […] pont mobile, avalanche…) » ; art. 109-4 « les feux circulaires principaux pour véhicules ont un diamètre soit de 200 mm, soit de 300 mm », R24 « diamètre minimum de 160 mm » ; art. 110, C en jaune clignotant général « tous les signaux tricolores sont au jaune clignotant sur le feu du milieu » ; art. 110-5 le signal d'anticipation est « soit accolé à la même hauteur que le feu vert du signal R11v associé, soit situé juste en dessous » ; fig. 6 « Ce symbole signifie qu'il s'agit d'un feu clignotant » | [IISR_6ePARTIE_VC_20160215](https://equipementsdelaroute.cerema.fr/IMG/pdf/IISR_6ePARTIE_VC_20160215_cle217f7b.pdf) |
| 7e | art. 113-1 couleurs des marques et modulations T1/T2/T3, **tableau du B relevé en entier le 2026-08-25** (T1 3 m de trait pour 10 m d'intervalle, T'1 1,5 pour 5, T3 3 pour 1,33, T2 3 pour 3,5, T'3 20 pour 6, **T4 39 pour 13**, t'2 transversale 0,5 pour 0,5) ; art. 114-2 C « Autoroutes. Les lignes de délimitation de voies sont de type T1 de largeur 2u » ; art. 114-4 A, qui nomme la « voie d'insertion, de décélération ou d'entrecroisement » sans rien dire de la priorité qui y joue ; art. 114-4 B « Sur autoroute et route à chaussées séparées et à carrefours dénivelés, la ligne délimitant une bande d'arrêt d'urgence est discontinue de type T4 et de largeur 3u en section courante. […] En l'absence de bande d'arrêt d'urgence, la ligne de rive est continue de largeur 3u » ; ligne mixte = une continue doublée d'une T1 ou T3 espacée de 2u ; art. 115-3 B **trois** flèches de rabattement, à cheval sur la ligne d'annonce sur route à deux voies ; art. 117-2 A (numéroté « 117 A » dans une édition antérieure de l'IISR, même texte) hachures blanches « inclinées à 2 pour 1 », 0,50 m de large, 1,35 m d'espacement, **en chevrons** aux points de convergence, de divergence ou de séparation de sens opposés, « pointe toujours dirigée vers le conducteur » ; art. 118 passages piétons ; art. 118-10 damier de voie de détresse, carreaux de 1,5 × 3 m ; **art. 113-1 A** « Le blanc est la couleur utilisée pour les marquages sur chaussées […] 1. - Le jaune pour − les marques interdisant l'arrêt ou le stationnement » ; **art. 113-1 B** « Pour les lignes transversales, la modulation (T'2) comporte alternativement 0,5 m de trait et 0,5 m de vide » ; **art. 113-1 C** u = 5 cm sur les routes ordinaires ; **tableau de l'art. 113-2 E** (« Choix des modulations et largeurs des lignes », page 8-9 du PDF) interdiction de stationner = T'2 de 2u, interdiction de s'arrêter = continue de 2u, arrêt d'autobus = continue en zigzag de 2u — relevé mot pour mot : « 2. Ligne confirmant ou indiquant l'interdiction de stationner (jaune, art. 118-2) T'2 2u » et « 3. Ligne confirmant ou indiquant l'interdiction de s'arrêter (jaune, art. 118-2) continue 2u » ; l'art. 113-1 n'a pas de section E, seul le 113-2 en a une ; **art. 118-2 A a)** stationnement « en épi ou perpendiculaire », limites en lignes blanches continues de 2u ou T'2 de 2u ; **art. 118-2 B** le marquage jaune « est réalisé sur la face supérieure de la bordure du trottoir ou en rive de chaussée […] discontinue de type T'2 pour le stationnement gênant ou très gênant ; continue pour l'arrêt gênant ou très gênant » | [IISR_7ePARTIE_VC_20160215](https://equipementsdelaroute.cerema.fr/IMG/pdf/IISR_7ePARTIE_VC_20160215_cle217e65.pdf) |
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
de descente de l'A16.
**Aucun visuel d'éditeur d'ETG n'a servi de modèle**, ni comme source ni comme référence :
ce qui est public, c'est la norme, pas le fichier image d'un site.

**La dette du caisson de feu est en partie levée (2026-08-24).** Ce fichier portait, depuis
la tâche 7, l'aveu que « le caisson de feu tricolore n'a lui non plus aucune planche
relevée ». La 6e partie de l'IISR et l'article 7 de l'arrêté du 24 novembre 1967 ont été
lus depuis, et ils donnent trois choses que le dessin ne devine plus :

- les lentilles sont **circulaires**, et il y en a **trois** sur un signal tricolore, **une
  seule** sur un signal d'arrêt R24 comme sur un signal d'anticipation R16 — c'est ce
  nombre, et non une teinte, qui sépare les trois scènes de feux les unes des autres ;
- leur **ordre** est rouge en haut, jaune au milieu, vert en bas (les signaux R13 les
  donnent « vert, jaune, rouge, dans cet ordre de bas en haut ») : `feuTricolore` déduit
  donc la teinte de chaque lentille de sa position, et ne la reçoit jamais de l'appelant ;
- **quelle** lentille clignote selon le cas — au milieu « lorsque l'ensemble de
  l'installation est en panne, en cours de mise en activité ou volontairement géré avec ce
  seul message », en bas et à la place du vert quand le jaune clignotant est permanent
  (art. 7). `feu-jaune-clignotant` allume celle du milieu, qui est le cas qu'un candidat
  rencontre.

Ce qui **reste** dessiné, faute de norme : le **contour** du caisson autour des lentilles
— la 6e partie ne cote que le diamètre des lentilles, pas l'enveloppe, et les proportions
existantes (13 × 34 pour des lentilles de 8) se sont trouvées à quelques pour cent d'un
caisson plausible, donc elles n'ont pas bougé et aucun PNG déjà rendu n'a changé ; le halo
et les traits rayonnants qui figurent l'allumage et le clignotement, la figure 6 de la 6e
partie attestant seulement qu'un symbole de clignotement existe sans que sa forme soit
extractible du texte ; et la flèche du signal d'anticipation. La croix de Saint-André et
les barrières d'un passage à niveau n'ont **pas** été dessinées : leur planche n'a pas été
relevée, et la voie ferrée suffit à dire le passage à niveau.

### La rive de l'autoroute était fausse (2026-08-25)

`chausseeAutoroute` dessinait ses **deux** bandes de rive en continu, avec le commentaire
« continues, comme sur la vraie chaussée ». C'est vrai à gauche, où l'art. 114-4 B de la 7e
partie donne des « lignes de délimitation de terre-plein central […] continues et de largeur
3u ». C'est faux à droite : le même article dit que « la ligne délimitant une bande d'arrêt
d'urgence est discontinue de type T4 », la continue n'étant réservée qu'à l'« absence de
bande d'arrêt d'urgence ». Or la scène montre bien une BAU — la chaussée court jusqu'au bord
du cadre au-delà de la rive.

Ce n'était pas un détail de dessin mais une **faute de sens** : une ligne continue interdit
d'être franchie, alors qu'on rejoint la BAU en cas de nécessité absolue. La banque le disait
déjà de son côté — la question « Une ligne discontinue tracée le long du bord de la chaussée
délimite : » répond « la bande d'arrêt d'urgence ou l'accotement ». Le dessin contredisait
une de ses propres questions.

Corrigé, avec la délimitation de voies dans le même mouvement. Ce qui se transpose n'est pas
la longueur mais le **rapport plein/vide** du tableau de l'art. 113-1 B : 3 pour la T4 de
rive (39 m de trait, 13 m d'intervalle), 0,3 pour la T1 de délimitation de voies (3 m pour
10 m, art. 114-2 C). Le premier jet dessinait les voies à 18 pour 14, soit 1,3 — presque une
T2, et surtout indiscernable d'une rive. C'est ce contraste des deux modulations, inversées
l'une de l'autre, qui fait lire le bord droit comme un bord et non comme une quatrième voie.

Les longueurs, elles, ne se transposent pas : à l'échelle de la scène une voie de 78 unités
vaut 3,5 m, donc 39 m feraient 870 unités pour un cadre haut de 300. Ce facteur ~20 entre
l'axe transversal et l'axe longitudinal est la raison pour laquelle la tâche 12 a **renoncé**
à illustrer la distance de sécurité : un schéma 4:3 ne peut pas montrer 90 m de route et une
voie de 3,5 m à la même échelle, donc il mentirait sur la seule grandeur que la question
demanderait d'apprécier.

Mesure de contrôle (§13 de `methode.md`), au centre du trait de rive, en niveaux de gris sur
le PNG @2x : plein 255 en clair et 234 en sombre, vide 93 et 75 — soit le gris de la chaussée
exactement, et un écart de 162 et 159 points. La discontinuité se lit donc par la luminance
seule, sans aucune teinte.

### La paire de lignes jaunes : pourquoi la photo a cédé la place à un dessin

La banque ne portait que la **continue**, et sous forme de photographie Wikimedia
(`ligne-jaune-continue`, toujours recensée plus bas). Lui ajouter sa **discontinue** posait
un choix que rien dans le dossier ne tranchait, et il a été tranché ici : **les deux sont
dessinées**, et la photo passe orpheline.

Le motif n'est pas esthétique. Les deux questions forment une paire dont la réponse est
opposée — continue interdit l'arrêt, discontinue seulement le stationnement — et la teinte
comme la bordure sont identiques des deux côtés. Si l'une était une photo et l'autre un
schéma, le **registre visuel** serait corrélé à la réponse : un candidat qui rencontre les
deux cartes dans un même flux apprendrait « photo, donc arrêt interdit », sans jamais
regarder le trait. Le raccourci serait plus rapide que la règle, donc c'est lui qu'on
apprendrait. Les deux scènes sont désormais **identiques au trait près** : même cadrage,
même bordure, même voiture à la même place. Vérifié par différence pixel à pixel des deux
PNG @3x : 9 504 pixels diffèrent, tous dans la bande x ∈ [251,3 ; 258,3] du trait, aucun
ailleurs.

L'autre voie possible — trouver sur Commons une photo de ligne jaune **discontinue** le long
d'une bordure, et garder les deux en photo — n'a pas été prise : ces images sont rares, leur
conformité au marquage français ne se vérifie pas sur une vignette, et une paire de photos
prises à deux endroits différents introduirait justement les écarts (cadrage, revêtement,
éclairage) qu'on cherche à éliminer.

**Le trait est posé sur la face supérieure de la bordure**, et c'est le point le plus
important de ces deux scènes. L'art. 118-2, B autorise deux emplacements — sur la bordure ou
en rive de chaussée. Le second aurait, pour qui ne distingue pas les couleurs, exactement
l'allure d'une bande de rive blanche. Le premier est reconnaissable **sans aucune teinte** :
aucun marquage blanc n'est jamais peint sur une bordure de trottoir, donc un trait posé là ne
peut être qu'un jaune d'interdiction. C'est pour ça que le `Palette` a gagné une couleur
`bordure` : sans surface de bordure, pas de trait « sur la bordure ».

Relevé de luminance (Rec. 709 sur les valeurs sRGB du PNG @3x livré, `Y = 0,2126 R +
0,7152 G + 0,0722 B`) :

| zone | clair | sombre |
|---|---|---|
| trait jaune, au niveau d'un plein | 198,1 | 209,5 |
| bordure nue, au niveau d'un vide | 139,1 | 115,3 |
| axe médian blanc | 255,0 | 234,3 |
| chaussée | 93,1 | 75,1 |
| trottoir | 235,1 | 37,2 |

La polarité va dans le bon sens : ce qui porte l'interdiction — le plein du trait — est
**plus clair** que son absence, de 59 points en clair et de 94 en sombre. Une réserve
mesurée et assumée : en mode **sombre**, le trait jaune (209,5) et le marquage blanc (234,3)
ne sont qu'à 25 points l'un de l'autre, alors qu'ils sont à 57 en clair. En sombre, la
luminance seule ne permet donc pas de conclure « ce trait n'est pas blanc » — c'est la
position sur la bordure qui le dit, et elle est de forme.

### Le stationnement en épi

L'angle des places n'est écrit dans aucun article : l'art. 118-2, A, a) ne donne que le type
et la largeur des lignes. Il se **relève sur la planche** jointe à l'article (page 44 du PDF
de la 7e partie, image extraite avec `pypdf[image]`), qui montre deux figures côte à côte —
perpendiculaire à gauche, en épi à droite. En suivant un même séparateur de la figure de
droite, il passe de x = 806 px à y = 100 à x = 724 px à y = 240, soit `atan(140/82)` =
**59,6°** avec la bordure. La scène dessine 60°. La planche donne aussi le partage des deux
marquages, que l'article laisse ouvert : séparateurs **continus**, front des places en **T'2
discontinue**.

Trois voitures occupent des places contiguës et la moitié droite reste vide. Ce partage
n'est pas décoratif : des obliques nues partant d'une bordure se prendraient pour les
hachures d'une zone non circulable (comparer avec `marquage-zebra`), et des places toutes
occupées cacheraient l'inclinaison qui porte la réponse. Aucune teinte n'intervient — le
séparateur mesure 255,0 en clair contre 93,1 pour la chaussée (234,3 contre 75,1 en sombre).

Trois licences prises sur la géométrie, toutes pour la lisibilité :

- les chiffres des B14 et B33 tiennent 1,0 rayon au lieu de 0,84, Helvetica-Bold étant
  bien plus large que la fonte réglementaire ;
- l'arrondi des angles est proportionnel au rayon (0,09) là où la norme le fixe en
  millimètres : nos panneaux se dessinent à cinq tailles selon la scène ;
- dans `marquage-ligne-mixte`, l'écart entre la continue et la discontinue va bien au-delà
  des 2u de la norme — à cette échelle, 2u fusionnent en un seul trait et la question
  devient injouable.
- dans les scènes de stationnement, la **face supérieure de la bordure** est dessinée à 22
  unités là où une vraie bordure en ferait 5 à l'échelle de la scène (32 unités par mètre,
  une voie de 96 valant 3 m) : à 5, un trait de 2u ne laisserait rien voir de la bordure sous
  lui, et c'est ce « sous lui » qui porte tout le sens. Le trait lui-même passe de 3,2 à 7
  unités pour la même raison. En revanche la **modulation T'2 n'est pas retouchée** : 0,5 m
  de plein pour 0,5 m de vide font 16 unités chacun à cette échelle, ce qui se lit très
  bien, et c'est ce rapport de 1 pour 1 qui distingue une T'2 d'une T1 ou d'une T3 ;
- les séparateurs de `stationnement-en-epi` font 4 unités contre 2u (2,4 unités à l'échelle
  de cette scène, qui est celle des véhicules : 12 unités par mètre) ;
- la **bordure du trottoir** de cette même scène (`epiBordureBas − epiTrottoirBas`, entre
  le trottoir et la chaussée) fait 10 unités là où la norme, à cette même échelle de 12
  unités par mètre, en donnerait 12 : une licence de la même famille que celle des scènes
  de ligne jaune ci-dessus (chiffrée à 22 unités contre 5), mais qui n'était pas déclarée
  jusqu'ici. Elle sert la même lisibilité — la bande doit rester visible sans empiéter sur
  le front des places, dessiné juste en dessous.

**Corrigé en ronde 1 de revue : `marquage-zebra` dessinait une seule pente uniforme sur
une zone qui sépare deux sens opposés.** L'art. 117-2 A de la 7e partie (relevé mot pour
mot, voir tableau ci-dessus) dit que l'inclinaison des hachures « tend à ramener l'usager
vers l'axe de la voie de circulation qu'il emprunte » et qu'« aux points de convergence
ou de divergence, les hachures se présentent donc sous forme de chevrons ». Une zone qui
sépare deux sens opposés — les deux voitures de la scène vont en sens contraire — relève
du même article, et une pente unique donnait forcément à l'un des deux sens l'inclinaison
inverse de celle prescrite ; l'explication de la question, qui invoque justement ce
principe, contredisait donc l'image qu'elle est censée expliquer. La scène dessine
maintenant des chevrons symétriques par rapport à l'axe de la zone, une pente 2 pour 1
par moitié comme le veut l'article. La planche officielle (« C.3 — Schémas de marquage
par hachures », art. 117-2 et 114-2, page 63 du PDF de la 7e partie) confirme le motif :
elle montre des chevrons en pointe, jamais une pente unique, dans les zones qui séparent
deux directions.

`ligne-jaune-continue` (la photo, plus bas) est **orpheline** depuis le 2026-08-25 : la
question qu'elle illustrait pointe maintenant `stationnement-ligne-jaune-continue`, pour la
raison de symétrie exposée plus haut. Elle est conservée, ligne de provenance comprise —
c'est une image correcte, correctement sourcée, et le jour où le dossier voudra une paire de
photographies plutôt qu'une paire de schémas, c'est la moitié du travail déjà faite.

`giratoire-sortie-clignotant` reste **orphelin** : dessiné et correct, il n'est référencé
par aucune question depuis qu'une revue antérieure a retiré son illustration décorative.
Conservé tel quel pour qu'une tâche future le retrouve et lui trouve une question.

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

### Une vue de profil : le chargement (2026-08-25)

Cette scène ne pouvait pas être vue de dessus. Ce que sa question fait travailler est un
rapport **avant/arrière** — de quel bout un chargement déborde — et une vue aérienne ne dit
pas « sur le toit ». Elle rejoint donc `croisement-en-pente`, seule autre vue de profil du
dossier.

**L'échelle est doublée** par rapport aux vues de dessus : une caisse de 96 unités pour 4 m,
soit 24 unités par mètre là où les carrefours comptent 12. La raison est dans la réponse : les
3 m que R312-21 accorde à l'arrière auraient fait 36 unités à l'échelle des carrefours, à
peine plus qu'une roue, donc indiscernables d'un débord d'un mètre. Le débord dessiné vaut 60
unités, soit **2,5 m** — dans la limite légale, et c'est ce qui compte : une scène qui
montrerait un chargement hors la loi rendrait fausse la bonne réponse de sa propre question.
Le chargement ne dépasse pas non plus l'aplomb avant, que R312-22 interdit absolument.

Relevé de luminance (§13 de `methode.md`) — Rec. 709 sur les valeurs sRGB des PNG **@3x**
livrés, `Y = 0,2126 R + 0,7152 G + 0,0722 B`, un pixel par zone, coordonnées données en
**unités de scène** (le pixel lu est `3 ×` celles-ci) :

| zone | x, y | clair | sombre |
|---|---|---|---|
| `chargement` — fond (`sol`) | 40, 40 | 235,1 | 37,2 |
| `chargement` — bloc de planches, partie en débord | 170, 136 | 198,1 | 209,5 |
| `chargement` — bloc de planches, au-dessus du pavillon | 250, 133 | 198,1 | 209,5 |
| `chargement` — refend et contour du bloc | 200, 137 | 51,0 | 51,0 |
| `chargement` — caisse du véhicule | 250, 178 | 128,6 | 128,6 |
| `chargement` — liseré blanc de la caisse | 250, 191,5 | 255,0 | 234,3 |
| `chargement` — chaussée | 200, 215 | 93,1 | 75,1 |

Ce que ce relevé établit, et ce qu'il ne prétend pas établir. **La réponse ne repose ni sur un
état allumé/éteint ni sur une teinte** : elle repose sur une position (de quel côté le
débord). Il n'y a donc pas de polarité à vérifier comme sur `feu-fleche-clignotante`. Ce que
la mesure doit garantir, c'est que **chaque silhouette se détache de ce qu'elle touche**, et
c'est le cas :

- le bloc de planches se sépare de la caisse de 69,5 points en clair et 80,9 en sombre — la
  raison pour laquelle il est peint en `panneauJaune` et non en `bordure`, qui n'aurait laissé
  que 10,5 points ;
- il ne se sépare du fond que de **37,0 points en clair**, et c'est la mesure la plus faible
  de la scène : c'est son contour sombre, à 51,0 dans les deux modes, qui borne réellement le
  débord — 147 points de contraste contre le bloc lui-même.

Une réserve assumée. La caisse du candidat mesure **128,6 dans les deux modes** (le bleu
`vous` est identique en clair et en sombre) : en mode sombre elle est donc plus claire que la
chaussée (75,1), en clair plus sombre — inversion sans conséquence ici, aucune réponse ne s'y
joue, mais elle vaut d'être notée pour les scènes futures. Et le liseré blanc de la caisse
(255,0 / 234,3) est à la même valeur que la bande de rive : c'est la position, pas la
luminance, qui les distingue.

### `siege-enfant-place-avant`, retirée en ronde 1 de revue (2026-08-25)

Cette scène a existé ici, en gros plan d'habitacle, et elle a été **dessinée trois fois**
avant d'en arriver là. Les deux premières versions dessinaient une coupe de berline entière,
qui ne tient pas dans la **bande d'environ 110 unités** que le rétrécissement du bandeau
laisse autour du centre vertical : l'habitacle y descendait à 62 puis 68 unités de hauteur
intérieure, pour deux dossiers et une coque, et le sens de la coque tenait alors dans un
panneau de 18 unités de large, au milieu de trois silhouettes sombres empilées. La troisième
renonçait à la voiture et cadrait l'intérieur — pare-brise incliné, tableau de bord, et une
coque de 32 unités de large et 70 de haut dont l'asymétrie (dossier haut côté pare-brise,
rebord de pied bas côté arrière) devait dire le sens dos à la route.

Le relevé de luminance de cette version établissait que chaque forme se **détachait** des
autres dans les deux modes — la coque du fond de 55,1 points en clair et 159,4 en sombre, du
siège du véhicule de 40,9 et 81,3 ; le pare-brise du fond de 19,9 points en clair, sa mesure
la plus faible, d'où un contour sombre de 2,5 unités qui le bornait lui aussi. Ce que cette
mesure ne garantissait pas — et c'est le §13 de `methode.md` qui le dit en toutes lettres,
« un œil qui sait quelle réponse est attendue voit ce qu'il cherche » — c'est qu'un lecteur
qui ignore la réponse **lise** l'asymétrie comme un retournement plutôt que comme quatre
rectangles. La
revue de la tâche 13, en clair, en sombre et en niveaux de gris, a tranché en ce sens : rien
n'identifiait la coque, pas de silhouette arrondie, et le rebord de pied se lisait aussi bien
comme un petit dossier. La question était injouable même pour un lecteur voyant — pas
seulement décorative, ce qui est pire.

La scène a donc été retirée (code, imageset, cette entrée) et les deux faits qu'elle devait
porter — la place (avant) et le sens (dos à la route) — sont passés dans l'énoncé de la
question, qui n'est plus illustrée. Contrairement aux deux orphelins de la section précédente
(`giratoire-sortie-clignotant`, `ligne-jaune-continue`), ce n'est pas un dessin correct en
attente d'emploi : il ne resservira pas.

## Photographies

Recadrées en 4:3 puis sorties en @2x/@3x, JPEG qualité 82 — `sips` pour les deux premières,
`Tools/photo-panneau.py` (Pillow) à partir du B21b, qui dérive aussi la variante sombre que
`sips` ne sait pas produire. Le recadrage garde l'élément décisif dans la bande centrale,
celle qui survit au rétrécissement du bandeau à 18 % (voir
`QuestionCardView.hauteurDuBandeau`).

Les quatre panneaux d'interdiction (B1, B3, B6a1, B6d) viennent tous du même contributeur
que le B21b, Marc Mongenet, qui documente systématiquement la signalisation française sur
Commons. `panneau-b1-sens-interdit` provient d'un JPEG livré en orientation EXIF pivotée
(le fichier brut est un paysage 4000×3000, à pivoter 90° pour retrouver le portrait
3000×4000 que Commons affiche) : `photo-panneau.py` ne lit que les pixels bruts et ignore
l'EXIF, donc cette source a d'abord été réécrite bit à bit avec `PIL.ImageOps.exif_transpose`
avant tout centre de recadrage, sans quoi le panneau livré aurait tourné de 90°. Les trois
autres sources n'ont pas ce piège (orientation EXIF 1, pixels bruts déjà à l'endroit).

| asset | source | auteur | licence | relevé le | résolution d'origine |
|---|---|---|---|---|---|
| `panneau-giratoire-vue-conducteur` | [Commons — Panneau AB25 sur la D 183](https://commons.wikimedia.org/wiki/File:Panneau_AB25_sur_la_D_183.jpg) (2024-09-21) | Marc Mongenet | CC BY-SA 4.0 | 2026-08-23 | 5472 × 3648 |
| `ligne-jaune-continue` | [Commons — Marquage stationnement et arrêt interdits](https://commons.wikimedia.org/wiki/File:Marquage_stationnement_et_arr%C3%AAt_interdits_2013-11-17.JPG) (2013-11-17) | Tabl-trai | CC BY-SA 3.0 | 2026-08-23 | 2800 × 900 |
| `panneau-b21b-tout-droit` | [Commons — Les Pilles, panneau B21b](https://commons.wikimedia.org/wiki/File:Les_Pilles,_panneau_B21b.jpg) (2017-08-11) | Marc Mongenet | CC BY-SA 4.0 | 2026-09-22 | 4000 × 3000 |
| `panneau-b1-sens-interdit` | [Commons — Panneau B1 panonceau M9v1](https://commons.wikimedia.org/wiki/File:Panneau_B1_panonceau_M9v1.jpg) (2019-03-24) | Marc Mongenet | CC BY-SA 4.0 | 2026-09-22 | 3000 × 4000 |
| `panneau-b3-interdiction-depasser` | [Commons — A43 Panneau B3 panonceaux M4f M4x M1](https://commons.wikimedia.org/wiki/File:A43_Panneau_B3_panonceaux_M4f_M4x_M1.jpg) (2016-08-20) | Marc Mongenet | CC BY-SA 4.0 | 2026-09-22 | 2248 × 2248 |
| `panneau-b6a1-stationnement-interdit` | [Commons — Malagny Panneau B6a1 panonceau M8d bis](https://commons.wikimedia.org/wiki/File:Malagny_Panneau_B6a1_panonceau_M8d_bis.jpg) (2018-06-26) | Marc Mongenet | CC BY-SA 4.0 | 2026-09-22 | 4000 × 3000 |
| `panneau-b6d-arret-interdit` | [Commons — A75 Millau Panneau B6d](https://commons.wikimedia.org/wiki/File:A75_Millau_Panneau_B6d.jpg) (2019-08-10) | Marc Mongenet | CC BY-SA 4.0 | 2026-09-22 | 4000 × 3000 |

Ces sept-là passeraient une diffusion telles quelles : CC BY-SA demande l'attribution
(ce tableau la porte) et le partage à l'identique des seules œuvres dérivées de l'image.
Un recadrage en est une — donc si l'app est un jour distribuée, l'attribution devra
apparaître dans l'app, pas seulement ici.

## Ajouter une image

1. Schéma : ajouter la scène dans `Tools/Scenes/`, relancer `./Tools/render-scenes.sh`.
   Photo : `uv run --with pillow Tools/photo-panneau.py <source> <asset> --centre X,Y
   --largeur W`, qui recadre en 4:3, sort @2x/@3x et dérive la variante sombre.
2. Ajouter la ligne ici — asset, source, auteur, licence, date de relevé, résolution
   d'origine.
3. Poser l'`illustration` sur la question dans `questions.json` (`asset` + `alt`).
4. `python3 Tools/audit.py`, puis les tests.
