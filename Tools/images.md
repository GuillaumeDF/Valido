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
| `autoroute-voie-de-gauche` | trois voies d'un même sens, candidat le long de la glissière ; rive droite en **T4** (traits longs, vides courts) le long de la bande d'arrêt d'urgence, délimitation de voies en **T1** (vides longs, traits courts) | maison, aucune source tierce |
| `marquage-ligne-mixte` | ligne continue doublée d'une discontinue, la discontinue du côté du candidat | maison, aucune source tierce |
| `marquage-fleches-rabattement` | trois flèches de rabattement à cheval sur une ligne d'annonce, continue au-delà ; le candidat démarre dans la voie qui se termine, pas déjà dans celle désignée | maison, aucune source tierce |
| `marquage-zebra` | zone non circulable en chevrons au milieu de la chaussée, encadrée de deux continues | maison, aucune source tierce |
| `marquage-damier-detresse` | damier rouge et blanc d'une voie de détresse, à droite de la chaussée | maison, aucune source tierce |
| `marquage-ligne-continue-axiale` | chaussée à double sens, **une continue** dans l'axe, rien d'autre | maison, aucune source tierce |
| `marquage-ligne-discontinue-axiale` | la **même** chaussée, la même vue, axe en **discontinue T1** | maison, aucune source tierce |
| `marquage-ligne-discontinue-rive` | la **même** chaussée, la même vue, axe continu, et une **discontinue T2** le long de la rive droite délimitant l'accotement | maison, aucune source tierce |
| `marquage-zebra-vehicule-arrete` | la zone de chevrons de `marquage-zebra`, avec un véhicule **arrêté dessus** | maison, aucune source tierce |
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
| `giratoire-sans-panneau` | le **même** giratoire que `rond-point-insertion`, sans le panneau ni la flèche sur l'anneau | maison, aucune source tierce |
| `carrefour-feu-contre-panneau` | croisement nu, feu du candidat au **vert** (lampe du bas), STOP sur son approche | maison, aucune source tierce |
| `tramway-hors-intersection` | une chaussée à double sens croisée par des rails **en section courante**, aucune rue perpendiculaire | maison, aucune source tierce |
| `tourne-a-gauche-hors-intersection` | tourne-à-gauche vers un accès privé étroit, hors de toute intersection réglée, véhicule venant en face | maison, aucune source tierce |
| `sortie-de-parking` | un accès privé identique, le candidat en sortant pour rejoindre la chaussée où circule un autre véhicule | maison, aucune source tierce |
| `feu-jaune-fixe` | le **même** tricolore que `feu-jaune-clignotant`, lampe du milieu **allumée** et non clignotante | maison, aucune source tierce |
| `carrefour-feu-jaune-cedez` | même croisement que `carrefour-feu-contre-panneau`, feu en **jaune clignotant** et un **Cédez le passage** à la place du STOP | maison, aucune source tierce |
| `file-ralentie` | vue de dessus : cinq véhicules en file rapprochée, allure réduite, **aucun** feu de détresse allumé, le candidat en position centrale, les quatre autres au contour sombre | maison, aucune source tierce |
| `route-double-sens` | vue de dessus : une voie par sens, séparées par un axe **discontinu T1** ; le candidat dans sa voie, un véhicule d'en face dans l'autre, aucun panneau | maison, aucune source tierce |
| `route-deux-voies-par-sens` | la **même** voie de candidat, une seconde voie de son sens ajoutée à sa gauche (T1 les délimite), séparée d'une voie inverse unique — un véhicule s'y présente — par une **continue** | maison, aucune source tierce |
| `route-chaussees-separees` | les deux voies du candidat inchangées, la voie inverse en gagne une seconde — un véhicule dans la plus à gauche —, les deux chaussées séparées par un **terre-plein central** bordé de continues | maison, aucune source tierce |
| `route-trois-voies-double-sens` | la **même** voie de candidat, un véhicule lent devant lui dans sa voie, une voie centrale vide délimitée des deux côtés par un **T1** (pas une continue), un véhicule d'en face loin devant dans la voie la plus à gauche, restée vide près du candidat | maison, aucune source tierce |
| `stationnement-double-sens` | vue de dessus : chaussée à double sens, une voie par sens, trottoirs et bordures des **deux** côtés ; le candidat dans sa voie, un véhicule d'en face dans l'autre, **aucun véhicule garé** | maison, aucune source tierce |
| `stationnement-voie-bus` | vue de dessus : chaussée à deux voies, la voie de droite réservée aux bus — séparée de la voie générale par une **T3** et marquée « BUS » au sol —, **vide** ; le candidat dans la voie générale | maison, aucune source tierce |
| `inter-files` | vue de dessus : chaussée à deux voies du même sens, une file de voitures qui avancent dans chacune, une **moto** — corps étroit, guidon transversal, casque du pilote — roulant entre les deux, **en niveaux de gris** | maison, aucune source tierce |

### Les trois scènes de `Feux`

Trois scènes ajoutées, aucune carte touchée (`Valido/Resources/questions.json` reste à
`git diff --stat` vide tout au long de la tâche). Deux fonctions partagées, pour que rien ne
se recopie :

- **`feuJauneSeul(_:_:_:)`** (`ScenesCirculation.swift`) — extraite du corps de
  `feu-jaune-clignotant` (scène 5) ; l'état de la lampe du milieu (`.clignotante` ou
  `.allumee`) est le seul paramètre qui distingue `feu-jaune-fixe` (scène 28) de sa scène
  sœur.
- **`carrefourFeuEtPanneau(_:feu:panneau:_:)`** (`ScenesCarrefour.swift`) — extraite du
  corps de `carrefour-feu-contre-panneau` (scène 13) ; `feu` porte l'état des trois lentilles,
  `panneau` la fonction qui dessine le signal d'approche (`panneauStop` en scène 13,
  `panneauCedez` en scène 16, `carrefour-feu-jaune-cedez`). Le croisement, le véhicule du
  candidat et sa flèche restent ceux de la scène 1, au même point pour le feu et le panneau.

**Byte-identité des deux scènes refactorées.** `feu-jaune-clignotant` et
`carrefour-feu-contre-panneau` n'apparaissent dans aucune sortie de
`git status --porcelain -- Valido/Assets.xcassets` après rendu : leurs huit PNG (deux
imagesets, @2x/@3x, clair/sombre) sont revenus identiques à l'octet près.

**`feu-jaune-fixe` — la paire au trait près.** Différence pixel à pixel des PNG `@3x`
(identique dans les deux modes) : boîte `(495, 397)` → `(705, 503)`, soit 2 192 pixels
(clair) / 2 190 (sombre) — encadrant strictement la lampe du milieu et ses abords, jamais le
caisson ni les deux autres lentilles. C'est exactement ce que prédit `lentille()` : `.allumee`
et `.clignotante` partagent le même remplissage, le même halo et le même reflet, et ne se
séparent que par les six traits rayonnants que `.clignotante` ajoute après coup.

**`carrefour-feu-jaune-cedez` — deux différences déclarées, pas une paire au trait près.**
Différence pixel à pixel des PNG `@3x` (identique dans les deux modes), décomposée en ses
deux composantes disjointes — vérifié qu'aucun pixel ne diffère en dehors d'elles :

| composante | boîte (px, `@3x`) |
|---|---|
| feu (état des lentilles) | `(749, 227)` → `(823, 295)` |
| panneau (STOP → Cédez) | `(752, 600)` → `(844, 694)` |
| reste de l'image | vide |

**`file-ralentie` — pourquoi la position du candidat ne désigne pas la réponse.** La carte
demande *qui* doit allumer ses feux de détresse dans une file ralentie ; la bonne réponse est
« le dernier véhicule de la file ». Une scène qui allumerait des feux de détresse répondrait à
la question par le dessin plutôt que par la règle — d'où **aucun** feu de détresse allumé, sur
aucun véhicule. Placer en plus le véhicule du candidat en tête aurait suggéré l'option « au
conducteur de tête, qui voit le ralentissement » ; le placer en queue aurait dessiné la bonne
réponse elle-même, puisque le candidat serait alors littéralement « le dernier véhicule de la
file ». La scène pose donc cinq véhicules en file — deux devant, deux derrière — et loge le
candidat exactement au centre, à égalité de position avec n'importe lequel des trois qui
l'encadrent : sa place dans la file ne dit rien de plus que « il y a une file ».

**Les deux véhicules `tiers` frôlaient le seuil.** Sur une caisse posée seule sur la route,
`p.tiers` (232,89,78) ne se sépare de `p.chaussee` (92,93,98) que de 25,46 points d'écart en
clair sur les véhicules 2 et 5 — au-dessus du seuil de 25, mais de moins d'un demi-point,
exactement le constat déjà fait sur `croisement-chaussee-etroite` (25,5 points, section « Les
trois scènes de tunnel… », plus haut : « le constat qui avait déjà valu un contour au bus et
au poids lourd de la tâche 15 »), et `voiture()` porte depuis cette tâche un paramètre
`contour` prévu pour ce cas précis. Les quatre véhicules de décor de `file-ralentie` (`autre`
×2, `tiers` ×2) reçoivent donc `contour: traitSombre` — le même mécanisme, appliqué sans en
introduire un second ; le candidat garde son liseré habituel, déjà loin au-dessus du seuil
sans aucun ajout.

Un contour de 2 unités sur une caisse de 40 × 22 ne déplace pas la luminance moyenne d'une
zone de mesure de 20 × 20 posée en son centre : la caisse `tiers` reste donc mesurée à 25,5
en clair après comme avant l'ajout — le contour ne change rien à ce chiffre-là, il ajoute une
**seconde** ligne de séparation, à 51,0 dans les deux modes (la même valeur fixe
qu'à `croisement-chaussee-etroite`, indépendante de la teinte du véhicule qu'il cerne),
vérifiée identique sur les véhicules 1 et 2. Contre la chaussée, ce contour mesure 42,1 points
en clair et 24,1 en sombre — sous le seuil pris isolément en sombre, comme il l'était déjà
dans le rapport de `croisement-chaussee-etroite` sans y avoir été signalé comme un défaut :
ce n'est pas ce rapport-là qui porte la lecture, mais l'écart caisse/contour, 67,6 à 145,6
points selon le véhicule et le mode (`tiers` en clair au plus bas, `autre` en sombre au plus
haut) — une transition nette qu'aucune des deux teintes seules ne montrait.

Seul `file-ralentie` a changé au rendu (`git status --porcelain -- Valido/Assets.xcassets`
après `./Tools/render-scenes.sh`, `exit 0`) : ses quatre PNG, rien d'autre.

**Relevés de luminance** (Rec. 709 sur les PNG `@3x` livrés) :

| zone | clair | sombre | écart vs chaussée |
|---|---:|---:|---:|
| `feu-jaune-fixe` — lampe du milieu allumée | 205,6 | 215,5 | — |
| `feu-jaune-fixe` — boîtier | 93,1 | 75,1 | **112,5 / 140,4** |
| `carrefour-feu-jaune-cedez` — panneau (Cédez, fond blanc) | 255,0 | 245,3 | — |
| `carrefour-feu-jaune-cedez` — chaussée | 93,1 | 75,1 | **161,9 / 170,2** |
| `file-ralentie` — chaussée | 93,1 | 75,1 | — |
| `file-ralentie` — véhicule 1 (`autre`), caisse | 180,0 | 196,6 | **86,9 / 121,5** |
| `file-ralentie` — véhicule 2 (`tiers`), caisse | 118,6 | 154,1 | **25,5 / 79,0** |
| `file-ralentie` — véhicule 3 (candidat, `vous`), caisse | 128,6 | 128,6 | **35,5 / 53,5** |
| `file-ralentie` — véhicule 4 (`autre`), caisse | 180,0 | 196,6 | **86,9 / 121,5** |
| `file-ralentie` — véhicule 5 (`tiers`), caisse | 118,6 | 154,1 | **25,5 / 79,0** |
| `file-ralentie` — contour sombre (véhicules 1, 2, 4, 5 ; identique sur les quatre) | 51,0 | 51,0 | **42,1 / 24,1** |

