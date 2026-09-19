# Notions et maîtrise — enseigner un système sans sortir du feed

Spec du 2026-09-19. Première intervention sur la **boucle d'apprentissage** ; les quatre
précédentes portaient sur le contenu (justesse, fraîcheur, forme) ou sur le feed lui-même.
Celle-ci ne corrige aucune carte existante et n'en retire aucune : elle ajoute un ordre de
service, une monnaie de progression, et les cartes qui manquent pour que l'ordre ait
quelque chose à servir.

## Le problème

Le constat qui ouvre cette spec est un retour d'usage, pas une mesure d'outil : **après deux
semaines d'usage quotidien, l'utilisateur ne sait toujours pas à quoi correspond la forme
d'un panneau, ni sa couleur, ni les régimes de priorité, ni les types de lignes.** Les
exemples donnés n'étaient pas exhaustifs.

Valido contrôle sans enseigner. C'est une propriété structurelle, pas un défaut de contenu :
un feed de QCM tiré à plat suppose que le cours a été suivi ailleurs. Trois mesures, prises
à l'ouverture de cette spec :

| mesure | valeur | commande |
|---|---|---|
| cartes `code` touchant la grammaire forme/couleur dans leur `prompt` | **5 sur 255** | §1 ci-dessous |
| dont cartes énonçant une famille entière | **2** (rond + bord rouge ; rond + fond bleu) | lecture directe |
| cartes `Panneaux & marquage` illustrées testant **un** panneau précis | **17 sur 27** | lecture directe |

Le triangle à bord rouge (danger), le carré ou rectangle à fond bleu (indication) et
l'octogone (stop) ne sont **énoncés comme système nulle part** dans la banque. L'octogone
STOP et le triangle pointe en bas existent bien, mais comme cartes de `Priorités &
intersections` : la banque est classée par **usage**, jamais par **système**, si bien que la
grammaire de la signalisation n'est réunie sur aucun axe.

**Le défaut a une signature, et elle n'est pas propre aux panneaux.** Les exemples donnés à
l'ouverture — panneaux, priorités, lignes — n'étaient pas exhaustifs, et les prendre pour
cible aurait produit un correctif local à un défaut général. Les 255 cartes `code` ont donc
été relues, les treize domaines, et le critère qui ressort est net :

> **Quand un domaine est une taxonomie, Valido teste les membres un par un et n'énonce
> jamais la famille. Quand c'est une procédure ou une grandeur, la fondation existe déjà.**

Les six taxonomies sans fondation, relevées sur l'ensemble du corpus :

| domaine | la famille jamais énoncée | applications qui en dépendent |
|---|---|---:|
| `Panneaux & marquage` | les formes et les couleurs — 2 familles énoncées sur 5 | 17 |
| `Feux` | les feux du véhicule : croisement, route, brouillard avant et arrière, détresse, position | 6 |
| `Permis & sanctions` | **contravention contre délit**, la distinction qui structure tout le domaine | ~6 |
| `Arrêt & stationnement` | gênant / très gênant / dangereux / abusif, et leur barème | 4 |
| `Vitesse` | la règle d'abattement par intempérie, et les limites de la période probatoire | 6 |
| `Usagers & partage de la route` | « usager vulnérable » comme catégorie | 5 |

