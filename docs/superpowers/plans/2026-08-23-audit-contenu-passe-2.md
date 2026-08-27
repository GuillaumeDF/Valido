# Audit de contenu passe 2 — plan d'implémentation

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Rendre la fraîcheur juridique de chaque question `code` vérifiable et rejouable, aligner la couverture sur le référentiel officiel de l'ETG, porter la banque illustrée de 8 à ~40 questions, et réparer les énoncés `swift` irrépondables.

**Architecture:** Trois registres markdown imposés par `Tools/audit.py` (fraîcheur par question, carte de couverture, provenance d'images) portent les invariants que le code ne peut pas porter. Le contenu se traite ensuite thématique par thématique, de bout en bout — vérifier, sourcer, compléter, illustrer — pour qu'une question naisse en sachant si une image la porte, plutôt que d'être réécrite quand on décide de l'illustrer.

**Tech Stack:** Python 3 (`Tools/audit.py`), Swift 6 + CoreGraphics en script (`Tools/Scenes/`, `swiftc`), Swift Testing + `xcodebuild` (`ValidoTests/`), JSON à la main (`Valido/Resources/questions.json`).

**Spec:** [`docs/superpowers/specs/2026-08-23-audit-contenu-design.md`](../specs/2026-08-23-audit-contenu-design.md)

## Global Constraints

- **Branche** `audit-contenu-2026-08`. Un commit par tâche, message en anglais, terminé par `Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>`.
- **`id` est immuable.** La progression est indexée par `Question.ID` (`Valido/Model/ProgressSnapshot.swift:12`). Réécrire un énoncé ne recalcule **jamais** son `id` : la progression de l'utilisateur se réinitialiserait en silence sur les questions touchées.
- **Recette d'`id` pour une question neuve** : `hashlib.sha256(('valido-v2:' + prompt).encode()).hexdigest()[:32]`. Vérifiée sur les 60 questions déjà créées ainsi. `questions.md` §6 décrit mal cette recette (« SHA-256 de l'énoncé préfixé `valido-v2:` » laisse croire que le préfixe est dans l'`id`) : la tâche 21 corrige la phrase.
- **Aucune référence de lettre** nulle part — ni option, ni explication. Les options sont mélangées à chaque présentation.
- **`sourceURL`** : présent sur les questions `swift` (page d'origine ou documentation), absent sur les `code`. Sur une question sans image, `illustration` est **absente**, jamais `null` — comme `sourceURL`.
- **Liste blanche de sources**, seule autorité pour affirmer un chiffre, un seuil, un montant, une durée ou une qualification pénale : `legifrance.gouv.fr`, `securite-routiere.gouv.fr`, `service-public.gouv.fr`, `ecologie.gouv.fr`, `sante.gouv.fr`, `unece.org` (Convention de Vienne), `eur-lex.europa.eu`, `cprguidelines.eu` (ERC), `croix-rouge.fr`, `inrs.fr`. Aucun éditeur d'ETG, aucun site d'auto-école, jamais.
- **Les trois règles du §5 de `questions.md`** : citer la source et sa date ; signaler au lieu de corriger en cas de doute ; recycler l'ancienne valeur en distracteur.
- **Budget de hauteur d'une question illustrée** : énoncé ≤ 70 caractères, chaque option ≤ 50, explication ≤ 220.
- **Équilibre de longueur** : la bonne option ne dépasse pas de plus de 10 caractères la deuxième plus longue, ni de plus de 20 la moyenne des trois distracteurs.
- **Style du dépôt** : commentaires, documentation et noms de tests en français ; types, API et messages de commit en anglais. Les commentaires portent le *pourquoi*, y compris celui des mécanismes retirés — ne pas nettoyer ces blocs datés.
- **Un échec de test se corrige dans les données, jamais dans le test.**
- **Aucune modification de l'app** : ni vue, ni view model, ni scheduler, ni persistance. Seul `ValidoTests/BundledContentTests.swift` bouge côté Swift compilé.
- **Ligne de base d'`audit.py` au démarrage**, sur 310 questions : `lettre/reference` 1, `forme/markdown` 1, `forme/seule-ponctuee` 14, `longueur/plus-longue` 98, `expl/paraphrase-litterale` 23. Les deux premières sont les faux positifs connus. On se compare à cette base, pas à zéro.

## Deux commandes, à connaître avant de commencer

```bash
# Suite complète. `iPhone 17` est déclaré par trois runtimes dont un reste coincé :
# « Application failed preflight checks » / « Busy » est un simulateur, pas une régression.
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro'

# Un seul test — les PARENTHÈSES sont obligatoires, sinon 0 test tourne
# et « ** TEST SUCCEEDED ** » s'affiche quand même. Vérifier « ✔ Test run with N test(s) ».
  -only-testing:'ValidoTests/leContenuLivréEstValide()'
```

`python3 Tools/audit.py` **sort toujours 0** : c'est le rapport qu'on lit, pas le code de retour.

## Structure des fichiers

| Fichier | Responsabilité | Tâches |
|---|---|---|
| `Tools/couverture.md` | *créé* — thématique ETG → topic Valido → volume → verdict | 1 |
| `Tools/sources.md` | *créé* — registre de fraîcheur, une ligne par question `code` | 2 |
| `Tools/audit.py` | *modifié* — contrôles couverture, registre, budget de hauteur | 1, 2, 3 |
| `Tools/Scenes/Repere.swift` | *créé* — repère 400×300, palettes clair/sombre, `rgb` | 4 |
| `Tools/Scenes/Primitives.swift` | *créé* — chaussées, axes, voiture, flèche, texte, marquages | 4 |
| `Tools/Scenes/Panneaux.swift` | *créé* — `Forme` × `Pictogramme`, un panneau par fonction courte | 4, 7 |
| `Tools/Scenes/ScenesCarrefour.swift` | *créé* — les 6 scènes existantes, à l'identique | 4 |
| `Tools/Scenes/ScenesPanneaux.swift` | *créé* — les panneaux isolés, une scène par panneau | 7 |
| `Tools/Scenes/ScenesCirculation.swift` | *créé* — dépassement, insertion, stationnement, feux, distances | 5-13 |
| `Tools/Scenes/main.swift` | *créé* — table `scenes`, rendu, écriture des imagesets | 4 |
| `Tools/render-scenes.sh` | *créé* — `swiftc Tools/Scenes/*.swift` puis exécution | 4 |
| `Tools/render-scenes.swift` | *supprimé* — remplacé par `Tools/Scenes/` | 4 |
| `Valido/Resources/questions.json` | *modifié* — le contenu | 3, 5-20 |
| `Valido/Assets.xcassets/Scenes/` | *modifié* — ~33 imagesets neufs | 4-13 |
| `Tools/images.md` | *modifié* — une ligne par asset neuf, nouvelle commande | 4-13, 21 |
| `ValidoTests/BundledContentTests.swift` | *modifié* — seuils relevés, 2 tests neufs | 3, 21 |
| `Tools/questions.md` | *modifié* — §5 liste blanche, §6 recette d'`id`, §7 budget dur | 21 |
| `Tools/audit-2026-08-passe-2.md` | *créé* — le rapport de la passe | 21 |
| `CLAUDE.md` | *modifié* — commande de rendu, volumes, nouveaux registres | 21 |

---

## Procédure C — le cycle d'une tâche de contenu

Les tâches 5 à 17 traitent chacune un domaine du code de la route et suivent **exactement** ce cycle. Il est écrit ici une seule fois ; chaque tâche donne ensuite sa propre substance — quelles questions, quelles sources, quelles illustrations, quels points ouverts à fermer.

- [ ] **C1 — Inventorier.** Extraire les questions du domaine, avec leur longueur et leur statut d'illustration.

```bash
python3 - <<'EOF'
import json
TOPIC = "<le topic de la tâche>"
qs = json.load(open('Valido/Resources/questions.json'))
for i, q in enumerate(qs):
    if q['topic'] != TOPIC or q['subject'] != 'code':
        continue
    bonne = next(o['text'] for o in q['options'] if o['id'] == q['correctID'])
    print(f"--- #{i} {q['id'][:8]} [{q['difficulty']}]{' [IMG]' if q.get('illustration') else ''}")
    print(f"  Q: {q['prompt']}")
    for o in q['options']:
        print(f"  {'*' if o['id'] == q['correctID'] else ' '} {o['text']}")
    print(f"  E: {q['explanation']}")
EOF
```

- [ ] **C2 — Vérifier chaque affirmation datable.** Pour chaque question du domaine portant un chiffre, un seuil, un montant, une durée ou une qualification pénale : ouvrir la source de la liste blanche, relever la valeur en vigueur, la date de vérification de la page (« Vérifié le … » sur service-public, « Version en vigueur au … » sur Legifrance) et l'URL. Une valeur qui ne se retrouve sur aucune source de la liste **se signale**, elle ne se corrige pas au jugé.

- [ ] **C3 — Corriger, en recyclant.** Quand une valeur est périmée : la bonne option prend la valeur en vigueur, et **l'ancienne valeur devient un distracteur** — c'est celle que le candidat aura lue ailleurs, donc le meilleur distracteur disponible. L'explication cite le fondement (article, ou intitulé de la page) sans devenir une paraphrase de la bonne option.

- [ ] **C4 — Remplir `Tools/sources.md`.** Une ligne par question du domaine, y compris celles qu'on n'a pas touchées. `nature` = `stable` pour une règle sans valeur datable, `datée` sinon. Une `datée` porte obligatoirement l'URL **et** la date de relevé au format `AAAA-MM-JJ`.

- [ ] **C5 — Écrire les questions manquantes.** Les sujets à couvrir sont listés dans la tâche. Chaque question neuve respecte les sept règles de distracteur et les neuf pièges de forme du §1 et §2 de `Tools/questions.md`, et reçoit un `id` par la recette des contraintes globales. Répartition de difficulté visée sur le domaine : environ 40 % `facile`, 40 % `moyen`, 20 % `costaud`.

- [ ] **C6 — Illustrer ce qui le gagne.** Critère du §7, appliqué strictement : **si la question se tient sans l'image, elle n'est pas illustrée.** Illustrer veut dire retirer de l'énoncé ce que l'image dira. Pour chaque illustration : ajouter la scène dans le fichier `Tools/Scenes/` indiqué par la tâche, relancer `./Tools/render-scenes.sh`, ajouter la ligne dans `Tools/images.md`, poser `illustration` (`asset` + `alt`) sur la question. L'`alt` **est** l'énoncé pour qui n'accède pas à l'image : au moins 40 caractères, et il ne partage pas trois mots pleins avec le `prompt`. Budget de hauteur respecté. Les questions du domaine qu'on **renonce** à illustrer, et pourquoi, se notent pour le rapport de la tâche 21.

- [ ] **C7 — Auditer.**

```bash
python3 Tools/audit.py 2>&1 | grep '^###\|^== '
```

Attendu : aucune sortie `schema/`, `source/`, `couverture/` ni `image/` (hors le faux positif `image/enonce-redit-la-scene` s'il est justifié) ; `lettre/reference` et `forme/markdown` restent à 1 chacun ; les compteurs informatifs (`longueur/plus-longue`, `expl/paraphrase-litterale`, `forme/seule-ponctuee`) peuvent monter avec le volume, mais chaque nouvelle entrée du domaine se relit à l'œil.

- [ ] **C8 — Tester.**

```bash
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' 2>&1 | tail -25
```

Attendu : `✔ Test run with N test(s)` avec N ≥ 62, aucun échec. Vérifier la ligne `Test run with`, pas `** TEST SUCCEEDED **`.

- [ ] **C9 — Commiter.**

```bash
git add Valido/Resources/questions.json Tools/sources.md Tools/images.md \
        Tools/Scenes/ Valido/Assets.xcassets/Scenes/
git commit   # message donné par la tâche
```

---

## Phase 0 — Le socle

### Task 1: Référentiel ETG et carte de couverture

**Files:**
- Create: `Tools/couverture.md`
- Modify: `Tools/audit.py:46-54` (bloc des registres), `Tools/audit.py:156` (ordre de sortie)

**Interfaces:**
- Consomme : rien.
- Produit : `Tools/couverture.md` avec une ligne par couple (thématique, topic) ; la liste **arrêtée** des topics `code`, y compris les nouveaux, que les tâches 5 à 17 utilisent telle quelle ; le contrôle `couverture/topic-non-rattache` dans `audit.py`.

- [ ] **Step 1: Établir le libellé officiel des thématiques**

La page `securite-routiere.gouv.fr/passer-son-permis-de-conduire/preparation-de-lexamen-du-code-de-la-route/objectifs-et` est rendue en JavaScript : `WebFetch` en revient avec un corps vide. L'arrêté du 29 avril 2024 (`JORFTEXT000049502288`) ne porte que l'organisation de l'épreuve, pas le référentiel. Une recherche préalable indique **onze** thématiques, pas dix — ne pas partir de la liste de mémoire à dix entrées.

Pistes, dans cet ordre :

1. `WebFetch` sur `https://www.legifrance.gouv.fr/loda/id/JORFTEXT000032471964/` — arrêté du 27 avril 2016 fixant le cahier des charges prévu à l'article L. 221-7, dont les annexes portent le programme.
2. `WebFetch` sur `https://www.securite-routiere.gouv.fr/sites/default/files/2020-04/reponsesquestionspermisauto_v1604.pdf` — le PDF officiel d'exemples de questions, qui étiquette chaque question par sa thématique. C'est un PDF statique, donc lisible.
3. `WebSearch` `allowed_domains: ["securite-routiere.gouv.fr"]` sur « thématiques épreuve théorique générale » pour trouver une autre page portant la liste.
4. Le REMC (Référentiel pour l'Éducation à une Mobilité Citoyenne) sur `securite-routiere.gouv.fr`.

Si aucune source de la liste blanche ne donne la liste, **le consigner explicitement** en tête de `couverture.md` et adosser la carte au document le plus officiel trouvé, en le nommant et en le datant. Ne pas reconstituer la liste de mémoire.

- [ ] **Step 2: Écrire `Tools/couverture.md`**

Format : **une ligne par couple (thématique, topic)**, pour que le contrôle d'`audit.py` reste une expression régulière simple.

```markdown
# Couverture du référentiel ETG

Source du référentiel : <URL> (relevé le 2026-08-23).

Une ligne par couple (thématique officielle, `topic` de `questions.json`). `Tools/audit.py`
refuse un `topic` `code` absent de la colonne du milieu : un topic non rattaché est soit
une faute de frappe, soit un pan de contenu hors référentiel. Le volume est indicatif et
se relit avec `python3 Tools/audit.py`.

| thématique ETG | topic Valido | volume | verdict |
|---|---|---:|---|
| <libellé officiel 1> | `Vitesse` | 16 | à compléter |
| <libellé officiel 1> | `Distances & freinage` | 10 | à compléter |
…
```

La colonne `verdict` prend `couvert`, `à compléter` ou `absent`. Une thématique sans aucun topic reçoit une ligne avec un topic vide et le verdict `absent` — c'est elle qui déclenche la création d'un topic dans les tâches 15 à 17.

Rattacher les dix topics `code` existants — `Priorités & intersections` (21), `Panneaux & marquage` (17), `Vitesse` (16), `Alcool & stupéfiants` (14), `Permis & sanctions` (14), `Premiers secours` (13), `Arrêt & stationnement` (11), `Feux` (10), `Distances & freinage` (10), `Mécanique & environnement` (10) — puis nommer les topics à créer pour les thématiques restées `absent`. Ces noms sont **arrêtés ici** : les tâches 15 à 17 les reprennent sans les réinventer.

- [ ] **Step 3: Ajouter le contrôle à `audit.py`**

Après le bloc `RECENSES` (`Tools/audit.py:46-54`), insérer :

```python
COUVERTURE_MD = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'couverture.md')
# La carte de couverture : une ligne par couple (thématique ETG, topic). Un `topic` `code`
# absent de cette colonne est soit une faute de frappe, soit un pan de contenu hors
# référentiel — dans les deux cas on veut le savoir avant les tests.
try:
    TOPICS_DECLARES = set(re.findall(r'^\|[^|]*\|\s*`([^`]+)`\s*\|',
                                     open(COUVERTURE_MD).read(), re.M))
except OSError:
    TOPICS_DECLARES = set()
```

Puis, dans la boucle principale, juste après le bloc `# --- schéma ---` (après `Tools/audit.py:73`) :

```python
    # --- couverture ---
    if q['subject'] == 'code' and TOPICS_DECLARES and q['topic'] not in TOPICS_DECLARES:
        flag('couverture/topic-non-rattache', q, q['topic'])
```

Et étendre l'ordre de sortie (`Tools/audit.py:156`) :

```python
order = ['schema/', 'couverture/', 'source/', 'lettre/', 'forme/', 'longueur/', 'fuite/', 'expl/', 'image/']
```

- [ ] **Step 4: Vérifier que le contrôle mord**

```bash
python3 - <<'EOF'
import json
qs = json.load(open('Valido/Resources/questions.json'))
qs[0]['topic'] = 'Topic Qui N Existe Pas'
json.dump(qs, open('/tmp/faux.json', 'w'), ensure_ascii=False)
EOF
python3 Tools/audit.py /tmp/faux.json | grep 'couverture/'
```

Attendu : une ligne `### couverture/topic-non-rattache  (1)`. Puis sur le vrai fichier :

```bash
python3 Tools/audit.py | grep 'couverture/' ; echo "rc=$? (1 = aucune sortie, c'est le but)"
```

Attendu : aucune sortie `couverture/`.

- [ ] **Step 5: Commiter**

```bash
git add Tools/couverture.md Tools/audit.py
git commit -m "$(cat <<'EOF'
Anchor code coverage on the official ETG syllabus

The ten code topics were this repo's invention, not the exam's syllabus,
so nothing said which parts of the theory exam went untested. The map
now names each official theme, and audit.py rejects a code topic that
attaches to none of them — a typo and an off-syllabus topic look the
same from the outside, and both are worth catching before the tests.

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

### Task 2: Registre de fraîcheur

**Files:**
- Create: `Tools/sources.md`
- Modify: `Tools/audit.py` (imports ligne 9, bloc des registres, boucle de fin)

**Interfaces:**
- Consomme : rien de la tâche 1.
- Produit : `Tools/sources.md` avec 136 lignes `stable`/`datée` déclarées ; les contrôles `source/absente`, `source/hors-liste-blanche`, `source/date-illisible`, `source/releve-perime`, `source/stable-avec-source`, `source/affirmation-vide`, et la liste des lignes orphelines. Les tâches 5 à 17 remplissent les colonnes `source` et `relevé le` au fil de leurs vérifications.

Cette tâche crée le registre et **classe** les 136 questions ; elle ne vérifie encore rien. Une `datée` non encore vérifiée porte l'URL et la date vides, ce qui la fait sortir en `source/hors-liste-blanche` — c'est voulu : la sortie d'`audit.py` devient la liste de travail des tâches 5 à 17, et elle ne peut pas être oubliée.

- [ ] **Step 1: Générer le squelette du registre**

```bash
python3 - <<'EOF' > /tmp/registre.md
import json, re
qs = json.load(open('Valido/Resources/questions.json'))
# Un chiffre, une unité, un montant ou une durée dans l'énoncé, une option ou
# l'explication : indice de valeur datable. C'est une aide au classement, pas le
# classement : `nature` est relue et corrigée à la main juste après.
DATABLE = re.compile(r'\d|km/h|mg/l|g/l|point|€|euro|an\b|ans\b|mois|amende|prison|délit|contravention', re.I)
for q in qs:
    if q['subject'] != 'code':
        continue
    tout = q['prompt'] + ' '.join(o['text'] for o in q['options']) + q['explanation']
    nature = 'datée' if DATABLE.search(tout) else 'stable'
    print(f"| `{q['id']}` | {nature} | {q['topic']} — à renseigner |  |  |")
EOF
wc -l /tmp/registre.md
```

- [ ] **Step 2: Écrire `Tools/sources.md`**

En-tête, puis les 136 lignes générées, triées par topic pour que le fichier se relise domaine par domaine :

```markdown
# Registre de fraîcheur des questions `code`

Une ligne par question `code`, **sans exception**. `Tools/audit.py` refuse une question
`code` absente de ce tableau : c'est la seule manière d'empêcher qu'une question neuve
entre sans que personne ait dit contre quoi elle a été vérifiée.

`nature` est **déclarée, pas déduite**. Aucun script ne peut décider si « le clignotant
s'utilise à chaque changement de voie » porte une valeur datable.

- `stable` — une règle sans chiffre, sans seuil, sans sanction. Colonnes `source` et
  `relevé le` vides.
- `datée` — tout seuil, barème, montant, durée ou qualification pénale. URL d'un domaine
  de la liste blanche **et** date de relevé obligatoires.

La liste blanche : `legifrance.gouv.fr`, `securite-routiere.gouv.fr`,
`service-public.gouv.fr`, `ecologie.gouv.fr`, `sante.gouv.fr`, `unece.org`,
`eur-lex.europa.eu`, `cprguidelines.eu`, `croix-rouge.fr`, `inrs.fr`. Rien d'autre : les
éditeurs d'ETG et les sites d'auto-école se recopient et périment sans le dire, ce qui est
exactement le défaut que ce registre corrige.

`audit.py` signale un relevé de plus de douze mois. Ce n'est pas une erreur, c'est une
échéance : le droit routier bouge, et la passe d'août 2026 a trouvé un chiffre périmé
depuis trois jours.

| id | nature | affirmation vérifiée | source | relevé le |
|---|---|---|---|---|
```

- [ ] **Step 3: Relire les 136 `nature` à la main**

Le classement automatique se trompe dans les deux sens : « Le clignotant doit être utilisé à chaque changement de direction ou de voie » n'a pas de valeur datable malgré le mot « voie », et une question sur la qualification d'une infraction peut n'avoir aucun chiffre tout en étant parfaitement datable. Relire les 136 lignes et corriger `nature`, puis remplacer « à renseigner » par ce qui est réellement vérifié, en une phrase : « limitation hors agglomération sur chaussée séparée », « points retirés pour refus de priorité », « qualification pénale de la conduite sans permis ».

- [ ] **Step 4: Ajouter les contrôles à `audit.py`**

Étendre l'import (`Tools/audit.py:9`) :

```python
import json, os, re, sys, unicodedata, collections, datetime
```

Après le bloc `TOPICS_DECLARES` de la tâche 1, insérer :

```python
SOURCES_MD = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'sources.md')
# Domaines dont une affirmation datable peut se réclamer. La liste est fermée : un éditeur
# d'ETG recopie et périme sans le dire, et c'est précisément le défaut que ce registre
# corrige. Élargie en août 2026 aux institutions européennes et académiques, faute de
# source gouvernementale chiffrée sur les gestes de secours et la géométrie des panneaux.
DOMAINES = ('legifrance.gouv.fr', 'securite-routiere.gouv.fr', 'service-public.gouv.fr',
            'ecologie.gouv.fr', 'sante.gouv.fr', 'unece.org', 'eur-lex.europa.eu',
            'cprguidelines.eu', 'croix-rouge.fr', 'inrs.fr')
LIGNE_SOURCE = re.compile(
    r'^\|\s*`([0-9a-f]{32})`\s*\|\s*(stable|datée)\s*\|([^|]*)\|([^|]*)\|([^|]*)\|\s*$', re.M)
try:
    REGISTRE = {m[0]: (m[1], m[2].strip(), m[3].strip(), m[4].strip())
                for m in LIGNE_SOURCE.findall(open(SOURCES_MD).read())}
except OSError:
    REGISTRE = {}
```

Après la boucle principale, avant le bloc `order = [...]`, insérer :

```python
# --- registre de fraîcheur ---
# Le seul contrôle d'`audit.py` qui ne porte pas sur la forme : il ne dit pas qu'une
# valeur est juste, il dit que quelqu'un a écrit contre quoi et quand il l'a vérifiée.
# C'est ce qui rend la passe rejouable dans six mois plutôt qu'à refaire.
AUJOURDHUI = datetime.date.today()
for q in QS:
    if q['subject'] != 'code':
        continue
    ligne = REGISTRE.get(q['id'])
    if ligne is None:
        flag('source/absente', q, 'aucune ligne dans sources.md')
        continue
    nature, affirmation, source, releve = ligne
    if not affirmation or 'à renseigner' in affirmation:
        flag('source/affirmation-vide', q, affirmation or '(vide)')
    if nature == 'datée':
        if not any(d in source for d in DOMAINES):
            flag('source/hors-liste-blanche', q, source or '(vide)')
        try:
            jour = datetime.date.fromisoformat(releve)
        except ValueError:
            flag('source/date-illisible', q, releve or '(vide)')
        else:
            if (AUJOURDHUI - jour).days > 365:
                flag('source/releve-perime', q, f'{releve} — plus de douze mois')
    elif source or releve:
        flag('source/stable-avec-source', q, f'«{source}» «{releve}»')

orphelines = sorted(set(REGISTRE) - {q['id'] for q in QS if q['subject'] == 'code'})
```

Puis, tout à la fin du fichier, après la boucle des longueurs :

```python
if orphelines:
    print(f"\n### source/ligne-orpheline  ({len(orphelines)})")
    for qid in orphelines:
        print(f"  {qid[:8]} — ligne dans sources.md sans question `code` correspondante")
```

- [ ] **Step 5: Vérifier que les contrôles mordent**

```bash
python3 Tools/audit.py | grep '^### source/'
```

Attendu, à ce stade : `source/hors-liste-blanche` avec un compteur égal au nombre de lignes `datée` (aucune n'est encore vérifiée), `source/date-illisible` au même compteur, et **aucune** ligne `source/absente`, `source/stable-avec-source` ni `source/ligne-orpheline`. C'est cette sortie qui devient la liste de travail des tâches 5 à 17.

Vérifier que l'absence mord :

```bash
python3 - <<'EOF'
import json
qs = json.load(open('Valido/Resources/questions.json'))
q = dict(next(x for x in qs if x['subject'] == 'code'))
q['id'] = 'f' * 32
qs.append(q)
json.dump(qs, open('/tmp/faux2.json', 'w'), ensure_ascii=False)
EOF
python3 Tools/audit.py /tmp/faux2.json | grep 'source/absente'
```

Attendu : `### source/absente  (1)`.

- [ ] **Step 6: Commiter**

```bash
git add Tools/sources.md Tools/audit.py
git commit -m "$(cat <<'EOF'
Make per-question legal freshness a checked fact

The August pass verified figures and recorded it in prose, attached to no
question. Six months on nobody could say which question was checked,
against what, or when — and that pass had found a figure stale for three
days. Every code question now carries a declared nature: a stable rule,
or a dated value that owes a whitelisted URL and a survey date. audit.py
refuses a code question missing from the ledger, so a new question cannot
enter unverified, and flags a survey older than twelve months.

The whitelist is closed on purpose. Driving-school sites copy each other
and go stale silently, which is the defect being fixed.

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

### Task 3: Budget de hauteur imposé

**Files:**
- Modify: `Tools/audit.py` (bloc `# --- illustration ---`, autour de la ligne 91)
- Modify: `ValidoTests/BundledContentTests.swift` (ajout en fin de fichier)
- Modify: `Valido/Resources/questions.json` (4 questions à raccourcir)

**Interfaces:**
- Consomme : l'ordre de sortie étendu par la tâche 1.
- Produit : `image/enonce-trop-long`, `image/option-trop-longue`, `image/expl-trop-longue` dans `audit.py` ; le test `leBudgetDeHauteurDesQuestionsIllustréesEstTenu()`. Les tâches 5 à 17 écrivent leurs questions illustrées sous ce budget.

Le §7 de `questions.md` chiffre déjà ce budget, mais en prose. À quarante questions illustrées, la prose ne tient pas : une explication trop longue fait tomber le bandeau à 8 % de la carte, il ne reste qu'une bande de la scène, et rien ne le signale. **Quatre des huit questions illustrées actuelles violent déjà ces seuils** — le contrôle démarre donc en rouge, et se corrige dans les données.

- [ ] **Step 1: Écrire le test qui échoue**

À la fin de `ValidoTests/BundledContentTests.swift` :

```swift
/// Le bandeau de `QuestionCardView` réclame jusqu'à 38 % de la carte avant réponse et
/// 18 % après, et il **cède** quand le texte n'a plus la place — aucun texte de la carte
/// n'est compressible, donc l'image est le seul élément qui puisse reculer. Mesuré sur
/// les huit premières illustrées : à 220 caractères d'explication et un énoncé de trois
/// lignes, le bandeau descend à 8 % et il ne reste qu'une bande de la scène.
///
/// Les chiffres viennent du §7 de `Tools/questions.md`, où ils n'étaient que de la prose.
/// À quarante questions illustrées, la prose ne tient plus.
@Test func leBudgetDeHauteurDesQuestionsIllustréesEstTenu() throws {
    let bank = try QuestionBank.bundled()
    var fautives: [String] = []
    for question in bank.questions where question.illustration != nil {
        if question.prompt.count > 70 {
            fautives.append("\(question.id) énoncé \(question.prompt.count)")
        }
        for option in question.options where option.text.count > 50 {
            fautives.append("\(question.id) option \(option.text.count)")
        }
        if question.explanation.count > 220 {
            fautives.append("\(question.id) explication \(question.explanation.count)")
        }
    }
    #expect(fautives == [])
}
```

- [ ] **Step 2: Lancer le test pour le voir échouer**

```bash
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  -only-testing:'ValidoTests/leBudgetDeHauteurDesQuestionsIllustréesEstTenu()' 2>&1 | tail -20
```

Attendu : ÉCHEC, avec cinq entrées — `carrefour-cedez-le-passage` explication 223, `carrefour-en-t` option 51, `rond-point-insertion` option 51 et explication 272, `panneau-giratoire-vue-conducteur` explication 261. Vérifier la ligne `✔ Test run with 1 test(s)` : sans les parenthèses dans `-only-testing`, zéro test tourne et le build est quand même annoncé réussi.

- [ ] **Step 3: Raccourcir les quatre questions dans les données**

Ne pas relever les seuils — la règle du dépôt est que l'échec se corrige dans les données. Pour chacune : retirer de l'explication ce qui répète la bonne option ou détaille un cas de bord, et raccourcir l'option de 51 caractères d'un mot. Attention en touchant les options : l'équilibre de longueur (`longueur/plus-10`, `longueur/registre`) se relit après.

- [ ] **Step 4: Lancer le test pour le voir passer**

```bash
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  -only-testing:'ValidoTests/leBudgetDeHauteurDesQuestionsIllustréesEstTenu()' 2>&1 | tail -20
```

Attendu : `✔ Test run with 1 test(s)`, aucun échec.

- [ ] **Step 5: Porter le même contrôle dans `audit.py`**

Dans le bloc `# --- illustration ---`, après le contrôle `image/alt-trop-court` (`Tools/audit.py:91`) :

```python
        # Budget de hauteur du §7, désormais imposé : le bandeau cède quand le texte
        # n'a plus la place, et l'image est le seul élément compressible de la carte.
        # Le test `leBudgetDeHauteurDesQuestionsIllustréesEstTenu` verrouille les mêmes
        # seuils sur le livré ; celui-ci les attrape avant le build.
        if len(q['prompt']) > 70:
            flag('image/enonce-trop-long', q, f"{len(q['prompt'])} car. (max 70)")
        for o in q['options']:
            if len(o['text']) > 50:
                flag('image/option-trop-longue', q, f"{o['id']} : {len(o['text'])} car. (max 50)")
        if len(expl) > 220:
            flag('image/expl-trop-longue', q, f'{len(expl)} car. (max 220)')
```

- [ ] **Step 6: Vérifier l'accord entre les deux contrôles**

```bash
python3 Tools/audit.py | grep '^### image/'
```

Attendu : aucune ligne `image/enonce-trop-long`, `image/option-trop-longue` ni `image/expl-trop-longue`. Les deux contrôles doivent dire la même chose : `audit.py` regarde le disque, le test regarde le bundle compilé.

- [ ] **Step 7: Suite complète, puis commit**

```bash
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' 2>&1 | tail -25
git add Tools/audit.py ValidoTests/BundledContentTests.swift Valido/Resources/questions.json
git commit -m "$(cat <<'EOF'
Enforce the illustrated-card height budget

The banner cedes height when the text has none left — no text on the card
is compressible, so the image is the only element that can retreat. At 220
characters of explanation the banner drops to 8% and only a strip of the
scene survives. Those figures were prose in questions.md §7; at forty
illustrated questions prose does not hold.

Four of the eight existing illustrated questions were already over, and
they are trimmed rather than the thresholds raised.

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

### Task 4: Découper le script de rendu, primitives de panneaux

**Files:**
- Create: `Tools/Scenes/Repere.swift`, `Tools/Scenes/Primitives.swift`, `Tools/Scenes/Panneaux.swift`, `Tools/Scenes/ScenesCarrefour.swift`, `Tools/Scenes/main.swift`, `Tools/render-scenes.sh`
- Delete: `Tools/render-scenes.swift`
- Modify: `Tools/images.md` (section « Schémas dessinés », commande de rendu)

**Interfaces:**
- Consomme : rien.
- Produit :
  - `Repere.swift` — `let W = 400.0, H = 300.0`, `voie`, `cx`, `cy`, `struct Palette`, `func rgb(_:_:_:_:) -> CGColor`, `let clair: Palette`, `let sombre: Palette`
  - `Primitives.swift` — `enum Cap { case nord, sud, est, ouest }`, `chausseeVerticale(_:_:)`, `chausseeSud(_:_:)`, `chausseeHorizontale(_:_:)`, `axeVertical(_:_:)`, `axeSud(_:_:)`, `axeHorizontal(_:_:)`, `voiture(_:x:y:cap:couleur:liseree:_:)`, `fleche(_:_:couleur:)`, `texte(_:_:centre:taille:couleur:)`, `ligneDArret(_:_:)`, `ligneDeCedez(_:_:)`, `fond(_:_:)`, plus les repères de voie (`voieVous`, `demiVoiture`, `seuilSud`, `seuilNord`, `seuilEst`, `seuilOuest`, `voieDepuisLaDroite`, `voieDepuisLaGauche`, `voieDenFace`)
  - `Panneaux.swift` — `enum Forme { case disque, triangle, triangleInverse, octogone, carre, losange }`, `func panneau(_ ctx: CGContext, forme: Forme, at pt: CGPoint, rayon: Double, fond: CGColor, bord: CGColor?, epaisseurBord: Double, _ p: Palette)`, plus une fonction courte par panneau : `panneauStop`, `panneauCedez`, `panneauRoutePrioritaire`
  - `ScenesCarrefour.swift` — `let scenesCarrefour: [(String, Scene)]`, les six existantes
  - `main.swift` — `typealias Scene = (CGContext, Palette) -> Void`, `let scenes: [(String, Scene)]`, `rendre(_:_:echelle:)`, `ecrire(_:_:)`, et le code de haut niveau
- Les tâches 5 à 13 ajoutent des scènes dans `ScenesPanneaux.swift` et `ScenesCirculation.swift`, et des panneaux dans `Panneaux.swift`.

`render-scenes.swift` fait 453 lignes pour six scènes, avec les panneaux en fonctions jetables. À quarante scènes, le fichier dépasse 1500 lignes. Cette tâche le découpe **sans changer un pixel** : c'est ce qui la rend vérifiable.

- [ ] **Step 1: Empreinte des PNG actuels, pour prouver l'identité du rendu**

```bash
find Valido/Assets.xcassets/Scenes -name '*.png' | sort | xargs shasum -a 256 > /tmp/avant.sha
wc -l /tmp/avant.sha
```

Attendu : 24 lignes (six imagesets × quatre PNG).

- [ ] **Step 2: Découper le fichier**

Le code de haut niveau doit être dans `main.swift` : c'est la seule règle de `swiftc` sur plusieurs fichiers. Répartition :

| lignes de l'original | destination |
|---|---|
| 1-4 (imports), 17-45 (repère, `Palette`, `rgb`, `clair`, `sombre`) | `Repere.swift` |
| 47-96 (chaussées, axes), 98-196 (`Cap`, `voiture`, `fleche`, `texte`, marquages), 254-284 (repères de voie, `fond`, `croisementNu`) | `Primitives.swift` |
| 198-251 (`panneauStop`, `panneauCedez`, `panneauRoutePrioritaire`) | `Panneaux.swift`, réécrits sur la primitive |
| 286-384 (la table `scenes`) | `ScenesCarrefour.swift`, renommée `scenesCarrefour` |
| 252 (`typealias Scene`), 386-453 (rendu et sortie) | `main.swift` |

Chaque fichier reprend les imports dont il a besoin (`import CoreGraphics`, `import CoreText` pour `texte`, `import AppKit` pour `NSBitmapImageRep` dans `main.swift`). Les commentaires existants suivent leur code : ils portent le *pourquoi* (le ratio 4:3 dicté par le rétrécissement du bandeau, la chaussée étroite pour le cadrage, le liseré blanc contre le daltonisme) et se perdraient sinon.

- [ ] **Step 3: Écrire la primitive de panneau**

`Tools/Scenes/Panneaux.swift` :

```swift
import CoreGraphics

/// Les formes réglementaires. La géométrie d'un panneau est une norme publique
/// (Instruction interministérielle sur la signalisation routière) : elle se redessine,
/// elle ne se recopie pas chez un éditeur d'ETG.
enum Forme {
    case disque
    case triangle          // danger : pointe en haut
    case triangleInverse   // cédez le passage
    case octogone          // STOP, et lui seul
    case carre
    case losange           // carré posé sur la pointe : AB6, fin de priorité
}

/// Un panneau se dessine en deux temps — le fond, puis un bord d'épaisseur donnée —
/// parce que c'est le bord qui distingue une interdiction (liseré rouge épais) d'une
/// indication (fond plein). Le pictogramme est dessiné par l'appelant, par-dessus.
///
/// `rayon` est le rayon du cercle circonscrit : à 15-17, un panneau reste lisible dans
/// la bande centrale qui survit au rétrécissement du bandeau à 18 %.
func panneau(_ ctx: CGContext, forme: Forme, at pt: CGPoint, rayon: Double,
             fond: CGColor, bord: CGColor? = nil, epaisseurBord: Double = 0) {
    func chemin(_ r: Double) -> CGPath {
        let path = CGMutablePath()
        switch forme {
        case .disque:
            path.addEllipse(in: CGRect(x: pt.x - r, y: pt.y - r, width: r * 2, height: r * 2))
        case .triangle:
            path.move(to: CGPoint(x: pt.x, y: pt.y - r * 0.95))
            path.addLine(to: CGPoint(x: pt.x + r, y: pt.y + r * 0.72))
            path.addLine(to: CGPoint(x: pt.x - r, y: pt.y + r * 0.72))
        case .triangleInverse:
            path.move(to: CGPoint(x: pt.x - r, y: pt.y - r * 0.72))
            path.addLine(to: CGPoint(x: pt.x + r, y: pt.y - r * 0.72))
            path.addLine(to: CGPoint(x: pt.x, y: pt.y + r * 0.95))
        case .octogone:
            for i in 0..<8 {
                let a = Double(i) * .pi / 4 + .pi / 8
                let q = CGPoint(x: pt.x + cos(a) * r, y: pt.y + sin(a) * r)
                i == 0 ? path.move(to: q) : path.addLine(to: q)
            }
        case .carre:
            let c = r * 0.78
            path.addRect(CGRect(x: pt.x - c, y: pt.y - c, width: c * 2, height: c * 2))
        case .losange:
            path.move(to: CGPoint(x: pt.x, y: pt.y - r))
            path.addLine(to: CGPoint(x: pt.x + r, y: pt.y))
            path.addLine(to: CGPoint(x: pt.x, y: pt.y + r))
            path.addLine(to: CGPoint(x: pt.x - r, y: pt.y))
        }
        path.closeSubpath()
        return path
    }
    if let bord, epaisseurBord > 0 {
        ctx.setFillColor(bord)
        ctx.addPath(chemin(rayon))
        ctx.fillPath()
        ctx.setFillColor(fond)
        ctx.addPath(chemin(rayon - epaisseurBord))
        ctx.fillPath()
    } else {
        ctx.setFillColor(fond)
        ctx.addPath(chemin(rayon))
        ctx.fillPath()
    }
}
```

Puis les trois panneaux existants, réécrits dessus — même géométrie, mêmes rayons, donc mêmes pixels :

```swift
func panneauStop(_ ctx: CGContext, at pt: CGPoint, _ p: Palette) {
    panneau(ctx, forme: .octogone, at: pt, rayon: 15, fond: p.panneauRouge)
    texte(ctx, "STOP", centre: pt, taille: 8, couleur: p.panneauFond)
}

func panneauCedez(_ ctx: CGContext, at pt: CGPoint, _ p: Palette) {
    panneau(ctx, forme: .triangleInverse, at: pt, rayon: 17,
            fond: p.panneauFond, bord: p.panneauRouge, epaisseurBord: 17 * 0.38)
}

/// AB6, caractère prioritaire d'une route : un carré posé sur la pointe, fond blanc,
/// losange jaune au centre. C'est le pendant exact de la priorité à droite — même
/// carrefour, réponse inverse.
func panneauRoutePrioritaire(_ ctx: CGContext, at pt: CGPoint, _ p: Palette) {
    panneau(ctx, forme: .losange, at: pt, rayon: 17, fond: p.panneauFond)
    panneau(ctx, forme: .losange, at: pt, rayon: 10, fond: p.panneauJaune)
}
```

Le `panneauCedez` original dessinait un triangle plein rouge puis un triangle blanc à `k = 0.62` : l'épaisseur de bord équivalente est `17 × (1 − 0.62) = 6.46`, soit `17 * 0.38`. Si l'empreinte de l'étape 6 diffère, c'est ici qu'il faut regarder.

- [ ] **Step 4: Écrire `main.swift` et le lanceur**

`Tools/Scenes/main.swift` reprend `typealias Scene`, la table agrégée, puis le rendu et l'écriture inchangés :

```swift
let scenes: [(String, Scene)] = scenesCarrefour
```

À mesure que les tâches 5 à 13 ajoutent des tables, cette ligne devient `scenesCarrefour + scenesPanneaux + scenesCirculation`.

`Tools/render-scenes.sh` :

```bash
#!/bin/sh
# Rendu des schémas des questions illustrées. Le script a été découpé en plusieurs
# fichiers quand le nombre de scènes a dépassé la dizaine : `swift Fichier.swift` ne
# compile qu'un fichier, d'où `swiftc`. Le code de haut niveau doit rester dans main.swift.
#
# Les PNG ne s'éditent jamais à la main : on édite la scène, on relance ceci.
set -e
BIN="$(mktemp -d)/render-scenes"
DEVELOPER_DIR="${DEVELOPER_DIR:-/Applications/Xcode-26.3.0.app}" \
  swiftc -O "$(dirname "$0")"/Scenes/*.swift -o "$BIN"
exec "$BIN"
```

```bash
chmod +x Tools/render-scenes.sh
```

- [ ] **Step 5: Régénérer**

```bash
./Tools/render-scenes.sh
```

Attendu : six lignes, `carrefour-priorite-droite.imageset` … `rond-point-insertion.imageset`. Les deux photos Wikimedia ne sont pas régénérées — le script ne les touche pas.

- [ ] **Step 6: Prouver que le rendu est identique**

```bash
find Valido/Assets.xcassets/Scenes -name '*.png' | sort | xargs shasum -a 256 > /tmp/apres.sha
diff /tmp/avant.sha /tmp/apres.sha && echo "IDENTIQUE"
```

Attendu : `IDENTIQUE`. Un découpage qui change les pixels n'est pas un découpage — si le diff sort, corriger la géométrie du panneau (étape 3) avant d'aller plus loin. Les huit PNG des deux photos figurent dans les deux empreintes et doivent être inchangés eux aussi.

- [ ] **Step 7: Supprimer l'ancien script, mettre `images.md` à jour**

```bash
git rm Tools/render-scenes.swift
```

Dans `Tools/images.md`, section « Schémas dessinés », remplacer la mention de `Tools/render-scenes.swift` par `./Tools/render-scenes.sh` (deux occurrences : le paragraphe d'introduction et l'étape 1 de « Ajouter une image »), et ajouter une phrase sur le découpage : les panneaux vivent dans `Tools/Scenes/Panneaux.swift` et sont réutilisés par les scènes qui les contiennent.

- [ ] **Step 8: Suite complète, puis commit**

```bash
python3 Tools/audit.py | grep '^### image/'   # attendu : aucune sortie
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' 2>&1 | tail -25
git add Tools/Scenes Tools/render-scenes.sh Tools/images.md
git commit -m "$(cat <<'EOF'
Split the scene renderer, factor out sign primitives

453 lines for six scenes, with each sign a throwaway function; forty
scenes would put the file past 1500. Signs now come from one Forme ×
fill × border primitive, so a sign costs a dozen lines and — the point —
is drawn once: the AB6 serves both the question that asks what it means
and the junction scene that contains it.

swiftc replaces `swift file.swift`, which compiles a single file. Every
PNG is byte-identical to before, which is what makes the split checkable
rather than merely plausible.

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

## Phase 1 — Le contenu `code`, thématique par thématique

Chaque tâche suit la **Procédure C**. Ce qui suit est sa substance : le domaine, les affirmations à vérifier en priorité, les sujets manquants, les illustrations visées.

Les sept premières tâches prennent les domaines les plus lourds et les plus datables ; les trois suivantes les domaines stables ; les trois dernières créent les topics que la tâche 1 aura déclarés `absent`.

### Task 5: Vitesse

**Files:**
- Modify: `Valido/Resources/questions.json`, `Tools/sources.md`, `Tools/images.md`
- Create: `Tools/Scenes/ScenesCirculation.swift`, imagesets sous `Valido/Assets.xcassets/Scenes/`

**Interfaces:**
- Consomme : `Tools/sources.md` (tâche 2), les topics arrêtés par la tâche 1, `panneau(_:forme:at:rayon:fond:bord:epaisseurBord:)` (tâche 4).
- Produit : `let scenesCirculation: [(String, Scene)]` dans `ScenesCirculation.swift`, et la ligne `scenes` de `main.swift` étendue à `scenesCarrefour + scenesCirculation`.

Topic : `Vitesse`, 16 questions. Domaine le plus dense en valeurs datables de toute la banque.

- [ ] **Step 1: Procédure C, étape C1** sur le topic `Vitesse`.

- [ ] **Step 2: Procédure C, étape C2.** À vérifier en priorité :
  - **R413-2** — limitations générales, dont les 110 km/h sur route à chaussées séparées.
  - **R413-5** et les trois plafonds du permis probatoire (110 / 100 / 80).
  - **Délit d'excès de vitesse** : seuil de 5 km/h, paliers de 10 km/h — service-public fiche F31551, décrets 2023-1150 et 2025-1269. La passe d'août avait relevé la fiche au 27/02/2026 : relire la date de vérification actuelle.
  - **Grand excès de vitesse** : la passe d'août a corrigé une question qui le donnait encore comme contravention. Confirmer la qualification en vigueur.
  - **Zones 30, zones de rencontre, aires piétonnes** — vitesses respectives.
  - **Point signalé, non corrigé en août** : le périphérique parisien, où R413-3 permet 70 km/h alors que la Ville a abaissé à 50. Une question est écrivable **si** son sujet est l'écart entre règle nationale et arrêté local ; sinon, la laisser signalée.

- [ ] **Step 3: Procédure C, étapes C3 et C4** — corriger en recyclant, puis renseigner les 16 lignes du registre.

- [ ] **Step 4: Procédure C, étape C5.** Sujets manquants à écrire (viser +4 à +6) : vitesse par temps de pluie sur autoroute et sur route, vitesse en cas de visibilité réduite à moins de 50 mètres, vitesse minimale sur la voie de gauche d'autoroute, abaissement des limitations pour un conducteur en période probatoire quand la limite affichée est déjà inférieure, vitesse à l'approche d'un chantier signalé.

- [ ] **Step 5: Procédure C, étape C6.** Illustrations visées, dans `ScenesCirculation.swift` :
  - `panneau-b14-limitation` — disque à liseré rouge, nombre au centre. Question : « Ce panneau impose : », options qui distinguent limitation, vitesse conseillée, et fin de limitation.
  - `panneau-b33-fin-limitation` — même disque, barré d'une oblique. Le pendant exact du précédent : même image, réponse inverse.
  - `panneau-b30-zone-30` — entrée de zone 30, carré à fond blanc.
  - `distance-securite-autoroute` — deux véhicules sur autoroute, l'intervalle marqué. Question : « À 130 km/h, l'intervalle minimal correspond à : ».

  Pour créer le fichier, l'en-tête suit celui de `ScenesCarrefour.swift` et la table s'appelle `scenesCirculation`. Étendre ensuite `main.swift` :

```swift
let scenes: [(String, Scene)] = scenesCarrefour + scenesCirculation
```

- [ ] **Step 6: Procédure C, étapes C7 et C8** — audit puis suite complète.

- [ ] **Step 7: Procédure C, étape C9.** Message :

```
Speed: re-verify every dated figure, add four illustrated signs

Sixteen questions, the densest in dated values of the whole bank. Each
figure now carries its source and survey date in the ledger. The B14
limit sign and its B33 cancellation share one geometry and invert the
answer, which is the pair a candidate actually confuses.
```

---

### Task 6: Priorités & intersections

**Files:**
- Modify: `Valido/Resources/questions.json`, `Tools/sources.md`, `Tools/images.md`
- Modify: `Tools/Scenes/ScenesCarrefour.swift`, imagesets sous `Valido/Assets.xcassets/Scenes/`

**Interfaces:**
- Consomme : les primitives de carrefour de `Primitives.swift` (`croisementNu`, `voiture`, `fleche`, les repères de voie), `panneau(...)`.
- Produit : de nouvelles entrées dans `scenesCarrefour`.

Topic : `Priorités & intersections`, 21 questions — le plus gros topic de la banque, et **six des huit illustrations existantes** en viennent. Le domaine est majoritairement `stable` : les règles de priorité ne bougent pas, ce sont les points retirés qui bougent.

- [ ] **Step 1: Procédure C, étape C1** sur le topic `Priorités & intersections`.

- [ ] **Step 2: Procédure C, étape C2.** À vérifier :
  - **Barème de points** : refus de priorité 4 points, priorité piéton 6 points — relever la fiche service-public en vigueur et sa date.
  - **Priorité piéton engagé ou manifestant l'intention de traverser** : la rédaction de R415-11 a évolué, confirmer la formulation en vigueur.
  - **Véhicules d'intérêt général prioritaires** — ce qu'un usager doit faire, et si franchir une ligne continue est couvert (point corrigé en août : le vérifier tient).
  - **Panonceau M12** (arrêté du 12 janvier 2012) et **sas vélo** — déjà sourcés en août, confirmer.
  - Le reste du domaine est `stable` : priorité à droite, carrefour à sens giratoire, cédez-le-passage, STOP, croisement en pente.

- [ ] **Step 3: Procédure C, étapes C3 et C4** — les 21 lignes du registre.

- [ ] **Step 4: Procédure C, étape C5.** Sujets manquants (viser +3 à +5) : priorité à l'intérieur d'un giratoire quand le panneau AB25 est absent, sortie de giratoire et clignotant, croisement difficile en pente (qui cède à qui), intersection où les feux sont en panne ou clignotants, priorité d'un tramway.

- [ ] **Step 5: Procédure C, étape C6.** Illustrations visées, dans `scenesCarrefour` :
  - `carrefour-feu-en-panne` — le croisement nu avec un feu éteint, question sur la règle qui reprend.
  - `carrefour-tramway` — voie ferrée traversant le carrefour.
  - `croisement-en-pente` — deux véhicules face à face sur une chaussée étroite en pente.
  - `giratoire-sortie-clignotant` — véhicule sur l'anneau, sortie à droite.

- [ ] **Step 6: Procédure C, étapes C7 et C8.**

- [ ] **Step 7: Procédure C, étape C9.** Message :

```
Priorities: cover the cases the six existing scenes left out

Twenty-one questions, mostly stable rules — what moves here is the points
tariff, not the right of way. Adds the four situations a driver actually
hesitates on and that text cannot pose: a dead traffic light, a tramway
crossing, a narrow gradient, and leaving a roundabout.
```

---

### Task 7: Panneaux & marquage

**Files:**
- Modify: `Valido/Resources/questions.json`, `Tools/sources.md`, `Tools/images.md`, `Tools/Scenes/Panneaux.swift`
- Create: `Tools/Scenes/ScenesPanneaux.swift`, imagesets sous `Valido/Assets.xcassets/Scenes/`

**Interfaces:**
- Consomme : `Forme`, `panneau(...)`, `texte(...)`.
- Produit : `let scenesPanneaux: [(String, Scene)]` ; `main.swift` étendu à `scenesCarrefour + scenesCirculation + scenesPanneaux` ; une fonction par panneau dans `Panneaux.swift`, réutilisable par les scènes des autres tâches.

Topic : `Panneaux & marquage`, 17 questions. **C'est la tâche la plus lourde en illustrations** : un panneau se reconnaît, il ne se récite pas. C'est aussi celle où la transformation d'énoncé est la plus systématique — une question qui nomme le panneau dans son texte doit lui retirer ce nom pour que l'image le porte.

- [ ] **Step 1: Procédure C, étape C1** sur le topic `Panneaux & marquage`.

- [ ] **Step 2: Procédure C, étape C2.** Le domaine est très majoritairement `stable` : la sémantique d'un panneau ne se périme pas. Deux points à vérifier tout de même :
  - **Le panneau carré bleu** — la passe d'août a corrigé un mauvais exemple ; confirmer.
  - **Ligne continue** : franchissement 3 points contre chevauchement 1 — relever la fiche en vigueur.
  - La **géométrie et les couleurs normalisées** se vérifient sur l'Instruction interministérielle sur la signalisation routière (Legifrance) ou la Convention de Vienne (`unece.org`), qui entrent maintenant dans la liste blanche.

- [ ] **Step 3: Procédure C, étapes C3 et C4.**

- [ ] **Step 4: Ajouter les panneaux dans `Panneaux.swift`**

Une fonction courte par panneau, sur le modèle des trois de la tâche 4. À dessiner (≈14, en plus des trois existants) :

| fonction | panneau | forme |
|---|---|---|
| `panneauDangerGeneral` | A14, danger | triangle, liseré rouge |
| `panneauPassagePietons` | A13b | triangle, pictogramme piéton |
| `panneauVirage` | A1a | triangle, pictogramme courbe |
| `panneauSensInterdit` | B1 | disque rouge, barre blanche horizontale |
| `panneauInterdictionDepasser` | B3 | disque à liseré rouge, deux véhicules |
| `panneauStationnementInterdit` | B6a1 | disque bleu, liseré et oblique rouges |
| `panneauArretEtStationnementInterdits` | B6d | disque bleu, liseré et deux obliques rouges |
| `panneauSensGiratoire` | AB25 | triangle, trois flèches en anneau |
| `panneauDirectionObligatoire` | B21-1 | disque bleu, flèche blanche |
| `panneauVoieVelo` | C113 | carré bleu, pictogramme vélo |
| `panneauParking` | C1a | carré bleu, « P » |
| `panneauAutoroute` | C207 | carré bleu, pictogramme autoroute |
| `panneauFinPriorite` | AB7 | losange, barré d'une oblique |
| `panneauImpasse` | C13a | carré bleu, pictogramme impasse |

Chacune fait appel à `panneau(...)` pour le fond et le bord, puis dessine son pictogramme. Les pictogrammes complexes (piéton, vélo, autoroute) se réduisent à quelques formes : l'image est vue à ~90 points de haut dans la carte, un pictogramme simplifié y est plus lisible qu'un dessin fidèle. **Aucune information ne repose sur la couleur seule** : la forme et le pictogramme suffisent à distinguer chaque panneau de tous les autres du jeu.

- [ ] **Step 5: Écrire `ScenesPanneaux.swift`**

Une scène par panneau : le panneau seul, centré, sur le fond `p.sol`, à un rayon plus grand que dans une scène de carrefour (le panneau est le sujet, pas un détail). Prévoir aussi les scènes de marquage : `marquage-ligne-mixte`, `marquage-zebra-passage-pietons`, `marquage-fleche-rabattement`.

Étendre `main.swift` :

```swift
let scenes: [(String, Scene)] = scenesCarrefour + scenesCirculation + scenesPanneaux
```

- [ ] **Step 6: Procédure C, étape C5.** Sujets manquants (viser +4 à +6) : distinction panneau de danger / panneau d'interdiction par la forme, panonceau et ce qu'il modifie, panneau à fond jaune temporaire de chantier, marquage en damier, ligne mixte, flèches de rabattement.

- [ ] **Step 7: Procédure C, étape C6 — la transformation d'énoncé**

C'est ici qu'elle est la plus systématique. Pour chaque question existante qui **nomme** son panneau dans le texte, retirer ce nom et poser l'image : « Le panneau de forme octogonale, unique dans la signalisation, impose : » devient « Ce panneau impose : » avec `panneau-ab4-stop`. L'énoncé perd ce que l'image dit ; l'`alt` le reprend, puisqu'il **est** l'énoncé pour qui n'accède pas à l'image.

Attention au contrôle `image/enonce-redit-la-scene` : trois mots pleins communs entre `prompt` et `alt` le déclenchent. Un énoncé réduit à « Ce panneau impose : » ne peut pas le déclencher, ce qui est le signe qu'il est bien écrit.

Les questions dont le texte **ne peut pas** céder sa substance à une image — celles qui portent sur une règle et non sur une reconnaissance — restent en texte. Les noter pour le rapport de la tâche 21.

- [ ] **Step 8: Procédure C, étapes C7 et C8.**

- [ ] **Step 9: Procédure C, étape C9.** Message :

```
Signs: let the image carry the question

A sign is recognised, not recited, yet every question here named its sign
in the text — which made the answer readable without looking. Fourteen
signs are now drawn from the shared Forme primitive, and the questions
that could give up their substance to an image did: "the octagonal sign,
unique in French signage, requires" became "this sign requires".

Shape and pictogram alone separate every sign in the set; no question
turns on colour, so the set stays playable colour-blind.
```

---

### Task 8: Alcool & stupéfiants

**Files:**
- Modify: `Valido/Resources/questions.json`, `Tools/sources.md`

**Interfaces:**
- Consomme : le registre. Aucune illustration : ce domaine porte des seuils et des peines, rien qu'une image puisse poser.
- Produit : rien pour les tâches suivantes.

Topic : `Alcool & stupéfiants`, 14 questions. **Le domaine le plus volatil de la banque** : c'est ici que la passe d'août a trouvé un chiffre périmé depuis trois jours.

- [ ] **Step 1: Procédure C, étape C1.**

- [ ] **Step 2: Procédure C, étape C2.** À vérifier, sans exception :
  - **Seuils d'alcoolémie** : 0,5 g/l sang / 0,25 mg/l air expiré, et 0,2 / 0,1 en permis probatoire et transport en commun.
  - **L235-1**, conduite après usage de stupéfiants, et le **cumul alcool + stupéfiants** (5 ans et 15 000 € relevés en août). Vérifier la version en vigueur : c'est la valeur que la **loi n° 2026-798 du 18 août 2026** a modifiée.
  - **Refus de dépistage** — qualification et peines.
  - **Éthylotest antidémarrage** — régime en vigueur.
  - **Point signalé en août, à trancher ou re-signaler** : le tableau de service-public donne 9 points pour drogue + alcool, alors que [R223-2](https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000006841413) plafonne le retrait simultané à 8. Aucune question ne s'appuie sur ce chiffre aujourd'hui ; ne pas en créer une dessus. Inscrire la contradiction au registre en colonne `affirmation`.

- [ ] **Step 3: Procédure C, étapes C3 et C4.** Recycler impérativement : « 4 500 € et 2 ans de prison » était la bonne réponse jusqu'en août 2026, c'est maintenant le meilleur distracteur de sa question.

- [ ] **Step 4: Procédure C, étape C5.** Sujets manquants (viser +2 à +4) : délai d'élimination de l'alcool par l'organisme, équivalence entre un verre standard et l'alcoolémie, dépistage systématique après un accident corporel, conséquences sur l'assurance.

- [ ] **Step 5: Procédure C, étapes C7 et C8.** Pas d'illustration ici.

- [ ] **Step 6: Procédure C, étape C9.** Message :

```
Alcohol and drugs: re-verify against the August 2026 statute

The most volatile domain in the bank — the previous pass found a figure
here that had been stale for three days. Every threshold and penalty is
re-read against the version in force after loi n° 2026-798, and each
superseded figure becomes a distractor: it is what a candidate will have
read elsewhere.
```

---

### Task 9: Permis & sanctions

**Files:**
- Modify: `Valido/Resources/questions.json`, `Tools/sources.md`

**Interfaces:**
- Consomme : le registre. Pas d'illustration.
- Produit : rien pour les tâches suivantes.

Topic : `Permis & sanctions`, 14 questions. C'est la tâche qui **ferme le point ouvert le plus lourd** de la passe d'août.

- [ ] **Step 1: Procédure C, étape C1.**

- [ ] **Step 2: Procédure C, étape C2.** Le point ouvert d'août, à traiter d'abord :

La **loi n° 2026-798 du 18 août 2026** modifie L224-1 (rétention du permis), L233-1, L235-1, et introduit des renvois à L236-1 / L236-2 (rodéos). Seul L235-1 a été balayé en août. Par ailleurs la [décision n° 2026-915 DC du 14 août 2026](https://www.legifrance.gouv.fr/jorf/id/JORFTEXT000054707332) a déclaré **non conformes** certaines de ses dispositions. Établir, article par article sur Legifrance, **ce qui est en vigueur aujourd'hui** avant d'écrire quoi que ce soit. Si la lecture reste incertaine sur un point, le signaler au registre plutôt que d'écrire une question dessus.

Le reste à vérifier :
  - **Période probatoire** : durée, durée réduite après conduite accompagnée, capital initial et progression.
  - **[R223-2](https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000006841413)** — plafond de 8 points sur infractions simultanées.
  - **Reconstitution du capital** : délai sans infraction, stage de récupération.
  - **Homicide routier** — [art. 221-18 à 221-21 du code pénal](https://www.legifrance.gouv.fr/codes/section_lc/LEGITEXT000006070719/LEGISCTA000051872738/) : 7 ans et 100 000 €, portés à 10 ans et 150 000 € dès deux circonstances aggravantes. Confirmer.
  - **[L221-2](https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000039099784)** — conduite sans permis : 1 an et 15 000 €. Confirmer.

- [ ] **Step 3: Procédure C, étapes C3 et C4.**

- [ ] **Step 4: Procédure C, étape C5.** Sujets manquants (viser +3 à +5), en n'écrivant que ce que l'étape 2 a pu établir : rétention du permis par un officier (durée, suites), suspension administrative contre suspension judiciaire, conduite malgré suspension, rodéo motorisé (qualification et peine), permis à points d'un conducteur étranger.

- [ ] **Step 5: Procédure C, étapes C7 et C8.**

- [ ] **Step 6: Procédure C, étape C9.** Message :

```
Licence and penalties: close the August 2026 statute question

The previous pass swept only L235-1 of loi n° 2026-798 and left licence
retention and rodeos open, with part of the statute struck down by
decision 2026-915 DC. Each article is now read in its version in force,
and what stayed unclear is recorded in the ledger rather than answered
by a question.
```

---

### Task 10: Feux

**Files:**
- Modify: `Valido/Resources/questions.json`, `Tools/sources.md`, `Tools/images.md`, `Tools/Scenes/ScenesCirculation.swift`, imagesets

**Interfaces:**
- Consomme : `scenesCirculation` (créée en tâche 5), `panneau(...)`.
- Produit : de nouvelles entrées dans `scenesCirculation`.

Topic : `Feux`, 10 questions. Domaine presque entièrement `stable`, et fortement illustrable : un feu se voit.

- [ ] **Step 1: Procédure C, étape C1.**

- [ ] **Step 2: Procédure C, étape C2.** Peu de valeurs datables. À vérifier : les **feux arrière antibrouillard** (la passe d'août avait retiré « épais » et « forte » d'une question faute de source — confirmer la règle en vigueur), et les cas d'usage obligatoire des feux de croisement de jour.

- [ ] **Step 3: Procédure C, étapes C3 et C4** — la plupart des lignes seront `stable`.

- [ ] **Step 4: Procédure C, étape C5.** Sujets manquants (viser +4 à +6) : feu orange clignotant, feu rouge clignotant (passage à niveau), flèche verte concomitante d'un feu rouge, feu de détresse et ses cas d'usage, panne de feux de croisement de nuit.

  **Ce topic reçoit en plus la visibilité et l'éclairage**, que la tâche 17 n'a plus le droit de porter : la carte de couverture rattache `Feux` à deux thématiques — « Signalisation » et « Visibilité et éclairage » — et signale la moitié éclairage comme mince une fois isolée. À écrire aussi : feux de croisement obligatoires de jour et dans quels cas, usage des feux de route et quand les abaisser, feux de brouillard avant et arrière et leur interdiction hors brouillard, éclairage d'un véhicule à l'arrêt sur la chaussée, conduite de nuit face à un véhicule mal éclairé. Viser +3 de plus sur cette moitié.

- [ ] **Step 5: Procédure C, étape C6.** Illustrations visées :
  - `feu-orange-clignotant` — le carrefour avec un feu en orange clignotant.
  - `feu-fleche-verte` — feu rouge et flèche verte à droite, la combinaison que les candidats confondent.
  - `feu-rouge-clignotant-passage-niveau` — passage à niveau, feu rouge clignotant.

  Les trois états d'un feu doivent se distinguer **sans la couleur** : la position de la lampe allumée dans le boîtier porte l'information, exactement comme le liseré blanc distingue le véhicule du candidat.

- [ ] **Step 6: Procédure C, étapes C7 et C8.**

- [ ] **Step 7: Procédure C, étape C9.** Message :

```
Traffic lights: three states an image can pose and text cannot

Almost entirely stable rules, and the most illustratable domain left: a
light is seen. The lit lamp's position in the housing carries the state,
not its colour — same rule as the white outline on the candidate's car.
```

---

### Task 11: Arrêt & stationnement

**Files:**
- Modify: `Valido/Resources/questions.json`, `Tools/sources.md`, `Tools/images.md`, `Tools/Scenes/ScenesCirculation.swift`, imagesets

**Interfaces:**
- Consomme : `scenesCirculation`, les panneaux `panneauStationnementInterdit` et `panneauArretEtStationnementInterdits` (tâche 7).
- Produit : de nouvelles entrées dans `scenesCirculation`.

Topic : `Arrêt & stationnement`, 11 questions. Une illustration existe déjà (`ligne-jaune-continue`, photo Wikimedia).

- [ ] **Step 1: Procédure C, étape C1.**

- [ ] **Step 2: Procédure C, étape C2.** À vérifier : montant de l'amende pour stationnement gênant, très gênant et dangereux (trois niveaux distincts, chacun avec sa source) ; distance minimale d'un passage piéton ; règles sur les emplacements réservés (personnes handicapées, recharge électrique).

- [ ] **Step 3: Procédure C, étapes C3 et C4.**

- [ ] **Step 4: Procédure C, étape C5.** Sujets manquants (viser +2 à +4) : différence arrêt / stationnement, stationnement unilatéral alterné, stationnement en épi et en bataille, ouverture de portière et responsabilité, stationnement devant une bouche à incendie.

- [ ] **Step 5: Procédure C, étape C6.** Illustrations visées :
  - `stationnement-en-epi` — vue de dessus, la disposition demandée.
  - `stationnement-ligne-jaune-discontinue` — le pendant de la photo existante : discontinue interdit le stationnement, continue interdit aussi l'arrêt. Même bordure, réponse différente.
  - `stationnement-place-reservee` — marquage au sol d'une place réservée.

- [ ] **Step 6: Procédure C, étapes C7 et C8.**

- [ ] **Step 7: Procédure C, étape C9.** Message :

```
Parking: pair the yellow lines the existing photo left half-told

A continuous kerb line bans stopping, a broken one only parking — same
kerb, different answer, and the bank held only the first. Adds the pair,
plus the parking layouts that read from above and nowhere else.
```

---

### Task 12: Distances & freinage

**Files:**
- Modify: `Valido/Resources/questions.json`, `Tools/sources.md`, `Tools/images.md`, `Tools/Scenes/ScenesCirculation.swift`, imagesets

**Interfaces:**
- Consomme : `scenesCirculation`.
- Produit : de nouvelles entrées dans `scenesCirculation`.

Topic : `Distances & freinage`, 10 questions. Domaine de calculs et d'ordres de grandeur : la plupart des lignes seront `datée`, parce qu'un chiffre non sourcé est exactement le défaut qu'on corrige.

- [ ] **Step 1: Procédure C, étape C1.**

- [ ] **Step 2: Procédure C, étape C2.** À vérifier : temps de réaction retenu par la sécurité routière, distances d'arrêt aux vitesses usuelles, règle des deux secondes, distance de sécurité minimale et son intervalle en tunnel, allongement sur chaussée mouillée. Chaque valeur doit venir de `securite-routiere.gouv.fr` ou `service-public.gouv.fr` — un ordre de grandeur recopié ailleurs ne suffit pas.

- [ ] **Step 3: Procédure C, étapes C3 et C4.**

- [ ] **Step 4: Procédure C, étape C5.** Sujets manquants (viser +4 à +6) : distance de sécurité exprimée en secondes plutôt qu'en mètres, distance de sécurité imposée aux poids lourds, freinage d'urgence et ABS, aquaplanage.

  **Ce topic reçoit en plus l'autoroute et les intempéries**, que la tâche 17 ne porte plus. À écrire aussi : insertion depuis la bretelle et voie d'entrecroisement (qui s'adapte à qui), bande d'arrêt d'urgence — usages autorisés et sanction, distance de sécurité sur autoroute et son repère au sol, conduite par vent latéral à la sortie d'un ouvrage, conduite par neige ou verglas et allongement de la distance d'arrêt. Viser +3 de plus.

- [ ] **Step 5: Procédure C, étape C6.** Illustration visée : `distance-securite-tunnel` — deux véhicules en tunnel, l'intervalle marqué. Le pendant de `distance-securite-autoroute` de la tâche 5.

- [ ] **Step 6: Procédure C, étapes C7 et C8.**

- [ ] **Step 7: Procédure C, étape C9.** Message :

```
Distances: source every order of magnitude

A domain made of figures, so nearly every line lands as dated. An
unsourced order of magnitude is exactly the defect this pass exists to
fix, so each reaction time and stopping distance now names the official
page it came from.
```

---

### Task 13: Mécanique & environnement

**Files:**
- Modify: `Valido/Resources/questions.json`, `Tools/sources.md`

**Interfaces:**
- Consomme : le registre.
- Produit : rien pour les tâches suivantes.

Topic : `Mécanique & environnement`, 10 questions. Contient le second point ouvert d'août,
et **absorbe les équipements de sécurité et le chargement** après la réaffectation décidée
au vu de la carte de couverture.

- [ ] **Step 1: Procédure C, étape C1.**

- [ ] **Step 2: Procédure C, étape C2.** Le point ouvert d'août :

**ZFE et Crit'Air.** Le ministère maintenait les ZFE comme outil légal et la vignette comme obligatoire ([page ZFE, mise à jour 13 août 2025](https://www.ecologie.gouv.fr/politiques-publiques/zones-faibles-emissions-zfe)), mais une suppression avait été votée à l'Assemblée et la page officielle avait alors plus d'un an. Vérifier **l'état du droit**, pas l'état de la page : chercher le texte sur Legifrance. La question Crit'Air existante porte sur le classement du véhicule, qui ne dépend pas du sort des ZFE — elle survit dans tous les cas.

Le reste à vérifier : périodicité du contrôle technique et de sa contre-visite, usure minimale légale des pneumatiques, obligations d'équipement hivernal (loi Montagne, communes concernées).

- [ ] **Step 3: Procédure C, étapes C3 et C4.**

- [ ] **Step 4: Procédure C, étape C5.** Sujets manquants (viser +6 à +9) : éco-conduite et surconsommation (rapport engagé, climatisation, galerie de toit), voyants du tableau de bord et gravité (rouge contre orange), pression des pneumatiques et son effet sur la distance de freinage, recyclage des huiles et batteries.

  **Ce topic reçoit en plus les équipements de sécurité et le chargement**, que le plan avait d'abord logés dans une tâche 16 qui n'existe plus sous cette forme : aucune des onze thématiques officielles ne les nomme, et la carte de couverture donne `Mécanique & environnement` comme `à compléter`. À écrire aussi :
  - **ceinture** — obligation, exemptions, sanction ; **airbag** et siège enfant dos à la route en place avant ;
  - **sièges enfants** — jusqu'à quel âge ou quelle taille, quelle homologation ;
  - **gilet de haute visibilité et triangle** — ce qui est obligatoire à bord. Attention : la passe d'août a retiré « visible à 100 m » d'une question faute de source. Ne réintroduire un chiffre que s'il se relève sur la liste blanche ;
  - **charge utile, PTAC, PTRA** — définitions et où les lire sur la carte grise ;
  - **dépassement du chargement** — à l'arrière, à l'avant, signalisation exigée ;
  - **attelage et remorque** — permis requis selon le PTAC, vitesse applicable.

- [ ] **Step 5: Procédure C, étape C6.** Illustrations visées, dans `scenesCirculation` — elles viennent avec les sujets repris de l'ancienne tâche 16 :
  - `chargement-depassement-arriere` — véhicule vu de côté, chargement dépassant, la signalisation en question.
  - `triangle-presignalisation-place` — véhicule en panne et position du triangle sur la chaussée.
  - `siege-enfant-place-avant` — vue de côté, siège dos à la route en place avant.

- [ ] **Step 6: Procédure C, étapes C7 et C8.**

- [ ] **Step 7: Procédure C, étape C9.** Message :

```
Mechanics and environment: settle the ZFE question against the statute

The August pass left this open because the ministry page was a year old
while a repeal had passed the Assembly. Checked against the law rather
than the page. The Crit'Air question survives either way: it turns on
how a vehicle is classified, not on what becomes of the zones.
```

---

### Task 14: Premiers secours

**Files:**
- Modify: `Valido/Resources/questions.json`, `Tools/sources.md`

**Interfaces:**
- Consomme : le registre, et l'élargissement de la liste blanche décidé dans la spec.
- Produit : rien pour les tâches suivantes.

Topic : `Premiers secours`, 13 questions. **C'est la tâche que l'élargissement de la liste blanche débloque** : la passe d'août avait renoncé à créer des questions sur la fréquence des compressions et la conduite face à une brûlure, faute de source sur un domaine gouvernemental. `cprguidelines.eu` (ERC) et `croix-rouge.fr` entrent maintenant dans la liste.

- [ ] **Step 1: Procédure C, étape C1.**

- [ ] **Step 2: Procédure C, étape C2.** À vérifier :
  - **« Appeler, masser, défibriller »** et la perte de 10 % de survie par minute perdue — [sante.gouv.fr, DAE](https://sante.gouv.fr/prevention-en-sante/preserver-sa-sante/dae). Confirmer.
  - **Fréquence et profondeur des compressions thoraciques** — ERC Guidelines. C'est la valeur qu'août n'avait pas pu sourcer.
  - **PAS** (protéger, alerter, secourir) et les numéros d'urgence (15, 17, 18, 112, 114).
  - **Conduite face à une brûlure**, face à un casque de motard, face à une hémorragie — Croix-Rouge française.
  - **Retrait du casque** : la règle « on ne retire pas le casque sauf si… » demande une source précise, pas une formule mémorisée.

- [ ] **Step 3: Procédure C, étapes C3 et C4.** Une source ERC ou Croix-Rouge se relève comme une source gouvernementale : URL et date. Si la page ERC ne porte pas de date visible, relever l'année de l'édition des guidelines.

- [ ] **Step 4: Procédure C, étape C5.** Sujets manquants (viser +3 à +5) : fréquence des compressions, profondeur des compressions, brûlure (règle des 15), casque de motard, position latérale de sécurité et quand elle s'applique, hémorragie externe.

- [ ] **Step 5: Procédure C, étapes C7 et C8.**

- [ ] **Step 6: Procédure C, étape C9.** Message :

```
First aid: write the questions the old whitelist forbade

The August pass declined to create questions on compression rate or burn
care because no government domain carried the figures. ERC guidelines and
the French Red Cross now sit in the whitelist — still institutions, no
driving-school sites — and the gap closes.
```

---

### Task 15: Usagers & partage de la route

**Files:**
- Modify: `Valido/Resources/questions.json`, `Tools/sources.md`, `Tools/couverture.md`, `Tools/images.md`, `Tools/Scenes/ScenesCirculation.swift`, imagesets

**Interfaces:**
- Consomme : le topic **`Usagers & partage de la route`**, arrêté par la tâche 1 dans `couverture.md` pour la thématique « Usagers, partage de l'espace public ». Écrire ce nom au caractère près — `audit.py` refuse tout autre.
- Produit : le premier topic neuf de la banque, et de nouvelles entrées dans `scenesCirculation`.

Thématique « Usagers, partage de l'espace public », **absente de la banque**. Piétons, cyclistes, deux-roues motorisés, poids lourds, engins de déplacement personnel, transports en commun, angles morts. C'est le plus gros trou de couverture, et le plus illustrable — un angle mort ne se décrit pas, il se montre.

- [ ] **Step 1: Créer le topic `Usagers & partage de la route`** — le nom exact est arrêté dans la section « Topics à créer » de `couverture.md`.

- [ ] **Step 2: Procédure C, étape C2.** À sourcer avant d'écrire :
  - **Cyclistes** — panonceau M12 ([arrêté du 12 janvier 2012](https://www.legifrance.gouv.fr/jorf/id/JORFTEXT000025202146)), sas vélo, distance latérale de dépassement en et hors agglomération ([securite-routiere.gouv.fr, règles pour les cyclistes](https://www.securite-routiere.gouv.fr/reglementation-liee-aux-modes-de-deplacements/velo/regles-de-circulation-pour-les-cyclistes)).
  - **EDPM** (trottinettes) — âge minimum, vitesse maximale, où circuler, casque.
  - **Deux-roues motorisés** — circulation inter-files (régime en vigueur : expérimentation ou pérennisation), équipements obligatoires du conducteur et du passager.
  - **Poids lourds** — angles morts, signalisation obligatoire des angles morts sur le véhicule, distance de dépassement.
  - **Piétons** — passage piéton, priorité, obligations du piéton hors agglomération.
  - **Transports en commun** — priorité d'un bus quittant son arrêt, dépassement d'un bus scolaire à l'arrêt.

- [ ] **Step 3: Écrire les questions.** Viser 14 à 18, ce qui met le topic au niveau des plus gros. Répartition ~40 % `facile`, 40 % `moyen`, 20 % `costaud`. Chaque question passe les sept règles de distracteur et les neuf pièges de forme.

- [ ] **Step 4: Procédure C, étape C4** — les lignes du registre pour toutes les questions neuves.

- [ ] **Step 5: Procédure C, étape C6.** Illustrations visées :
  - `angle-mort-poids-lourd` — vue de dessus, les zones non vues depuis la cabine. La question type de ce domaine, et strictement impossible en texte.
  - `depassement-cycliste-distance` — la distance latérale, en agglomération et hors.
  - `sas-cycliste-feu` — le sas en amont du feu, et qui peut s'y placer.
  - `bus-quittant-arret` — bus signalant son départ, question de priorité.

- [ ] **Step 6: Mettre `couverture.md` à jour** — volume réel, verdict `couvert`.

- [ ] **Step 7: Procédure C, étapes C7 et C8.**

- [ ] **Step 8: Procédure C, étape C9.** Message :

```
Add the missing syllabus theme: other road users

The largest coverage hole, and the most visual: a lorry's blind spots do
not describe, they show. Pedestrians, cyclists, powered scooters,
motorcycles, lorries and buses now have a topic, with the lateral
overtaking distances and inter-file rules read off the official pages.
```

---

### Task 16: Croisement & dépassement

**Files:**
- Modify: `Valido/Resources/questions.json`, `Tools/sources.md`, `Tools/couverture.md`, `Tools/images.md`, `Tools/Scenes/ScenesCirculation.swift`, imagesets

**Interfaces:**
- Consomme : le topic **`Croisement & dépassement`**, arrêté par la tâche 1 dans `couverture.md`. Écrire ce nom au caractère près.
- Produit : le second topic neuf, et de nouvelles entrées dans `scenesCirculation`.

Thématique **absente de la banque**, et que le plan initial n'avait pas anticipée : c'est la
tâche 1 qui l'a fait apparaître. Le dépassement est la manœuvre la plus illustrable de tout
l'examen — une ligne discontinue, un véhicule engagé, un tiers en face, et la question se
pose d'elle-même. Elle ne se pose pas en texte.

Cette tâche **ne traite pas** les équipements de sécurité et le chargement, que le plan
avait d'abord logés ici : aucune des onze thématiques officielles ne les nomme, et ils sont
passés à la tâche 13 (`Mécanique & environnement`).

- [ ] **Step 1: Créer le topic `Croisement & dépassement`** — nom exact depuis la section « Topics à créer » de `couverture.md`.

- [ ] **Step 2: Procédure C, étape C2.** À sourcer avant d'écrire :
  - **Où le dépassement est interdit** — sommet de côte, virage sans visibilité, passage à niveau, intersection, passage piéton ; et ce que dit le marquage par rapport au panneau.
  - **Dépassement par la droite** — les cas où il est licite (véhicule signalant qu'il tourne à gauche, circulation en files).
  - **Ligne continue et ligne mixte** — franchissement 3 points contre chevauchement 1 ; la partie continue et de quel côté elle s'applique. Recoupe la tâche 7 : ne pas doublonner une question déjà écrite là, la proximité ne se voit pas d'`audit.py`.
  - **Distance latérale de dépassement d'un cycliste** — 1 m en agglomération, 1,50 m hors ; recoupe la tâche 15, se coordonner.
  - **Croisement sur chaussée étroite et en pente** — qui cède ; recoupe la tâche 6, qui traite le même cas sous l'angle de la priorité. Une question par angle au maximum.
  - **Dépassement d'un poids lourd, d'un convoi, d'un véhicule agricole** — durée d'exposition et rabattement.
  - **Dépassement interdit aux véhicules de plus de 3,5 t** par temps de pluie sur autoroute.

- [ ] **Step 3: Écrire les questions.** Viser 12 à 16, réparties ~40 % `facile`, 40 % `moyen`, 20 % `costaud`. Chaque question passe les sept règles de distracteur et les neuf pièges de forme du §1 et §2 de `Tools/questions.md`.

- [ ] **Step 4: Procédure C, étape C4** — une ligne de registre par question neuve.

- [ ] **Step 5: Procédure C, étape C6.** Illustrations visées, dans `scenesCirculation` :
  - `depassement-ligne-discontinue` — la manœuvre en cours, un tiers venant en face. Question : « Vous pouvez achever ce dépassement : ».
  - `depassement-sommet-de-cote` — la même route, la visibilité coupée par le relief. Même géométrie que la précédente, réponse inverse : c'est la paire qui apprend quelque chose.
  - `depassement-cycliste-distance` — la distance latérale ; **une seule scène pour les tâches 15 et 16**, celle qui la dessine la première la déclare dans `images.md` et l'autre la réutilise.
  - `croisement-chaussee-etroite` — deux véhicules face à face, un obstacle d'un côté.
  - `rabattement-apres-depassement` — le véhicule dépassant, la distance de rabattement en question.

- [ ] **Step 6: Mettre `couverture.md` à jour** — volume réel, verdict `couvert`.

- [ ] **Step 7: Procédure C, étapes C7 et C8.**

- [ ] **Step 8: Procédure C, étape C9.** Message :

```
Add the missing syllabus theme: crossing and overtaking

The plan had not foreseen this theme; the syllabus map surfaced it. It is
the most illustratable manoeuvre in the exam — a broken line, a committed
car, oncoming traffic — and the least posable in text. The overtaking pair
carries the point: same road, visibility cut by the crest, opposite answer.
```

### Task 17: Tunnels & passages à niveau

**Files:**
- Modify: `Valido/Resources/questions.json`, `Tools/sources.md`, `Tools/couverture.md`, `Tools/images.md`, `Tools/Scenes/ScenesCirculation.swift`, imagesets

**Interfaces:**
- Consomme : le topic **`Tunnels & passages à niveau`**, arrêté par la tâche 1 dans `couverture.md`. Écrire ce nom au caractère près.
- Produit : le troisième topic neuf ; les dernières entrées de `scenesCirculation`.

Thématique **absente de la banque**. Deux lieux où une erreur ne se corrige pas : un tunnel
dont on ne peut pas sortir, un passage à niveau qu'on ne peut pas quitter. C'est pour ça
qu'ils ont leur thématique à l'examen.

Cette tâche est **plus resserrée que ce que le plan prévoyait d'abord** : autoroute et
intempéries sont passées à la tâche 12 (`Distances & freinage`), visibilité et éclairage à
la tâche 10 (`Feux`). Aucune des onze thématiques officielles ne porte « conditions de
circulation », et inventer un topic hors référentiel contredirait la tâche 1.

- [ ] **Step 1: Créer le topic `Tunnels & passages à niveau`** — nom exact depuis la section « Topics à créer » de `couverture.md`.

- [ ] **Step 2: Procédure C, étape C2.** À sourcer :
  - **Tunnel** — allumage obligatoire des feux, intervalle de sécurité en marche et à l'arrêt, interdiction du demi-tour et de la marche arrière, conduite à tenir en cas d'immobilisation, conduite à tenir en cas d'incendie (rester ou sortir, où sont les issues), fréquence radio et panneaux de rappel.
  - **Passage à niveau** — signalisation d'approche (les balises à trois, deux et un trait), conduite à tenir quand les barrières s'abaissent, interdiction absolue de s'engager sans pouvoir dégager, conduite à tenir en cas d'immobilisation sur la voie, numéro à appeler et sa présence sur le panneau.
  - **Sanctions** propres à ces deux lieux, si une source de la liste blanche les chiffre.

- [ ] **Step 3: Écrire les questions.** Viser 12 à 16, mêmes règles de répartition et de forme.

- [ ] **Step 4: Procédure C, étape C4.**

- [ ] **Step 5: Procédure C, étape C6.** Illustrations visées :
  - `tunnel-arret-urgence` — tunnel, niche de sécurité, véhicule arrêté.
  - `tunnel-intervalle` — deux véhicules en marche dans le tunnel, l'intervalle en question.
  - `passage-a-niveau-balises` — l'approche et ses balises, question sur ce qu'elles annoncent. Un cas où l'information est **purement visuelle** : le nombre de traits ne se dit pas dans un énoncé sans donner la réponse.
  - `passage-a-niveau-immobilise` — véhicule arrêté entre les barrières, question sur la conduite à tenir.

- [ ] **Step 6: Mettre `couverture.md` à jour**, puis vérifier qu'**aucune thématique ne reste au verdict `absent`** :

```bash
grep -c 'absent' Tools/couverture.md
```

Attendu : `0` dans la colonne verdict du tableau (la section « Topics à créer » peut encore mentionner le mot en prose). S'il reste une thématique `absent`, c'est une tâche 18 à ajouter au plan, pas une ligne à effacer.

- [ ] **Step 7: Procédure C, étapes C7 et C8.**

- [ ] **Step 8: Procédure C, étape C9.** Message :

```
Add the missing syllabus theme: tunnels and level crossings

Two places where a mistake cannot be undone: a tunnel you cannot leave, a
crossing you cannot clear. The approach markers are the case for an image
that text cannot make — counting the bars is the answer, so an prompt that
describes them has already given it away.

With this, no syllabus theme is left at verdict "absent".
```

## Phase 2 — Le contenu `swift`

### Task 18: Recenser les énoncés cassés

**Files:**
- Create: `/tmp/enonces-casses.md` (livrable de revue, non versionné)

**Interfaces:**
- Consomme : rien.
- Produit : la liste soumise à validation, reprise telle quelle par la tâche 19.

**Cette tâche ne modifie pas le contenu.** Elle produit un jugement, et un jugement s'approuve avant de s'appliquer à trente ou quarante questions.

- [ ] **Step 1: Extraire les 174 questions `swift`**

```bash
python3 - <<'EOF' > /tmp/swift-toutes.txt
import json
qs = json.load(open('Valido/Resources/questions.json'))
for i, q in enumerate(qs):
    if q['subject'] != 'swift':
        continue
    print(f"--- #{i} {q['id'][:8]} [{q['topic']}/{q['difficulty']}]")
    print(f"  Q: {q['prompt']}")
    for o in q['options']:
        print(f"  {'*' if o['id'] == q['correctID'] else ' '} {o['text']}")
    print(f"  E: {q['explanation']}")
EOF
grep -c '^---' /tmp/swift-toutes.txt
```

Attendu : `174`.

- [ ] **Step 2: Appliquer le critère à chacune**

Les trois cas, et eux seuls :

1. **Irrépondable sans connaître déjà la réponse** — l'énoncé ne donne aucune prise à quelqu'un qui raisonne.
2. **La bonne réponse dépend d'un contexte que l'énoncé ne donne pas** — deux options sont défendables selon une hypothèse non dite. Précédent connu du dépôt : « Sandbox iOS, `Caches` contre `tmp` », conservée en août parce que « à tout moment » dans l'énoncé tranche. C'est le niveau de précision attendu.
3. **L'énoncé nomme une API sans dire quelle dimension est demandée** — rôle, comportement, disponibilité, coût ? « `@ViewBuilder` : » demande son rôle et se répond ; un énoncé dont les quatre options mélangent les dimensions ne se répond pas.

Le format « fragment » finissant par « : » n'est **pas** un défaut en soi : 171 des 174 l'emploient, il est court, et la contrainte de hauteur de carte est réelle. Ce qui se corrige est l'ambiguïté, pas le format.

- [ ] **Step 3: Écrire la liste**

Dans `/tmp/enonces-casses.md`, une entrée par énoncé retenu :

```markdown
### `2aed9f0c` — Outillage & diagnostics
Cas 3 : nomme `@Test(arguments:)` sans dire si la question porte sur ce qu'il fait ou sur
quand l'employer ; deux options répondent chacune à une des deux lectures.
- Actuel : « En Swift Testing, `@Test(arguments:)` sert à : »
- Proposé : « `@Test(arguments:)` évite d'écrire : »
```

Chaque entrée porte le cas invoqué (1, 2 ou 3), la raison en une phrase, l'énoncé actuel et l'énoncé proposé. **L'`id` ne change pas** : la progression est indexée dessus.

- [ ] **Step 4: Soumettre la liste**

Afficher `/tmp/enonces-casses.md` et attendre validation avant la tâche 19. Volume attendu : 20 à 40 entrées. Si la liste dépasse 60, le critère a été appliqué trop large — le resserrer et resoumettre.

- [ ] **Step 5: Pas de commit.** Cette tâche ne touche à aucun fichier versionné.

---

### Task 19: Réécrire les énoncés validés

**Files:**
- Modify: `Valido/Resources/questions.json`

**Interfaces:**
- Consomme : `/tmp/enonces-casses.md` validé en tâche 18.
- Produit : rien pour les tâches suivantes.

- [ ] **Step 1: Relever les `id` avant réécriture**

```bash
python3 -c "
import json
qs = json.load(open('Valido/Resources/questions.json'))
print(sum(1 for q in qs), 'questions')
open('/tmp/ids-avant.txt','w').write('\n'.join(sorted(q['id'] for q in qs)))
"
```

- [ ] **Step 2: Appliquer les réécritures validées**

Pour chaque entrée : remplacer `prompt` par l'énoncé proposé. **Ne pas recalculer l'`id`.** Relire ensuite l'explication et les options : un énoncé plus précis peut rendre une explication redondante (`expl/paraphrase-litterale`) ou faire fuiter un mot dans la bonne option (`fuite/mot-enonce`). Corriger dans la foulée.

- [ ] **Step 3: Vérifier que les `id` n'ont pas bougé**

```bash
python3 -c "
import json
qs = json.load(open('Valido/Resources/questions.json'))
open('/tmp/ids-apres.txt','w').write('\n'.join(sorted(q['id'] for q in qs)))
"
diff /tmp/ids-avant.txt /tmp/ids-apres.txt && echo "IDS INCHANGÉS"
```

Attendu : `IDS INCHANGÉS`. Un `id` qui bouge réinitialise la progression de l'utilisateur sur cette question, en silence.

- [ ] **Step 4: Auditer**

```bash
python3 Tools/audit.py | grep '^### '
```

Comparer aux compteurs de la tâche précédente. `fuite/mot-enonce` doit rester absent ; `expl/paraphrase-litterale` peut avoir bougé et chaque nouvelle entrée se relit.

- [ ] **Step 5: Suite complète, puis commit**

```bash
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' 2>&1 | tail -25
git add Valido/Resources/questions.json
git commit -m "$(cat <<'EOF'
Swift: repair the prompts that could not be answered

Not a reformat. 171 of 174 prompts are fragments ending in a colon, and
that stays: it is short, and the card's height budget is real. What is
fixed is ambiguity — prompts unanswerable without already knowing the
answer, prompts whose answer turns on unstated context, and prompts that
name an API without saying which dimension is being asked.

Ids are untouched on purpose: progress is keyed on them, so recomputing
one would silently reset the user's history for that question.

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

### Task 20: Les trous `swift`

**Files:**
- Modify: `Valido/Resources/questions.json`

**Interfaces:**
- Consomme : rien.
- Produit : rien pour les tâches suivantes.

Il n'existe pas de référentiel pour `swift` : les treize topics sont ceux du dépôt. L'inventaire se fait donc contre les nouveautés de la plateforme, pas contre une liste officielle.

- [ ] **Step 1: Inventorier ce que la banque couvre déjà**

```bash
python3 - <<'EOF'
import json, collections
qs = json.load(open('Valido/Resources/questions.json'))
par_topic = collections.defaultdict(list)
for q in qs:
    if q['subject'] == 'swift':
        par_topic[q['topic']].append(q['prompt'])
for topic in sorted(par_topic):
    print(f"=== {topic} ({len(par_topic[topic])})")
    for p in sorted(par_topic[topic]):
        print(f"   {p}")
EOF
```

- [ ] **Step 2: Établir les nouveautés à couvrir**

`WebFetch` sur `https://www.swift.org/blog/` et sur les notes de version de Swift 6.2, puis sur `https://developer.apple.com/documentation/ios-ipados-release-notes` et les nouveautés d'iOS 26 et Xcode 26. Confronter à l'inventaire de l'étape 1 et lister ce qui manque. Pistes probables, à confirmer contre la documentation plutôt qu'à supposer : les nouveaux types de la bibliothèque standard, l'évolution de l'isolation par défaut et de la concurrence, les nouveautés de SwiftUI de la version, les frameworks apparus dans iOS 26, les outils apparus dans Xcode 26.

Ne rien écrire sur une API dont la documentation ne confirme ni le nom ni le comportement.

- [ ] **Step 3: Écrire 15 à 25 questions**

Réparties sur les topics existants — ne pas créer de topic `swift` neuf, les treize couvrent large. `sourceURL` pointe la page de documentation ou l'article `swift.org`. `id` par la recette des contraintes globales. Sept règles de distracteur, neuf pièges de forme.

Attention particulière au piège le plus fréquent de ce domaine : une bonne réponse qui cite le nom exact de l'API pendant que les trois distracteurs paraphrasent. C'est `forme/backtick-isole` dans `audit.py`, et c'est un cadeau au candidat.

- [ ] **Step 4: Auditer**

```bash
python3 Tools/audit.py | grep '^### '
```

Attendu : aucune sortie `schema/`, `fuite/`, `forme/backtick-isole` ni `longueur/plus-10`.

- [ ] **Step 5: Suite complète, puis commit**

```bash
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' 2>&1 | tail -25
git add Valido/Resources/questions.json
git commit -m "$(cat <<'EOF'
Swift: cover what iOS 26, Swift 6.2 and Xcode 26 added

No syllabus exists for this half of the bank, so the inventory runs
against the platform's release notes rather than an official list. Every
API named here is confirmed against its documentation page, which is
carried in sourceURL.

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

## Phase 3 — Clôture

### Task 21: Seuils, documentation, rapport

**Files:**
- Modify: `ValidoTests/BundledContentTests.swift:10,17,18` (seuils), fin de fichier (un test)
- Modify: `Tools/questions.md` (§3, §4, §5, §6, §7), `Tools/images.md`, `CLAUDE.md`, `README.md`
- Create: `Tools/audit-2026-08-passe-2.md`

**Interfaces:**
- Consomme : tout ce qui précède.
- Produit : le livrable final.

- [ ] **Step 1: Mesurer le volume réel**

```bash
python3 -c "
import json, collections
qs = json.load(open('Valido/Resources/questions.json'))
c = collections.Counter(q['subject'] for q in qs)
ill = sum(1 for q in qs if q.get('illustration'))
print('total', len(qs), dict(c), 'illustrées', ill)
print('seuils à écrire :', int(len(qs)*0.95), int(c['code']*0.95), int(c['swift']*0.95), int(ill*0.9))
"
```

- [ ] **Step 2: Écrire le test du volume illustré**

À la fin de `ValidoTests/BundledContentTests.swift` :

```swift
/// L'ETG est un examen visuel : un panneau se reconnaît, il ne se récite pas. La passe
/// d'août 2026 laissait huit questions illustrées sur 310, et rien n'empêchait ce nombre
/// de retomber à zéro sans qu'aucun test ne bronche. Seuil sous le volume livré, comme
/// les autres : un effondrement casse, une variation de quelques questions non.
@Test func laBanqueGardeSonVolumeIllustré() throws {
    let bank = try QuestionBank.bundled()
    let illustrées = bank.questions.filter { $0.illustration != nil }
    #expect(illustrées.count >= 35)
}
```

Ajuster `35` à la valeur calculée à l'étape 1 si le volume livré diffère.

- [ ] **Step 3: Relever les trois seuils existants**

Dans `ValidoTests/BundledContentTests.swift`, remplacer `295` (ligne 10), `125` (ligne 17) et `170` (ligne 18) par les valeurs de l'étape 1. Mettre à jour le commentaire de doc en tête du fichier s'il chiffre le volume.

- [ ] **Step 4: Lancer la suite**

```bash
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' 2>&1 | tail -25
```

Attendu : `✔ Test run with N test(s)` avec N ≥ 64, aucun échec.

- [ ] **Step 5: Mettre `Tools/questions.md` à jour**

- **§3** — ajouter les contrôles neufs à la liste : registre de fraîcheur (`source/*`), carte de couverture (`couverture/topic-non-rattache`), budget de hauteur (`image/enonce-trop-long`, `image/option-trop-longue`, `image/expl-trop-longue`). Remplacer la ligne de base citée (98 / 23 / 14) par la nouvelle, mesurée.
- **§4** — mettre les volumes et les seuils de test à jour, et ajouter les deux tests neufs à la liste de ce que `BundledContentTests` couvre.
- **§5** — élargir la liste blanche aux cinq domaines ajoutés, en disant **pourquoi** : aucun domaine gouvernemental ne chiffre les gestes de secours ni la géométrie normalisée des panneaux. Renvoyer vers `sources.md` comme registre par question, et vers `couverture.md`.
- **§6** — corriger la description de la recette d'`id`, qui laisse croire que `valido-v2:` est dans l'identifiant : l'`id` est `sha256("valido-v2:" + prompt)[:32]`, le préfixe est dans l'entrée du hachage. Mettre le compte de questions v2 à jour.
- **§7** — dire que le budget de hauteur est désormais imposé par `audit.py` **et** par un test, avec les trois seuils. Ajouter une sous-section sur les panneaux : forme et pictogramme portent l'information, jamais la couleur seule, et un panneau se dessine une fois dans `Tools/Scenes/Panneaux.swift` pour servir aussi les scènes qui le contiennent.

- [ ] **Step 5 bis: Purger les références à la commande de rendu supprimée**

La tâche 4 a remplacé `swift Tools/render-scenes.swift` par `./Tools/render-scenes.sh`, mais
trois mentions survivent hors de son périmètre — `README.md` lignes 116 et 138, et
`Tools/questions.md` ligne 358. Une commande documentée qui n'existe plus est un piège pour
le prochain lecteur.

```bash
grep -rn 'render-scenes\.swift' --include='*.md' . | grep -v '^\./\.superpowers\|^\./docs/superpowers'
```

Attendu après correction : aucune sortie. `docs/superpowers/` est de l'historique et ne se
met pas à jour — c'est la seule exception.

- [ ] **Step 6: Mettre `Tools/images.md` à jour**

Vérifier que **chaque** asset créé pendant la passe a sa ligne (c'est déjà imposé par `audit.py`, donc l'audit le dit), et que la section « Ajouter une image » décrit la nouvelle commande et le découpage en `Tools/Scenes/`.

- [ ] **Step 7: Mettre `CLAUDE.md` à jour**

Section « Commandes » : `./Tools/render-scenes.sh` remplace `swift Tools/render-scenes.swift`. La nouvelle ligne de base d'`audit.py`. Section « Le contenu est du code » : le volume, le nombre d'illustrées, et les deux registres neufs (`sources.md`, `couverture.md`) avec leur rôle en une phrase chacun. Section « Architecture » : rien à changer, l'app n'a pas bougé.

`CLAUDE.md` est **non suivi par git** au démarrage de cette passe (`?? CLAUDE.md`). Demander avant de l'ajouter au dépôt ; sinon le modifier sans le committer.

- [ ] **Step 8: Écrire le rapport**

`Tools/audit-2026-08-passe-2.md`, sur le modèle d'`audit-2026-08.md` :

1. **Ce qui a changé de valeur** — une entrée par correction : la question, l'ancienne valeur, la nouvelle, la source et sa date, et le fait que l'ancienne est devenue distracteur.
2. **Signalements non corrigés** — les points de doute, avec ce qui manque pour trancher. Y verser explicitement le sort de chaque point ouvert d'août : loi 2026-798, ZFE, périphérique, contradiction des 9 points.
3. **Couverture** — l'état final de `couverture.md`, et le fait qu'aucune thématique ne reste `absent`.
4. **Illustrations** — les assets créés, et **la liste des questions qu'on a renoncé à illustrer, avec la raison**. C'est la partie la plus utile du rapport pour la passe suivante.
5. **Énoncés `swift` réécrits** — la liste, avec le cas invoqué pour chacun.
6. **Nouvelle ligne de base d'`audit.py`** — les compteurs, pour que la passe suivante ait un point de comparaison.
7. **Ce qui change dans les tests** — les seuils et les deux tests ajoutés.

- [ ] **Step 9: Audit final et commit**

```bash
python3 Tools/audit.py > /tmp/audit-final.txt
grep '^### \|^== \|^code:\|^swift:' /tmp/audit-final.txt
```

Vérifier qu'aucune catégorie `schema/`, `source/`, `couverture/` ne sort, et que les sorties `image/` restantes sont les faux positifs `image/enonce-redit-la-scene` justifiés un par un.

```bash
git add ValidoTests/BundledContentTests.swift Tools/questions.md Tools/images.md \
        Tools/audit-2026-08-passe-2.md
git commit -m "$(cat <<'EOF'
Close the second content pass: thresholds, docs, report

Raises the volume floors to 95% of what ships, adds a floor under the
illustrated count — nothing stopped it falling back to zero — and records
the pass: every figure changed with its source and date, every doubt left
standing, and the questions declined for illustration with the reason.
That last list is what the next pass will actually use.

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>
EOF
)"
```

- [ ] **Step 10: Proposer la suite**

La branche est prête. Ne pas fusionner sans demande explicite. Résumer : volumes avant/après, nombre de valeurs corrigées, nombre de points signalés, nombre d'illustrations, et les questions restées sans réponse faute de source.

---

## Auto-revue du plan

**Couverture de la spec.** Chaque section de la spec a sa tâche : le socle → 1 à 4 ; fraîcheur et couverture `code` → 5 à 17 ; points ouverts d'août → 5 (périphérique), 8 (9 points), 9 (loi 2026-798), 13 (ZFE) ; liste blanche élargie → 2 (contrôle) et 14 (usage) ; illustrations → 5, 6, 7, 10, 11, 12, 15, 16, 17 ; `swift` chirurgical → 18 et 19 ; trous `swift` → 20 ; vérification → 21. Le hors-périmètre de la spec est respecté : aucune tâche ne touche à l'app, aux photos, ni à Notion.

**Deux écarts assumés par rapport à la spec.** Elle annonçait « environ douze commits » : le plan en compte vingt, parce que découper par domaine plutôt que par thématique agrégée donne des commits qu'un relecteur peut accepter ou refuser séparément. Elle annonçait aussi le budget de hauteur comme un ajout : il se révèle être une **correction**, quatre des huit questions illustrées le violant déjà.

**Cohérence des noms.** `Scene`, `Palette`, `Forme`, `panneau(_:forme:at:rayon:fond:bord:epaisseurBord:)`, `scenesCarrefour`, `scenesPanneaux`, `scenesCirculation`, `TOPICS_DECLARES`, `REGISTRE`, `DOMAINES`, `LIGNE_SOURCE`, `orphelines`, `leBudgetDeHauteurDesQuestionsIllustréesEstTenu()`, `laBanqueGardeSonVolumeIllustré()` : chacun est défini dans une tâche et repris sous le même nom dans les suivantes. `main.swift` agrège les trois tables de scènes, et la ligne `let scenes` est étendue explicitement en tâches 5 et 7.

**L'inconnu a été levé, et il a coûté une réaffectation.** La tâche 1 a établi onze
thématiques officielles, dont trois sans aucune question : `Croisement & dépassement`,
`Tunnels & passages à niveau`, `Usagers & partage de la route`. Le plan initial avait deviné
deux de ces trois de travers — il attendait « équipements & chargement » et « route &
conditions », et n'avait pas vu venir le dépassement, qui est pourtant la manœuvre la plus
illustrable de l'examen. Les tâches 15 à 17 ont été récrites sur les vrais libellés, et les
sujets orphelins répartis : équipements et chargement à la tâche 13, autoroute et intempéries
à la tâche 12, visibilité et éclairage à la tâche 10. Aucun sujet prévu n'a été perdu ; c'est
leur adresse qui a changé.