Les cinq véhicules sont dans l'ordre de la file (tête en 1, queue en 5) ; le candidat, en
position 3, est le seul sans contour, avec son liseré habituel. Toutes les valeurs de caisse
dépassent 25 points dans au moins un mode ; en clair, `tiers` reste à 25,5 sur la caisse
seule (inchangé par le contour, qui ne touche pas le centre de la caisse), et c'est le
contour qui lui ajoute une seconde séparation, lisible à 51,0 contre la caisse (67,6 en
clair, 103,1 en sombre) comme contre la chaussée (42,1 / 24,1).

Toutes les valeurs dépassent 25 points, dans les deux modes.

### Les cinq scènes de configuration de « Priorités & intersections »

Cinq scènes ajoutées à `Tools/Scenes/ScenesCarrefour.swift`, sans toucher à aucune carte
existante. Trois fonctions partagées, pour que rien ne se recopie :

- `giratoireInsertion(_:panneau:_:)` — extraite du corps de `rond-point-insertion` ; le
  paramètre `panneau` est toute la différence entre elle et `giratoire-sans-panneau`.
- `tramwayEnApproche(_:_:)` — extraite du corps de `carrefour-tramway` ; partagée telle
  quelle par `tramway-hors-intersection`.
- `accesPrive(_:y:largeur:_:)` — nouvelle, partagée par `tourne-a-gauche-hors-intersection`
  et `sortie-de-parking`.

Les deux extractions ont été vérifiées **byte-identiques** : `carrefour-tramway` retrouve
ses quatre PNG à l'octet près après rendu (`cmp` sur les deux `@3x`). `rond-point-insertion`
a d'abord semblé changer — même code, même flags — parce que `render-scenes.sh` réclamait
par défaut `Xcode-26.3.0.app`, absent de ce poste, qui n'a que `Xcode-27.0.0.app` : les PNG
livrés avant la tâche 4B avaient donc été rendus sous un compilateur Swift différent de
celui que quiconque peut faire tourner ici. Isolé pendant la tâche en rendant l'ancien code
sous `DEVELOPER_DIR=Xcode-27.0.0.app` : il produisait déjà un fichier différent du PNG
livré (même boîte, même magnitude que ce que le nouveau code produisait), et un second
rendu du nouveau code, dans la même session, retombait à l'octet près sur ce que l'ancien
code venait de produire — la différence tenait au compilateur, pas au code. C'était le
même bruit que celui déjà relevé et écarté par la tâche 3B-1, sur exactement les mêmes sept
imagesets (`carrefour-stop`, `croisement-en-pente`, `giratoire-sortie-clignotant`,
`panneau-b14-limitation`, `panneau-b30-zone-30`, `panneau-b33-fin-limitation`,
`rond-point-insertion`).

**Corrigé à la racine, plutôt que recontourné scène par scène** : `render-scenes.sh` défaut
désormais sur `Xcode-27.0.0.app`, le seul installé ici, et l'intégralité du dépôt a été
**rerendue** sous ce compilateur — ces mêmes
sept imagesets, 28 PNG, aucun changement de contenu — puis un second passage du script sur
l'arbre propre confirme `git status --porcelain -- Valido/Assets.xcassets` vide : le rendu
est désormais déterministe sur ce poste. `rond-point-insertion` et `giratoire-sans-panneau`
sont donc, depuis, rendus par le **même** compilateur, et la boîte de différence ci-dessous
est mesurée sur les fichiers réellement livrés — pas sur un rendu de session parallèle.

**La paire du giratoire.** `rond-point-insertion` pose un `panneauCedez` sur l'entrée du
candidat, qui donne la priorité au véhicule déjà sur l'anneau — sa flèche dit qu'il passe.
Sans ce panneau, un giratoire relève de la priorité à droite ordinaire, et c'est l'entrant
qui passerait : garder la flèche aurait dessiné la réponse inverse de la bonne. La scène
sans panneau retire donc **les deux** — panneau et flèche — plutôt que de figer une flèche
neutre : elle pose la question sans y répondre. Ce choix élargit la boîte de différence
au-delà du seul panneau, et c'est mesuré plutôt que caché :

Différence pixel à pixel des PNG `@3x` (identique dans les deux modes), décomposée en ses
deux composantes disjointes — vérifié qu'aucun pixel ne diffère en dehors d'elles :

| composante | boîte (px, `@3x`) | boîte (unités de scène) |
|---|---|---|
| flèche retirée (véhicule déjà sur l'anneau) | `(438, 504)` → `(588, 624)` | `(146, 168)` → `(196, 208)` |
| panneau retiré (`panneauCedez`) | `(758, 691)` → `(850, 772)` | `(253, 230)` → `(283, 257)` |
| reste de l'image | vide | — |

**La paire du feu.** `carrefour-feu-contre-panneau` reprend `croisementNu`, comme
`carrefour-feu-en-panne`. Le feu du candidat est planté au-delà du carrefour, sur son
approche (`feuTricolore` avec `[.eteinte, .eteinte, .allumee]`, largeur par défaut) : seule
la lampe du **bas** est allumée, au vert — la position, pas la teinte, qui la désigne selon
l'arrêté du 24 novembre 1967. Un STOP (`panneauStop`), sur l'approche du candidat, ordonne
l'inverse : c'est le conflit que la carte interroge, et le feu — réglage le plus récent —
l'emporte sur le panneau, réglage permanent.

**Relevés de luminance** (Rec. 709 sur les PNG `@3x` livrés) :

| zone | clair | sombre | écart |
|---|---:|---:|---:|
| `giratoire-sans-panneau` — véhicule du candidat | 128,6 | 128,6 | — |
| `giratoire-sans-panneau` — chaussée | 93,1 | 75,1 | **35,5 / 53,5** |
| `carrefour-feu-contre-panneau` — lentille verte allumée | 166,7 | 170,7 | — |
| `carrefour-feu-contre-panneau` — boîtier (chaussée) | 93,1 | 75,1 | **73,6 / 95,6** |
| `carrefour-feu-contre-panneau` — STOP (bande rouge, relevé à quatre points du pourtour) | 86,0 | 115,1 | — |
| `carrefour-feu-contre-panneau` — sol autour du STOP | 235,1 | 37,2 | **149,1 / 77,9** |
| `tramway-hors-intersection` — rail | 255,0 | 234,3 | — |
| `tramway-hors-intersection` — chaussée | 93,1 | 75,1 | **161,9 / 159,2** |
| `tourne-a-gauche-hors-intersection` — véhicule du candidat | 128,6 | 128,6 | — |
| `sortie-de-parking` — véhicule du candidat | 128,6 | 128,6 | — |
| les deux — chaussée | 93,1 | 75,1 | **35,5 / 53,5** |

Toutes les valeurs dépassent 25 points, dans les deux modes. Le centre du panneau (STOP,
lettrage blanc) mesure à part — 255,0 clair / 245,3 sombre — et n'est pas la zone décisive :
c'est la bande rouge qui distingue la forme du sol, le blanc du lettrage n'ajoutant qu'une
lisibilité supplémentaire, non un contraste de reconnaissance.

**Un défaut non mesuré jusqu'ici : l'îlot central.** `giratoire-sans-panneau`,
`rond-point-insertion` et `giratoire-sortie-clignotant` partagent la même géométrie et
posent l'îlot en `p.ilot` (219,0 clair / 69,2 sombre) sur un anneau en chaussée (93,1 /
75,1) : seulement **5,9 points d'écart en sombre**. L'îlot s'y confond avec la chaussée ;
l'anneau ne se lit plus que par ses tirets. C'est le même défaut, sur la même teinte
`p.ilot`, que celui déjà relevé sur le terre-plein d'`autoroute-voie-de-gauche` (tâche 6B,
remplacé par `p.bordure`) — resté en observation sur cette famille de scènes. Aucune option
de `dd4c58febe771b6f297f1ca46c2ec75b`, `02f7d6a65856887348bfe8653bb90c6e` ou
`2daf8939fc85f5b288010cf545bb681d` ne s'appuie sur l'îlot lui-même : les trois cartes
interrogent une règle de priorité ou de signalisation, et l'anneau reste lisible par ses
tirets même sans lui.

**Re-vérifié sur l'arbre rerendu et déterministe** :

