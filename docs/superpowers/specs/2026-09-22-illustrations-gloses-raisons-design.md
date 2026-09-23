# Illustrer, gloser, expliquer — une passe de contenu née de l'usage

Spec du 2026-09-22. La première dont l'entrée n'est ni un outil ni une source, mais
**l'usage** : treize captures d'écran prises en se servant de l'app, chacune signalée comme
« un symptôme qui peut être général et non un problème précis à fixer ».

Elle suit le diagnostic de forme
([`Tools/audit-2026-09-formes.md`](../../../Tools/audit-2026-09-formes.md),
spec [`2026-09-06`](2026-09-06-formes-questions-etg-design.md)), qui a mesuré l'écart avec
l'épreuve réelle sans corriger une carte, et le chantier des notions
([`2026-09-19`](2026-09-19-notions-maitrise-design.md)). Celle-ci corrige.

## Le problème

Les treize observations se rangent en quatre symptômes, tous trois chiffrés sur les 271
cartes `code` livrées.

**1. L'énoncé fait le travail de l'image — 23 cartes.** Le §7 de
[`Tools/questions.md`](../../../Tools/questions.md) interdit qu'un énoncé redise la scène.
Ici c'est l'inverse qui s'est installé : l'énoncé **remplace** une image absente. « Le
panneau STOP (octogone rouge) impose : », « Un panonceau triangulaire à liseré rouge sous
un feu tricolore autorise : », « Une surface hachurée ou couverte de chevrons, et non un
trait : ». On décrit en mots ce qu'il suffirait de montrer, puis on demande de reconnaître
ce qu'on vient de décrire. Le commentaire d'ouverture de
`Tools/Scenes/ScenesPanneaux.swift` nomme déjà ce défaut — « les questions du domaine
nommaient toutes leur panneau dans l'énoncé, ce qui les rendait solubles sans regarder » —
et la passe qui l'a écrit n'a traité que les cartes qu'elle illustrait.

**2. La configuration spatiale reste en texte — 29 cartes.** « Sur une chaussée à double
sens de trois voies, pour dépasser : », « À l'approche d'une intersection, le
dépassement : ». Le lecteur reconstruit le schéma de tête, à chaque lecture. Quatre
domaines entiers n'ont aucune carte illustrée : `Distances & freinage` (22),
`Permis & sanctions` (21), `Alcool & stupéfiants` (19), `Premiers secours` (18).

**3. Les gloses expliquent le clair et taisent le manquant — 17 cartes glosées.** Trois
défauts distincts, tous présents :

| défaut | exemple | ce qui se passe |
|---|---|---|
| glose inversée | « Les feux de croisement **(codes)** » | le terme officiel est expliqué par un argot que l'app n'a jamais introduit |
| glose inutile | « En inter-files **— entre deux files de véhicules —** » | redit ce que le mot dit déjà, **et omet « des deux-roues motorisés »** que la carte jumelle, elle, porte |
| glose absente | « Une galerie de toit chargée » | aucun mot pour qui n'a jamais chargé un toit |

**4. Une réponse contre-intuitive sans sa raison se lit comme une erreur.** `8e64074d…`
(« Le port de la ceinture n'est pas obligatoire : » → « pour le conducteur d'un taxi en
service ») est juste, R412-1 le dit, et son explication ne donne qu'une liste fermée de six
cas à retenir. Aucun pourquoi, donc aucune raison d'y croire — et rien à apprendre, ce qui
est le seul objet de l'app.

Union des trois lots mécanisables : **61 cartes, sur 11 des 13 domaines** — Priorités &
intersections 14, Panneaux & marquage 13, Feux 8, Vitesse 5, Croisement & dépassement 5,
Arrêt & stationnement 4, Usagers & partage 4, Tunnels & passages 4, Distances & freinage 2,
Mécanique & environnement 1, Permis & sanctions 1. Le quatrième symptôme ne se mécanise
pas : il se lit à la main, domaine par domaine.

