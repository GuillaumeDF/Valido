# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Valido — feed vertical infini de QCM (code de la route + Swift/iOS). iOS 26.2, SwiftUI,
Swift 6, projet Xcode à plat (pas de SwiftPM). Le `README.md` explique les décisions de
produit ; ce fichier ne redit que ce qui sert à travailler dans le dépôt.

## Commandes

```bash
# Le simulateur se démarre À LA MAIN d'abord, sinon « Busy » / preflight
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl boot 'iPhone 17 Pro'

# Toute la suite (64 tests, Swift Testing)
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro'

# Un seul test — les PARENTHÈSES sont obligatoires
-only-testing:'ValidoTests/répartition70_30()'

python3 Tools/audit.py              # contrôles de forme + fraîcheur + couverture
./Tools/render-scenes.sh            # regénère les schémas PNG (clair/sombre, @2x/@3x)
```

Deux pièges d'outillage, tous deux silencieux :

- **`-only-testing` sans `()`** exécute 0 test et affiche quand même `** TEST SUCCEEDED **`.
  Vérifier la ligne `✔ Test run with N test(s)`. (Les lignes `Executed 0 tests` de XCTest
  sont normales : Swift Testing rapporte à part.)
- **Trois runtimes (26.0/26.1/26.2) déclarent un device `iPhone 17`**, et l'un d'eux reste
  coincé : `Application failed preflight checks` / `Busy` sans qu'aucun test n'ait tourné
  est un simulateur, pas une régression. Passer à `iPhone 17 Pro` ou viser un UDID
  (`DEVELOPER_DIR=... xcrun simctl list devices available`).

`audit.py` **sort toujours 0** : c'est le rapport qu'on lit, pas le code de retour. La
ligne de base au 2026-08-29, sur 448 questions, n'est pas vide — `longueur/plus-longue`
(76, informatif, le seuil dur est `plus-10`), `expl/paraphrase-litterale` (20),
`forme/seule-ponctuee` (14) et deux faux positifs connus (`lettre/reference` 1,
`forme/markdown` 1). Doivent rester **vides** : `schema/`, `couverture/`, `source/`,
`fuite/`, `image/`, `longueur/plus-10`, `forme/backtick-isole` — ce dernier ne mordant que
si une option porte un backtick, son zéro ne prouve rien sur un lot sans code span.
Comparer à cette base, pas à zéro ; le §3 de `Tools/questions.md` dit lesquelles demandent
un tri à la main, et le §7 de `Tools/audit-2026-08-passe-2.md` ce que l'outil ne voit pas.

**Les deux chiffres qui ont bougé à la passe 3 sont voulus, ce ne sont pas des dérives.**
`longueur/plus-longue` **97 → 76** : tout le mouvement est côté `code` (34 → 13), obtenu en
élargissant les distracteurs, pas en raccourcissant les bonnes réponses. Et
`expl/paraphrase-litterale` **18 → 20** (dont `code` 10 → 12) a **monté** là où la spec de la
passe attendait une baisse : le critère pédagogique retenu exige qu'une explication énonce la
règle, et sur une carte dont la règle *est* un chiffre, ce compteur mesure l'objectif inverse.
Trois cartes ont gagné le chiffre qui leur manquait, une est sortie de la liste sans qu'aucune
fuite ne se ferme (elle écrit « quatre » là où l'option dit « 4 » — `audit.py:194` teste une
sous-chaîne). **Donc : `expl/paraphrase-litterale` n'est pas un compteur à minimiser** ; le
faire baisser pour lui-même vide les cartes de ce qu'elles enseignent. Les trois classes à
distinguer et les douze angles morts mesurés sont dans
`Tools/audit-2026-08-passe-3.md`, section « La ligne de base publiée ».

## Architecture

Une seule boucle : `ScrollView` paginé → `FeedViewModel` → `CardScheduler` → `QuestionBank`.

**Trois couches, une règle d'isolation.** La cible compile avec
`SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor`, donc chaque type du modèle est explicitement
`nonisolated` (SE-0466) : *le modèle est sans isolation et `Sendable`, le view model est
`@MainActor`, les vues suivent.* Tout nouveau type dans `Valido/Model/` porte `nonisolated`.

**Le scheduler est pur.** `CardScheduler.next(bank:progress:recent:selection:rng:)` ne
cache ni horloge ni aléatoire : le RNG est passé en `inout`, et le temps est un compteur
monotone `ProgressSnapshot.serveIndex` — **aucun `Date()` dans le projet**, « il y a
longtemps » se mesure en cartes servies. À graine fixe (`ValidoTests/SeededRNG`), la même
entrée donne toujours la même sortie ; c'est ce qui rend la répartition 70/30 testable sur
1000 tirages. Ne pas introduire d'horloge ni de `random()` implicite dans cette chaîne.

**Les sept nombres réglables** (part pondérée 0,7 ; fenêtre anti-répétition 25 ; horizon 60 ;
plancher 0,05…) vivent tous dans `SchedulerConfig`, jamais en dur ailleurs.

