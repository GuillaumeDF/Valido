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

**310 questions** embarquées dans le bundle : 136 sur le code de la route, 174 sur
Swift/iOS. Aucun réseau, aucun compte, aucun secret dans l'app.

Huit de ces questions ont leur énoncé **dans une image** — carrefour, panneau, vue
conducteur. Sans l'image, « qui passe en premier ? » n'a pas de sens : elle n'illustre
pas, elle énonce.

## Les décisions qui structurent le reste

Elles sont détaillées dans [`docs/superpowers/specs/2026-08-22-valido-design.md`](docs/superpowers/specs/2026-08-22-valido-design.md).
Les cinq qui expliquent le plus de code :

**Verdict symétrique, aucune avance programmatique.** Juste ou faux, l'explication
s'ouvre, et c'est le balayage qui fait avancer. La spec prévoyait l'inverse — auto-avance
après 400 ms sur une bonne réponse — et cette asymétrie a été retirée le 2026-08-23 avec
les trois défauts qui vivaient dedans : gel du feed, relance périmée qui ramenait une
carte en arrière, course entre annulation et réveil. On apprend maintenant sur toute la
banque, pas seulement sur ce qu'on rate. La mise reste réelle : perdre un ×12 est la
punition de la faute, l'interruption n'était pas la seule sanction.

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

**Le bandeau d'image cède, le texte jamais.** Une question illustrée montre son image en
haut de carte — jusqu'à 38 % de la hauteur avant réponse, 18 % après, l'image ayant fait
son travail dès que le verdict est là. Mais ces fractions sont des plafonds : aucun texte
de la carte n'est compressible (voir les `fixedSize` de `QuestionCardView`), donc quand
l'énoncé, les quatre options et l'explication réclament la place, c'est l'image qui
recule. Sur la carte la plus chargée elle descend à 8 %. La contrainte remonte donc dans
la rédaction — une question illustrée se tient courte — et pas dans le layout.

Les sept nombres qu'on voudra bricoler après trois jours d'usage vivent tous dans
[`SchedulerConfig`](Valido/Model/SchedulerConfig.swift).

## Structure

```
Valido/
  Model/       20 types, tous `nonisolated` — QuestionBank, CardScheduler,
               ComboEngine, ProgressStore, SchedulerConfig, Illustration…
  ViewModel/   FeedViewModel, @MainActor
  View/        FeedView, QuestionCardView, ComboBadge, ContentErrorView
  Resources/   questions.json
  Assets.xcassets/Scenes/   8 imagesets : 6 schémas dessinés, 2 photos
ValidoTests/   62 tests (Swift Testing)
Tools/         guide de rédaction, rendu des schémas, audit, provenance des images
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

`CardScheduler` reste la pièce la plus testée, et elle est écrite pour ça — répartition
70/30 sur 1000 tirages à graine fixe, fenêtre anti-répétition, question jamais vue qui
passe devant, question maîtrisée qui reste tirable, banque plus petite que la fenêtre.

## Les questions

`Valido/Resources/questions.json` **est** la source. Il n'y a pas de génération : on édite
le fichier, on repasse les contrôles, on lance les tests.

- [`Tools/questions.md`](Tools/questions.md) — le guide de rédaction : les 7 règles de
  distracteur, la condensation, les 9 pièges de forme, les contrôles avant écriture, la
  fraîcheur juridique, et le §7 sur les questions illustrées.
- [`Tools/images.md`](Tools/images.md) — la provenance de chaque image : source, auteur,
  licence, date de relevé. `audit.py` refuse un asset qui n'y a pas sa ligne, sans quoi
  une image devient orpheline et impossible à re-sourcer.
- `swift Tools/render-scenes.swift` — regénère les six schémas de carrefour en PNG clair
  et sombre, @2x et @3x. Les fichiers ne s'éditent jamais à la main : on édite la scène.
- `python3 Tools/audit.py` — les contrôles mécaniques.
- [`Tools/audit-2026-08.md`](Tools/audit-2026-08.md) — la dernière passe : ce qui a été
  corrigé, avec les sources, et ce qui reste ouvert.

Ce qui décide de la qualité du feed : **un distracteur manifestement faux rend la question
gratuite**, gonfle le combo et rend le feed ennuyeux — exactement le mode d'échec que ce
projet existe pour éviter. Et la bonne réponse ne doit jamais être la plus longue des
quatre : c'est l'indice le plus fiable de tout QCM. Les options sont mélangées à chaque
présentation, donc aucune référence de lettre nulle part.

Les 136 questions de code de la route se périment : le droit bouge. La passe d'août 2026 a
trouvé trois questions aux chiffres faux, dont une qui l'était depuis trois jours. Le §5 du
guide dit quoi revérifier, où, et comment citer.

## Les images

Deux origines, un seul champ dans le modèle (`Illustration` : un nom d'asset et un `alt`),
et **aucun réseau** — tout est dans le catalogue d'assets, `URLSession` n'existe nulle
part dans le projet.

**Six schémas dessinés** par `Tools/render-scenes.swift`, en CoreGraphics, sur le modèle
de `design/logo/render-icon.swift`. C'est le choix qui compte : la scène et la bonne
réponse sortent de la même donnée, donc « qui passe en premier » se vérifie au lieu de
s'espérer. Une photo trouvée et une réponse rédigée sont deux artefacts indépendants qui
peuvent se contredire en silence. Les formes de panneaux sont redessinées d'après
l'Instruction interministérielle sur la signalisation routière — la géométrie d'un panneau
réglementaire est une norme publique. Aucun visuel d'éditeur d'ETG n'a été repris.

**Deux photographies** de Wikimedia Commons, recadrées en 4:3, pour ce que le vectoriel ne
sait pas faire : la vue conducteur. Le recadrage garde l'élément décisif dans la bande
centrale, celle qui survit au rétrécissement du bandeau.

Aucune information ne repose sur la couleur seule : le véhicule du candidat porte un
liseré blanc, et les options désignent les autres **par leur provenance**, pas par leur
teinte.

## Limite connue

310 questions ne font pas un feed infini : à 30 questions par session, la banque est
consommée en une quinzaine. La v1 répond à une seule question — la boucle tient-elle sur
moi ? Si elle tient, le chantier suivant n'est pas une fonctionnalité, c'est la génération
de questions depuis les pages de cours, qui alimentera le même `questions.json`.

Reportés, assumés : carte boss, duel, notifications, écran de statistiques, onboarding.