**Une observation a été vérifiée et écartée.** La carte `749552ac…` (refus de dépistage
d'alcoolémie), signalée « vérifie cette information », est exacte : L234-8 en vigueur
depuis le 20/08/2026 donne « trois ans d'emprisonnement et 9 000 euros d'amende » et la
réduction de la moitié des points, contre les mêmes peines et une suspension jusqu'à cinq
ans à L234-1/L234-2 — ce que `Tools/sources.md:223` portait déjà, URL et relevé compris.
Aucune correction.

**Une autre a été vérifiée et retournée.** Sur `9e65525b…` (« Malgré ce panneau, vous
pouvez encore doubler : »), la correction proposée — ajouter « si vous êtes » — rendrait la
carte fausse : le B3 exempte le véhicule **dépassé**, pas le dépassant, et la confusion est
le piège explicite de `f5a12ba7…` (« le dépassement *d'*un deux-roues, pas le dépassement
*par* un deux-roues »). L'ambiguïté est réelle, sa correction est de nommer l'objet.

## Ce qui est décidé, et ce qui ne l'est pas

Quatre arbitrages sont pris et ne se rouvrent pas dans cette passe.

1. **Le budget de hauteur ne bouge pas.** `QuestionCardView` n'est pas touché : pas de
   plancher de bandeau, pas de défilement interne, la carte reste une page pleine
   (`containerRelativeFrame` dans `FeedView`). Les seuils 70 / 50 / 220 restent ce qu'ils
   sont, et ce sont les cartes qui entrent dedans.
2. **L'unité de travail est le domaine, pas le symptôme.** Les quatre corrections
   s'appliquent ensemble, carte par carte, domaine par domaine. Enchaîner les quatre
   chantiers ferait réécrire 46 explications deux ou trois fois et rejouerait quatre fois
   la relecture anti-fuite à la main — celle qui a trouvé 44 fuites sur la branche
   précédente là où `relire.py` n'en avait trouvé aucune.
3. **Un panneau se photographie, un marquage et une configuration se dessinent.** C'est la
   ligne de partage de la passe, et elle vaut pour la suite du dépôt (§4).
4. **Aucun `id` ne se recalcule.** Soixante-et-un énoncés changent ; `id` vaut
   `sha256("valido-v2:" + prompt)[:32]` **au moment de la création**, pas après. La
   progression est indexée dessus.

Reste ouvert : combien des seize panneaux existants trouvent une photographie de
résolution suffisante. Un panneau qui n'en trouve pas garde son dessin, et le rapport le
nomme.

## 1. Le transfert : l'énoncé cède à l'image ce qu'elle porte

L'opération n'est pas « ajouter une image à une carte ». C'est **déplacer la description de
l'objet, de l'énoncé vers l'image**, ce qui rend la carte injouable sans elle — la
condition posée par le §7 — et libère au passage la place que le budget réclame.

| | énoncé | explication |
|---|---:|---:|
| `Un panonceau triangulaire à liseré rouge sous un feu tricolore autorise :` | 73 | 257 |
| `Ce panonceau autorise :` + `panonceau-m12` | **23** | **185** |

Le M12 paie son budget par le seul transfert, et il perd en chemin « créé par l'arrêté du
12 janvier 2012 » — la datation de règle que `audit-2026-09-formes.md` compte comme
artefact étranger à la forme de l'épreuve. Ce n'est pas une coïncidence : ce qui sort de
l'explication est ce que l'image montre ou ce qui ne s'y joue pas.

**Aucun asset ne sert deux cartes, et ce n'était pas acquis.** La première version de cette
spec annonçait trois cartes corrigeables sans rien dessiner, `panneau-ab4-stop`,
`panneau-ab7-fin-priorite` et `marquage-zebra` étant déjà au catalogue. Vérification faite,
les trois servent **déjà** une carte — `443e4299ccb3ff71669f8df6669b8bf4` (« Ce panneau
impose : »), `7d44f7dd303fce58716234cba54480b1` et `37fe1af42b8d81d68a70da4a7305f6c1`
(« Ce marquage au sol : »). Poser la même image sur la carte voisine rendrait les deux
indiscernables au fil, et sur `marquage/zones` les deux cartes de la notion porteraient le
même dessin. **Chaque carte décrite en mots reçoit donc sa propre image — un cadrage ou un
cas distinct — ou reste en texte.**

## 2. Le budget, et le garde-fou

Quarante-six des cinquante-deux cartes des lots 1 et 2 dépassent aujourd'hui au moins un
des trois seuils (explication médiane 260 et 247 caractères contre 220 permis ; énoncé de
plus de 70 sur 19 cartes ; option de plus de 50 sur 13).

Le transfert du §1 en paie une partie. Il n'en paie pas la totalité : les chevrons
(`5f7e9145…`) passent de 397 à 240 caractères et restent à 20 de trop, sur une explication
qui n'est que de l'enseignement.

**Le garde-fou, et c'est l'invariant de la passe : une carte qui n'atteint pas 220 sans
perdre sa raison n'est pas illustrée.** Le budget est une contrainte, la raison est un
invariant — jamais l'inverse. Une carte écartée pour ce motif est nommée dans le rapport,
avec son compte de caractères, et reste en texte.

Corollaire assumé : le nombre de cartes illustrées à l'arrivée n'est pas connu à l'avance
et ne se fixe pas comme objectif.

## 3. Les cartes de famille

« Un panneau rond à bord rouge indique : » ne s'illustre pas avec un B1 : on apprendrait le
B1. Huit cartes du premier lot ne portent sur aucun signal précis — six sur une **famille**
de signalisation (forme, fond, liseré, panonceau), deux sur une **règle d'application** qui
n'a pas d'objet à montrer (un panneau de chantier contre un panneau permanent, la portée
d'une prescription dans le temps). Ces deux dernières restent en texte sans discussion.

Règle : **une carte de famille s'illustre en montrant la famille, c'est-à-dire trois
instances côte à côte, ou pas du tout.** `Panneaux.swift` les dessine déjà toutes, donc la
scène ne coûte que son assemblage. Si les trois instances ne tiennent pas lisiblement dans
la bande centrale, la carte reste en texte.

## 4. Les panneaux passent en photographie

Le défaut que la capture #10 nomme se localise précisément : **le contour des panneaux est
relevé sur l'IISR, leur intérieur est fait à l'œil.** Le disque, le triangle, le listel et
la largeur de couronne sont normés ; la flèche du B21b est une aiguille à tête minuscule là
où la vraie est large et trapue, le piéton de l'A13b un bonhomme bâton à tête ronde, les
deux voitures du B3 des blocs sans roue ni pare-brise, et le bleu un cyan plutôt que le bleu
réglementaire. Trois fonctions de `Panneaux.swift` concentrent l'essentiel —
`silhouettePieton`, `silhouetteVoiture`, `silhouetteVelo` — mais les flèches et les teintes
dérivent partout.

**La ligne de partage, et elle vaut au-delà de cette passe : un panneau se photographie, un
marquage et une configuration se dessinent.** Un panneau porte un pictogramme normalisé
qu'aucun redessin à la main n'atteint, et c'est exactement là que le dessin dérive. Un
marquage est de la géométrie — largeur, modulation, inclinaison — que le dessin rend
exactement, et que `marquage-zebra` a d'ailleurs corrigée contre la planche officielle. Une
configuration de voies n'existe sur aucune photographie.

**Faisabilité vérifiée avant d'écrire ceci.** Commons tient une catégorie par numéro de
panneau — `Category:<code> (road sign, France)` — et les seize existent : 76 fichiers pour
le B3, 98 pour l'A13b, 1 451 pour le B14. On y trouve des prises de vue de face où le
panneau est le sujet, certaines en domaine public, les autres en CC BY-SA — la classe de
licence que `images.md` déclare déjà diffusable avec attribution.

**Le tri se fait sur la résolution, pas sur l'existence.** Le meilleur gros plan d'A13b
trouvé fait 480 × 640 ; un bandeau @3x réclame environ 1 100 px de large après recadrage
4:3. C'est ce critère qui décidera combien des seize passent.

Protocole, par panneau :

1. ouvrir `Category:<code> (road sign, France)` ;
2. retenir une photographie de face, panneau sujet principal, **au moins 1 100 px sur le
   grand côté du recadrage 4:3** ;
3. relever licence et auteur ; refuser tout ce qui n'est ni domaine public ni CC ;
4. recadrer en 4:3 centré sur le panneau, sortir @2x et @3x en JPEG qualité 82, comme les
   deux photographies déjà livrées ;
5. **dériver la variante sombre** à exposition réduite — Pillow sous `uv`, `sips` n'ayant
   aucune option de luminosité — pour que la discipline clair/sombre du catalogue tienne. La photo du giratoire, seule photographie livrée
   aujourd'hui, n'en a pas : elle sert le même JPEG dans les deux modes, et c'est une
   exception qu'on ne reconduit pas ;
6. mesurer les niveaux de gris, dans les deux modes, avant commit — **deux écarts, chacun
   d'au moins 25 points** :

   - le **listel** du panneau — sa structure de bord la plus claire, ou la bande
     extérieure à défaut de listel — contre le fond qui **touche** le panneau, à son pire
     endroit. Pas un coin du cadre : un coin peut être en pleine lumière pendant qu'une
     tache collée au panneau est à l'ombre. Échantillonner plusieurs points le long de la
     silhouette, le plus sombre et le plus clair ;
   - le **pictogramme** contre le champ du panneau.

   Deux erreurs de mesure ont été commises avant d'arriver là, et elles valent d'être
   écrites. Mesurer *le centre* contre le fond est un contresens : sur tout un pan de la
   signalisation le centre est le pictogramme, noir par construction — le piéton de l'A13b,
   les voitures du B3, la bicyclette du C113. Mesurer *le champ* contre le fond en est un
   autre : un champ bleu et du feuillage sont deux choses sombres, et entre les deux il y a
   toujours le listel. C'est lui qui porte la forme, et l'IISR l'impose pour cette
   raison — un panneau de danger est « entouré par une bande rouge bordée elle-même par un
   listel blanc » (2e partie, art. 23) ;
7. écrire la ligne dans `images.md` — asset, source, auteur, licence, date de relevé,
   résolution d'origine ;
8. **retirer la scène du tableau de `Tools/Scenes/`**, et la fonction de dessin qu'elle
   employait si plus aucune autre scène ne l'appelle. Sans ce retrait, le prochain
   `./Tools/render-scenes.sh` régénère le dessin, réécrit `Contents.json` vers des PNG et
   **efface la photographie** — aucun test, aucun compteur ne le verrait. Le dépôt porte
   déjà le précédent : ni `panneau-giratoire-vue-conducteur` ni `ligne-jaune-continue` n'a
   gardé sa scène. La preuve du retrait : lancer `./Tools/render-scenes.sh`, puis constater
   par `git status` que les JPEG et le `Contents.json` de l'imageset sont intacts et
   qu'aucun PNG n'y a reparu.

Un panneau sans photographie de résolution suffisante **garde son dessin**. Le rapport le
nomme, avec la meilleure résolution trouvée.

**Le plancher porte sur ce que la carte interroge, pas sur tout ce qui entre dans le cadre.**
Une photographie de rue tient rarement un seul objet : un panonceau de distance, un second
panneau sur le même mât, un signal plus loin. Ces objets-là sont du décor, et un décor dont
l'`alt` ne parle pas et sur lequel aucune option ne repose n'a pas à passer le plancher — il
n'a rien à porter. Ce qui est exigé, c'est que **l'objet de la question** se détache. La
distinction se déclare : le rapport nomme ce qui, dans le cadre, est mesuré et ce qui est
décor, et `images.md` porte le chiffre de tout objet qui reste sous le plancher, décor
compris. Sans cette ligne, « c'était du décor » deviendrait l'excuse de toute mesure ratée.

**Ce qui reste dessiné, et pourquoi ce n'est pas le défaut que `images.md` redoute.** Les
panneaux plantés dans les scènes composites (`carrefour-stop`, `carrefour-route-prioritaire`,
`carrefour-cedez-le-passage`, les scènes de vitesse) restent en CoreGraphics : on ne
compose pas une photographie dans une vue de dessus. Le risque nommé à propos des deux
lignes jaunes — un registre visuel corrélé à une réponse — ne mord pas ici, parce que le
registre suivra le **type de carte** et non la réponse : photographie pour « reconnaître ce
panneau », dessin pour « qui passe en premier ». Savoir qu'on est devant une question de
reconnaissance ne livre aucune bonne réponse. À vérifier tout de même domaine par domaine,
comme le §7 l'impose.

## 5. Les gloses

Une glose ne se met que sur un terme que l'app n'a jamais introduit, et elle nomme **ce que
le candidat verrait**, pas un synonyme. Trois conséquences :

- une glose qui décrit l'objet (« (octogone rouge) », « (triangle pointe en bas) »)
  disparaît avec l'arrivée de l'image — elle est un cas particulier du §1 ;
- une glose qui traduit un terme officiel en argot (« (codes) », « (warning) », « (ambre) »)
  s'inverse ou saute : c'est le terme officiel qui est la cible d'apprentissage ;
- une glose qui redit l'évident cède la place à ce qui manque. `a6fb8c06…` devient
  « En inter-files, la vitesse d'un deux-roues motorisé ne peut excéder : » — le sujet
  entre, l'incise sort.

Les dix-sept cartes glosées sont relues, y compris les neuf hors des lots illustrés. La
règle rejoint le §1 de `Tools/questions.md`.

## 6. Les raisons

Le modèle est celui de la passe 3 et ne change pas : **règle + raison + limite**. Cette
passe ne l'étend pas, elle l'applique là où il manque — c'est-à-dire sur les cartes dont la
bonne réponse contredit l'attente ordinaire.

Critère, appliqué à la main, domaine par domaine : *une carte dont la bonne réponse
surprend porte la raison de la règle, pas seulement son énoncé.* Sur `8e64074d…`, la liste
fermée de R412-1 reste (c'est la règle) et gagne ce qui la rend croyable.

Aucun compteur ne mesure ça et aucun ne le mesurera : « la règle est là mais on ne voit pas
pourquoi » n'a pas de forme qu'une sortie d'outil puisse tester. C'est une relecture, pas
une ligne d'audit.

## 7. La découpe

Onze domaines, un commit chacun, dans l'ordre de densité : Panneaux & marquage (13),
Priorités & intersections (14), Feux (8), Vitesse (5), Croisement & dépassement (5),
Arrêt & stationnement (4), Usagers & partage (4), Tunnels & passages (4),
Distances & freinage (2), Mécanique & environnement (1), Permis & sanctions (1).

Panneaux & marquage passe en premier : il porte quatre des treize captures, les trois
cartes dont l'asset existe déjà mais sert une voisine, et c'est sur lui que le protocole photographique du
§4 se rode — sourcing, recadrage, variante sombre, relevé — avant que les dix autres
domaines en dépendent. Treize des seize panneaux déjà dessinés y sont portés ; les trois
autres (`b14`, `b30`, `b33`) viennent avec le domaine `Vitesse`.

Chaque domaine est une unité complète — image, glose, longueur et raison sur chacune de ses
cartes, en une seule écriture — et se clôt sur :

1. `python3 Tools/audit.py`, comparé à la ligne de base de `CLAUDE.md`, pas à zéro ;
2. `python3 Tools/relire.py --fuites "<domaine>"` **et** la relecture à la main des cartes
   voisines côte à côte, en grepant la liste des bonnes réponses que l'outil déclare ne pas
   avoir testées ;
3. `./Tools/render-scenes.sh` si des scènes ont bougé, puis le relevé de niveaux de gris de
   chaque PNG neuf, avant commit ;
4. la suite des 64 tests, en vérifiant la ligne `✔ Test run with N test(s)` ;
5. un commit.

## 8. Le livrable

- `Valido/Resources/questions.json` — jusqu'à 61 cartes modifiées, aucun `id` touché ;
- `Tools/Scenes/` — les scènes neuves de marquage et de configuration ; `Panneaux.swift`
  ne gagne aucun panneau nouveau ;
- `Valido/Assets.xcassets/Scenes/` — imagesets dessinés (quatre PNG) et photographiques
  (quatre JPEG, clair et sombre en @2x/@3x) ;
- `Tools/images.md` — une ligne par asset neuf ; la section « Photographies » gagne une
  colonne de résolution d'origine et devient la plus fournie du fichier ;
- `Tools/sources.md` — la ligne d'une carte dont l'affirmation change ; un énoncé raccourci
  sans changement d'affirmation ne touche pas au registre ;
- `Tools/questions.md` — la règle de glose (§5) et la règle de famille (§3) ;
- `ValidoTests/BundledContentTests.swift` — seuil d'illustrées relevé à 90 % du nouveau
  livré, comme la convention l'impose ;
- `Tools/audit-2026-09-illustrations.md` — le rapport : compteurs avant/après, cartes écartées du
  §2 avec leur compte de caractères, mesure du §4 et sa décision, ce que l'outillage n'a
  pas vu ;
- `CLAUDE.md` — la ligne de base recomposée, si les compteurs bougent.

### Critères d'acceptation

- Les compteurs qui doivent rester vides le sont : `schema/`, `couverture/`, `source/`,
  `fuite/`, `image/`, `longueur/plus-10`, `forme/backtick-isole`, `notions/non-declaree`,
  `notions/sans-fondation`, `notions/carte-orpheline`.
- Aucune carte illustrée ne viole 70 / 50 / 220 — vérifié deux fois, par `audit.py` et par
  `leBudgetDeHauteurDesQuestionsIllustréesEstTenu`.
- Aucun `id` de `questions.json` n'a changé : diff des seuls `id` vide.
- Chaque asset neuf a sa ligne dans `images.md` et son relevé de niveaux de gris dans le
  rapport, **variante sombre comprise**.
- Chaque photographie retenue porte auteur, licence et résolution d'origine ; aucune n'est
  sous licence non libre.
- Les 64 tests passent, `✔ Test run with N test(s)` lu et reporté.
- Le rapport nomme chaque carte écartée du chantier par le garde-fou du §2.

## 9. Ce qui ne bouge pas

- `QuestionCardView`, `FeedView`, `CardScheduler`, `SchedulerConfig` : aucun code de l'app.
  La seule exception possible est `Tools/Scenes/`, qui n'est pas compilé dans la cible.
- La réponse unique, le mélange des options, l'absence de référence de lettre.
- Les `id` livrés.
- `forme/impersonnel`, `forme/hors-situation` et `forme/definitionnel` : **descripteurs**.
  Leur mouvement est relevé dans le rapport, jamais visé. Un énoncé raccourci par transfert
  ne gagne pas un « vous » pour faire baisser un compteur.
- `expl/paraphrase-litterale` : ne se minimise pas, pour la raison écrite en passe 3.

## 10. Risques

**Le transfert vide une carte de ce qu'elle enseignait.** C'est le risque principal et le
garde-fou du §2 est sa seule protection : en cas de doute, la carte reste en texte. Une
carte illustrée mais amputée est pire que la carte d'aujourd'hui.

**Deux registres cohabitent : photographie sur les cartes de panneau, dessin partout
ailleurs.** Argumenté au §4 — le registre suivra le type de carte, pas la réponse. La
vérification reste due, domaine par domaine : aucune paire de cartes à réponse opposée ne
doit se distinguer par son registre.

**La résolution disponible sur Commons décide du périmètre réel.** Le nombre de panneaux
qui passent en photographie n'est pas connu avant le tri ; celui qui n'en trouve pas garde
son dessin, et l'app portera donc des panneaux des deux sortes. C'est le prix de la
fidélité, et il se constate carte par carte plutôt qu'il ne se décide à l'avance.

**Le mode sombre d'une photographie est dérivé, pas photographié.** Baisser l'exposition
déplace tous les niveaux de gris : le contrôle d'accessibilité se refait sur la variante
sombre, pas seulement sur la claire.

**Une carte de famille illustrée par trois instances enseigne les trois instances.** Le
§3 le borne à la lisibilité ; si les trois signaux deviennent la question, la carte
retourne au texte.

**Soixante-et-un énoncés modifiés est le plus gros mouvement de texte depuis la passe 3.**
La découpe par domaine est ce qui le rend relisible : chaque commit se relit seul, et la
relecture anti-fuite se fait sur le domaine entier, cartes voisines ouvertes — la seule
condition dans laquelle les 44 fuites de la branche précédente ont été trouvées.
