# Diagnostic de forme des questions `code` — plan d'implémentation

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Mesurer et chiffrer l'écart de forme entre les 255 questions `code` de Valido et les questions de l'épreuve ETG réelle, sans corriger aucune carte.

**Architecture:** Trois livrables indépendants. (1) `Tools/audit.py` gagne une règle de corroboration qui ouvre la liste blanche aux éditeurs d'ETG sans leur donner autorité sur un chiffre. (2) Il gagne trois — éventuellement quatre — compteurs de forme, **informatifs**, qui tournent sur les 255 cartes. (3) Un rapport `Tools/audit-2026-09-formes.md` porte le corpus lu, la grille dérivée, les treize tableaux de domaine issus d'une lecture à la main, et une recommandation chiffrée de réécriture.

**Tech Stack:** Python 3 (bibliothèque standard uniquement — `audit.py` n'importe que `json, os, re, sys, unicodedata, collections, datetime`), Markdown, `WebFetch` pour le corpus. Aucun code Swift n'est touché.

**Spec:** [`docs/superpowers/specs/2026-09-06-formes-questions-etg-design.md`](../specs/2026-09-06-formes-questions-etg-design.md)

## Global Constraints

Chaque tâche hérite implicitement de ce qui suit.

- **Aucune carte de `Valido/Resources/questions.json` n'est modifiée.** Ni un `id`, ni une option, ni un `prompt`, ni une `explanation`. Le diagnostic mesure ; il ne corrige pas.
- **La ligne de base publiée doit rester identique** à la fin de chaque tâche : `lettre/reference` 1, `forme/markdown` 1, `forme/seule-ponctuee` 14, `longueur/plus-longue` 76, `expl/paraphrase-litterale` 20. Les sept catégories dures restent vides : `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10`, `forme/backtick-isole`.
- **Les 64 tests passent** à la fin de chaque tâche qui touche un fichier suivi.
- **Les nouveaux compteurs de forme sont informatifs.** Ils ne rejoignent **pas** la liste des compteurs devant rester vides. Cette phrase est écrite dans `CLAUDE.md` dans la tâche qui les crée, pas après coup.
- **Droit d'auteur :** on relève des formes, jamais des questions. Aucune question d'éditeur n'est recopiée dans `questions.json`, ni citée intégralement dans le rapport. Une observation décrit une structure (« l'énoncé pose la situation en deux lignes puis demande l'action »), elle ne reproduit pas le texte.
- **Langue :** commentaires, documentation et rapport en **français** ; messages de commit en **anglais**.
- **`audit.py` sort toujours 0.** C'est le rapport qu'on lit, jamais le code de retour.

**Commandes de référence :**

```bash
# L'audit (à lancer depuis la racine du dépôt)
python3 Tools/audit.py

# La suite de tests — le simulateur se démarre à la main d'abord
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl boot 'iPhone 17 Pro'
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro'
```

Ne juger que la ligne `✔ Test run with 64 tests`. Un `** TEST SUCCEEDED **` sans elle ne prouve rien.

## Structure des fichiers

| Fichier | Responsabilité | Tâches |
|---|---|---|
| `Tools/audit.py` | Contrôles mécaniques. Gagne la corroboration et les compteurs de forme. | 1, 4, 5 |
| `Tools/sources.md` | Registre de fraîcheur. Seul son **en-tête** de liste blanche est réécrit ; ses 255 lignes ne bougent pas. | 1 |
| `Tools/couverture.md` | Carte du référentiel. Gagne la distribution de référence, si le corpus permet de l'établir. | 5 |
| `CLAUDE.md` | Porte la ligne de base et le statut des compteurs. | 1, 4, 5 |
| `Tools/audit-2026-09-formes.md` | Le rapport. Créé en tâche 2, complété par chaque tâche suivante. | 2, 3, 6–18, 19 |

---

### Task 1: La règle de corroboration

Ouvre `sources.md` aux éditeurs d'ETG en garantissant mécaniquement qu'un éditeur ne peut jamais porter un chiffre seul. Indépendante du corpus, donc en premier : elle est entièrement testable sans rien avoir lu.

**Files:**
- Modify: `Tools/audit.py:70-77` (les constantes `SOURCES_MD` et `DOMAINES`)
- Modify: `Tools/audit.py:216-218` (le contrôle de liste blanche)
- Modify: `Tools/sources.md:14-21` (l'en-tête de liste blanche)
- Modify: `CLAUDE.md` (la liste des compteurs devant rester vides)
- Test: `/private/tmp/claude-501/-Users-guillaume-Developer-Swift-Valido/72e82e2e-7b82-4b1f-805f-470e4f7d2713/scratchpad/corrobo/` (registre et banque d'essai, jetables)

**Interfaces:**
- Consomme : rien.
- Produit : `DOMAINES_FAIT` (tuple de 11 domaines, seule autorité sur un chiffre), `DOMAINES_FORME` (tuple des domaines d'éditeurs), le flag `source/editeur-non-corrobore`, et la surcharge `VALIDO_SOURCES_MD` qui permet à toute tâche ultérieure de faire tourner `audit.py` contre un registre d'essai.

- [ ] **Step 1: Écrire le cas d'essai qui doit faire tomber le flag**

`audit.py` dérive aujourd'hui `SOURCES_MD` de `__file__` : aucun registre d'essai n'est atteignable. On crée d'abord la paire de fichiers, on rendra le chemin surchargeable au step 3.

```bash
D=/private/tmp/claude-501/-Users-guillaume-Developer-Swift-Valido/72e82e2e-7b82-4b1f-805f-470e4f7d2713/scratchpad/corrobo
mkdir -p "$D"

cat > "$D/questions.json" <<'JSON'
[
  {"id": "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa1", "subject": "code", "topic": "Vitesse",
   "difficulty": "moyen", "prompt": "Vous roulez sur cette route, la limite est de :",
   "options": [{"id": "A", "text": "80 km/h hors agglomeration"},
               {"id": "B", "text": "90 km/h hors agglomeration"},
               {"id": "C", "text": "70 km/h hors agglomeration"},
               {"id": "D", "text": "100 km/h hors agglomeration"}],
   "correctID": "A",
   "explanation": "La limite hors agglomeration sur route bidirectionnelle sans separateur central est fixee a quatre-vingts kilometres par heure."},
  {"id": "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa2", "subject": "code", "topic": "Vitesse",
   "difficulty": "moyen", "prompt": "Vous roulez sur cette autoroute, la limite est de :",
   "options": [{"id": "A", "text": "130 km/h par temps sec"},
               {"id": "B", "text": "110 km/h par temps sec"},
               {"id": "C", "text": "120 km/h par temps sec"},
               {"id": "D", "text": "150 km/h par temps sec"}],
   "correctID": "A",
   "explanation": "La limite sur autoroute par temps sec est fixee a cent trente kilometres par heure pour un conducteur hors periode probatoire."}
]
JSON

cat > "$D/sources.md" <<'MD'
# Registre d'essai — corroboration

| id | nature | affirmation | source | relevé le |
|---|---|---|---|---|
| `aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa1` | datée | 80 km/h hors agglomération | https://www.ornikar.com/code/limitations | 2026-09-06 |
| `aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa2` | datée | 130 km/h sur autoroute | https://www.ornikar.com/code/autoroute et https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000006841413 | 2026-09-06 |
MD
echo "cas d'essai écrits dans $D"
```

La première ligne ne porte qu'un éditeur : elle **doit** lever `source/editeur-non-corrobore`. La seconde porte l'éditeur **et** Légifrance : elle ne doit rien lever.

- [ ] **Step 2: Lancer l'audit contre le cas d'essai, pour constater qu'il ne voit rien**

```bash
D=/private/tmp/claude-501/-Users-guillaume-Developer-Swift-Valido/72e82e2e-7b82-4b1f-805f-470e4f7d2713/scratchpad/corrobo
VALIDO_SOURCES_MD="$D/sources.md" python3 Tools/audit.py "$D/questions.json" | grep -E '^### source/' || echo "aucun flag source/"
```

Attendu : `source/absente (2)` — la variable d'environnement est ignorée, `audit.py` lit encore le vrai `sources.md`, où ces deux ids n'existent pas. C'est l'échec qui justifie le step 3.

- [ ] **Step 3: Rendre le registre surchargeable et scinder la liste**

Dans `Tools/audit.py`, remplacer le bloc `SOURCES_MD` / `DOMAINES` (lignes 70 à 77) par :

```python
# Le registre est surchargeable pour que la règle de corroboration ci-dessous se vérifie
# sur un cas d'essai : sans ça elle n'est qu'une phrase dans un guide.
SOURCES_MD = os.environ.get('VALIDO_SOURCES_MD') or os.path.join(
    os.path.dirname(os.path.abspath(__file__)), 'sources.md')
# Deux listes, et la frontière entre les deux est le cœur du registre.
# `DOMAINES_FAIT` : seule autorité sur un chiffre. Élargie en août 2026 aux institutions
# européennes et académiques, faute de source gouvernementale chiffrée sur les gestes de
# secours et la géométrie des panneaux.
DOMAINES_FAIT = ('legifrance.gouv.fr', 'securite-routiere.gouv.fr', 'service-public.gouv.fr',
                 'ecologie.gouv.fr', 'sante.gouv.fr', 'unece.org', 'eur-lex.europa.eu',
                 'cprguidelines.eu', 'erc.edu', 'croix-rouge.fr', 'inrs.fr')
# `DOMAINES_FORME` : admis pour ce qu'un éditeur sait — comment l'examen pose la question,
# quel piège il tend, à quelle fréquence un thème tombe. Jamais pour un chiffre : un
# éditeur recopie et périme sans le dire, et c'est le défaut que ce registre corrige.
# D'où la règle : une ligne `datée` porte toujours une source de `DOMAINES_FAIT`, et une
# source d'éditeur ne vient qu'en plus.
DOMAINES_FORME = ('ornikar.com', 'envoituresimone.com', 'codeclic.com', 'digischool.fr')
```

- [ ] **Step 4: Écrire le contrôle**

Dans `Tools/audit.py`, remplacer les trois lignes du contrôle de liste blanche (lignes 216 à 218, à l'intérieur du `if nature == 'datée':`) par :

```python
    if nature == 'datée':
        if not any(d in source for d in DOMAINES_FAIT):
            if any(d in source for d in DOMAINES_FORME):
                flag('source/editeur-non-corrobore', q, source)
            else:
                flag('source/hors-liste-blanche', q, source or '(vide)')
```

Le préfixe `source/` figure déjà dans la liste `order` en fin de fichier, donc le nouveau compteur s'imprime sans autre changement.

- [ ] **Step 5: Relancer le cas d'essai — le flag doit tomber sur la première ligne seulement**

```bash
D=/private/tmp/claude-501/-Users-guillaume-Developer-Swift-Valido/72e82e2e-7b82-4b1f-805f-470e4f7d2713/scratchpad/corrobo
VALIDO_SOURCES_MD="$D/sources.md" python3 Tools/audit.py "$D/questions.json" | grep -E '^###|aaaaaaa'
```

Attendu, exactement : `### source/editeur-non-corrobore  (1)` suivi d'une seule ligne, celle de `aaaaaaaa…a1`. Si `…a2` apparaît aussi, la règle rejette une ligne correctement corroborée — corriger avant d'aller plus loin.

- [ ] **Step 6: Vérifier que le registre réel est intact**

```bash
python3 Tools/audit.py | grep -E '^### '
```

Attendu, exactement cinq lignes : `lettre/reference (1)`, `forme/markdown (1)`, `forme/seule-ponctuee (14)`, `longueur/plus-longue (76)`, `expl/paraphrase-litterale (20)`. Aucun `source/`. Le nouveau flag naît vide parce qu'aucune carte ne cite d'éditeur — c'est le résultat attendu, pas une absence de test : le step 5 a prouvé qu'il tombe quand il doit.

- [ ] **Step 7: Réécrire l'en-tête de liste blanche de `sources.md`**

Remplacer, dans `Tools/sources.md`, le paragraphe qui commence par « La liste blanche : » et se termine par « …porte d'entrée à citer pour les recommandations de secourisme. » par :

```markdown
**Deux listes, et la frontière entre les deux est ce que ce registre garantit.**

*Autorité sur un chiffre* (`DOMAINES_FAIT` dans `audit.py`) : `legifrance.gouv.fr`,
`securite-routiere.gouv.fr`, `service-public.gouv.fr`, `ecologie.gouv.fr`, `sante.gouv.fr`,
`unece.org`, `eur-lex.europa.eu`, `cprguidelines.eu`, `erc.edu`, `croix-rouge.fr`,
`inrs.fr`. `cprguidelines.eu` ne sert plus aucun contenu (voir plus bas) ; `erc.edu` — la
véritable adresse de l'ERC, dont `cprguidelines.eu` était une transcription erronée du nom
« ERC Guidelines » — est la porte d'entrée à citer pour les recommandations de secourisme.

*Admis en complément* (`DOMAINES_FORME`) : `ornikar.com`, `envoituresimone.com`,
`codeclic.com`, `digischool.fr`. Un éditeur d'ETG sait une chose que l'État ne publie pas :
comment l'examen pose la question, quel piège il tend, à quelle fréquence un thème tombe.
Il ne sait pas le droit — il le recopie et le périme sans le dire, ce qui est exactement le
défaut que ce registre corrige. **D'où la règle, tenue par `audit.py` et non par la bonne
volonté : une ligne `datée` porte toujours une source de la première liste ; une source
d'éditeur ne vient qu'en plus, jamais seule.** Le manquement lève
`source/editeur-non-corrobore`, qui doit rester vide.
```

- [ ] **Step 8: Inscrire le nouveau compteur dans `CLAUDE.md`**

Dans `CLAUDE.md`, la phrase qui énumère les compteurs devant rester vides se lit aujourd'hui :

```
Doivent rester **vides** : `schema/`, `couverture/`, `source/`, `fuite/`, `image/`,
`longueur/plus-10`, `forme/backtick-isole`
```

`source/` couvre déjà le nouveau flag par préfixe. Ajouter, juste après cette phrase, une ligne qui dit ce que le préfixe recouvre désormais :

```markdown
Depuis le 2026-09-06, `source/` recouvre aussi `source/editeur-non-corrobore` : la liste
blanche est scindée en `DOMAINES_FAIT` (autorité sur un chiffre) et `DOMAINES_FORME` (les
éditeurs d'ETG, admis pour la forme des questions), et une ligne `datée` qui ne citerait
qu'un éditeur est refusée. Le registre est surchargeable par `VALIDO_SOURCES_MD`, ce qui
sert à vérifier la règle sur un cas d'essai.
```

- [ ] **Step 9: Lancer la suite de tests**

```bash
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' 2>&1 \
  | grep -E "Test run with|✘|error:"
```

Attendu : `✔ Test run with 64 tests in 0 suites passed`. Aucun test ne lit `sources.md`, donc un échec ici signalerait autre chose — ne pas le corriger dans le test.

- [ ] **Step 10: Commit**

```bash
git add Tools/audit.py Tools/sources.md CLAUDE.md
git commit -m "$(cat <<'EOF'
Split the whitelist into fact and form, and enforce corroboration

ETG publishers know something the State does not publish -- how the exam frames
a question, which trap it sets, how often a theme comes up. They do not know the
law: they copy it and let it go stale silently, which is the defect this registry
exists to correct. So they are admitted, and never alone: a `datée` line always
carries a DOMAINES_FAIT source, and a publisher URL only ever comes in addition.

The rule is held by audit.py, not by good intentions. source/editeur-non-corrobore
fires on a line citing only a publisher, and it is verified rather than asserted:
VALIDO_SOURCES_MD makes the registry overridable, and a two-line test registry --
one publisher-only, one corroborated -- flags the first and passes the second.

It is born empty on the real registry: no card cites a publisher yet.

Baseline unchanged: 1 / 1 / 14 / 76 / 20, the seven hard categories empty.
64 tests pass.

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

### Task 2: Le corpus, et le rapport qu'il ouvre

**Files:**
- Create: `Tools/audit-2026-09-formes.md`

**Interfaces:**
- Consomme : rien.
- Produit : la section « 1. Le corpus » du rapport, et la liste des observations datées que la tâche 3 utilisera pour adosser chaque axe de la grille. Chaque observation porte un identifiant `OBS-n` cité par les tâches suivantes.

- [ ] **Step 1: Lire la strate 1 — le spécimen officiel**

Lire par `WebFetch` : `https://www.securite-routiere.gouv.fr/sites/default/files/2020-04/reponsesquestionspermisauto_v1604.pdf`

Relever, pour chaque question du PDF : la présence ou non d'une image, la personne grammaticale de l'énoncé, le nombre de propositions, le nombre de bonnes réponses, et l'étiquette de thème que le PDF porte. Consigner ces relevés en tableau — c'est le seul échantillon de **vraies** questions ETG du corpus.

- [ ] **Step 2: Lire la strate 2 — le texte de l'épreuve**

Chercher sur `legifrance.gouv.fr` l'arrêté en vigueur définissant l'épreuve théorique générale. Relever ce qui borne la forme : nombre de questions, seuil de réussite, temps de réponse, thèmes. Noter l'identifiant du texte et la date de relevé.

Si l'annexe qui porte le programme n'est reproduite qu'en image dans le fac-similé du JO — c'est le cas de l'arrêté du 27 avril 2016, écarté pour cette raison lors de la passe 2 — le noter comme illisible plutôt que de le paraphraser de mémoire.

- [ ] **Step 3: Lire la strate 3 — les éditeurs, en accès libre**

Tenter, un par un : `ornikar.com`, `envoituresimone.com`, `codeclic.com`, `digischool.fr`, et les pages éditoriales du type « les questions les plus ratées au code ». Pour chacun, noter ce qui a été **effectivement lu** et ce qui a été refusé (compte, paywall, rendu JavaScript vide).

Relever des **structures**, jamais des questions : « l'énoncé pose la situation en deux lignes puis demande l'action », « le distracteur inverse la condition », « trois propositions dont deux vraies ». Ne recopier aucun texte de question.

- [ ] **Step 4: Écrire l'en-tête et la section corpus du rapport**

Créer `Tools/audit-2026-09-formes.md` :

```markdown
# Forme des questions `code` — diagnostic contre l'épreuve réelle, septembre 2026

Quatrième intervention sur le contenu, après les passes 2
([`audit-2026-08-passe-2.md`](audit-2026-08-passe-2.md)) et 3
([`audit-2026-08-passe-3.md`](audit-2026-08-passe-3.md)). **Celle-ci ne corrige aucune
carte** : elle mesure un écart et le chiffre. Aucun `id`, aucune option, aucun `prompt` de
`questions.json` n'a été touché.

Spec : [`docs/superpowers/specs/2026-09-06-formes-questions-etg-design.md`](../docs/superpowers/specs/2026-09-06-formes-questions-etg-design.md).

## 1. Le corpus

Trois strates, par autorité décroissante. L'ordre décide du poids de chaque observation et
il est rappelé à chaque constat qui s'y appuie.

### Strate 1 — le spécimen officiel

[le tableau du step 1, une ligne par question du PDF]

### Strate 2 — le texte de l'épreuve

[ce que l'arrêté borne, avec son identifiant et la date de relevé]

### Strate 3 — les éditeurs, en accès libre

[ce qui a été lu, ce qui a été refusé, avec la date]

### Ce que ce corpus ne peut pas dire

La banque officielle n'est pas publique. Un éditeur produit sa propre imitation : la
strate 3 mesure « ce que le marché croit être une vraie question », et ce qu'un éditeur
publie en accès libre est de surcroît ce qu'il a choisi de montrer. Aucun constat du présent
rapport ne s'appuie sur la strate 3 seule sans le dire.

[si la strate 3 est revenue vide ou quasi vide, le dire ici, et dire ce que la grille perd]

## Observations

| id | strate | source | date | ce qui est observé |
|---|---|---|---|---|
| OBS-1 | … | … | … | … |
```

Chaque observation reçoit un identifiant `OBS-n`. La tâche 3 les cite ; un axe sans `OBS-n` sera retiré.

- [ ] **Step 5: Vérifier que le rapport ne cite aucune question d'éditeur**

```bash
python3 Tools/audit.py | grep -E '^### '   # la ligne de base ne doit pas bouger
wc -l Tools/audit-2026-09-formes.md
```

Relire la section strate 3 et confirmer, ligne à ligne, qu'aucune question n'y est reproduite — seulement des structures décrites.

- [ ] **Step 6: Commit**

```bash
git add Tools/audit-2026-09-formes.md
git commit -m "$(cat <<'EOF'
Open the form report with the corpus actually read

Three strata, and the order decides the weight of every later claim: the official
specimen PDF is the only real ETG questions publicly available, the arrêté bounds
the format, and the publishers -- read only where they are open -- say what the
market believes a real question looks like.

The report names what was refused as precisely as what was read. Structures are
recorded, never questions: no publisher text is reproduced.

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

### Task 3: La grille, dérivée du corpus

**Files:**
- Modify: `Tools/audit-2026-09-formes.md` (ajout de la section 2)

**Interfaces:**
- Consomme : les `OBS-n` de la tâche 2.
- Produit : la grille définitive. Les axes conservés déterminent quels compteurs la tâche 4 implémente ; un axe retiré ici n'a pas de compteur.

- [ ] **Step 1: Confronter chaque axe candidat aux observations**

Les six axes attendus par la spec, chacun à confirmer ou à retirer :

| Axe | Ce qu'il oppose |
|---|---|
| Ancrage | question posée sur une scène vue du poste de conduite / savoir hors situation |
| Personne | « je », « vous » / impersonnel |
| Objet | ce que je dois **faire** / ce que la règle **dit** |
| Piège | nuance de la règle, condition qui renverse, faux ami, distracteur hors sujet |
| Format | nombre et longueur des propositions |
| Poids | fréquence par thème |

Pour chacun : citer le ou les `OBS-n` qui le soutiennent. **Un axe sans observation est retiré**, et son retrait est écrit avec son motif — c'est un résultat, pas un oubli.

- [ ] **Step 2: Écrire la section 2 du rapport**

Ajouter à `Tools/audit-2026-09-formes.md` :

```markdown
## 2. La grille

Chaque axe est adossé aux observations qui le soutiennent. Un axe que le corpus n'a pas
soutenu est listé plus bas, avec son motif de retrait.

| Axe | Ce qu'il oppose | Observations | Mécanisable ? |
|---|---|---|---|
| … | … | OBS-n, OBS-m | oui / non, et pourquoi |

### Axes retirés

[l'axe, et pourquoi le corpus ne l'a pas soutenu]
```

La colonne « Mécanisable ? » est la ligne de partage de la spec : elle décide de ce qui entre dans `audit.py` en tâche 4 et de ce qui reste à la lecture à la main des tâches 6 à 18.

- [ ] **Step 3: Vérifier**

```bash
grep -c 'OBS-' Tools/audit-2026-09-formes.md   # chaque axe conservé doit en citer au moins un
python3 Tools/audit.py | grep -E '^### '        # ligne de base inchangée
```

- [ ] **Step 4: Commit**

```bash
git add Tools/audit-2026-09-formes.md
git commit -m "$(cat <<'EOF'
Derive the form grid from the corpus, and record what it dropped

Every axis kept cites the observations that support it; an axis the corpus did not
support is listed with the reason it was dropped, because that is a result and not
an omission. The "mechanisable" column is the dividing line the spec asks for: it
decides what becomes a counter and what stays a reading.

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

### Task 4: Les compteurs de forme dans `audit.py`

**Files:**
- Modify: `Tools/audit.py` (constantes après `LETTER`, et la boucle principale)
- Modify: `CLAUDE.md` (la ligne de base)
- Modify: `Tools/audit-2026-09-formes.md` (section 3)
- Test: le dossier `corrobo/` de la tâche 1, réutilisé

**Interfaces:**
- Consomme : la colonne « Mécanisable ? » de la tâche 3.
- Produit : les compteurs `forme/impersonnel`, `forme/hors-situation`, `forme/definitionnel` et leurs valeurs initiales sur les 255.

- [ ] **Step 1: Écrire le cas d'essai — deux cartes, l'une située, l'autre pas**

```bash
D=/private/tmp/claude-501/-Users-guillaume-Developer-Swift-Valido/72e82e2e-7b82-4b1f-805f-470e4f7d2713/scratchpad/corrobo
cat > "$D/formes.json" <<'JSON'
[
  {"id": "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb1", "subject": "code", "topic": "Vitesse",
   "difficulty": "moyen", "prompt": "Vous abordez cette descente, vous devez :",
   "options": [{"id": "A", "text": "retrograder pour retenir le vehicule"},
               {"id": "B", "text": "passer au point mort pour economiser"},
               {"id": "C", "text": "freiner en continu jusqu en bas"},
               {"id": "D", "text": "accelerer pour garder de l elan"}],
   "correctID": "A",
   "explanation": "Le frein moteur retient le vehicule sans chauffer les plaquettes, ce que le freinage continu ne permet pas sur une longue descente."},
  {"id": "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb2", "subject": "code", "topic": "Vitesse",
   "difficulty": "moyen", "prompt": "La distance de securite est :",
   "options": [{"id": "A", "text": "de deux secondes sur le vehicule precedent"},
               {"id": "B", "text": "de une seconde sur le vehicule precedent"},
               {"id": "C", "text": "de trois secondes sur le vehicule precedent"},
               {"id": "D", "text": "de quatre secondes sur le vehicule precedent"}],
   "correctID": "A",
   "explanation": "Deux secondes couvrent le temps de reaction du conducteur et la distance parcourue avant que le freinage ne produise son effet."}
]
JSON
echo "cas d'essai formes écrit"
```

`…b1` est située (« vous », « cette descente ») : elle ne doit lever aucun des trois compteurs. `…b2` est impersonnelle, hors situation et définitionnelle : elle doit lever les trois.

- [ ] **Step 2: Lancer pour constater que rien ne sort**

```bash
D=/private/tmp/claude-501/-Users-guillaume-Developer-Swift-Valido/72e82e2e-7b82-4b1f-805f-470e4f7d2713/scratchpad/corrobo
python3 Tools/audit.py "$D/formes.json" | grep -E '^### forme/(impersonnel|hors-situation|definitionnel)' || echo "aucun compteur de forme — attendu"
```

Attendu : `aucun compteur de forme — attendu`.

- [ ] **Step 3: Écrire les trois motifs**

Dans `Tools/audit.py`, après la définition de `LETTER` (vers la ligne 29) :

```python
# --- forme ETG (informatifs) ---
# Ces trois compteurs mesurent un écart de forme avec l'épreuve réelle, pas un défaut.
# Un énoncé impersonnel n'est pas fautif : sur une carte de signalisation ou de mécanique,
# c'est peut-être la forme juste. Ils ne rejoignent donc PAS les compteurs devant rester
# vides, et les faire baisser pour eux-mêmes est un contresens — c'est exactement ce que
# `expl/paraphrase-litterale` a appris à la passe 3.
PERSONNE = re.compile(r"\b(?:vous|votre|vos|je|mon|ma|mes)\b|\bj'", re.I)
# « ce », « cette » ne comptent que devant un nom : « ce qui », « ce que », « ce dont »
# ne situent rien.
DEICTIQUE = re.compile(
    r"\b(?:ce|cet|cette|ces)\s+(?!qui\b|que\b|qu'|dont\b)\w+"
    r"|\bici\b|\bdevant\b|\bderri[èe]re\b"
    r"|\bvous\s+(?:arrivez|roulez|approchez|suivez|circulez|abordez|quittez)\b", re.I)
DEFINITION = re.compile(
    r"\b(?:est|sont|sert\s+à|servent\s+à|signifie|signifient|indique|indiquent"
    r"|impose|imposent|doit\s+être|doivent\s+être|permet\s+de|permettent\s+de)\b", re.I)
```

- [ ] **Step 4: Brancher les compteurs dans la boucle**

Dans `Tools/audit.py`, à l'intérieur du `for q in QS:` de la boucle principale, juste après le bloc `# --- couverture ---` :

```python
    # --- forme ETG (informatifs, cf. le rapport du 2026-09) ---
    if q['subject'] == 'code':
        p = q['prompt']
        if not PERSONNE.search(p):
            flag('forme/impersonnel', q, f"«{p[:60]}»")
        if illu_absente(q) and not DEICTIQUE.search(p):
            flag('forme/hors-situation', q, f"«{p[:60]}»")
        if p.rstrip().endswith(':') and DEFINITION.search(p):
            flag('forme/definitionnel', q, f"«{p[:60]}»")
```

et, à côté des autres fonctions utilitaires (après `firstword`, vers la ligne 42) :

```python
def illu_absente(q):
    return q.get('illustration') is None
```

Le préfixe `forme/` figure déjà dans `order`, donc les trois compteurs s'impriment sans autre changement.

- [ ] **Step 5: Relancer le cas d'essai**

```bash
D=/private/tmp/claude-501/-Users-guillaume-Developer-Swift-Valido/72e82e2e-7b82-4b1f-805f-470e4f7d2713/scratchpad/corrobo
python3 Tools/audit.py "$D/formes.json" | grep -E '^###|bbbbbbb'
```

Attendu : les trois compteurs à `(1)`, et à chaque fois la carte `bbbbbbbb…b2`. Si `…b1` apparaît quelque part, le motif est trop large — corriger avant d'aller plus loin.

- [ ] **Step 6: Mesurer les 255, et trier les faux positifs à la main**

```bash
SCRATCH=/private/tmp/claude-501/-Users-guillaume-Developer-Swift-Valido/72e82e2e-7b82-4b1f-805f-470e4f7d2713/scratchpad
python3 Tools/audit.py > "$SCRATCH/formes-mesure.txt" 2>&1
grep -E '^### ' "$SCRATCH/formes-mesure.txt"
grep -A200 '^### forme/hors-situation' "$SCRATCH/formes-mesure.txt" | head -60
```

Relever les trois effectifs. Puis **lire** les cartes signalées et compter combien sont des faux positifs. Les faux positifs se documentent, ils ne se corrigent pas en tordant la regex indéfiniment — le dépôt vit déjà avec `lettre/reference` à 1 et `forme/markdown` à 1, tous deux connus et déclarés. Fixer un seuil : au-delà d'un tiers de faux positifs sur un compteur, le motif est mauvais et se resserre ; en dessous, il se déclare tel quel.

- [ ] **Step 7: Publier la ligne de base dans le rapport et dans `CLAUDE.md`**

Ajouter à `Tools/audit-2026-09-formes.md` :

```markdown
## 3. Les compteurs de forme

Trois compteurs, **informatifs**. Ils mesurent un écart avec l'épreuve, pas un défaut : un
énoncé impersonnel peut être la forme juste sur une carte de signalisation. Les faire
baisser pour eux-mêmes viderait les cartes, ce que la passe 3 a appris à ses dépens sur
`expl/paraphrase-litterale`.

| compteur | effectif sur 255 | faux positifs relevés | ce qu'il mesure vraiment |
|---|---|---|---|
| `forme/impersonnel` | … | … | … |
| `forme/hors-situation` | … | … | … |
| `forme/definitionnel` | … | … | … |

Reproduire : `python3 Tools/audit.py | grep -E '^### forme/'`.
```

Et dans `CLAUDE.md`, à la suite du paragraphe de ligne de base, ajouter :

```markdown
Trois compteurs de forme sont nés le 2026-09-06 avec le diagnostic
[`Tools/audit-2026-09-formes.md`](Tools/audit-2026-09-formes.md) :
`forme/impersonnel`, `forme/hors-situation` et `forme/definitionnel`. Ils sont
**informatifs**, comme `longueur/plus-longue`, et ne rejoignent pas les compteurs devant
rester vides : ils mesurent l'écart de forme avec l'épreuve réelle, pas un défaut. Les
faire baisser pour eux-mêmes est un contresens — sur une carte de signalisation, un énoncé
impersonnel est souvent la forme juste. Leurs valeurs de départ sont dans le §3 du rapport.
```

- [ ] **Step 8: Vérifier que la ligne de base historique n'a pas bougé**

```bash
python3 Tools/audit.py | grep -E '^### '
```

Attendu : les cinq compteurs historiques à leurs valeurs exactes — `lettre/reference (1)`, `forme/markdown (1)`, `forme/seule-ponctuee (14)`, `longueur/plus-longue (76)`, `expl/paraphrase-litterale (20)` — **plus** les trois nouveaux. Aucun `schema/`, `couverture/`, `source/`, `fuite/`, `image/`.

- [ ] **Step 9: Lancer la suite de tests**

```bash
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' 2>&1 \
  | grep -E "Test run with|✘|error:"
```

Attendu : `✔ Test run with 64 tests`.

- [ ] **Step 10: Commit**

```bash
git add Tools/audit.py CLAUDE.md Tools/audit-2026-09-formes.md
git commit -m "$(cat <<'EOF'
Measure form against the real exam with three informative counters

forme/impersonnel, forme/hors-situation and forme/definitionnel run on the 255
`code` cards. They are declared informative in CLAUDE.md at the moment they are
created, not afterwards: they measure a gap with the exam, not a defect, and an
impersonal prompt is often the right form on a signage card. Driving them down for
their own sake would empty the cards -- which is what passe 3 learned the hard way
on expl/paraphrase-litterale.

Verified on a two-card fixture before being trusted on 255: a situated prompt
raises none of the three, an impersonal definitional one raises all three. False
positives are counted and declared rather than chased with an ever-tighter regex.

Historical baseline unchanged: 1 / 1 / 14 / 76 / 20, the seven hard categories
empty. 64 tests pass.

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

### Task 5: `couverture/poids` — conditionnel

Ce compteur mesure l'écart entre la distribution des 255 par thème et celle du corpus. **Il n'existe que si la tâche 2 a permis d'établir cette distribution de référence.** Si le corpus ne la donne pas, cette tâche se solde par un paragraphe qui dit pourquoi, et le compteur n'est pas écrit.

**Files:**
- Modify: `Tools/couverture.md` (la table de référence)
- Modify: `Tools/audit.py`
- Modify: `Tools/audit-2026-09-formes.md` (section 4)

**Interfaces:**
- Consomme : la strate qui a fourni les fréquences (tâche 2), et `TOPICS_DECLARES` déjà lu par `audit.py` depuis `couverture.md`.
- Produit : `couverture/poids`, ou son absence motivée.

- [ ] **Step 1: Décider si la référence existe**

Relire la section corpus. La distribution par thème est-elle établie sur une strate nommée, avec une source et une date ?

**Si non :** écrire dans `Tools/audit-2026-09-formes.md` une section « 4. Le poids par thème, non mesuré » disant quelle strate manquait et ce qu'il faudrait pour l'établir, puis passer directement au step 6. Un compteur qui mesurerait contre une distribution inventée serait pire que pas de compteur.

**Si oui :** continuer.

- [ ] **Step 2: Inscrire la distribution de référence dans `couverture.md`**

Ajouter à `Tools/couverture.md`, après la note méthodologique :

```markdown
## Distribution de référence

Part de chaque thématique dans le corpus de l'épreuve, relevée le [date] sur [strate et
source]. `audit.py` compare la répartition des 255 cartes `code` à cette colonne et lève
`couverture/poids` au-delà de l'écart déclaré ci-dessous.

| thématique ETG | part de référence | source |
|---|---|---|
| … | … % | … |

Écart toléré : [n] points. Ce seuil est un choix, pas une mesure — il est écrit ici pour
qu'on puisse le contester.
```

- [ ] **Step 3: Écrire le compteur**

Dans `Tools/audit.py`, après la boucle du registre de fraîcheur et avant la ligne `orphelines = ...` :

```python
# --- poids par thème ---
# Comparé à la distribution de référence de couverture.md. Informatif : un écart n'est pas
# une faute, c'est un déséquilibre à arbitrer — une banque peut choisir d'insister.
POIDS_REF = {m[0]: float(m[1].replace(',', '.'))
             for m in re.findall(r'^\|\s*([^|]+?)\s*\|\s*([\d,.]+)\s*%\s*\|',
                                 open(COUVERTURE_MD).read(), re.M)}
ECART_TOLERE = 5.0
if POIDS_REF:
    codes = [q for q in QS if q['subject'] == 'code']
    obs = collections.Counter(q['topic'] for q in codes)
    for topic, part_ref in POIDS_REF.items():
        part_obs = 100.0 * obs.get(topic, 0) / len(codes)
        if abs(part_obs - part_ref) > ECART_TOLERE:
            findings['couverture/poids'].append(
                ('code', topic, '0' * 32, topic, f'{part_obs:.1f} % contre {part_ref:.1f} % de référence'))
```

`couverture/` figure déjà dans `order`. Attention : `couverture/` est aujourd'hui dans les catégories devant rester **vides**. Ce nouveau compteur y ajoute une entrée informative — le step 5 le déclare explicitement dans `CLAUDE.md`, sans quoi la prochaine passe le lira comme une régression.

- [ ] **Step 4: Vérifier**

```bash
python3 Tools/audit.py | grep -E '^### couverture/'
python3 Tools/audit.py | grep -E '^### ' | wc -l
```

Relire chaque écart signalé : est-ce un déséquilibre réel de la banque, ou une différence de découpage entre les thèmes officiels et les `topic` de `questions.json` ? Le second cas n'est pas un défaut de contenu et doit être écrit comme tel.

- [ ] **Step 5: Déclarer le compteur dans `CLAUDE.md`**

```markdown
`couverture/poids` fait exception à « `couverture/` doit rester vide » : c'est un compteur
**informatif** né le 2026-09-06, qui compare la répartition des 255 cartes `code` à la
distribution de référence inscrite dans `couverture.md`. Un écart est un déséquilibre à
arbitrer, pas une faute. `couverture/topic-non-rattache`, lui, doit toujours rester vide.
```

- [ ] **Step 6: Commit**

```bash
git add Tools/audit.py Tools/couverture.md CLAUDE.md Tools/audit-2026-09-formes.md
git commit -m "$(cat <<'EOF'
Weigh the bank against the exam's theme distribution, or say why not

couverture/poids compares the 255 `code` cards to the reference distribution now
recorded in couverture.md, with the tolerated gap written down as the arbitrary
choice it is. It is the one informative entry under a prefix that must otherwise
stay empty, and CLAUDE.md says so -- without that line the next pass reads it as a
regression.

If the corpus could not establish a reference distribution, no counter is written:
measuring against an invented distribution is worse than not measuring. The report
says which stratum was missing and what would establish it.

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

## Procédure de lecture d'un domaine (tâches 6 à 18)

Les treize tâches qui suivent appliquent la même procédure, avec un domaine et un effectif différents. La procédure est écrite ici une fois, en toutes lettres ; chaque tâche porte ses paramètres concrets et les cite.

**P1 — Sortir les cartes du domaine.**

```bash
SCRATCH=/private/tmp/claude-501/-Users-guillaume-Developer-Swift-Valido/72e82e2e-7b82-4b1f-805f-470e4f7d2713/scratchpad
python3 Tools/relire.py "<DOMAINE>" > "$SCRATCH/formes-<slug>.txt"
wc -l "$SCRATCH/formes-<slug>.txt"
```

`relire.py` met chaque carte en face de sa ligne de `sources.md`. C'est la seule vue qui montre l'énoncé, les quatre options et l'explication ensemble — `audit.py` ne les affiche jamais côte à côte.

**P2 — Croiser avec les compteurs mécaniques.**

```bash
python3 Tools/audit.py | grep -E '^  \[code/<DOMAINE>\]' | grep -E 'forme/' || true
```

**P3 — Lire chaque carte et lui donner un verdict** sur les axes non mécanisables retenus par la tâche 3. Chaque verdict porte **son motif en une ligne**, pour être contestable carte par carte plutôt que sur un total.

**P4 — Écrire la section de domaine** dans `Tools/audit-2026-09-formes.md` :

```markdown
### <DOMAINE> (<N> cartes)

| id | ancrage | objet | piège | se poserait à l'examen ? | motif |
|---|---|---|---|---|---|
| `xxxxxxxx` | … | … | … | oui / non / partiel | … |

**Ce que la lecture a vu et que les compteurs n'ont pas vu :** …
**Ce que les compteurs ont signalé à tort :** …
```

**P5 — Vérifier que l'effectif du tableau vaut celui du domaine**, et que la ligne de base n'a pas bougé :

```bash
python3 Tools/audit.py | grep -E '^### '
```

**P6 — Commit**, message en anglais, sur le modèle :

```bash
git add Tools/audit-2026-09-formes.md
git commit -m "Read <DOMAIN> against the form grid: <N> cards, <K> would not be asked

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>"
```

---

### Tasks 6 à 18: Les treize domaines

Une tâche par ligne, dans cet ordre — du plus fourni au moins fourni, pour que la procédure se cale sur un gros domaine d'abord.

**Files (identiques pour les treize) :**
- Modify: `Tools/audit-2026-09-formes.md`
- Read: `Valido/Resources/questions.json`, `Tools/sources.md`

**Interfaces:**
- Consomme : la grille de la tâche 3, les compteurs de la tâche 4.
- Produit : une section de domaine par tâche. Les treize effectifs doivent sommer à 255, ce que la tâche 19 vérifie.

- [ ] **Task 6 — `Panneaux & marquage`, 27 cartes.** Appliquer P1 à P6. Domaine le plus fourni et le plus illustré : `forme/hors-situation` devrait y être bas, l'illustration situant déjà la question. Si ce n'est pas le cas, c'est un résultat à écrire.
- [ ] **Task 7 — `Priorités & intersections`, 26 cartes.** Appliquer P1 à P6. C'est le domaine où « qui passe en premier ? » n'a de sens que situé : l'écart d'ancrage y sera le plus lisible.
- [ ] **Task 8 — `Vitesse`, 22 cartes.** Appliquer P1 à P6. Domaine à chiffres : `forme/definitionnel` y sera probablement haut, et c'est peut-être légitime — le noter plutôt que le compter comme défaut.
- [ ] **Task 9 — `Distances & freinage`, 21 cartes.** Appliquer P1 à P6.
- [ ] **Task 10 — `Mécanique & environnement`, 20 cartes.** Appliquer P1 à P6. Le domaine où un énoncé impersonnel est le plus plausiblement la forme juste.
- [ ] **Task 11 — `Feux`, 19 cartes.** Appliquer P1 à P6.
- [ ] **Task 12 — `Permis & sanctions`, 19 cartes.** Appliquer P1 à P6. Domaine de barèmes : même remarque qu'en `Vitesse`.
- [ ] **Task 13 — `Premiers secours`, 18 cartes.** Appliquer P1 à P6. Seul domaine dont les sources ne sont pas juridiques (ERC, INRS, Croix-Rouge) : vérifier si la forme des questions ETG y diffère aussi.
- [ ] **Task 14 — `Alcool & stupéfiants`, 18 cartes.** Appliquer P1 à P6.
- [ ] **Task 15 — `Usagers & partage de la route`, 18 cartes.** Appliquer P1 à P6.
- [ ] **Task 16 — `Arrêt & stationnement`, 17 cartes.** Appliquer P1 à P6.
- [ ] **Task 17 — `Croisement & dépassement`, 15 cartes.** Appliquer P1 à P6.
- [ ] **Task 18 — `Tunnels & passages à niveau`, 15 cartes.** Appliquer P1 à P6.

---

### Task 19: Synthèse, recommandation, et vérification des critères

**Files:**
- Modify: `Tools/audit-2026-09-formes.md` (sections finales)
- Modify: `CLAUDE.md` (renvoi vers le rapport)
- Modify: `README.md` (la liste des rapports de contenu)

**Interfaces:**
- Consomme : tout ce qui précède.
- Produit : le rapport achevé et la recommandation chiffrée qui devient l'entrée de la décision de réécriture.

- [ ] **Step 1: Vérifier que les treize effectifs somment à 255**

```bash
python3 - <<'EOF'
import re
t = open('Tools/audit-2026-09-formes.md').read()
n = [int(x) for x in re.findall(r'^### .+ \((\d+) cartes\)', t, re.M)]
print(len(n), 'domaines,', sum(n), 'cartes')
EOF
```

Attendu : `255`. Si le total diffère, une carte a été oubliée ou comptée deux fois — la retrouver avant d'écrire la synthèse.

- [ ] **Step 2: Écrire « Ce que l'outillage ne voit pas »**

Ajouter au rapport la section qui a le plus servi aux passes précédentes : ce que la lecture a vu et qu'aucun compteur n'a attrapé, ce que les compteurs ont signalé à tort, et ce qui ne peut structurellement pas avoir de ligne d'outil.

```markdown
## Ce que l'outillage ne voit pas

| n° | l'angle mort | ligne d'outil, si elle existe |
|---|---|---|
| 1 | … | `audit.py:NNN` ou « aucune, et il ne peut pas y en avoir » |
```

- [ ] **Step 3: Écrire la recommandation chiffrée**

```markdown
## Recommandation

Sur les 255 cartes lues, **N** s'écartent de la forme de l'épreuve sur au moins un axe, dont
**M** sur l'ancrage, **P** sur l'objet et **Q** sur le piège.

Par ordre de rendement décroissant :

1. **[l'axe]** — N cartes, [ce que coûte la réécriture, ce qu'elle rapporte].
2. …

**Ce qu'il ne faut pas faire :** [les compteurs à ne pas minimiser, et pourquoi].

Coût estimé de chaque lot, et ce qui reste inconnu : …
```

Si la mesure a cassé l'hypothèse de départ — si les cartes sont déjà proches de la forme de l'épreuve — **l'écrire franchement** et recommander de ne rien réécrire. C'est un résultat valide, et c'est la raison pour laquelle cette passe mesure avant de corriger.

- [ ] **Step 4: Renvoyer vers le rapport depuis `README.md` et `CLAUDE.md`**

Dans `README.md`, la liste des rapports se termine aujourd'hui par le renvoi vers les passes 2 et 3. Ajouter :

```markdown
- [`Tools/audit-2026-09-formes.md`](Tools/audit-2026-09-formes.md) — le diagnostic de
  forme : ce qui sépare une carte de Valido d'une question de l'épreuve réelle, chiffré
  carte par carte, et ce qu'il faudrait réécrire.
```

Dans `CLAUDE.md`, ajouter le rapport à côté des deux autres.

- [ ] **Step 5: Vérifier tous les critères d'acceptation de la spec**

```bash
# 1. les effectifs somment à 255 — fait au step 1
# 3. chaque chiffre est reproductible
grep -c 'python3 Tools/audit.py' Tools/audit-2026-09-formes.md
# 4. le flag de corroboration tombe sur la ligne d'essai, et est vide sur le réel
D=/private/tmp/claude-501/-Users-guillaume-Developer-Swift-Valido/72e82e2e-7b82-4b1f-805f-470e4f7d2713/scratchpad/corrobo
VALIDO_SOURCES_MD="$D/sources.md" python3 Tools/audit.py "$D/questions.json" | grep -c 'editeur-non-corrobore'
python3 Tools/audit.py | grep -c 'editeur-non-corrobore' || echo "0 sur le réel — attendu"
# 5. la ligne de base historique
python3 Tools/audit.py | grep -E '^### '
# 7. le rapport nomme ce qu'il n'a pas pu lire
grep -n 'refusé\|non lu\|inaccessible' Tools/audit-2026-09-formes.md
```

Le critère 2 (chaque axe adossé à une observation) et le critère 6 (les tests) se vérifient l'un à la relecture de la section 2, l'autre par la commande ci-dessous.

- [ ] **Step 6: Lancer la suite de tests une dernière fois**

```bash
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' 2>&1 \
  | grep -E "Test run with|✘|error:"
```

Attendu : `✔ Test run with 64 tests`.

- [ ] **Step 7: Vérifier qu'aucune carte n'a bougé**

```bash
git diff --stat $(git log --format=%H -1 --grep='Split the whitelist')^ -- Valido/Resources/questions.json
```

Attendu : **aucune sortie**. C'est la contrainte globale la plus importante de cette passe : si `questions.json` a bougé, quelque chose a dérivé du diagnostic vers la correction.

- [ ] **Step 8: Commit**

```bash
git add Tools/audit-2026-09-formes.md README.md CLAUDE.md
git commit -m "$(cat <<'EOF'
Close the form diagnostic with a costed recommendation

The thirteen domain tables sum to 255: no card left unexamined. The report ends
where the next decision starts -- how many cards drift from the exam's form, on
which axis, and in what order rewriting them would pay.

"What the tooling does not see" carries the part that has served every previous
pass best: what the reading caught and no counter did, what the counters flagged
wrongly, and which blind spots cannot have a tool line at all.

questions.json is byte-identical to its state before this pass. Verified, not
assumed: the diff against the pass's first commit is empty.

Baseline unchanged: 1 / 1 / 14 / 76 / 20. 64 tests pass.

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>
EOF
)"
```
