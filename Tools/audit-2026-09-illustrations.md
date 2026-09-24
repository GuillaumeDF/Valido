# Illustrations, gloses et raisons — rapport de passe, septembre 2026

Cinquième intervention sur le contenu, après les passes 2 et 3
([`audit-2026-08-passe-2.md`](audit-2026-08-passe-2.md),
[`audit-2026-08-passe-3.md`](audit-2026-08-passe-3.md)) et le diagnostic de forme
([`audit-2026-09-formes.md`](audit-2026-09-formes.md)). Celle-ci corrige : elle est née de
treize captures d'usage et a porté, domaine par domaine, quatre corrections — l'énoncé qui
décrivait ce qu'une image devait montrer, la configuration laissée en texte, les gloses à
côté de la plaque, les bonnes réponses sans leur raison.

Spec : [`docs/superpowers/specs/2026-09-22-illustrations-gloses-raisons-design.md`](../docs/superpowers/specs/2026-09-22-illustrations-gloses-raisons-design.md).
Branche `contenu/illustrations-gloses-raisons`, de `a04fa25` (`main`) à ce rapport. Aucun
`id` n'a changé : `lesIdentifiantsLivrésSontStables()` passe, empreinte de la tâche 1.

Ce rapport est écrit contre les sources, pas contre les rapports de tâche : chaque chiffre
ci-dessous a été recompté sur `main` (worktree temporaire) ou sur l'arbre livré, avec la
commande donnée. Là où un rapport de tâche ou `images.md` dit autre chose, c'est écrit.

## 1. Les compteurs, avant et après

`python3 Tools/audit.py | grep -E "^### "`, sur `main` (`a04fa25`) puis sur l'arbre livré :

| compteur | `main` | livré | nature |
|---|---:|---:|---|
| `lettre/reference` | 1 | 1 | faux positif connu |
| `forme/definitionnel` | 98 | 98 | informatif |
| `forme/hors-situation` | 216 | **189** | informatif |
| `forme/impersonnel` | 215 | **216** | informatif |
| `forme/markdown` | 1 | 1 | faux positif connu |
| `forme/seule-ponctuee` | 14 | 14 | informatif |
| `longueur/plus-longue` | 76 | 76 | informatif |
| `expl/paraphrase-litterale` | 20 | 20 | informatif, ne se minimise pas |

Absents de la sortie, comme exigé : `schema/`, `couverture/`, `source/`, `fuite/`, `image/`
(dont les quatre contrôles nés de cette passe : `image/variante-sombre-absente`,
`image/echelle-manquante`, `image/licence-absente`, `image/enonce-decrit-l-objet`),
`longueur/plus-10`, `forme/backtick-isole`, `notions/non-declaree`,
`notions/sans-fondation`, `notions/carte-orpheline`.

**`forme/hors-situation` 216 → 189 : vingt-sept sorties, zéro entrée.** Le compteur ne porte
que sur les cartes sans illustration (`audit.py:171`). Les vingt-sept cartes qui ont gagné
une image en sortent toutes, et aucune n'était déjà déictique avant la passe — donc chacune
comptait. Aucune carte restée en texte n'y est entrée. Les vingt-sept, par domaine :
Panneaux & marquage 6 (`37fe…81059d80`, `…8141b1d0`, `…81f8a2f3`, `5a4e6a38`, `5abe2f78`,
`5f7e9145`), Priorités & intersections 9 (`…815f8684`, `…8161be32`, `…81d6aef7`,
`…81fa9deb`, `e0f68dd1`, `b433eefe`, `09f18973`, `02f7d6a6`, `2daf8939`), Feux 3
(`…81fc9bbb`, `0ac1e53a`, `fc0333a5`), Vitesse 3 (`…817994d5`, `fed604fe`, `f7370daa`),
Arrêt & stationnement 2 (`…811b96fd`, `…81d793bc`), Usagers 1 (`5f426e8e`), Croisement &
dépassement 1 (`99824d4d`), Tunnels 2 (`3a06288b`, `5c11020d`). Ce n'est pas un progrès de
forme : c'est un changement de ce qui est mesuré.

**`forme/impersonnel` 215 → 216 : une entrée.** `f7370daa…` disait « deux voies dans votre
sens » ; l'image porte la configuration, l'énoncé est devenu « sur cette chaussée » et a
perdu son « votre ». Aucune sortie.

**`forme/definitionnel` 98 = 98**, sans entrée ni sortie : les énoncés raccourcis ont gardé
leur verbe final (« indique : », « impose : »).

**`longueur/plus-longue` est resté à 76, mais pas sans effort** : deux fois (tâche 3B-2,
76 → 78 ; tâche 8, 76 → 77 en cours de tâche) un distracteur raccourci au-delà du plafond de
50 a rendu la bonne réponse la plus longue. Les deux fois, corrigé en élargissant le
distracteur, jamais en touchant la bonne réponse.

Recompte du livré (commande du plan, step 1, et `ls` des imagesets) :

| | `main` | livré |
|---|---:|---:|
| questions | 464 (271 `code`, 193 `swift`) | 464 (271, 193) |
| cartes illustrées | 49 | **76** |
| — par une photographie | 1 | 24 |
| — par un schéma | 48 | 52 |
| cartes `fondation` illustrées | 0 | 17 |
| imagesets photographiques | 2 | 25 |
| imagesets dessinés | 49 | 52 |
| imagesets sans carte | 2 (`giratoire-sortie-clignotant`, `ligne-jaune-continue`) | 1 (`ligne-jaune-continue`) |