Et le contre-exemple, qui est ce qui rend le critère utilisable plutôt qu'anecdotique —
quatre domaines portent **déjà** leur fondation, et rien n'y est à écrire : `Distances &
freinage` (« La distance d'arrêt d'un véhicule se compose de : »), `Premiers secours`
(« Face à un accident, la règle de conduite à suivre est : », soit protéger / alerter /
secourir), `Mécanique & environnement` (témoin rouge contre témoin orange, deux cartes qui
énoncent le système) et `Arrêt & stationnement` sur son autre axe (« L'arrêt se distingue du
stationnement par : »).

Le critère se lit donc comme un test à appliquer à chaque notion, pas comme une liste à
recopier : *cette notion est-elle une famille dont je teste les membres ?* Si oui, il lui
faut une fondation. Le tableau ci-dessus est le résultat d'un premier passage, pas une
liste close — §6 en fait un travail d'annotation systématique.

**Deux pannes distinctes, deux remèdes distincts.** Les deux domaines cités à l'ouverture
tombent d'ailleurs de part et d'autre de cette frontière, et c'est ce qui structure toute la
suite :

- **La grammaire des panneaux est en panne de contenu.** Deux cartes sur cinq familles.
  Aucun ordre de service ne peut servir une carte qui n'existe pas.
- **Les lignes sont en panne d'ordre.** Les cinq cartes existent déjà — continue,
  discontinue axiale, discontinue de rive, mixte, à cheval sur une continue. Elles sont
  noyées dans 448 cartes tirées à plat, avec une fenêtre anti-répétition de 25 et un horizon
  de 60 : rien ne les rapproche jamais, et on peut les rencontrer à trois semaines d'écart
  sans jamais percevoir qu'elles forment un système.

Confondre les deux ferait écrire des cartes là où il n'en manque pas, et laisserait la
grammaire à moitié enseignée là où il en manque vraiment.

## Ce qui est décidé, et ce qui ne l'est pas

Quatre arbitrages sont pris et ne se rouvrent pas dans cette passe.

**1. Pas de carte de cours.** Une fiche de texte insérée dans le feed serait la seule carte
sans interaction : le pouce passerait dessus. Elle casserait le rythme, qui est la raison
pour laquelle l'app est ouverte tous les jours. Le motif est aussi pédagogique et pas
seulement esthétique — répondre puis se corriger retient mieux que relire une fiche. **Le
système s'enseigne donc en QCM, comme tout le reste :** une carte de grammaire est une carte
normale, avec quatre options et un mémo.

**2. L'ordre penche, il ne verrouille pas.** Les cartes fondation d'une notion non acquise
sont fortement pondérées, mais rien n'est interdit et le tirage uniforme de 30 % n'est pas
touché. Un verrou dur garantirait l'ordre d'apprentissage, mais rendrait les trente
premières cartes prévisibles et ferait frotter la fenêtre anti-répétition de 25 contre des
notions qui ne comptent que cinq ou six cartes. L'imprévisibilité est une décision de
produit du README ; elle prime.

**3. La maîtrise ne se reperd jamais.** Une progression qui se casse punit l'absence au
lieu de récompenser le travail déjà fait, et le jour où elle casse on referme l'app. Une
notion acquise est **l'inverse exact d'une série** : elle ne peut que monter, aucune faute
ne la retire. `ComboEngine` porte la monnaie qui tombe, la maîtrise porte celle qui reste —
deux mises de natures opposées, et c'est voulu. (Le projet avait déjà écarté la série
quotidienne pour ce motif ; c'est un précédent qui converge, pas la raison.)

**4. Le tirage continue d'être piloté par les fautes.** Acquérir une notion ne la retire pas
du vivier. `weight()` garde `failureRate` et le plancher de 0,05 : une notion acquise qu'on
se remet à rater revient exactement comme aujourd'hui. **Le badge est ludique, la révision
reste mécanique** — deux systèmes volontairement séparés, parce que les confondre
transformerait un affichage en trou de révision.

Ce qui n'est **pas** décidé ici et reste au plan d'implémentation : la liste exacte des
notions et l'affectation des 255 cartes. Inventer trente noms de notions dans une spec sans
avoir relu les 255 cartes serait précisément le « rejouer de mémoire » que `CLAUDE.md`
interdit sur les décisions de contenu. La spec fixe le schéma, la méthode et les contrôles ;
l'affectation est un travail de lecture, planifié comme tel.

## 1. Le schéma de données

Deux champs sur `Question`, tous deux optionnels dans le JSON et nuls pour `swift` :

```swift
nonisolated enum Role: String, Codable, Sendable {
    case fondation     // énonce le système : « Un panneau triangulaire à bord rouge annonce : »
    case application   // exerce le système sur un cas : « Ce panneau indique : »
}
```

- `notion: String?` — identifiant stable en minuscules, de forme `domaine/systeme`
  (`panneaux/formes`, `marquage/lignes`, `priorite/regimes`). Un **niveau plus fin que
  `topic`** : `Panneaux & marquage` en portera plusieurs.
- `role: Role?` — nul hors `code`. Une carte `code` sans `notion` est refusée par `audit.py`
  une fois la migration terminée (voir §4, échelonnement).

`Question` étant `nonisolated`, `Codable`, `Sendable` et `Hashable`, les deux champs suivent
sans traitement particulier. Les `id` existants ne bougent pas : **un `id` livré est
immuable**, la progression est indexée dessus, et cette passe n'en réécrit aucun.

**Pourquoi `role` est un champ et pas une déduction.** On pourrait vouloir déduire « c'est
une fondation » d'une heuristique sur le `prompt` (absence d'illustration, présence d'un mot
de forme). La passe de septembre a mesuré ce que valent ces proxies lexicaux :
`forme/hors-situation` coïncide à 97,6 % avec « la carte n'a pas d'illustration » et ne
mesure donc pas ce qu'il nomme. Le rôle est une décision pédagogique ; il se déclare, comme
`nature` dans `sources.md` — qui est « déclarée, pas déduite » pour la même raison.

## 2. Le registre `Tools/notions.md`

Une ligne par notion, sur le modèle de `couverture.md`, imposé par `audit.py` :

| notion | topics concernés | fondations | applications | verdict |
|---|---|---:|---:|---|
| `marquage/lignes` | `Panneaux & marquage` | 1 | 4 | couvert |
| `panneaux/formes` | `Panneaux & marquage`, `Priorités & intersections` | 2 | 17 | à compléter |

Trois contrôles nouveaux, tous dans le préfixe `notions/` et tous **devant rester vides** :

- `notions/non-declaree` — une `notion` absente du registre. Même logique que
  `couverture/topic-non-rattache` : c'est une faute de frappe ou un pan de contenu hors
  système.
- `notions/sans-fondation` — une notion qui n'a aucune carte `fondation`. **C'est le
  contrôle qui porte toute la spec** : il rend mécaniquement impossible d'exercer un système
  qu'on n'a jamais énoncé, ce qui est exactement la panne constatée.
- `notions/carte-orpheline` — une carte `code` sans `notion` (activé en fin de migration).

Le registre déclare aussi, en colonne `topics concernés`, qu'une notion peut traverser
plusieurs `topic` — `panneaux/formes` est le cas réel, puisque l'octogone et le triangle
pointe en bas vivent aujourd'hui dans `Priorités & intersections`. **La notion est
l'axe transversal que `topic` ne sait pas porter** ; c'est sa raison d'être, et le registre
doit le montrer plutôt que de le subir.

`audit.py` continue de sortir 0 : c'est un rapport, pas un code de retour.

## 3. Le tirage

Un seul point d'entrée modifié, et **ce n'est pas `weight(for:progress:)`** : c'est
`weightedPick(from:progress:rng:)`.

```swift
let poids = pool.map { weight(for: $0.id, progress: progress) * boost(for: $0, progress: progress) }
```

où `boost` vaut `config.foundationBoost` si la carte est une `fondation` dont la notion
n'est pas acquise, et `1.0` sinon.

**Deux raisons de le brancher là plutôt que dans `weight()`, toutes deux vérifiées dans le
code.**

1. `weight(for:progress:)` prend un `Question.ID`, pas une `Question` — elle n'a accès ni à
   `role` ni à `notion`. `weightedPick` a déjà la `Question` entière sous la main. Changer la
   signature casserait les cinq appels de `CardSchedulerTests.swift` (l. 53, 54, 67, 77, 78)
   sans rien gagner.
2. Surtout, `weight()` **court-circuite sur une carte jamais vue** :
   `guard let lastServeIndex = stats.lastServeIndex else { return config.unseenFailureWeight }`
   (`CardScheduler.swift:35-37`). Un boost placé après ce calcul raterait exactement le cas
   qu'il doit servir — une fondation jamais vue, jour 1. En multipliant à l'extérieur, le
   boost s'applique aux deux branches.

La séparation est aussi conceptuellement juste : `weight()` reste **le poids de révision**
(faiblesse × ancienneté), le boost est **le poids d'apprentissage**. Deux choses distinctes,
deux fonctions distinctes.

Rien d'autre ne change. `eligible(in:recent:selection:)`, le partage 70/30, la fenêtre de
25, le plancher de 0,05 : intacts. Le boost ne s'applique qu'au tirage **pondéré** — le
tiers uniforme reste inconditionnel, donc l'imprévisibilité tient. Les cinq tests existants
de `weight()` passent **sans modification**.

Deux nombres rejoignent les sept de `SchedulerConfig`, qui en portera **neuf** :

- `foundationBoost` (valeur de départ **4,0**) — le facteur appliqué à une carte fondation
  dont la notion n'est pas acquise. Ordre de grandeur choisi pour dominer
  `unseenFailureWeight` (3,0) sans écraser une carte souvent ratée, dont le poids d'échec
  peut atteindre 3,0 lui aussi.
- `masteryStreak` (valeur de départ **4**) — bonnes réponses consécutives sur des cartes
  **distinctes** de la notion, exigées pour l'acquérir.

Les deux valeurs de départ sont des points de réglage assumés, pas des résultats : elles se
bricoleront après trois jours d'usage, ce pour quoi `SchedulerConfig` existe. Ce qui doit
être **testé** n'est pas leur valeur mais l'invariant qu'elles servent — voir §5.

**Le scheduler reste pur.** `estAcquise` est une fonction de `ProgressSnapshot`, qui ne
porte que le compteur monotone `serveIndex` ; aucune horloge, aucun `Date()`, aucun
`random()` implicite n'entre dans cette chaîne. À graine fixe (`ValidoTests/SeededRNG`), la
même entrée donne toujours la même sortie.

## 4. La progression

`ProgressSnapshot` gagne, par notion, la série courante et le fait d'être acquise. Trois
règles :

1. Une bonne réponse sur une carte de la notion incrémente la série **si la carte n'est pas
   déjà dans la série en cours** — sans quoi la fenêtre anti-répétition suffirait à faire
   acquérir une notion sur une seule carte revue quatre fois.
2. Une faute remet la série à zéro. Elle ne retire **jamais** l'acquisition déjà obtenue.
3. Une notion acquise le reste à travers les chargements. Elle vit donc dans
   `FileProgressStore` (JSON dans Application Support), pas dans `UserDefaults` : c'est de la
   progression, pas une préférence — la même frontière que `DefaultsSourceSelectionStore`.

`load()` ne doit toujours jamais lancer : une progression illisible retombe sur l'état neuf,
donc sur « aucune notion acquise », ce qui est le comportement sûr — on réapprend, on ne
saute rien.

**Échelonnement de la migration.** `notions/carte-orpheline` ne s'active qu'une fois les 255
cartes affectées. Avant cela, une carte `code` sans `notion` se comporte exactement comme
aujourd'hui : `boost` à 1,0, aucune notion, aucun effet. La banque reste jouable à chaque
étape du chantier, et `QuestionBank.init` n'a pas à rejeter de carte pour ce motif.

## 5. Les tests

Ce chantier touche la chaîne que la suite verrouille le plus (64 tests, Swift Testing). Les
tests à ajouter, nommés en français comme le reste :

- **`fondationPrioriséeTantQueNotionNonAcquise()`** — à graine fixe, sur une banque à deux
  notions, la fondation d'une notion vierge sort plus souvent que ses applications. Teste
  l'invariant, pas la valeur de `foundationBoost`.
- **`acquisitionNeRetirePasDuVivier()`** — une notion acquise continue de sortir. C'est
  l'arbitrage 4 ; sans ce test il se perd à la première refonte.
- **`sérieExigeDesCartesDistinctes()`** — quatre bonnes réponses sur la **même** carte
  n'acquièrent pas la notion.
- **`fauteNeRetirePasUneNotionAcquise()`** — l'arbitrage 3, verrouillé.
- **`répartition70_30()`** — le test existant doit continuer de passer **inchangé**. Si le
  boost déplace le 70/30, c'est que le boost a été branché au mauvais endroit.

`BundledContentTests` gagne : chaque notion déclarée a au moins une carte `fondation`, et
chaque carte `code` porte une `notion` du registre (en fin de migration). Les seuils de
volume existants (≥ 425, ≥ 242 `code`, ≥ 183 `swift`, ≥ 44 illustrées) ne bougent pas — les
cartes neuves les font monter, et **un échec s'y corrige dans les données, jamais dans le
test**.

## 6. Le contenu

La moitié la plus lourde, et celle qu'aucun code ne remplace.

1. **Affecter `notion` et `role` aux 255 cartes `code`.** Travail de lecture, domaine par
   domaine, sur le modèle des treize lectures du §4 de `audit-2026-09-formes.md`. Il
   produit le registre `notions.md` en même temps que l'affectation — les deux ne peuvent
   pas être écrits l'un sans l'autre.
2. **Écrire les fondations manquantes, sur les treize domaines.** Le balayage du §1 en a
   déjà nommé six ; l'annotation de l'étape 1 en révélera d'autres, puisqu'elle applique le
   même test à chaque notion plutôt qu'aux seuls domaines déjà lus sous cet angle. Le socle
   connu à ce stade :

   | notion | la fondation à écrire |
   |---|---|
   | `panneaux/formes` | triangle à bord rouge = danger ; carré ou rectangle = indication ; octogone = stop ; triangle pointe en bas = cédez le passage |
   | `panneaux/couleurs` | la couleur comme axe **indépendant** de la forme : bord rouge = interdiction, fond bleu = obligation ou indication selon la forme, fond jaune = temporaire |
   | `feux/eclairage-vehicule` | la famille des feux et le rôle de chacun — six cartes l'exercent, aucune ne l'énonce |
   | `permis/qualification` | contravention contre délit : ce qui les sépare, et ce que chacune emporte |
   | `stationnement/gradation` | les quatre niveaux — gênant, très gênant, dangereux, abusif — et leur barème |
   | `vitesse/intemperies` | la règle d'abattement elle-même, plutôt que ses trois cas |
   | `vitesse/probatoire` | les limites abaissées comme système, plutôt que ses trois cas |
   | `usagers/vulnerables` | ce qui fait un usager vulnérable, et ce que ça impose au conducteur |

   Chaque carte neuve passe par le protocole complet de `Tools/questions.md` — 7 règles de
   distracteur, 9 pièges de forme, `sources.md`, `couverture.md`, puis `audit.py`,
   `relire.py`, les tests. Les fondations de `permis/qualification` et
   `stationnement/gradation` portent des montants et des retraits de points : elles sont
   `datée` dans `sources.md`, avec une source de `DOMAINES_FAIT` et sa date de relevé.
3. **Ne rien réécrire d'autre.** Les 17 cartes « Ce panneau indique : » sont de bonnes
   cartes d'application ; elles ne deviennent un problème que sans fondation en amont. Cette
   passe n'ouvre pas le lot de réécriture des 25 cartes du diagnostic de septembre, qui est
   un autre chantier avec son propre coût (20 scènes à dessiner).

## 7. L'interface

Une seule surface nouvelle, à côté de `ComboBadge` : un compteur de notions acquises. Sans
lui, l'acquisition est invisible et ne motive rien — c'est la contrepartie ludique qui
justifie le mécanisme, et la seule raison pour laquelle il ne se réduit pas à un détail
d'algorithme.

Contrainte reprise du README : **aucun texte de carte n'est compressible**. Le compteur vit
dans le bandeau, avec `ComboBadge`, jamais dans la carte — il ne prend donc rien à l'énoncé,
aux options ni au mémo, et n'entre pas dans le budget de hauteur des illustrées
(70 / 50 / 220).

`FeedViewModel.cards` **ne fait que croître** et l'index d'une carte reste absolu : rien
dans cette spec ne touche à la fenêtre de cartes ni au retrait par l'arrière de
`apply(_:currentIndex:)`.

## 8. Le livrable

- `Valido/Model/Question.swift` — `notion`, `role`, l'enum `Role`.
- `Valido/Model/ProgressSnapshot.swift` — série par notion, acquisition, persistance.
- `Valido/Model/SchedulerConfig.swift` — `foundationBoost`, `masteryStreak`.
- `Valido/Model/CardScheduler.swift` — le boost dans `weightedPick`, `weight()` inchangée.
- `Valido/View/` — le compteur de maîtrise, à côté de `ComboBadge`.
- `Valido/Resources/questions.json` — `notion` + `role` sur 255 cartes, plus les fondations
  neuves.
- `Tools/notions.md` — le registre.
- `Tools/audit.py` — les deux clés dans `schema/cle-hors-schema`, les trois contrôles
  `notions/`.
- `ValidoTests/` — les cinq tests du §5, plus les contrôles de `BundledContentTests`.
- `CLAUDE.md` — les **neuf** nombres de `SchedulerConfig` au lieu de sept, le registre
  `notions.md` à côté de `sources.md` et `couverture.md`, les trois compteurs `notions/`
  dans la liste de ceux qui doivent rester vides.
- `README.md` — le volume de questions, et rien d'autre. **Le pourquoi de cette boucle va
  dans les commentaires des types concernés** (`CardScheduler`, `ProgressSnapshot`,
  `ComboEngine`), au format daté déjà en usage dans le dépôt — pas en règle normative dans
  le README, qui décrit le projet et ne le contraint pas.

### Critères d'acceptation

1. `python3 Tools/audit.py` affiche `notions/non-declaree`, `notions/sans-fondation` et
   `notions/carte-orpheline` **vides**, et les compteurs qui doivent rester vides le sont
   toujours : `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10`,
   `forme/backtick-isole`.
2. Les compteurs informatifs (`longueur/plus-longue` 76, `expl/paraphrase-litterale` 20,
   `forme/impersonnel` 199, `forme/hors-situation` 200, `forme/definitionnel` 94) sont
   **comparés à la ligne de base, pas à zéro**. Les cartes neuves les font bouger ; une
   hausse n'est une dérive que si elle vient d'autre chose que du volume ajouté.
3. La suite complète passe, `répartition70_30()` **inchangé**.
4. Chaque notion du registre a au moins une carte `fondation`.
5. À partir d'une progression vierge et à graine fixe, les cartes de `panneaux/formes` et de
   `marquage/lignes` sortent dans les premières dizaines de tirages — l'invariant qui répond
   au constat d'ouverture.

## 9. Ce qui ne bouge pas

Les `id` livrés. Le partage 70/30 et les sept nombres existants. La fenêtre de 25, l'horizon
de 60, le plancher de 0,05. L'absence de `Date()` et de réseau. `FeedViewModel.cards` qui ne
fait que croître. Le verdict symétrique et l'absence d'auto-avance. L'absence de série
quotidienne. Le mono-réponse — l'écart au multi-réponse de l'épreuve est réel et mesuré
(14 des 24 questions du spécimen), mais c'est un autre chantier et il ne se mélange pas à
celui-ci.

## 10. Risques

**Le boost rend le début prévisible.** C'est le risque direct de l'arbitrage 2, atténué
et non supprimé : 30 % des tirages restent uniformes, mais un utilisateur neuf verra
beaucoup de fondations. `foundationBoost` est là pour être baissé si le début du feed
devient lisible.

**La granularité des notions est un jugement, pas une mesure.** Trop fines, elles
s'acquièrent en quatre cartes et le compteur devient du bruit ; trop larges, `masteryStreak`
ne veut plus rien dire. Le garde-fou est le registre : une notion qui n'a pas de quoi
soutenir une série de `masteryStreak` cartes distinctes est trop fine et doit fusionner.

**L'acquisition peut mentir.** Quatre bonnes réponses d'affilée sur des cartes distinctes ne
prouvent pas qu'un système est su — un QCM à quatre options se devine une fois sur quatre.
C'est assumé : le badge est une mise ludique, et l'arbitrage 4 garantit que la révision
continue indépendamment de lui. Ce qu'il ne faut pas faire, c'est se servir de
l'acquisition pour retirer des cartes du vivier — ce serait transformer un affichage en trou
de révision.

**Le chantier de contenu est plus gros que le chantier de code.** 255 cartes à lire et
affecter, une trentaine à écrire. Le code tient en cinq fichiers ; l'annotation est le
chemin critique, et c'est elle qu'il faut découper dans le plan.