- la paire du giratoire ci-dessus, remesurée : boîte identique (`(438, 504)` → `(850, 772)`,
  décomposée dans les deux mêmes composantes, rien d'autre) ;
- `stationnement-ligne-jaune-continue` / `-discontinue` : 9 504 pixels diffèrent, bande
  x ∈ [251,3 ; 258,3] — inchangé (ces deux imagesets n'étaient pas de ceux que le
  compilateur faisait bouger) ;
- les trois lignes de la tâche 3B-1 (`marquage-ligne-continue-axiale` et ses deux
  variantes) : mêmes boîtes qu'au rapport de cette tâche, `(592, 45)` → `(608, 900)` et
  `(879, 45)` → `(888, 878)` — inchangées ;
- relevé de luminance sur cinq points déjà chiffrés ci-dessus et plus haut (marquage plein
  d'une continue, T1 au plein et au vide, T2 au plein et au vide, trait jaune plein et
  bordure nue d'une ligne de stationnement) : chaque valeur retombe **à la décimale** sur
  celle déjà publiée, dans les deux modes ;
- test direct sur un des sept imagesets que le compilateur faisait bouger
  (`panneau-b14-limitation`) : le centre du disque (255,0 / 245,3) et sa bande rouge
  (86,0 / 115,1) sont **identiques à l'octet** entre le PNG d'avant rebaseline
  (`Xcode-26.3`, extrait par `git show`) et celui d'après (`Xcode-27`) ; toute la
  différence entre les deux rendus tient dans une boîte `(540, 411)` → `(682, 490)`, autour
  du texte du panneau — l'antialiasing d'un glyphe, jamais une figure mesurée sur un
  remplissage plein.

### Les quatre scènes d'usagers

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
  27 unités il était illisible et n'expliquait plus rien — **retiré** : les deux lignes
  d'arrêt et la figurine au sol suffisent à porter le sens du sas.
- Le **cycliste vu de dessus a été redessiné deux fois**, et les deux fois la mesure ne
  suffisait pas à trancher : la première version (guidon et épaules à 0,30 de la longueur) se
  lisait comme un poteau surmonté d'un point, la seconde (tête sombre sur épaules colorées)
  comme un anneau — l'écart de luminance était pourtant bon dans les deux cas. Ce qui a réglé
  la question est un buste **plus long que large** et une tête **claire** cernée d'un filet
  sombre. Même remarque pour le piéton, dont la tête sombre du premier jet évidait la
  silhouette sur le trottoir du mode sombre (37,2). La mesure prouve la visibilité, pas
  l'intelligibilité : elle se relit à l'œil, dans les deux modes.

  **Le même défaut « anneau »** avait été corrigé sur le cycliste mais laissé sur le
  piéton — tête à 0,48 de `taille`, sur des épaules à 0,90, soit un rapport de 0,53
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

### Les quatre scènes de croisement et dépassement

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

### Les trois scènes de tunnel et de passage à niveau

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

**`marquage-zebra` dessinait une seule pente uniforme sur une zone qui sépare deux sens
opposés.** L'art. 117-2 A de la 7e partie (relevé mot pour
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

`giratoire-sortie-clignotant` n'est plus orphelin depuis la tâche 4C (2026-09-23) : il
illustre désormais `02f7d6a65856887348bfe8653bb90c6e` (usage du clignotant droit avant de
quitter l'anneau), la question que la revue antérieure attendait.

**Le défaut du B30 dessiné en carré, noté ici depuis le 2026-08-23, est levé depuis le
2026-09-23 (tâche 6A) :** l'art. 45 de la 4e partie place le B30 « dans un **rectangle**
pour les zones 30 » et l'art. 5-3 lui donne 700 × 900 mm en gamme normale ; le carré
portait quand même le point de la question — une prescription zonale, pas ponctuelle —
mais la forme était fausse. `panneau-b30-zone-30` est maintenant une photographie
(section Photographies, plus bas), et le panneau retenu y est bien rectangulaire, plus
haut que large.

`croisement-en-pente` est la seule scène **de profil** et non vue de dessus. Ce n'est pas
un écart de style : une pente ne se voit pas en vue aérienne, et c'est le sens de la
déclivité qui décide de la réponse. La règle de cadrage tient quand même — les deux
véhicules sont au centre vertical, dans la bande qui survit au rétrécissement du bandeau.

Le B14, le B33 et le B30 avaient été redessinés d'après la planche de la page 4 du [guide
technique « la zone 30 »](https://www.securite-routiere.gouv.fr/sites/default/files/2019-02/guide_techn_fiche4_technique_zone30_cle29ec98.pdf)
publié par la Sécurité routière (relevé le 2026-08-23), faute de mieux : Cloudflare rendait
alors le téléchargement des parties de l'IISR inaccessible. L'IISR relevée depuis (voir
plus haut) les confirme, et corrige la forme du B30. Les trois dessins sont retirés depuis
le 2026-09-23 (tâche 6A) : ce paragraphe reste pour l'historique de la forme, pas pour un
code qui n'existe plus.

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

### Quatre scènes de marquage : trois lignes, un zébra occupé

Un marquage se dessine, il ne se photographie pas — c'est la ligne de partage de tout le
chantier des illustrations (les seize panneaux remplacés par une photographie l'ont été
pour la raison inverse : un pictogramme normé, qu'aucun redessin n'atteint). Ces quatre
scènes portent de la géométrie — largeur, modulation, inclinaison — qu'un dessin rend
exactement.

**Les trois premières sont identiques au trait près**, exactement pour la raison exposée
plus haut à propos de la paire de lignes jaunes : si deux cartes d'une même notion se
distinguaient par autre chose que ce qu'elles enseignent — le cadrage, la largeur de voie,
la position d'une voiture —, c'est cet écart-là qu'on apprendrait, pas la règle. Les trois
partagent donc `sceneLigne` (`Tools/Scenes/ScenesPanneaux.swift`), qui pose la même
`chausseeDeMarquage` et ne fait varier que le marquage nommé en paramètre. Vérifié par
différence pixel à pixel des PNG @3x :

| paire | boîte des différences |
|---|---|
| `marquage-ligne-continue-axiale` / `marquage-ligne-discontinue-axiale` | x ∈ [592, 608], une bande verticale centrée sur l'axe |
| `marquage-ligne-continue-axiale` / `marquage-ligne-discontinue-rive` | x ∈ [879, 888], une bande verticale centrée sur la rive droite |

Aucune des deux boîtes ne couvre autre chose qu'une bande étroite : les deux scènes ne
diffèrent qu'au marquage nommé, dans les deux modes.

**La norme (IISR, 7e partie).** L'art. 113-1, B donne la modulation de chaque type — table
relevée mot pour mot : T1 « 3 m de trait, 10 m d'intervalle », rapport plein/vide 1/3 ; T2
« 3 m de trait, 3,5 m d'intervalle », rapport 1. L'art. 113-2 dit quel marquage reçoit
quel type : « Ligne axiale ou de délimitation de voie en rase campagne (articles 114, 114-1
et 114-2) » → T1 ; « Ligne de rive de chaussée (art. 114-4, A) » → T2. Et l'art. 114-4, A
tranche le cas de la troisième scène mot pour mot : « Sur route, la ligne de rive est de
type T2 et de largeur 3u » — en section courante, hors autoroute. L'autoroute, elle, marque
sa bande d'arrêt d'urgence en **T4** et non en T2 (art. 114-4, B, déjà relevé plus haut à
propos de `autoroute-voie-de-gauche`) : les deux rives ne portent pas la même modulation,
et c'est le type de route qui décide laquelle s'applique. `ligneT1` et `ligneT2` dessinent
15 unités de trait pour respectivement 65 et 32,5 unités de cycle — 15/50 = 0,3 et
15/17,5 = 0,857, les deux rapports de la table à l'échelle déjà utilisée par `ligneAxialeT1`
de `ScenesCirculation.swift` (5 unités par mètre).

**La quatrième**, `marquage-zebra-vehicule-arrete`, réutilise la zone de chevrons de
`marquage-zebra` — extraite dans `zoneChevrons`, revérifié après extraction : le PNG livré
de `marquage-zebra` n'a pas bougé d'un octet — mais remplace la circulation de part et
d'autre par un véhicule arrêté dessus, l'occupation que la carte interroge. Aucun asset ne
sert deux cartes.

Relevé de luminance (Rec. 709 sur les PNG @3x livrés, `Y = 0,2126 R + 0,7152 G + 0,0722 B`),
coordonnées en unités de scène (le pixel lu est 3× celles-ci) :

| zone | x, y | clair | sombre |
|---|---|---|---|
| `marquage-ligne-continue-axiale` — marquage | 200, 150 | 255,0 | 234,3 |
| `marquage-ligne-continue-axiale` — chaussée | 150, 150 | 93,1 | 75,1 |
| `marquage-ligne-discontinue-axiale` — T1, au plein | 200, 7 | 255,0 | 234,3 |
| `marquage-ligne-discontinue-axiale` — T1, au vide | 200, 170 | 93,1 | 75,1 |
| `marquage-ligne-discontinue-rive` — T2, au plein | 294, 5 | 255,0 | 234,3 |
| `marquage-ligne-discontinue-rive` — T2, au vide | 294, 22 | 93,1 | 75,1 |
| `marquage-zebra-vehicule-arrete` — trait blanc de la zone | 195, 4 | 255,0 | 234,3 |
| `marquage-zebra-vehicule-arrete` — fond sombre de la zone | 200, 0 | 93,1 | 75,1 |
| `marquage-zebra-vehicule-arrete` — véhicule (caisse) | 196, 150 | 128,6 | 128,6 |

Le marquage se détache de la chaussée de 161,9 points en clair et 159,2 en sombre sur les
trois premières scènes — la même paire de valeurs partout, puisque c'est la même chaussée.
Sur la quatrième, le véhicule se détache des **deux** composantes de la zone qu'il occupe :
de 126,4 (clair) et 105,7 (sombre) points contre le trait blanc, de 35,5 (clair) et 53,5
(sombre) contre le fond sombre entre les chevrons. Une moyenne mêlant les deux composantes
sur un carré aurait pu, par construction, retomber près de la teinte du véhicule sans que
rien ne soit illisible — c'est pour ça que les deux composantes sont mesurées séparément
plutôt qu'en une seule zone moyennée. Aucune des quatre scènes ne repose sur une teinte
seule : la polarité (marquage clair sur chaussée sombre, véhicule à mi-chemin des deux mais
à plus de 25 points de chacune) est identique dans les deux modes.

### Les trois types de route hors agglomération

Trois fondations de `Vitesse` décrivaient en mots, sur 99 à 109 caractères, une
configuration de chaussée dont la vitesse par défaut dépend entièrement : une voie par sens
(`37fe1af42b8d817994d5f81863c7e6ae`, 80 km/h), deux voies dans le sens du candidat sans
terre-plein (`f7370daabea929065f6b2586ca3eea91`, 90 km/h), deux chaussées séparées par un
terre-plein central (`fed604fe7c4b8b3b96adc066a7902138`, 110 km/h). Aucune carte n'a été
touchée par cette tâche elle-même : une tâche ultérieure les a illustrées, et les trois
portent aujourd'hui ces scènes (`route-double-sens`, `route-deux-voies-par-sens`,
`route-chaussees-separees`).

**Une famille, une fonction.** `sceneRoute(_:)` (`Tools/Scenes/ScenesPanneaux.swift`), sur le
modèle direct de `sceneLigne` : la configuration en paramètre, `ligneT1` et `ligneContinue`
réutilisées telles quelles, aucun corps de scène recopié. Échelle et largeur de voie : celles
de `depassement-ligne-discontinue` (`ScenesCirculation.swift`) — 16 unités par mètre, voie de
56 unités pour 3,50 m.

**Ce que l'IISR a fourni.** Art. 113-1, B (modulation T1, « 3 m de trait, 10 m
d'intervalle ») et art. 113-2 (« Ligne axiale ou de délimitation de voie en rase campagne » →
T1), déjà relevés pour la tâche 3B-1 — le même T1 sert ici deux rôles distincts : axe séparant
les deux sens dans la première scène, délimitation de voies du même sens dans les deux
suivantes, posé au **même** `x` (`routeDroite - routeVoie`) dans les trois. Art. 114-4, B
(« les lignes de délimitation de terre-plein central sont continues et de largeur 3u »),
déjà relevé pour `autoroute-voie-de-gauche`, pour les deux continues qui bordent le
terre-plein. **Ce que l'IISR ne fournit pas** : la largeur du terre-plein lui-même — une
largeur de chaussée est un fait de conception routière, pas de signalisation — retenue à
40 unités (2,5 m) pour rester lisible à cette échelle, sans prétendre relever une cote
officielle. Aucune ligne de rive n'est dessinée : elle n'entre dans ce qu'aucune des trois
cartes ne distingue, et en ajouter poserait une question de plus que l'énoncé ne pose pas —
même raisonnement que l'axe absent de `croisement-chaussee-etroite`.

**Comment la voie du candidat reste fixe.** Les trois configurations n'ont pas la même
largeur de chaussée, donc pas le même cadrage possible à voiture et voie identiques partout.
Le parti pris : la rive droite de la voie du candidat est une constante (`routeDroite = 328`),
sa voie est toujours la voie la plus à droite, et la chaussée s'étend vers la **gauche** à
mesure que la configuration se charge — jusqu'à deux voies de plus et un terre-plein pour la
troisième. Tout ce qui est à droite de cette rive (la voie du candidat, sa voiture, le
`sol` au-delà) est donc identique dans les trois scènes, pixel pour pixel ; c'est la chaussée,
à gauche, qui varie et qui porte seule la différence de configuration.

**La boîte de différence, vérifiée par différence pixel à pixel des PNG `@3x`** (identique
dans les deux modes) :

| paire | boîte des différences (px) | boîte (unités de scène) |
|---|---|---|
| `route-double-sens` / `route-deux-voies-par-sens` | `(480, 0)` → `(774, 900)` | `(160, 0)` → `(258, 300)` |
| `route-deux-voies-par-sens` / `route-chaussees-separees` | `(192, 0)` → `(656, 900)` | `(64, 0)` → `(≈219, 300)` |
| `route-double-sens` / `route-chaussees-separees` | `(192, 0)` → `(774, 900)` | `(64, 0)` → `(258, 300)` |

Deux des trois boîtes s'étendent maintenant jusqu'à x = 258 unités de scène (774 px) : c'est
le véhicule d'en face de `route-double-sens`, dont la voie (centre x = 244) est la plus à
droite des trois positions que prend ce véhicule selon la scène (voir plus bas). Ce nouveau
bord reste **avant** la ligne T1 commune aux trois (posée à x = 272, large de 5, donc à
partir de x = 269,5) — vérifié directement, en comparant le recadrage x ≥ 272 des trois PNG
`@3x` à leur version d'avant ce véhicule (`git show HEAD:…`) : bbox de différence vide dans
les six cas (trois scènes, deux modes). Tout ce qui est à droite de cette ligne — la voie du
candidat, la ligne T1 elle-même, sa voiture, et le `sol` au-delà de la rive droite — reste
donc bit pour bit identique dans les trois scènes ; seule la chaussée à gauche, qui porte le
véhicule d'en face en plus de la configuration elle-même, diffère.

**Relevé de luminance** (Rec. 709 sur les PNG `@3x` livrés, `Y = 0,2126 R + 0,7152 G +
0,0722 B`), coordonnées en unités de scène (le pixel lu est 3× celles-ci) :

| zone | x, y | clair | sombre |
|---|---|---:|---:|
| T1, au plein | 272, 7 | 255,0 | 234,3 |
| T1, au vide (= chaussée) | 272, 40 | 93,1 | 75,1 |
| chaussée témoin (voie du candidat) | 300, 250 | 93,1 | 75,1 |
| véhicule du candidat, caisse | 300, 154 | 128,6 | 128,6 |
| terre-plein (`route-chaussees-separees` seule) | 196, 100 | 139,1 | 115,3 |
| chaussée contre le terre-plein | 244, 100 | 93,1 | 75,1 |
| véhicule d'en face, caisse (`route-double-sens`) | 244, 100 | 180,0 | 196,6 |
| véhicule d'en face, caisse (`route-deux-voies-par-sens`) | 188, 100 | 180,0 | 196,6 |
| véhicule d'en face, caisse (`route-chaussees-separees`) | 92, 100 | 180,0 | 196,6 |
| chaussée témoin, sous chacun des trois véhicules d'en face | même x, y = 250 | 93,1 | 75,1 |

Le marquage se détache de la chaussée de **161,9 / 159,2** points (clair/sombre) — la même
paire que sur toutes les scènes de marquage du dossier, puisque c'est la même chaussée et le
même blanc. Le véhicule du candidat se détache de la chaussée de **35,5 / 53,5** points ; le
véhicule d'en face, de **86,9 / 121,5** points, identique aux trois positions qu'il occupe
selon la scène (même teinte `p.autre`, même chaussée sous lui).

**Le terre-plein, et pourquoi `ilot` ne convient pas.** Un premier essai posait le
terre-plein en `p.ilot` — la couleur déjà réservée au terre-plein de
`autoroute-voie-de-gauche` — et mesurait 219,0 en clair mais seulement **69,2 en sombre**,
contre 75,1 pour la chaussée : un écart de 5,9 points, un ressaut invisible. C'est
exactement le défaut déjà relevé sur `bordure` (`Repere.swift`) quand elle a remplacé `ilot`
pour les scènes de stationnement (« en mode sombre elle mesure 54 en niveaux de gris contre
58 pour la chaussée ») — et la solution est la même : `p.bordure`, qui se sépare de la
chaussée de **46,0 / 40,2** points dans les deux modes (139,1 / 115,3 contre 93,1 / 75,1).
Aucune couleur n'a été ajoutée à `Palette` ; c'est aussi la couleur la plus indiquée pour ce
que le brief demande explicitement — que le terre-plein se distingue par sa luminance et non
par une teinte verte.

Toutes les valeurs dépassent 25 points, dans les deux modes.

**Le sens de circulation n'était pas lisible sur une seule scène.** Rien, dans les trois
scènes d'origine, ne montrait le sens de circulation. `ligneT1` trace la même modulation
qu'elle sépare deux sens (`route-double-sens`) ou deux voies du même sens
(`route-deux-voies-par-sens`, `route-chaussees-separees`) — c'est l'IISR qui le veut ainsi,
pas un choix de dessin (art. 113-1, B et 113-2 citées plus haut, dans les deux cas). Le bloc
à gauche de cette ligne, dans `route-double-sens`, est **bit pour bit identique** à la
seconde voie du candidat dans `route-deux-voies-par-sens` — rien ne distinguait donc « une
voie inverse » de « une seconde voie du même sens » sur la première scène prise seule. La
largeur totale de la chaussée aurait pu sembler trancher, mais elle ne le fait qu'en
comparant les trois scènes côte à côte, ce qu'un candidat ne fait jamais : une carte se lit
seule.

**La correction : un véhicule d'en face, cap sud, sans liseré, dans la voie la plus à
gauche de chaque scène** — `p.autre`, la teinte déjà réservée aux véhicules tiers du
dossier, hauteur `y = 100`, décalée de celle du candidat (`y = 154`) pour ne pas se lire
comme un face-à-face, exactement comme `marquage-ligne-mixte` et `marquage-zebra` décalent
déjà leurs deux véhicules opposés. Une seule fonction partagée avec le candidat
(`voitureRoute`, paramétrée en `cap`/`couleur`/`liseree`) plutôt que deux corps de dessin
recopiés. Sa position horizontale suit la voie la plus à gauche de chaque configuration —
x = 244 (`route-double-sens`), 188 (`route-deux-voies-par-sens`), 92
(`route-chaussees-separees`) — et c'est la seule chose qui varie d'une scène à l'autre ; sa
hauteur, sa teinte et l'absence de liseré sont constantes. `p.autre` se détache de la
chaussée de 86,9 points en clair et 121,5 en sombre (relevé ci-dessus, identique aux trois
positions) — aucun contour n'était nécessaire, à la différence du traitement `tiers` de la
tâche 5A.

Vérifié par recadrage x ≥ 272 des six PNG `@3x` livrés contre leur version
d'avant (`git show HEAD:…`) : bbox de différence vide dans les six cas — la voie du
candidat, la ligne T1, sa voiture et le `sol` au-delà n'ont pas bougé d'un pixel. Seule la
chaussée à gauche de cette ligne porte maintenant, en plus de la configuration, le véhicule
d'en face qui la rend lisible sans les deux autres scènes sous les yeux.

### La chaussée à trois voies de `Croisement & dépassement`

Une quatrième configuration ajoutée à `ConfigurationDeRoute` (`ScenesPanneaux.swift`),
`.troisVoiesDoubleSens`, plutôt qu'une nouvelle fonction : elle réutilise `sceneRoute`, la
voie du candidat fixe et `voitureRoute` de la tâche 6B. Après rendu,
`git status --porcelain -- Valido/Assets.xcassets` ne montre que l'imageset neuf — les
trois scènes de la tâche 6B ressortent bit pour bit identiques.

**Ce que R414-8 impose au marquage.** L'article interdit à qui dépasse d'emprunter la voie
la plus à gauche d'une chaussée à double sens de plus de deux voies, ce qui la laisse à ceux
qui viennent en face. L'IISR 7e partie, art. 114-1 (« Routes à trois voies de rase
campagne »), en tire la marque : « Les lignes discontinues sont de type T1 et de largeur 2u.
Elles sont comprises dans le tiers central de la chaussée. » — donc **deux T1**, un de
chaque côté de la voie centrale, jamais une continue : à la différence de
`route-deux-voies-par-sens`, où la seconde voie est affectée en permanence au candidat, la
voie centrale d'une route à trois voies ne l'est à aucun sens, elle sert au dépassement des
deux côtés. C'est cette continue-là, plus qu'un simple T1 de plus, qui aurait fait de la
scène une redite de `route-deux-voies-par-sens` avec un véhicule en moins.

