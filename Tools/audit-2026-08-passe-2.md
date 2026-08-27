# Audit de la banque de questions — seconde passe, août 2026

Suite de [`audit-2026-08.md`](audit-2026-08.md), qui avait porté la banque de 250 à 302
questions — 310 au moment où celle-ci démarre — et laissé quatre points ouverts. Cette passe-ci reprend l'exercice avec deux
exigences que la première n'avait pas : **couvrir le référentiel officiel de l'ETG**, et
**laisser derrière soi de quoi rejouer la vérification** plutôt qu'un rapport à croire.

Résultat : **310 → 448 questions** (255 `code`, 193 `swift`), **8 → 49 illustrées**,
139 questions écrites, une retirée, 42 imagesets créés. Vingt tâches de contenu, quarante
commits, chacune relue par un tiers avant d'être acceptée.

Deux fichiers naissent de cette passe et sont désormais imposés par `audit.py` :
[`sources.md`](sources.md), un registre de fraîcheur ligne par ligne sur les 255 questions
`code`, et [`couverture.md`](couverture.md), la carte du référentiel ETG. Le premier est ce
qui rendra la **prochaine** passe possible en une fraction du temps : elle n'aura pas à
redécouvrir contre quoi chaque question a été vérifiée.

| | avant | après |
|---|---:|---:|
| questions | 310 | **448** |
| dont `code` | 136 | **255** |
| dont `swift` | 174 | **193** |
| questions illustrées | 8 | **49** |
| imagesets | 8 | **51** (49 utilisés, 2 orphelins déclarés) |
| thématiques ETG sans aucune question | 3 | **0** |
| questions `code` sans ligne de fraîcheur | 136 | **0** |

---

## 1. Ce qui a changé de valeur

**Sur treize domaines `code`, deux seulement portaient une valeur périmée** — `Alcool &
stupéfiants` et `Permis & sanctions`, tous deux touchés par la loi n° 2026-798 du 18 août
2026. Partout ailleurs les chiffres étaient justes ; ce qui a été corrigé est de l'ordre du
**fait faux** (une exception niée, une peine attribuée au mauvais article, une durée qui
court du mauvais événement) ou du **chiffre non sourçable retiré**.

Chaque valeur relevée est adossée à un article consolidé de Legifrance et à sa ligne
« Version en vigueur depuis le … », jamais à la loi ni à la liste des censures : le texte
consolidé est le résultat, la loi n'est que l'instruction. Le détail par question, avec la
citation littérale, vit dans [`sources.md`](sources.md).

### 1.1 Valeurs périmées, remplacées, l'ancienne recyclée en distracteur

| question | ancienne valeur | nouvelle | source, version | l'ancienne devient |
|---|---|---|---|---|
| `37fe1af4…ba00` — 0,8 g/L | « jusqu'à 4 500 €, 2 ans, −6 points » | 3 ans et 9 000 €, −6 points | L234-1, en vigueur 20/08/2026 | nommée dans l'explication comme « le barème qu'on lit encore partout », **et** distracteur de `5720fa6a` |
| `749552ac…8ef9` — refus de dépistage | « puni comme la conduite en état d'ivresse » (délit abrogé à cet endroit) | « puni comme la conduite au-delà de 0,8 g/L » — 3 ans, 9 000 €, −6 points | L234-8, en vigueur 20/08/2026 ; le délit d'ivresse manifeste n'est pas supprimé mais **déplacé** au 1° du I de L237-1 | le couple 2 ans / 4 500 € devient distracteur A de `5720fa6a` |
| `37fe1af4…24c9` — verre standard | 0,20 g/L (valeur unique) | fourchette 0,20 à 0,25 g/L | INRS, 10 g d'alcool pur | l'ancienne n'était pas fausse mais **trop étroite** : absorbée dans la fourchette |
| `37fe1af4…0f64` — élimination | « un verre par heure » | « environ une heure et demie » par verre standard | INRS | corrigé, pas recyclé : « un verre par heure » n'a jamais été un état du droit |
| `37fe1af4…3b22` — effets de l'alcool | « dès 0,3 g/L » | « dès le premier verre », liste tenue pour établie à partir de 0,5 g/L | — | **retiré, pas remplacé** : le 0,3 g/L n'a jamais été une valeur en vigueur |
| rodéo motorisé (question neuve `30226200`) | 1 an et 15 000 € | 2 ans et 30 000 € | L236-1, en vigueur 20/08/2026 | l'ancienne peine est le distracteur — c'est ce qu'affiche tout manuel antérieur au 20 août |

**Le recyclage central de la passe** : « 2 ans de prison et 4 500 € d'amende » a eu deux
vies — plafond de l'alcoolémie délictuelle jusqu'au 10 juillet 2025, puis du refus de
dépistage jusqu'au 19 août 2026. C'est très exactement ce qu'un candidat lit encore
aujourd'hui sur `service-public` F2886 (« Vérifié le 11 juillet 2025 »). Il est devenu le
meilleur distracteur de la banque.

### 1.2 Faits faux, corrigés — pas des chiffres, des règles

