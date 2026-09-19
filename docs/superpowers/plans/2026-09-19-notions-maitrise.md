# Notions et maîtrise — plan d'implémentation

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Faire que Valido enseigne un système avant de l'exercer, sans sortir de la boucle question → réponse → mémo.

**Architecture:** Un axe `notion` plus fin que `topic` et un `role` (`fondation` / `application`) sur chaque carte `code` ; un registre `Tools/notions.md` dont `audit.py` refuse qu'une notion n'ait aucune fondation ; un facteur multiplicatif appliqué dans `weightedPick` aux fondations des notions non acquises ; une acquisition par notion stockée dans `ProgressSnapshot` et qui ne se reperd jamais.

**Tech Stack:** Swift 6, SwiftUI, Swift Testing, `SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor`, projet Xcode à plat, Python 3 pour l'outillage.

**Spec:** [`docs/superpowers/specs/2026-09-19-notions-maitrise-design.md`](../specs/2026-09-19-notions-maitrise-design.md)

**Hors périmètre, plan séparé :** les quatre domaines absents du §6.3 de la spec (ADAS, boîte automatique, instruments du tableau de bord, prise d'information — une vingtaine de cartes neuves à sourcer). Ils ne dépendent que du schéma livré par la tâche 1 ; les mêler ici ferait un plan qu'on ne finit pas.

## Global Constraints

- Tout nouveau type de `Valido/Model/` porte `nonisolated` et est `Sendable` (SE-0466, la cible compile avec `SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor`).
- **Aucun `Date()`**, aucun `random()` implicite dans la chaîne `CardScheduler` → `ProgressSnapshot`. Le temps est `ProgressSnapshot.serveIndex`.
- **Un `id` livré est immuable.** Aucune tâche ne réécrit un `id` de `questions.json`.
- Les sept nombres existants de `SchedulerConfig` ne bougent pas. Les deux nouveaux vivent au même endroit, jamais en dur ailleurs.
- `audit.py` **sort toujours 0** : on lit le rapport, pas le code de retour.
- Compteurs devant rester vides : `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10`, `forme/backtick-isole`, plus les trois `notions/` créés ici.
- Compteurs informatifs à comparer à la ligne de base, **jamais à zéro** : `longueur/plus-longue` 76, `expl/paraphrase-litterale` 20, `forme/impersonnel` 199, `forme/hors-situation` 200, `forme/definitionnel` 94.
- Commentaires : seulement là où le code ne suffit pas à comprendre. Noms de tests et commentaires en français, types et messages de commit en anglais.
- Commande de test (l'UDID, jamais le nom — trois runtimes déclarent un `iPhone 17 Pro`) :
  ```bash
  DEVELOPER_DIR=/Applications/Xcode-27.0.0.app xcodebuild test \
    -project Valido.xcodeproj -scheme Valido \
    -destination 'platform=iOS Simulator,id=66921B37-1805-4988-AB69-B51A94490BC0'
  ```
  Ne juger que la ligne `✔ Test run with N test(s)` — un `** TEST SUCCEEDED **` sans elle ne prouve rien.

---

## File Structure

| fichier | responsabilité | tâche |
|---|---|---|
| `Valido/Model/Question.swift` | `Role`, `notion`, `role` sur `Question` | 1 |
| `Valido/Model/NotionProgress.swift` *(créé)* | la série en cours et l'acquisition d'une notion | 2 |
| `Valido/Model/ProgressSnapshot.swift` | stockage par notion + décodage tolérant | 2 |
| `Valido/Model/SchedulerConfig.swift` | `foundationBoost`, `masteryStreak` | 3 |
| `Valido/Model/CardScheduler.swift` | `boost(for:progress:)` appliqué dans `weightedPick` | 3 |
| `Valido/ViewModel/FeedViewModel.swift` | câble la réponse à la progression de notion, expose le compte acquis | 4 |
| `Valido/View/NotionBadge.swift` *(créé)* | le compteur de maîtrise, à côté de `ComboBadge` | 9 |
| `Tools/notions.md` *(créé)* | le registre : une ligne par notion | 5 |
| `Tools/audit.py` | les deux clés au schéma, les trois contrôles `notions/` | 5, 8 |
| `Tools/couverture.md` | second axe : les quatorze libellés de compétence du spécimen | 8 |
| `Valido/Resources/questions.json` | `notion` + `role` sur 255 cartes, puis les fondations neuves | 6, 7, 8 |
| `ValidoTests/BundledContentTests.swift` | verrouille le livré annoté | 8 |

---

### Task 1: Le schéma — `Role` et `notion` sur `Question`

**Files:**
- Modify: `Valido/Model/Question.swift`
- Test: `ValidoTests/QuestionBankTests.swift`

**Interfaces:**
- Consumes: rien.
- Produces: `Role` (`enum Role: String, Codable, Sendable { case fondation, application }`), `Question.notion: String?`, `Question.role: Role?`, et le paramètre `notion:`/`role:` de `Question.init` (défaut `nil` pour les deux).

- [ ] **Step 1: Écrire le test qui échoue**

Dans `ValidoTests/QuestionBankTests.swift` :

```swift
@Test func uneCarteSansNotionSeDécodeEncore() throws {
    let json = """
    [{"id":"a1","subject":"code","topic":"Vitesse","difficulty":"facile",
      "prompt":"Énoncé","options":[{"id":"A","text":"a"},{"id":"B","text":"b"},
      {"id":"C","text":"c"},{"id":"D","text":"d"}],
      "correctID":"B","explanation":"Explication"}]
    """.data(using: .utf8)!

    let questions = try JSONDecoder().decode([Question].self, from: json)
    #expect(questions[0].notion == nil)
    #expect(questions[0].role == nil)
}

@Test func uneCarteAnnotéePorteSaNotionEtSonRôle() throws {
    let json = """
    [{"id":"a2","subject":"code","topic":"Panneaux & marquage","difficulty":"facile",
      "prompt":"Énoncé","options":[{"id":"A","text":"a"},{"id":"B","text":"b"},
      {"id":"C","text":"c"},{"id":"D","text":"d"}],
      "correctID":"B","explanation":"Explication",
      "notion":"panneaux/formes","role":"fondation"}]
    """.data(using: .utf8)!

    let questions = try JSONDecoder().decode([Question].self, from: json)
    #expect(questions[0].notion == "panneaux/formes")
    #expect(questions[0].role == .fondation)
}
```

- [ ] **Step 2: Lancer les tests pour les voir échouer**

Run : la commande de test des Global Constraints, puis `grep` sur la sortie.
Expected : FAIL — `value of type 'Question' has no member 'notion'`.

- [ ] **Step 3: Implémenter**

Dans `Valido/Model/Question.swift`, après l'enum `Difficulty` :

```swift
nonisolated enum Role: String, Codable, Sendable {
    case fondation
    case application
}
```

Puis dans `struct Question`, après `let illustration: Illustration?` :

```swift
    let notion: String?
    let role: Role?
```

Et dans `init`, après `illustration: Illustration? = nil` :

```swift
        notion: String? = nil,
        role: Role? = nil
```

avec, dans le corps :

```swift
        self.notion = notion
        self.role = role
```

Les deux champs étant `Optional`, le `Codable` synthétisé les traite déjà comme absents-autorisés : aucun `init(from:)` manuel n'est nécessaire ici (contrairement à la tâche 2, où le champ ajouté n'est pas optionnel).

- [ ] **Step 4: Lancer les tests pour les voir passer**

Expected : `✔ Test run with 66 tests` (64 + les 2 neufs), `** TEST SUCCEEDED **`.

- [ ] **Step 5: Autoriser les deux clés dans `audit.py`**

Dans `Tools/audit.py`, au contrôle `schema/cle-hors-schema` (autour de la ligne 134), ajouter `'notion'` et `'role'` au set :

```python
    if set(q) - {'id','subject','topic','difficulty','prompt','options','correctID','explanation','sourceURL','illustration','notion','role'}:
        flag('schema/cle-hors-schema', q, sorted(set(q)))
```

- [ ] **Step 6: Vérifier qu'`audit.py` est inchangé**

Run : `python3 Tools/audit.py > /tmp/apres.txt; git stash; python3 Tools/audit.py > /tmp/avant.txt; git stash pop; diff /tmp/avant.txt /tmp/apres.txt`
Expected : aucune différence — aucune carte ne porte encore les clés.

- [ ] **Step 7: Commit**

```bash
git add Valido/Model/Question.swift ValidoTests/QuestionBankTests.swift Tools/audit.py
git commit -m "Add the notion and role axis to Question"
```

---

### Task 2: La progression par notion

**Files:**
- Create: `Valido/Model/NotionProgress.swift`
- Modify: `Valido/Model/ProgressSnapshot.swift`
- Test: `ValidoTests/ProgressTests.swift`

**Interfaces:**
- Consumes: `Question.notion` (tâche 1).
- Produces: `NotionProgress { var cartesDeLaSérie: Set<Question.ID>; var acquise: Bool }`, `ProgressSnapshot.notions: [String: NotionProgress]`, `ProgressSnapshot.estAcquise(_ notion: String?) -> Bool`, et la signature élargie `ProgressSnapshot.recordAnswer(_ id: Question.ID, correct: Bool, notion: String? = nil, masteryStreak: Int = 0)`.

**Le piège que cette tâche existe pour éviter :** `FileProgressStore.load()` décode avec `try?` et retombe sur `ProgressSnapshot()` en cas d'erreur. Le `Codable` synthétisé exige la présence de **toutes** les clés non optionnelles — ajouter `notions` sans `init(from:)` manuel ferait échouer le décodage de tout fichier existant, et **toute la progression déjà acquise serait silencieusement remise à zéro**. D'où le `decodeIfPresent` de l'étape 3.

- [ ] **Step 1: Écrire les tests qui échouent**

Dans `ValidoTests/ProgressTests.swift` :

```swift
@Test func laSérieNeCompteQueDesCartesDistinctes() {
    var progress = ProgressSnapshot()
    for _ in 0..<4 {
        progress.recordAnswer("q1", correct: true, notion: "panneaux/formes", masteryStreak: 4)
    }
    #expect(progress.estAcquise("panneaux/formes") == false)
}

@Test func quatreCartesDistinctesAcquièrentLaNotion() {
    var progress = ProgressSnapshot()
    for i in 1...4 {
        progress.recordAnswer("q\(i)", correct: true, notion: "panneaux/formes", masteryStreak: 4)
    }
    #expect(progress.estAcquise("panneaux/formes"))
}

@Test func uneFauteRemetLaSérieÀZéro() {
    var progress = ProgressSnapshot()
    for i in 1...3 {
        progress.recordAnswer("q\(i)", correct: true, notion: "marquage/lignes", masteryStreak: 4)
    }
    progress.recordAnswer("q4", correct: false, notion: "marquage/lignes", masteryStreak: 4)
    progress.recordAnswer("q5", correct: true, notion: "marquage/lignes", masteryStreak: 4)
    #expect(progress.estAcquise("marquage/lignes") == false)
}

@Test func uneFauteNeRetirePasUneNotionAcquise() {
    var progress = ProgressSnapshot()
    for i in 1...4 {
        progress.recordAnswer("q\(i)", correct: true, notion: "marquage/lignes", masteryStreak: 4)
    }
    progress.recordAnswer("q5", correct: false, notion: "marquage/lignes", masteryStreak: 4)
    #expect(progress.estAcquise("marquage/lignes"))
}

@Test func uneNotionNulleEstTraitéeCommeAcquise() {
    let progress = ProgressSnapshot()
    #expect(progress.estAcquise(nil))
}

@Test func uneProgressionÉcriteAvantLesNotionsSeDécodeEncore() throws {
    let ancien = """
    {"serveIndex":42,"stats":{"q1":{"attempts":3,"failures":1,"lastServeIndex":40}}}
    """.data(using: .utf8)!

    let progress = try JSONDecoder().decode(ProgressSnapshot.self, from: ancien)
    #expect(progress.serveIndex == 42)
    #expect(progress.stats(for: "q1").attempts == 3)
    #expect(progress.notions.isEmpty)
}
```

- [ ] **Step 2: Lancer les tests pour les voir échouer**

Expected : FAIL à la compilation — `extra argument 'notion' in call`.

- [ ] **Step 3: Implémenter**

Créer `Valido/Model/NotionProgress.swift` :

```swift
import Foundation

nonisolated struct NotionProgress: Codable, Sendable, Equatable {
    var cartesDeLaSérie: Set<Question.ID>
    var acquise: Bool

    init(cartesDeLaSérie: Set<Question.ID> = [], acquise: Bool = false) {
        self.cartesDeLaSérie = cartesDeLaSérie
        self.acquise = acquise
    }
}
```

Dans `Valido/Model/ProgressSnapshot.swift`, ajouter la propriété, le décodage tolérant et les deux membres :

```swift
    var notions: [String: NotionProgress]

    init(
        serveIndex: Int = 0,
        stats: [Question.ID: QuestionStats] = [:],
        notions: [String: NotionProgress] = [:]
    ) {
        self.serveIndex = serveIndex
        self.stats = stats
        self.notions = notions
    }

    // `decodeIfPresent` et non le Codable synthétisé : un fichier écrit avant cette version
    // n'a pas la clé, et `FileProgressStore.load()` avale l'erreur avec `try?` — toute la
    // progression serait remise à zéro sans que rien ne le signale.
    init(from decoder: any Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        serveIndex = try c.decode(Int.self, forKey: .serveIndex)
        stats = try c.decode([Question.ID: QuestionStats].self, forKey: .stats)
        notions = try c.decodeIfPresent([String: NotionProgress].self, forKey: .notions) ?? [:]
    }

    func estAcquise(_ notion: String?) -> Bool {
        guard let notion else { return true }
        return notions[notion]?.acquise ?? false
    }

    mutating func recordAnswer(
        _ id: Question.ID,
        correct: Bool,
        notion: String? = nil,
        masteryStreak: Int = 0
    ) {
        var entry = stats(for: id)
        entry.attempts += 1
        if !correct { entry.failures += 1 }
        stats[id] = entry

        guard let notion else { return }
        var n = notions[notion] ?? NotionProgress()
        if correct {
            n.cartesDeLaSérie.insert(id)
            if n.cartesDeLaSérie.count >= masteryStreak { n.acquise = true }
        } else {
            n.cartesDeLaSérie.removeAll()
        }
        notions[notion] = n
    }
```

et supprimer l'ancienne `recordAnswer(_:correct:)` ainsi que l'ancien `init(serveIndex:stats:)`, remplacés ci-dessus.

- [ ] **Step 4: Lancer les tests pour les voir passer**

Expected : `✔ Test run with 72 tests`, `** TEST SUCCEEDED **`.

- [ ] **Step 5: Commit**

```bash
git add Valido/Model/NotionProgress.swift Valido/Model/ProgressSnapshot.swift ValidoTests/ProgressTests.swift
git commit -m "Track mastery per notion, decoding older progress files as-is"
```

---

### Task 3: Le boost de tirage

**Files:**
- Modify: `Valido/Model/SchedulerConfig.swift`, `Valido/Model/CardScheduler.swift`
- Test: `ValidoTests/CardSchedulerTests.swift`

**Interfaces:**
- Consumes: `Question.role`, `Question.notion` (tâche 1), `ProgressSnapshot.estAcquise(_:)` (tâche 2).
- Produces: `SchedulerConfig.foundationBoost: Double` (défaut 4.0), `SchedulerConfig.masteryStreak: Int` (défaut 4), `CardScheduler.boost(for:progress:) -> Double`.

- [ ] **Step 1: Écrire les tests qui échouent**

Dans `ValidoTests/CardSchedulerTests.swift` :

```swift
@Test func uneFondationNonAcquiseSortPlusSouventQueSesApplications() throws {
    var questions = [Fixtures.question(id: "f1", topic: "Panneaux & marquage")]
    questions += (1...9).map { Fixtures.question(id: "a\($0)", topic: "Panneaux & marquage") }
    let annotées = questions.enumerated().map { i, q in
        Question(
            id: q.id, subject: q.subject, topic: q.topic, difficulty: q.difficulty,
            prompt: q.prompt, options: q.options, correctID: q.correctID,
            explanation: q.explanation,
            notion: "panneaux/formes", role: i == 0 ? .fondation : .application
        )
    }
    let bank = try QuestionBank(questions: annotées)
    let scheduler = CardScheduler()
    var rng = SeededRNG(seed: 3)
    var fondations = 0

    for _ in 0..<1000 {
        let tiré = scheduler.next(bank: bank, progress: ProgressSnapshot(), recent: [], rng: &rng)
        if tiré.draw == .weighted && tiré.card.id == "f1" { fondations += 1 }
    }

    // Une carte sur dix, mais boostée : nettement au-dessus du dixième des ~700 pondérés.
    #expect(fondations > 150)
}

@Test func uneNotionAcquiseNeSortPasDuVivier() throws {
    let fondation = Question(
        id: "f1", subject: .code, topic: "Panneaux & marquage", difficulty: .facile,
        prompt: "Énoncé", options: [Option(id: "A", text: "a"), Option(id: "B", text: "b"),
                                    Option(id: "C", text: "c"), Option(id: "D", text: "d")],
        correctID: "B", explanation: "Explication",
        notion: "panneaux/formes", role: .fondation
    )
    let bank = try QuestionBank(questions: [fondation])
    var progress = ProgressSnapshot()
    progress.notions["panneaux/formes"] = NotionProgress(cartesDeLaSérie: ["f1"], acquise: true)

    let scheduler = CardScheduler()
    #expect(scheduler.boost(for: fondation, progress: progress) == 1.0)

    var rng = SeededRNG(seed: 5)
    let tiré = scheduler.next(bank: bank, progress: progress, recent: [], rng: &rng)
    #expect(tiré.card.id == "f1")
}

@Test func uneCarteSansNotionNEstJamaisBoostée() throws {
    let scheduler = CardScheduler()
    let nue = Fixtures.question(id: "q1")
    #expect(scheduler.boost(for: nue, progress: ProgressSnapshot()) == 1.0)
}
```

- [ ] **Step 2: Lancer les tests pour les voir échouer**

Expected : FAIL — `value of type 'CardScheduler' has no member 'boost'`.

- [ ] **Step 3: Implémenter**

Dans `Valido/Model/SchedulerConfig.swift`, ajouter les deux propriétés après `failureSpan`, et les deux paramètres à la fin de l'`init` (avec leurs valeurs par défaut) :

```swift
    /// Facteur appliqué à une carte `fondation` dont la notion n'est pas acquise.
    var foundationBoost: Double
    /// Bonnes réponses sur des cartes distinctes exigées pour acquérir une notion.
    var masteryStreak: Int
```

```swift
        foundationBoost: Double = 4.0,
        masteryStreak: Int = 4
```

```swift
        self.foundationBoost = foundationBoost
        self.masteryStreak = masteryStreak
```

Dans `Valido/Model/CardScheduler.swift`, ajouter la fonction après `weight(for:progress:)` :

```swift
    func boost(for question: Question, progress: ProgressSnapshot) -> Double {
        guard question.role == .fondation, !progress.estAcquise(question.notion) else { return 1.0 }
        return config.foundationBoost
    }
```

et l'appliquer dans `weightedPick`, en remplaçant la ligne `let poids = pool.map { weight(for: $0.id, progress: progress) }` par :

```swift
        let poids = pool.map { weight(for: $0.id, progress: progress) * boost(for: $0, progress: progress) }
```

- [ ] **Step 4: Lancer les tests pour les voir passer**

Expected : `✔ Test run with 75 tests`, `** TEST SUCCEEDED **`, et **`répartition70_30()` toujours vert sans modification** — si ce test bouge, le boost a été branché au mauvais endroit (il ne doit toucher que le tirage pondéré).

- [ ] **Step 5: Commit**

```bash
git add Valido/Model/SchedulerConfig.swift Valido/Model/CardScheduler.swift ValidoTests/CardSchedulerTests.swift
git commit -m "Weight unacquired foundations up inside the weighted draw"
```

---

### Task 4: Câbler la réponse à la progression

**Files:**
- Modify: `Valido/ViewModel/FeedViewModel.swift`
- Test: `ValidoTests/FeedViewModelTests.swift`

**Interfaces:**
- Consumes: tâches 1 à 3.
- Produces: `FeedViewModel.notionsAcquises: Int` (nombre de notions acquises, lu par la tâche 9).

- [ ] **Step 1: Écrire le test qui échoue**

Dans `ValidoTests/FeedViewModelTests.swift` :

```swift
@MainActor
@Test func répondreJusteFaitProgresserLaNotion() throws {
    let annotées = (1...4).map { i in
        Question(
            id: "f\(i)", subject: .code, topic: "Panneaux & marquage", difficulty: .facile,
            prompt: "Énoncé \(i)",
            options: [Option(id: "A", text: "a"), Option(id: "B", text: "b"),
                      Option(id: "C", text: "c"), Option(id: "D", text: "d")],
            correctID: "B", explanation: "Explication",
            notion: "panneaux/formes", role: .fondation
        )
    }
    let model = FeedViewModel(
        bank: try QuestionBank(questions: annotées),
        store: InMemoryProgressStore()
    )
    model.start()
    #expect(model.notionsAcquises == 0)

    var index = 0
    while model.notionsAcquises == 0 && index < 40 {
        model.ensureCards(currentIndex: index)
        _ = model.answer("B", at: index)
        index += 1
    }

    #expect(model.notionsAcquises == 1)
}
```

- [ ] **Step 2: Lancer le test pour le voir échouer**

Expected : FAIL — `value of type 'FeedViewModel' has no member 'notionsAcquises'`.

- [ ] **Step 3: Implémenter**

Dans `Valido/ViewModel/FeedViewModel.swift`, remplacer l'appel à `recordAnswer` dans `answer(_:at:)` :

```swift
        progress.recordAnswer(
            presented.id,
            correct: correct,
            notion: presented.question.notion,
            masteryStreak: scheduler.config.masteryStreak
        )
```

et ajouter, après `count(of:)` :

```swift
    var notionsAcquises: Int {
        progress.notions.values.count { $0.acquise }
    }
```

- [ ] **Step 4: Lancer les tests pour les voir passer**

Expected : `✔ Test run with 76 tests`, `** TEST SUCCEEDED **`.

- [ ] **Step 5: Commit**

```bash
git add Valido/ViewModel/FeedViewModel.swift ValidoTests/FeedViewModelTests.swift
git commit -m "Feed answers into notion progress"
```

---

### Task 5: Le registre et ses deux premiers contrôles

**Files:**
- Create: `Tools/notions.md`
- Modify: `Tools/audit.py`

**Interfaces:**
- Consumes: `notion` / `role` de `questions.json` (tâche 1).
- Produces: `NOTIONS_MD` (surchargeable par `VALIDO_NOTIONS_MD`, comme `VALIDO_SOURCES_MD`), le dict `REGISTRE_NOTIONS`, et les compteurs `notions/non-declaree` et `notions/sans-fondation`.

`notions/carte-orpheline` n'est **pas** créé ici : il s'active à la tâche 8, quand les 255 cartes sont annotées. Avant cela il flaguerait la banque entière.

- [ ] **Step 1: Créer `Tools/notions.md`**

```markdown
# Registre des notions

Une ligne par notion, sur le modèle de [`couverture.md`](couverture.md). `Tools/audit.py`
refuse une `notion` absente de ce tableau, et une notion qui n'a aucune carte `fondation`.

Une **notion** est un cran plus fin qu'un `topic` : `Panneaux & marquage` en porte
plusieurs, et une même notion peut traverser plusieurs `topic` — c'est l'axe transversal
que `topic` ne sait pas porter. La colonne « topics concernés » le montre.

Le **rôle** est déclaré, pas déduit. Une `fondation` énonce le système (« Un panneau
triangulaire à bord rouge annonce : ») ; une `application` l'exerce sur un cas (« Ce
panneau indique : »). Aucune heuristique sur le `prompt` ne sait faire la différence.

Surchargeable par `VALIDO_NOTIONS_MD`, ce qui sert à vérifier une règle sur un cas d'essai.

| notion | topics concernés | fondations | applications | verdict |
|---|---|---:|---:|---|
```

- [ ] **Step 2: Brancher le registre dans `audit.py`**

À côté de la lecture de `SOURCES_MD`, ajouter :

```python
NOTIONS_MD = os.environ.get('VALIDO_NOTIONS_MD', os.path.join(ICI, 'notions.md'))
LIGNE_NOTION = re.compile(r'^\|\s*`([a-z0-9/-]+)`\s*\|', re.M)
try:
    NOTIONS_DECLAREES = set(LIGNE_NOTION.findall(open(NOTIONS_MD).read()))
except OSError:
    NOTIONS_DECLAREES = set()
```

(`ICI` et `os` existent déjà pour `SOURCES_MD` ; réutiliser les mêmes noms plutôt que d'en introduire.)

- [ ] **Step 3: Ajouter les deux contrôles**

Dans la boucle `for q in QS`, à la suite du bloc `--- couverture ---` :

```python
    # --- notions ---
    if q['subject'] == 'code' and q.get('notion') and NOTIONS_DECLAREES:
        if q['notion'] not in NOTIONS_DECLAREES:
            flag('notions/non-declaree', q, q['notion'])
```

Après la boucle, à côté du calcul de `orphelines` :

```python
fondations = {q['notion'] for q in QS if q.get('role') == 'fondation' and q.get('notion')}
notions_utilisées = {q['notion'] for q in QS if q.get('notion')}
for n in sorted(notions_utilisées - fondations):
    findings['notions/sans-fondation'].append(('—', '—', '—', n, 'aucune carte fondation'))
```

- [ ] **Step 4: Ajouter `'notions/'` à l'ordre d'affichage**

Dans la liste `order`, insérer `'notions/'` juste après `'couverture/'` :

```python
order = ['schema/', 'couverture/', 'notions/', 'source/', 'lettre/', 'forme/', 'longueur/', 'fuite/', 'expl/', 'image/']
```

- [ ] **Step 5: Vérifier sur un cas d'essai**

```bash
cd /Users/guillaume/Developer/Swift/Valido
printf '| `essai/inexistante` | `Vitesse` | 0 | 0 | à compléter |\n' > /tmp/notions-essai.md
VALIDO_NOTIONS_MD=/tmp/notions-essai.md python3 Tools/audit.py | grep -c '^### notions/'
```
Expected : `0` — aucune carte n'est encore annotée, donc aucun des deux contrôles ne mord.

- [ ] **Step 6: Vérifier que le rapport est inchangé**

Run : `python3 Tools/audit.py | grep -E '^###'`
Expected : exactement les mêmes sections qu'avant la tâche, aucune section `notions/`.

- [ ] **Step 7: Commit**

```bash
git add Tools/notions.md Tools/audit.py
git commit -m "Add the notion registry and refuse a notion with no foundation"
```

---

### Task 6: Annoter `Panneaux & marquage` — le domaine pilote

**Files:**
- Modify: `Valido/Resources/questions.json`, `Tools/notions.md`

C'est la tâche qui fixe la méthode ; les douze autres domaines la rejouent. **Lire
[`Tools/questions.md`](../../../Tools/questions.md) avant de commencer** — l'annotation ne
touche pas aux énoncés, mais toute édition de `questions.json` passe par le même protocole.

- [ ] **Step 1: Lister les 27 cartes du domaine**

```bash
cd /Users/guillaume/Developer/Swift/Valido && python3 - <<'PY'
import json
qs = json.load(open('Valido/Resources/questions.json'))
for q in qs:
    if q.get('topic') == 'Panneaux & marquage':
        print(q['id'][:8], '[img]' if q.get('illustration') else '     ', q['prompt'][:90])
PY
```

- [ ] **Step 2: Décider les notions et les rôles, à la main**

Appliquer le test du §1 de la spec à chaque carte : *cette notion est-elle une famille dont
je teste les membres ?* Les notions attendues sur ce domaine, d'après le balayage de la
spec — à confirmer carte par carte, pas à recopier sans lire :

- `panneaux/formes` — triangle, rond, carré, octogone, triangle pointe en bas. Deux
  fondations existent (« Un panneau rond à bord rouge indique : », « Un panneau rond à fond
  bleu, sans liseré rouge, indique : ») ; les dix-sept cartes « Ce panneau … » sont des
  applications.
- `panneaux/couleurs` — l'axe couleur, indépendant de la forme.
- `panneaux/portee` — où une prescription commence et finit (« À sa hauteur, ce panneau : »,
  « Ce panneau ne lève jamais : », chantier contre permanent).
- `panneaux/panonceaux` — la plaque sous le panneau.
- `marquage/lignes` — continue, discontinue axiale, discontinue de rive, mixte, à cheval.
  **Cinq cartes déjà présentes** : ce domaine-là est en panne d'ordre, pas de contenu. La
  fondation est « Une ligne continue au centre de la chaussée : ».

`panneaux/formes` traverse aussi `Priorités & intersections` (l'octogone STOP et le triangle
pointe en bas y vivent) — l'annoter ici, et le déclarer dans les deux topics à l'étape 4.

- [ ] **Step 3: Écrire `notion` et `role` sur les 27 cartes**

Édition directe de `Valido/Resources/questions.json`. Les deux clés se placent après
`explanation` (ou après `illustration` si la carte en a une). Aucun autre champ ne bouge,
**aucun `id` ne change**.

- [ ] **Step 4: Déclarer les notions dans `Tools/notions.md`**

Une ligne par notion, avec le compte réel :

```bash
cd /Users/guillaume/Developer/Swift/Valido && python3 - <<'PY'
import json, collections
qs = json.load(open('Valido/Resources/questions.json'))
par_notion = collections.defaultdict(lambda: {'f': 0, 'a': 0, 'topics': set()})
for q in qs:
    n = q.get('notion')
    if not n: continue
    par_notion[n]['topics'].add(q['topic'])
    par_notion[n]['f' if q.get('role') == 'fondation' else 'a'] += 1
for n, d in sorted(par_notion.items()):
    topics = ', '.join(f'`{t}`' for t in sorted(d['topics']))
    verdict = 'couvert' if d['f'] else 'à compléter'
    print(f"| `{n}` | {topics} | {d['f']} | {d['a']} | {verdict} |")
PY
```

Coller la sortie dans le tableau de `notions.md`.

- [ ] **Step 5: Lancer `audit.py`**

Run : `python3 Tools/audit.py | grep -E '^### (notions|schema|couverture)/'`
Expected : `notions/non-declaree` et `notions/sans-fondation` **absents**. S'ils
apparaissent, c'est une notion oubliée dans le registre ou une famille sans fondation — les
deux se corrigent dans les données, jamais dans l'outil.

- [ ] **Step 6: Lancer la suite**

Expected : `✔ Test run with 76 tests`, `** TEST SUCCEEDED **`.

- [ ] **Step 7: Commit**

```bash
git add Valido/Resources/questions.json Tools/notions.md
git commit -m "Annotate the sign and marking cards with their notion and role"
```

---

### Task 7: Annoter les douze autres domaines

**Files:**
- Modify: `Valido/Resources/questions.json`, `Tools/notions.md`

Un pas par domaine, chacun rejouant les étapes 1 à 7 de la tâche 6 en changeant le `topic`.
Un commit par domaine : une annotation qui déraille doit pouvoir se relire seule.

- [ ] **Step 1: `Priorités & intersections` (26 cartes)** — attention à `panneaux/formes`, qui vient du domaine précédent (octogone STOP, triangle pointe en bas). Notions attendues : `priorite/regimes` (la hiérarchie agent > feu > panneau > règle générale, et la priorité à droite par défaut), `priorite/giratoire`, `priorite/cas-particuliers` (tramway, véhicule prioritaire, sortie de parking). Commit : `Annotate the priority and intersection cards`.
- [ ] **Step 2: `Vitesse` (22 cartes)** — `vitesse/limites-par-route`, `vitesse/intemperies`, `vitesse/probatoire`, `vitesse/sanctions`. Les deux du milieu n'ont **aucune fondation** : les déclarer `à compléter`, la tâche 8 les écrit. Commit : `Annotate the speed cards`.
- [ ] **Step 3: `Distances & freinage` (21 cartes)** — domaine déjà fondé (« La distance d'arrêt d'un véhicule se compose de : »). `distances/composition-arret`, `distances/intervalle`, `distances/adherence`, `distances/bau`. Commit : `Annotate the distance and braking cards`.
- [ ] **Step 4: `Mécanique & environnement` (20 cartes)** — `mecanique/temoins` (déjà fondé), `mecanique/pneus`, `mecanique/equipements-obligatoires`, `securite/retenue-enfants`, `environnement/critair`, `environnement/ecoconduite`, `mecanique/chargement`. Commit : `Annotate the vehicle and environment cards`.
- [ ] **Step 5: `Feux` (19 cartes)** — le topic mêle deux choses que `couverture.md` distingue déjà : `feux/signaux-tricolores` et `feux/eclairage-vehicule`. Le second n'a **aucune fondation** (six applications) — `à compléter`. Commit : `Annotate the light cards`.
- [ ] **Step 6: `Permis & sanctions` (19 cartes)** — `permis/capital-points`, `permis/bareme`, `permis/recuperation`, `permis/probatoire`, `permis/qualification`. Le dernier n'a **aucune fondation** alors que six cartes en dépendent — `à compléter`. Commit : `Annotate the licence and penalty cards`.
- [ ] **Step 7: `Premiers secours` (18 cartes)** — déjà fondé (« Face à un accident, la règle de conduite à suivre est : »). `secours/protection-alerte-secours`, `secours/alerte`, `secours/gestes`. Commit : `Annotate the first aid cards`.
- [ ] **Step 8: `Alcool & stupéfiants` (18 cartes)** — `alcool/seuils`, `alcool/metabolisme`, `alcool/sanctions`, `alcool/depistage`, `stups/regime`. Commit : `Annotate the alcohol and drug cards`.
- [ ] **Step 9: `Usagers & partage de la route` (18 cartes)** — `usagers/cyclistes`, `usagers/edpm`, `usagers/deux-roues-motorises`, `usagers/pietons`, `usagers/angles-morts`, plus `usagers/vulnerables` **sans fondation** — `à compléter`. Commit : `Annotate the road sharing cards`.
- [ ] **Step 10: `Arrêt & stationnement` (17 cartes)** — `stationnement/arret-vs-stationnement` (déjà fondé), `stationnement/interdictions`, `stationnement/gradation` (**sans fondation**), `stationnement/marquage`, `stationnement/regles-locales`. Commit : `Annotate the stopping and parking cards`.
- [ ] **Step 11: `Croisement & dépassement` (15 cartes)** — `depassement/interdictions`, `depassement/manoeuvre`, `croisement/regles`. Commit : `Annotate the passing and crossing cards`.
- [ ] **Step 12: `Tunnels & passages à niveau` (15 cartes)** — `tunnel/conduite`, `tunnel/incident`, `pn/franchissement`, `pn/signalisation`. Commit : `Annotate the tunnel and level crossing cards`.
- [ ] **Step 13: Vérifier qu'il ne reste aucune carte `code` sans notion**

```bash
cd /Users/guillaume/Developer/Swift/Valido && python3 - <<'PY'
import json
qs = json.load(open('Valido/Resources/questions.json'))
nues = [q['id'] for q in qs if q['subject'] == 'code' and not q.get('notion')]
print(len(nues), 'carte(s) code sans notion')
for i in nues[:20]: print('  ', i)
PY
```
Expected : `0 carte(s) code sans notion`.

- [ ] **Step 14: Lancer `audit.py` et la suite**

Expected : `notions/non-declaree` absent ; `notions/sans-fondation` liste **exactement** les six notions annoncées `à compléter` ci-dessus (`vitesse/intemperies`, `vitesse/probatoire`, `feux/eclairage-vehicule`, `permis/qualification`, `usagers/vulnerables`, `stationnement/gradation`) plus, le cas échéant, `panneaux/couleurs`. La suite passe. Les compteurs informatifs sont comparés à la ligne de base, pas à zéro.

---

### Task 8: Les fondations manquantes, et le verrou

**Files:**
- Modify: `Valido/Resources/questions.json`, `Tools/notions.md`, `Tools/sources.md`, `Tools/couverture.md`, `Tools/audit.py`, `ValidoTests/BundledContentTests.swift`

**Lire [`Tools/questions.md`](../../../Tools/questions.md) en entier avant d'écrire une
carte** — 7 règles de distracteur, 9 pièges de forme, §5 sur la fraîcheur juridique.

- [ ] **Step 1: Écrire les sept à huit fondations manquantes**

Une carte par notion listée `à compléter` à la tâche 7. L'`id` d'une carte neuve est
`sha256("valido-v2:" + prompt)[:32]` — le préfixe est dans l'entrée du hachage, pas dans
l'identifiant :

```bash
python3 -c "import hashlib,sys; print(hashlib.sha256(('valido-v2:'+sys.argv[1]).encode()).hexdigest()[:32])" "Un panneau triangulaire à bord rouge annonce :"
```

Chaque carte porte `"role": "fondation"` et sa `notion`. Rappel de forme : les options sont
mélangées à chaque présentation, donc **aucune référence de lettre** nulle part, et la bonne
réponse ne dépasse pas de 10 caractères la deuxième plus longue.

- [ ] **Step 2: Déclarer chaque carte neuve dans `Tools/sources.md`**

Une ligne par carte `code`, **sans exception**. `permis/qualification` et
`stationnement/gradation` portent des montants et des retraits de points : leurs lignes sont
`datée`, avec une URL de `DOMAINES_FAIT` et sa date de relevé. Les fondations de forme
(`panneaux/formes`, `panneaux/couleurs`) sont `stable`, colonnes `source` et `relevé le`
vides.

- [ ] **Step 3: Vérifier la couverture**

Run : `python3 Tools/audit.py | grep -E '^### (source|couverture|notions)/'`
Expected : aucune de ces trois sections.

- [ ] **Step 4: Ajouter le second axe à `Tools/couverture.md`**

Une seconde table rattachant chaque `topic` aux quatorze libellés de compétence du spécimen
officiel (§1 de la spec, sous-section « Quatre domaines absents depuis le départ »). Sans
bac « Capacité de perception et d'évaluation » ni « Nouvelles technologies », rien ne
signalera jamais leur absence — c'est la correction qui empêche l'angle mort de se reformer.
Les quatre domaines absents y figurent avec le verdict `absent` ; leur écriture est le plan
suivant.

- [ ] **Step 5: Activer `notions/carte-orpheline`**

Dans `Tools/audit.py`, dans la boucle `for q in QS`, au bloc `--- notions ---` :

```python
    if q['subject'] == 'code' and not q.get('notion'):
        flag('notions/carte-orpheline', q, 'aucune notion')
```

- [ ] **Step 6: Vérifier que le contrôle ne mord pas**

Run : `python3 Tools/audit.py | grep -c '^### notions/'`
Expected : `0`.

- [ ] **Step 7: Verrouiller le livré**

Dans `ValidoTests/BundledContentTests.swift` :

```swift
@Test func chaqueCarteCodePorteUneNotionEtUnRôle() throws {
    let bank = try QuestionBank.bundled()
    let nues = bank.questions.filter { $0.subject == .code && ($0.notion == nil || $0.role == nil) }
    #expect(nues.map(\.id) == [])
}

@Test func chaqueNotionAAuMoinsUneFondation() throws {
    let bank = try QuestionBank.bundled()
    let notions = Set(bank.questions.compactMap(\.notion))
    let fondées = Set(bank.questions.filter { $0.role == .fondation }.compactMap(\.notion))
    #expect(notions.subtracting(fondées).sorted() == [])
}
```

- [ ] **Step 8: Lancer la suite**

Expected : `✔ Test run with 78 tests`, `** TEST SUCCEEDED **`. Un échec ici **se corrige dans
les données, jamais dans le test**.

- [ ] **Step 9: Commit**

```bash
git add Valido/Resources/questions.json Tools/notions.md Tools/sources.md Tools/couverture.md Tools/audit.py ValidoTests/BundledContentTests.swift
git commit -m "Write the missing foundations and lock the notion axis in"
```

---

### Task 9: Le compteur de maîtrise

**Files:**
- Create: `Valido/View/NotionBadge.swift`
- Modify: `Valido/View/QuestionCardView.swift`
- Test: manuel (rendu), plus la suite existante.

**Interfaces:**
- Consumes: `FeedViewModel.notionsAcquises` (tâche 4).
- Produces: `NotionBadge(acquises: Int, total: Int)`.

Sans surface, l'acquisition est invisible et ne motive rien. Contrainte reprise du §7 de la
spec : le compteur vit dans le bandeau **à côté de `ComboBadge`**, jamais dans la carte — il
ne prend rien à l'énoncé, aux options ni au mémo, et n'entre pas dans le budget de hauteur
des illustrées (70 / 50 / 220).

- [ ] **Step 1: Créer la vue**

`Valido/View/NotionBadge.swift` :

```swift
import SwiftUI

struct NotionBadge: View {
    let acquises: Int
    let total: Int

    var body: some View {
        Label("\(acquises)/\(total)", systemImage: "checkmark.seal.fill")
            .font(.caption.weight(.semibold))
            .foregroundStyle(acquises == 0 ? .secondary : .tint)
            .accessibilityLabel("\(acquises) notions acquises sur \(total)")
    }
}
```

- [ ] **Step 2: Le brancher**

Dans `QuestionCardView`, `contenu`, le `HStack` de tête porte déjà `ComboBadge(combo: combo)`.
Ajouter les deux propriétés stockées (`let notionsAcquises: Int`, `let notionsTotal: Int`)
et poser `NotionBadge(acquises: notionsAcquises, total: notionsTotal)` avant `ComboBadge`.
Répercuter les deux arguments au point de construction dans `FeedView`, en les lisant sur le
`model`.

- [ ] **Step 3: Exposer le total**

Dans `FeedViewModel`, à côté de `notionsAcquises` :

```swift
    var notionsTotal: Int {
        Set(bank.questions.compactMap(\.notion)).count
    }
```

- [ ] **Step 4: Lancer la suite**

Expected : `✔ Test run with 78 tests`, `** TEST SUCCEEDED **`.

- [ ] **Step 5: Voir le rendu**

Lancer l'app sur le simulateur et vérifier sur une carte illustrée et une carte chargée que
le compteur ne pousse rien hors de la carte.

- [ ] **Step 6: Commit**

```bash
git add Valido/View/NotionBadge.swift Valido/View/QuestionCardView.swift Valido/View/FeedView.swift Valido/ViewModel/FeedViewModel.swift
git commit -m "Show acquired notions next to the combo"
```

---

### Task 10: Refermer le chantier

**Files:**
- Modify: `CLAUDE.md`
- Delete: `docs/superpowers/plans/2026-09-19-notions-maitrise.md`

- [ ] **Step 1: Mettre `CLAUDE.md` à jour**

Trois points, et rien d'autre : `SchedulerConfig` porte **neuf** nombres et non sept ;
`Tools/notions.md` rejoint `sources.md` et `couverture.md` dans la liste des registres
imposés par `audit.py` ; les trois compteurs `notions/` rejoignent ceux qui doivent rester
vides.

Dans `README.md`, un seul chiffre : le volume de questions, que les fondations neuves ont
fait monter au-dessus de 448. Rien d'autre — il décrit le projet sans le contraindre.

```bash
python3 -c "import json; qs=json.load(open('Valido/Resources/questions.json')); print(len(qs), sum(1 for q in qs if q['subject']=='code'), sum(1 for q in qs if q['subject']=='swift'), sum(1 for q in qs if q.get('illustration')))"
```

- [ ] **Step 2: Relever la nouvelle ligne de base**

Run : `python3 Tools/audit.py | grep -E '^###'`
Reporter les valeurs des compteurs informatifs dans `CLAUDE.md` — les cartes neuves les font
monter, et une hausse due au volume n'est pas une dérive.

- [ ] **Step 3: Supprimer ce plan**

Un plan se supprime quand son travail est livré : le pourquoi vit dans la spec, le quoi dans
l'historique git.

- [ ] **Step 4: Commit**

```bash
git add CLAUDE.md README.md && git rm docs/superpowers/plans/2026-09-19-notions-maitrise.md
git commit -m "Close the notions work: nine knobs, three registries"
```