**Deux véhicules ajoutés au véhicule d'en face déjà partagé par la famille**, tous deux
`voitureRoute`, aucune géométrie recopiée :

- **Un véhicule lent dans la voie du candidat** (`p.tiers`, sans liseré, cap nord, devant
  lui) — sans lui, la voie centrale vide ne motiverait aucun dépassement, la scène ne
  poserait pas de question. `p.tiers` est déjà la teinte du troisième véhicule de
  `croisement-chaussee-etroite` ; aucune couleur n'a été ajoutée à `Palette`.
- **Le véhicule d'en face partagé (`p.autre`)**, dans la voie la plus à gauche — **loin
  devant**, et surtout **absente à hauteur du candidat** : sans ce vide, le distracteur
  « prenez la voie de gauche, la plus dégagée » ne serait plus défendable, et la carte ne
  testerait plus la règle mais l'évidence d'un véhicule visible. La voie centrale reste elle
  aussi vide sur toute sa longueur — aucun véhicule n'y roule ni n'y est arrêté.

Ces deux choix (voie de gauche vide près du candidat, voie centrale vide) sont ceux du
brief de la tâche 7 ; une tâche future qui ajouterait un véhicule à l'un ou l'autre endroit
retirerait au distracteur A sa raison d'être tentant.

**Relevés de luminance** (Rec. 709, PNG `@3x`, coordonnées en unités de scène, écart contre
la chaussée de la même voie) :

| zone | x, y | clair | sombre | écart clair | écart sombre |
|---|---|---:|---:|---:|---:|
| T1 entre voie centrale et voie opposée, au plein | 216, 7 | 255,0 | 234,3 | 161,9 | 159,2 |
| véhicule du candidat, caisse | 300, 154 | 128,6 | 128,6 | 35,5 | 53,5 |
| véhicule lent (`p.tiers`), caisse | 300, 90 | 118,6 | 154,1 | 25,5 | 79,0 |
| véhicule d'en face (`p.autre`), caisse | 188, 30 | 180,0 | 196,6 | 86,8 | 121,4 |

Le T1 candidat/voie centrale (`x = 272`) reprend le code déjà mesuré à la tâche 6B (255,0 /
93,1 clair, 234,3 / 75,1 sombre) : même position, même code, non re-listé. Toutes les
valeurs dépassent le plancher de 25 points, dans les deux modes ; l'écart le plus serré
(25,5, véhicule lent en clair) reste au-dessus, mesuré sur un point pur du corps du
véhicule, hors pare-brise.

### Les deux scènes d'« Arrêt & stationnement »

Deux scènes ajoutées à `Tools/Scenes/ScenesCirculation.swift`, aucune scène existante
touchée : après rendu, `git status --porcelain -- Valido/Assets.xcassets` ne montre que
les deux imagesets neufs, et un contrôle SHA-256 des 196 PNG déjà livrés (avant/après)
retombe à l'octet près sur chacun d'eux.

**`stationnement-double-sens`** reprend la géométrie de `bus-quittant-arret` et
`sas-cycliste-feu` (`rueBordeeDeDeuxTrottoirs`, gauche 152, droite 248, bordure 12,
axe 200, pas 24) : deux trottoirs, deux bordures, un axe médian discontinu. **Aucun
véhicule garé** — une file rangée à droite aurait donné la réponse avant qu'elle ne se
pose. Le véhicule d'en face (`p.autre`, cap sud, sans liseré) est ce qui fait lire
« double sens » : sans lui, la voie du candidat se lirait aussi bien comme une chaussée à
sens unique vue d'une seule voie — même raison que le véhicule d'en face de `sceneRoute`
(tâche 6B). Le trottoir porte un distracteur de la carte (« Sur le trottoir, si les
piétons peuvent passer ») : ce n'est donc pas un décor neutre, et sa luminance contre la
chaussée est mesurée ci-dessous comme le reste.

