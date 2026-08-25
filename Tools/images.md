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
| `siege-enfant-place-avant` | **vue d'intérieur, gros plan** : pare-brise et tableau de bord à droite, siège avant du véhicule, coque de bébé posée dessus dos à la route | maison, aucune source tierce |

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

### Deux vues de profil, et pourquoi le siège enfant a changé de cadrage trois fois (2026-08-25)

Ces deux scènes-là ne pouvaient pas être vues de dessus. Ce que leurs questions font
travailler est un rapport **avant/arrière** — de quel bout un chargement déborde, à quelle
place et dans quel sens une coque est installée — et une vue aérienne ne dit ni « sur le
toit » ni « à la place avant ». Elles rejoignent donc `croisement-en-pente`, seule vue de
profil du dossier jusqu'ici.

**L'échelle est doublée** par rapport aux vues de dessus : une caisse de 96 unités pour 4 m,
soit 24 unités par mètre là où les carrefours comptent 12. La raison est dans la réponse : les
3 m que R312-21 accorde à l'arrière auraient fait 36 unités à l'échelle des carrefours, à
peine plus qu'une roue, donc indiscernables d'un débord d'un mètre. Le débord dessiné vaut 60
unités, soit **2,5 m** — dans la limite légale, et c'est ce qui compte : une scène qui
montrerait un chargement hors la loi rendrait fausse la bonne réponse de sa propre question.
Le chargement ne dépasse pas non plus l'aplomb avant, que R312-22 interdit absolument.

`siege-enfant-place-avant` a été dessiné **trois fois**, et les deux premières versions sont
la démonstration d'une contrainte qu'il vaut mieux mesurer que deviner. Une coupe de berline
entière tient dans le cadre, mais pas dans la **bande d'environ 110 unités** que le
rétrécissement du bandeau laisse autour du centre vertical : l'habitacle y descend à 62 puis
68 unités de hauteur intérieure, pour deux dossiers et une coque. Le sens de la coque tenait
alors dans un panneau de 18 unités de large, au milieu de trois silhouettes sombres empilées.
La troisième version renonce à la voiture et cadre l'intérieur : la coque fait 32 unités de
large et 70 de haut, et ce qui dit « place avant » est le **pare-brise incliné et le tableau
de bord sous lui** — aucune banquette ne s'adosse à un pare-brise.

**Il n'y a pas d'enfant dessiné dans la coque**, et c'est un retrait délibéré. L'énoncé dit
déjà « Ce siège enfant » : l'image n'a pas à prouver de quoi il s'agit, elle doit dire la
place et le sens. Un enfant a été dessiné puis retiré pour deux motifs mesurés — aucune
couleur du `Palette` ne le sépare franchement à la fois de la coque et du fond dans les deux
modes, et sa silhouette masquait justement l'asymétrie de la coque, qui est ce qui porte la
réponse. Cette asymétrie est le seul porteur : dossier haut et appuie-tête élargi du côté du
pare-brise, rebord de pied bas à l'autre bout. On s'adosse au côté haut, donc le dos de
l'occupant est tourné vers le pare-brise et son regard vers l'arrière. Le siège du véhicule,
dessiné vide juste derrière, est le témoin sans lequel une coque seule n'est retournée par
rapport à rien.

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
| `siège` — fond (`sol`) | 40, 40 | 235,1 | 37,2 |
| `siège` — pare-brise | 375, 110 | 255,0 | 245,3 |
| `siège` — tableau de bord, siège du véhicule, plancher | 365, 178 | 139,1 | 115,3 |
| `siège` — coque, dossier haut côté avant | 266, 140 | 180,0 | 196,6 |
| `siège` — coque, rebord de pied côté arrière | 154, 136 | 180,0 | 196,6 |
| `siège` — creux de la coque (fond visible) | 200, 134 | 235,1 | 37,2 |

Ce que ce relevé établit, et ce qu'il ne prétend pas établir. **Aucune des deux réponses ne
repose sur un état allumé/éteint ni sur une teinte** : elles reposent sur une position (de
quel côté le débord) et sur une silhouette (quel bout de la coque est haut). Il n'y a donc pas
de polarité à vérifier comme sur `feu-fleche-clignotante`. Ce que la mesure doit garantir,
c'est que **chaque silhouette se détache de ce qu'elle touche**, et c'est le cas :

- le bloc de planches se sépare de la caisse de 69,5 points en clair et 80,9 en sombre — la
  raison pour laquelle il est peint en `panneauJaune` et non en `bordure`, qui n'aurait laissé
  que 10,5 points ;
- il ne se sépare du fond que de **37,0 points en clair**, et c'est la mesure la plus faible
  de la scène : c'est son contour sombre, à 51,0 dans les deux modes, qui borne réellement le
  débord — 147 points de contraste contre le bloc lui-même ;
- la coque se sépare du fond de 55,1 points en clair et 159,4 en sombre, et du siège du
  véhicule de 40,9 et 81,3. Le creux de la coque montre le fond, donc le « U » se lit par la
  luminance seule ;
- le pare-brise ne se sépare du fond que de **19,9 points en clair**, sa mesure la plus
  faible ; il est donc, lui aussi, borné par un contour sombre de 2,5 unités.

Deux réserves assumées. La caisse du candidat mesure **128,6 dans les deux modes** (le bleu
`vous` est identique en clair et en sombre) : en mode sombre elle est donc plus claire que la
chaussée (75,1), en clair plus sombre — inversion sans conséquence ici, aucune réponse ne s'y
joue, mais elle vaut d'être notée pour les scènes futures. Et le liseré blanc de la caisse
(255,0 / 234,3) est à la même valeur que la bande de rive : c'est la position, pas la
luminance, qui les distingue.

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
