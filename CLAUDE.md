# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Valido — feed vertical infini de QCM (code de la route + Swift/iOS). iOS 26.2, SwiftUI,
Swift 6, projet Xcode à plat (pas de SwiftPM). Le `README.md` décrit le projet sans le
contraindre — les décisions et leur pourquoi vivent dans `docs/superpowers/specs/`. Ce
fichier ne porte que ce qui sert à travailler dans le dépôt.

## Commandes

```bash
# Le simulateur se démarre À LA MAIN d'abord, sinon « Busy » / preflight.
# L'UDID, jamais le nom — trois runtimes déclarent un « iPhone 17 Pro » (voir plus bas).
DEVELOPER_DIR=/Applications/Xcode-27.1.0.app xcrun simctl boot 66921B37-1805-4988-AB69-B51A94490BC0

# Toute la suite (84 tests, Swift Testing)
DEVELOPER_DIR=/Applications/Xcode-27.1.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,id=66921B37-1805-4988-AB69-B51A94490BC0'

# Un seul test — les PARENTHÈSES sont obligatoires
-only-testing:'ValidoTests/répartition70_30()'

python3 Tools/audit.py              # contrôles de forme + fraîcheur + couverture
python3 Tools/relire.py --fuites "Feux"   # une carte qui livre la réponse d'une autre
./Tools/render-scenes.sh            # regénère les schémas PNG (clair/sombre, @2x/@3x)
```

Deux pièges d'outillage, tous deux silencieux :

- **`-only-testing` sans `()`** exécute 0 test et affiche quand même `** TEST SUCCEEDED **`.
  Vérifier la ligne `✔ Test run with N test(s)`. (Les lignes `Executed 0 tests` de XCTest
  sont normales : Swift Testing rapporte à part.)
- **Trois runtimes (26.0/26.1/26.2) déclarent chacun un `iPhone 17 Pro`**, et seul celui de
  26.2 satisfait la cible — viser l'UDID ou `name=iPhone 17 Pro,OS=26.2`, jamais le nom
  seul, sinon `xcodebuild` refuse la destination en listant les trente devices écartés. Au
  2026-11-20 l'UDID est `66921B37-1805-4988-AB69-B51A94490BC0` ; le recompter avec
  `DEVELOPER_DIR=... xcrun simctl list devices available`. Un `Application failed preflight
  checks` / `Busy` sans qu'aucun test n'ait tourné est un simulateur coincé, pas une
  régression.

`audit.py` **sort toujours 0** : c'est le rapport qu'on lit, pas le code de retour. On
compare à la ligne de base, pas à zéro (relevée sur 464 questions) :

- **Doivent rester vides** : `schema/`, `couverture/`, `source/` (dont
  `source/editeur-non-corrobore`), `fuite/`, `image/`, `longueur/plus-10`,
  `forme/backtick-isole` — qui ne mord que si une option porte un backtick —,
  `notions/non-declaree`, `notions/sans-fondation`, `notions/carte-orpheline`.
- **Ligne de base** : `longueur/plus-longue` 77 (informatif, le seuil dur est `plus-10`),
  `expl/paraphrase-litterale` 20, `forme/seule-ponctuee` 14, et deux faux positifs connus,
  `lettre/reference` 1 et `forme/markdown` 1.
- **Compteurs de forme, informatifs** : `forme/impersonnel` 216, `forme/hors-situation` 189,
  `forme/definitionnel` 98. Ils mesurent l'écart avec l'épreuve réelle, pas un défaut :
  chaque carte `fondation` fait monter les deux premiers, une carte illustrée sort de
  `hors-situation`. Les faire baisser pour eux-mêmes est un contresens.

**`expl/paraphrase-litterale` n'est pas un compteur à minimiser** : sur une carte dont la
règle est un chiffre, il mesure l'objectif inverse. D'où vient chaque valeur, et pourquoi
ses mouvements passés sont voulus : [`Tools/audit-ligne-de-base.md`](Tools/audit-ligne-de-base.md).
Ce que l'outillage ne voit pas : `Tools/audit-2026-08-passe-3.md`, section « Ce que
l'outillage ne voit toujours pas ». Toute décision de réécriture part du §4 de
[`Tools/audit-2026-09-formes.md`](Tools/audit-2026-09-formes.md) — le relire, pas le
rejouer de mémoire. Le registre des sources est surchargeable par `VALIDO_SOURCES_MD`, pour
vérifier une règle sur un cas d'essai.

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

**Les neuf nombres réglables** (part pondérée 0,7 ; fenêtre anti-répétition 25 ; horizon 60 ;
plancher 0,05 ; `foundationBoost` 4,0 — le facteur appliqué à une carte `fondation` dont la
notion n'est pas encore acquise ; `masteryStreak` 4 — le nombre de bonnes réponses sur des
cartes distinctes qu'il faut pour acquérir une notion, plafonné au nombre de cartes de la
notion elle-même, si bien qu'une notion à deux cartes s'acquiert en deux…) vivent tous dans
`SchedulerConfig`, jamais en dur ailleurs.

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
464 questions (271 `code`, 193 `swift`), dont **76 illustrées**. L'`id` est soit un ancien id
de page Notion, soit `sha256("valido-v2:" + prompt)[:32]` — le préfixe est dans l'entrée du
hachage, pas dans l'identifiant. **Un `id` livré est immuable** : la progression est indexée
dessus. Les options sont mélangées à chaque présentation (**donc aucune référence de lettre
nulle part**, ni dans une option ni dans une explication).