« En agglomération » reste dans l'énoncé plutôt que d'être retiré : les deux trottoirs et
leurs bordures **suggèrent** l'agglomération, ils ne la **prouvent** pas — à la différence
de `depassement-cycliste-distance`, où des piétons avaient été ajoutés spécifiquement pour
faire de ce fait une donnée sûre. Cette scène n'en pose aucun ; le mot reste donc du texte.

**`stationnement-voie-bus`** est une chaussée à deux voies : la voie générale (candidat,
`p.vous`, liseré) et la voie de bus, **vide** — l'absence de bus est précisément ce que
l'explication nomme comme piège (« jamais l'absence de bus »), la scène ne devait donc pas
la corriger en en dessinant un. Les deux voies sont séparées par une ligne discontinue de
type T3, largeur 5u (IISR, 7e partie, art. 118-3, A, qui renvoie à l'art. 114-3, 2° :
trois régimes selon le couloir — continue à contresens, continue en couloir permanent où
le dépassement est interdit, **discontinue T3 dans tous les autres cas de couloirs
réservés dans le sens normal**, celui d'ici, en l'absence de toute mention contraire —
modulation « 3 m de trait, 1,33 m d'intervalle », rapport plein/vide 2,25, calculé au
rapport exact plutôt que fixé comme le fait `ligneT3` de `ScenesPanneaux.swift` pour un
usage différent). Le mot « BUS » est peint au sol, comme le permet l'art. 118-3, E
(« en répétition le long des couloirs ») ; taille de police 20, qui tient de x = 204,0 à
243,7 unités de scène, avec marge de part et d'autre de la bordure qui commence à 248. Le mot
est le sujet de la carte, pas du décor : mesuré ci-dessous comme le marquage lui-même.

**Relevé de luminance** (Rec. 709 sur les PNG `@3x` livrés, `luminance.py`), coordonnées
en unités de scène (le pixel lu est 3× celles-ci) :

| zone | x, y | clair | sombre | écart clair | écart sombre |
|---|---|---:|---:|---:|---:|
| `double-sens` — trottoir (`sol`) | 60, 150 | 235,1 | 37,2 | 142,0 | 37,9 |
| `double-sens` — chaussée témoin | 170, 250 | 93,1 | 75,1 | — | — |
| `double-sens` — véhicule du candidat, caisse | 224, 182 | 128,6 | 128,6 | 35,5 | 53,5 |
| `double-sens` — véhicule d'en face (`p.autre`), caisse | 176, 118 | 180,0 | 196,6 | 86,9 | 121,5 |
| `double-sens` — axe médian, au plein | 200, 12 | 255,0 | 234,3 | 161,9 | 159,2 |
| `voie-bus` — mot « BUS », zone 40×40 : moyenne / max | 204, 130 | 127,3 / 255,0 | 108,7 / 234,3 | — / 161,9 | — / 159,2 |
| `voie-bus` — chaussée témoin (voie de bus, sous le mot) | 224, 230 | 93,1 | 75,1 | — | — |
| `voie-bus` — séparateur T3, au plein | 200, 15 | 255,0 | 234,3 | 161,9 | 159,2 |
| `voie-bus` — séparateur T3, au vide (= chaussée) | 200, 39 | 93,1 | 75,1 | — | — |
| `voie-bus` — véhicule du candidat, caisse | 176, 180 | 128,6 | 128,6 | 35,5 | 53,5 |
| `voie-bus` — chaussée témoin (voie générale) | 170, 250 | 93,1 | 75,1 | — | — |

Toutes les valeurs dépassent le plancher de 25 points, dans les deux modes — la plupart
très largement, puisque les deux scènes ne réutilisent que des teintes déjà établies
ailleurs dans le dossier (`sol`, `chaussee`, `marquage`, `vous`, `autre`) : chaque écart
retombe à la décimale sur une valeur déjà publiée pour ces teintes. Le mot « BUS » mesuré
en zone plutôt qu'en point (comme les zones hachurées du dossier) : le minimum de la zone
(93,1 / 75,1) est la chaussée nue entre les lettres, son maximum (255,0 / 234,3) une pleine
épaisseur de trait blanc — c'est ce maximum qu'il faut lire contre la chaussée témoin, pas
la moyenne, qui mélange les deux.

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
Le recadrage de `panneau-b6a1-stationnement-interdit` laisse un panonceau M8d (« 30 m »,
sens de la flèche) partiellement lisible en bas du cadre : aucune option de la banque ne
s'appuie sur cette distance (vérifié sur `1658abbc16db4667fec7211f8c9b0f93`,
`7d44f7dd303fce58716234cba54480b1` et `5abe2f7853853a6744f3a71425a0ba6e`).

**`panneau-b6a1-stationnement-interdit` et `panneau-b6d-arret-interdit` sont une exception de
structure, pas de cliché.** Le pictogramme (une oblique rouge pour le B6a1, deux barres en
croix pour le B6d) ne se sépare de son champ bleu que de 5,9 / 3,9 points en clair/sombre pour
le premier, 5,0 / 3,3 pour le second — très sous le plancher, sur la paire pictogramme contre
champ. Ce n'est pas la photo qui est en cause : le rouge et le bleu réglementaires du B6 ont
presque la même luminance Rec. 709, et toute photo fidèle la porte, comme un dessin qui
n'écarterait ces teintes qu'en trahissant les couleurs du panneau. Les deux teintes restent
distinctes pour la plupart des dyschromatopsies, et c'est l'`alt` qui porte le nombre de barres
pour qui n'accède pas à l'image (`1658abbc16db4667fec7211f8c9b0f93` pour le B6a1,
`1509ad94aea7c6f82355f3362b10a8e1` pour le B6d) — les photographies restent.

