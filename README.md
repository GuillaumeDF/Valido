# Valido

Un feed vertical infini qui révise. L'idée est de prendre la place du scroll passif
d'Instagram ou TikTok : même geste, même absence de friction, mais chaque carte est une
question. Deux matières mélangées, le code de la route et Swift/iOS.

Le critère de réussite n'est pas un score d'apprentissage. C'est un réflexe : ouvrir
Valido dans le bus au lieu d'Instagram.

Projet perso, iOS 26.2, SwiftUI, Swift 6.

---

## Ce qui tourne

Une seule boucle : un `ScrollView` paginé, une carte plein écran, alimentée à l'approche
du bas. Pas de menu, pas d'écran d'accueil, pas d'écran de fin de session — un « bravo,
terminé ! » est une porte de sortie.

**302 questions** embarquées dans le bundle : 128 sur le code de la route, 174 sur
Swift/iOS. Aucun réseau, aucun compte, aucun secret dans l'app.

## Les décisions qui structurent le reste

Elles sont détaillées dans [`docs/superpowers/specs/2026-08-22-valido-design.md`](docs/superpowers/specs/2026-08-22-valido-design.md).
Les quatre qui expliquent le plus de code :

**Verdict asymétrique.** Bonne réponse → la carte s'enchaîne seule après 400 ms. Mauvaise
réponse → l'explication s'ouvre et l'avance est bloquée jusqu'au swipe. Le flow arcade
quand on sait, la leçon seulement quand il y a un trou. Être arrêté devient le coût de la
faute, ce qui donne du poids au combo.

**Pas de série quotidienne.** Écartée volontairement : le jour où elle casse, on abandonne
l'app. La rétention repose sur l'imprévisibilité, pas sur la culpabilité.

**Le scheduler ne cache rien.** `nextCard(bank:progress:recent:rng:)` — ni horloge cachée,
ni aléatoire caché. Et pas de `Date()` : un compteur monotone `serveIndex` sert d'horloge,
donc « il y a longtemps » se mesure en cartes vues. À graine fixe, la même entrée donne
toujours la même sortie, et le 70/30 se teste au lieu de s'espérer.

**Un quota d'aléatoire garanti.** 70 % des tirages sont pondérés par la faiblesse
(taux de faute × ancienneté), 30 % sont uniformes et sans condition. C'est ce tiers qui
empêche l'algorithme de devenir lisible. Les 25 dernières cartes sont exclues des deux
tirages, sans quoi le hasard ressort la même question deux cartes plus loin et l'illusion
d'infini casse. Une question maîtrisée voit son poids tomber presque à zéro **sans jamais
disparaître** — plancher à 0,05.

Les sept nombres qu'on voudra bricoler après trois jours d'usage vivent tous dans
[`SchedulerConfig`](Valido/Model/SchedulerConfig.swift).

## Structure

```
Valido/
  Model/       19 types, tous `nonisolated` — QuestionBank, CardScheduler,
               ComboEngine, ProgressStore, SchedulerConfig…
  ViewModel/   FeedViewModel, @MainActor
  View/        FeedView, QuestionCardView, ComboBadge, ContentErrorView
  Resources/   questions.json
ValidoTests/   57 tests (Swift Testing)
Tools/         guide de rédaction des questions, script d'audit, rapports
design/logo/   planches du logo et de l'icône
docs/          spec et plan de la v1
```

La cible compile avec `SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor`, ce qui isolerait aussi
les types du modèle — or ce sont des types valeur `Sendable` faits pour être utilisables
partout. D'où les `nonisolated` (SE-0466), qui énoncent la couche : **le modèle est sans
isolation, le view model est `@MainActor`, les vues suivent.**

`Valido/` est un dossier synchronisé (`objectVersion = 77`) : tout `.swift` créé sur le
disque est compilé sans toucher au `.pbxproj`.

## Lancer et tester

```bash
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,name=iPhone 17'
```

Un échec sur `Application failed preflight checks` / `Busy` sans qu'aucun test n'ait
tourné est un simulateur coincé, pas une régression : changer de device.

`CardScheduler` est la pièce la plus testée, et elle est écrite pour ça — répartition
70/30 sur 1000 tirages à graine fixe, fenêtre anti-répétition, question jamais vue qui
passe devant, question maîtrisée qui reste tirable, banque plus petite que la fenêtre.

## Les questions

`Valido/Resources/questions.json` **est** la source. Il n'y a pas de génération : on édite
le fichier, on repasse les contrôles, on lance les tests.

- [`Tools/questions.md`](Tools/questions.md) — le guide de rédaction : les 7 règles de
  distracteur, la condensation, les 9 pièges de forme, les contrôles avant écriture, la
  fraîcheur juridique.
- `python3 Tools/audit.py` — les contrôles mécaniques.
- [`Tools/audit-2026-08.md`](Tools/audit-2026-08.md) — la dernière passe : ce qui a été
  corrigé, avec les sources, et ce qui reste ouvert.

Ce qui décide de la qualité du feed : **un distracteur manifestement faux rend la question
gratuite**, gonfle le combo et rend le feed ennuyeux — exactement le mode d'échec que ce
projet existe pour éviter. Et la bonne réponse ne doit jamais être la plus longue des
quatre : c'est l'indice le plus fiable de tout QCM. Les options sont mélangées à chaque
présentation, donc aucune référence de lettre nulle part.

Les 128 questions de code de la route se périment : le droit bouge. La passe d'août 2026 a
trouvé trois questions aux chiffres faux, dont une qui l'était depuis trois jours. Le §5 du
guide dit quoi revérifier, où, et comment citer.

## Limite connue

302 questions ne font pas un feed infini : à 30 questions par session, la banque est
consommée en une quinzaine. La v1 répond à une seule question — la boucle tient-elle sur
moi ? Si elle tient, le chantier suivant n'est pas une fonctionnalité, c'est la génération
de questions depuis les pages de cours, qui alimentera le même `questions.json`.

Reportés, assumés : carte boss, duel, notifications, écran de statistiques, onboarding,
images de situation.