Trois registres, tous trois imposés par `audit.py` :

- `Tools/sources.md` — la **fraîcheur** : une ligne par question `code`, déclarée `stable` ou
  `datée`, une `datée` portant l'URL d'un domaine de la liste blanche et sa date de relevé.
- `Tools/couverture.md` — la **couverture** : une ligne par couple (thématique ETG, `topic`).
  Un `topic` `code` qui n'y figure pas est refusé.
- `Tools/notions.md` — les **notions** : une ligne par notion, l'axe plus fin que `topic`
  porté par les 271 cartes `code`. `audit.py` refuse une notion absente du registre, une
  carte `code` sans notion, et une notion sans carte `fondation`.

Avant toute édition de questions, lire [`Tools/questions.md`](Tools/questions.md) : 7 règles
de distracteur, 9 pièges de forme, fraîcheur juridique (§5, sources officielles imposées),
questions illustrées (§7). Puis `audit.py`, puis `relire.py`, puis les tests.

[`Tools/relire.py`](Tools/relire.py) est en **lecture seule** et sort toujours 0, comme
`audit.py`. Deux modes : `relire.py "<domaine>"` met chaque carte en face de sa ligne de
`sources.md` — l'affirmation est la référence, la carte est ce qu'on vérifie contre elle, et
`audit.py` ne les affiche jamais ensemble ; `relire.py --fuites "<domaine>"` cherche les
explications qui livrent la bonne réponse d'une **autre** carte. **Ce que `--fuites` ne voit
pas** décide de la relecture à la main qui doit l'accompagner : il ignore toute bonne réponse
de moins de **trois mots pleins** (jetons d'au moins cinq caractères — « 1,6 mm » en compte
zéro), n'inspecte que les `explanation` et jamais les **options**, et ne reconnaît pas une
réponse redite en d'autres mots. Il **nomme** les bonnes réponses qu'il n'a pas testées :
c'est cette liste-là qu'on grep à la main.

`ValidoTests/BundledContentTests.swift` verrouille le livré : volume ≥ 425, ≥ 242 `code` et
≥ 183 `swift`, **≥ 68 illustrées**, aucune lettre de réponse en tête d'option ou
d'explication, équilibre de longueur (la bonne réponse ne dépasse pas de 10 caractères la
deuxième plus longue), résolution de chaque asset dans le bundle, `alt` ≥ 40 caractères, et
le budget de hauteur des illustrées (70 / 50 / 220 caractères). Les seuils de volume sont à
95 % du livré, 90 % pour les illustrées. **Un échec s'y corrige dans les données, jamais
dans le test.**

Images : un seul champ `Illustration { asset, alt }`. L'`alt` **est** l'énoncé pour qui
n'accède pas à l'image. **Un panneau se photographie, un marquage et une configuration se
dessinent** : un pictogramme normé ne se redessine pas à la main, une géométrie de voies
n'existe sur aucune photo. Deux origines — 52 schémas générés par `./Tools/render-scenes.sh`
(scènes sous `Tools/Scenes/`, on édite la scène, jamais les PNG ; un panneau planté dans une
scène se dessine une seule fois, dans `Tools/Scenes/Panneaux.swift`) et 25 photographies
Commons, préparées par `Tools/photo-panneau.py`. Une seule ne sert aucune carte, et c'est la
seule sans variante sombre : `ligne-jaune-continue`, orpheline depuis avant ce chantier. Tout
asset doit avoir sa ligne dans [`Tools/images.md`](Tools/images.md), sinon `audit.py` le
refuse. Aucune information ne repose sur la couleur seule — et ça **se mesure**
en niveaux de gris avant de commiter un PNG, la bonne intention ayant déjà produit une
polarité inversée.

## Style du dépôt

Commentaires, documentation et noms de tests en **français** ; types, API et messages de
commit en anglais (des variables locales françaises existent dans le modèle, c'est assumé).

**Pas de commentaire, sauf si le code ne suffit pas à comprendre.** La règle se teste, et
elle se teste en supprimant : si le code se comprend sans, le commentaire part — on ne le
raccourcit pas, on ne le reformule pas. `weightedShare = 0.7` n'a pas besoin qu'on écrive
« 0,7 des tirages sont pondérés ». Trois cas seulement y survivent, et c'est tout ce que le
dépôt garde (56 lignes sur les 1 000 de `Valido/`) :

- **une absence** — un mécanisme refusé ou retiré ne se lit jamais dans le code. L'auto-avance
  supprimée le 2026-08-23 (`FeedView`), la série quotidienne refusée (`ComboEngine`), le
  rognage par l'avant écarté (`FeedViewModel`) ;
- **un piège d'API** — `Color.clear` cadré avant l'`overlay`, `.viewAligned` plutôt que
  `.paging`, les `fixedSize` qui empêchent la troncature (`QuestionCardView`) ;
- **une unité ou une intention qu'un nom ne porte pas** — les sept champs de
  `SchedulerConfig`, l'`alt` qui *est* l'énoncé (`Question`).

Écrire court. Le reste du « pourquoi » va dans la spec sous `docs/superpowers/specs/`, pas
en commentaire et pas dans le `README.md`, qui décrit le projet sans le contraindre.

`docs/superpowers/specs/` garde les specs de design ; les plus anciennes sont de
l'historique : on les lit, on ne les met pas à jour. `docs/superpowers/plans/` ne garde que
les plans **en cours** — un plan se supprime quand son travail est livré et que son rapport
le résume.