**`FeedViewModel.cards` ne fait que croître.** Rogner par l'avant produisait un saut visible
du `ScrollView` ; c'est la paresse du `LazyVStack` qui rend le flux infini, pas la brièveté
du tableau. Corollaire : l'index d'une carte est absolu, `cards[0]` reste la première carte
servie. Un changement de sources (`apply(_:currentIndex:)`) retire par l'**arrière** seulement.
Ces contraintes sont documentées en commentaire dans `FeedViewModel` et `FeedView` — les
lire avant de toucher à la fenêtre de cartes.

**Persistance**, deux magasins derrière protocoles (injectés, doublés en test) :
`FileProgressStore` (JSON dans Application Support, écrit toutes les 5 réponses et sur
`scenePhase != .active`) et `DefaultsSourceSelectionStore` (`UserDefaults` : c'est une
préférence, pas de la progression). Les deux `load()` ne lancent jamais — une donnée
illisible retombe sur l'état neuf.

**Invariants portés par les types, pas par l'UI** : `QuestionBank.init` valide et rejette
avec un `ContentError` **nommant l'id fautif** ; `SourceSelection` ne peut pas être vide
(décocher la dernière source est un no-op). C'est la boucle de retour à utiliser sur le
contenu.

**Aucun réseau.** Pas d'`URLSession`, pas de compte, pas de secret ; les images sont des
imagesets du catalogue.

`Valido/` est un dossier synchronisé (`objectVersion = 77`) : un `.swift` créé sur le disque
est compilé sans toucher au `.pbxproj`.

## Le contenu est du code

`Valido/Resources/questions.json` **est** la source — pas de génération, on édite le fichier.
448 questions (255 `code`, 193 `swift`), dont **49 illustrées**. L'`id` est soit un ancien id
de page Notion, soit `sha256("valido-v2:" + prompt)[:32]` — le préfixe est dans l'entrée du
hachage, pas dans l'identifiant. **Un `id` livré est immuable** : la progression est indexée
dessus. Les options sont mélangées à chaque présentation (**donc aucune référence de lettre
nulle part**, ni dans une option ni dans une explication).

Deux registres, tous deux imposés par `audit.py` :

- `Tools/sources.md` — la **fraîcheur** : une ligne par question `code`, déclarée `stable` ou
  `datée`, une `datée` portant l'URL d'un domaine de la liste blanche et sa date de relevé.
- `Tools/couverture.md` — la **couverture** : une ligne par couple (thématique ETG, `topic`).
  Un `topic` `code` qui n'y figure pas est refusé.

Avant toute édition de questions, lire [`Tools/questions.md`](Tools/questions.md) : 7 règles
de distracteur, 9 pièges de forme, fraîcheur juridique (§5, sources officielles imposées),
questions illustrées (§7). Puis `audit.py`, puis les tests.

`ValidoTests/BundledContentTests.swift` verrouille le livré : volume ≥ 425, ≥ 242 `code` et
≥ 183 `swift`, **≥ 44 illustrées**, aucune lettre de réponse en tête d'option ou
d'explication, équilibre de longueur (la bonne réponse ne dépasse pas de 10 caractères la
deuxième plus longue), résolution de chaque asset dans le bundle, `alt` ≥ 40 caractères, et
le budget de hauteur des illustrées (70 / 50 / 220 caractères). Les seuils de volume sont à
95 % du livré, 90 % pour les illustrées. **Un échec s'y corrige dans les données, jamais
dans le test.**

Images : un seul champ `Illustration { asset, alt }`. L'`alt` **est** l'énoncé pour qui
n'accède pas à l'image. Deux origines — 49 schémas générés par `./Tools/render-scenes.sh`
(scènes sous `Tools/Scenes/`, on édite la scène, jamais les PNG ; un panneau se dessine une
seule fois, dans `Tools/Scenes/Panneaux.swift`) et deux photos Wikimedia, dont une seule
sert encore. Tout asset doit avoir sa ligne dans [`Tools/images.md`](Tools/images.md), sinon
`audit.py` le refuse. Aucune information ne repose sur la couleur seule — et ça **se mesure**
en niveaux de gris avant de commiter un PNG, la bonne intention ayant déjà produit une
polarité inversée.

## Style du dépôt

Commentaires, documentation et noms de tests en **français** ; types, API et messages de
commit en anglais (des variables locales françaises existent dans le modèle, c'est assumé).

Les commentaires servent à porter le **pourquoi**, y compris celui des mécanismes *retirés* —
l'auto-avance après bonne réponse a été supprimée le 2026-08-23 et `ComboEngine`, `FeedView`
et `FeedViewModel` en gardent la trace datée. Une correction non évidente s'inscrit dans le
commentaire du type concerné, au même format ; ne pas nettoyer ces blocs en les prenant pour
du bavardage.

`docs/superpowers/` (spec et plan de la v1, puis de la seconde passe de contenu) et
`.superpowers/sdd/` (traces d'exécution, non suivies par git) sont de l'historique : on les
lit, on ne les met pas à jour.
