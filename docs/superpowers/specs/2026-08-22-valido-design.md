# Valido — design V1

Date : 2026-08-22
Statut : validé, prêt pour plan d'implémentation

## 1. Intention

Remplacer le scroll passif d'Instagram/TikTok par un flux qui révise. L'app doit
donner envie d'être ouverte sans raison, et ne jamais donner l'impression d'un
devoir. Deux matières au départ : le code de la route et Swift/iOS.

Le critère de réussite n'est pas un score d'apprentissage, c'est un réflexe :
ouvrir Valido dans le bus au lieu d'Instagram.

## 2. Décisions structurantes

| Décision | Choix | Raison |
|---|---|---|
| Boucle centrale | Un feed vertical infini ; tout le reste sera un *type de carte* dedans | Aucun menu, aucune décision avant de réviser. Les modes séparés (duel, roguelite) deviennent du contenu, pas de la navigation. |
| Contenu | Import one-shot depuis Notion vers un JSON embarqué | Jouable immédiatement, hors-ligne, aucun secret dans l'app, porte App Store laissée ouverte. |
| Leviers d'addiction | Combo en session + imprévisibilité | Les deux seuls qui fonctionnent seul, hors-ligne, avec une petite banque. |
| Série quotidienne | **Non** | Écartée volontairement : le jour où elle casse, on abandonne l'app. La rétention repose sur l'imprévisibilité, pas sur la culpabilité. |
| Sélection | Un feed mélangé, pondéré par la faiblesse, avec un quota d'aléatoire garanti | Sert l'apprentissage sans être lisible. Le mélange des matières fait comporter 250 questions comme un pool bien plus large. |
| Verdict | **Asymétrique** : juste → enchaîne seul ; faux → bloque sur l'explication | Flow arcade quand on sait, leçon seulement quand il y a un trou. Être arrêté devient le coût de la faute, ce qui donne du poids au combo. |
| Fin de session | Aucun écran de fin | Un « bravo, terminé ! » est une porte de sortie. |
| Persistance | Fichier JSON derrière un protocole, pas SwiftData | L'état canonique est un agrégat borné (250 lignes, ~30 Ko). SwiftData gagnera sa place le jour où il faudra des courbes dans le temps. |

## 3. Le contenu

### Source

Deux bases Notion, déjà homogènes :

| Base | Emplacement | Volume | Axes |
|---|---|---|---|
| `QCM Code` | Perso › Code de la route | **100** | 10 thèmes × 10, difficulté Facile/Moyen/Costaud |
| `Quiz Swift` | Work › Swift | **150** | 14 sections (Langage 38, Concurrence 20, SwiftUI 17, Outillage 17, Architecture 14…), même échelle |