| asset | source | auteur | licence | relevé le | résolution d'origine |
|---|---|---|---|---|---|
| `panneau-giratoire-vue-conducteur` | [Commons — Panneau AB25 sur la D 183](https://commons.wikimedia.org/wiki/File:Panneau_AB25_sur_la_D_183.jpg) (2024-09-21) | Marc Mongenet | CC BY-SA 4.0 | 2026-08-23 | 5472 × 3648 |
| `ligne-jaune-continue` | [Commons — Marquage stationnement et arrêt interdits](https://commons.wikimedia.org/wiki/File:Marquage_stationnement_et_arr%C3%AAt_interdits_2013-11-17.JPG) (2013-11-17) | Tabl-trai | CC BY-SA 3.0 | 2026-08-23 | 2800 × 900 |
| `panneau-b21b-tout-droit` | [Commons — Les Pilles, panneau B21b](https://commons.wikimedia.org/wiki/File:Les_Pilles,_panneau_B21b.jpg) (2017-08-11) | Marc Mongenet | CC BY-SA 4.0 | 2026-09-22 | 4000 × 3000 |
| `panneau-b1-sens-interdit` | [Commons — Panneau B1 panonceau M9v1](https://commons.wikimedia.org/wiki/File:Panneau_B1_panonceau_M9v1.jpg) (2019-03-24) | Marc Mongenet | CC BY-SA 4.0 | 2026-09-22 | 3000 × 4000 |
| `panneau-b3-interdiction-depasser` | [Commons — A43 Panneau B3 panonceaux M4f M4x M1](https://commons.wikimedia.org/wiki/File:A43_Panneau_B3_panonceaux_M4f_M4x_M1.jpg) (2016-08-20) | Marc Mongenet | CC BY-SA 4.0 | 2026-09-22 | 2248 × 2248 |
| `panneau-b6a1-stationnement-interdit` | [Commons — Malagny Panneau B6a1 panonceau M8d bis](https://commons.wikimedia.org/wiki/File:Malagny_Panneau_B6a1_panonceau_M8d_bis.jpg) (2018-06-26) | Marc Mongenet | CC BY-SA 4.0 | 2026-09-22 | 4000 × 3000 |
| `panneau-b6d-arret-interdit` | [Commons — A75 Millau Panneau B6d](https://commons.wikimedia.org/wiki/File:A75_Millau_Panneau_B6d.jpg) (2019-08-10) | Marc Mongenet | CC BY-SA 4.0 | 2026-09-22 | 4000 × 3000 |
| `panneau-a1a-virage` | [Commons — Cranves-Sales panneau A1a](https://commons.wikimedia.org/wiki/File:Cranves-Sales_panneau_A1a.jpg) (2018-04-10) | Marc Mongenet | CC BY-SA 4.0 | 2026-09-22 | 4000 × 3000 |
| `panneau-a13b-passage-pietons` | [Commons — N85 panneau A13b à Quet-en-Beaumont](https://commons.wikimedia.org/wiki/File:N85_panneau_A13b_%C3%A0_Quet-en-Beaumont.jpg) (2017-09-27) | Marc Mongenet | CC BY-SA 4.0 | 2026-09-22 | 4000 × 3000 |
| `panneau-a14-panonceau` | [Commons — Panneau A14 M9z carrière](https://commons.wikimedia.org/wiki/File:Panneau_A14_M9z_carri%C3%A8re.jpg) (2016-08-27) | Marc Mongenet | CC BY-SA 4.0 | 2026-09-22 | 3000 × 2248 |
| `panneau-b31-fin-interdictions` | [Commons — D311 panneau B31](https://commons.wikimedia.org/wiki/File:D311_panneau_B31.jpg) (2019-08-03) | Marc Mongenet | CC BY-SA 4.0 | 2026-09-22 | 3808 × 2856 |
| `panneau-ab4-stop` | [Commons — Loisin panneau AB4](https://commons.wikimedia.org/wiki/File:Loisin_panneau_AB4.jpg) (2017-04-14) | Marc Mongenet | CC BY-SA 4.0 | 2026-09-22 | 4000 × 3000 |
| `panneau-ab7-fin-priorite` | [Commons — Annemasse AB7](https://commons.wikimedia.org/wiki/File:Annemasse_AB7.jpg) (2016-08-01) | Marc Mongenet | CC BY-SA 4.0 | 2026-09-22 | 3000 × 4000 |
| `panneau-c1a-parking` | [Commons — Panneau C1a Parking Auberge St Cyr Menthon 1](https://commons.wikimedia.org/wiki/File:Panneau_C1a_Parking_Auberge_St_Cyr_Menthon_1.jpg) (2019-09-21) | Chabe01 | CC BY-SA 4.0 | 2026-09-22 | 5184 × 3456 |
| `panneau-c113-voie-velo` | [Commons — D311 panneau C113](https://commons.wikimedia.org/wiki/File:D311_panneau_C113.jpg) (2019-08-03) | Marc Mongenet | CC BY-SA 4.0 | 2026-09-22 | 3384 × 2538 |
| `panneaux-ronds-bord-rouge` | [Commons — A51 tunnel d'Uriol, panneaux B3a B6d M2 C111 M9z B14 B17 M4m](https://commons.wikimedia.org/wiki/File:A51_tunnel_d%27Uriol_panneaux_B3a_B6d_M2_C111_M9z_B14_B17_M4m.jpg) (2017-08-05) | Marc Mongenet | CC BY-SA 4.0 | 2026-09-23 | 4000 × 3000 |
| `panonceaux-b1-thonon` | [Commons — Panneau B1 avec panonceaux M4w M4x M1 (01)](https://commons.wikimedia.org/wiki/File:Panneau_B1_avec_panonceaux_M4w_M4x_M1_01.jpg) (2022-04-15) | Marc Mongenet | CC BY-SA 4.0 | 2026-09-23 | 3000 × 4000 |
| `panneau-ab3a-cedez-le-passage` | [Commons — Panneau 1 AB3a RD183-907 Borly](https://commons.wikimedia.org/wiki/File:Panneau_1_AB3a_RD183-907_Borly.jpg) (2018-01-25) | Marc Mongenet | CC BY-SA 4.0 | 2026-09-23 | 4000 × 3000 |
| `panneau-ab6-route-prioritaire` | [Commons — Panneau AB6 Route Mâcon St Cyr Menthon 1](https://commons.wikimedia.org/wiki/File:Panneau_AB6_Route_M%C3%A2con_St_Cyr_Menthon_1.jpg) (2019-09-29) | Chabe01 | CC BY-SA 4.0 | 2026-09-23 | 5184 × 3456 |
| `panonceau-m12-cyclistes` | [Commons — Feux tricolores Avenue Pépinière Fontenay Bois 1](https://commons.wikimedia.org/wiki/File:Feux_tricolores_Avenue_P%C3%A9pini%C3%A8re_Fontenay_Bois_1.jpg) (2019-11-09) | Chabe01 | CC BY-SA 4.0 | 2026-09-23 | 3024 × 4032 |
| `panneau-b14-limitation` | [Commons — Panneau B14 70 à Arenthon](https://commons.wikimedia.org/wiki/File:Panneau_B14_70_%C3%A0_Arenthon.jpg) (2019-09-28) | Marc Mongenet | CC BY-SA 4.0 | 2026-09-23 | 4000 × 3000 |
| `panneau-b33-fin-limitation` | [Commons — Panneau B33 70 D903 Scientrier](https://commons.wikimedia.org/wiki/File:Panneau_B33_70_D903_Scientrier.jpg) (2019-09-28) | Marc Mongenet | CC BY-SA 4.0 | 2026-09-23 | 4000 × 3000 |
| `panneau-b30-zone-30` | [Commons — Zone 30 près gare Moulins](https://commons.wikimedia.org/wiki/File:Zone_30_pr%C3%A8s_gare_Moulins_2015-08-26.JPG) (2015-08-26) | Tabl-trai | CC BY-SA 3.0 | 2026-09-23 | 2816 × 2112 |
| `panneau-c111-tunnel` | [Commons — Extrémité Ouest Tunnel des Sorderettes en Maurienne](https://commons.wikimedia.org/wiki/File:Extr%C3%A9mit%C3%A9_Ouest_Tunnel_des_Sorderettes_en_Maurienne_%28mai_2025%29.JPG) (mai 2025) | Florian Pépellin | CC BY-SA 4.0 | 2026-09-24 | 3108 × 2360 |
| `panonceau-tunnel-longueur` | [Commons — Autoroute A43, La Maurienne, IMG 5854](https://commons.wikimedia.org/wiki/File:Autoroute_A43_-_La_Maurienne_-_2012-07-16_-_IMG_5854.jpg) (2012-07-16) | Poudou99 | CC BY 3.0 | 2026-09-24 | 5184 × 3456 |

**Sept photographies ont un bord qui échoue au plancher de luminance, sans que la carte en
dépende : B1, B31, AB4, A13b, AB6, B33, B30.** Au pire point de leur pourtour, c'est le listel
qui se confond avec le fond qui le touche — B1 contre la tôle du support et le ciel entre les
branches (14 points de son pourtour sous 25 en sombre) ; B31 contre la roche ensoleillée et
l'herbe sèche (16) ; AB4 contre le ciel des deux flancs (18) ; A13b contre le mur blanchi d'une
ferme (8) ; AB6 contre le ciel sur l'arête de tôle (74) et contre une clôture ou des bâtiments
sur la bordure noire (3) ; B33 contre le ciel et le feuillage au soleil (33) ; B30 contre le
ciel, en bas et en haut à droite (3). Dans chaque cas le pictogramme contre son champ passe
largement (de 47,9 / 29,6 pour l'AB6 à 178,9 / 111,7 pour le B31, clair/sombre) : c'est lui,
jamais le listel, qui porte la réponse de la carte — ce sont des exceptions de cadrage, la
carte ne dépend pas du bord.

Le lot des quatre panneaux de danger et de fin (A1a, A13b, A14, B31, tâche 3A-2) vient lui
aussi de Marc Mongenet, sans qu'aucun repli n'ait été nécessaire. Aucune de ces quatre
sources n'a le piège d'orientation EXIF du B1 (les quatre sont en orientation 1, pixels
bruts déjà à l'endroit). Pour l'A14, le fichier retenu porte lui-même le panonceau M9z
« CARRIÈRE » — le même mot que la scène dessinée qu'il remplace, sans que ç'ait été un
critère de choix : c'était le meilleur candidat de la catégorie Commons de toute façon.

Le dernier lot (AB4, AB7, C1a, C113, tâche 3A-3) referme le domaine : les quatre derniers
panneaux dessinés en CoreGraphics passent en photographie, si bien que tous les panneaux
isolés de `Panneaux & marquage` le sont désormais — ses marquages au sol, eux, restent
dessinés (voir « Schémas dessinés » plus haut). `panneau-ab7-fin-priorite` vient d'une
source en orientation EXIF 8 (comme le B1) : le fichier brut, un paysage 4000×3000, a
d'abord été réécrit bit à bit avec `PIL.ImageOps.exif_transpose` avant tout centre de
recadrage.
`panneau-c1a-parking` est le premier asset de ce fichier à ne pas venir de Marc Mongenet :
Chabe01, un contributeur différent, mais la même licence CC BY-SA 4.0. Lui seul a demandé un
recadrage plus large que le plancher de `photo-panneau.py`, la source étant un cliché pris de
très près — voir le rapport de tâche 3A-3 pour le recadrage retenu.

`panneau-ab7-fin-priorite` est une exception mesurée, pas un oubli, et un balayage dense
(méthode v3, 113 points) la montre plus étendue que l'ancien relevé ponctuel ne le disait.
L'arête de tôle échoue sur 55 des 113 points, contre le ciel et la forêt, avec un pire point
à **−2,3 clair / 0,5 sombre** — le relevé d'origine, pris à un seul sommet (le droit,
contre un talus broussailleux en plein soleil), ne disait que 14,7 clair / 9,1 sombre. La
bordure noire échoue séparément sur 18 points, contre une forêt sombre en bas à gauche et en
haut à droite (−0,3 clair / −0,1 sombre à son pire) — un défaut jamais publié avant ce
balayage. Le pictogramme, lui, passe largement (29,8 à 69,5 en sombre). Cinq sources
Commons de repli ont été essayées (Douvaine, Brugheas, Bernin ×2, Marcigny) et chacune portait
un défaut au moins aussi grave — panonceau collé, balise de chantier, mât à cinq panneaux,
prise de vue en contre-plongée — donc celle-ci est restée, en connaissance de cause (rapport
de tâche 3A-3).

`panneau-c113-voie-velo` reste au plancher de `photo-panneau.py` et n'occupe qu'environ 16 %
de la largeur du bandeau, là où le reste du dossier avoisine la moitié : c'est la taille du
panneau dans la seule photo qui passe le double écart, pas un choix de cadrage. Deux sources
cadrées plus près ont été essayées et écartées, chiffres à l'appui — Arcachon (34 % du cadre)
oppose le listel à un ciel laiteux qui tombe à 24,5 clair / 15,2 sombre, sous le plancher des
deux côtés ; Bellerive (25 %) oppose le listel (195,2) à un mur crépi clair qui le dépasse
(211,1), un écart négatif. Un panneau plus grand mais illisible en niveaux de gris n'aurait
rien réglé (rapport de tâche 3A-3).

Ces vingt-cinq passeraient une diffusion telles quelles : CC BY-SA (ou CC BY) demande
l'attribution (ce tableau la porte) et le partage à l'identique des seules œuvres dérivées
de l'image.
Un recadrage en est une — donc si l'app est un jour distribuée, l'attribution devra
apparaître dans l'app, pas seulement ici.

Le lot suivant (AB3a, AB6, un second AB7, M12, tâche 4A) ouvre le second domaine,
`Priorités & intersections`. Il ne pose aucune carte lui-même : les quatre imagesets sont
neufs, préparés pour la tâche 4C, qui a depuis réécrit les cartes correspondantes.

`panneau-ab3a-cedez-le-passage` vient de Borly (RD183-907, Marc Mongenet) : le triangle
s'y détache sur des conifères sombres plutôt que sur le ciel, ce qui donne un écart large sur
presque tout le pourtour (listel contre feuillage ≥ 75 en clair des deux côtés, ≥ 90 en
sombre) — sauf en un point du sommet haut, où une pièce métallique nette (un collier de
fixation sur le poteau, contre le listel, visible à l'écran et non un défaut de mesure) fait
chuter l'écart à environ 32 en clair, soit ≈ 20 en sombre : sous le plancher, comme le sommet
droit de `panneau-ab7-fin-priorite` plus haut. La cause diffère de celle de l'AB7 — ici une
pièce de fixation claire touche le listel, pas un fond naturel éclairci — mais la conclusion
est la même : gardé en connaissance de cause, un point sur tout le pourtour, pas une arête
entière. Un premier candidat (Chemin Romagne, St Cyr
Menthon) a été écarté : son triangle est propre mais posé devant un ciel clair sans aucun
relief, listel contre ciel n'y dépasse pas quelques points d'écart (essai non conservé). Le
pictogramme n'existe pas sur une AB3a ; la paire mesurée à sa place est la bordure rouge
contre le champ blanc intérieur, large (146 clair / 90 sombre).

`panneau-ab6-route-prioritaire` vient de la Route de Mâcon à St Cyr Menthon (Chabe01, même
site que `panneau-c1a-parking`) : champ contre le losange jaune, 50 clair / 31 sombre —
confortable, et c'est cette paire qui porte la réponse. Le listel contre le ciel est l'une
des sept exceptions de cadrage relevées plus haut : à son pire point, l'arête de tôle tombe
à 0,1 clair / 0,1 sombre, et 74 des 113 points balayés autour d'elle échouent sous 25 en
sombre ; la bordure noire échoue séparément à trois points, contre une clôture ou des
bâtiments en bas.

Le second AB7 demandé (« un autre exemplaire » que `panneau-ab7-fin-priorite`, pour ne pas
faire servir un même cliché à deux cartes) n'a pas été créé. Cinq candidats supplémentaires
ont été essayés en plus des cinq déjà écartés par la tâche 3A-3 : `Panneaux AB5 AB7 Rue
Chenale Marcigny 4.jpg` (isolé, de face, mais son pictogramme jaune ne se détache du champ
blanc qu'à 31 points en clair, 19 en sombre — sous le plancher, et pas un point isolé, le
défaut porte sur les deux blocs jaunes) ; `Fin de route prioritaire (Brugheas)` recadré au
plus près du plancher (1152 px) montre inévitablement les balises de chantier et le
panonceau rayé déjà écartés par la tâche 3A-3 ; `D269 Menthon-St-Bernard.jpg` ne montre en
réalité aucun AB7 (juste une borne et une plaque directionnelle D269, faux positif de
catégorie) ; `D1075`/`D1085 (Isère)` sont des scènes à plusieurs panneaux (E43, EB10, J11,
M1, J13, D42b, SU2), non isolées, et sous le plancher en résolution ; `Loupes panneau -
2015a.jpg` porte l'AB7 juste au-dessus de deux plaques de lieu-dit collées sans espace, comme
le mât de Bernin déjà écarté. Aucun candidat restant dans la catégorie Commons `AB7 (road
sign, France)` (~75 fichiers, majoritairement des panneaux d'agglomération sans rapport,
faux positifs de catégorie). Cette carte reste donc en texte.

`panonceau-m12-cyclistes` vient de l'avenue Pépinière à Fontenay-sous-Bois (Chabe01).
**Elle montre le panonceau monté au-dessus du feu, pas en dessous** — le montage le moins
courant : l'agencement ordinaire, vu à Massy et avenue Maréchal Joffre (même photographe),
pose le panonceau sous le feu. Gardée quand même, faute de mieux : les deux candidats à
l'agencement correct ont chacun un listel qui ne se détache pas de son fond, sur un flanc
entier et pas un point isolé (chiffres ci-dessous) — pire que celui-ci, pas meilleur.

Deux paires d'écart sont mesurées, sur l'image livrée (`clair@3x.jpg`, 1152 × 864, et
`sombre@3x.jpg` qui en dérive) :

- **Listel contre le fond qui le touche**, balayé sur tout le pourtour (101 points, méthode
  v3) : **42 d'entre eux tombent sous 25 en sombre**, sur les deux flancs, pas un seul. Le
  relevé ponctuel d'origine disait le flanc **gauche** confortable contre un ciel bleu franc
  (219,5 listel contre 152,7 ciel, écart 66,8 clair / 41,4 sombre) ; le balayage dense y
  trouve pourtant son pire point de tout le pourtour, là où le listel se confond avec le ciel
  et tombe même en dessous : écart **−1,3 clair / −1,0 sombre**. Côté droit, à contre-jour,
  contre des feuillages d'automne dépareillés (soleil et ombre mêlés) et le mât gris du
  support : le listel lui-même s'assombrit sur ce flanc, à 124–163 selon le point, là où il
  lit 200–220 ailleurs sur le même panneau ; comparé au fond qui le touche à cet endroit,
  l'écart tombe à un point mesuré à **16 en sombre** — sous le plancher de 25 lui aussi, mais
  plus le pire des deux flancs depuis ce balayage.
- **Pictogramme (vélo + flèche, jaune) contre le champ blanc.** Mesuré directement sur
  `sombre@3x.jpg` : les roues du vélo à 115–116, le champ blanc à 138 (zone propre à
  660,140), soit un écart de **36,6 clair / 22,7 sombre** — **sous le plancher**, mais ce
  n'est **pas un défaut photographique** : le jaune et le blanc d'un M12 sont fixés par la
  réglementation, et leurs luminances Rec. 709 sont structurellement proches quelle que soit
  la photo (ou même un dessin fidèle). **C'est une exception structurelle du panneau, pas de
  ce cliché** : le M12 se reconnaît à sa forme (petit triangle pointe en bas, bord rouge) et
  à sa position (sous — ou ici, au-dessus de — un feu), et son `alt` porte le pictogramme
  pour qui n'accède pas à l'image. Aucun panonceau M12, photographié ou dessiné, ne passerait
  ce plancher sur cette paire.

**Deux candidats à l'agencement correct, réévalués sur le seul listel** (la paire pictogramme
étant exemptée pour la raison structurelle ci-dessus, elle ne départage pas les candidats) :

- `Feux Tricolores & Panonceau M12f Avenue Nationale - Massy` (Chabe01, CC BY-SA 4.0,
  panonceau sous le feu bas) : listel métallique gris contre le bitume flou du fond, balayé
  systématiquement sur les deux flancs (une centaine de lignes, zones de 8 à 12 px). Le pire
  point mesuré donne un listel **plus sombre que le fond** (listel 134,4 contre fond 149,6,
  soit un écart négatif) ; le meilleur point du balayage plafonne à 31,2 clair / 19,3 sombre.
  Sur l'ensemble des deux flancs, aucun point ne dépasse 25 en sombre. Net échec, pas gardé —
  généré une fois pour mesure (`eval-m12-massy`), non conservé.
- `Panonceau M12 Avenue Maréchal Joffre - Fontenay-sous-Bois (FR94) - 2020-09-08 - 1.jpg`
  (Chabe01, CC BY-SA 4.0, feu bas rouge allumé, panonceau au-dessus — donc pas davantage
  « sous son feu » que le candidat retenu, contrairement à une première lecture) : listel
  contre un mât de béton à la texture inégale (traînées claires et sombres). Balayé de la
  même façon : le flanc droit (contre une façade en pierre claire, ensoleillée) reste
  quasiment nul à négatif sur toute sa hauteur mesurée (-14,3 à +1,6 clair selon le point) ;
  le flanc gauche alterne des points proches de zéro et une plage à +60/+70 clair (38-44
  sombre) selon la texture du béton à cet endroit précis — trop instable pour qualifier
  « un point isolé ». Ni meilleur ni pire que Massy dans l'ensemble, pas gardé — généré une
  fois pour mesure (`eval-m12-joffre`), non conservé.

Les trois partagent le même trait : le listel d'un panonceau M12 est un cadre métallique mat,
pas la sheeting rétroréfléchissante très blanche des panneaux de forme, donc son écart au
fond ne bénéficie jamais de la marge large observée sur AB4, AB6 ou C1a — et le fond lui-même
(rue, mât, feuillage) est plus proche en luminance d'un tel listel qu'un ciel ou un champ
agricole ne le serait.

### Les cartes de famille : un mât qui en porte plusieurs

« Un panneau rond à bord rouge indique : » ne s'illustre pas avec un seul panneau : la règle
du [§7](questions.md#7-les-questions-illustrées) exige trois instances de la famille côte à
côte, faute de quoi la carte enseignerait l'exemplaire plutôt que la famille. Six familles ont
été cherchées ; deux ont trouvé leur photographie, les quatre autres restent en texte.

**`panneaux-ronds-bord-rouge`** vient de l'entrée du tunnel d'Uriol (A51, Isère) : sur un même
site, un panneau à 200 m, une limitation à 70, une limitation à 110, une interdiction de
dépasser pour les poids lourds et un arrêt-et-stationnement-interdit (disque **bleu**, pas
blanc) — cinq disques cerclés de rouge, cinq pictogrammes différents, la dernière démontrant que
le liseré décide, pas la couleur du centre. Le panneau bleu carré « Tunnel d'Uriol » et son
panonceau de distance, plantés entre les postes, restent dans le cadre : ils ne sont d'aucune
famille de ce lot, leur forme carrée les distingue sans ambiguïté, et les exclure aurait
demandé un recadrage impossible (les trois postes ne s'alignent pas à la même hauteur).

**Trois des cinq (`70`, l'interdiction poids lourds, l'arrêt-interdit) sont en réalité des
exceptions de cadrage**, et non les valeurs confortables publiées jusqu'ici : au pire point
de leur pourtour, contre le feuillage qui les touche, l'écart tombe à **7,8 clair / 5,3
sombre** pour le `70` (17 des 84 points balayés sous 25 en sombre), **10,1 / 7,7** pour
l'interdiction poids lourds (19 des 99), **13,4 / 6,5** pour l'arrêt-interdit (7 des 90). Ce
que la famille garde malgré tout, vérifié directement sur l'image livrée : le liseré rouge
reste net contre son propre listel blanc, indépendamment du décor. Sa médiane (32 à 38 en
clair, 20 à 23 en sombre selon le disque) se détache de celle du listel blanc qui le borde
(156 à 164 en clair, 95 à 101 en sombre) par 75 à 126 points selon le disque et le mode,
largement au-dessus du plancher — c'est ce contraste-là, interne au disque, qui porte encore
le trait de famille que la carte interroge, pas le disque contre son décor. L'arrêt-interdit
n'a qu'un listel fin pour cela : son champ bleu ne se sépare de la croix rouge que faiblement
(17,4 clair / 11,1 sombre), la même exception structurelle que sur B6a1 et B6d plus haut. Le
disque `110`, plus proche de la roche du tunnel et donc à
l'ombre, ne passe pas ce plancher sur une partie de son pourtour — au pire point, le listel
y est même plus sombre que la roche qui le touche (−0,5 en clair, −0,9 en sombre) : il
reste dans le cadre à titre de contexte, mais la carte ne s'appuie pas sur lui — c'est un
défaut connu, comme celui de `panneau-ab7-fin-priorite` plus haut, gardé après comparaison
plutôt que caché.

**`panonceaux-b1-thonon`** montre un B1 (chemin du Genevray, Thonon-les-Bains) portant trois
panonceaux empilés — une remorque, un attelage voiture-caravane, une distance « 800m » — contre
une haie de thuyas. Trois photographies du même mât ont été comparées (deux cadrages serrés sur
le seul B1, un troisième montrant aussi un poteau voisin à deux disques rouges) ; la retenue est
celle où les trois panonceaux sont les plus nets et où le B1 recadré laisse le moins de ciel
autour du panonceau du haut, qui reste le point faible : son bord touche un ciel clair sur environ
la moitié de sa hauteur, sous le plancher de 25 dans les deux modes au pire point (1,2 en clair,
0,9 en sombre), quand les deux panonceaux du bas, contre la haie, dépassent tous deux 45 dans les
deux modes. Le cadre métallique
de chaque panonceau, visible en gris, reste un repère de forme indépendant de la teinte.

**Les quatre familles restées en texte, et ce qui a été cherché** : le disque bleu sans liseré
rouge (obligation) et le triangle à bande rouge (danger) n'apparaissent jamais groupés par trois
dans les 2 500 clichés de signalisation de Marc Mongenet passés en revue (recherche par motif de
nom de fichier, deux codes ou plus de la même famille) — la France ne semble pas empiler ces
familles-là comme elle empile les discs d'interdiction ou les panonceaux. Le carré d'indication en
a trouvé deux candidats (`C12`+`C24a`, `C62`+`C64d`), mais jamais trois. Le fond jaune temporaire
n'a trouvé que des paires de codes `AK` sur des mâts de chantier différents, jamais trois panneaux
jaunes groupés sur un seul poste. Aucune des quatre n'a donc été forcée.

### Les trois derniers panneaux dessinés : la vitesse

`panneau-b14-limitation`, `panneau-b33-fin-limitation` et `panneau-b30-zone-30` referment
la liste des panneaux **isolés** dessinés en CoreGraphics : les scènes qui restent sous
`Tools/Scenes/` composent toutes un carrefour, un giratoire ou un marquage, jamais un
panneau seul.

**`panneau-b14-limitation`** vient de [Commons — Panneau B14 70 à Arenthon](https://commons.wikimedia.org/wiki/File:Panneau_B14_70_%C3%A0_Arenthon.jpg)
(Marc Mongenet, CC BY-SA 4.0, 2019-09-28, 4000 × 3000) : disque seul sur son poteau,
contre un ciel nuageux et une lisière boisée en contrebas. Un premier essai sur
`Panneau B14 70 D903 Scientrier.jpg` (même auteur, même route, même jour) — disque isolé
contre une haie de conifères — a été mesuré puis écarté : le rouge du liseré (L ≈ 30 en
clair, un rouge nettement plus sombre que sur l'Arenthon retenu) tombe trop près de la
luminance de plusieurs poches d'ombre du feuillage tout autour du disque — huit points sur
vingt-quatre échantillonnés à 15° d'intervalle sous 25 points d'écart (jusqu'à 1,4 point à
330°, en zones 20×20) — un défaut réparti sur une bonne moitié du pourtour, pas un point
isolé. Sur l'Arenthon retenu, listel contre ciel (zones 20×20) : 30,0 clair / 18,1 sombre
contre 244,8 / 151,0 à gauche, 29,4 / 18,0 contre 222,5 / 137,7 à droite — un écart énorme
des deux côtés. Champ contre pictogramme : 138,6 / 85,3 contre 13,1 / 7,9.

**`panneau-b33-fin-limitation`** vient de [Commons — Panneau B33 70 D903 Scientrier](https://commons.wikimedia.org/wiki/File:Panneau_B33_70_D903_Scientrier.jpg)
(Marc Mongenet, CC BY-SA 4.0, 2019-09-28, 4000 × 3000) — la même route que le B14 écarté
ci-dessus, douze minutes plus tard sur l'appareil, mais ce disque-ci n'a pas de liseré
rouge (fond blanc, filet et oblique noirs, 4e partie art. 47) : cadré contre des branches,
un pan de ciel et des bottes de foin, il n'a pas le défaut du B14 du même site. Champ
contre pictogramme (zones 20×20) : 220,1 clair / 136,0 sombre contre 55,8 / 33,9. Champ
contre le fond qui le touche, aux quatre points relevés : feuillage à gauche (131,9 / 81,6,
écart 88,2 / 54,4), collines embrumées à droite (113,4 / 69,9, écart 106,7 / 66,1), branche
en haut (157,6 / 97,1, écart 65,4 / 40,6 — une branche sèche qui laisse filtrer un peu de
ciel), bottes de foin en bas (47,6 / 29,0, écart 154,0 / 95,6) — ces quatre-là passent le
plancher de 25, dans les deux modes. Un balayage dense (méthode v3) en trouve un
cinquième, que ces quatre points manquaient : contre le ciel à droite et le feuillage au
soleil, l'arête claire extérieure du listel (3 à 4 px) est de la teinte même du fond
(2,4 clair / −1,7 sombre à son pire), et 33 des 113 points balayés tombent sous 25 en
sombre. Une exception de cadrage de plus : le champ contre le pictogramme reste large
(220,1 clair / 136,0 sombre contre 55,8 / 33,9) et porte seul la réponse.

**`panneau-b30-zone-30`** vient de [Commons — Zone 30 près gare Moulins](https://commons.wikimedia.org/wiki/File:Zone_30_pr%C3%A8s_gare_Moulins_2015-08-26.JPG)
(Tabl-trai, CC BY-SA 3.0, 2015-08-26, 2816 × 2112) : le panneau, seul sur son poteau, sans
aucun panonceau, contre un ciel bleu et un arbre — un magasin flouté tout en bas du cadre
n'est pas assez nette pour se lire. **Il est bien rectangulaire** — le défaut du dessin
carré, noté plus haut, est levé.

Deux candidats antérieurs ont été écartés, pour deux raisons différentes.

`Panneau zone 30 St-Lys.jpg` (Kuremu Sakura, CC BY-SA 4.0, 2019-10-28, 3000 × 4000), plus
grand dans le cadre et tout aussi net, a été écarté après mesure de luminance : son rouge,
plus terne (un panneau visiblement plus ancien, fond craquelé), tombe sous 25 points
d'écart contre son fond sur la moitié basse du bord gauche (herbe, jusqu'à −15 à −28 selon
le point), sur une bande du bord droit (grillage, 27 à 43), et au-dessus comme en dessous
(le panneau municipal collé au-dessus, l'herbe en dessous, 13 à 20) — un défaut sur les
quatre côtés, dans les deux modes.

`Avenue de Thiers (Abrest), entrée de zone 30, direction Vichy 2024-08-11.JPG` (Tabl-trai,
CC BY-SA 4.0 / GFDL 1.2+, 2976 × 1984), retenu puis retiré en revue : la photographie
montrait bien un B30 rectangulaire, net, avec de bonnes marges de luminance (champ contre
pictogramme 216,1 / 33,8 clair ; listel contre un point propre du grain de son poteau en
bois, écart 63,6 / 41,0), mais son panonceau « PRIORITÉ PIÉTONS » restait dans le cadre,
lisible dans les deux modes, directement sous le panneau — **et ce texte est la
distractrice B de cette carte** (« une aire piétonne où le piéton reste prioritaire »), au
mot près l'inverse de ce que `cac0f9db162887802d4fb15ba97d768f` enseigne sur la même notion
(la zone 30 ne donne **pas** la priorité au piéton — c'est justement ce qui la distingue
d'une zone de rencontre). Un décor n'est exempt que si aucune option ne s'appuie dessus ; un
panonceau est du texte, jamais neutre par défaut. Un recadrage excluant le panonceau a été
essayé et abandonné : sur la source, le bord bas du panneau et le haut du panonceau ne sont
séparés que de 6 à 10 px (montage sans jeu), et le premier pixel net de texte
(« PRIORITÉ ») commence à peu près là où finit le liseré rouge — couper là aurait rogné le
panneau lui-même, pas seulement le panonceau. Aucun fichier de ce candidat n'a été commité ;
il a été retiré avant la clôture de la tâche 6A.

Sur le Moulins retenu, listel contre ciel : 81,8 / 55,1 clair/sombre contre 154,5 / 95,3 à
gauche (écart 72,7 / 40,2), 82,4 / 55,0 contre 152,5 / 93,8 à droite (écart 70,1 / 38,8),
93,1 / 54,7 contre 136,5 / 83,9 en haut (écart 43,4 / 29,2 — le point le plus faible, encore
1,17× le plancher en sombre). Champ contre pictogramme : 242,6 / 149,8 contre 73,0 / 44,9
en moyenne (écart 169,6 / 104,9). Un arbre touche presque l'angle bas-gauche arrondi du
panneau mais ne le touche pas (vérifié à l'œil) ; le bas du panneau donne sur son propre
poteau et sa ferrure de fixation, jamais mesurés comme un fond dans ce dossier — ni ici.
Un balayage dense (méthode v3) trouve pourtant un point que ces relevés ne portaient pas :
la bande rouge, en bas du cadre et au coin haut droit, se détache du ciel qui la touche par
seulement **−28,9 clair / −17,4 sombre** à son pire — plus sombre que ce ciel, pas plus
claire —, sur 3 des 115 points balayés. Une exception de cadrage de plus : le champ contre
le pictogramme (242,6 / 149,8 contre 73,0 / 44,9) porte seul la réponse.

### Le C111 et son panonceau de longueur

Les deux premières photographies de `Tunnels & passages à niveau` : le C111 seul et le même
panneau accompagné de son panonceau de longueur. Aucune scène dessinée ne portait de C111
avant ce lot — `grep -rn tunnel Tools/Scenes/` ne trouve que `tunnel-arret-urgence`, qui
n'est pas un panneau et ne bouge pas.

**`panneau-c111-tunnel`** vient de l'extrémité ouest du tunnel des Sorderettes, en Maurienne
(Florian Pépellin, CC BY-SA 4.0, mai 2025). Le cadre retenu porte, en plus du C111, la plaque
nommant l'ouvrage au-dessus et son panonceau de longueur (« 372 m ») en dessous, puis, plus bas
et à l'écart du mât, une borne orange d'appel d'urgence (repère « 181 », pictogramme
combiné téléphonique et « S.O.S. ») — aucun panneau de prescription (vitesse, hauteur,
interdiction) ne figure dans le cadre, et aucune option de la carte (changement de voie,
dépassement, demi-tour, remorque attelée) ni d'aucune carte de la notion `tunnel/conduite`
ne porte sur un nom de tunnel, une longueur ou un numéro d'appel : la plaque, le panonceau et
la borne y sont un décor neutre, gardé faute de mieux. Relevé au pire point trouvé le long de
son propre contour, la borne contre le feuillage qui la touche : 219,8 clair / 136,7 sombre
contre 155,5 clair / 97,1 sombre à la tache la plus claire du feuillage voisin, soit un écart
de 64,3 clair / 39,6 sombre — **au-dessus** du plancher de 25 dans les deux modes, donc pas de
chiffre sous 25 à consigner pour cet objet-là. **Aucun poteau isolé, ne portant que le seul C111, n'a
passé le double écart** : `Entrée Est Tunnel Bois Clair Berzé Châtel 1.jpg` et `…2.jpg`
(Chabe01, CC BY-SA 4.0) opposent le listel à un talus mêlant feuillage ensoleillé et paroi
claire — l'écart tombe à 3,5 clair / 2,4 sombre à un endroit de la bordure gauche et devient
**négatif** (-15,8 clair / -9,9 sombre) à un autre, la roche claire y dépassant le listel.
Aucun recadrage ne change ce que le poteau touche réellement ; élargir le cadre ne fait que
montrer plus de la même paroi. Relevés sur le cliché retenu, aux pires points trouvés le long
de la silhouette (Rec. 709, `luminance.py`) :

| zone | clair | sombre | écart clair | écart sombre |
|---|---:|---:|---:|---:|
| listel (arche, bord gauche) contre végétation | 168,6 / 104,9 | 104,0 / 64,5 | 63,7 | 39,5 |
| listel (arche, bord droit) contre végétation | 233 / 153 | 144 / 87 | 80 | 57 |
| plaque de nom, bord haut, contre végétation | 224 / ≤107 | — | ≥117 | — |
| pictogramme contre champ | 225,3 / 95,4 | 139,3 / 59,0 | 129,9 | 80,3 |

**`panonceau-tunnel-longueur`** vient du tunnel « Les Hurtières », sur l'A43 en Maurienne
(Poudou99, CC BY 3.0, 2012-07-16 — premier asset de ce fichier qui ne vient ni de Marc
Mongenet, ni de Chabe01, ni de Florian Pépellin). **Un cliché distinct** de celui du C111
ci-dessus : un autre tunnel, un autre photographe. Le panonceau M2 (IISR 5e partie, art. 75-2,
1 : « Il est complété par un panonceau M2 indiquant la longueur de l'ouvrage », voir
`Tools/sources.md` ligne `3a06288b`) porte « 1 183 m », lisible dans les deux modes ; aucun
panneau de hauteur ni de vitesse n'entre dans le cadre — les deux distracteurs B et C de la
carte. Là non plus aucun poteau isolé ne s'est trouvé : la plaque nommant le tunnel reste
donc dans le cadre, décor neutre pour les mêmes raisons que ci-dessus.

| zone | clair | sombre | écart clair | écart sombre |
|---|---:|---:|---:|---:|
| listel (arche, bord gauche) contre végétation | 185,6 / 91,6 | 114,8 / 56,4 | 94,0 | 58,4 |
| listel (arche, bord droit) contre végétation | 184,4 / 67,9 | 113,8 / 41,3 | 116,5 | 72,5 |
| listel (panonceau de longueur, bord gauche) contre végétation | 186,6 / 127,0 | 115,2 / 78,1 | 59,6 | 37,1 |
| pictogramme contre champ | 176,6 / 85,4 | 109,3 / 52,8 | 91,2 | 56,5 |

Les deux images demandent l'attribution CC BY-SA / CC BY (ce tableau la porte) ; un recadrage
est une œuvre dérivée, donc le partage à l'identique s'appliquerait à une diffusion de l'app.

## Ajouter une image

1. Schéma : ajouter la scène dans `Tools/Scenes/`, relancer `./Tools/render-scenes.sh`.
   Photo : `uv run --with pillow Tools/photo-panneau.py <source> <asset> --centre X,Y
   --largeur W`, qui recadre en 4:3, sort @2x/@3x et dérive la variante sombre.
2. Ajouter la ligne ici — asset, source, auteur, licence, date de relevé, résolution
   d'origine.
3. Poser l'`illustration` sur la question dans `questions.json` (`asset` + `alt`).
4. `python3 Tools/audit.py`, puis les tests.
