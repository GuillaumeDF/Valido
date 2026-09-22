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
3. **Le registre reste le dessin.** Aucune photographie nouvelle : ni sourcing Commons, ni
   licence à porter, ni conformité au marquage français invérifiable sur vignette. La
   géométrie continue de se relever sur l'IISR, et `Tools/Scenes/Panneaux.swift` reste le
   seul endroit où un panneau se dessine.
4. **Aucun `id` ne se recalcule.** Soixante-et-un énoncés changent ; `id` vaut
   `sha256("valido-v2:" + prompt)[:32]` **au moment de la création**, pas après. La
   progression est indexée dessus.

Reste ouvert, et tranché sur une mesure au §4 : si les seize panneaux déjà dessinés passent
d'un cadrage isolé à un cadrage situé.

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

**Trois cartes se corrigent sans dessiner quoi que ce soit.** `panneau-ab4-stop`,
`panneau-ab7-fin-priorite` et `marquage-zebra` existent dans le catalogue et ne sont posés
sur aucune des cartes qui les décrivent en mots.

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

## 4. Chantier 0 : le registre situé, sous mesure préalable

Deux captures posent la même question — « pourquoi dessiner un panneau approximatif » sur
le B21b isolé, « enfin une vraie illustration » sur la photo du giratoire. L'écart entre
les deux n'est pas dessin contre photo : c'est **isolé contre situé**. La photo montre un
panneau planté sur l'accotement d'une route qu'on voit arriver ; le dessin montre un disque
sur un fond uni.

**Ce cadrage isolé est une décision documentée, pas un oubli.** Le commentaire d'ouverture
de `ScenesPanneaux.swift` la porte et la motive : « le panneau est le sujet, seul sur le
fond neutre. Un décor de route ne survivrait pas au recadrage et entrerait en concurrence
avec le liseré, le listel et le pictogramme, qui sont précisément ce qu'il faut lire. »
L'objection est physique : au verdict, le bandeau tombe à 18 % et seule une bande d'environ
110 unités autour du centre vertical survit.

Elle ne se contourne pas à l'argument. Elle se mesure.

**Étape de mesure, avant toute migration.** Dessiner `scenePanneauEnSituation` et rendre le
seul `panneau-b21b-tout-droit` dans les deux cadrages. Le panneau y occupe la bande
centrale ; le ciel et la chaussée sont les bandes qui se font recadrer. Puis relever, sur
les PNG @2x et @3x, en clair et en sombre :

- la hauteur du panneau en unités, isolé et situé ;
- ce qui reste visible dans la bande de 110 unités, donc au verdict ;
- l'écart de luminance entre le liseré et son fond, dans les deux cadrages — la
  concurrence que le commentaire annonce se lit là, ou nulle part.

**Critère de décision, écrit avant la mesure :** le situé est adopté si le panneau perd au
plus 15 % de sa hauteur et si l'écart de luminance liseré/fond ne perd pas plus de 10
points. Sinon le cadrage isolé est conservé, le commentaire de `ScenesPanneaux.swift` est
confirmé plutôt que réécrit, et les captures qui le visaient reçoivent pour réponse la
mesure.

Si le situé est adopté, il s'applique aux **seize** scènes de panneau existantes
(treize dans `ScenesPanneaux.swift`, trois dans `ScenesCirculation.swift`) autant qu'aux
nouvelles : deux registres coexistants seraient exactement le défaut que
[`Tools/images.md`](../../../Tools/images.md) nomme à propos des deux lignes jaunes — un
registre visuel qui finit corrélé à une réponse. Coût : 64 PNG regénérés, les niveaux de
gris remesurés, seize `alt` réécrits, les lignes de `images.md` mises à jour.

Les quatre scènes de marquage (`marquage-ligne-mixte`, `-fleches-rabattement`, `-zebra`,
`-damier-detresse`) ne sont pas concernées : elles portent déjà une chaussée.

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
cartes illustrables sans dessin, et c'est lui qui valide ou casse le §4 avant que les dix
autres domaines en dépendent.

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
- `Tools/Scenes/` — `scenePanneauEnSituation` si le §4 l'adopte, plus les scènes neuves ;
- `Valido/Assets.xcassets/Scenes/` — les imagesets correspondants, quatre PNG chacun ;
- `Tools/images.md` — une ligne par asset neuf, et les descriptions revues si le §4 passe ;
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
  rapport.
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

**Le registre situé se corrèle à une réponse.** Traité par le tout-ou-rien du §4 : soit les
seize existantes migrent, soit aucune ne migre. En plus, vérifier par domaine qu'aucune
paire de cartes à réponse opposée ne se distingue par son registre visuel.

**Une carte de famille illustrée par trois instances enseigne les trois instances.** Le
§3 le borne à la lisibilité ; si les trois signaux deviennent la question, la carte
retourne au texte.

**Soixante-et-un énoncés modifiés est le plus gros mouvement de texte depuis la passe 3.**
La découpe par domaine est ce qui le rend relisible : chaque commit se relit seul, et la
relecture anti-fuite se fait sur le domaine entier, cartes voisines ouvertes — la seule
condition dans laquelle les 44 fuites de la branche précédente ont été trouvées.