Les deux photographies de `main` étaient `panneau-giratoire-vue-conducteur` (en service, sans
variante sombre jusqu'à la tâche 2) et `ligne-jaune-continue` (orpheline depuis qu'un dessin
l'a remplacée avant ce chantier ; toujours orpheline, jamais supprimée). Vingt-trois
photographies sont neuves : seize remplacent un panneau isolé dessiné (treize en tâche 3,
trois en tâche 6), sept sont des imagesets neufs (AB3a, AB6, M12, les deux photos de
famille, C111, C111 + panonceau). Dix-neuf schémas sont neufs.

Seuil relevé dans `laBanqueGardeSonVolumeIllustré()` : `int(76 × 0,9)` = **68** (il était à
44). Vérifié à la frontière : à 77 le test échoue (`Expectation failed: illustrées.count >=
77`), à 68 il passe.

## 2. Les cartes gardées en texte

La prochaine passe doit distinguer deux familles : celles que le **garde-fou** du §2 de la
spec a arrêtées (220 caractères d'explication ne tiennent pas sans perdre la raison), et
celles qu'une **autre raison** a gardées en texte. Comptes relevés sur l'arbre livré
(énoncé / plus longue option / explication).

### Le garde-fou

| id | domaine | é / o / x | ce qui n'entrait pas dans 220 | source de la décision |
|---|---|---|---|---|
| `1f62ee2f0d02611c04ed79a57b73412a` | Feux | 70 / 58 / 519 | la raison (un véhicule éteint devient invisible à qui arrive à vitesse) et la limite (la sanction ne vaut que sans éclairage public) | `task-5B-cartes.md` |
| `2fc1ed8a9c9274f0e06be9f12850f5a4` | Croisement & dépassement | 94 / 47 / 330 | la raison ou la limite | `task-7-cartes.md`, rapport 7 |
| `f1ae9582d692d2bb7febb6a3c936ff34` | Croisement & dépassement | 46 / 44 / 330 | même motif ; sa notion a déjà une application illustrée (`42078575…`) | `task-7-cartes.md` |
| `a6fb8c0684dce67923a3207ee19171c9` | Usagers & partage | 69 / 43 / 353 | les deux plafonds, la restriction aux deux voies de gauche ou la sanction — et une scène devrait choisir si une file est arrêtée, ce qui trancherait entre deux options | `task-9-cartes.md`, rapport 9 |
| `b7b38d7ae1faf0dd593a1a2446b59ee6` | Usagers & partage | 74 / 46 / 386 | ses deux limites (sécurité compromise, trottoir ou accotement d'abord) — et placer le piéton sur la chaussée, c'est choisir un bord, donc la réponse | `task-9-cartes.md`, rapport 9 |
| `bda520451eb11447c3921f8a358742f1` | Tunnels & passages | 65 / 42 / 464 | règle + raison (l'œil met des secondes à s'adapter ; être vu) + limite (jusqu'au C112) — et l'objet est une prescription, pas une configuration | `task-10-cartes.md`, rapport 10 |

Les trois dernières relèvent **aussi** de l'autre famille : le budget les arrêtait, l'image
les aurait arrêtées de toute façon.

### Une autre raison

| id | domaine | é / o / x | raison |
|---|---|---|---|
| `37fe1af42b8d81bd9426eabc80ab4a05` | Priorités | 24 / 50 / 242 | illustrée, cette fondation STOP deviendrait mot pour mot `443e4299…` (« Ce panneau impose : » sur une photo de STOP) — règle « une fondation ne devient jamais la jumelle d'une application » (spec §3) ; seule la glose « (octogone rouge) » est partie |
| `37fe1af42b8d812fade7d79d309e4c48` | Priorités | 58 / 49 / 259 | jumelle de `dd4c58fe…` (entrée de giratoire, même réponse) |
| `37fe1af42b8d818fb7c9efba6c63d91d` | Priorités | 63 / 46 / 223 | jumelle de `f255331d…` (`carrefour-priorite-droite`) |
| `37fe1af42b8d8184beb9c6687c92ffb5` | Priorités | 41 / 44 / 245 | aucun second AB7 photographiable (§3 ci-dessous) ; `panneau-ab7-fin-priorite` sert déjà `7d44f7dd…` |
| `37fe1af42b8d817da9fff3054d6ffa3a` | Priorités | 75 / 48 / 255 | aucune scène dessinée pour la hiérarchie des signaux |
| `37fe1af42b8d81699c2ffbefd648d9a3` | Panneaux & marquage | 57 / 56 / 213 | famille (disque bleu sans liseré) : jamais trois instances sur un même site dans les ~2 500 clichés de Marc Mongenet parcourus |
| `899646535894ff92314de8bbb12f769a` | Panneaux & marquage | 63 / 41 / 302 | famille (triangle de danger) : même recherche, même résultat |
| `2113eaf703eec8a91ce135e3e96d8082` | Panneaux & marquage | 51 / 41 / 457 | famille (carré ou rectangle) : deux candidats à deux codes, aucun à trois |
| `6f086316c1ff1dfa49dce303862e2bc1` | Panneaux & marquage | 36 / 59 / 295 | famille (fond jaune) : des paires `AK`, jamais trois sur un poste |
| `f12ee5bea85947a13d387f574e817337`, `03041783e81ea879ebb18f4c75170754` | Panneaux & marquage | 76 / 49 / 235 ; 53 / 53 / 383 | règles d'application sans objet à montrer (chantier contre permanent ; portée d'une prescription) — spec §3, « restent en texte sans discussion » |
| `3cb86b6e4c489d919a495408021f062a` | Panneaux & marquage | 71 / 41 / 196 | rangée avec les deux précédentes (« cartes de règle ») par `task-3B-2-cartes.md`, sans motif propre écrit |
| `d5505e2b6bdcdeb78eecbec2a2a2a724` | Feux | 105 / 60 / 295 | une scène de nuit introduirait un registre visuel qu'aucune scène du catalogue n'a |
| `6012289234e0766392ac505dbfdbd3ae` | Feux | 71 / 52 / 311 | porte sur l'équipement du véhicule, pas sur une situation à montrer |
| `f5a12ba77751310fe9a210a3b787286a` | Croisement & dépassement | 49 / 45 / 404 | ses options sont des conditions : toute image d'un carrefour précis montrerait la condition ou la contredirait (capture n°9, §7) |
| `e5b0f585f1a3654ca790b9e391db8203` | Croisement & dépassement | 62 / 48 / 209 | même motif : une traversée sans barrière dessinée donnerait la réponse |
| `87c63a1be4e005f6c846d7798756696f`, `37fe1af42b8d818da27dc338f75795fe` | Vitesse | 100 / 43 / 256 ; 97 / 8 / 199 | prémisse = un modificateur de règle (probatoire, pluie) ; une seconde vue de chaussées séparées doublerait la fondation `fed604fe…` |
| `36d598b80e93b695b2994fce6172eb50` | Distances & freinage | 46 / 43 / 345 | le verglas est invisible, la carte porte un comportement ; le plan prévoyait une scène, décision contraire |
| `5ae4a8d7800141787ada8a389ff74fc1` | Tunnels & passages | 50 / 41 / 316 | la question porte sur une qualification (« gênant »), qu'aucune image ne pose |

Restent en texte, sans avoir jamais été au périmètre d'une image : les cartes du lot
« glose » ou « raison » seules (`…8193887b` codes, `…81adbe05` détresse, `…81589410`,
`04182c9b`, `…811198bd`, `…8181a057`, `45d84549`, `…8104b119`, `8e64074d`, `526d6b50`,
`…81b99c05`, `…81d09328`, `…818293f3`).

## 3. Les panneaux restés en dessin

**Aucun panneau isolé n'est encore dessiné** : les seize panneaux seuls que le catalogue
dessinait sont photographiés. Restent en CoreGraphics les panneaux **plantés dans une scène**
— on ne compose pas une photo dans une vue de dessus (spec §4). Relevé par
`grep` des appelants dans `Tools/Scenes/` :

| fonction de `Panneaux.swift` | panneau | scènes |
|---|---|---|
| `panneauStop` | AB4 | `carrefour-stop`, `carrefour-feu-contre-panneau` |
| `panneauCedez` | AB3a | `carrefour-cedez-le-passage`, `rond-point-insertion` (par `giratoireInsertion`), `giratoire-sortie-clignotant`, `carrefour-feu-jaune-cedez` |
| `panneauRoutePrioritaire` | AB6 | `carrefour-route-prioritaire` |
| `panneauDescenteDangereuse` (par `panneauDeDanger` et `panonceau`) | A16 + panonceau « 12 % » | `croisement-en-pente` |

Hors de la ligne de partage, et donc dessinés aussi : les signaux lumineux (`feuTricolore`,
`feuHorsService`, `signalDAnticipation`, `signalDArret`), dont l'état — allumé,
clignotant — ne se photographie pas ; et la balise J10 de `passage-a-niveau-balises`, **vue
de face et seule**. `images.md` (section de la tâche 6A) écrit que plus aucun panneau isolé
n'est dessiné : c'est vrai des panneaux au sens de la spec, pas de cette balise. Savoir si la
ligne de partage couvre une balise n'a été tranché nulle part.

Aucune recherche de photographie n'a été faite pour les panneaux plantés dans une scène : la
colonne « meilleure résolution trouvée » que demandait le plan n'a donc rien à porter pour
eux.

**Les recherches faites sans succès**, pour qu'une passe ultérieure ne les refasse pas :

- **Le C111 seul** (tâche 10, chiffres du rapport 10) — aucun poteau ne portant que le C111
  n'a passé le double écart. `Entrée Est Tunnel Bois Clair Berzé Châtel 2.jpg` (Chabe01,
  CC BY-SA 4.0, 4032 × 3024) : 63,7 / 39,5 sur un bord, mais **3,5 / 2,4** en un point du
  bord gauche et **−15,8 / −9,9** en un troisième, la roche claire dépassant le listel. Le
  `…1.jpg` du même site (champ ≈ 144 px) : les quatre bords entre 24,2 et 25,4 en sombre.
  `Tunnel Mont-Blanc panneaux C111 M2.jpg` et la variante du tunnel du Vuache donnaient 95 à
  190, mais ce sont des panneaux combinés (nom + arche + panonceau). Les deux cartes livrées
  portent donc un C111 accompagné de sa plaque de nom (et, pour `5c11020d`, du panonceau
  « 372 m » d'un autre tunnel que celui de `3a06288b`), en décor déclaré. Pour le panonceau :
  Croix-Rousse écarté à 22,7 / 14,1 sur une bande de 30 px du bord gauche ; Galibier ×2,
  Chambéry, Bastia écartés pour un panneau de vitesse ou de hauteur dans le cadre.
- **Le second AB7** (tâches 3A-3 et 4A) — dix candidats, catégorie Commons `AB7 (road sign,
  France)` (~75 fichiers) épuisée : Douvaine (panonceau collé), Brugheas (balise de
  chantier), Bernin ×2 (mât à cinq panneaux), Marcigny `…1.jpg` (contre-plongée, 37,4 / 23,2),
  Marcigny `…4.jpg` (pictogramme 31 / 19), `D269 Menthon-St-Bernard` (aucun AB7), `D1075` /
  `D1085` (scènes à plusieurs panneaux, sous 1 152 px), `Loupes panneau - 2015a` (plaques
  collées). Détail dans `images.md`, section Photographies.
- **Les familles** (tâche 3B-2) — quatre sur six sans cliché à trois instances ; méthode
  (motif de nom de fichier sur les uploads de Marc Mongenet) dans `images.md`.
- **Les sources plus proches pour le C113** (tâche 3A-3) — Arcachon (34 % du cadre, 24,5 /
  15,2 contre un ciel laiteux), Bellerive (25 %, mur à 211,1 contre un listel à 195,2).

## 4. Les niveaux de gris, remesurés sous la règle v3

La règle v3 (spec §4, point 6) : deux écarts d'au moins 25 points, dans les deux modes —
le listel contre le fond **qui touche** le panneau, **au pire endroit**, et le pictogramme
contre le champ. Les photographies des tâches 2, 3A-1 et 3A-2 avaient été mesurées sous les
règles v1 (centre contre coin du cadre) et v2 (champ contre coin) ; le registre le notait
comme dette de la tâche 14. Elles sont toutes remesurées ici, et les autres aussi.

### Méthode

Mesurer « au pire endroit » demande de balayer tout le contour, pas trois points choisis.
Le balayage retenu, sur les JPEG `@3x` livrés, Rec. 709 (la formule de `luminance.py`) :
tous les 3° autour du panneau, un rayon part du centre ; on y repère le bord extérieur de la
bande d'ancrage (couronne rouge, champ bleu, filet sombre selon le panneau) ; le **listel**
est la zone 3 × 3 la plus claire de la bande qui suit (la « structure de bord la plus
claire » de la spec) ; le **fond** est une zone 7 × 7 prise juste au-delà du bord extérieur
du panneau, arête de tôle comprise. Mêmes coordonnées dans le mode sombre. Chaque point sous
25 a été regardé sur une mosaïque de gros plans ; les points où l'échantillon tombait à côté
(sur l'arête de tôle, dans un coin arrondi) ont été corrigés par un réglage, et quand ce
n'était pas possible, ils sont nommés. Sont **exclus**, et déclarés, les contacts avec le
poteau, avec un panonceau ou une plaque fixés au panneau et avec un panneau voisin du même
mât, comme les relevés antérieurs le faisaient.

Le script de balayage a servi à cette tâche et n'est pas versé au dépôt : il est hors du
périmètre (aucun outil ne devait bouger). Les pires points sont recoupés avec
`Tools/luminance.py`, qui, lui, est au dépôt ; exemple, pour le B6d :

```bash
uv run --with pillow Tools/luminance.py \
  Valido/Assets.xcassets/Scenes/panneau-b6d-arret-interdit.imageset/sombre@3x.jpg \
  --zone 708,200,3 --zone 715,182,7
# listel 115,2, fond 107,1 → 8,1 (clair : 185,7 contre 172,8 → 12,9)
```

Recoupés de la même façon : A13b (`--zone 279,602,3 --zone 244,607,7` → 16,4 / 10,3), B1
(`338,261,3` / `313,237,7` → −7,6 / −4,3), AB4 (`759,774,3` / `785,794,7` → 22,2 / 14,2),
B31 (`419,627,3` / `411,632,7` → −6,4 / −4,7). Les deux outils ne tombent pas sur le même
pixel à un près (arrondi du coin de zone) ; les écarts restent du même ordre.

**Ce que la mesure dense dit de la règle elle-même** : sur un fond pommelé — feuillage au
soleil, ciel entre des branches, roche claire —, une zone 7 × 7 finit presque toujours par
tomber sur une tache de la luminance du listel. « Au pire endroit », appliqué point par
point, condamne ainsi la plupart des photographies prises devant de la végétation, y
compris des panneaux qui se lisent sans effort à l'œil. Les relevés antérieurs, sur deux à
cinq points choisis, ne le voyaient pas. Ce rapport ne corrige pas la règle : il publie ce
qu'elle donne, et le compte des points qui échouent, pour que la décision se prenne sur des
chiffres.

### Le listel contre le fond

Colonnes : points mesurés ; pire écart clair et sombre (angle, 0° = à droite, 90° = en bas) ;
nombre de points sous 25 en sombre ; ce qui touche au pire endroit ; ce que `images.md` ou le
rapport de tâche publiait.

| asset | points | pire clair | pire sombre | < 25 sombre | au pire endroit | publié avant |
|---|---:|---:|---:|---:|---|---|
| `panneau-b21b-tout-droit` | 113 | 54,7 | 34,0 | 0 | talus herbeux | v1 : 123,7 / 76,7 (centre contre coin) |
| `panneau-b1-sens-interdit` | 113 | −1,5 | −0,2 | **14** | la tôle grise du support octogonal derrière le disque, et le ciel entre les branches | v1 : 48,3 / 30,2 |
| `panneau-b3-interdiction-depasser` | 99 | 45,2 | 27,6 | 0 | feuillage (panonceau « 3,5 t » exclu) | v1 : 52,9 / 32,8 |
| `panneau-b6a1-stationnement-interdit` | 113 | −1,7 | −1,8 | **22** | feuilles au soleil, mur crépi | v1 : 91,8 / 56,8 |
| `panneau-b6d-arret-interdit` | 113 | 15,4 | 8,2 | **58** | le ciel, sur la moitié gauche et le haut ; seule la fine arête sombre de la tôle détache le disque | v1 : 77,2 / 47,9 |
| `panneau-a1a-virage` | 115 | 53,1 | 32,5 | 0 | haie | v2 : 64,7 / 40,5 |
| `panneau-a13b-passage-pietons` | 115 | 14,6 | 9,4 | **8** | le mur blanchi de la ferme, sur le flanc gauche | v2 : 85,7 / 53,6 (champ contre coin) |
| `panneau-a14-panonceau` | 89 | 26,8 | 15,8 | 1 | végétation éclairée (panonceau exclu) | v2 : 43,0 / 26,4 |
| `panneau-b31-fin-interdictions` | 113 | −0,4 | −0,9 | **16** | roche au soleil, en bas à gauche, là où la barre atteint le bord ; herbe sèche en haut à droite | v2 : 65,0 minimum |
| `panneau-ab4-stop` | 98 | 25,2 | 15,8 | **18** | le ciel, sur les deux flancs | v3 : 45,1 / 28,3 |
| `panneau-ab7-fin-priorite` — arête de tôle | 113 | −2,3 | 0,5 | **55** | ciel et forêt | v3 : exception, 14,7 / 9,1 au sommet droit |
| `panneau-ab7-fin-priorite` — bordure noire | 113 | −0,3 | −0,1 | **18** | forêt sombre, bas gauche et haut droit | — |
| `panneau-c1a-parking` | 113 | 23,6 | 14,6 | 1 | façade, flanc droit | v3 : 67,0 (pictogramme) |
| `panneau-c113-voie-velo` | 113 | 37,4 | 22,8 | 1 | herbe claire, coin bas droit | v3 : 36,9 (pictogramme) ; listel 65,7 |
| `panneau-ab3a-cedez-le-passage` | 105 | 35,7 | 22,0 | 1 | ciel entre les branches, flanc droit (mât exclu) | v3 : exception ≈ 32 / 20 au sommet haut |
| `panneau-ab6-route-prioritaire` — arête de tôle | 113 | 0,1 | 0,1 | **74** | le ciel | v3 : 75 / 46 |
| `panneau-ab6-route-prioritaire` — bordure noire | 113 | −17,5 | −10,9 | 3 | clôture et bâtiments, en bas | — |
| `panonceau-m12-cyclistes` | 101 | −1,3 | −1,0 | **42** | le ciel, flanc gauche ; le mât gris, flanc droit | v3 : exception, 16 en sombre au flanc droit ; flanc gauche 66,8 / 41,4 |
| `panneau-b14-limitation` | 111 | −56,5 | −35,1 | 0 | ciel | 30,0 / 18,1 contre 244,8 / 151,0 — c'est la couronne rouge qui est mesurée, pas le listel |
| `panneau-b33-fin-limitation` | 113 | 2,4 | −1,7 | **33** | ciel à droite et feuillage au soleil : l'arête claire extérieure (3 à 4 px) est de la teinte du fond | quatre points, 65,4 / 40,6 minimum |
| `panneau-b30-zone-30` — bande rouge | 115 | −28,9 | −17,4 | 3 | ciel, bas et coin haut droit | 43,4 / 29,2 |
| `panneau-c111-tunnel` | 54 | 122,7 | 76,3 | 0 | végétation (plaque et panonceau exclus) | 63,7 / 39,5 |
| `panonceau-tunnel-longueur` | 54 | 51,7 | 31,7 | 0 | végétation (plaque et panonceau exclus) | 59,6 / 37,1 minimum |
| `panneaux-ronds-bord-rouge` — « 70 » | 84 | 7,8 | 5,3 | **17** | herbe sèche (panonceau et disque voisins exclus) | ≥ 43 / ≥ 28 pour les trois disques |
| `panneaux-ronds-bord-rouge` — poids lourds | 99 | 10,1 | 7,7 | **19** | feuillage au soleil | idem |
| `panneaux-ronds-bord-rouge` — arrêt interdit | 90 | 13,4 | 6,5 | 7 | feuillage | idem |
| `panneaux-ronds-bord-rouge` — « 110 » (décor) | 99 | −0,5 | −0,9 | 31 | roche à l'ombre | déclaré sous le plancher, 7,5 |
| `panonceaux-b1-thonon` — haut | 30 | 1,2 | 0,9 | **21** | le ciel, deux flancs | déclaré, 7,5 au pire point |
| `panonceaux-b1-thonon` — milieu, bas | 30 ; 18 | −5,2 ; −22,4 | −3,2 ; −16,7 | 2 ; 1 | coins arrondis, échantillon peu sûr | ≥ 47 / ≥ 19 |
| `panneau-giratoire-vue-conducteur` | 109 | 24,3 | 13,5 | 2 | ciel au sommet ; panneau de ~110 px, listel de 2 px | aucun relevé v3 |

Les flancs latéraux seuls sont mesurés sur les panonceaux de Thonon, le C111 et le
panonceau de tunnel : dessus et dessous touchent une autre plaque du même mât.

**En résumé** : sous la règle v3 appliquée au pire point, **six photographies passent
partout** — B21b, B3, A1a, B14, C111, panonceau de tunnel — et quatre à un point près —
A14, C1a, C113, AB3a, un seul point sous 25 en sombre chacune. Les autres échouent
sur une partie de leur pourtour, et aucune n'est comptée comme passage : les exceptions
déjà écrites (AB7, AB3a, M12, C113 petit) restent des exceptions, et **s'y ajoutent** B1,
B6a1, B6d, A13b, B31, AB4, AB6, B33, B30, les trois disques mesurés de la photo de famille
et le panonceau du haut de Thonon. `images.md` n'est pas corrigé par ce rapport.

### Le pictogramme contre le champ

Médiane des pixels classés par couleur dans l'intérieur du panneau, clair / sombre.

| asset | paire | écart clair / sombre |
|---|---|---:|
| A13b, A14, A1a | noir sur blanc | 158,5 / 98,4 ; 172,5 / 106,8 ; 189,4 / 117,7 |
| AB3a | bordure rouge contre champ blanc (pas de pictogramme) | 147,1 / 91,7 |
| AB4 | lettres blanches sur rouge | 155,7 / 96,5 |
| AB6 | losange jaune contre champ blanc | 47,9 / 29,6 |
| AB7 | blocs orangés contre champ ; barre noire contre champ | 55,0 / 33,8 ; 114,8 / 71,2 |
| B1 | barre blanche sur rouge | 116,8 / 72,7 |
| B14, B30, B31, B33 | noir sur blanc | 123,2 / 76,4 ; 175,5 / 109,1 ; 178,9 / 111,7 ; 167,1 / 103,6 |
| B21b, C111, C113, C1a, panonceau de tunnel | blanc sur bleu | 129,1 / 79,7 ; 143,5 / 89,0 ; 122,9 / 75,8 ; 108,5 / 66,9 ; 97,2 / 59,9 |
| B3 | voitures noire et rouge sur blanc | 146,9 / 91,0 ; 135,2 / 84,2 |
| **B6a1** | **oblique rouge sur bleu** | **5,9 / 3,9** |
| **B6d** | **croix rouge sur bleu** | **5,0 / 3,3** |
| **arrêt interdit de `panneaux-ronds-bord-rouge`** | **croix rouge sur bleu** | **17,4 / 11,1** |
| **M12** | **vélo jaune sur blanc** | **36,9 / 22,6** — exception structurelle déjà écrite (36,6 / 22,7) |
| panonceaux de Thonon | noir sur blanc | 161,8 / 100,4 ; 157,3 / 97,7 ; 158,9 / 99,2 |
| giratoire (AB25) | flèches noires sur blanc | 177,6 / 110,3 |

**Le B6a1 et le B6d échouent de vingt points** sur la seconde paire, et ce n'est pas le
cliché : le rouge et le bleu réglementaires ont presque la même luminance. En niveaux de
gris, le disque est un rond sombre uniforme où l'oblique et la croix ne se devinent qu'à
leur liseré d'antialiasing — or c'est précisément leur nombre de barres qui distingue les
deux cartes (`1658abbc…` stationnement interdit, `1509ad94…` arrêt interdit). Jamais mesuré
avant : les deux photos ne l'avaient été qu'en v1. C'est la même exception structurelle que
le M12 (« aucune image fidèle ne passera »), plus sévère, et sur un couple de cartes voisines.

### Les schémas neufs

Les dix-neuf schémas n'utilisent que des teintes de `Palette`, identiques d'une scène à
l'autre. Rejoués sur les PNG `@3x` livrés, aux coordonnées publiées par `images.md` (3B-1,
6B, 7, 8) : chaque valeur retombe à la décimale — marquage 255,0 / 234,3 contre chaussée
93,1 / 75,1 ; candidat 128,6 / 128,6 ; véhicule d'en face 180,0 / 196,6 ; véhicule lent
118,6 / 154,1 ; terre-plein 139,1 / 115,3 ; trottoir 235,1 / 37,2. Pour les scènes 4B, 5A et
9, publiées sans coordonnées, le recensement des aplats de chaque PNG retrouve exactement les
paires publiées (feu vert 166,7 / 170,7, bande du STOP 86,0 / 115,1, contour 51,0 / 51,0,
casque 241,0, guidon 181,0, corps 34,0, épaules 134,0). Les écarts les plus serrés restent
ceux déjà écrits : véhicule `tiers` contre chaussée à 25,5 en clair (`file-ralentie`,
`route-trois-voies-double-sens`), contour contre chaussée à 24,1 en sombre (`file-ralentie`,
comme `croisement-chaussee-etroite`), trottoir contre chaussée à 37,9 en sombre.

**Un écart que personne n'avait mesuré** : `giratoire-sans-panneau` (et, avant lui,
`rond-point-insertion` et `giratoire-sortie-clignotant`, même géométrie) pose l'îlot central
en `p.ilot`, 219,0 / **69,2**, sur un anneau en chaussée à 93,1 / **75,1** : **5,9 points** en
mode sombre. L'îlot disparaît ; l'anneau ne se lit plus que par ses tirets. C'est le défaut que
la tâche 6B avait trouvé sur le terre-plein (`p.ilot` remplacé par `p.bordure`) et laissé en
observation sur `autoroute-voie-de-gauche`. Les scènes de profil `croisement-en-pente` et
`depassement-sommet-de-cote` emploient aussi cette teinte ; non examinées ici.

## 5. Le mouvement des trois compteurs de forme

Relevé et expliqué au §1, jamais visé : `forme/hors-situation` −27 (les cartes illustrées
sortent du périmètre), `forme/impersonnel` +1 (un « votre » parti avec la configuration),
`forme/definitionnel` 0. Aucun énoncé n'a gagné un « vous » pour faire baisser un compteur.

Deux conséquences pour la lecture future. Le paragraphe de `CLAUDE.md` qui écrivait que
« chaque future fondation les fera monter d'une unité chacun » ne vaut plus que pour une
fondation en texte : dix-sept fondations sont désormais illustrées (six en tâche 3B-2), et
une fondation illustrée ne pèse pas sur `forme/hors-situation`. Et le constat du diagnostic
de forme (§3, angle mort n°4) se vérifie à grande échelle : le compteur a baissé de 27 sans
qu'aucune carte ne soit devenue plus « située » — il mesure la présence d'une image.

## 6. Ce que l'outillage n'a pas vu

| n° | ce qui est passé sous l'outillage | trouvé par |
|---|---|---|
| 1 | **Fuites fermées à la main en `Arrêt & stationnement`** (tâche 8), `relire.py` à 0 à la clôture : la glose « (135 € et 3 points) » de `…811198bd` et sa phrase « ne coûte aucun point » livraient `3497bb89…` ; l'explication de `…8181a057` rangeait passages piétons et voies réservées parmi les très gênants, réponses de `…8134ad4b` et `…81d793bc` (en substance, pas mot pour mot) ; l'option C de `c5d4d52f…` nommait le stationnement dangereux comme seul degré à points — et `relire.py` ne lit pas les options. | contrôleur et implémenteur, rapport 8 |
| 2 | **Fuites fermées à la main en `Distances & freinage`** (tâche 11) : l'incise « comme pour le non-respect des distances de sécurité » de `aad60a74…` livrait `…81e7a041` (réponse de trois mots pleins, mais paraphrasée, pas incluse) ; la glose « (1 s) » de l'**énoncé** de `…8104b119` livrait la fondation `…81e98af3`. | contrôleur, rapport 11 |
| 3 | **Fuites fermées à la main en `Permis & sanctions`** (tâche 13), `relire.py` à 0 à la clôture : téléphone ↔ ceinture ↔ distances (le montant et les points partagés, seuls de leur valeur dans les options) ; « taxi en service » dans la ceinture, bonne réponse de `8e64074d…` (autre domaine) ; « 110 km/h au lieu de 130 » dans le disque A, bonne réponse de `…819e9620` (Vitesse). | contrôleur, rapport 13 |
| 4 | **Une fuite fermée en vidant une phrase** (tâche 13, `0c52013`) : la carte téléphone devenait « au même niveau que d'autres inattentions du code », la ceinture « comme d'autres négligences au volant » — plus aucune règle propre. L'audit n'y voit rien. Réécrit en `2c50980` : chaque carte dit sa classe et ses points, sans nommer l'autre. | contrôleur, avant revue |
| 5 | **Un accord cassé** (tâche 12, `7f28327`) : « Des barres de toit chargées » au pluriel, options restées au féminin singulier. Ce n'était pas une fuite fermée, contrairement à ce que le brief de cette tâche suppose : c'était la correction de glose de la capture n°7. Corrigé en `a42d1eb` en revenant au singulier et en glosant « galerie de toit » par ce qu'on voit. | contrôleur, avant revue |
| 6 | **Une fuite cachée sous le seuil** (tâche 4D) : « route à caractère prioritaire » réduit à « route prioritaire », trois jetons → deux, `relire.py` passé de 2 à 0 sans que rien ne soit fermé — et le recouvrement avait déjà été jugé acceptable par la passe 3 (Point 17). Défait en `94c6b06`. | revue 4D |
| 7 | **La photo du B30 dont le panonceau contredisait un distracteur** (tâche 6A) : « PRIORITÉ PIÉTONS » sous le panneau, soit le distracteur B de `ed0e45e0…` et l'inverse de ce qu'enseigne `cac0f9db…`, sans un mot dans l'`alt`. Re-sourcé en `57a3f0e` ; règle du décor complétée dans la spec. Aucun contrôle ne lit le texte d'une photo. | contrôleur |
| 8 | **La règle v3, appliquée partout**, contredit une grande partie des relevés publiés (§4) ; et le B6a1 / B6d n'ont jamais eu leur paire pictogramme / champ mesurée. | cette tâche |
| 9 | **L'îlot du giratoire** à 5,9 points de l'anneau en mode sombre, sur trois scènes (§4). | cette tâche |
| 10 | **`images.md`, en l'état** : les sections de trois lots de schémas (6B, 7, 8) sont rangées sous `## Photographies` ; « `Panneaux & marquage` est désormais entièrement photographique » est faux (ses marquages sont dessinés) ; « Ces quinze-là passeraient une diffusion » date de quinze photos, il y en a vingt-cinq ; les chiffres dits « listel » du B14 et du B30 sont ceux de la couronne ou de la bande rouge ; la ligne de `inter-files` dit encore « en niveaux de gris » (le mot a été retiré de l'`alt`, tâche 9) et sa mesure de luminance n'est que dans le rapport 9. `audit.py` ne lit que les lignes de tableau. | cette tâche |
| 11 | **Cadrages** : l'octogone de `panneau-ab4-stop` est coupé par le bas du cadre ; le triangle de `panonceau-m12-cyclistes` touche le bord haut ; sur `panonceaux-b1-thonon`, le B1 est presque entièrement hors cadre — il n'en reste que le bas du disque, et le panonceau « 800m » est coupé en bas ; `panneau-giratoire-vue-conducteur` fait 1 098 px de large, sous le plancher de 1 152 px de la passe (il la précède). | cette tâche |

## 7. Les captures de l'usager

Retrouvées carte par carte en regardant chaque image et en cherchant ses options dans
`questions.json`.

| n° | commentaire | carte | ce qui a été fait, et par quelle tâche |
|---|---|---|---|
| 1 | « pas très compréhensible » | `04182c9b…` | énoncé réécrit « Un excès de vitesse de 40 à moins de 50 km/h fait perdre : », aligné sur ses voisines de notion (tâche 6C, `fd57087`) |
| 2 | « difficile à y croire » | `8e64074d…` (taxi) | **pas suivie à la lettre** : aucune source de la liste blanche ne donne de mécanisme propre à l'exemption (directive 2003/20/CE, art. 6 ; réponse ministérielle QE 4994 lue en entier) ; la carte le dit — « c'est une dérogation admise par le droit européen » (tâche 12, `7f28327`, `a42d1eb`) |
| 3 | « lire plusieurs fois, une image aurait aidé » | `99824d4d…` | illustrée par `route-trois-voies-double-sens`, énoncé « Sur cette route, pour dépasser : » (tâche 7) |
| 4 | « ajouter "si vous êtes" » | `9e65525b…` (B3) | la correction proposée aurait rendu la carte fausse (le B3 exempte le véhicule dépassé) ; retournée par la spec, qui la remplace par « nommer l'objet ». Le livré : la photographie du B3 (tâche 3A-1) ; l'énoncé est celui de la capture, inchangé. **Non suivie à la lettre non plus**, et c'est voulu — je le signale parce que le brief de cette tâche ne compte que deux captures dans ce cas |
| 5 | « vérifie cette information » | `749552ac…` (refus de dépistage) | vérifiée à L234-8 en vigueur, exacte ; aucune correction (spec, « Le problème ») |
| 6 | « ça veut dire quoi "(codes)" ? » | `37fe…8193887b` | glose inversée retirée de l'énoncé (tâche 5B), puis de l'explication, où « codes » restait deux fois (`6179d68`) |
| 7 | « c'est quoi une galerie de toit ? » | `526d6b50…` | « Une galerie de toit — les barres qui portent des bagages ou un coffre — chargée » ; « pavillon » devient « toit » (tâche 12, `a42d1eb`) |
| 8 | « pourquoi pas d'illustration ? » | `b433eefe…` (M12) | photographie du M12 (tâche 4A), énoncé « Ce panonceau autorise : », datation retirée (tâche 4C) |
| 9 | « pourquoi pas d'illustration ? » | `f5a12ba7…` | **pas suivie à la lettre** : gardée en texte, toute image donnerait ou contredirait la condition ; son vrai défaut, l'absence de raison, est corrigé (tâche 7) |
| 10 | « pourquoi un panneau approximatif et pas un vrai, photographié ? » | `37fe…8174a3c3` (B21b) | photographie Commons (tâche 2) — et la ligne de partage de toute la passe : seize panneaux dessinés remplacés |
| 11 | « enfin une vraie illustration, suivre cet exemple » | `9eb85068…` (AB25, `panneau-giratoire-vue-conducteur`) | l'exemple suivi ; la photo a gagné sa variante sombre (tâche 2) |
| 12 | « tu parles pour une moto ? » | `a6fb8c06…` | l'incise sort, le sujet entre : « En inter-files, la vitesse d'un deux-roues motorisé ne peut excéder : » ; reste en texte (garde-fou, §2) (tâche 9) |
| 13 | « pourquoi pas d'illustration ? » | `5f7e9145…` (hachures) | illustrée par `marquage-zebra-vehicule-arrete`, énoncé « Cette zone : », explication 397 → 217 (tâche 3B-2) |

## 8. Aucun registre visuel ne prédit une réponse

Commande du plan (step 5), sur l'arbre livré — seules les cartes illustrées comparées :

```
Panneaux & marquage / panneaux/formes
    [photo] Ce type de panneau indique :
    [photo] Ce panneau donne :
    [photo] Ce panneau indique :
    [photo] Ce panneau impose :
    [schema] Ici, avant de vous engager, vous devez :
    [photo] Ce panneau, pour un cycliste :
Priorités & intersections / panneaux/formes
    [photo] Ce panneau impose :
    [schema] À ce panneau, vous devez :
Priorités & intersections / priorite/regimes
    [photo] Ce panneau indique :
    [schema] Qui passe en premier ?
    [schema] Vous arrivez à ce carrefour. Qui passe en premier ?
    [schema] Vous vous insérez sur la route qui traverse. Qui passe en premier ?
```

La notion `panneaux/portee`, que le plan citait au 2026-09-22 (photo du giratoire au milieu
de panneaux dessinés), n'apparaît plus : ses panneaux sont tous photographiés.

- **`panneaux/formes`, Panneaux & marquage** — sain. Les cinq photos demandent ce qu'un
  panneau signifie ; le schéma demande quoi faire dans un carrefour (`carrefour-cedez-le-passage`,
  « céder le passage, sans obligation de vous arrêter »). Le registre suit le type de
  question. La seule réponse proche d'une photo est l'AB4 (« un arrêt, même si la route est
  vide »), et le schéma du STOP de l'autre domaine répond lui aussi par un arrêt : « schéma »
  ne veut pas dire « pas d'arrêt ».
- **`panneaux/formes`, Priorités & intersections** — sain : photo de l'AB3a (« de laisser
  passer, en s'arrêtant si nécessaire »), schéma du STOP dans un carrefour (« vous arrêter à
  la ligne, puis céder le passage ») ; reconnaître contre manœuvrer, deux réponses qui
  cèdent toutes deux.