**Correction du 2026-08-22 (découverte à l'implémentation).** Cette section affirmait
un format identique dans les deux bases. C'était faux : la vérification n'avait porté
que sur une page de `QCM Code`, et la similitude des schémas de propriétés avait été
prise à tort pour une similitude des corps de page. Les deux bases n'ont pas la même
forme.

`QCM Code` — un vrai QCM :

- le **titre** est l'énoncé ;
- le **corps** contient des puces `A.` à `D.` ;
- un bloc `<details>` de résumé « 👀 Réponse » contient la bonne lettre en gras
  suivie de l'explication — deux variantes observées : `**B — 100 km/h.** …` et `**B.** …`.

`Quiz Swift` — un jeu de **fiches**, pas un QCM :

- le **titre** est une question ouverte (« La macro `@Entry` (iOS 18) ? ») ;
- le **corps** ne contient qu'un bloc `<details>` avec la réponse en texte libre ;
- **aucune option** ;
- une propriété `Page` (URL) pointe vers la note de cours.

Décision de Guillaume : convertir les fiches en QCM plutôt que renoncer à la moitié
Swift. Pour chaque fiche, trois mauvaises réponses sont générées, la bonne réponse est
condensée en une proposition de longueur comparable, et le texte d'origine de la fiche
devient l'`explanation`. Contrainte de qualité qui décide de la réussite : un distracteur
manifestement faux rend la question gratuite, gonfle le combo et rend le feed ennuyeux —
soit exactement le mode d'échec que ce projet existe pour éviter. La proposition correcte
ne doit jamais être la plus longue : c'est l'indice le plus fiable de tout QCM.

Une fiche dont la réponse est une liste, un extrait de code, ou trop ouverte pour avoir
une seule bonne proposition n'est pas convertie de force : elle est écartée avec son
motif. Un 135 honnête vaut mieux qu'un 150 rempli au forceps.

### Import

Les corps de page ne sortent pas d'une requête SQL Notion — seules les propriétés
en sortent. L'import lit donc les 250 pages une par une, en lots parallèles, et
écrit un unique `Valido/Resources/questions.json` versionné dans le projet.
Une fois l'import fait, l'app ne parle plus jamais à Notion.

Abandonnés à l'import : `Seed`, `Vu le` et la formule *Ordre du jour*. C'était le
système de révision manuel dans Notion ; l'app le remplace.

La validation vit **à l'import, une seule fois, hors de l'app**. Une question est
rejetée — avec un rapport listant les rejets — si elle a moins de 2 options, ou si
aucune bonne lettre n'est extractible. Le JSON embarqué est donc garanti valide.

La procédure d'import est documentée dans `Tools/import-notion.md` pour pouvoir
être rejouée.

## 4. Modèle de données

```swift
struct Question: Identifiable, Codable, Sendable {
    let id: String          // ID de page Notion — stable entre deux imports
    let subject: Subject    // .code | .swift
    let topic: String       // « Vitesse », « Concurrence »…
    let difficulty: Difficulty  // .facile | .moyen | .costaud
    let prompt: String
    let options: [Option]   // 2 à 4
    let correctID: Option.ID
    let explanation: String
    let sourceURL: URL?     // seul Quiz Swift en a → bouton « approfondir »
}
```

**Les options sont mélangées à chaque présentation.** Dans les deux bases, la bonne
réponse est en B dans une large majorité des cas ; sans mélange on apprend la lettre
au lieu de la règle et le feed devient trivial en deux sessions. D'où `correctID`
plutôt qu'un index : l'ordre d'affichage change, l'identité de la bonne réponse non.

## 5. Architecture

Cinq unités, chacune compréhensible et testable seule. `CardScheduler` et
`ComboEngine` ne connaissent pas SwiftUI ; `FeedView` ne connaît aucune règle.
Les trois nombres qu'on voudra bricoler après trois jours d'usage (70/30, taille de
la fenêtre anti-répétition, formule de poids) vivent à un seul endroit.

**Correction du 2026-08-23.** Le paquet SwiftPM `ValidoCore` a été supprimé. Il existait
pour une seule raison — `swift test` en une seconde sans simulateur — mais Guillaume veut
lire son code d'un seul tenant sur un petit projet perso. Mesure faite après coup : le
cycle `xcodebuild test` prend **4 secondes** à chaud, pas les 40 annoncées. Le paquet ne
payait donc presque rien.

Tout vit dans la cible app, en MVVM explicite :

```
Valido/
  ValidoApp.swift
  Model/       Question · QuestionBank · ContentError · QuestionStats · ProgressSnapshot
               ProgressStore · FileProgressStore · Card · SchedulerConfig · CardScheduler
               ComboEngine · AnyRandomNumberGenerator
  ViewModel/   FeedViewModel.swift          (ex-FeedModel)
  View/        FeedView · QuestionCardView · ComboBadge · ContentErrorView
  Resources/   questions.json               (lu via Bundle.main)
ValidoTests/   44 tests, cible Xcode + scheme partagé
```

Deux conséquences non évidentes du déplacement :

- La cible app compile avec `SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor`, que le paquet
  n'avait pas. Tous les types du modèle s'en trouvaient isolés au MainActor alors que ce
  sont des types valeur `Sendable` faits pour être utilisables partout — la cible de tests
  refusait de compiler. Les 19 types de `Model/` sont donc marqués `nonisolated`
  (SE-0466), ce qui énonce la couche : **le modèle est sans isolation, le view model est
  `@MainActor`, les vues suivent.**
- `Valido/` est un dossier synchronisé (`objectVersion = 77`), donc `Resources/questions.json`
  est copié dans le bundle sans entrée dans le `.pbxproj`. Vérifié : 250 questions dans
  `Valido.app`.

Deux fichiers qui portaient deux types chacun ont été séparés au passage :
`QuestionStats` / `ProgressSnapshot`, et `FeedViewModel` / `AnyRandomNumberGenerator`.

## 6. Le moteur du feed

### L'horloge

Pas de `Date()`. Un compteur monotone `serveIndex`, incrémenté à chaque carte servie
et persisté, sert d'horloge. Conséquence : le scheduler est entièrement déterministe
et testable, et « il y a longtemps » se mesure en cartes vues plutôt qu'en jours —
ce qui est de toute façon la bonne unité pour un feed.

### La signature

```swift
func nextCard(bank: QuestionBank,
              progress: ProgressSnapshot,
              recent: [Question.ID],
              rng: inout some RandomNumberGenerator) -> Card
```

Rien d'implicite : ni horloge cachée, ni aléatoire caché. À graine fixe, la même
entrée donne toujours la même sortie — le 70/30 se teste au lieu de s'espérer.

### La règle

- **70 %** — tirage pondéré :

  ```
  poids(q) = poidsÉchec(q) × poidsAncienneté(q)

  poidsÉchec(q)      = 3.0                              si jamais vue
                     = 0.3 + 2.7 × (fautes / tentatives) sinon

  poidsAncienneté(q) = 1.0                                        si jamais vue
                     = max(0.05, min(1.0, (serveIndex - lastServeIndex) / 60))
  ```

  Une question ratée hier pèse lourd ; une question juste cinq fois de suite tombe
  presque à zéro **sans jamais disparaître** (plancher 0.05).

- **30 %** — tirage uniforme sur les 250, sans aucune condition. Quota
  d'imprévisibilité **garanti** : c'est lui qui empêche l'algorithme de devenir lisible.

- **Anti-répétition** — les **25** dernières cartes servies sont exclues des deux
  tirages. Sans ça le hasard ressort la même question deux cartes plus loin et
  l'illusion d'infini casse.

### Le combo

`ComboEngine`, machine à états minuscule : juste → `multiplier += 1` ; faux →
`multiplier = 0` et la carte passe en état « bloquée sur l'explication ». C'est elle
qui décide si la carte s'auto-enchaîne ou attend le swipe : la règle asymétrique
vit à un seul endroit.

## 7. L'interaction

`ScrollView` vertical paginé, une carte plein écran, alimentée par le scheduler à
l'approche du bas.

**Correction du 2026-08-23 (bug observé).** Cette section exigeait une fenêtre glissante
« qui se vide derrière », au motif que « c'est ce qui rend le flux réellement infini
plutôt qu'une longue liste ». Ce motif était faux, et il a causé un bug visible : ce qui
rend le flux infini est la paresse du `LazyVStack`, qui ne matérialise que les lignes
visibles quelle que soit la longueur du tableau. Rogner l'avant n'achetait donc que de la
mémoire — négligeable, quelques centaines de kilooctets sur une session d'une heure — et
coûtait un saut visible à chaque balayage à partir de la 6e carte : retirer `cards[0]`
supprime une carte entière de contenu au-dessus de la zone visible pendant que le
`ScrollView` résout son calage, l'obligeant à recalculer son décalage.

Le tableau ne fait donc que croître. Seul le `lookahead` de 3 cartes subsiste.

Le feel, où ça se gagne ou se perd :

- verdict en **moins de 100 ms** — la couleur change avant que le doigt ne se lève ;
- `.sensoryFeedback(.success)` sur juste, `.error` sur faux — l'haptique fait plus
  pour la sensation de jeu que n'importe quelle animation ;
- combo affiché en haut, intensité visuelle croissante **à partir de ×5** : il doit
  devenir inquiétant à perdre ;
- **juste** → auto-avance après **400 ms** : assez pour voir le vert, trop court pour s'ennuyer ;
- **faux** → l'explication s'ouvre, l'avance est bloquée jusqu'au swipe.

### Types de cartes en V1 : la carte question, et rien d'autre

La carte boss (« 5 d'affilée ou tu perds tout ») est explicitement reportée : elle
n'a de valeur que si le combo est déjà quelque chose qu'on craint de perdre.
Construire la peur d'abord, la mesurer une semaine, ajouter la carte ensuite.
`Card` est un `enum` précisément pour que cet ajout ne touche à rien d'autre.

En V1 la surprise vient de trois sources : quelle question, quelle matière (Swift
qui débarque au milieu du code de la route), et un enjeu de combo qui monte seul.

## 8. Persistance

État canonique = un agrégat **borné** : par question `attempts`, `failures`,
`lastServeIndex`, plus le `serveIndex` global. Soit 250 lignes de taille fixe pour
toujours, ~30 Ko.

Écarté volontairement : le journal d'événements (une tentative = une ligne) et le
temps de réponse. Le journal croît sans borne (~70 000 lignes par an à raison de
200 réponses/jour) pour un besoin que l'agrégat couvre ; le temps de réponse ne sert
aucune mécanique de la V1 — il redeviendra pertinent avec le duel.

Écriture disque groupée (changement de scène, ou toutes les 5 réponses), jamais à
chaque tap.

## 9. Cas limites

| Cas | Comportement | Raison |
|---|---|---|
| `questions.json` absent ou indécodable | Écran d'erreur franc au lancement | C'est un bug de build, pas un cas utilisateur. Pas de feed vide silencieux. |
| Question malformée | Rejetée **à l'import**, avec rapport | La validation vit hors de l'app ; le bundle est garanti valide. |
| Fichier de progression corrompu | Repart de zéro, sans message | Perdre l'historique se rattrape en deux sessions ; bloquer l'app, non. |
| Toutes les questions dans la fenêtre anti-répétition | La fenêtre est tronquée jusqu'à ce qu'un tirage soit possible | Garantit que `nextCard` rend toujours une carte, même avec une banque minuscule. |

## 10. Tests

En TDD. `CardScheduler` est le morceau qui mérite le plus de tests, et il est écrit
pour ça.

- **`CardSchedulerTests`** — RNG à graine fixe : répartition 70/30 sur 1000 tirages ;
  la fenêtre anti-répétition est respectée ; une question jamais vue passe devant ;
  une question maîtrisée reste tirable ; le cas dégénéré de la banque plus petite que
  la fenêtre.
- **`ComboEngineTests`** — incrément, remise à zéro, état bloquant.
- **`BundledContentTests`** — charge le `questions.json` livré et vérifie les
  invariants : 250 entrées, ≥2 options chacune, `correctID` présent dans `options`,
  explication non vide, `id` uniques. Ce test remplace le test de parseur envisagé en
  discussion : le parsing se fait une fois hors du dépôt, donc on valide le produit
  livré plutôt que d'embarquer du code de parsing mort.
- **`ProgressStoreTests`** — aller-retour, fichier corrompu, agrégat correct après
  une série de tentatives.

Pas de tests d'UI en V1.

## 11. Hors périmètre V1

Assumé, pas oublié : série quotidienne, social/duel/classement, carte boss, images
et photos de situation, notifications push, génération de contenu, écran de
statistiques, onboarding, écran de fin de session.

## 12. Mise en place et ordre de construction

Le projet Xcode est un squelette (`ContentView` par défaut, iOS 26.2, aucun test). Il utilise
`objectVersion = 77` avec dossiers synchronisés : tout `.swift` créé sur le disque sous `Valido/`
est compilé sans édition du `.pbxproj`. Mise en place : créer le paquet `ValidoCore` (qui apporte
sa propre cible de tests), déclarer la dépendance locale dans la cible app, et passer
`SWIFT_VERSION` de 5.0 à 6.0.

Ordre suggéré, chaque étape vérifiable seule :

1. Le paquet `ValidoCore` + `Question`.
2. `QuestionBank` et la validation.
3. Import Notion → `questions.json` + `BundledContentTests` verts.
4. `ProgressStore` (protocole + les deux implémentations).
5. `CardScheduler` en TDD — le cœur, avant toute UI.
6. `ComboEngine` en TDD.
7. `FeedModel` + fenêtre glissante.
8. Câblage du paquet dans la cible Xcode, Swift 6, build vert.
9. `FeedView` / `QuestionCardView` — feel, haptique, timings.

Plan détaillé : `docs/superpowers/plans/2026-08-22-valido-v1.md`.

## 13. Limite connue

250 questions ne font pas un feed infini : à 30 questions par session, la banque est
consommée en une semaine. La V1 sert à répondre à une seule question — la boucle
tient-elle sur moi ? Si elle tient, le chantier suivant n'est pas une fonctionnalité,
c'est la génération de questions depuis les pages de cours Notion (14 sections Swift,
une page Code de la route entière), qui alimentera le même `questions.json`.

Note : la conversion des fiches Swift (§3) est une première incursion dans ce chantier,
arrivée plus tôt que prévu et pour une autre raison. Elle en valide au passage le
mécanisme — génération, relecture, injection dans le même `questions.json` — donc le
chantier suivant part avec un précédent plutôt que d'une page blanche.