| question | ce qui était faux | ce qui est écrit maintenant | source, version |
|---|---|---|---|
| `3e99bcc3` — homicide routier | l'énoncé disait « puni **hors circonstance aggravante** de : ». L'art. 221-18 ne crée pas une peine mais une **qualification**, qui n'existe *que* si une des dix circonstances est réunie. Le distracteur « 5 ans / 75 000 € » était donc la bonne réponse de l'énoncé tel qu'écrit — deux réponses défendables, la mauvaise cochée | « retenu dès une seule circonstance comme l'alcool, est puni de : » ; les quatre options ne bougent pas, elles portaient déjà les quatre échelons réels | art. 221-18 à 221-21 du code pénal |
| `37fe1af4…5119` — ligne continue | bonne réponse « **Ne doit jamais** être franchie ni chevauchée », explication « la seule tolérance est le contournement d'un obstacle infranchissable ». R412-19 ne connaît **aucune** exception d'obstacle, et il en connaît une que la question niait | « Interdit le franchissement comme le chevauchement », l'exception (dépasser un cycle, un cyclomobile léger ou un EDPM) nommée dans l'explication avec son article | R412-19, en vigueur 16/01/2022, relevé 2026-08-24 |
| `37fe1af4…a42d` — flèches de rabattement | le distracteur « un rétrécissement de chaussée, une voie en moins » est un **cas réel** (art. 115-3 B de la 7e partie de l'IISR donne deux emplois aux flèches) : seconde réponse défendable | question reprise sur la **portée** de l'obligation, telle que l'article la formule, ce qui couvre les deux cas | IISR 7e partie, art. 115-3 B |
| `f5a12ba7` — dépassement en intersection | l'explication mettait les deux-roues en **sujet** du dépassement. « Tout dépassement autre que celui des véhicules à deux roues est interdit aux intersections » : c'est le deux-roues **doublé** qui fait l'exception. Le candidat repartait avec « en deux-roues je peux doubler aux intersections », qui est faux | « C'est le dépassement d'un deux-roues qui échappe à l'interdiction, pas le dépassement par un deux-roues » | R414-11 |
| `37fe1af4…b160` — invalidation à zéro point | l'explication laissait courir les six mois depuis la notification | L223-5 II les fait courir de la **remise du permis au préfet** ; ajoutés le passage à un an en cas de récidive dans les cinq ans, et l'examen médical. La mention « 48SI » est retirée — désignation administrative que le code ne porte pas | L223-5 II |
| `2d45cedf` — conduite sans permis | l'explication affirmait un « stage obligatoire » | L221-2 II 5° en fait une peine complémentaire **encourue** ; le IV ajouté (amende forfaitaire de 800 €) | L221-2 |
| `defefbae` — refus de priorité | énoncé « en intersection » : le distracteur « 6 points » devenait défendable, R415-11 (piéton) figurant au même chapitre | énoncé « entre deux véhicules », options inchangées | R415-11 |
| `37fe1af4…5f9d79` — voie de bus | explication : « très gênants, à 135 €, **sans dérogation horaire** ». R417-11 I 1° ne dit rien de tel | « seule la nécessité absolue l'excuse, jamais l'absence de bus » | R417-11 |
| `37fe1af4…50b0a` — zone bleue | « la durée gratuite est limitée (souvent 1 h 30) », présenté comme réglementaire. **Aucun texte national ne fixe de durée** | le modèle du disque est national, la durée municipale ; « une heure et demie n'est qu'un usage répandu ». Chiffre **retiré** | R417-3 |
| `37fe1af4…51e0` — Crit'Air | « conditionne l'accès aux ZFE, **surtout en pic de pollution** » : confond la ZFE (régime permanent) et la circulation différenciée | cite R318-2 et dit que le périmètre relève d'un arrêté local | R318-2 I, en vigueur 01/07/2017 |
| `37fe1af4…e5c00` — triangle | la dispense était attribuée à R416-19, qui ne la contient pas | attribuée à l'arrêté du 30 septembre 2008 | arrêté du 30/09/2008 |
| `37fe1af4…32ab7` — le 112 | « joignable depuis n'importe quel téléphone, **même sans carte SIM** ». F33954 dit l'inverse comme condition | « malgré un forfait épuisé ou un abonnement résilié » ; intitulés du 115 et du 119 alignés sur la page | service-public F33954 |
| `bda52045` — feux en tunnel | l'explication ne reposait que sur la physiologie de l'œil ; la ligne de registre affirmait qu'« aucun article du code de la route ne nomme le tunnel » — vrai du code, faux de la **signalisation**, qui est de rang 1 elle aussi | le fondement en première phrase : le C111 prescrit l'allumage, « sans condition d'heure ni d'éclairage de l'ouvrage » | art. 5 de l'arrêté du 24/11/1967, en vigueur 08/09/2025 |
| `c084813f` — passage à niveau | deux options pouvaient être vraies **en même temps** (« cinq secondes avant l'abaissement des barrières » et « vingt secondes avant l'arrivée du train ») | le distracteur devient « cinq secondes avant l'arrivée du train », faux et exclusif | arrêté du 18/03/1991 |
| `5e2dbc04` — position du massage | deux options sur quatre disaient « sur le dos », dont la bonne : jouer « la famille dupliquée » faisait passer d'une chance sur trois à une sur deux | quatre familles distinctes — dorsale, latérale, assise, ventrale | ERC 2021, p. 24 |
| `a6fb8c06` — inter-files | les sanctions avaient été **retirées** par prudence : la tâche 15 ne les avait obtenues qu'en rendu synthétisé | restaurées, relevées mot pour mot le 2026-08-27 : contravention de 4e classe, −3 points, suspension de trois ans au plus | R412-11-3 II à IV, en vigueur 11/01/2025 |
| `5c11020d` — panneau de tunnel | l'explication énumérait les **trois** prescriptions du C111, dont « feux de croisement obligatoires » — qui est la bonne réponse de `bda52045`. Un candidat qui lisait l'une connaissait l'autre d'avance | limitée aux deux prescriptions que la question teste | voir [§7](#7-ce-que-loutillage-ne-voit-pas) |

### 1.3 Ce que la norme a corrigé sur les images

Trois corrections ne portent sur aucune question mais sur ce qui les dessine, et elles
valent d'être connues parce qu'elles disent comment on relève une forme.

- **La « flèche verte » n'existe pas.** Le plan demandait une scène « feu rouge + flèche
  verte à droite, la combinaison que les candidats confondent ». Cette combinaison n'existe
  pas dans la signalisation française : la flèche qui autorise à franchir un rouge est
  **jaune et clignotante** (signal d'anticipation R16, art. 7 de l'arrêté du 24/11/1967), et
  une flèche verte n'existe que sur un tricolore directionnel R14, qui « ne peut en aucun cas
  coexister » avec un R11 sur le même couloir. La scène dessine un R16td, et la question
  corrige la confusion au lieu de l'entériner.
- **Le jaune clignotant d'un carrefour est sur la lampe du milieu**, pas celle du bas — le
  bas est réservé au cas permanent. Et **le signal d'un passage à niveau est un R24 à
  lentille unique**, pas un caisson à trois lampes : un tricolore y aurait été faux.
- **Un panneau de danger porte un listel blanc** autour de sa bande rouge (IISR 2e partie,
  art. 23), et c'est un **triangle équilatéral** (art. 21). La primitive n'en dessinait
  qu'un bord et ses proportions avaient été choisies à l'œil ; les deux sont corrigées, ce
  qui a rejailli sur sept scènes existantes.

---

## 2. Signalements non corrigés

### 2.1 Les quatre points ouverts d'août 2026 — leur sort

| point d'août | sort |
|---|---|
| **Loi n° 2026-798 du 18 août 2026** — « une passe dédiée sur rétention du permis et rodéos est à prévoir » | **Fermé.** Les articles visés ont été ouverts un par un en version consolidée : L224-1, L224-2, L224-16, L233-1, L234-1, L234-8, L235-1, L236-1, L236-2, L237-1. La méthode retenue — juger sur la ligne « Version en vigueur depuis le … » de l'article, jamais sur la loi ni sur la liste des censures — a établi l'abrogation du II de L234-1 et la création du chapitre 7 (L237-1 à L237-4) sans jamais lire l'article 30. Cinq questions neuves en sortent. **Reste ouvert** : le dispositif de la décision n° 2026-915 DC n'a pas été lu (il ne fonde rien) ; et `L221-2` comme `L224-1` portent une **date de fin au 01/01/2029** — une version future existe déjà, à regarder à la prochaine passe. |
| **ZFE et Crit'Air** — « la page officielle a un an, une suppression a été votée » | **Fermé.** `L2213-4-1` du CGCT porte « Version en vigueur depuis le 25 août 2021 », relevé deux fois par deux routes dont son URL datée au 2026-08-25 : l'article n'a pas bougé, aucune mention « (Abrogé) ». La suppression votée le 14 avril 2026 a été **censurée** le 21 mai 2026 (décision n° 2026-903 DC, cavalier législatif). Les ZFE sont en vigueur, la vignette reste l'instrument de leur contrôle. La question Crit'Air survit — elle porte sur le **classement**, de rang 1 par R318-2 — et son explication est corrigée. **Aucune question n'est écrite sur ce qui est interdit dans telle agglomération** : le périmètre relève d'un arrêté local, hors liste blanche. |
| **Périphérique parisien** — R413-3 permet 70, la Ville a abaissé à 50 | **Reste ouvert, et c'est documenté.** Aucune source de la liste blanche ne donne la vitesse du périphérique : la seule page `service-public` qui en parle (A18035, voie de covoiturage) ne mentionne aucune vitesse. Le relèvement à 70 en agglomération n'est attesté qu'indirectement, par un tableau de la Sécurité routière **de 2008**. Aucune question créée, ni en passe 1 ni en passe 2. Ce qu'il faudrait pour trancher : l'arrêté municipal, qui est par nature hors liste blanche — donc le point restera ouvert tant que la liste ne s'élargit pas aux arrêtés locaux, ce qui serait une décision de dépôt. |
| **Contradiction des 9 points** — `service-public` affiche « drogue + alcool = 9 points » alors que R223-2 plafonne le cumul simultané à 8 | **Reste ouvert, sans conséquence.** R223-2 a été relu mot pour mot en passe 2 : le plafond de 8 est confirmé au rang 1. La contradiction est celle de la page officielle, pas de la banque. **Aucune question ne s'appuie sur 9 points**, et aucune n'a été écrite sur le cumul de retraits. À trancher le jour où une question voudrait porter ce chiffre : dans ce cas c'est R223-2 qui fait foi. |

### 2.2 Les points ouverts que cette passe ajoute

Ils suivent tous la même règle : **un chiffre incertain laissé en place et signalé est moins
grave qu'un chiffre faux présenté comme sûr.** Aucun n'est affirmé dans une option ni dans
une explication.

- **L'intervalle propre au tunnel.** Aucune source de rang 1 ne le chiffre pour un véhicule
  léger. La question qui subsiste porte sur le **régime** (l'autorité de police peut
  l'allonger), pas sur une valeur. Les 50 m du II de R412-12 existent bien mais valent hors
  agglomération partout — donc pas une valeur propre au tunnel ; ils servent de distracteur.
- **Les sanctions du dépassement trop serré d'un cycliste** (forfait de 135 €) et la
  **contravention de première classe du piéton** qui ne prend pas le passage : ni l'une ni
  l'autre relevée au rang 1, retirées des explications.
- **Le décret d'expérimentation de l'inter-files de 2021.** Deux numéros différents obtenus
  (2021-993 et 2021-1028), non recoupés. Absent du contenu ; le « onze départements » du
  distracteur n'existe qu'en distracteur, où sa fausseté actuelle suffit.
- **Les 200 mètres du triangle de présignalisation** que donne `securite-routiere.gouv.fr` :
  délibérément laissés dehors, ce domaine étant de rang 2 et l'article n'en disant rien.
- **Les 3 à 5 mètres du sas cycliste**, lisibles mot pour mot dans l'IISR. Le Cerema est
  hors liste blanche : le chiffre sert à **dessiner** et est cité dans `images.md`, jamais
  dans un énoncé, une explication ou une colonne `source`.
- **Les numéros d'article R413-3, R413-19 et le décret du 6 décembre 2023** cités dans trois
  explications : leurs *conséquences* sont confirmées deux fois chacune, leurs *numéros*
  viennent de la passe d'août et n'ont pas été relus. Signalés dans le registre.
- **L236-2 : lisible, mais rien n'y est écrit.** Son 2° renvoie aux « faits mentionnés au II
  de L. 236-1 », or depuis le 20/08/2026 ce II est l'aggravation « en réunion ». Le renvoi
  paraît décalé par la renumérotation ; on ne bâtit pas un QCM sur un renvoi dont on ignore
  s'il est encore lu comme avant.
- **`37fe1af4…e464` — « quelle vitesse maximale sur autoroute ? »** Le distracteur `100 km/h`
  est *partiellement* vrai (sur une section limitée à 110, la réponse est 100). Laissé tel
  quel : les deux sources formulent la règle exactement comme l'énoncé, et le cas des 100 a
  sa question en propre. Signalé plutôt que corrigé.
- **`d50cd498` — le distracteur « reculez pour repasser derrière le bras d'entrée »**
  dégagerait lui aussi la voie ferrée en principe. Il reste faux (manœuvre à l'aveugle, et
  il nie le caractère cassable de la lisse) ; la supériorité d'« avancer » ne vient pas d'un
  texte — R422-3 ne prescrit aucun sens — mais d'une doctrine de conduite enseignée. Signalé
  plutôt que retouché.
- **Le distracteur « feux de détresse » atteint six occurrences** sur la banque `code`,
  contre deux bonnes réponses. La règle 7 du §1 de `questions.md` vise ce motif — elle avait
  été écrite pour « Klaxonner », qui était à sept. **À surveiller, et le premier à traiter
  d'une passe suivante.**

---

## 3. Couverture du référentiel

La carte est [`couverture.md`](couverture.md), et `audit.py` refuse désormais tout `topic`
`code` qui n'y figure pas.

**Point de départ** : le référentiel officiel annonce « onze thèmes à connaître » et sa page
n'en liste que **dix** — l'incohérence est celle du site, pas d'une erreur de lecture, et le
onzième (« Gestes de premier secours ») a été recoupé sur un second document officiel. La
page est rendue en JavaScript : elle se lit par sa route `?_format=json`, jamais par un
`WebFetch` direct.

**Trois thématiques n'avaient aucune question.** Elles en ont maintenant 48 :

| thématique | topic créé | volume |
|---|---|---:|
| Croisement et dépassement | `Croisement & dépassement` | 15 |
| Tunnels et passages à niveau | `Tunnels & passages à niveau` | 15 |
| Usagers, partage de l'espace public | `Usagers & partage de la route` | 18 |

**Aucune thématique ne reste `absent`.** Une seule reste `à compléter`, et le verdict est
délibéré : **« Économie et écoconduite »**. Son topic a doublé (10 → 20) mais **six**
questions seulement portent la thématique — éco-conduite, frein moteur en descente, galerie
de toit et traînée, pression des pneus, classement Crit'Air, huile et batterie usagées. Les
quatorze autres sont des équipements, du chargement et de la retenue des enfants, logés là
faute de thématique officielle qui les accueille. C'est le seul trou de couverture qui reste,
et il est chiffrable : consommation et vitesse, arrêt du moteur, entretien et rejets, choix
du rapport — tous sourçables sur `ecologie.gouv.fr`, qui est dans la liste blanche.

**Un défaut de structure, à connaître.** Le topic `Feux` sert **deux** thématiques
(« Signalisation » et « Visibilité et éclairage ») et rien dans `questions.json` ne les
distingue : le partage — huit questions de signaux, onze d'éclairage — n'est écrit que dans
`couverture.md`. Le rendre opposable demanderait de scinder le topic (`Feux` / `Éclairage`) ;
l'opération est sans risque, le `topic` n'entrant pas dans le calcul de l'`id`, mais c'est du
contenu et non de la documentation.

---

## 4. Illustrations

C'est le mouvement le plus visible de la passe : **8 → 49 questions illustrées**, 42
imagesets créés, un retiré. Le renderer a été découpé en `Tools/Scenes/` sans changer un
pixel (24 PNG identiques octet pour octet après découpage), et un panneau se dessine
désormais **une fois**, dans `Tools/Scenes/Panneaux.swift`, pour toutes les scènes qui le
contiennent.

### 4.1 Les 42 assets créés

`autoroute-voie-de-gauche` · `carrefour-feu-en-panne` · `carrefour-tramway` ·
`croisement-en-pente` · `feu-jaune-clignotant` · `feu-fleche-clignotante` ·
`passage-niveau-feu-rouge-clignotant` · `marquage-ligne-mixte` ·
`marquage-fleches-rabattement` · `marquage-zebra` · `marquage-damier-detresse` ·
`stationnement-ligne-jaune-continue` · `stationnement-ligne-jaune-discontinue` ·
`stationnement-en-epi` · `chargement-depassement-arriere` · `angle-mort-poids-lourd` ·
`depassement-cycliste-distance` · `sas-cycliste-feu` · `bus-quittant-arret` ·
`depassement-ligne-discontinue` · `depassement-sommet-de-cote` ·
`croisement-chaussee-etroite` · `rabattement-apres-depassement` · `tunnel-arret-urgence` ·
`passage-a-niveau-immobilise` · `passage-a-niveau-balises` — plus **seize panneaux**
(`panneau-a1a-virage`, `-a13b-passage-pietons`, `-a14-panonceau`, `-ab4-stop`,
`-ab7-fin-priorite`, `-b1-sens-interdit`, `-b3-interdiction-depasser`, `-b6a1-…`,
`-b6d-…`, `-b14-limitation`, `-b21b-tout-droit`, `-b30-zone-30`, `-b31-fin-interdictions`,
`-b33-fin-limitation`, `-c1a-parking`, `-c113-voie-velo`).

Un asset retiré de la banque : la photo `ligne-jaune-continue` a cédé la place à un dessin,
plus lisible sur la bande centrale qui survit au rétrécissement du bandeau. Elle reste dans
`images.md` et sur le disque, déclarée orpheline, comme `giratoire-sortie-clignotant`.

### 4.2 Les questions qu'on a renoncé à illustrer, et pourquoi

**C'est la partie la plus utile de ce rapport pour une passe suivante.** Elle n'est pas une
liste de regrets : chaque ligne dit soit un motif de principe qui vaudra encore, soit un
obstacle levable, et le second cas est signalé comme tel.

#### Les motifs de principe — ils ne changeront pas

| motif | ce qu'il élimine, exemples |
|---|---|
| **Le test du §7 : l'image doit porter l'énoncé.** Si une option ne renvoie à rien que seule l'image apporte, l'image est décorative — même quand un brief la nomme | une scène a été dessinée puis **retirée par la revue** parce que « votre clignotant droit doit s'allumer : » suivi de quatre options de timing ne demande aucun regard. Les énoncés qui tiennent sont déictiques : « Ce panneau », « Ces feux », « À ce carrefour » |
| **La réponse reposerait sur la teinte seule** | « Un panneau rond à bord rouge indique : » et son miroir bleu : les deux sont ronds, seule la couleur les sépare. Illustrer rendrait la question injouable à un daltonien. Idem pour « un panneau de chantier contredit un panneau permanent », qui supposerait de faire distinguer un fond jaune d'un fond blanc |
| **Un barème ne se dessine pas** | tous les retraits de points, tous les montants d'amende, la qualification contravention/délit, le chevauchement à 1 point |
| **L'axe longitudinal du 4:3 est compressé d'un facteur ~20** par rapport au transversal (mesuré : un trait de rive T4 vaut 39 m, soit 870 unités dans un cadre haut de 300 ; la bande qui survit au recadrage n'en laisse que ~110) | **toute question dont la réponse est une distance** : intervalle de sécurité, distance en tunnel, triangle de présignalisation à 30 m, densité d'une file saturée, véhicule arrivant en face pendant un dépassement |
| **L'absence ne se dessine pas** | « à un rond-point sans panneau » : l'image devrait montrer qu'un panneau n'est pas là |
| **Une règle générale n'est pas une situation** | hiérarchie agent / feu / panneau, « le clignotant doit être utilisé », toutes les questions de définition |
| **Deux images quasi identiques désapprennent** | la paire ligne continue / ligne discontinue axiale, les trois schémas de chaussée (double sens, terre-plein, deux voies même sens), la lampe du milieu contre la lampe du bas d'un jaune clignotant |
| **Un pictogramme ne s'invente pas** quand la norme n'est pas relevée | le panonceau M12 (cyclistes), la croix de Saint-André, les barrières d'un passage à niveau |
| **Une image ne doit pas choisir la réponse** | ligne de rive : ce qu'elle borde dépend de la route, dessiner l'une des deux routes donnerait la réponse. Sas cycliste : la voiture du candidat a été retirée de la scène parce que **toute** position correcte donnait la réponse |

#### Les renoncements levables — ce qu'une passe suivante peut reprendre

| question | ce qui manque, et rien d'autre |
|---|---|
| `07b430cc` (convoi large) et `99824d4d` (trois voies) | **les deux meilleures candidates de toute la liste.** Un gabarit hors norme et un nombre de voies sont des faits purement visuels. Elles n'ont pas été illustrées faute de budget de scènes dans leur tâche, **pas faute de matière** |
| `700316a2` (sas cycliste, question de règle) | il manquait une primitive de passage piéton et de ligne d'arrêt double au moment du choix. **Les deux existent maintenant** (`sas-cycliste-feu` les a créées) |
| `b433eefe` (panonceau M12) | la planche officielle du M12a/M12b n'avait pas été relevée. Elle est **relevable** : l'IISR s'extrait en image, planche par planche, avec `pypdf[image]` — la marche à suivre est dans `images.md` |
| la croix de Saint-André et les barrières | même cas : il faut relever la partie « signalisation des passages à niveau » de l'IISR, ce qui n'a pas été fait |
| `3a06288b` (panonceau de longueur de tunnel) | un C111 dessiné conviendrait, **mais avec un panonceau vierge** — un panonceau réel porte un chiffre, et la question dit précisément qu'il ne faut pas l'affirmer. Un panonceau vierge n'existe pas sur la route : c'est un arbitrage éditorial, pas une impossibilité |
| zone de rencontre (20 km/h) | illustrable **si l'énoncé devient déictique** : « Dans cette zone, la vitesse est limitée à : », avec un B52. Aujourd'hui l'énoncé nomme la zone, donc l'image serait redondante |
| `e0f68dd1` (sortie de parking), `stationnement-place-reservee` | écartées parce que la question tient sans l'image. Le §7 est un critère, pas une préférence : elles ne reviendront que si l'angle de l'énoncé change |

### 4.3 Deux acquis de méthode sur les images

- **Le §10, ou : ce qui est en haut ou en bas de la scène disparaît.** Le bandeau tombe à
  18 % de la carte après réponse et recadre en `.fill`. Une scène a placé le panneau porteur
  du prédicat juridique de sa question à y≈38-90 sur 300 : la pente survivait au recadrage,
  le panneau non. **Tout élément dont dépend la réponse va au centre vertical.**
- **La couleur, ça se mesure.** Une scène de feux respectait la règle en intention et
  l'inversait en fait : la lampe **allumée** mesurait 96 en niveaux de gris, les **éteintes**
  119 — un daltonien y lisait « la lampe du haut est morte ». Le même relevé a montré qu'une
  lampe verte allumée (luminance 121) serait **indiscernable** d'une lentille éteinte (119).
  Regarder l'image ne suffit pas : un œil qui sait quelle réponse est attendue voit ce qu'il
  cherche.

---

## 5. Énoncés `swift` réécrits

Les 174 questions `swift` ont été relues **une par une, en une seule lecture**, contre trois
cas et eux seuls :

1. **irrépondable** sans connaître déjà la réponse ;
2. **la bonne réponse dépend d'un contexte que l'énoncé ne donne pas** — deux options
   défendables selon une hypothèse non dite ;
3. **l'énoncé nomme une API sans dire quelle dimension** est demandée (rôle, comportement,
   disponibilité, coût ?).

Le format « fragment finissant par `:` » n'a jamais compté comme défaut : 171 des 174
l'emploient. **Deux** énoncés seulement ont été retenus au critère strict, très en dessous
des 20 à 40 attendus — et c'est le résultat qui compte, pas la fourchette. Treize questions
ont finalement été retouchées : les deux entrées, plus onze défauts vus en chemin et validés
à part.

| question | cas ou défaut | ce qui a changé |
|---|---|---|
| `37fe1af4…2f26` — `enumerated()` | **cas 2** : l'énoncé ne disait pas de quelle composante du tuple il parlait, et « un couple (clé, valeur) » est vrai de la seconde sur un `Dictionary` | énoncé : « Dans le tuple rendu par `enumerated()`, la première composante est : ». Options inchangées ; la seule qui bascule est celle du dictionnaire |
| `2118d638` — abonnement actif | **cas 2** : l'énoncé ne disait pas **qui lit**, et « le reçu validé côté serveur Apple » décrit une architecture réelle | énoncé : « **Dans l'app**, pour savoir si un abonnement est actif, on lit : ». Deux mots, comme le précédent « Caches contre tmp » que le dépôt avait déjà tranché ainsi |
| `ca3d16b4` — `@Suite` | distracteur **vrai** : `TimeLimitTrait` est `isRecursive`, donc un `.timeLimit` posé sur une suite descend bien sur tous ses tests | distracteur remplacé par « leur imposer une relance automatique après échec », qui n'existe pas en Swift Testing. Le fait retiré est **recyclé en leçon** dans l'explication |
| `37fe1af4…f93e` — mise en place d'un projet | distracteur désignant une **technologie morte** : le bitcode n'a plus de case à cocher depuis Xcode 14 | « activer la couverture de code sur le schéma de test », vraie case, mesure neutre. Le défaut « 3 distracteurs du même côté » est **atténué, pas éteint** — voir §9 |
| `54ba9d20` — Privacy Manifest | **doublon de fond** avec `37fe1af4…ca6b` | différencié, pas supprimé : la `costaud` change d'angle, la `moyen` n'est pas touchée |
| `37fe1af4…f000` — `@escaping` | **paire d'inverses** : « doit être appelée avant la fin de la fonction » est la définition mot à mot de *non*-escaping, le tirage tombait à 50 % | « est allouée sur la pile plutôt que sur le tas », faux et confusion réelle, longueur identique au caractère près |
| `37fe1af4…4964` — Billing Grace Period | **paire d'inverses** (« suspend l'abonnement » contre « garde l'abonné actif »), et explication qui **paraphrasait** la bonne réponse | distracteur remplacé par *Extend a Subscription Renewal Date*, mécanisme réel et distinct ; explication réécrite pour dire le *pourquoi* ; un distracteur raccourci, écart −10 → −3 |
| `37fe1af4…fbfb` — `guard` contre `if let` | **forme isolée** : quatre ouvertures non alignées | les **trois distracteurs** viennent à la bonne réponse, jamais l'inverse. Écart final −3 |
| `37fe1af4…d57bf3` — `MainActorMessage` | **fuite** que le détecteur à 4 caractères ne voit pas, et type non situé | énoncé : « Dans `NotificationCenter` (iOS 26), un `MainActorMessage` sert à : » |
| `37fe1af4…544d1` — travail async lié au cycle de vie d'une vue | `topic` mal placé (`Langage` pour une question entièrement SwiftUI) ; puis écart de longueur à **−13**, invisible d'`audit.py` | `topic` → `SwiftUI` ; puis distracteur raccourci de 56 à 46, écart −13 → −3 |
| `37fe1af4…f3b2` — sonder la connectivité | distracteur énonçant une **exigence de revue App Store qui n'existe pas** — invérifiable par le candidat | « n'a de sens que pour les transferts en arrière-plan », faux pour une raison qu'on peut apprendre. Et la bonne option perd son second `:`, l'énoncé en portant déjà un |
| `37fe1af4…bcfc3` — Combine | **seul énoncé de la banque à dater par un adverbe** : « Aujourd'hui, Combine garde l'avantage : » | « **En iOS 26**, Combine garde l'avantage : » — la version de plateforme, comme les autres énoncés datés de la banque |
| `37fe1af4…526f20a` (retirée) — bibliothèque *Diagnostics* | **retirée.** La réponse se déduit du nom, un second distracteur ouvrait sur les mêmes trois mots, et c'était le seul contenu **non-Apple** de la banque `swift` | choix éditorial, pas contrainte : le seuil de volume était tenu à 23 questions près. `ProgressSnapshot.stats` étant indexé par `id`, une clé orpheline y est inerte |

**Vingt questions `swift` neuves** ont par ailleurs couvert ce qu'iOS 26, Swift 6.2 et
Xcode 26 ont ajouté, en visant les cinq trous mesurés : SwiftData (le thème `Données` passe
de 7 à 12), Liquid Glass, accessibilité, navigation, `Clock` / `Task.sleep` /
`MainActor.assumeIsolated`. Elles portent toutes l'URL `developer.apple.com` contre laquelle
elles ont été vérifiées — d'où le **troisième régime** de `sourceURL` (149 `notion.so`, 24
sans clé, 20 `developer.apple.com`), désormais documenté au §6 de
[`questions.md`](questions.md) avec la règle pour la suite : **une question `swift` neuve
porte l'URL de sa documentation.** C'est la seule piste de fraîcheur de ce demi-fichier.

Note d'outil : les pages `developer.apple.com` sont montées en JavaScript et un `WebFetch`
en revient sans la prose. La route qui répond est
`https://developer.apple.com/tutorials/data/documentation/<chemin>.json`, en `curl`, et elle
sert le texte mot pour mot.

---

## 6. Nouvelle ligne de base d'`audit.py`

Mesurée le **2026-08-27**, sur 448 questions. `audit.py` **sort toujours 0** : c'est le
rapport qu'on lit, pas le code de retour.

```
== 448 questions ==
lettre/reference             1
forme/markdown               1
forme/seule-ponctuee        14
longueur/plus-longue        97
expl/paraphrase-litterale   18

code:  bonne réponse plus longue que la moyenne des distracteurs dans 126/255 cas; écart moyen +0.6 car.
swift: bonne réponse plus longue que la moyenne des distracteurs dans 120/193 cas; écart moyen +1.6 car.
```

**Toutes les autres catégories sont vides** : `schema/`, `couverture/`, `source/`, `fuite/`,
`image/`, `longueur/plus-10`, `forme/backtick-isole`, `forme/meta-option`, `lettre/…` autres,
`forme/ouverture-isolee`, `forme/seule-detaillee`, `longueur/registre`,
`expl/paraphrase-lexicale`, `expl/trop-courte`.

Comparaison avec la ligne de base d'entrée de passe, **remesurée sur l'état de `main`**
(310 questions) plutôt que reprise de mémoire :

| compteur | avant (310) | après (448) | lecture |
|---|---:|---:|---|
| `lettre/reference` | 1 | **1** | faux positif connu : une lettre **ancrée par l'énoncé** (« Le « D » de SOLID ») est légitime |
| `forme/markdown` | 1 | **1** | faux positif connu : `` `/** */` `` est dans un code span, et `QuestionCardView.styled()` parse en `.inlineOnlyPreservingWhitespace` |
| `forme/seule-ponctuee` | 14 | **14** | informatif, et **jamais cumulé avec la longueur** — c'est le cumul qui est exploitable, pas la virgule |
| `longueur/plus-longue` | 98 | **97** | informatif (+1 à +10 caractères). Le seuil dur est `longueur/plus-10`, à zéro |
| `expl/paraphrase-litterale` | 23 | **18** | à relire à l'œil : une explication qui reprend un chiffre est normale, celle qui n'ajoute rien ne l'est pas |

Et les deux lignes de synthèse, qui sont les seules à mesurer un **taux** :

| | avant (310) | après (448) |
|---|---|---|
| `code` — bonne réponse plus longue que la moyenne des distracteurs | 77/136 (**57 %**), écart moyen **+1,4** car. | 126/255 (**49 %**), écart moyen **+0,6** car. |
| `swift` — idem | 111/174 (**64 %**), écart moyen **+1,8** car. | 120/193 (**62 %**), écart moyen **+1,6** car. |

**Le compteur qui a le plus bougé, et pourquoi** : `expl/paraphrase-litterale` baisse de 23
à 18 **alors que la banque a grossi de 45 %**. Ce n'est pas un effet de dilution — chaque
domaine a réécrit les explications qui ne faisaient que redire la bonne réponse. Même
lecture sur le `code` : le taux de bonnes réponses plus longues que la moyenne passe de
57 % à 49 %, sur une population qui a presque doublé.

**Une lecture à ne pas faire.** `forme/backtick-isole` à zéro est **structurel et non
conquis** : le détecteur ne mord que si au moins une option de la question porte un backtick
(`audit.py:173`). Sur les 80 options écrites par la dernière tâche `swift`, **aucune** n'en
porte — le compteur ne pouvait pas se déclencher. Un zéro ne prouve quelque chose que si le
détecteur avait une chance de mordre.

---

## 7. Ce que l'outillage ne voit pas

**La partie de ce rapport qui servira le plus.** Chaque angle mort a été découvert par un
relecteur qui a **mesuré** au lieu de lire, et chacun est reproductible : telle ligne fait
telle chose, donc tel défaut passe. Aucun n'a été corrigé pendant la passe — la ligne de base
d'`audit.py` sert de référence à vingt tâches, et la faire bouger en cours de route aurait
invalidé toutes les comparaisons.

| # | ce que l'outil fait | ce qui passe donc |
|---|---|---|
| 1 | **`audit.py:216-221` date le RELEVÉ, jamais la SOURCE.** `source/releve-perime` compare la colonne « relevé le » à aujourd'hui | un document de 2015 relevé hier passe pour frais. Une source vieillissante ne se signale pas d'elle-même |
| 2 | **Aucun contrôle inter-questions.** `schema/doublon-option` compare les quatre options **d'une même** question | deux questions qui portent la même règle, ou dont l'une **fuite** vers l'autre. Cas vivant, corrigé par cette tâche : l'explication de `5c11020d` énumérait « feux de croisement obligatoires », qui est la bonne réponse de `bda52045` |
| 3 | **`audit.py:167` intersecte des jetons entiers** (`fuite/mot-enonce`) | toutes les fuites **par racine** : `annulée` / `annulation`, `Reprendre` / `reprise` ne s'apparient pas |
| 4 | **Le détecteur est français, et lexical** | les fuites **par traduction** : « fonction longue » → `-warn-long-function-bodies`, « traités sur le fil principal » → `MainActorMessage`, « réglage courant » → « valeur » |
| 5 | **`audit.py:176-179` exige exactement DEUX premiers mots distincts** (`forme/ouverture-isolee`) | une bonne réponse seule de son article parmi **trois** ouvertures différentes ; et **quatre** options ouvrant toutes sur le même mot |
| 6 | **`audit.py:173` ne mord que si une option porte un backtick** (`forme/backtick-isole`) | un lot entier de questions sans code span laisse le compteur à zéro sans qu'il ait rien contrôlé |
| 7 | **`audit.py:157-161` ne contrôle l'équilibre de longueur que DANS UN SENS** | une bonne réponse nettement **plus courte** que ses distracteurs est un indice aussi lisible : le candidat apprend que la réponse est la brève. Un domaine est monté à **29 %** de réponses les plus courtes contre 9 % de référence, sans qu'aucun compteur bouge. Le piège est vicieux parce qu'on y tombe **en corrigeant** dans l'autre sens — on allonge les distracteurs au lieu de raccourcir la bonne réponse |
| 8 | **`audit.py:29` (`LETTER`) attrape une majuscule isolée entre séparateurs** | **faux positif systématique** dès qu'une explication cite une sous-section d'article au style de la maison (`118-2, A, a)`). Il a fallu écrire `118-2.A.a)`, incohérent avec le reste du dépôt — jusqu'à ce qu'un relecteur constate que l'IISR **elle-même** écrit « article 118-2.B », donc que la notation pointée est la graphie de la source et non un contournement |

**Deux défauts que rien ne peut mécaniser**, et qui demandent donc un relevé à la main à
chaque passe :

- **Trois distracteurs du même côté d'une opposition binaire.** Trois options qui affirment
  la priorité et une seule qui cède : la bonne réponse se désigne par sa position logique,
  sans rien connaître. Deux questions `facile` en sont mortes.
- **La règle 7 comptée sur toute la banque.** Un distracteur récurrent s'apprend comme un
  motif. « Klaxonner » était à sept occurrences en passe 1 ; « feux de détresse » est à six
  aujourd'hui (§2.2).

**Ce qu'une passe suivante devrait faire d'`audit.py`**, dans l'ordre du rapport
coût/bénéfice : (1) le contrôle d'écart inverse — dix lignes, il attrape le défaut le plus
répandu de cette liste ; (2) un contrôle inter-questions de similarité d'options, qui aurait
attrapé le cas `5c11020d` ; (3) exclure du motif `LETTER` les lettres précédées d'un chiffre
et d'un tiret, qui éteindrait le faux positif 8. **À faire hors passe de contenu**, jamais
pendant : la ligne de base est un instrument de comparaison.

---

## 8. Ce qui change dans les tests

`ValidoTests/BundledContentTests.swift` — **et rien d'autre dans le code**. Aucune vue,
aucun view model, aucun scheduler, aucune persistance n'a bougé de toute la passe.

### 8.1 Les seuils relevés

| seuil | avant | après | base |
|---|---:|---:|---|
| `leContenuLivréEstValide` | ≥ 295 | **≥ 425** | 95 % des 448 livrées |
| `lesDeuxMatièresSontPrésentes` — `code` | ≥ 125 | **≥ 242** | 95 % des 255 |
| `lesDeuxMatièresSontPrésentes` — `swift` | ≥ 170 | **≥ 183** | 95 % des 193 |

### 8.2 Les deux tests ajoutés

**`leBudgetDeHauteurDesQuestionsIllustréesEstTenu`** — énoncé ≤ 70, chaque option ≤ 50,
explication ≤ 220 caractères, sur les seules questions illustrées. Ces trois chiffres
vivaient au §7 de `questions.md` **en prose**, et la passe a découvert que **quatre des huit
questions illustrées violaient déjà le budget qu'elles étaient censées décrire**. Le budget
n'était donc pas un ajout, c'était une correction. Les mêmes seuils sont doublés dans
`audit.py`, qui les attrape avant le build.

**`laBanqueGardeSonVolumeIllustré`** — ≥ 44 questions illustrées, soit 90 % des 49 livrées.
Le seuil est plus bas que les 95 % des seuils de volume, parce qu'une question illustrée se
retire plus facilement qu'elle ne s'écrit. Ce test comble un trou net : les trois tests
d'image antérieurs vérifient chacun ce qu'une illustration **doit respecter** (asset qui se
résout, `alt` d'au moins 40 caractères, budget de hauteur), **aucun ne vérifiait qu'il en
reste une seule**. Le nombre pouvait retomber à zéro sans qu'un test bronche.

### 8.3 L'état

`✔ Test run with 64 tests` sur `iPhone 17 Pro`, Xcode 26.3, aucun échec. Un seul point de
méthode, et il a coûté du temps à plusieurs tâches : **le simulateur se démarre à la main**
(`DEVELOPER_DIR=… xcrun simctl boot 'iPhone 17 Pro'`) avant `xcodebuild`, sans quoi
`Application failed preflight checks` / `Busy` se lit comme une régression alors que ce n'en
est pas une. Et on ne juge que la ligne `✔ Test run with N test(s)` : un
`** TEST SUCCEEDED **` sans elle ne prouve rien.

---

## 9. Les trente constats mineurs parqués — le tri

Vingt tâches ont laissé derrière elles trente constats délibérément non corrigés, tracés un
par un dans le ledger de la passe. Ils sont triés ici en trois piles, parce qu'une revue de
branche n'a pas besoin de trente lignes, elle a besoin de savoir **où regarder d'abord**.

### 9.1 Ce qui ne devrait pas bloquer une fusion, mais se corrige en une passe courte (contenu)

Aucun de ces constats ne rend une question fausse ; chacun la fait **travailler moins qu'elle
ne pourrait**.

| constat | pourquoi il attend |
|---|---|
| **« Feux de détresse » à six occurrences en distracteur** sur la banque `code`, contre deux bonnes réponses | c'est le motif exact que la règle 7 vise, et il est à un cran du « Klaxonner » à sept qui avait déclenché sa rédaction. **Le premier à traiter** : il se corrige en diversifiant six distracteurs, sans toucher à une bonne réponse |
| `acfa94cd` — rupture de motif grammatical (seule bonne réponse en « vous êtes… » contre trois sujets nominaux) **et** deux seuils inventés au lieu de confusions courantes | deux défauts de §2 dans la même carte |
| `5a4e87df` — bonne réponse déductible du nom de l'API (`Inline`Array → « sans allocation séparée ») | c'est le motif même qui a fait retirer la question WeTransfer. Le corriger demande de changer l'angle de la carte, pas une option |
| `2f278647` — distracteur partiellement vrai, et deux options ouvrant sur « la racine » ; `62f082eb` — distracteur le plus discutable du lot | les deux restent faux ; ils sont sur la frontière de la règle 2 |
| `37fe1af4…f93e` — le « 3 contre 1 » d'une opposition binaire est **atténué, pas éteint** | reconnu comme tel par l'implémenteur au moment de le corriger |
| dissonance « deux verres » contre « deux ou trois verres » entre deux explications du domaine alcool | incohérence interne visible d'un lecteur attentif |
| `eac980f5` — question dense (deux faits en plus de la règle à trouver) | l'implémenteur a émis la réserve, la re-revue l'a jugée **excessive** (« format standard situation puis conséquences »). Conservée pour mémoire, pas comme dette |
| `46269e3e` — la moins irrépondable des quatre illustrées de sa tâche : deux distracteurs s'éliminent sans l'image | le §7 reste tenu, l'image tranche entre les deux options restantes |
| `Données` change de nature (7 → 12, dont 5 toutes SwiftData) et la difficulté dérive (9 `costaud` sur 20) | c'est un effet voulu du comblement d'un trou ; à rééquilibrer si le thème continue de grossir |

### 9.2 Ce qui n'est pas du contenu mais de l'**outillage** ou de la **documentation**

C'est la pile la plus importante à isoler, parce qu'elle ne se corrige pas dans
`questions.json` et qu'une revue de contenu ne la verra pas.

| constat | nature |
|---|---|
| **Les huit angles morts d'`audit.py`** (§7) | outillage. Deux d'entre eux sont des constats parqués en propre : les fuites sous le seuil de 4 caractères (« 70 », « 30 ») que le détecteur ne voit pas, et l'écart de −13 laissé en exemple vivant sur `37fe1af4…544d1` avant sa correction |
| **abaisser le seuil de `fuite/mot-enonce` sous 4 caractères** | **décision de dépôt, pas de tâche** — c'est pourquoi ce constat a été parqué et non exécuté |
| `Tools/audit.py` et le docstring du test reprennent quasi mot pour mot le texte d'un brief | style ; cohérent avec le dépôt, non bloquant |
| **écarts commentaire/code dans `Tools/Scenes/`** : `debordH`/`debordV` sont des **insets** et non les demi-axes que nomme le commentaire, et une borne « 1,545 r » est fausse (c'est 1,5 r) | **de la même classe que le défaut qui a coûté deux rondes de revue : un commentaire qui affirme ce que le code ne fait pas.** La conclusion du calcul est inchangée. À corriger, mais deux lignes de commentaire ne justifiaient pas une ronde |
| l'orientation verticale du chevron est un **choix** et non une citation — absente de la liste des licences d'`images.md` | documentation d'image |
| `panneau-b33` : le halo entaille le « 7 » et coupe l'oblique en deux moignons | dessin, lisible à taille de carte mais abîmé |
| `panneau-a13b` dont les trois bandes se lisent comme un socle à 90 points ; **listel blanc invisible en clair sur quatre panneaux à fond clair** | dessin ; le second est le plus gênant, il annule une correction de norme dans un des deux modes |
| dans `depassement-ligne-discontinue` les deux véhicules ne se chevauchent que sur 20 unités sur 50, là où l'`alt` dit « à la hauteur de celle qu'elle double » | `alt` un peu généreux, sans effet sur la réponse |
| **un état intermédiaire de l'historique (`7fe5ae4`) échouerait la suite de tests** | l'état final est bon ; mais un `git bisect` ou un cherry-pick sur ce commit serait trompeur. À savoir avant de bisecter cette branche |
| deux chiffres du tableau §15 d'un rapport de tâche ne se reproduisent pas (un −1 pour un 0, un « 15 % → 14 % » pour un taux stable) | erreur de calcul **dans un rapport**, pas dans les données. Non repris ici |
| un rapport de ronde montre la sortie de la suite mais ne **nomme** pas de test couvrant | exigence « nommer + montrer » partiellement remplie |
| le §9 point 7 d'un rapport garde une citation « 113-1 E » périmée, volontairement non retouchée | historique ; **ne pas écraser une trace d'exécution** est la bonne réaction |
| une ligne de registre du « 112 » cite encore « 119 destiné à tout enfant ou adolescent victime de violences » là où l'explication corrigée dit « enfance en danger » | registre, désaccord de libellé avec le contenu |
| une ligne de `sources.md` (les 30 m du triangle) a son contenu corrigé mais son sourçage formel laissé au domaine propriétaire | partage de périmètre assumé entre deux tâches |

### 9.3 Ce qui est déjà réglé, et ne doit pas revenir dans une revue

- **Les volumes périmés de `couverture.md`** (`Arrêt & stationnement` à 11 pour 17,
  `Distances & freinage` à 10 pour 21) : **recomptés en totalité** par cette tâche.
- **Les sanctions de R412-11-3** : restaurées, relevées mot pour mot.
- **La fuite `5c11020d` → `bda52045`** : coupée.
- **`Tools/questions.md` sur les trois régimes de `sourceURL`** : réécrit.
- **La concentration du domaine `Panneaux & marquage` sur l'axe « forme/couleur → famille »**
  (5 questions sur 27) et le **miroir exact** `1a0a5812` / `37fe1af4…f5aef8` sur la ligne
  mixte : constat réel, mais les deux cartes ont été **délibérément différenciées** plutôt
  que fusionnées, et le domaine est passé de 17 à 27 questions depuis le constat. À rejuger
  seulement s'il grossit encore.
- **La reformulation de `37fe1af4…b7bf77`, qui « frôle l'énoncé de principe »** : jugée
  acceptable par la revue de sa tâche.
- **La ligne `Feux` / « Visibilité et éclairage » de `couverture.md`** qui affichait le
  volume du topic entier : le partage 8/11 est écrit sous le tableau, et le verdict est rendu
  au §3 de ce rapport.

### 9.4 Le tri, en une phrase

**Rien dans les trente ne bloque une fusion.** Aucun ne rend une question fausse, aucun ne
casse un test, aucun ne dégrade une donnée livrée. Ce qu'un relecteur de branche devrait
regarder en priorité tient en trois lignes : le **listel blanc invisible en mode clair sur
quatre panneaux** (une correction de norme annulée dans un des deux modes), les **écarts
commentaire/code de `Tools/Scenes/`** (la classe de défaut la plus coûteuse de cette passe),
et le **distracteur « feux de détresse » à six occurrences** (la seule règle du guide de
rédaction qui soit aujourd'hui en dépassement).

---

## 10. Ce que la prochaine passe trouvera prêt

- Un **registre de fraîcheur** de 255 lignes qui dit, pour chaque question `code`, contre
  quoi elle a été vérifiée et quand — et qui se périme tout seul au bout de douze mois,
  `audit.py` le signalant.
- Une **carte de couverture** qui rattache chaque `topic` à une thématique officielle, et
  qui refuse mécaniquement un topic hors référentiel.
- Une **liste de renoncements motivés** (§4.2), dont sept lignes disent explicitement ce
  qu'il manque et rien d'autre.
- Un **relevé d'angles morts** (§7) avec la ligne d'outil de chacun.
- Un dossier `Tools/Scenes/` où **un panneau se dessine une fois**, et une méthode pour
  relever une planche officielle en image plutôt que de dessiner de mémoire.

Et une chose qui n'est pas prête : **448 questions ne font toujours pas un feed infini.**
Deux passes de contenu ont porté la banque de 250 à 448 sans changer l'ordre de grandeur.
Écrire à la main ne rattrapera pas un feed ; c'est la génération depuis les pages de cours
qui le fera, et elle alimentera le même `questions.json`.