- **`priorite/regimes`** — sain : la photo de l'AB6 (« vous êtes prioritaire ») voisine
  trois schémas dont les réponses vont dans les deux sens (l'autre passe ; vous passez ;
  vous passez). Le registre ne dit pas qui passe.

## Laissé ouvert

Les mineurs différés du registre qui décrivent l'état livré, pour la revue de branche (les
mineurs de processus n'y sont pas) :

- `panneau-b6a1-stationnement-interdit` laisse lisible en bas de cadre un panonceau « 30m »
  que l'`alt` ne mentionne pas (3A-1).
- `panonceaux-b1-thonon` et `panneaux-ronds-bord-rouge` : décor sous le plancher (disque
  « 110 », panonceau du haut), déclaré ; « Ce type de panneau indique : » sur un cadre qui
  porte aussi un carré bleu et des panonceaux (3B-2).
- `37fe1af42b8d81f8a2f3f8bd2afc9d2d` : l'option D est l'inverse logique de la bonne réponse
  (3B-2).
- Deux énoncés identiques entre notions (« Ce panneau indique : » AB6 / A1a ; « Ce panneau
  impose : » Cédez / STOP), images et réponses différentes (4C).
- `8e946477…` : explication à 217 / 220 (4D).
- `37fe1af42b8d81e7a041ff53b8ef69c2` : distracteur D (375 € et 6 points) incohérent, différé
  depuis la passe 3 (registre, mineur e).
- `autoroute-voie-de-gauche` emploie `p.ilot` (6B) — et les trois giratoires aussi (§4).
- `Tools/images.md` porte encore du récit de travaux (« Fix round 1 », « premier essai à
  26 ») ; le lettrage « BUS » de `stationnement-voie-bus` passe à 1,5 unité du séparateur ;
  des commentaires `// MARK: … (tâche N, date)` dans `ScenesCirculation.swift` (registre,
  mineurs a, b, d).
- Code d'outillage : `luminance.py` sans test de sa ligne de commande ni garde de bornes
  (1) ; commentaire « cinq colonnes » d'`audit.py` pour une table qui en a six (2) ;
  docstring de `panneauDeDanger` (« cinq panneaux le partagent ») périmée (3A-2) ; bloc de
  véhicule répété dans cinq scènes et `ligneT1` appelée à l'identique dans trois branches
  (4B, 6B).
- `images.md` : la cause du point faible de l'AB3a est attribuée à un reflet flou, c'est une
  pièce nette sur le poteau ; « Maréchal-Joffre » s'écrit sans trait d'union sur Commons (4A).
