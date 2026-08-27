# Relecture des 255 questions `code` — plan d'implémentation

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Relire chacune des 255 questions `code` contre la ligne de registre qui dit contre quoi elle a été vérifiée, corriger les trois écarts de justesse — valeur périmée, règle énoncée trop largement, explication qui dépasse l'article — et réécrire énoncés, options et explications pour quelqu'un qui découvre la règle, sans relâcher un seul seuil.

**Architecture :** Treize tâches de contenu, une par domaine `code`, traitées de bout en bout : lire le registre, corriger la justesse, réécrire pour enseigner, reporter dans `sources.md`, prouver par `audit.py` et les tests que seuls les mouvements attendus ont eu lieu. Un outil de lecture (`Tools/relire.py`) ouvre le plan, parce qu'aucun outil existant ne met la carte en face de sa ligne de registre et qu'une tâche exécutée par un sous-agent frais ne peut hériter d'aucun script de session. Trois tâches de clôture recomptent la couverture, consolident le rapport de passe et referment la branche.

**Tech Stack :** `Valido/Resources/questions.json` édité à la main (JSON, `indent=2`, `sort_keys=True`, `ensure_ascii=False`) ; `python3 Tools/audit.py` pour la forme, la fraîcheur et la couverture ; Swift Testing via `xcodebuild` sur simulateur iOS 26.2 pour le verrou sur le livré ; registres markdown `Tools/sources.md`, `Tools/couverture.md`, `Tools/images.md`. Python 3.9 système (`/usr/bin/python3`) — pas de dépendance tierce, `audit.py` n'en a aucune.

**Spec :** [`docs/superpowers/specs/2026-08-27-relecture-code-pedagogie-design.md`](../specs/2026-08-27-relecture-code-pedagogie-design.md) — à lire avant la première tâche : elle porte les deux arbitrages (budget des illustrées tenu, source rouverte sur déclenchement seulement) dont ce plan n'est que l'exécution.

## Global Constraints

Valables pour **chaque** tâche ; non répétées dans les tâches.

- **Langue.** Contenu, commentaires et noms de tests en **français**. Messages de commit en **anglais**.
- **Les `id` sont immuables.** Aucun `id` réécrit, ajouté ni supprimé : la progression de l'utilisateur est indexée dessus. Réécrire un `prompt` désynchronise l'`id` de `sha256("valido-v2:" + prompt)[:32]` — c'est **normal et voulu**, 260 des 448 questions sont déjà dans ce cas, l'immuabilité primant sur le hachage.
- **Aucune référence de lettre**, ni dans une option ni dans une explication (`A —`, `réponse B`, `… C :`). Les options sont mélangées à chaque affichage : une lettre désigne une position qui n'existe plus.
- **Volume constant.** 255 `code`, 49 illustrées, 448 au total. Cette passe réécrit ; elle n'ajoute ni ne retire de question.
- **Aucun seuil relâché.** Ni `Tools/audit.py` ni `ValidoTests/BundledContentTests.swift` ne sont modifiés par une tâche de contenu. Un échec s'y corrige **dans les données**.
- **Budget des cartes illustrées** : énoncé ≤ 70 caractères, chaque option ≤ 50, explication ≤ 220. Sur ces 49 cartes on enseigne **en coupant**, jamais en allongeant.
- **Équilibre de longueur** : la bonne option ne dépasse pas de plus de **10** caractères la deuxième plus longue, ni de plus de **20** la *moyenne* des trois distracteurs.
- **Pas de méta-option** (« toutes les », « aucune », « ci-dessus »), pas de résidu markdown (`**`, `](`), exactement 4 options d'`id` `A`–`D`, textes distincts deux à deux.
- **Un doute se signale, il ne se corrige pas.** Un chiffre incertain dans la banque est moins grave qu'un chiffre faux présenté comme sûr. Le doute va au rapport de passe, avec ce qui a été lu et ce qui manque.
- **Le simulateur se démarre à la main** avant le premier `xcodebuild` : `DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl boot 'iPhone 17 Pro'`.
- **`-only-testing` sans les parenthèses exécute 0 test et affiche quand même `** TEST SUCCEEDED **`.** La ligne `✔ Test run with N test(s)` est la seule preuve qu'un test a tourné.
- **`audit.py` sort toujours 0.** C'est le rapport qu'on lit, jamais le code de retour.
- **`.passe3/`** est le dossier de travail de la passe : relevés d'avant/après, notes d'écarts. Ignoré par git (tâche 1), jamais commité.

### La ligne de base d'`audit.py` (2026-08-27, 448 questions)

On se compare à elle, **pas à zéro** :

```
lettre/reference            1     faux positif connu (lettre ancrée par l'énoncé)
forme/markdown              1     faux positif connu (`/** */` dans un code span)
forme/seule-ponctuee       14     informatif, jamais cumulé avec la longueur
longueur/plus-longue       97     informatif (+1 à +10)
expl/paraphrase-litterale  18     dont 10 `code` — doit BAISSER
```

Doivent rester **vides** : `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10`, `forme/backtick-isole`.

Deux mouvements sont **attendus** : `expl/paraphrase-litterale` baisse (c'est un défaut pédagogique, pas une tolérance) et `longueur/plus-longue` bouge dans les deux sens puisque les options sont réécrites. **Un seul mouvement est interdit : une sortie qui passe de vide à non vide.**

### Les trois écarts de justesse à chercher

| Écart | Signature | Correction |
|---|---|---|
| **Valeur périmée** | un chiffre de la carte absent de la colonne `affirmation`, ou différent d'elle | mettre la valeur de l'article ; **l'ancienne valeur devient un distracteur** — c'est exactement ce qu'un candidat aura lu ailleurs |
| **Règle trop large** | un absolu dans la carte (« toujours », « dans tous les cas », « obligatoire ») que l'affirmation ne porte pas | rétablir la condition que l'article pose |
| **Explication au-delà de l'article** | une conséquence, une sanction, une exception absente de l'affirmation | couper la clause, **ou** étendre l'affirmation en la sourçant |

« Règle trop large » est le défaut le plus probable et le seul totalement invisible d'`audit.py` : la carte est bien formée, sa ligne existe, sa source est recevable, et elle dit quand même plus que l'article. Forme typique, documentée dans `sources.md` : le trottoir est « très gênant » pour une voiture (R417-11 I 8° a) mais seulement « gênant » pour un cyclomoteur (R417-10 II 1°) — deux articles voisins, quatre régimes, et une carte qui en énonce un pour tous.

### Les quatre critères pédagogiques

1. **L'énoncé se comprend sans connaître la réponse.** Tous ses termes sont introduits. Un énoncé répondable seulement par qui sait déjà n'est pas une question, c'est un rappel.
2. **Chaque option nomme une règle réelle**, sans jargon non introduit. Les trois distracteurs sont les trois confusions qu'un débutant fait vraiment — jamais des variantes inventées d'un chiffre.
3. **L'explication tient trois temps : la règle, sa raison, sa limite.** La raison la rend mémorisable ; la limite — la condition qui la fait cesser — empêche de la sur-appliquer, et c'est le garde-fou contre « règle trop large ».
4. **L'explication n'est jamais la bonne option reformulée.** C'est le critère qu'`audit.py` mesure sous `expl/paraphrase-litterale`.

Sur une carte illustrée, les trois temps du critère 3 doivent tenir en 220 caractères. C'est possible parce que couper la reformulation de la réponse — ce que le critère 4 exige de toute façon — libère précisément la place qui manque. Les deux contraintes tirent dans le même sens.

### L'angle mort à surveiller à chaque tâche

Le §7 n° 2 de [`Tools/audit-2026-08-passe-2.md`](../../../Tools/audit-2026-08-passe-2.md) recense la **fuite d'une carte vers une autre carte** : une explication qui énumère la bonne réponse d'une question voisine. La passe 2 en a introduit une (`5c11020d` donnait la réponse de `bda52045`). Une passe qui étoffe 255 explications est exactement celle qui en introduit : chaque tâche a une étape dédiée, `python3 Tools/relire.py --fuites "<domaine>"`.

### Ce qui bouge en même temps que les questions

- **`Tools/sources.md`** — dès que ce qui est affirmé change : colonne `affirmation` réécrite, `relevé le` porté à la date de la lecture. Un changement de `nature` (`stable` ↔ `datée`) se justifie dans la colonne. **Les lignes inchangées ne se touchent pas** : leur date atteste une lecture réelle.
- **`Tools/couverture.md`** — volumes recomptés **une seule fois**, en clôture (tâche 15).
- **`Tools/audit-2026-08-passe-3.md`** — le rapport de passe, une section par domaine, écrite **dans la tâche du domaine** ; consolidé en tâche 16.

---

### Tâche 1 : `Tools/relire.py` — mettre la carte en face de sa ligne de registre

**Files:**
- Create: `Tools/relire.py`
- Modify: `.gitignore` (ajouter `.passe3/`)
- Modify: `Tools/questions.md` (§3, mention de l'outil de lecture)

**Interfaces:**
- Consumes: rien. Première tâche.
- Produces: deux commandes dont **chacune des treize tâches de domaine dépend** —
  - `python3 Tools/relire.py "<domaine>"` → pour chaque carte du domaine : sa ligne de registre (`nature`, `affirmation`, `source`, `relevé le`), puis son énoncé, son `alt` s'il y en a, ses quatre options avec leur longueur et la bonne marquée `✓`, et son explication avec sa longueur. Les illustrées sont affichées **en premier**, ce sont elles que le budget contraint.
  - `python3 Tools/relire.py --fuites "<domaine>"` → pour chaque carte du domaine, les **autres** cartes `code` de la banque dont la bonne option est entièrement recouverte par son explication.
  - Les deux sont en **lecture seule** et sortent toujours 0.

**Pourquoi cet outil, alors que la spec ne demande pas d'outillage.** `audit.py` vérifie qu'une ligne de registre **existe** ; il ne l'affiche jamais à côté de la carte. La procédure de la spec — « lire la ligne de `sources.md` avant la carte » — demande de rapprocher deux fichiers de 425 Ko et 163 Ko, 255 fois : à la main, c'est la manière la plus sûre de relire la mauvaise ligne. Et une tâche exécutée par un sous-agent frais ne peut pas hériter d'un script de session, donc l'outil doit être dans le dépôt.

**Le seuil du mode `--fuites` a été calibré en écrivant ce plan**, sur la banque du 2026-08-27 : en sous-chaîne le test remonte **235** recouvrements (dominés par « 3 », « 50 km/h »), à deux mots pleins **49**, à trois mots pleins **19**. Trois est le seuil retenu — c'est le premier qui donne une liste relisible à la main.

- [ ] **Step 1: Écrire l'outil**

Créer `Tools/relire.py` avec exactement ce contenu :

```python
#!/usr/bin/env python3
"""Lecture seule : met chaque carte `code` d'un domaine en face de sa ligne de registre.

`audit.py` vérifie qu'une ligne de `sources.md` existe pour une question ; il ne
l'affiche jamais avec la carte. La relecture de justesse a besoin des deux côte à côte —
l'affirmation est la référence, la carte est ce qu'on vérifie contre elle.

    python3 Tools/relire.py "Vitesse"
    python3 Tools/relire.py --fuites "Vitesse"

N'écrit aucun fichier. Sort toujours 0 : c'est un rapport, pas une porte.
"""
import json
import re
import sys
import unicodedata
from pathlib import Path

RACINE = Path(__file__).resolve().parent.parent
BANQUE = RACINE / 'Valido' / 'Resources' / 'questions.json'
REGISTRE = RACINE / 'Tools' / 'sources.md'

LIGNE = re.compile(
    r'^\| `([0-9a-f]{32})` \| (stable|datée) \|(.*?)\|(.*?)\|(.*?)\|\s*$', re.M)


def charger():
    questions = json.loads(BANQUE.read_text(encoding='utf-8'))
    registre = {m[0]: {'nature': m[1], 'affirmation': m[2].strip(),
                       'source': m[3].strip(), 'releve': m[4].strip()}
                for m in LIGNE.findall(REGISTRE.read_text(encoding='utf-8'))}
    return questions, registre


def cartes(questions, domaine):
    """Les illustrées d'abord : ce sont elles que le budget de 220 contraint."""
    lot = [q for q in questions if q['subject'] == 'code' and q['topic'] == domaine]
    return sorted(lot, key=lambda q: (not q.get('illustration'), q['id']))


def bonne(q):
    return next(o['text'] for o in q['options'] if o['id'] == q['correctID'])


def afficher(questions, registre, domaine):
    lot = cartes(questions, domaine)
    if not lot:
        topics = sorted({q['topic'] for q in questions if q['subject'] == 'code'})
        print(f'Aucune carte `code` dans « {domaine} ». Domaines connus :')
        for t in topics:
            print('  -', t)
        return
    print(f'# {domaine} — {len(lot)} cartes '
          f"({sum(1 for q in lot if q.get('illustration'))} illustrées)")
    for q in lot:
        r = registre.get(q['id'])
        print('\n' + '=' * 96)
        if r is None:
            print(f"!! {q['id']} — AUCUNE ligne dans sources.md (audit.py doit le "
                  f"signaler en source/absente)")
        else:
            print(f"{q['id']}  {r['nature']}  relevé {r['releve'] or '—'}")
            print(f"  source      : {r['source'] or '—'}")
            print(f"  AFFIRMATION : {r['affirmation']}")
        image = q.get('illustration')
        budget = ' [budget illustrée : 70 / 50 / 220]' if image else ''
        print(f"  difficulté  : {q['difficulty']}{budget}")
        print(f"  ÉNONCÉ ({len(q['prompt'])}) : {q['prompt']}")
        if image:
            print(f"  asset       : {image['asset']}")
            print(f"  ALT ({len(image['alt'])})    : {image['alt']}")
        for o in q['options']:
            marque = '✓' if o['id'] == q['correctID'] else ' '
            print(f"  {marque} {o['id']} ({len(o['text']):3d}) {o['text']}")
        print(f"  EXPL ({len(q['explanation'])})   : {q['explanation']}")


def mots(texte, seuil=5):
    """Mots pleins normalisés — sans accent, sans casse, au-dessus du seuil."""
    plat = unicodedata.normalize('NFD', texte.lower())
    plat = ''.join(c for c in plat if unicodedata.category(c) != 'Mn')
    return {m for m in re.findall(r"[a-z0-9]+", plat) if len(m) >= seuil}


def fuites(questions, domaine):
    """Une explication qui contient la bonne réponse d'une AUTRE carte.

    Angle mort n° 2 du §7 de la passe 2 : aucun contrôle d'`audit.py` ne regarde une
    carte à la lumière d'une autre, et la passe 2 a elle-même introduit une fuite de
    cette forme en étoffant une explication.
    """
    banque = [q for q in questions if q['subject'] == 'code']
    lot = cartes(questions, domaine)
    trouve = 0
    for q in lot:
        cible = mots(q['explanation'])
        for autre in banque:
            if autre['id'] == q['id']:
                continue
            reponse = mots(bonne(autre))
            # Trois mots pleins au minimum : sous ce seuil le recouvrement est du
            # vocabulaire commun (« 50 km/h », « 3 points ») et noie le signal — mesuré
            # à 235 faux positifs en sous-chaîne, 49 à deux mots, 19 à trois.
            if len(reponse) >= 3 and reponse <= cible:
                trouve += 1
                print(f"{q['id'][:12]} (expl) recouvre la bonne réponse de "
                      f"{autre['id'][:12]} [{autre['topic']}]")
                print(f"    expl    : {q['explanation']}")
                print(f"    réponse : {bonne(autre)}")
    print(f'\n{trouve} recouvrement(s) sur {len(lot)} cartes de « {domaine} ».')
    if trouve:
        print("Chacun se relit à la main : un mot commun est normal, la réponse "
              "entière ne l'est pas.")


def main():
    args = list(sys.argv[1:])
    mode_fuites = '--fuites' in args
    args = [a for a in args if a != '--fuites']
    if len(args) != 1:
        print(__doc__)
        return
    questions, registre = charger()
    if mode_fuites:
        fuites(questions, args[0])
    else:
        afficher(questions, registre, args[0])


if __name__ == '__main__':
    main()
```

- [ ] **Step 2: Vérifier qu'il lit les 255 cartes et retrouve les 255 lignes**

Run :

```bash
python3 - <<'EOF'
import subprocess, json
qs = json.load(open('Valido/Resources/questions.json'))
topics = sorted({q['topic'] for q in qs if q['subject'] == 'code'})
total = 0
for t in topics:
    out = subprocess.run(['python3', 'Tools/relire.py', t],
                         capture_output=True, text=True).stdout
    n = out.count('=' * 96)
    total += n
    print(f'{t:32s} {n:3d} cartes, {out.count("AUCUNE ligne")} sans ligne de registre')
print('total', total)
EOF
```

Expected : les treize domaines, **total 255**, et **0 sans ligne de registre** partout — cohérent avec `source/absente` vide dans la ligne de base. Volumes attendus, domaine par domaine : Alcool & stupéfiants 18, Arrêt & stationnement 17, Croisement & dépassement 15, Distances & freinage 21, Feux 19, Mécanique & environnement 20, Panneaux & marquage 27, Permis & sanctions 19, Premiers secours 18, Priorités & intersections 26, Tunnels & passages à niveau 15, Usagers & partage de la route 18, Vitesse 22.

- [ ] **Step 3: Vérifier le mode `--fuites` sur un domaine dense**

Run :

```bash
python3 Tools/relire.py --fuites "Vitesse" | tail -6
python3 Tools/relire.py --fuites "Alcool & stupéfiants" | tail -2
```

Expected : `4 recouvrement(s) sur 22 cartes de « Vitesse »` et `0 recouvrement(s) sur 18 cartes de « Alcool & stupéfiants »`, sans traceback. Ces quatre-là sont l'état **d'avant** la passe, pas des régressions : ils se relisent dans la tâche 3, qui possède le domaine.

- [ ] **Step 4: Vérifier que l'outil n'écrit rien**

Run :

```bash
git status --porcelain
```

Expected : aucune ligne `M` sur `Valido/Resources/questions.json` ni sur `Tools/sources.md`. L'outil est en lecture seule et cette étape le prouve avant que treize tâches ne s'appuient dessus.

- [ ] **Step 5: Ignorer le dossier de travail de la passe**

Ajouter à la fin de `.gitignore` :

```
# Relevés d'avant/après de la passe de relecture `code` (2026-08). Des rapports de
# travail, pas des livrables : ce qui doit survivre va dans Tools/audit-2026-08-passe-3.md.
.passe3/
```

- [ ] **Step 6: Signaler l'outil dans `Tools/questions.md`**

Dans le §3 (« Contrôles avant écriture »), juste après le bloc `python3 Tools/audit.py`, insérer :

```markdown
Pour **lire** une carte à côté de la ligne de `sources.md` qui la couvre — ce qu'`audit.py`
ne fait pas, il vérifie seulement que la ligne existe :

    python3 Tools/relire.py "Vitesse"            # les cartes du domaine + leur ligne de registre
    python3 Tools/relire.py --fuites "Vitesse"   # explications qui recouvrent la réponse d'une autre carte

Lecture seule, sort toujours 0. Le second mode couvre l'angle mort n° 2 du §7 de
[`audit-2026-08-passe-2.md`](audit-2026-08-passe-2.md) — la fuite d'une carte vers une
autre — au seuil de trois mots pleins : en dessous, le recouvrement est du vocabulaire
commun et noie le signal.
```

- [ ] **Step 7: Vérifier qu'`audit.py` est indifférent à l'ajout**

Run :

```bash
python3 Tools/audit.py | grep -E '^### '
```

Expected : exactement la ligne de base — `lettre/reference  (1)`, `forme/markdown  (1)`, `forme/seule-ponctuee  (14)`, `longueur/plus-longue  (97)`, `expl/paraphrase-litterale  (18)`, rien d'autre. Aucun contenu n'a été touché : toute différence ici est une alerte, pas un progrès.

- [ ] **Step 8: Commit**

```bash
git add Tools/relire.py Tools/questions.md .gitignore
git commit -m "$(cat <<'EOF'
Add a read-only reader that pairs a card with its registry line

audit.py checks that a `code` question has a line in sources.md; it
never shows that line next to the card. The pass ahead has to read the
recorded claim before the card, 255 times, across two files — by hand
that is the surest way to read the wrong line.

The --fuites mode covers blind spot 2 of the second pass: an
explanation that spells out another card's correct answer. No check
looked at one card in the light of another, and the pass that widened
explanations is the one that introduced such a leak. Three full words
is the threshold: substring matching reports 235 overlaps on today's
bank, two words 49, three words 19 — the first list short enough to
read.

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

### Tâche 2 : domaine « Permis & sanctions »

**Files:**
- Modify: `Valido/Resources/questions.json` — les 19 cartes `code` de `topic` « Permis & sanctions »
- Modify: `Tools/sources.md` — les lignes dont l'`affirmation` change
- Create/Modify: `Tools/audit-2026-08-passe-3.md` — la section du domaine

**Interfaces:**
- Consumes: `python3 Tools/relire.py "Permis & sanctions"` et `python3 Tools/relire.py --fuites "Permis & sanctions"` (tâche 1).
- Produces: une section `## Permis & sanctions` dans `Tools/audit-2026-08-passe-3.md`, au format fixé à l'étape 8, que la tâche 16 consolide sans le réécrire.

**Le lot.** 19 cartes : **19 `datée`**, 0 `stable`, **0 illustrée(s)**. Relevés du registre : 2026-08-24. **1** explication(s) sous 120 caractères ; **2** portant un absolu ou une obligation à confronter à l'affirmation.

| id (18 car., greppable) | nat. | énoncé | drapeaux |
|---|---|---|---|
| `0be9d147f1eba292ca` | D | Conduire après la notification d'une suspension du permis … | — |
| `2b6972fab03433e709` | D | Pour retrouver 12 points sans passer par un stage, il faut… | — |
| `2d45cedf9b3d349027` | D | Conduire sans avoir jamais obtenu le permis est : | — |
| `302262003495b5750d` | D | Un rodéo motorisé commis seul, sans autre infraction, est … | — |
| `37fe1af42b8d8132a2` | D | Tenir son téléphone en main au volant fait perdre : | — |
| `37fe1af42b8d8158b3` | D | Un stage de sensibilisation à la sécurité routière permet … | ABS obligatoire |
| `37fe1af42b8d8174b4` | D | Au début du permis probatoire, le capital de points est de… | — |
| `37fe1af42b8d81b6a9` | D | Sans aucune infraction, un permis probatoire en conduite a… | COURTE 64 |
| `37fe1af42b8d81b7ac` | D | Ne pas porter la ceinture de sécurité coûte : | — |
| `37fe1af42b8d81c593` | D | La période probatoire dure : | — |
| `37fe1af42b8d81d093` | D | Le disque « A » (jeune conducteur) doit être apposé : | — |
| `37fe1af42b8d81d29c` | D | Après une infraction ayant entraîné le retrait d'1 point, … | — |
| `37fe1af42b8d81ecb1` | D | Lorsque le solde de points atteint zéro, le permis est : | ABS dans tous les cas |
| `37fe1af42b8d81ed80` | D | Un permis classique compte au maximum : | — |
| `3e99bcc374a5538e9a` | D | L'homicide routier, retenu dès une seule circonstance comm… | — |
| `666bb472f111a4f463` | D | Plusieurs infractions commises en même temps entraînent au… | — |
| `aa44507977673661e7` | D | Le préfet dispose, pour transformer une rétention du permi… | — |
| `bc949f3e3918b2e407` | D | Un conducteur titulaire d'un permis délivré à l'étranger q… | — |
| `f405372595dbaf85bf` | D | La suspension du permis prononcée par le préfet ne peut en… | — |

`D` = `datée`, `s` = `stable`. `IMG` = illustrée, budget 70 / 50 / 220. `COURTE` = explication sous 120 caractères, candidate n° 1 du critère 3. `ABS` = absolu ou obligation dans l'explication, à confronter à l'affirmation (écart « règle trop large »). **Un drapeau est une piste, pas un verdict, et son absence n'est pas un quitus : les cartes sans drapeau se relisent aussi.**

- [ ] **Step 1: Relever l'état d'avant, pour pouvoir prouver le mouvement**

Run :

```bash
mkdir -p .passe3 && python3 Tools/audit.py > .passe3/avant-02.txt
grep -E '^### ' .passe3/avant-02.txt
python3 - <<'EOF'
import json, statistics
qs = json.load(open('Valido/Resources/questions.json'))
lot = [q for q in qs if q['subject'] == 'code' and q['topic'] == 'Permis & sanctions']
el = [len(q['explanation']) for q in lot]
print(len(lot), 'cartes | expl médiane', statistics.median(el),
      '| sous 120 :', sum(1 for x in el if x < 120),
      '| illustrées :', sum(1 for q in lot if q.get('illustration')))
EOF
```

Expected : la ligne de base des Global Constraints, puis `19 cartes … sous 120 : 1 … illustrées : 0`.

- [ ] **Step 2: Lire les 19 cartes à côté de leur ligne de registre**

Run :

```bash
python3 Tools/relire.py "Permis & sanctions" > .passe3/lot-02.txt
less .passe3/lot-02.txt
```

Lire **la ligne avant la carte**. L'`affirmation` est la référence ; la carte est ce qu'on vérifie contre elle. **Ne rien éditer à cette étape** : lire tout le domaine d'abord, pour que les cartes se corrigent les unes par les autres — deux cartes voisines qui se contredisent (cas n° 8 du §9.5 de la passe 2, « deux verres » contre « deux ou trois verres ») ne se voient qu'en lisant le lot entier.

- [ ] **Step 3: Marquer les trois écarts de justesse**

Pour chaque carte, dans l'ordre du tableau des Global Constraints : **valeur périmée**, puis **règle trop large**, puis **explication au-delà de l'article**. Consigner dans `.passe3/ecarts-02.md` une ligne par écart — `id`, écart, ce que dit la carte, ce que dit l'affirmation, correction envisagée.

**Rouvrir une source dans un seul cas** : la carte affirme quelque chose que l'affirmation ne couvre pas **et** qui n'est pas manifestement faux. Lire alors l'**article consolidé** (Legifrance, ligne « Version en vigueur depuis le … »), jamais une page de synthèse seule : le « Vérifié le » de `service-public` date la lecture, pas la valeur, et `securite-routiere.gouv.fr` ne fait jamais autorité seul sur un chiffre. Liste blanche, et rien d'autre : `legifrance.gouv.fr`, `securite-routiere.gouv.fr`, `service-public.gouv.fr`, `ecologie.gouv.fr`, `sante.gouv.fr`, `unece.org`, `eur-lex.europa.eu`, `cprguidelines.eu`, `erc.edu`, `croix-rouge.fr`, `inrs.fr`.

- [ ] **Step 4: Corriger la justesse dans `Valido/Resources/questions.json`**

Appliquer les corrections de l'étape 3. Quand la valeur périmée était la bonne réponse, **elle devient un distracteur** : c'est exactement ce qu'un candidat aura lu ailleurs. Ne toucher à aucun `id`.

- [ ] **Step 5: Réécrire pour qui découvre la règle**

Les quatre critères des Global Constraints, sur les trois champs. Commencer par les 1 explication(s) sous 120 caractères. Aucune carte illustrée : le budget de 220 ne contraint pas ce domaine.

- [ ] **Step 6: Renormaliser le fichier et prouver qu'aucun `id` n'a bougé**

Run :

```bash
python3 - <<'EOF'
import json
p = 'Valido/Resources/questions.json'
d = json.load(open(p))
with open(p, 'w', encoding='utf-8') as f:
    json.dump(d, f, ensure_ascii=False, indent=2, sort_keys=True)
    f.write('\n')
print(len(d), 'questions')
EOF
python3 - <<'EOF'
import json, subprocess
avant = json.loads(subprocess.run(
    ['git', 'show', 'HEAD:Valido/Resources/questions.json'],
    capture_output=True, text=True).stdout)
apres = json.load(open('Valido/Resources/questions.json'))
a = [q['id'] for q in avant]
b = [q['id'] for q in apres]
print('mêmes ids :', sorted(a) == sorted(b), '|', len(a), '->', len(b))
print('ajoutés :', sorted(set(b) - set(a)), '| retirés :', sorted(set(a) - set(b)))
EOF
```

Expected : `448 questions`, `mêmes ids : True | 448 -> 448`, et deux listes vides.

- [ ] **Step 7: Chercher les fuites introduites, puis repasser `audit.py`**

Run :

```bash
python3 Tools/relire.py --fuites "Permis & sanctions" | tail -40
python3 Tools/audit.py > .passe3/apres-02.txt
diff <(grep -E '^### ' .passe3/avant-02.txt) <(grep -E '^### ' .passe3/apres-02.txt) || true
```

Expected : `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10` et `forme/backtick-isole` **absents** du rapport d'après. **Une sortie qui passe de vide à non vide est un échec de la tâche** : corriger dans les données avant de continuer. `expl/paraphrase-litterale` doit avoir baissé si le domaine en portait. Chaque recouvrement listé par `--fuites` se relit à la main — un mot commun est normal, la réponse entière ne l'est pas.

- [ ] **Step 8: Reporter dans `Tools/sources.md`, puis écrire la section du rapport**

Dans `Tools/sources.md` : pour chaque ligne dont ce qui est affirmé a changé, réécrire la colonne `affirmation` et porter `relevé le` à la date de la lecture. Un changement de `nature` se justifie dans la colonne. **Ne pas toucher aux lignes inchangées.**

Dans `Tools/audit-2026-08-passe-3.md`, ajouter :

```markdown
## Permis & sanctions

19 cartes, 19 `datée`, 0 illustrée(s).

### Écarts de justesse trouvés

| id | écart | ce que disait la carte | ce que dit l'article | correction |
|---|---|---|---|---|

### Doutes signalés, non corrigés

| id | ce qui est douteux | ce qui a été lu | ce qui manque |
|---|---|---|---|

### Pédagogie

- explications sous 120 caractères : 1 à l'entrée, N à la sortie
- cartes dont le budget de 220 a limité l'explication : …
- énoncés reformulés parce qu'ils présupposaient la règle : …

### Mouvements d'`audit.py`

| sortie | avant | après |
|---|---|---|
```

Une section vide se remplit d'**une phrase qui dit qu'elle est vide et pourquoi**, jamais d'un tableau sans ligne : « aucun écart de justesse — les N lignes `datée` du domaine ont toutes été relevées le … et la carte ne dit rien de plus que son affirmation » se vérifie, « (vide) » ne se vérifie pas.

- [ ] **Step 9: Lancer les dix tests du contenu livré**

Run :

```bash
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl boot 'iPhone 17 Pro' 2>/dev/null || true
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  -only-testing:'ValidoTests/leContenuLivréEstValide()' \
  -only-testing:'ValidoTests/lesDeuxMatièresSontPrésentes()' \
  -only-testing:'ValidoTests/aucuneExplicationNeCommenceParUneLettreDeRéponse()' \
  -only-testing:'ValidoTests/chaqueQuestionAAuMoinsDeuxOptionsEtUneBonneRéponse()' \
  -only-testing:'ValidoTests/laBonneRéponseNeDépassePasLaDeuxièmePlusLongueDeDixCaractères()' \
  -only-testing:'ValidoTests/aucuneOptionNeCommenceParUneLettreDeRéponse()' \
  -only-testing:'ValidoTests/chaqueIllustrationRéférencéeExisteDansLeBundle()' \
  -only-testing:'ValidoTests/chaqueAltDécritVraimentLaScène()' \
  -only-testing:'ValidoTests/leBudgetDeHauteurDesQuestionsIllustréesEstTenu()' \
  -only-testing:'ValidoTests/laBanqueGardeSonVolumeIllustré()' 2>&1 | tail -30
```

Expected : `** TEST SUCCEEDED **` **et** la ligne `✔ Test run with 10 test(s)`. Sans la ligne de comptage, la réussite ne prouve rien. Si `Application failed preflight checks` / `Busy` sort sans qu'aucun test n'ait tourné, c'est le simulateur — changer de device via `DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl list devices available` — pas le contenu.

- [ ] **Step 10: Commit**

```bash
git add Valido/Resources/questions.json Tools/sources.md Tools/audit-2026-08-passe-3.md
git commit -m "$(cat <<'EOF'
Reread the « Permis & sanctions » cards against what the registry records

<Une ligne par écart de justesse corrigé, avec son article et sa
version en vigueur. Puis ce que la réécriture a changé : les
explications qui renommaient la réponse disent maintenant la règle,
sa raison et sa limite. Puis les doutes laissés ouverts, et pourquoi
ils ne sont pas corrigés.>

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>
EOF
)"
```

Le corps se rédige à partir de la section du rapport : il dit **ce qui a bougé et pourquoi**, jamais « fix content ».

---

### Tâche 3 : domaine « Vitesse »

**Files:**
- Modify: `Valido/Resources/questions.json` — les 22 cartes `code` de `topic` « Vitesse »
- Modify: `Tools/sources.md` — les lignes dont l'`affirmation` change
- Create/Modify: `Tools/audit-2026-08-passe-3.md` — la section du domaine

**Interfaces:**
- Consumes: `python3 Tools/relire.py "Vitesse"` et `python3 Tools/relire.py --fuites "Vitesse"` (tâche 1).
- Produces: une section `## Vitesse` dans `Tools/audit-2026-08-passe-3.md`, au format fixé à l'étape 8, que la tâche 16 consolide sans le réécrire.

**Le lot.** 22 cartes : **19 `datée`**, 3 `stable`, **4 illustrée(s)** (explications à 208, 211, 218, 218 caractères sur 220). Relevés du registre : 2026-08-23. **4** explication(s) sous 120 caractères ; **8** portant un absolu ou une obligation à confronter à l'affirmation.

| id (18 car., greppable) | nat. | énoncé | drapeaux |
|---|---|---|---|
| `07ef459de55adcb501` | s | Ce panneau impose : | IMG expl 211/220 |
| `37fe1af42b8d815ba4` | D | Par beau temps sur autoroute, cette voie interdit de desce… | IMG expl 208/220; ABS impose |
| `3adc294978b6ac1f64` | s | Ce panneau annonce : | IMG expl 218/220; ABS toutes les |
| `ed0e45e08fb4f47007` | D | Ce panneau vous fait entrer dans : | IMG expl 218/220 |
| `04182c9bbdeb305e21` | D | Un dépassement de la vitesse autorisée de 40 à moins de 50… | ABS obligatoire |
| `14eb253e5dc55f5633` | D | Un excès de vitesse de moins de 5 km/h fait perdre : | — |
| `25390f0f30dbb64020` | s | Sur autoroute, à l'approche d'un chantier, la vitesse à te… | — |
| `337bfcb4d034b62de5` | D | Depuis fin 2025, un excès de vitesse de 50 km/h ou plus es… | — |
| `37fe1af42b8d812c95` | D | Dans une zone de rencontre, la vitesse est limitée à : | ABS doit |
| `37fe1af42b8d815894` | D | En agglomération, quelle est la vitesse maximale par défau… | COURTE 114; ABS impose |
| `37fe1af42b8d816b8b` | D | Vous dépassez de 30 km/h la vitesse autorisée. Combien de … | ABS aucun |
| `37fe1af42b8d817994` | D | Hors agglomération, sur une route à double sens sans sépar… | COURTE 102 |
| `37fe1af42b8d817a91` | D | Un grand excès de vitesse de 50 km/h ou plus entraîne un r… | — |
| `37fe1af42b8d818da2` | D | Par temps de pluie, sur une route à chaussées séparées lim… | COURTE 74 |
| `37fe1af42b8d819e96` | D | Jeune conducteur en période probatoire : quelle vitesse ma… | — |
| `37fe1af42b8d81d0bf` | D | Par temps de pluie, à quelle vitesse maximale puis-je roul… | — |
| `37fe1af42b8d81f9ae` | D | Par brouillard, avec une visibilité inférieure à 50 mètres… | COURTE 80 |
| `61eed52d453ac9d8ab` | D | En période probatoire, sur une route limitée à 70 km/h, vo… | ABS jamais/toujours |
| `87c63a1be4e005f6c8` | D | En période probatoire, sur une route à chaussées séparées … | ABS jamais |
| `cac0f9db162887802d` | D | Entre une zone 30 et une zone de rencontre, la différence … | — |
| `f7370daabea929065f` | D | Hors agglomération, sur une chaussée à deux voies dans vot… | — |
| `fed604fe7c4b8b3b96` | D | Hors agglomération, sur une route à chaussées séparées par… | — |

`D` = `datée`, `s` = `stable`. `IMG` = illustrée, budget 70 / 50 / 220. `COURTE` = explication sous 120 caractères, candidate n° 1 du critère 3. `ABS` = absolu ou obligation dans l'explication, à confronter à l'affirmation (écart « règle trop large »). **Un drapeau est une piste, pas un verdict, et son absence n'est pas un quitus : les cartes sans drapeau se relisent aussi.**

- [ ] **Step 1: Relever l'état d'avant, pour pouvoir prouver le mouvement**

Run :

```bash
mkdir -p .passe3 && python3 Tools/audit.py > .passe3/avant-03.txt
grep -E '^### ' .passe3/avant-03.txt
python3 - <<'EOF'
import json, statistics
qs = json.load(open('Valido/Resources/questions.json'))
lot = [q for q in qs if q['subject'] == 'code' and q['topic'] == 'Vitesse']
el = [len(q['explanation']) for q in lot]
print(len(lot), 'cartes | expl médiane', statistics.median(el),
      '| sous 120 :', sum(1 for x in el if x < 120),
      '| illustrées :', sum(1 for q in lot if q.get('illustration')))
EOF
```

Expected : la ligne de base des Global Constraints, puis `22 cartes … sous 120 : 4 … illustrées : 4`.

- [ ] **Step 2: Lire les 22 cartes à côté de leur ligne de registre**

Run :

```bash
python3 Tools/relire.py "Vitesse" > .passe3/lot-03.txt
less .passe3/lot-03.txt
```

Lire **la ligne avant la carte**. L'`affirmation` est la référence ; la carte est ce qu'on vérifie contre elle. **Ne rien éditer à cette étape** : lire tout le domaine d'abord, pour que les cartes se corrigent les unes par les autres — deux cartes voisines qui se contredisent (cas n° 8 du §9.5 de la passe 2, « deux verres » contre « deux ou trois verres ») ne se voient qu'en lisant le lot entier.

- [ ] **Step 3: Marquer les trois écarts de justesse**

Pour chaque carte, dans l'ordre du tableau des Global Constraints : **valeur périmée**, puis **règle trop large**, puis **explication au-delà de l'article**. Consigner dans `.passe3/ecarts-03.md` une ligne par écart — `id`, écart, ce que dit la carte, ce que dit l'affirmation, correction envisagée.

**Rouvrir une source dans un seul cas** : la carte affirme quelque chose que l'affirmation ne couvre pas **et** qui n'est pas manifestement faux. Lire alors l'**article consolidé** (Legifrance, ligne « Version en vigueur depuis le … »), jamais une page de synthèse seule : le « Vérifié le » de `service-public` date la lecture, pas la valeur, et `securite-routiere.gouv.fr` ne fait jamais autorité seul sur un chiffre. Liste blanche, et rien d'autre : `legifrance.gouv.fr`, `securite-routiere.gouv.fr`, `service-public.gouv.fr`, `ecologie.gouv.fr`, `sante.gouv.fr`, `unece.org`, `eur-lex.europa.eu`, `cprguidelines.eu`, `erc.edu`, `croix-rouge.fr`, `inrs.fr`.

- [ ] **Step 4: Corriger la justesse dans `Valido/Resources/questions.json`**

Appliquer les corrections de l'étape 3. Quand la valeur périmée était la bonne réponse, **elle devient un distracteur** : c'est exactement ce qu'un candidat aura lu ailleurs. Ne toucher à aucun `id`.

- [ ] **Step 5: Réécrire pour qui découvre la règle**

Les quatre critères des Global Constraints, sur les trois champs. Commencer par les 4 explication(s) sous 120 caractères. Sur les 4 carte(s) illustrée(s), le gain vient de la **coupe** : supprimer la reformulation de la bonne réponse libère la place des trois temps.

- [ ] **Step 6: Renormaliser le fichier et prouver qu'aucun `id` n'a bougé**

Run :

```bash
python3 - <<'EOF'
import json
p = 'Valido/Resources/questions.json'
d = json.load(open(p))
with open(p, 'w', encoding='utf-8') as f:
    json.dump(d, f, ensure_ascii=False, indent=2, sort_keys=True)
    f.write('\n')
print(len(d), 'questions')
EOF
python3 - <<'EOF'
import json, subprocess
avant = json.loads(subprocess.run(
    ['git', 'show', 'HEAD:Valido/Resources/questions.json'],
    capture_output=True, text=True).stdout)
apres = json.load(open('Valido/Resources/questions.json'))
a = [q['id'] for q in avant]
b = [q['id'] for q in apres]
print('mêmes ids :', sorted(a) == sorted(b), '|', len(a), '->', len(b))
print('ajoutés :', sorted(set(b) - set(a)), '| retirés :', sorted(set(a) - set(b)))
EOF
```

Expected : `448 questions`, `mêmes ids : True | 448 -> 448`, et deux listes vides.

- [ ] **Step 7: Chercher les fuites introduites, puis repasser `audit.py`**

Run :

```bash
python3 Tools/relire.py --fuites "Vitesse" | tail -40
python3 Tools/audit.py > .passe3/apres-03.txt
diff <(grep -E '^### ' .passe3/avant-03.txt) <(grep -E '^### ' .passe3/apres-03.txt) || true
```

Expected : `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10` et `forme/backtick-isole` **absents** du rapport d'après. **Une sortie qui passe de vide à non vide est un échec de la tâche** : corriger dans les données avant de continuer. `expl/paraphrase-litterale` doit avoir baissé si le domaine en portait. Chaque recouvrement listé par `--fuites` se relit à la main — un mot commun est normal, la réponse entière ne l'est pas.

- [ ] **Step 8: Reporter dans `Tools/sources.md`, puis écrire la section du rapport**

Dans `Tools/sources.md` : pour chaque ligne dont ce qui est affirmé a changé, réécrire la colonne `affirmation` et porter `relevé le` à la date de la lecture. Un changement de `nature` se justifie dans la colonne. **Ne pas toucher aux lignes inchangées.**

Dans `Tools/audit-2026-08-passe-3.md`, ajouter :

```markdown
## Vitesse

22 cartes, 19 `datée`, 4 illustrée(s).

### Écarts de justesse trouvés

| id | écart | ce que disait la carte | ce que dit l'article | correction |
|---|---|---|---|---|

### Doutes signalés, non corrigés

| id | ce qui est douteux | ce qui a été lu | ce qui manque |
|---|---|---|---|

### Pédagogie

- explications sous 120 caractères : 4 à l'entrée, N à la sortie
- cartes dont le budget de 220 a limité l'explication : …
- énoncés reformulés parce qu'ils présupposaient la règle : …

### Mouvements d'`audit.py`

| sortie | avant | après |
|---|---|---|
```

Une section vide se remplit d'**une phrase qui dit qu'elle est vide et pourquoi**, jamais d'un tableau sans ligne : « aucun écart de justesse — les N lignes `datée` du domaine ont toutes été relevées le … et la carte ne dit rien de plus que son affirmation » se vérifie, « (vide) » ne se vérifie pas.

- [ ] **Step 9: Lancer les dix tests du contenu livré**

Run :

```bash
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl boot 'iPhone 17 Pro' 2>/dev/null || true
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  -only-testing:'ValidoTests/leContenuLivréEstValide()' \
  -only-testing:'ValidoTests/lesDeuxMatièresSontPrésentes()' \
  -only-testing:'ValidoTests/aucuneExplicationNeCommenceParUneLettreDeRéponse()' \
  -only-testing:'ValidoTests/chaqueQuestionAAuMoinsDeuxOptionsEtUneBonneRéponse()' \
  -only-testing:'ValidoTests/laBonneRéponseNeDépassePasLaDeuxièmePlusLongueDeDixCaractères()' \
  -only-testing:'ValidoTests/aucuneOptionNeCommenceParUneLettreDeRéponse()' \
  -only-testing:'ValidoTests/chaqueIllustrationRéférencéeExisteDansLeBundle()' \
  -only-testing:'ValidoTests/chaqueAltDécritVraimentLaScène()' \
  -only-testing:'ValidoTests/leBudgetDeHauteurDesQuestionsIllustréesEstTenu()' \
  -only-testing:'ValidoTests/laBanqueGardeSonVolumeIllustré()' 2>&1 | tail -30
```

Expected : `** TEST SUCCEEDED **` **et** la ligne `✔ Test run with 10 test(s)`. Sans la ligne de comptage, la réussite ne prouve rien. Si `Application failed preflight checks` / `Busy` sort sans qu'aucun test n'ait tourné, c'est le simulateur — changer de device via `DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl list devices available` — pas le contenu.

- [ ] **Step 10: Commit**

```bash
git add Valido/Resources/questions.json Tools/sources.md Tools/audit-2026-08-passe-3.md
git commit -m "$(cat <<'EOF'
Reread the « Vitesse » cards against what the registry records

<Une ligne par écart de justesse corrigé, avec son article et sa
version en vigueur. Puis ce que la réécriture a changé : les
explications qui renommaient la réponse disent maintenant la règle,
sa raison et sa limite. Puis les doutes laissés ouverts, et pourquoi
ils ne sont pas corrigés.>

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>
EOF
)"
```

Le corps se rédige à partir de la section du rapport : il dit **ce qui a bougé et pourquoi**, jamais « fix content ».

---

### Tâche 4 : domaine « Alcool & stupéfiants »

**Files:**
- Modify: `Valido/Resources/questions.json` — les 18 cartes `code` de `topic` « Alcool & stupéfiants »
- Modify: `Tools/sources.md` — les lignes dont l'`affirmation` change
- Create/Modify: `Tools/audit-2026-08-passe-3.md` — la section du domaine

**Interfaces:**
- Consumes: `python3 Tools/relire.py "Alcool & stupéfiants"` et `python3 Tools/relire.py --fuites "Alcool & stupéfiants"` (tâche 1).
- Produces: une section `## Alcool & stupéfiants` dans `Tools/audit-2026-08-passe-3.md`, au format fixé à l'étape 8, que la tâche 16 consolide sans le réécrire.

**Le lot.** 18 cartes : **17 `datée`**, 1 `stable`, **0 illustrée(s)**. Relevés du registre : 2026-08-24. **0** explication(s) sous 120 caractères ; **7** portant un absolu ou une obligation à confronter à l'affirmation.

| id (18 car., greppable) | nat. | énoncé | drapeaux |
|---|---|---|---|
| `22603ebb1d645f3273` | D | Après un accident ayant causé un dommage corporel, le dépi… | ABS systématiquement |
| `37fe1af42b8d810ea5` | D | Conduire après usage de stupéfiants est : | ABS aucun |
| `37fe1af42b8d8118b6` | D | Pour un permis classique, le taux d'alcool maximal autoris… | — |
| `37fe1af42b8d811eae` | D | L'alcool dans le sang s'élimine à un rythme d'environ : | — |
| `37fe1af42b8d812180` | D | Un verre d'alcool standard servi dans un bar fait monter l… | — |
| `37fe1af42b8d817e8e` | D | À partir de 0,8 g/L de sang, conduire est : | — |
| `37fe1af42b8d817e9b` | D | Conduire avec un taux entre 0,5 et 0,8 g/L fait perdre : | — |
| `37fe1af42b8d81b381` | D | La conduite sous stupéfiants expose à une peine pouvant al… | ABS suffit |
| `37fe1af42b8d81b3b1` | D | Parmi ces effets, lequel est causé par l'alcool au volant … | ABS aucune |
| `37fe1af42b8d81cf87` | D | Pour un conducteur en permis probatoire, le taux d'alcool … | — |
| `37fe1af42b8d81f2a6` | s | Pour éliminer l'alcool plus rapidement, il faut : | — |
| `526ffb51f8bc0ed954` | D | Un conducteur en permis probatoire contrôlé à 0,4 g/L de s… | — |
| `5720fa6a7cd6274398` | D | Conduire avec 0,9 g/L d'alcool dans le sang expose au maxi… | — |
| `749552ac121e0cd77b` | D | Refuser de se soumettre au dépistage d'alcoolémie est : | ABS toujours |
| `92f3fe40dd9c28ff00` | D | Refuser de se soumettre à un dépistage de stupéfiants expo… | — |
| `bda97dae02fa9e085f` | D | Après un accident causé sous l'emprise de l'alcool, l'assu… | ABS obligatoire |
| `e13df5a7d4151bdeca` | D | Conduire sous l'emprise de l'alcool et de stupéfiants expo… | ABS obligatoire |
| `ef26cca38b9d1abc6f` | D | L'éthylotest antidémarrage est un dispositif qui : | — |

`D` = `datée`, `s` = `stable`. `IMG` = illustrée, budget 70 / 50 / 220. `COURTE` = explication sous 120 caractères, candidate n° 1 du critère 3. `ABS` = absolu ou obligation dans l'explication, à confronter à l'affirmation (écart « règle trop large »). **Un drapeau est une piste, pas un verdict, et son absence n'est pas un quitus : les cartes sans drapeau se relisent aussi.**

- [ ] **Step 1: Relever l'état d'avant, pour pouvoir prouver le mouvement**

Run :

```bash
mkdir -p .passe3 && python3 Tools/audit.py > .passe3/avant-04.txt
grep -E '^### ' .passe3/avant-04.txt
python3 - <<'EOF'
import json, statistics
qs = json.load(open('Valido/Resources/questions.json'))
lot = [q for q in qs if q['subject'] == 'code' and q['topic'] == 'Alcool & stupéfiants']
el = [len(q['explanation']) for q in lot]
print(len(lot), 'cartes | expl médiane', statistics.median(el),
      '| sous 120 :', sum(1 for x in el if x < 120),
      '| illustrées :', sum(1 for q in lot if q.get('illustration')))
EOF
```

Expected : la ligne de base des Global Constraints, puis `18 cartes … sous 120 : 0 … illustrées : 0`.

- [ ] **Step 2: Lire les 18 cartes à côté de leur ligne de registre**

Run :

```bash
python3 Tools/relire.py "Alcool & stupéfiants" > .passe3/lot-04.txt
less .passe3/lot-04.txt
```

Lire **la ligne avant la carte**. L'`affirmation` est la référence ; la carte est ce qu'on vérifie contre elle. **Ne rien éditer à cette étape** : lire tout le domaine d'abord, pour que les cartes se corrigent les unes par les autres — deux cartes voisines qui se contredisent (cas n° 8 du §9.5 de la passe 2, « deux verres » contre « deux ou trois verres ») ne se voient qu'en lisant le lot entier.

- [ ] **Step 3: Marquer les trois écarts de justesse**

Pour chaque carte, dans l'ordre du tableau des Global Constraints : **valeur périmée**, puis **règle trop large**, puis **explication au-delà de l'article**. Consigner dans `.passe3/ecarts-04.md` une ligne par écart — `id`, écart, ce que dit la carte, ce que dit l'affirmation, correction envisagée.

**Rouvrir une source dans un seul cas** : la carte affirme quelque chose que l'affirmation ne couvre pas **et** qui n'est pas manifestement faux. Lire alors l'**article consolidé** (Legifrance, ligne « Version en vigueur depuis le … »), jamais une page de synthèse seule : le « Vérifié le » de `service-public` date la lecture, pas la valeur, et `securite-routiere.gouv.fr` ne fait jamais autorité seul sur un chiffre. Liste blanche, et rien d'autre : `legifrance.gouv.fr`, `securite-routiere.gouv.fr`, `service-public.gouv.fr`, `ecologie.gouv.fr`, `sante.gouv.fr`, `unece.org`, `eur-lex.europa.eu`, `cprguidelines.eu`, `erc.edu`, `croix-rouge.fr`, `inrs.fr`.

- [ ] **Step 4: Corriger la justesse dans `Valido/Resources/questions.json`**

Appliquer les corrections de l'étape 3. Quand la valeur périmée était la bonne réponse, **elle devient un distracteur** : c'est exactement ce qu'un candidat aura lu ailleurs. Ne toucher à aucun `id`.

- [ ] **Step 5: Réécrire pour qui découvre la règle**

Les quatre critères des Global Constraints, sur les trois champs. Commencer par les 0 explication(s) sous 120 caractères (aucune ici : le domaine part d'explications déjà étoffées, le gain est sur l'énoncé et les options). Aucune carte illustrée : le budget de 220 ne contraint pas ce domaine.

- [ ] **Step 6: Renormaliser le fichier et prouver qu'aucun `id` n'a bougé**

Run :

```bash
python3 - <<'EOF'
import json
p = 'Valido/Resources/questions.json'
d = json.load(open(p))
with open(p, 'w', encoding='utf-8') as f:
    json.dump(d, f, ensure_ascii=False, indent=2, sort_keys=True)
    f.write('\n')
print(len(d), 'questions')
EOF
python3 - <<'EOF'
import json, subprocess
avant = json.loads(subprocess.run(
    ['git', 'show', 'HEAD:Valido/Resources/questions.json'],
    capture_output=True, text=True).stdout)
apres = json.load(open('Valido/Resources/questions.json'))
a = [q['id'] for q in avant]
b = [q['id'] for q in apres]
print('mêmes ids :', sorted(a) == sorted(b), '|', len(a), '->', len(b))
print('ajoutés :', sorted(set(b) - set(a)), '| retirés :', sorted(set(a) - set(b)))
EOF
```

Expected : `448 questions`, `mêmes ids : True | 448 -> 448`, et deux listes vides.

- [ ] **Step 7: Chercher les fuites introduites, puis repasser `audit.py`**

Run :

```bash
python3 Tools/relire.py --fuites "Alcool & stupéfiants" | tail -40
python3 Tools/audit.py > .passe3/apres-04.txt
diff <(grep -E '^### ' .passe3/avant-04.txt) <(grep -E '^### ' .passe3/apres-04.txt) || true
```

Expected : `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10` et `forme/backtick-isole` **absents** du rapport d'après. **Une sortie qui passe de vide à non vide est un échec de la tâche** : corriger dans les données avant de continuer. `expl/paraphrase-litterale` doit avoir baissé si le domaine en portait. Chaque recouvrement listé par `--fuites` se relit à la main — un mot commun est normal, la réponse entière ne l'est pas.

- [ ] **Step 8: Reporter dans `Tools/sources.md`, puis écrire la section du rapport**

Dans `Tools/sources.md` : pour chaque ligne dont ce qui est affirmé a changé, réécrire la colonne `affirmation` et porter `relevé le` à la date de la lecture. Un changement de `nature` se justifie dans la colonne. **Ne pas toucher aux lignes inchangées.**

Dans `Tools/audit-2026-08-passe-3.md`, ajouter :

```markdown
## Alcool & stupéfiants

18 cartes, 17 `datée`, 0 illustrée(s).

### Écarts de justesse trouvés

| id | écart | ce que disait la carte | ce que dit l'article | correction |
|---|---|---|---|---|

### Doutes signalés, non corrigés

| id | ce qui est douteux | ce qui a été lu | ce qui manque |
|---|---|---|---|

### Pédagogie

- explications sous 120 caractères : 0 à l'entrée, N à la sortie
- cartes dont le budget de 220 a limité l'explication : …
- énoncés reformulés parce qu'ils présupposaient la règle : …

### Mouvements d'`audit.py`

| sortie | avant | après |
|---|---|---|
```

Une section vide se remplit d'**une phrase qui dit qu'elle est vide et pourquoi**, jamais d'un tableau sans ligne : « aucun écart de justesse — les N lignes `datée` du domaine ont toutes été relevées le … et la carte ne dit rien de plus que son affirmation » se vérifie, « (vide) » ne se vérifie pas.

- [ ] **Step 9: Lancer les dix tests du contenu livré**

Run :

```bash
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl boot 'iPhone 17 Pro' 2>/dev/null || true
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  -only-testing:'ValidoTests/leContenuLivréEstValide()' \
  -only-testing:'ValidoTests/lesDeuxMatièresSontPrésentes()' \
  -only-testing:'ValidoTests/aucuneExplicationNeCommenceParUneLettreDeRéponse()' \
  -only-testing:'ValidoTests/chaqueQuestionAAuMoinsDeuxOptionsEtUneBonneRéponse()' \
  -only-testing:'ValidoTests/laBonneRéponseNeDépassePasLaDeuxièmePlusLongueDeDixCaractères()' \
  -only-testing:'ValidoTests/aucuneOptionNeCommenceParUneLettreDeRéponse()' \
  -only-testing:'ValidoTests/chaqueIllustrationRéférencéeExisteDansLeBundle()' \
  -only-testing:'ValidoTests/chaqueAltDécritVraimentLaScène()' \
  -only-testing:'ValidoTests/leBudgetDeHauteurDesQuestionsIllustréesEstTenu()' \
  -only-testing:'ValidoTests/laBanqueGardeSonVolumeIllustré()' 2>&1 | tail -30
```

Expected : `** TEST SUCCEEDED **` **et** la ligne `✔ Test run with 10 test(s)`. Sans la ligne de comptage, la réussite ne prouve rien. Si `Application failed preflight checks` / `Busy` sort sans qu'aucun test n'ait tourné, c'est le simulateur — changer de device via `DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl list devices available` — pas le contenu.

- [ ] **Step 10: Commit**

```bash
git add Valido/Resources/questions.json Tools/sources.md Tools/audit-2026-08-passe-3.md
git commit -m "$(cat <<'EOF'
Reread the « Alcool & stupéfiants » cards against what the registry records

<Une ligne par écart de justesse corrigé, avec son article et sa
version en vigueur. Puis ce que la réécriture a changé : les
explications qui renommaient la réponse disent maintenant la règle,
sa raison et sa limite. Puis les doutes laissés ouverts, et pourquoi
ils ne sont pas corrigés.>

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>
EOF
)"
```

Le corps se rédige à partir de la section du rapport : il dit **ce qui a bougé et pourquoi**, jamais « fix content ».

---

### Tâche 5 : domaine « Usagers & partage de la route »

**Files:**
- Modify: `Valido/Resources/questions.json` — les 18 cartes `code` de `topic` « Usagers & partage de la route »
- Modify: `Tools/sources.md` — les lignes dont l'`affirmation` change
- Create/Modify: `Tools/audit-2026-08-passe-3.md` — la section du domaine

**Interfaces:**
- Consumes: `python3 Tools/relire.py "Usagers & partage de la route"` et `python3 Tools/relire.py --fuites "Usagers & partage de la route"` (tâche 1).
- Produces: une section `## Usagers & partage de la route` dans `Tools/audit-2026-08-passe-3.md`, au format fixé à l'étape 8, que la tâche 16 consolide sans le réécrire.

**Le lot.** 18 cartes : **14 `datée`**, 4 `stable`, **4 illustrée(s)** (explications à 202, 210, 212, 219 caractères sur 220). Relevés du registre : 2026-08-26, 2026-08-27. **0** explication(s) sous 120 caractères ; **7** portant un absolu ou une obligation à confronter à l'affirmation.

| id (18 car., greppable) | nat. | énoncé | drapeaux |
|---|---|---|---|
| `39fa27d59e28817c42` | s | Ce feu passe au rouge. Votre voiture s'arrête : | IMG expl 219/220 |
| `9b774739866a136e7c` | D | Vous dépassez ce cycliste en le laissant à au moins : | IMG expl 210/220; ABS impose |
| `c29b2e7d758f0d17e7` | s | À cette place le long du camion, le mieux est de : | IMG expl 202/220 |
| `f6ef205dcb2d32c5f3` | D | Face à ce bus, vous devez : | IMG expl 212/220 |
| `058434ed65eee628ae` | D | Un piéton doit emprunter le passage protégé s'il en existe… | ABS impose |
| `0b13aed9a8d54d809e` | D | La circulation d'une trottinette électrique sur le trottoi… | — |
| `45d84549ac55287098` | D | Hors agglomération, un engin de déplacement personnel moto… | ABS obligatoire |
| `49f761c8ac8bd10ed3` | D | Vous doublez un autocar qui fait descendre des enfants. Vo… | ABS doit/impose |
| `5f426e8e0d23263046` | D | La circulation inter-files des deux-roues motorisés est : | — |
| `7c2284d4cc7f32e90c` | D | Sur un trottoir, un enfant à vélo peut rouler : | ABS jamais |
| `82b915c28f76ff1314` | D | Sur une moto, les gants certifiés sont obligatoires pour : | — |
| `9eed1fe645eb99123b` | D | Les autocollants qui matérialisent les angles morts sont o… | ABS impose |
| `a6fb8c0684dce67923` | D | En inter-files, la vitesse ne peut excéder : | — |
| `b7b38d7ae1faf0dd59` | s | Hors agglomération, un piéton contraint d'emprunter la cha… | — |
| `bf6922c59ca8a1e934` | D | À vélo, le casque attaché est obligatoire pour : | — |
| `d3f45f8d29cf6fb411` | D | L'âge minimal pour conduire une trottinette électrique est… | — |
| `e6f52409aaec9cc7d1` | s | Hors agglomération, celui qui pousse son vélo à la main ma… | ABS toutes les |
| `fe6c39082afe1716a7` | D | Par construction, un engin de déplacement personnel motori… | — |

`D` = `datée`, `s` = `stable`. `IMG` = illustrée, budget 70 / 50 / 220. `COURTE` = explication sous 120 caractères, candidate n° 1 du critère 3. `ABS` = absolu ou obligation dans l'explication, à confronter à l'affirmation (écart « règle trop large »). **Un drapeau est une piste, pas un verdict, et son absence n'est pas un quitus : les cartes sans drapeau se relisent aussi.**

- [ ] **Step 1: Relever l'état d'avant, pour pouvoir prouver le mouvement**

Run :

```bash
mkdir -p .passe3 && python3 Tools/audit.py > .passe3/avant-05.txt
grep -E '^### ' .passe3/avant-05.txt
python3 - <<'EOF'
import json, statistics
qs = json.load(open('Valido/Resources/questions.json'))
lot = [q for q in qs if q['subject'] == 'code' and q['topic'] == 'Usagers & partage de la route']
el = [len(q['explanation']) for q in lot]
print(len(lot), 'cartes | expl médiane', statistics.median(el),
      '| sous 120 :', sum(1 for x in el if x < 120),
      '| illustrées :', sum(1 for q in lot if q.get('illustration')))
EOF
```

Expected : la ligne de base des Global Constraints, puis `18 cartes … sous 120 : 0 … illustrées : 4`.

- [ ] **Step 2: Lire les 18 cartes à côté de leur ligne de registre**

Run :

```bash
python3 Tools/relire.py "Usagers & partage de la route" > .passe3/lot-05.txt
less .passe3/lot-05.txt
```

Lire **la ligne avant la carte**. L'`affirmation` est la référence ; la carte est ce qu'on vérifie contre elle. **Ne rien éditer à cette étape** : lire tout le domaine d'abord, pour que les cartes se corrigent les unes par les autres — deux cartes voisines qui se contredisent (cas n° 8 du §9.5 de la passe 2, « deux verres » contre « deux ou trois verres ») ne se voient qu'en lisant le lot entier.

- [ ] **Step 3: Marquer les trois écarts de justesse**

Pour chaque carte, dans l'ordre du tableau des Global Constraints : **valeur périmée**, puis **règle trop large**, puis **explication au-delà de l'article**. Consigner dans `.passe3/ecarts-05.md` une ligne par écart — `id`, écart, ce que dit la carte, ce que dit l'affirmation, correction envisagée.

**Rouvrir une source dans un seul cas** : la carte affirme quelque chose que l'affirmation ne couvre pas **et** qui n'est pas manifestement faux. Lire alors l'**article consolidé** (Legifrance, ligne « Version en vigueur depuis le … »), jamais une page de synthèse seule : le « Vérifié le » de `service-public` date la lecture, pas la valeur, et `securite-routiere.gouv.fr` ne fait jamais autorité seul sur un chiffre. Liste blanche, et rien d'autre : `legifrance.gouv.fr`, `securite-routiere.gouv.fr`, `service-public.gouv.fr`, `ecologie.gouv.fr`, `sante.gouv.fr`, `unece.org`, `eur-lex.europa.eu`, `cprguidelines.eu`, `erc.edu`, `croix-rouge.fr`, `inrs.fr`.

- [ ] **Step 4: Corriger la justesse dans `Valido/Resources/questions.json`**

Appliquer les corrections de l'étape 3. Quand la valeur périmée était la bonne réponse, **elle devient un distracteur** : c'est exactement ce qu'un candidat aura lu ailleurs. Ne toucher à aucun `id`.

- [ ] **Step 5: Réécrire pour qui découvre la règle**

Les quatre critères des Global Constraints, sur les trois champs. Commencer par les 0 explication(s) sous 120 caractères (aucune ici : le domaine part d'explications déjà étoffées, le gain est sur l'énoncé et les options). Sur les 4 carte(s) illustrée(s), le gain vient de la **coupe** : supprimer la reformulation de la bonne réponse libère la place des trois temps.

- [ ] **Step 6: Renormaliser le fichier et prouver qu'aucun `id` n'a bougé**

Run :

```bash
python3 - <<'EOF'
import json
p = 'Valido/Resources/questions.json'
d = json.load(open(p))
with open(p, 'w', encoding='utf-8') as f:
    json.dump(d, f, ensure_ascii=False, indent=2, sort_keys=True)
    f.write('\n')
print(len(d), 'questions')
EOF
python3 - <<'EOF'
import json, subprocess
avant = json.loads(subprocess.run(
    ['git', 'show', 'HEAD:Valido/Resources/questions.json'],
    capture_output=True, text=True).stdout)
apres = json.load(open('Valido/Resources/questions.json'))
a = [q['id'] for q in avant]
b = [q['id'] for q in apres]
print('mêmes ids :', sorted(a) == sorted(b), '|', len(a), '->', len(b))
print('ajoutés :', sorted(set(b) - set(a)), '| retirés :', sorted(set(a) - set(b)))
EOF
```

Expected : `448 questions`, `mêmes ids : True | 448 -> 448`, et deux listes vides.

- [ ] **Step 7: Chercher les fuites introduites, puis repasser `audit.py`**

Run :

```bash
python3 Tools/relire.py --fuites "Usagers & partage de la route" | tail -40
python3 Tools/audit.py > .passe3/apres-05.txt
diff <(grep -E '^### ' .passe3/avant-05.txt) <(grep -E '^### ' .passe3/apres-05.txt) || true
```

Expected : `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10` et `forme/backtick-isole` **absents** du rapport d'après. **Une sortie qui passe de vide à non vide est un échec de la tâche** : corriger dans les données avant de continuer. `expl/paraphrase-litterale` doit avoir baissé si le domaine en portait. Chaque recouvrement listé par `--fuites` se relit à la main — un mot commun est normal, la réponse entière ne l'est pas.

- [ ] **Step 8: Reporter dans `Tools/sources.md`, puis écrire la section du rapport**

Dans `Tools/sources.md` : pour chaque ligne dont ce qui est affirmé a changé, réécrire la colonne `affirmation` et porter `relevé le` à la date de la lecture. Un changement de `nature` se justifie dans la colonne. **Ne pas toucher aux lignes inchangées.**

Dans `Tools/audit-2026-08-passe-3.md`, ajouter :

```markdown
## Usagers & partage de la route

18 cartes, 14 `datée`, 4 illustrée(s).

### Écarts de justesse trouvés

| id | écart | ce que disait la carte | ce que dit l'article | correction |
|---|---|---|---|---|

### Doutes signalés, non corrigés

| id | ce qui est douteux | ce qui a été lu | ce qui manque |
|---|---|---|---|

### Pédagogie

- explications sous 120 caractères : 0 à l'entrée, N à la sortie
- cartes dont le budget de 220 a limité l'explication : …
- énoncés reformulés parce qu'ils présupposaient la règle : …

### Mouvements d'`audit.py`

| sortie | avant | après |
|---|---|---|
```

Une section vide se remplit d'**une phrase qui dit qu'elle est vide et pourquoi**, jamais d'un tableau sans ligne : « aucun écart de justesse — les N lignes `datée` du domaine ont toutes été relevées le … et la carte ne dit rien de plus que son affirmation » se vérifie, « (vide) » ne se vérifie pas.

- [ ] **Step 9: Lancer les dix tests du contenu livré**

Run :

```bash
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl boot 'iPhone 17 Pro' 2>/dev/null || true
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  -only-testing:'ValidoTests/leContenuLivréEstValide()' \
  -only-testing:'ValidoTests/lesDeuxMatièresSontPrésentes()' \
  -only-testing:'ValidoTests/aucuneExplicationNeCommenceParUneLettreDeRéponse()' \
  -only-testing:'ValidoTests/chaqueQuestionAAuMoinsDeuxOptionsEtUneBonneRéponse()' \
  -only-testing:'ValidoTests/laBonneRéponseNeDépassePasLaDeuxièmePlusLongueDeDixCaractères()' \
  -only-testing:'ValidoTests/aucuneOptionNeCommenceParUneLettreDeRéponse()' \
  -only-testing:'ValidoTests/chaqueIllustrationRéférencéeExisteDansLeBundle()' \
  -only-testing:'ValidoTests/chaqueAltDécritVraimentLaScène()' \
  -only-testing:'ValidoTests/leBudgetDeHauteurDesQuestionsIllustréesEstTenu()' \
  -only-testing:'ValidoTests/laBanqueGardeSonVolumeIllustré()' 2>&1 | tail -30
```

Expected : `** TEST SUCCEEDED **` **et** la ligne `✔ Test run with 10 test(s)`. Sans la ligne de comptage, la réussite ne prouve rien. Si `Application failed preflight checks` / `Busy` sort sans qu'aucun test n'ait tourné, c'est le simulateur — changer de device via `DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl list devices available` — pas le contenu.

- [ ] **Step 10: Commit**

```bash
git add Valido/Resources/questions.json Tools/sources.md Tools/audit-2026-08-passe-3.md
git commit -m "$(cat <<'EOF'
Reread the « Usagers & partage de la route » cards against what the registry records

<Une ligne par écart de justesse corrigé, avec son article et sa
version en vigueur. Puis ce que la réécriture a changé : les
explications qui renommaient la réponse disent maintenant la règle,
sa raison et sa limite. Puis les doutes laissés ouverts, et pourquoi
ils ne sont pas corrigés.>

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>
EOF
)"
```

Le corps se rédige à partir de la section du rapport : il dit **ce qui a bougé et pourquoi**, jamais « fix content ».

---

### Tâche 6 : domaine « Mécanique & environnement »

**Files:**
- Modify: `Valido/Resources/questions.json` — les 20 cartes `code` de `topic` « Mécanique & environnement »
- Modify: `Tools/sources.md` — les lignes dont l'`affirmation` change
- Create/Modify: `Tools/audit-2026-08-passe-3.md` — la section du domaine

**Interfaces:**
- Consumes: `python3 Tools/relire.py "Mécanique & environnement"` et `python3 Tools/relire.py --fuites "Mécanique & environnement"` (tâche 1).
- Produces: une section `## Mécanique & environnement` dans `Tools/audit-2026-08-passe-3.md`, au format fixé à l'étape 8, que la tâche 16 consolide sans le réécrire.

**Le lot.** 20 cartes : **12 `datée`**, 8 `stable`, **1 illustrée(s)** (explications à 175 caractères sur 220). Relevés du registre : 2026-08-25. **3** explication(s) sous 120 caractères ; **2** portant un absolu ou une obligation à confronter à l'affirmation.

| id (18 car., greppable) | nat. | énoncé | drapeaux |
|---|---|---|---|
| `2c0a147d9ba6e61b52` | D | Ce chargement : | IMG expl 175/220; ABS doit |
| `089e9b57f57bbb155f` | D | Un système homologué de retenue est exigé pour tout enfant… | — |
| `173c63baae24d7e7db` | D | Voiture plus remorque : la catégorie B couvre l'ensemble j… | — |
| `204454d0e329d40811` | s | Une huile de vidange et une batterie usagée : | — |
| `37fe1af42b8d811399` | D | Le témoin d'usure d'un pneu indique : | — |
| `37fe1af42b8d81209e` | s | Un témoin rouge allumé au tableau de bord signifie : | COURTE 90 |
| `37fe1af42b8d8123ab` | D | La vignette Crit'Air sert à : | — |
| `37fe1af42b8d814289` | D | Les équipements de sécurité obligatoires à bord d'une voit… | — |
| `37fe1af42b8d814ba7` | s | Sur une longue descente, pour ne pas surchauffer les frein… | — |
| `37fe1af42b8d8158a1` | s | Parmi les niveaux à surveiller régulièrement sur sa voitur… | ABS aucun |
| `37fe1af42b8d81b99c` | s | Un témoin orange (ambre) au tableau de bord signale : | COURTE 80 |
| `37fe1af42b8d81c89e` | s | L'éco-conduite consiste notamment à : | COURTE 96 |
| `37fe1af42b8d81deae` | D | La profondeur minimale légale des sculptures d'un pneu est… | — |
| `37fe1af42b8d81f4b9` | s | La pression des pneus doit être vérifiée : | — |
| `4477774964dae6e5d1` | D | En période hivernale, dans une commune soumise à l'obligat… | — |
| `526d6b502e05eefba3` | s | Une galerie de toit chargée, sur autoroute : | — |
| `6c9b9395e9090cd97a` | D | En circulation, le gilet de haute visibilité doit se trouv… | — |
| `8e64074daad0e4a72e` | D | Le port de la ceinture n'est pas obligatoire : | — |
| `cc10180c491d12311f` | D | Le premier contrôle technique d'une voiture neuve a lieu : | — |
| `eac980f55eb23bfd3b` | D | Un siège enfant dos à la route, à une place avant : | — |

`D` = `datée`, `s` = `stable`. `IMG` = illustrée, budget 70 / 50 / 220. `COURTE` = explication sous 120 caractères, candidate n° 1 du critère 3. `ABS` = absolu ou obligation dans l'explication, à confronter à l'affirmation (écart « règle trop large »). **Un drapeau est une piste, pas un verdict, et son absence n'est pas un quitus : les cartes sans drapeau se relisent aussi.**

- [ ] **Step 1: Relever l'état d'avant, pour pouvoir prouver le mouvement**

Run :

```bash
mkdir -p .passe3 && python3 Tools/audit.py > .passe3/avant-06.txt
grep -E '^### ' .passe3/avant-06.txt
python3 - <<'EOF'
import json, statistics
qs = json.load(open('Valido/Resources/questions.json'))
lot = [q for q in qs if q['subject'] == 'code' and q['topic'] == 'Mécanique & environnement']
el = [len(q['explanation']) for q in lot]
print(len(lot), 'cartes | expl médiane', statistics.median(el),
      '| sous 120 :', sum(1 for x in el if x < 120),
      '| illustrées :', sum(1 for q in lot if q.get('illustration')))
EOF
```

Expected : la ligne de base des Global Constraints, puis `20 cartes … sous 120 : 3 … illustrées : 1`.

- [ ] **Step 2: Lire les 20 cartes à côté de leur ligne de registre**

Run :

```bash
python3 Tools/relire.py "Mécanique & environnement" > .passe3/lot-06.txt
less .passe3/lot-06.txt
```

Lire **la ligne avant la carte**. L'`affirmation` est la référence ; la carte est ce qu'on vérifie contre elle. **Ne rien éditer à cette étape** : lire tout le domaine d'abord, pour que les cartes se corrigent les unes par les autres — deux cartes voisines qui se contredisent (cas n° 8 du §9.5 de la passe 2, « deux verres » contre « deux ou trois verres ») ne se voient qu'en lisant le lot entier.

- [ ] **Step 3: Marquer les trois écarts de justesse**

Pour chaque carte, dans l'ordre du tableau des Global Constraints : **valeur périmée**, puis **règle trop large**, puis **explication au-delà de l'article**. Consigner dans `.passe3/ecarts-06.md` une ligne par écart — `id`, écart, ce que dit la carte, ce que dit l'affirmation, correction envisagée.

**Rouvrir une source dans un seul cas** : la carte affirme quelque chose que l'affirmation ne couvre pas **et** qui n'est pas manifestement faux. Lire alors l'**article consolidé** (Legifrance, ligne « Version en vigueur depuis le … »), jamais une page de synthèse seule : le « Vérifié le » de `service-public` date la lecture, pas la valeur, et `securite-routiere.gouv.fr` ne fait jamais autorité seul sur un chiffre. Liste blanche, et rien d'autre : `legifrance.gouv.fr`, `securite-routiere.gouv.fr`, `service-public.gouv.fr`, `ecologie.gouv.fr`, `sante.gouv.fr`, `unece.org`, `eur-lex.europa.eu`, `cprguidelines.eu`, `erc.edu`, `croix-rouge.fr`, `inrs.fr`.

- [ ] **Step 4: Corriger la justesse dans `Valido/Resources/questions.json`**

Appliquer les corrections de l'étape 3. Quand la valeur périmée était la bonne réponse, **elle devient un distracteur** : c'est exactement ce qu'un candidat aura lu ailleurs. Ne toucher à aucun `id`.

- [ ] **Step 5: Réécrire pour qui découvre la règle**

Les quatre critères des Global Constraints, sur les trois champs. Commencer par les 3 explication(s) sous 120 caractères. Sur les 1 carte(s) illustrée(s), le gain vient de la **coupe** : supprimer la reformulation de la bonne réponse libère la place des trois temps.

- [ ] **Step 6: Renormaliser le fichier et prouver qu'aucun `id` n'a bougé**

Run :

```bash
python3 - <<'EOF'
import json
p = 'Valido/Resources/questions.json'
d = json.load(open(p))
with open(p, 'w', encoding='utf-8') as f:
    json.dump(d, f, ensure_ascii=False, indent=2, sort_keys=True)
    f.write('\n')
print(len(d), 'questions')
EOF
python3 - <<'EOF'
import json, subprocess
avant = json.loads(subprocess.run(
    ['git', 'show', 'HEAD:Valido/Resources/questions.json'],
    capture_output=True, text=True).stdout)
apres = json.load(open('Valido/Resources/questions.json'))
a = [q['id'] for q in avant]
b = [q['id'] for q in apres]
print('mêmes ids :', sorted(a) == sorted(b), '|', len(a), '->', len(b))
print('ajoutés :', sorted(set(b) - set(a)), '| retirés :', sorted(set(a) - set(b)))
EOF
```

Expected : `448 questions`, `mêmes ids : True | 448 -> 448`, et deux listes vides.

- [ ] **Step 7: Chercher les fuites introduites, puis repasser `audit.py`**

Run :

```bash
python3 Tools/relire.py --fuites "Mécanique & environnement" | tail -40
python3 Tools/audit.py > .passe3/apres-06.txt
diff <(grep -E '^### ' .passe3/avant-06.txt) <(grep -E '^### ' .passe3/apres-06.txt) || true
```

Expected : `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10` et `forme/backtick-isole` **absents** du rapport d'après. **Une sortie qui passe de vide à non vide est un échec de la tâche** : corriger dans les données avant de continuer. `expl/paraphrase-litterale` doit avoir baissé si le domaine en portait. Chaque recouvrement listé par `--fuites` se relit à la main — un mot commun est normal, la réponse entière ne l'est pas.

- [ ] **Step 8: Reporter dans `Tools/sources.md`, puis écrire la section du rapport**

Dans `Tools/sources.md` : pour chaque ligne dont ce qui est affirmé a changé, réécrire la colonne `affirmation` et porter `relevé le` à la date de la lecture. Un changement de `nature` se justifie dans la colonne. **Ne pas toucher aux lignes inchangées.**

Dans `Tools/audit-2026-08-passe-3.md`, ajouter :

```markdown
## Mécanique & environnement

20 cartes, 12 `datée`, 1 illustrée(s).

### Écarts de justesse trouvés

| id | écart | ce que disait la carte | ce que dit l'article | correction |
|---|---|---|---|---|

### Doutes signalés, non corrigés

| id | ce qui est douteux | ce qui a été lu | ce qui manque |
|---|---|---|---|

### Pédagogie

- explications sous 120 caractères : 3 à l'entrée, N à la sortie
- cartes dont le budget de 220 a limité l'explication : …
- énoncés reformulés parce qu'ils présupposaient la règle : …

### Mouvements d'`audit.py`

| sortie | avant | après |
|---|---|---|
```

Une section vide se remplit d'**une phrase qui dit qu'elle est vide et pourquoi**, jamais d'un tableau sans ligne : « aucun écart de justesse — les N lignes `datée` du domaine ont toutes été relevées le … et la carte ne dit rien de plus que son affirmation » se vérifie, « (vide) » ne se vérifie pas.

- [ ] **Step 9: Lancer les dix tests du contenu livré**

Run :

```bash
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl boot 'iPhone 17 Pro' 2>/dev/null || true
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  -only-testing:'ValidoTests/leContenuLivréEstValide()' \
  -only-testing:'ValidoTests/lesDeuxMatièresSontPrésentes()' \
  -only-testing:'ValidoTests/aucuneExplicationNeCommenceParUneLettreDeRéponse()' \
  -only-testing:'ValidoTests/chaqueQuestionAAuMoinsDeuxOptionsEtUneBonneRéponse()' \
  -only-testing:'ValidoTests/laBonneRéponseNeDépassePasLaDeuxièmePlusLongueDeDixCaractères()' \
  -only-testing:'ValidoTests/aucuneOptionNeCommenceParUneLettreDeRéponse()' \
  -only-testing:'ValidoTests/chaqueIllustrationRéférencéeExisteDansLeBundle()' \
  -only-testing:'ValidoTests/chaqueAltDécritVraimentLaScène()' \
  -only-testing:'ValidoTests/leBudgetDeHauteurDesQuestionsIllustréesEstTenu()' \
  -only-testing:'ValidoTests/laBanqueGardeSonVolumeIllustré()' 2>&1 | tail -30
```

Expected : `** TEST SUCCEEDED **` **et** la ligne `✔ Test run with 10 test(s)`. Sans la ligne de comptage, la réussite ne prouve rien. Si `Application failed preflight checks` / `Busy` sort sans qu'aucun test n'ait tourné, c'est le simulateur — changer de device via `DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl list devices available` — pas le contenu.

- [ ] **Step 10: Commit**

```bash
git add Valido/Resources/questions.json Tools/sources.md Tools/audit-2026-08-passe-3.md
git commit -m "$(cat <<'EOF'
Reread the « Mécanique & environnement » cards against what the registry records

<Une ligne par écart de justesse corrigé, avec son article et sa
version en vigueur. Puis ce que la réécriture a changé : les
explications qui renommaient la réponse disent maintenant la règle,
sa raison et sa limite. Puis les doutes laissés ouverts, et pourquoi
ils ne sont pas corrigés.>

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>
EOF
)"
```

Le corps se rédige à partir de la section du rapport : il dit **ce qui a bougé et pourquoi**, jamais « fix content ».

---

### Tâche 7 : domaine « Distances & freinage »

**Files:**
- Modify: `Valido/Resources/questions.json` — les 21 cartes `code` de `topic` « Distances & freinage »
- Modify: `Tools/sources.md` — les lignes dont l'`affirmation` change
- Create/Modify: `Tools/audit-2026-08-passe-3.md` — la section du domaine

**Interfaces:**
- Consumes: `python3 Tools/relire.py "Distances & freinage"` et `python3 Tools/relire.py --fuites "Distances & freinage"` (tâche 1).
- Produces: une section `## Distances & freinage` dans `Tools/audit-2026-08-passe-3.md`, au format fixé à l'étape 8, que la tâche 16 consolide sans le réécrire.

**Le lot.** 21 cartes : **10 `datée`**, 11 `stable`, **0 illustrée(s)**. Relevés du registre : 2026-08-25. **0** explication(s) sous 120 caractères ; **5** portant un absolu ou une obligation à confronter à l'affirmation.

| id (18 car., greppable) | nat. | énoncé | drapeaux |
|---|---|---|---|
| `0e85e6a79127a2bae7` | D | En tunnel, une seconde infraction à l'intervalle de sécuri… | — |
| `22e6420e179103f65f` | s | Vous sortez d'un tunnel par vent latéral. Vous : | — |
| `2362d0ebc53cb6de07` | s | Sur autoroute, l'intervalle de sécurité se repère au sol à… | — |
| `36d598b80e93b695b2` | s | Sur une chaussée enneigée ou verglacée, vous : | — |
| `37fe1af42b8d8104b1` | s | À 50 km/h, la distance parcourue pendant le temps de réact… | ABS jamais |
| `37fe1af42b8d811f99` | s | Pour estimer sa distance de réaction en mètres, on multipl… | — |
| `37fe1af42b8d812c9b` | s | Si vous doublez votre vitesse, votre distance de freinage … | — |
| `37fe1af42b8d812db5` | D | L'intervalle de sécurité à garder avec le véhicule qui pré… | — |
| `37fe1af42b8d815a8d` | D | À 130 km/h, l'intervalle de sécurité de 2 secondes représe… | — |
| `37fe1af42b8d817eb2` | s | La distance d'arrêt d'un véhicule se compose de : | — |
| `37fe1af42b8d81e48a` | s | Sur sol mouillé, les distances de freinage : | — |
| `37fe1af42b8d81e7a0` | D | Ne pas respecter les distances de sécurité est sanctionné … | — |
| `37fe1af42b8d81e98a` | s | Le temps de réaction moyen d'un conducteur est d'environ : | ABS jamais |
| `37fe1af42b8d81ef84` | D | La fatigue ou l'usage du téléphone au volant : | ABS interdit |
| `4ade42a7e2c69ec431` | s | En aquaplanage, la bonne réaction est de : | — |
| `8ddd0cebb28376040a` | D | Le code exprime la distance de sécurité en secondes plutôt… | — |
| `9f0fe6e809948a327c` | s | En freinage d'urgence, sur un véhicule à ABS, il faut : | — |
| `a225e45864e11748d6` | D | En vous insérant sur l'autoroute depuis une bretelle, vous… | ABS doit |
| `a4f04a8078a925fbc8` | D | Emprunter la bande d'arrêt d'urgence pour éviter un boucho… | ABS doit/interdite |
| `aad60a7453493cc671` | D | S'arrêter sur la bande d'arrêt d'urgence sans nécessité ab… | — |
| `f376d218b64a41796d` | D | Hors agglomération, deux camions qui se suivent à la même … | — |

`D` = `datée`, `s` = `stable`. `IMG` = illustrée, budget 70 / 50 / 220. `COURTE` = explication sous 120 caractères, candidate n° 1 du critère 3. `ABS` = absolu ou obligation dans l'explication, à confronter à l'affirmation (écart « règle trop large »). **Un drapeau est une piste, pas un verdict, et son absence n'est pas un quitus : les cartes sans drapeau se relisent aussi.**

- [ ] **Step 1: Relever l'état d'avant, pour pouvoir prouver le mouvement**

Run :

```bash
mkdir -p .passe3 && python3 Tools/audit.py > .passe3/avant-07.txt
grep -E '^### ' .passe3/avant-07.txt
python3 - <<'EOF'
import json, statistics
qs = json.load(open('Valido/Resources/questions.json'))
lot = [q for q in qs if q['subject'] == 'code' and q['topic'] == 'Distances & freinage']
el = [len(q['explanation']) for q in lot]
print(len(lot), 'cartes | expl médiane', statistics.median(el),
      '| sous 120 :', sum(1 for x in el if x < 120),
      '| illustrées :', sum(1 for q in lot if q.get('illustration')))
EOF
```

Expected : la ligne de base des Global Constraints, puis `21 cartes … sous 120 : 0 … illustrées : 0`.

- [ ] **Step 2: Lire les 21 cartes à côté de leur ligne de registre**

Run :

```bash
python3 Tools/relire.py "Distances & freinage" > .passe3/lot-07.txt
less .passe3/lot-07.txt
```

Lire **la ligne avant la carte**. L'`affirmation` est la référence ; la carte est ce qu'on vérifie contre elle. **Ne rien éditer à cette étape** : lire tout le domaine d'abord, pour que les cartes se corrigent les unes par les autres — deux cartes voisines qui se contredisent (cas n° 8 du §9.5 de la passe 2, « deux verres » contre « deux ou trois verres ») ne se voient qu'en lisant le lot entier.

- [ ] **Step 3: Marquer les trois écarts de justesse**

Pour chaque carte, dans l'ordre du tableau des Global Constraints : **valeur périmée**, puis **règle trop large**, puis **explication au-delà de l'article**. Consigner dans `.passe3/ecarts-07.md` une ligne par écart — `id`, écart, ce que dit la carte, ce que dit l'affirmation, correction envisagée.

**Rouvrir une source dans un seul cas** : la carte affirme quelque chose que l'affirmation ne couvre pas **et** qui n'est pas manifestement faux. Lire alors l'**article consolidé** (Legifrance, ligne « Version en vigueur depuis le … »), jamais une page de synthèse seule : le « Vérifié le » de `service-public` date la lecture, pas la valeur, et `securite-routiere.gouv.fr` ne fait jamais autorité seul sur un chiffre. Liste blanche, et rien d'autre : `legifrance.gouv.fr`, `securite-routiere.gouv.fr`, `service-public.gouv.fr`, `ecologie.gouv.fr`, `sante.gouv.fr`, `unece.org`, `eur-lex.europa.eu`, `cprguidelines.eu`, `erc.edu`, `croix-rouge.fr`, `inrs.fr`.

- [ ] **Step 4: Corriger la justesse dans `Valido/Resources/questions.json`**

Appliquer les corrections de l'étape 3. Quand la valeur périmée était la bonne réponse, **elle devient un distracteur** : c'est exactement ce qu'un candidat aura lu ailleurs. Ne toucher à aucun `id`.

- [ ] **Step 5: Réécrire pour qui découvre la règle**

Les quatre critères des Global Constraints, sur les trois champs. Commencer par les 0 explication(s) sous 120 caractères (aucune ici : le domaine part d'explications déjà étoffées, le gain est sur l'énoncé et les options). Aucune carte illustrée : le budget de 220 ne contraint pas ce domaine.

- [ ] **Step 6: Renormaliser le fichier et prouver qu'aucun `id` n'a bougé**

Run :

```bash
python3 - <<'EOF'
import json
p = 'Valido/Resources/questions.json'
d = json.load(open(p))
with open(p, 'w', encoding='utf-8') as f:
    json.dump(d, f, ensure_ascii=False, indent=2, sort_keys=True)
    f.write('\n')
print(len(d), 'questions')
EOF
python3 - <<'EOF'
import json, subprocess
avant = json.loads(subprocess.run(
    ['git', 'show', 'HEAD:Valido/Resources/questions.json'],
    capture_output=True, text=True).stdout)
apres = json.load(open('Valido/Resources/questions.json'))
a = [q['id'] for q in avant]
b = [q['id'] for q in apres]
print('mêmes ids :', sorted(a) == sorted(b), '|', len(a), '->', len(b))
print('ajoutés :', sorted(set(b) - set(a)), '| retirés :', sorted(set(a) - set(b)))
EOF
```

Expected : `448 questions`, `mêmes ids : True | 448 -> 448`, et deux listes vides.

- [ ] **Step 7: Chercher les fuites introduites, puis repasser `audit.py`**

Run :

```bash
python3 Tools/relire.py --fuites "Distances & freinage" | tail -40
python3 Tools/audit.py > .passe3/apres-07.txt
diff <(grep -E '^### ' .passe3/avant-07.txt) <(grep -E '^### ' .passe3/apres-07.txt) || true
```

Expected : `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10` et `forme/backtick-isole` **absents** du rapport d'après. **Une sortie qui passe de vide à non vide est un échec de la tâche** : corriger dans les données avant de continuer. `expl/paraphrase-litterale` doit avoir baissé si le domaine en portait. Chaque recouvrement listé par `--fuites` se relit à la main — un mot commun est normal, la réponse entière ne l'est pas.

- [ ] **Step 8: Reporter dans `Tools/sources.md`, puis écrire la section du rapport**

Dans `Tools/sources.md` : pour chaque ligne dont ce qui est affirmé a changé, réécrire la colonne `affirmation` et porter `relevé le` à la date de la lecture. Un changement de `nature` se justifie dans la colonne. **Ne pas toucher aux lignes inchangées.**

Dans `Tools/audit-2026-08-passe-3.md`, ajouter :

```markdown
## Distances & freinage

21 cartes, 10 `datée`, 0 illustrée(s).

### Écarts de justesse trouvés

| id | écart | ce que disait la carte | ce que dit l'article | correction |
|---|---|---|---|---|

### Doutes signalés, non corrigés

| id | ce qui est douteux | ce qui a été lu | ce qui manque |
|---|---|---|---|

### Pédagogie

- explications sous 120 caractères : 0 à l'entrée, N à la sortie
- cartes dont le budget de 220 a limité l'explication : …
- énoncés reformulés parce qu'ils présupposaient la règle : …

### Mouvements d'`audit.py`

| sortie | avant | après |
|---|---|---|
```

Une section vide se remplit d'**une phrase qui dit qu'elle est vide et pourquoi**, jamais d'un tableau sans ligne : « aucun écart de justesse — les N lignes `datée` du domaine ont toutes été relevées le … et la carte ne dit rien de plus que son affirmation » se vérifie, « (vide) » ne se vérifie pas.

- [ ] **Step 9: Lancer les dix tests du contenu livré**

Run :

```bash
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl boot 'iPhone 17 Pro' 2>/dev/null || true
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  -only-testing:'ValidoTests/leContenuLivréEstValide()' \
  -only-testing:'ValidoTests/lesDeuxMatièresSontPrésentes()' \
  -only-testing:'ValidoTests/aucuneExplicationNeCommenceParUneLettreDeRéponse()' \
  -only-testing:'ValidoTests/chaqueQuestionAAuMoinsDeuxOptionsEtUneBonneRéponse()' \
  -only-testing:'ValidoTests/laBonneRéponseNeDépassePasLaDeuxièmePlusLongueDeDixCaractères()' \
  -only-testing:'ValidoTests/aucuneOptionNeCommenceParUneLettreDeRéponse()' \
  -only-testing:'ValidoTests/chaqueIllustrationRéférencéeExisteDansLeBundle()' \
  -only-testing:'ValidoTests/chaqueAltDécritVraimentLaScène()' \
  -only-testing:'ValidoTests/leBudgetDeHauteurDesQuestionsIllustréesEstTenu()' \
  -only-testing:'ValidoTests/laBanqueGardeSonVolumeIllustré()' 2>&1 | tail -30
```

Expected : `** TEST SUCCEEDED **` **et** la ligne `✔ Test run with 10 test(s)`. Sans la ligne de comptage, la réussite ne prouve rien. Si `Application failed preflight checks` / `Busy` sort sans qu'aucun test n'ait tourné, c'est le simulateur — changer de device via `DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl list devices available` — pas le contenu.

- [ ] **Step 10: Commit**

```bash
git add Valido/Resources/questions.json Tools/sources.md Tools/audit-2026-08-passe-3.md
git commit -m "$(cat <<'EOF'
Reread the « Distances & freinage » cards against what the registry records

<Une ligne par écart de justesse corrigé, avec son article et sa
version en vigueur. Puis ce que la réécriture a changé : les
explications qui renommaient la réponse disent maintenant la règle,
sa raison et sa limite. Puis les doutes laissés ouverts, et pourquoi
ils ne sont pas corrigés.>

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>
EOF
)"
```

Le corps se rédige à partir de la section du rapport : il dit **ce qui a bougé et pourquoi**, jamais « fix content ».

---

### Tâche 8 : domaine « Arrêt & stationnement »

**Files:**
- Modify: `Valido/Resources/questions.json` — les 17 cartes `code` de `topic` « Arrêt & stationnement »
- Modify: `Tools/sources.md` — les lignes dont l'`affirmation` change
- Create/Modify: `Tools/audit-2026-08-passe-3.md` — la section du domaine

**Interfaces:**
- Consumes: `python3 Tools/relire.py "Arrêt & stationnement"` et `python3 Tools/relire.py --fuites "Arrêt & stationnement"` (tâche 1).
- Produces: une section `## Arrêt & stationnement` dans `Tools/audit-2026-08-passe-3.md`, au format fixé à l'étape 8, que la tâche 16 consolide sans le réécrire.

**Le lot.** 17 cartes : **10 `datée`**, 7 `stable`, **3 illustrée(s)** (explications à 196, 202, 215 caractères sur 220). Relevés du registre : 2026-08-25. **3** explication(s) sous 120 caractères ; **3** portant un absolu ou une obligation à confronter à l'affirmation.

| id (18 car., greppable) | nat. | énoncé | drapeaux |
|---|---|---|---|
| `0a4e98c4605ec20320` | s | Ce marquage interdit : | IMG expl 215/220 |
| `639297cf3f0f433daf` | s | Ces emplacements imposent un stationnement : | IMG expl 202/220 |
| `a2673bae092f3eaf43` | s | Le long de ce trottoir, le marquage interdit : | IMG expl 196/220 |
| `37fe1af42b8d811198` | D | Le stationnement dangereux (135 € et 3 points) se rencontr… | ABS aucun |
| `37fe1af42b8d811b96` | s | En agglomération, sur une chaussée à double sens, on stati… | — |
| `37fe1af42b8d812cad` | s | L'arrêt se distingue du stationnement par : | COURTE 109 |
| `37fe1af42b8d8134ad` | D | Stationner sur un passage piéton est : | — |
| `37fe1af42b8d8148bc` | s | Hors agglomération, pour vous arrêter vous devez de préfér… | COURTE 59 |
| `37fe1af42b8d816684` | D | En zone bleue, vous devez : | — |
| `37fe1af42b8d8181a0` | D | Un stationnement gênant (non « très gênant ») est sanction… | — |
| `37fe1af42b8d81d793` | D | S'arrêter ou stationner sur une voie réservée aux bus est … | ABS jamais |
| `37fe1af42b8d81e2b8` | s | Avant de quitter votre place de stationnement, vous devez … | COURTE 86 |
| `37fe1af42b8d81e9b3` | D | Le stationnement est considéré comme abusif au-delà de : | — |
| `5139c357024d2a17c4` | D | Le stationnement unilatéral alterné institué par un maire … | ABS impose |
| `ab50f861852232a60c` | D | L'interdiction d'ouvrir une portière dangereusement vise : | — |
| `c5d4d52f1aaa89b811` | D | Devant une bouche d'incendie, l'amende de stationnement es… | — |
| `e6d0b1101f0ac46d63` | D | Aux abords d'un passage piéton, l'arrêt et le stationnemen… | — |

`D` = `datée`, `s` = `stable`. `IMG` = illustrée, budget 70 / 50 / 220. `COURTE` = explication sous 120 caractères, candidate n° 1 du critère 3. `ABS` = absolu ou obligation dans l'explication, à confronter à l'affirmation (écart « règle trop large »). **Un drapeau est une piste, pas un verdict, et son absence n'est pas un quitus : les cartes sans drapeau se relisent aussi.**

- [ ] **Step 1: Relever l'état d'avant, pour pouvoir prouver le mouvement**

Run :

```bash
mkdir -p .passe3 && python3 Tools/audit.py > .passe3/avant-08.txt
grep -E '^### ' .passe3/avant-08.txt
python3 - <<'EOF'
import json, statistics
qs = json.load(open('Valido/Resources/questions.json'))
lot = [q for q in qs if q['subject'] == 'code' and q['topic'] == 'Arrêt & stationnement']
el = [len(q['explanation']) for q in lot]
print(len(lot), 'cartes | expl médiane', statistics.median(el),
      '| sous 120 :', sum(1 for x in el if x < 120),
      '| illustrées :', sum(1 for q in lot if q.get('illustration')))
EOF
```

Expected : la ligne de base des Global Constraints, puis `17 cartes … sous 120 : 3 … illustrées : 3`.

- [ ] **Step 2: Lire les 17 cartes à côté de leur ligne de registre**

Run :

```bash
python3 Tools/relire.py "Arrêt & stationnement" > .passe3/lot-08.txt
less .passe3/lot-08.txt
```

Lire **la ligne avant la carte**. L'`affirmation` est la référence ; la carte est ce qu'on vérifie contre elle. **Ne rien éditer à cette étape** : lire tout le domaine d'abord, pour que les cartes se corrigent les unes par les autres — deux cartes voisines qui se contredisent (cas n° 8 du §9.5 de la passe 2, « deux verres » contre « deux ou trois verres ») ne se voient qu'en lisant le lot entier.

- [ ] **Step 3: Marquer les trois écarts de justesse**

Pour chaque carte, dans l'ordre du tableau des Global Constraints : **valeur périmée**, puis **règle trop large**, puis **explication au-delà de l'article**. Consigner dans `.passe3/ecarts-08.md` une ligne par écart — `id`, écart, ce que dit la carte, ce que dit l'affirmation, correction envisagée.

**Rouvrir une source dans un seul cas** : la carte affirme quelque chose que l'affirmation ne couvre pas **et** qui n'est pas manifestement faux. Lire alors l'**article consolidé** (Legifrance, ligne « Version en vigueur depuis le … »), jamais une page de synthèse seule : le « Vérifié le » de `service-public` date la lecture, pas la valeur, et `securite-routiere.gouv.fr` ne fait jamais autorité seul sur un chiffre. Liste blanche, et rien d'autre : `legifrance.gouv.fr`, `securite-routiere.gouv.fr`, `service-public.gouv.fr`, `ecologie.gouv.fr`, `sante.gouv.fr`, `unece.org`, `eur-lex.europa.eu`, `cprguidelines.eu`, `erc.edu`, `croix-rouge.fr`, `inrs.fr`.

- [ ] **Step 4: Corriger la justesse dans `Valido/Resources/questions.json`**

Appliquer les corrections de l'étape 3. Quand la valeur périmée était la bonne réponse, **elle devient un distracteur** : c'est exactement ce qu'un candidat aura lu ailleurs. Ne toucher à aucun `id`.

- [ ] **Step 5: Réécrire pour qui découvre la règle**

Les quatre critères des Global Constraints, sur les trois champs. Commencer par les 3 explication(s) sous 120 caractères. Sur les 3 carte(s) illustrée(s), le gain vient de la **coupe** : supprimer la reformulation de la bonne réponse libère la place des trois temps.

- [ ] **Step 6: Renormaliser le fichier et prouver qu'aucun `id` n'a bougé**

Run :

```bash
python3 - <<'EOF'
import json
p = 'Valido/Resources/questions.json'
d = json.load(open(p))
with open(p, 'w', encoding='utf-8') as f:
    json.dump(d, f, ensure_ascii=False, indent=2, sort_keys=True)
    f.write('\n')
print(len(d), 'questions')
EOF
python3 - <<'EOF'
import json, subprocess
avant = json.loads(subprocess.run(
    ['git', 'show', 'HEAD:Valido/Resources/questions.json'],
    capture_output=True, text=True).stdout)
apres = json.load(open('Valido/Resources/questions.json'))
a = [q['id'] for q in avant]
b = [q['id'] for q in apres]
print('mêmes ids :', sorted(a) == sorted(b), '|', len(a), '->', len(b))
print('ajoutés :', sorted(set(b) - set(a)), '| retirés :', sorted(set(a) - set(b)))
EOF
```

Expected : `448 questions`, `mêmes ids : True | 448 -> 448`, et deux listes vides.

- [ ] **Step 7: Chercher les fuites introduites, puis repasser `audit.py`**

Run :

```bash
python3 Tools/relire.py --fuites "Arrêt & stationnement" | tail -40
python3 Tools/audit.py > .passe3/apres-08.txt
diff <(grep -E '^### ' .passe3/avant-08.txt) <(grep -E '^### ' .passe3/apres-08.txt) || true
```

Expected : `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10` et `forme/backtick-isole` **absents** du rapport d'après. **Une sortie qui passe de vide à non vide est un échec de la tâche** : corriger dans les données avant de continuer. `expl/paraphrase-litterale` doit avoir baissé si le domaine en portait. Chaque recouvrement listé par `--fuites` se relit à la main — un mot commun est normal, la réponse entière ne l'est pas.

- [ ] **Step 8: Reporter dans `Tools/sources.md`, puis écrire la section du rapport**

Dans `Tools/sources.md` : pour chaque ligne dont ce qui est affirmé a changé, réécrire la colonne `affirmation` et porter `relevé le` à la date de la lecture. Un changement de `nature` se justifie dans la colonne. **Ne pas toucher aux lignes inchangées.**

Dans `Tools/audit-2026-08-passe-3.md`, ajouter :

```markdown
## Arrêt & stationnement

17 cartes, 10 `datée`, 3 illustrée(s).

### Écarts de justesse trouvés

| id | écart | ce que disait la carte | ce que dit l'article | correction |
|---|---|---|---|---|

### Doutes signalés, non corrigés

| id | ce qui est douteux | ce qui a été lu | ce qui manque |
|---|---|---|---|

### Pédagogie

- explications sous 120 caractères : 3 à l'entrée, N à la sortie
- cartes dont le budget de 220 a limité l'explication : …
- énoncés reformulés parce qu'ils présupposaient la règle : …

### Mouvements d'`audit.py`

| sortie | avant | après |
|---|---|---|
```

Une section vide se remplit d'**une phrase qui dit qu'elle est vide et pourquoi**, jamais d'un tableau sans ligne : « aucun écart de justesse — les N lignes `datée` du domaine ont toutes été relevées le … et la carte ne dit rien de plus que son affirmation » se vérifie, « (vide) » ne se vérifie pas.

- [ ] **Step 9: Lancer les dix tests du contenu livré**

Run :

```bash
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl boot 'iPhone 17 Pro' 2>/dev/null || true
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  -only-testing:'ValidoTests/leContenuLivréEstValide()' \
  -only-testing:'ValidoTests/lesDeuxMatièresSontPrésentes()' \
  -only-testing:'ValidoTests/aucuneExplicationNeCommenceParUneLettreDeRéponse()' \
  -only-testing:'ValidoTests/chaqueQuestionAAuMoinsDeuxOptionsEtUneBonneRéponse()' \
  -only-testing:'ValidoTests/laBonneRéponseNeDépassePasLaDeuxièmePlusLongueDeDixCaractères()' \
  -only-testing:'ValidoTests/aucuneOptionNeCommenceParUneLettreDeRéponse()' \
  -only-testing:'ValidoTests/chaqueIllustrationRéférencéeExisteDansLeBundle()' \
  -only-testing:'ValidoTests/chaqueAltDécritVraimentLaScène()' \
  -only-testing:'ValidoTests/leBudgetDeHauteurDesQuestionsIllustréesEstTenu()' \
  -only-testing:'ValidoTests/laBanqueGardeSonVolumeIllustré()' 2>&1 | tail -30
```

Expected : `** TEST SUCCEEDED **` **et** la ligne `✔ Test run with 10 test(s)`. Sans la ligne de comptage, la réussite ne prouve rien. Si `Application failed preflight checks` / `Busy` sort sans qu'aucun test n'ait tourné, c'est le simulateur — changer de device via `DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl list devices available` — pas le contenu.

- [ ] **Step 10: Commit**

```bash
git add Valido/Resources/questions.json Tools/sources.md Tools/audit-2026-08-passe-3.md
git commit -m "$(cat <<'EOF'
Reread the « Arrêt & stationnement » cards against what the registry records

<Une ligne par écart de justesse corrigé, avec son article et sa
version en vigueur. Puis ce que la réécriture a changé : les
explications qui renommaient la réponse disent maintenant la règle,
sa raison et sa limite. Puis les doutes laissés ouverts, et pourquoi
ils ne sont pas corrigés.>

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>
EOF
)"
```

Le corps se rédige à partir de la section du rapport : il dit **ce qui a bougé et pourquoi**, jamais « fix content ».

---

### Tâche 9 : domaine « Premiers secours »

**Files:**
- Modify: `Valido/Resources/questions.json` — les 18 cartes `code` de `topic` « Premiers secours »
- Modify: `Tools/sources.md` — les lignes dont l'`affirmation` change
- Create/Modify: `Tools/audit-2026-08-passe-3.md` — la section du domaine

**Interfaces:**
- Consumes: `python3 Tools/relire.py "Premiers secours"` et `python3 Tools/relire.py --fuites "Premiers secours"` (tâche 1).
- Produces: une section `## Premiers secours` dans `Tools/audit-2026-08-passe-3.md`, au format fixé à l'étape 8, que la tâche 16 consolide sans le réécrire.

**Le lot.** 18 cartes : **9 `datée`**, 9 `stable`, **0 illustrée(s)**. Relevés du registre : 2026-08-25. **4** explication(s) sous 120 caractères ; **2** portant un absolu ou une obligation à confronter à l'affirmation.

| id (18 car., greppable) | nat. | énoncé | drapeaux |
|---|---|---|---|
| `1ef7d3ed540293c212` | D | Le premier geste face à une brûlure est de : | — |
| `37fe1af42b8d810ca6` | D | Le numéro d'appel d'urgence européen est le : | — |
| `37fe1af42b8d8122b0` | D | Le numéro des sapeurs-pompiers est le : | — |
| `37fe1af42b8d814182` | s | En cas d'hémorragie abondante, il faut : | — |
| `37fe1af42b8d8175a7` | s | Une victime ne doit être déplacée que : | COURTE 91 |
| `37fe1af42b8d817b90` | D | Le triangle de présignalisation se place : | — |
| `37fe1af42b8d817bb1` | s | Lorsque vous alertez les secours, vous devez indiquer : | COURTE 90; ABS jamais |
| `37fe1af42b8d81a092` | s | Face à un motard accidenté, son casque : | COURTE 86 |
| `37fe1af42b8d81b592` | s | Une victime inconsciente qui respire doit être mise : | — |
| `37fe1af42b8d81f1b1` | s | Face à un accident, la règle de conduite à suivre est : | — |
| `37fe1af42b8d81f7a2` | s | Pour protéger une zone d'accident, vous devez : | COURTE 90 |
| `5e2dbc048917ecebcc` | s | Pour masser une victime en arrêt cardiaque, on l'installe … | — |
| `5fe77bbd3af80ab119` | s | Premier sur un accident, seul, face à une victime conscien… | — |
| `7d456e77187812e3a2` | D | Face à une victime inconsciente qui ne respire plus, l'ord… | — |
| `82a9e65c1cf2ff4a1a` | D | Sur un adulte, chaque compression thoracique enfonce le st… | ABS doit |
| `b9e656cbd350744466` | D | Un défibrillateur automatisé externe peut être utilisé : | — |
| `d724a3c3121fafd733` | D | Quand le sauveteur pratique aussi le bouche-à-bouche, il a… | — |
| `fb24f6323a07a07c77` | D | Le massage cardiaque s'effectue à une cadence de : | — |

`D` = `datée`, `s` = `stable`. `IMG` = illustrée, budget 70 / 50 / 220. `COURTE` = explication sous 120 caractères, candidate n° 1 du critère 3. `ABS` = absolu ou obligation dans l'explication, à confronter à l'affirmation (écart « règle trop large »). **Un drapeau est une piste, pas un verdict, et son absence n'est pas un quitus : les cartes sans drapeau se relisent aussi.**

- [ ] **Step 1: Relever l'état d'avant, pour pouvoir prouver le mouvement**

Run :

```bash
mkdir -p .passe3 && python3 Tools/audit.py > .passe3/avant-09.txt
grep -E '^### ' .passe3/avant-09.txt
python3 - <<'EOF'
import json, statistics
qs = json.load(open('Valido/Resources/questions.json'))
lot = [q for q in qs if q['subject'] == 'code' and q['topic'] == 'Premiers secours']
el = [len(q['explanation']) for q in lot]
print(len(lot), 'cartes | expl médiane', statistics.median(el),
      '| sous 120 :', sum(1 for x in el if x < 120),
      '| illustrées :', sum(1 for q in lot if q.get('illustration')))
EOF
```

Expected : la ligne de base des Global Constraints, puis `18 cartes … sous 120 : 4 … illustrées : 0`.

- [ ] **Step 2: Lire les 18 cartes à côté de leur ligne de registre**

Run :

```bash
python3 Tools/relire.py "Premiers secours" > .passe3/lot-09.txt
less .passe3/lot-09.txt
```

Lire **la ligne avant la carte**. L'`affirmation` est la référence ; la carte est ce qu'on vérifie contre elle. **Ne rien éditer à cette étape** : lire tout le domaine d'abord, pour que les cartes se corrigent les unes par les autres — deux cartes voisines qui se contredisent (cas n° 8 du §9.5 de la passe 2, « deux verres » contre « deux ou trois verres ») ne se voient qu'en lisant le lot entier.

- [ ] **Step 3: Marquer les trois écarts de justesse**

Pour chaque carte, dans l'ordre du tableau des Global Constraints : **valeur périmée**, puis **règle trop large**, puis **explication au-delà de l'article**. Consigner dans `.passe3/ecarts-09.md` une ligne par écart — `id`, écart, ce que dit la carte, ce que dit l'affirmation, correction envisagée.

**Rouvrir une source dans un seul cas** : la carte affirme quelque chose que l'affirmation ne couvre pas **et** qui n'est pas manifestement faux. Lire alors l'**article consolidé** (Legifrance, ligne « Version en vigueur depuis le … »), jamais une page de synthèse seule : le « Vérifié le » de `service-public` date la lecture, pas la valeur, et `securite-routiere.gouv.fr` ne fait jamais autorité seul sur un chiffre. Liste blanche, et rien d'autre : `legifrance.gouv.fr`, `securite-routiere.gouv.fr`, `service-public.gouv.fr`, `ecologie.gouv.fr`, `sante.gouv.fr`, `unece.org`, `eur-lex.europa.eu`, `cprguidelines.eu`, `erc.edu`, `croix-rouge.fr`, `inrs.fr`.

- [ ] **Step 4: Corriger la justesse dans `Valido/Resources/questions.json`**

Appliquer les corrections de l'étape 3. Quand la valeur périmée était la bonne réponse, **elle devient un distracteur** : c'est exactement ce qu'un candidat aura lu ailleurs. Ne toucher à aucun `id`.

- [ ] **Step 5: Réécrire pour qui découvre la règle**

Les quatre critères des Global Constraints, sur les trois champs. Commencer par les 4 explication(s) sous 120 caractères. Aucune carte illustrée : le budget de 220 ne contraint pas ce domaine.

- [ ] **Step 6: Renormaliser le fichier et prouver qu'aucun `id` n'a bougé**

Run :

```bash
python3 - <<'EOF'
import json
p = 'Valido/Resources/questions.json'
d = json.load(open(p))
with open(p, 'w', encoding='utf-8') as f:
    json.dump(d, f, ensure_ascii=False, indent=2, sort_keys=True)
    f.write('\n')
print(len(d), 'questions')
EOF
python3 - <<'EOF'
import json, subprocess
avant = json.loads(subprocess.run(
    ['git', 'show', 'HEAD:Valido/Resources/questions.json'],
    capture_output=True, text=True).stdout)
apres = json.load(open('Valido/Resources/questions.json'))
a = [q['id'] for q in avant]
b = [q['id'] for q in apres]
print('mêmes ids :', sorted(a) == sorted(b), '|', len(a), '->', len(b))
print('ajoutés :', sorted(set(b) - set(a)), '| retirés :', sorted(set(a) - set(b)))
EOF
```

Expected : `448 questions`, `mêmes ids : True | 448 -> 448`, et deux listes vides.

- [ ] **Step 7: Chercher les fuites introduites, puis repasser `audit.py`**

Run :

```bash
python3 Tools/relire.py --fuites "Premiers secours" | tail -40
python3 Tools/audit.py > .passe3/apres-09.txt
diff <(grep -E '^### ' .passe3/avant-09.txt) <(grep -E '^### ' .passe3/apres-09.txt) || true
```

Expected : `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10` et `forme/backtick-isole` **absents** du rapport d'après. **Une sortie qui passe de vide à non vide est un échec de la tâche** : corriger dans les données avant de continuer. `expl/paraphrase-litterale` doit avoir baissé si le domaine en portait. Chaque recouvrement listé par `--fuites` se relit à la main — un mot commun est normal, la réponse entière ne l'est pas.

- [ ] **Step 8: Reporter dans `Tools/sources.md`, puis écrire la section du rapport**

Dans `Tools/sources.md` : pour chaque ligne dont ce qui est affirmé a changé, réécrire la colonne `affirmation` et porter `relevé le` à la date de la lecture. Un changement de `nature` se justifie dans la colonne. **Ne pas toucher aux lignes inchangées.**

Dans `Tools/audit-2026-08-passe-3.md`, ajouter :

```markdown
## Premiers secours

18 cartes, 9 `datée`, 0 illustrée(s).

### Écarts de justesse trouvés

| id | écart | ce que disait la carte | ce que dit l'article | correction |
|---|---|---|---|---|

### Doutes signalés, non corrigés

| id | ce qui est douteux | ce qui a été lu | ce qui manque |
|---|---|---|---|

### Pédagogie

- explications sous 120 caractères : 4 à l'entrée, N à la sortie
- cartes dont le budget de 220 a limité l'explication : …
- énoncés reformulés parce qu'ils présupposaient la règle : …

### Mouvements d'`audit.py`

| sortie | avant | après |
|---|---|---|
```

Une section vide se remplit d'**une phrase qui dit qu'elle est vide et pourquoi**, jamais d'un tableau sans ligne : « aucun écart de justesse — les N lignes `datée` du domaine ont toutes été relevées le … et la carte ne dit rien de plus que son affirmation » se vérifie, « (vide) » ne se vérifie pas.

- [ ] **Step 9: Lancer les dix tests du contenu livré**

Run :

```bash
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl boot 'iPhone 17 Pro' 2>/dev/null || true
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  -only-testing:'ValidoTests/leContenuLivréEstValide()' \
  -only-testing:'ValidoTests/lesDeuxMatièresSontPrésentes()' \
  -only-testing:'ValidoTests/aucuneExplicationNeCommenceParUneLettreDeRéponse()' \
  -only-testing:'ValidoTests/chaqueQuestionAAuMoinsDeuxOptionsEtUneBonneRéponse()' \
  -only-testing:'ValidoTests/laBonneRéponseNeDépassePasLaDeuxièmePlusLongueDeDixCaractères()' \
  -only-testing:'ValidoTests/aucuneOptionNeCommenceParUneLettreDeRéponse()' \
  -only-testing:'ValidoTests/chaqueIllustrationRéférencéeExisteDansLeBundle()' \
  -only-testing:'ValidoTests/chaqueAltDécritVraimentLaScène()' \
  -only-testing:'ValidoTests/leBudgetDeHauteurDesQuestionsIllustréesEstTenu()' \
  -only-testing:'ValidoTests/laBanqueGardeSonVolumeIllustré()' 2>&1 | tail -30
```

Expected : `** TEST SUCCEEDED **` **et** la ligne `✔ Test run with 10 test(s)`. Sans la ligne de comptage, la réussite ne prouve rien. Si `Application failed preflight checks` / `Busy` sort sans qu'aucun test n'ait tourné, c'est le simulateur — changer de device via `DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl list devices available` — pas le contenu.

- [ ] **Step 10: Commit**

```bash
git add Valido/Resources/questions.json Tools/sources.md Tools/audit-2026-08-passe-3.md
git commit -m "$(cat <<'EOF'
Reread the « Premiers secours » cards against what the registry records

<Une ligne par écart de justesse corrigé, avec son article et sa
version en vigueur. Puis ce que la réécriture a changé : les
explications qui renommaient la réponse disent maintenant la règle,
sa raison et sa limite. Puis les doutes laissés ouverts, et pourquoi
ils ne sont pas corrigés.>

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>
EOF
)"
```

Le corps se rédige à partir de la section du rapport : il dit **ce qui a bougé et pourquoi**, jamais « fix content ».

---

### Tâche 10 : domaine « Tunnels & passages à niveau »

**Files:**
- Modify: `Valido/Resources/questions.json` — les 15 cartes `code` de `topic` « Tunnels & passages à niveau »
- Modify: `Tools/sources.md` — les lignes dont l'`affirmation` change
- Create/Modify: `Tools/audit-2026-08-passe-3.md` — la section du domaine

**Interfaces:**
- Consumes: `python3 Tools/relire.py "Tunnels & passages à niveau"` et `python3 Tools/relire.py --fuites "Tunnels & passages à niveau"` (tâche 1).
- Produces: une section `## Tunnels & passages à niveau` dans `Tools/audit-2026-08-passe-3.md`, au format fixé à l'étape 8, que la tâche 16 consolide sans le réécrire.

**Le lot.** 15 cartes : **8 `datée`**, 7 `stable`, **3 illustrée(s)** (explications à 205, 208, 212 caractères sur 220). Relevés du registre : 2026-08-26. **0** explication(s) sous 120 caractères ; **6** portant un absolu ou une obligation à confronter à l'affirmation.

| id (18 car., greppable) | nat. | énoncé | drapeaux |
|---|---|---|---|
| `1cc2591b8808d4aa73` | s | Cette balise vous annonce : | IMG expl 205/220 |
| `1e329fa1bba26cabf5` | D | Votre moteur cale ici. Vous devez d'abord : | IMG expl 212/220 |
| `d50cd498f6e5261eb5` | s | Les demi-barrières viennent de s'abaisser. Vous : | IMG expl 208/220 |
| `1fe6ef49aad916e076` | D | Franchir irrégulièrement un passage à niveau fait perdre : | — |
| `3a06288bf73bb5254b` | s | À l'entrée d'un tunnel, le panonceau sous le panneau indiq… | — |
| `5ae4a8d7800141787a` | D | Dans un tunnel, s'arrêter le long de la chaussée : | — |
| `5c11020dc34bf45d56` | D | Le panneau qui signale l'entrée d'un tunnel interdit notam… | ABS interdit/interdits |
| `7148c3a8be7130501a` | s | Un véhicule prend feu devant vous dans un tunnel. Vous dev… | — |
| `763ae1f8c7040ecb17` | s | Le franchissement d'un passage à niveau est interdit : | ABS interdit/jamais |
| `8a6af9d26330dc0f3b` | D | Sur un passage à niveau automatique, une pancarte porte : | — |
| `a88bdac8ef012091a9` | D | Dans un tunnel, l'intervalle de sécurité entre deux véhicu… | ABS aucun |
| `bda520451eb11447c3` | D | De jour, à l'entrée d'un tunnel éclairé, vos feux de crois… | ABS obligatoire |
| `c084813ff73eacb15d` | D | Les feux rouges clignotants d'un passage à niveau automati… | — |
| `d3af170839b4cf693c` | s | À un passage à niveau sans barrière ni feu, vous : | ABS aucun/jamais/obligatoire |
| `d4b4abfd51499d4ab3` | s | La circulation est arrêtée juste au-delà d'un passage à ni… | ABS aucun/doit |

`D` = `datée`, `s` = `stable`. `IMG` = illustrée, budget 70 / 50 / 220. `COURTE` = explication sous 120 caractères, candidate n° 1 du critère 3. `ABS` = absolu ou obligation dans l'explication, à confronter à l'affirmation (écart « règle trop large »). **Un drapeau est une piste, pas un verdict, et son absence n'est pas un quitus : les cartes sans drapeau se relisent aussi.**

- [ ] **Step 1: Relever l'état d'avant, pour pouvoir prouver le mouvement**

Run :

```bash
mkdir -p .passe3 && python3 Tools/audit.py > .passe3/avant-10.txt
grep -E '^### ' .passe3/avant-10.txt
python3 - <<'EOF'
import json, statistics
qs = json.load(open('Valido/Resources/questions.json'))
lot = [q for q in qs if q['subject'] == 'code' and q['topic'] == 'Tunnels & passages à niveau']
el = [len(q['explanation']) for q in lot]
print(len(lot), 'cartes | expl médiane', statistics.median(el),
      '| sous 120 :', sum(1 for x in el if x < 120),
      '| illustrées :', sum(1 for q in lot if q.get('illustration')))
EOF
```

Expected : la ligne de base des Global Constraints, puis `15 cartes … sous 120 : 0 … illustrées : 3`.

- [ ] **Step 2: Lire les 15 cartes à côté de leur ligne de registre**

Run :

```bash
python3 Tools/relire.py "Tunnels & passages à niveau" > .passe3/lot-10.txt
less .passe3/lot-10.txt
```

Lire **la ligne avant la carte**. L'`affirmation` est la référence ; la carte est ce qu'on vérifie contre elle. **Ne rien éditer à cette étape** : lire tout le domaine d'abord, pour que les cartes se corrigent les unes par les autres — deux cartes voisines qui se contredisent (cas n° 8 du §9.5 de la passe 2, « deux verres » contre « deux ou trois verres ») ne se voient qu'en lisant le lot entier.

- [ ] **Step 3: Marquer les trois écarts de justesse**

Pour chaque carte, dans l'ordre du tableau des Global Constraints : **valeur périmée**, puis **règle trop large**, puis **explication au-delà de l'article**. Consigner dans `.passe3/ecarts-10.md` une ligne par écart — `id`, écart, ce que dit la carte, ce que dit l'affirmation, correction envisagée.

**Rouvrir une source dans un seul cas** : la carte affirme quelque chose que l'affirmation ne couvre pas **et** qui n'est pas manifestement faux. Lire alors l'**article consolidé** (Legifrance, ligne « Version en vigueur depuis le … »), jamais une page de synthèse seule : le « Vérifié le » de `service-public` date la lecture, pas la valeur, et `securite-routiere.gouv.fr` ne fait jamais autorité seul sur un chiffre. Liste blanche, et rien d'autre : `legifrance.gouv.fr`, `securite-routiere.gouv.fr`, `service-public.gouv.fr`, `ecologie.gouv.fr`, `sante.gouv.fr`, `unece.org`, `eur-lex.europa.eu`, `cprguidelines.eu`, `erc.edu`, `croix-rouge.fr`, `inrs.fr`.

- [ ] **Step 4: Corriger la justesse dans `Valido/Resources/questions.json`**

Appliquer les corrections de l'étape 3. Quand la valeur périmée était la bonne réponse, **elle devient un distracteur** : c'est exactement ce qu'un candidat aura lu ailleurs. Ne toucher à aucun `id`.

- [ ] **Step 5: Réécrire pour qui découvre la règle**

Les quatre critères des Global Constraints, sur les trois champs. Commencer par les 0 explication(s) sous 120 caractères (aucune ici : le domaine part d'explications déjà étoffées, le gain est sur l'énoncé et les options). Sur les 3 carte(s) illustrée(s), le gain vient de la **coupe** : supprimer la reformulation de la bonne réponse libère la place des trois temps.

- [ ] **Step 6: Renormaliser le fichier et prouver qu'aucun `id` n'a bougé**

Run :

```bash
python3 - <<'EOF'
import json
p = 'Valido/Resources/questions.json'
d = json.load(open(p))
with open(p, 'w', encoding='utf-8') as f:
    json.dump(d, f, ensure_ascii=False, indent=2, sort_keys=True)
    f.write('\n')
print(len(d), 'questions')
EOF
python3 - <<'EOF'
import json, subprocess
avant = json.loads(subprocess.run(
    ['git', 'show', 'HEAD:Valido/Resources/questions.json'],
    capture_output=True, text=True).stdout)
apres = json.load(open('Valido/Resources/questions.json'))
a = [q['id'] for q in avant]
b = [q['id'] for q in apres]
print('mêmes ids :', sorted(a) == sorted(b), '|', len(a), '->', len(b))
print('ajoutés :', sorted(set(b) - set(a)), '| retirés :', sorted(set(a) - set(b)))
EOF
```

Expected : `448 questions`, `mêmes ids : True | 448 -> 448`, et deux listes vides.

- [ ] **Step 7: Chercher les fuites introduites, puis repasser `audit.py`**

Run :

```bash
python3 Tools/relire.py --fuites "Tunnels & passages à niveau" | tail -40
python3 Tools/audit.py > .passe3/apres-10.txt
diff <(grep -E '^### ' .passe3/avant-10.txt) <(grep -E '^### ' .passe3/apres-10.txt) || true
```

Expected : `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10` et `forme/backtick-isole` **absents** du rapport d'après. **Une sortie qui passe de vide à non vide est un échec de la tâche** : corriger dans les données avant de continuer. `expl/paraphrase-litterale` doit avoir baissé si le domaine en portait. Chaque recouvrement listé par `--fuites` se relit à la main — un mot commun est normal, la réponse entière ne l'est pas.

- [ ] **Step 8: Reporter dans `Tools/sources.md`, puis écrire la section du rapport**

Dans `Tools/sources.md` : pour chaque ligne dont ce qui est affirmé a changé, réécrire la colonne `affirmation` et porter `relevé le` à la date de la lecture. Un changement de `nature` se justifie dans la colonne. **Ne pas toucher aux lignes inchangées.**

Dans `Tools/audit-2026-08-passe-3.md`, ajouter :

```markdown
## Tunnels & passages à niveau

15 cartes, 8 `datée`, 3 illustrée(s).

### Écarts de justesse trouvés

| id | écart | ce que disait la carte | ce que dit l'article | correction |
|---|---|---|---|---|

### Doutes signalés, non corrigés

| id | ce qui est douteux | ce qui a été lu | ce qui manque |
|---|---|---|---|

### Pédagogie

- explications sous 120 caractères : 0 à l'entrée, N à la sortie
- cartes dont le budget de 220 a limité l'explication : …
- énoncés reformulés parce qu'ils présupposaient la règle : …

### Mouvements d'`audit.py`

| sortie | avant | après |
|---|---|---|
```

Une section vide se remplit d'**une phrase qui dit qu'elle est vide et pourquoi**, jamais d'un tableau sans ligne : « aucun écart de justesse — les N lignes `datée` du domaine ont toutes été relevées le … et la carte ne dit rien de plus que son affirmation » se vérifie, « (vide) » ne se vérifie pas.

- [ ] **Step 9: Lancer les dix tests du contenu livré**

Run :

```bash
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl boot 'iPhone 17 Pro' 2>/dev/null || true
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  -only-testing:'ValidoTests/leContenuLivréEstValide()' \
  -only-testing:'ValidoTests/lesDeuxMatièresSontPrésentes()' \
  -only-testing:'ValidoTests/aucuneExplicationNeCommenceParUneLettreDeRéponse()' \
  -only-testing:'ValidoTests/chaqueQuestionAAuMoinsDeuxOptionsEtUneBonneRéponse()' \
  -only-testing:'ValidoTests/laBonneRéponseNeDépassePasLaDeuxièmePlusLongueDeDixCaractères()' \
  -only-testing:'ValidoTests/aucuneOptionNeCommenceParUneLettreDeRéponse()' \
  -only-testing:'ValidoTests/chaqueIllustrationRéférencéeExisteDansLeBundle()' \
  -only-testing:'ValidoTests/chaqueAltDécritVraimentLaScène()' \
  -only-testing:'ValidoTests/leBudgetDeHauteurDesQuestionsIllustréesEstTenu()' \
  -only-testing:'ValidoTests/laBanqueGardeSonVolumeIllustré()' 2>&1 | tail -30
```

Expected : `** TEST SUCCEEDED **` **et** la ligne `✔ Test run with 10 test(s)`. Sans la ligne de comptage, la réussite ne prouve rien. Si `Application failed preflight checks` / `Busy` sort sans qu'aucun test n'ait tourné, c'est le simulateur — changer de device via `DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl list devices available` — pas le contenu.

- [ ] **Step 10: Commit**

```bash
git add Valido/Resources/questions.json Tools/sources.md Tools/audit-2026-08-passe-3.md
git commit -m "$(cat <<'EOF'
Reread the « Tunnels & passages à niveau » cards against what the registry records

<Une ligne par écart de justesse corrigé, avec son article et sa
version en vigueur. Puis ce que la réécriture a changé : les
explications qui renommaient la réponse disent maintenant la règle,
sa raison et sa limite. Puis les doutes laissés ouverts, et pourquoi
ils ne sont pas corrigés.>

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>
EOF
)"
```

Le corps se rédige à partir de la section du rapport : il dit **ce qui a bougé et pourquoi**, jamais « fix content ».

---

### Tâche 11 : domaine « Priorités & intersections »

**Files:**
- Modify: `Valido/Resources/questions.json` — les 26 cartes `code` de `topic` « Priorités & intersections »
- Modify: `Tools/sources.md` — les lignes dont l'`affirmation` change
- Create/Modify: `Tools/audit-2026-08-passe-3.md` — la section du domaine

**Interfaces:**
- Consumes: `python3 Tools/relire.py "Priorités & intersections"` et `python3 Tools/relire.py --fuites "Priorités & intersections"` (tâche 1).
- Produces: une section `## Priorités & intersections` dans `Tools/audit-2026-08-passe-3.md`, au format fixé à l'étape 8, que la tâche 16 consolide sans le réécrire.

**Le lot.** 26 cartes : **5 `datée`**, 21 `stable`, **8 illustrée(s)** (explications à 167, 191, 193, 200, 202, 207, 214, 219 caractères sur 220). Relevés du registre : 2026-08-24. **3** explication(s) sous 120 caractères ; **9** portant un absolu ou une obligation à confronter à l'affirmation.

| id (18 car., greppable) | nat. | énoncé | drapeaux |
|---|---|---|---|
| `3e5d97761594126d37` | s | Ces feux sont hors service. La règle qui reprend est : | IMG expl 193/220 |
| `43dc08f7c9ebc00497` | s | À ce panneau, vous devez : | IMG expl 191/220; ABS impose |
| `6e1a51d34b4b79e436` | s | Le croisement s'annonce difficile. Qui doit céder ? | IMG expl 202/220 |
| `8e9464777a61dba385` | s | Vous arrivez à ce carrefour. Qui passe en premier ? | IMG expl 219/220 |
| `dd4c58febe771b6f29` | s | Vous vous présentez à l'entrée. Qui passe en premier ? | IMG expl 167/220; ABS impose/toujours |
| `e93ca4d156de5854ea` | s | Vous vous insérez sur la route qui traverse. Qui passe en … | IMG expl 200/220; ABS aucune |
| `ef4cfd171e0e9911a2` | s | À ce carrefour, qui passe en premier ? | IMG expl 207/220 |
| `f255331d3f234810a4` | s | Qui passe en premier ? | IMG expl 214/220; ABS aucun/doit |
| `02f7d6a65856887348` | s | Sur l'anneau, votre clignotant droit doit s'allumer : | — |
| `09f18973aee39386ee` | s | Pour tourner à gauche hors d'une intersection réglée, vous… | ABS aucun |
| `2a9e02b9719028e72f` | D | Ne pas céder le passage à un piéton engagé sur un passage … | — |
| `2daf8939fc85f5b288` | s | À un rond-point qu'aucun panneau n'annonce, la priorité es… | — |
| `37fe1af42b8d812fad` | s | À l'approche d'un carrefour à sens giratoire (« vous n'ave… | COURTE 78 |
| `37fe1af42b8d815f86` | s | Un feu de circulation et un panneau de priorité se contred… | ABS aucune |
| `37fe1af42b8d8161be` | s | Le panneau « Cédez le passage » (triangle pointe en bas) i… | COURTE 100; ABS obligatoire |
| `37fe1af42b8d817da9` | s | Qui a l'autorité la plus élevée pour régler la circulation… | — |
| `37fe1af42b8d818293` | D | Un véhicule prioritaire (pompiers, SAMU) en intervention a… | ABS en toutes circonstances/impose |
| `37fe1af42b8d8184be` | s | Le panneau losange jaune barré signifie : | — |
| `37fe1af42b8d818fb7` | s | À une intersection sans aucune signalisation, la priorité … | — |
| `37fe1af42b8d81bd94` | D | Le panneau STOP (octogone rouge) impose : | ABS impose |
| `37fe1af42b8d81d6ae` | s | Le panneau losange jaune indique : | COURTE 81 |
| `37fe1af42b8d81fa9d` | s | Vous croisez une voie de tramway, hors intersection : | — |
| `700316a2fd86db7d68` | s | Le sas cycliste, tracé en amont d'un feu, sert à : | — |
| `b433eefe7ea3ce149e` | D | Un panonceau triangulaire à liseré rouge sous un feu trico… | — |
| `defefbae1ae651a95d` | D | Un refus de priorité entre deux véhicules fait perdre : | — |
| `e0f68dd1324f9a5ffa` | s | Un véhicule qui sort d'un parking pour rejoindre la chauss… | — |

`D` = `datée`, `s` = `stable`. `IMG` = illustrée, budget 70 / 50 / 220. `COURTE` = explication sous 120 caractères, candidate n° 1 du critère 3. `ABS` = absolu ou obligation dans l'explication, à confronter à l'affirmation (écart « règle trop large »). **Un drapeau est une piste, pas un verdict, et son absence n'est pas un quitus : les cartes sans drapeau se relisent aussi.**

- [ ] **Step 1: Relever l'état d'avant, pour pouvoir prouver le mouvement**

Run :

```bash
mkdir -p .passe3 && python3 Tools/audit.py > .passe3/avant-11.txt
grep -E '^### ' .passe3/avant-11.txt
python3 - <<'EOF'
import json, statistics
qs = json.load(open('Valido/Resources/questions.json'))
lot = [q for q in qs if q['subject'] == 'code' and q['topic'] == 'Priorités & intersections']
el = [len(q['explanation']) for q in lot]
print(len(lot), 'cartes | expl médiane', statistics.median(el),
      '| sous 120 :', sum(1 for x in el if x < 120),
      '| illustrées :', sum(1 for q in lot if q.get('illustration')))
EOF
```

Expected : la ligne de base des Global Constraints, puis `26 cartes … sous 120 : 3 … illustrées : 8`.

- [ ] **Step 2: Lire les 26 cartes à côté de leur ligne de registre**

Run :

```bash
python3 Tools/relire.py "Priorités & intersections" > .passe3/lot-11.txt
less .passe3/lot-11.txt
```

Lire **la ligne avant la carte**. L'`affirmation` est la référence ; la carte est ce qu'on vérifie contre elle. **Ne rien éditer à cette étape** : lire tout le domaine d'abord, pour que les cartes se corrigent les unes par les autres — deux cartes voisines qui se contredisent (cas n° 8 du §9.5 de la passe 2, « deux verres » contre « deux ou trois verres ») ne se voient qu'en lisant le lot entier.

- [ ] **Step 3: Marquer les trois écarts de justesse**

Pour chaque carte, dans l'ordre du tableau des Global Constraints : **valeur périmée**, puis **règle trop large**, puis **explication au-delà de l'article**. Consigner dans `.passe3/ecarts-11.md` une ligne par écart — `id`, écart, ce que dit la carte, ce que dit l'affirmation, correction envisagée.

**Rouvrir une source dans un seul cas** : la carte affirme quelque chose que l'affirmation ne couvre pas **et** qui n'est pas manifestement faux. Lire alors l'**article consolidé** (Legifrance, ligne « Version en vigueur depuis le … »), jamais une page de synthèse seule : le « Vérifié le » de `service-public` date la lecture, pas la valeur, et `securite-routiere.gouv.fr` ne fait jamais autorité seul sur un chiffre. Liste blanche, et rien d'autre : `legifrance.gouv.fr`, `securite-routiere.gouv.fr`, `service-public.gouv.fr`, `ecologie.gouv.fr`, `sante.gouv.fr`, `unece.org`, `eur-lex.europa.eu`, `cprguidelines.eu`, `erc.edu`, `croix-rouge.fr`, `inrs.fr`.

- [ ] **Step 4: Corriger la justesse dans `Valido/Resources/questions.json`**

Appliquer les corrections de l'étape 3. Quand la valeur périmée était la bonne réponse, **elle devient un distracteur** : c'est exactement ce qu'un candidat aura lu ailleurs. Ne toucher à aucun `id`.

- [ ] **Step 5: Réécrire pour qui découvre la règle**

Les quatre critères des Global Constraints, sur les trois champs. Commencer par les 3 explication(s) sous 120 caractères. Sur les 8 carte(s) illustrée(s), le gain vient de la **coupe** : supprimer la reformulation de la bonne réponse libère la place des trois temps.

- [ ] **Step 6: Renormaliser le fichier et prouver qu'aucun `id` n'a bougé**

Run :

```bash
python3 - <<'EOF'
import json
p = 'Valido/Resources/questions.json'
d = json.load(open(p))
with open(p, 'w', encoding='utf-8') as f:
    json.dump(d, f, ensure_ascii=False, indent=2, sort_keys=True)
    f.write('\n')
print(len(d), 'questions')
EOF
python3 - <<'EOF'
import json, subprocess
avant = json.loads(subprocess.run(
    ['git', 'show', 'HEAD:Valido/Resources/questions.json'],
    capture_output=True, text=True).stdout)
apres = json.load(open('Valido/Resources/questions.json'))
a = [q['id'] for q in avant]
b = [q['id'] for q in apres]
print('mêmes ids :', sorted(a) == sorted(b), '|', len(a), '->', len(b))
print('ajoutés :', sorted(set(b) - set(a)), '| retirés :', sorted(set(a) - set(b)))
EOF
```

Expected : `448 questions`, `mêmes ids : True | 448 -> 448`, et deux listes vides.

- [ ] **Step 7: Chercher les fuites introduites, puis repasser `audit.py`**

Run :

```bash
python3 Tools/relire.py --fuites "Priorités & intersections" | tail -40
python3 Tools/audit.py > .passe3/apres-11.txt
diff <(grep -E '^### ' .passe3/avant-11.txt) <(grep -E '^### ' .passe3/apres-11.txt) || true
```

Expected : `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10` et `forme/backtick-isole` **absents** du rapport d'après. **Une sortie qui passe de vide à non vide est un échec de la tâche** : corriger dans les données avant de continuer. `expl/paraphrase-litterale` doit avoir baissé si le domaine en portait. Chaque recouvrement listé par `--fuites` se relit à la main — un mot commun est normal, la réponse entière ne l'est pas.

- [ ] **Step 8: Reporter dans `Tools/sources.md`, puis écrire la section du rapport**

Dans `Tools/sources.md` : pour chaque ligne dont ce qui est affirmé a changé, réécrire la colonne `affirmation` et porter `relevé le` à la date de la lecture. Un changement de `nature` se justifie dans la colonne. **Ne pas toucher aux lignes inchangées.**

Dans `Tools/audit-2026-08-passe-3.md`, ajouter :

```markdown
## Priorités & intersections

26 cartes, 5 `datée`, 8 illustrée(s).

### Écarts de justesse trouvés

| id | écart | ce que disait la carte | ce que dit l'article | correction |
|---|---|---|---|---|

### Doutes signalés, non corrigés

| id | ce qui est douteux | ce qui a été lu | ce qui manque |
|---|---|---|---|

### Pédagogie

- explications sous 120 caractères : 3 à l'entrée, N à la sortie
- cartes dont le budget de 220 a limité l'explication : …
- énoncés reformulés parce qu'ils présupposaient la règle : …

### Mouvements d'`audit.py`

| sortie | avant | après |
|---|---|---|
```

Une section vide se remplit d'**une phrase qui dit qu'elle est vide et pourquoi**, jamais d'un tableau sans ligne : « aucun écart de justesse — les N lignes `datée` du domaine ont toutes été relevées le … et la carte ne dit rien de plus que son affirmation » se vérifie, « (vide) » ne se vérifie pas.

- [ ] **Step 9: Lancer les dix tests du contenu livré**

Run :

```bash
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl boot 'iPhone 17 Pro' 2>/dev/null || true
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  -only-testing:'ValidoTests/leContenuLivréEstValide()' \
  -only-testing:'ValidoTests/lesDeuxMatièresSontPrésentes()' \
  -only-testing:'ValidoTests/aucuneExplicationNeCommenceParUneLettreDeRéponse()' \
  -only-testing:'ValidoTests/chaqueQuestionAAuMoinsDeuxOptionsEtUneBonneRéponse()' \
  -only-testing:'ValidoTests/laBonneRéponseNeDépassePasLaDeuxièmePlusLongueDeDixCaractères()' \
  -only-testing:'ValidoTests/aucuneOptionNeCommenceParUneLettreDeRéponse()' \
  -only-testing:'ValidoTests/chaqueIllustrationRéférencéeExisteDansLeBundle()' \
  -only-testing:'ValidoTests/chaqueAltDécritVraimentLaScène()' \
  -only-testing:'ValidoTests/leBudgetDeHauteurDesQuestionsIllustréesEstTenu()' \
  -only-testing:'ValidoTests/laBanqueGardeSonVolumeIllustré()' 2>&1 | tail -30
```

Expected : `** TEST SUCCEEDED **` **et** la ligne `✔ Test run with 10 test(s)`. Sans la ligne de comptage, la réussite ne prouve rien. Si `Application failed preflight checks` / `Busy` sort sans qu'aucun test n'ait tourné, c'est le simulateur — changer de device via `DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl list devices available` — pas le contenu.

- [ ] **Step 10: Commit**

```bash
git add Valido/Resources/questions.json Tools/sources.md Tools/audit-2026-08-passe-3.md
git commit -m "$(cat <<'EOF'
Reread the « Priorités & intersections » cards against what the registry records

<Une ligne par écart de justesse corrigé, avec son article et sa
version en vigueur. Puis ce que la réécriture a changé : les
explications qui renommaient la réponse disent maintenant la règle,
sa raison et sa limite. Puis les doutes laissés ouverts, et pourquoi
ils ne sont pas corrigés.>

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>
EOF
)"
```

Le corps se rédige à partir de la section du rapport : il dit **ce qui a bougé et pourquoi**, jamais « fix content ».

---

### Tâche 12 : domaine « Croisement & dépassement »

**Files:**
- Modify: `Valido/Resources/questions.json` — les 15 cartes `code` de `topic` « Croisement & dépassement »
- Modify: `Tools/sources.md` — les lignes dont l'`affirmation` change
- Create/Modify: `Tools/audit-2026-08-passe-3.md` — la section du domaine

**Interfaces:**
- Consumes: `python3 Tools/relire.py "Croisement & dépassement"` et `python3 Tools/relire.py --fuites "Croisement & dépassement"` (tâche 1).
- Produces: une section `## Croisement & dépassement` dans `Tools/audit-2026-08-passe-3.md`, au format fixé à l'étape 8, que la tâche 16 consolide sans le réécrire.

**Le lot.** 15 cartes : **3 `datée`**, 12 `stable`, **4 illustrée(s)** (explications à 196, 214, 215, 216 caractères sur 220). Relevés du registre : 2026-08-26. **0** explication(s) sous 120 caractères ; **5** portant un absolu ou une obligation à confronter à l'affirmation.

| id (18 car., greppable) | nat. | énoncé | drapeaux |
|---|---|---|---|
| `42078575c362bf24a2` | s | Devant cet obstacle, vous devez : | IMG expl 196/220 |
| `46269e3e9018b1949b` | s | Vous pouvez achever ce dépassement : | IMG expl 214/220 |
| `697b226c6270e1cee1` | s | Sur cette route à double sens, dépasser est : | IMG expl 216/220; ABS interdit |
| `9aaede46c1c808687f` | s | Vous venez de dépasser. Ce rabattement est : | IMG expl 215/220 |
| `07b430ccbde4b33b92` | D | Un convoi trop large pour qu'on le dépasse aisément doit : | — |
| `2fc1ed8a9c9274f0e0` | s | La circulation est figée en files sur toutes les voies. Ro… | ABS toutes les |
| `75e142d94ea93f63d0` | D | Un véhicule s'apprête à vous dépasser. Vous devez : | — |
| `93292bac6a7b17452c` | D | Le dépassement est interdit aux véhicules de plus de 3,5 t… | ABS jamais |
| `99824d4de286434d85` | s | Sur une chaussée à double sens de trois voies, pour dépass… | ABS interdit |
| `acfa94cddf8eadadd7` | s | Vous ne devez pas entamer un dépassement si : | — |
| `ad7c53ef7c57cb946c` | s | Dépasser par la droite est obligatoire : | — |
| `b494d71578b339d025` | s | À l'approche d'un passage pour piétons, dépasser est : | ABS aucun/impose |
| `e5b0f585f1a3654ca7` | s | Aux traversées de voies ferrées, le dépassement est interd… | — |
| `f1ae9582d692d2bb7f` | s | Lors d'un croisement, chaque conducteur doit : | — |
| `f5a12ba77751310fe9` | s | À l'approche d'une intersection, le dépassement : | — |

`D` = `datée`, `s` = `stable`. `IMG` = illustrée, budget 70 / 50 / 220. `COURTE` = explication sous 120 caractères, candidate n° 1 du critère 3. `ABS` = absolu ou obligation dans l'explication, à confronter à l'affirmation (écart « règle trop large »). **Un drapeau est une piste, pas un verdict, et son absence n'est pas un quitus : les cartes sans drapeau se relisent aussi.**

- [ ] **Step 1: Relever l'état d'avant, pour pouvoir prouver le mouvement**

Run :

```bash
mkdir -p .passe3 && python3 Tools/audit.py > .passe3/avant-12.txt
grep -E '^### ' .passe3/avant-12.txt
python3 - <<'EOF'
import json, statistics
qs = json.load(open('Valido/Resources/questions.json'))
lot = [q for q in qs if q['subject'] == 'code' and q['topic'] == 'Croisement & dépassement']
el = [len(q['explanation']) for q in lot]
print(len(lot), 'cartes | expl médiane', statistics.median(el),
      '| sous 120 :', sum(1 for x in el if x < 120),
      '| illustrées :', sum(1 for q in lot if q.get('illustration')))
EOF
```

Expected : la ligne de base des Global Constraints, puis `15 cartes … sous 120 : 0 … illustrées : 4`.

- [ ] **Step 2: Lire les 15 cartes à côté de leur ligne de registre**

Run :

```bash
python3 Tools/relire.py "Croisement & dépassement" > .passe3/lot-12.txt
less .passe3/lot-12.txt
```

Lire **la ligne avant la carte**. L'`affirmation` est la référence ; la carte est ce qu'on vérifie contre elle. **Ne rien éditer à cette étape** : lire tout le domaine d'abord, pour que les cartes se corrigent les unes par les autres — deux cartes voisines qui se contredisent (cas n° 8 du §9.5 de la passe 2, « deux verres » contre « deux ou trois verres ») ne se voient qu'en lisant le lot entier.

- [ ] **Step 3: Marquer les trois écarts de justesse**

Pour chaque carte, dans l'ordre du tableau des Global Constraints : **valeur périmée**, puis **règle trop large**, puis **explication au-delà de l'article**. Consigner dans `.passe3/ecarts-12.md` une ligne par écart — `id`, écart, ce que dit la carte, ce que dit l'affirmation, correction envisagée.

**Rouvrir une source dans un seul cas** : la carte affirme quelque chose que l'affirmation ne couvre pas **et** qui n'est pas manifestement faux. Lire alors l'**article consolidé** (Legifrance, ligne « Version en vigueur depuis le … »), jamais une page de synthèse seule : le « Vérifié le » de `service-public` date la lecture, pas la valeur, et `securite-routiere.gouv.fr` ne fait jamais autorité seul sur un chiffre. Liste blanche, et rien d'autre : `legifrance.gouv.fr`, `securite-routiere.gouv.fr`, `service-public.gouv.fr`, `ecologie.gouv.fr`, `sante.gouv.fr`, `unece.org`, `eur-lex.europa.eu`, `cprguidelines.eu`, `erc.edu`, `croix-rouge.fr`, `inrs.fr`.

- [ ] **Step 4: Corriger la justesse dans `Valido/Resources/questions.json`**

Appliquer les corrections de l'étape 3. Quand la valeur périmée était la bonne réponse, **elle devient un distracteur** : c'est exactement ce qu'un candidat aura lu ailleurs. Ne toucher à aucun `id`.

- [ ] **Step 5: Réécrire pour qui découvre la règle**

Les quatre critères des Global Constraints, sur les trois champs. Commencer par les 0 explication(s) sous 120 caractères (aucune ici : le domaine part d'explications déjà étoffées, le gain est sur l'énoncé et les options). Sur les 4 carte(s) illustrée(s), le gain vient de la **coupe** : supprimer la reformulation de la bonne réponse libère la place des trois temps.

- [ ] **Step 6: Renormaliser le fichier et prouver qu'aucun `id` n'a bougé**

Run :

```bash
python3 - <<'EOF'
import json
p = 'Valido/Resources/questions.json'
d = json.load(open(p))
with open(p, 'w', encoding='utf-8') as f:
    json.dump(d, f, ensure_ascii=False, indent=2, sort_keys=True)
    f.write('\n')
print(len(d), 'questions')
EOF
python3 - <<'EOF'
import json, subprocess
avant = json.loads(subprocess.run(
    ['git', 'show', 'HEAD:Valido/Resources/questions.json'],
    capture_output=True, text=True).stdout)
apres = json.load(open('Valido/Resources/questions.json'))
a = [q['id'] for q in avant]
b = [q['id'] for q in apres]
print('mêmes ids :', sorted(a) == sorted(b), '|', len(a), '->', len(b))
print('ajoutés :', sorted(set(b) - set(a)), '| retirés :', sorted(set(a) - set(b)))
EOF
```

Expected : `448 questions`, `mêmes ids : True | 448 -> 448`, et deux listes vides.

- [ ] **Step 7: Chercher les fuites introduites, puis repasser `audit.py`**

Run :

```bash
python3 Tools/relire.py --fuites "Croisement & dépassement" | tail -40
python3 Tools/audit.py > .passe3/apres-12.txt
diff <(grep -E '^### ' .passe3/avant-12.txt) <(grep -E '^### ' .passe3/apres-12.txt) || true
```

Expected : `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10` et `forme/backtick-isole` **absents** du rapport d'après. **Une sortie qui passe de vide à non vide est un échec de la tâche** : corriger dans les données avant de continuer. `expl/paraphrase-litterale` doit avoir baissé si le domaine en portait. Chaque recouvrement listé par `--fuites` se relit à la main — un mot commun est normal, la réponse entière ne l'est pas.

- [ ] **Step 8: Reporter dans `Tools/sources.md`, puis écrire la section du rapport**

Dans `Tools/sources.md` : pour chaque ligne dont ce qui est affirmé a changé, réécrire la colonne `affirmation` et porter `relevé le` à la date de la lecture. Un changement de `nature` se justifie dans la colonne. **Ne pas toucher aux lignes inchangées.**

Dans `Tools/audit-2026-08-passe-3.md`, ajouter :

```markdown
## Croisement & dépassement

15 cartes, 3 `datée`, 4 illustrée(s).

### Écarts de justesse trouvés

| id | écart | ce que disait la carte | ce que dit l'article | correction |
|---|---|---|---|---|

### Doutes signalés, non corrigés

| id | ce qui est douteux | ce qui a été lu | ce qui manque |
|---|---|---|---|

### Pédagogie

- explications sous 120 caractères : 0 à l'entrée, N à la sortie
- cartes dont le budget de 220 a limité l'explication : …
- énoncés reformulés parce qu'ils présupposaient la règle : …

### Mouvements d'`audit.py`

| sortie | avant | après |
|---|---|---|
```

Une section vide se remplit d'**une phrase qui dit qu'elle est vide et pourquoi**, jamais d'un tableau sans ligne : « aucun écart de justesse — les N lignes `datée` du domaine ont toutes été relevées le … et la carte ne dit rien de plus que son affirmation » se vérifie, « (vide) » ne se vérifie pas.

- [ ] **Step 9: Lancer les dix tests du contenu livré**

Run :

```bash
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl boot 'iPhone 17 Pro' 2>/dev/null || true
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  -only-testing:'ValidoTests/leContenuLivréEstValide()' \
  -only-testing:'ValidoTests/lesDeuxMatièresSontPrésentes()' \
  -only-testing:'ValidoTests/aucuneExplicationNeCommenceParUneLettreDeRéponse()' \
  -only-testing:'ValidoTests/chaqueQuestionAAuMoinsDeuxOptionsEtUneBonneRéponse()' \
  -only-testing:'ValidoTests/laBonneRéponseNeDépassePasLaDeuxièmePlusLongueDeDixCaractères()' \
  -only-testing:'ValidoTests/aucuneOptionNeCommenceParUneLettreDeRéponse()' \
  -only-testing:'ValidoTests/chaqueIllustrationRéférencéeExisteDansLeBundle()' \
  -only-testing:'ValidoTests/chaqueAltDécritVraimentLaScène()' \
  -only-testing:'ValidoTests/leBudgetDeHauteurDesQuestionsIllustréesEstTenu()' \
  -only-testing:'ValidoTests/laBanqueGardeSonVolumeIllustré()' 2>&1 | tail -30
```

Expected : `** TEST SUCCEEDED **` **et** la ligne `✔ Test run with 10 test(s)`. Sans la ligne de comptage, la réussite ne prouve rien. Si `Application failed preflight checks` / `Busy` sort sans qu'aucun test n'ait tourné, c'est le simulateur — changer de device via `DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl list devices available` — pas le contenu.

- [ ] **Step 10: Commit**

```bash
git add Valido/Resources/questions.json Tools/sources.md Tools/audit-2026-08-passe-3.md
git commit -m "$(cat <<'EOF'
Reread the « Croisement & dépassement » cards against what the registry records

<Une ligne par écart de justesse corrigé, avec son article et sa
version en vigueur. Puis ce que la réécriture a changé : les
explications qui renommaient la réponse disent maintenant la règle,
sa raison et sa limite. Puis les doutes laissés ouverts, et pourquoi
ils ne sont pas corrigés.>

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>
EOF
)"
```

Le corps se rédige à partir de la section du rapport : il dit **ce qui a bougé et pourquoi**, jamais « fix content ».

---

### Tâche 13 : domaine « Feux »

**Files:**
- Modify: `Valido/Resources/questions.json` — les 19 cartes `code` de `topic` « Feux »
- Modify: `Tools/sources.md` — les lignes dont l'`affirmation` change
- Create/Modify: `Tools/audit-2026-08-passe-3.md` — la section du domaine

**Interfaces:**
- Consumes: `python3 Tools/relire.py "Feux"` et `python3 Tools/relire.py --fuites "Feux"` (tâche 1).
- Produces: une section `## Feux` dans `Tools/audit-2026-08-passe-3.md`, au format fixé à l'étape 8, que la tâche 16 consolide sans le réécrire.

**Le lot.** 19 cartes : **2 `datée`**, 17 `stable`, **3 illustrée(s)** (explications à 206, 208, 218 caractères sur 220). Relevés du registre : 2026-08-24. **5** explication(s) sous 120 caractères ; **5** portant un absolu ou une obligation à confronter à l'affirmation.

| id (18 car., greppable) | nat. | énoncé | drapeaux |
|---|---|---|---|
| `1782eca179c97b4c02` | s | Ces feux vous autorisent à : | IMG expl 206/220 |
| `37fe1af42b8d8118ab` | s | Ce feu signifie : | IMG expl 218/220 |
| `37fe1af42b8d81df97` | s | Ce signal vous impose : | IMG expl 208/220; ABS interdit |
| `0ac1e53ac8978390a5` | s | À une intersection tenue par un feu jaune clignotant, un c… | ABS aucune |
| `1f62ee2f0d02611c04` | D | De nuit, hors agglomération, vos deux feux de croisement s… | — |
| `362d572a8e9eb2d294` | s | De nuit, vous roulez en feux de route derrière un véhicule… | ABS impose |
| `37fe1af42b8d81038e` | s | Le clignotant doit être utilisé : | COURTE 88; ABS toujours |
| `37fe1af42b8d81659d` | D | Franchir un feu rouge fixe fait perdre : | — |
| `37fe1af42b8d8189a7` | s | À un feu vert, vous : | COURTE 92 |
| `37fe1af42b8d819388` | s | Les feux de croisement (codes) sont obligatoires : | COURTE 73 |
| `37fe1af42b8d81adbe` | s | Les feux de détresse (warning) servent à : | COURTE 76 |
| `37fe1af42b8d81b1b3` | s | Les feux arrière antibrouillard s'utilisent : | — |
| `37fe1af42b8d81c8af` | s | De nuit hors agglomération, vous croisez un véhicule alors… | COURTE 72 |
| `37fe1af42b8d81fc9b` | s | Au feu jaune (orange) fixe, vous devez : | ABS impose |
| `6012289234e0766392` | s | Les feux avant de brouillard peuvent remplacer les feux de… | — |
| `a3b1d0cf8c4fde31d0` | s | De nuit, un véhicule arrive en face avec un seul feu allum… | — |
| `acaf8b468f86cd92d2` | s | Devant un feu rouge sans ligne d'arrêt peinte au sol, l'ar… | — |
| `d5505e2b6bdcdeb78e` | s | De nuit, à l'arrêt sur une chaussée sans éclairage public,… | — |
| `fc0333a5ae17dd22f3` | s | Dans une file de véhicules à allure fortement réduite, les… | — |

`D` = `datée`, `s` = `stable`. `IMG` = illustrée, budget 70 / 50 / 220. `COURTE` = explication sous 120 caractères, candidate n° 1 du critère 3. `ABS` = absolu ou obligation dans l'explication, à confronter à l'affirmation (écart « règle trop large »). **Un drapeau est une piste, pas un verdict, et son absence n'est pas un quitus : les cartes sans drapeau se relisent aussi.**

- [ ] **Step 1: Relever l'état d'avant, pour pouvoir prouver le mouvement**

Run :

```bash
mkdir -p .passe3 && python3 Tools/audit.py > .passe3/avant-13.txt
grep -E '^### ' .passe3/avant-13.txt
python3 - <<'EOF'
import json, statistics
qs = json.load(open('Valido/Resources/questions.json'))
lot = [q for q in qs if q['subject'] == 'code' and q['topic'] == 'Feux']
el = [len(q['explanation']) for q in lot]
print(len(lot), 'cartes | expl médiane', statistics.median(el),
      '| sous 120 :', sum(1 for x in el if x < 120),
      '| illustrées :', sum(1 for q in lot if q.get('illustration')))
EOF
```

Expected : la ligne de base des Global Constraints, puis `19 cartes … sous 120 : 5 … illustrées : 3`.

- [ ] **Step 2: Lire les 19 cartes à côté de leur ligne de registre**

Run :

```bash
python3 Tools/relire.py "Feux" > .passe3/lot-13.txt
less .passe3/lot-13.txt
```

Lire **la ligne avant la carte**. L'`affirmation` est la référence ; la carte est ce qu'on vérifie contre elle. **Ne rien éditer à cette étape** : lire tout le domaine d'abord, pour que les cartes se corrigent les unes par les autres — deux cartes voisines qui se contredisent (cas n° 8 du §9.5 de la passe 2, « deux verres » contre « deux ou trois verres ») ne se voient qu'en lisant le lot entier.

- [ ] **Step 3: Marquer les trois écarts de justesse**

Pour chaque carte, dans l'ordre du tableau des Global Constraints : **valeur périmée**, puis **règle trop large**, puis **explication au-delà de l'article**. Consigner dans `.passe3/ecarts-13.md` une ligne par écart — `id`, écart, ce que dit la carte, ce que dit l'affirmation, correction envisagée.

**Rouvrir une source dans un seul cas** : la carte affirme quelque chose que l'affirmation ne couvre pas **et** qui n'est pas manifestement faux. Lire alors l'**article consolidé** (Legifrance, ligne « Version en vigueur depuis le … »), jamais une page de synthèse seule : le « Vérifié le » de `service-public` date la lecture, pas la valeur, et `securite-routiere.gouv.fr` ne fait jamais autorité seul sur un chiffre. Liste blanche, et rien d'autre : `legifrance.gouv.fr`, `securite-routiere.gouv.fr`, `service-public.gouv.fr`, `ecologie.gouv.fr`, `sante.gouv.fr`, `unece.org`, `eur-lex.europa.eu`, `cprguidelines.eu`, `erc.edu`, `croix-rouge.fr`, `inrs.fr`.

- [ ] **Step 4: Corriger la justesse dans `Valido/Resources/questions.json`**

Appliquer les corrections de l'étape 3. Quand la valeur périmée était la bonne réponse, **elle devient un distracteur** : c'est exactement ce qu'un candidat aura lu ailleurs. Ne toucher à aucun `id`.

- [ ] **Step 5: Réécrire pour qui découvre la règle**

Les quatre critères des Global Constraints, sur les trois champs. Commencer par les 5 explication(s) sous 120 caractères. Sur les 3 carte(s) illustrée(s), le gain vient de la **coupe** : supprimer la reformulation de la bonne réponse libère la place des trois temps.

- [ ] **Step 6: Renormaliser le fichier et prouver qu'aucun `id` n'a bougé**

Run :

```bash
python3 - <<'EOF'
import json
p = 'Valido/Resources/questions.json'
d = json.load(open(p))
with open(p, 'w', encoding='utf-8') as f:
    json.dump(d, f, ensure_ascii=False, indent=2, sort_keys=True)
    f.write('\n')
print(len(d), 'questions')
EOF
python3 - <<'EOF'
import json, subprocess
avant = json.loads(subprocess.run(
    ['git', 'show', 'HEAD:Valido/Resources/questions.json'],
    capture_output=True, text=True).stdout)
apres = json.load(open('Valido/Resources/questions.json'))
a = [q['id'] for q in avant]
b = [q['id'] for q in apres]
print('mêmes ids :', sorted(a) == sorted(b), '|', len(a), '->', len(b))
print('ajoutés :', sorted(set(b) - set(a)), '| retirés :', sorted(set(a) - set(b)))
EOF
```

Expected : `448 questions`, `mêmes ids : True | 448 -> 448`, et deux listes vides.

- [ ] **Step 7: Chercher les fuites introduites, puis repasser `audit.py`**

Run :

```bash
python3 Tools/relire.py --fuites "Feux" | tail -40
python3 Tools/audit.py > .passe3/apres-13.txt
diff <(grep -E '^### ' .passe3/avant-13.txt) <(grep -E '^### ' .passe3/apres-13.txt) || true
```

Expected : `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10` et `forme/backtick-isole` **absents** du rapport d'après. **Une sortie qui passe de vide à non vide est un échec de la tâche** : corriger dans les données avant de continuer. `expl/paraphrase-litterale` doit avoir baissé si le domaine en portait. Chaque recouvrement listé par `--fuites` se relit à la main — un mot commun est normal, la réponse entière ne l'est pas.

- [ ] **Step 8: Reporter dans `Tools/sources.md`, puis écrire la section du rapport**

Dans `Tools/sources.md` : pour chaque ligne dont ce qui est affirmé a changé, réécrire la colonne `affirmation` et porter `relevé le` à la date de la lecture. Un changement de `nature` se justifie dans la colonne. **Ne pas toucher aux lignes inchangées.**

Dans `Tools/audit-2026-08-passe-3.md`, ajouter :

```markdown
## Feux

19 cartes, 2 `datée`, 3 illustrée(s).

### Écarts de justesse trouvés

| id | écart | ce que disait la carte | ce que dit l'article | correction |
|---|---|---|---|---|

### Doutes signalés, non corrigés

| id | ce qui est douteux | ce qui a été lu | ce qui manque |
|---|---|---|---|

### Pédagogie

- explications sous 120 caractères : 5 à l'entrée, N à la sortie
- cartes dont le budget de 220 a limité l'explication : …
- énoncés reformulés parce qu'ils présupposaient la règle : …

### Mouvements d'`audit.py`

| sortie | avant | après |
|---|---|---|
```

Une section vide se remplit d'**une phrase qui dit qu'elle est vide et pourquoi**, jamais d'un tableau sans ligne : « aucun écart de justesse — les N lignes `datée` du domaine ont toutes été relevées le … et la carte ne dit rien de plus que son affirmation » se vérifie, « (vide) » ne se vérifie pas.

- [ ] **Step 9: Lancer les dix tests du contenu livré**

Run :

```bash
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl boot 'iPhone 17 Pro' 2>/dev/null || true
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  -only-testing:'ValidoTests/leContenuLivréEstValide()' \
  -only-testing:'ValidoTests/lesDeuxMatièresSontPrésentes()' \
  -only-testing:'ValidoTests/aucuneExplicationNeCommenceParUneLettreDeRéponse()' \
  -only-testing:'ValidoTests/chaqueQuestionAAuMoinsDeuxOptionsEtUneBonneRéponse()' \
  -only-testing:'ValidoTests/laBonneRéponseNeDépassePasLaDeuxièmePlusLongueDeDixCaractères()' \
  -only-testing:'ValidoTests/aucuneOptionNeCommenceParUneLettreDeRéponse()' \
  -only-testing:'ValidoTests/chaqueIllustrationRéférencéeExisteDansLeBundle()' \
  -only-testing:'ValidoTests/chaqueAltDécritVraimentLaScène()' \
  -only-testing:'ValidoTests/leBudgetDeHauteurDesQuestionsIllustréesEstTenu()' \
  -only-testing:'ValidoTests/laBanqueGardeSonVolumeIllustré()' 2>&1 | tail -30
```

Expected : `** TEST SUCCEEDED **` **et** la ligne `✔ Test run with 10 test(s)`. Sans la ligne de comptage, la réussite ne prouve rien. Si `Application failed preflight checks` / `Busy` sort sans qu'aucun test n'ait tourné, c'est le simulateur — changer de device via `DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl list devices available` — pas le contenu.

- [ ] **Step 10: Commit**

```bash
git add Valido/Resources/questions.json Tools/sources.md Tools/audit-2026-08-passe-3.md
git commit -m "$(cat <<'EOF'
Reread the « Feux » cards against what the registry records

<Une ligne par écart de justesse corrigé, avec son article et sa
version en vigueur. Puis ce que la réécriture a changé : les
explications qui renommaient la réponse disent maintenant la règle,
sa raison et sa limite. Puis les doutes laissés ouverts, et pourquoi
ils ne sont pas corrigés.>

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>
EOF
)"
```

Le corps se rédige à partir de la section du rapport : il dit **ce qui a bougé et pourquoi**, jamais « fix content ».

---

### Tâche 14 : domaine « Panneaux & marquage »

**Files:**
- Modify: `Valido/Resources/questions.json` — les 27 cartes `code` de `topic` « Panneaux & marquage »
- Modify: `Tools/sources.md` — les lignes dont l'`affirmation` change
- Create/Modify: `Tools/audit-2026-08-passe-3.md` — la section du domaine

**Interfaces:**
- Consumes: `python3 Tools/relire.py "Panneaux & marquage"` et `python3 Tools/relire.py --fuites "Panneaux & marquage"` (tâche 1).
- Produces: une section `## Panneaux & marquage` dans `Tools/audit-2026-08-passe-3.md`, au format fixé à l'étape 8, que la tâche 16 consolide sans le réécrire.

**Le lot.** 27 cartes : **2 `datée`**, 25 `stable`, **19 illustrée(s)** (explications à 161, 180, 181, 184, 186, 189, 192, 193, 199, 200, 201, 202, 204, 206, 208, 209, 209, 212, 214 caractères sur 220). Relevés du registre : 2026-08-24. **1** explication(s) sous 120 caractères ; **13** portant un absolu ou une obligation à confronter à l'affirmation.

| id (18 car., greppable) | nat. | énoncé | drapeaux |
|---|---|---|---|
| `11d37be22fd315668c` | s | Ce panneau lève : | IMG expl 209/220 |
| `1509ad94aea7c6f823` | s | Sous ce panneau, vous ne pouvez pas : | IMG expl 181/220 |
| `1658abbc16db4667fe` | s | Ce panneau interdit : | IMG expl 204/220; ABS interdit |
| `37fe1af42b8d81709c` | s | Ce marquage vous impose : | IMG expl 206/220; ABS interdit |
| `37fe1af42b8d8174a3` | s | Ce panneau vous impose : | IMG expl 214/220; ABS impose |
| `37fe1af42b8d817881` | s | Ce panneau donne : | IMG expl 180/220; ABS suffit |
| `37fe1af42b8d81b3a4` | s | Sur ce marquage, le dépassement vous est : | IMG expl 208/220 |
| `37fe1af42b8d81b5aa` | s | Ce panneau annonce : | IMG expl 200/220 |
| `37fe1af42b8d81d68a` | s | Ce marquage au sol : | IMG expl 193/220 |
| `443e4299ccb3ff7166` | s | Ce panneau impose : | IMG expl 212/220; ABS aucun |
| `570e5e1ef861e03277` | s | Ce damier annonce : | IMG expl 184/220 |
| `7d44f7dd303fce5871` | s | Ce panneau annonce la fin : | IMG expl 209/220 |
| `89bea09b482974f37e` | s | Ce panneau prescrit : | IMG expl 192/220; ABS jamais |
| `8a1026edb35c31c37a` | s | Ce panneau signifie : | IMG expl 201/220; ABS aucun/interdit |
| `9e65525bbce6a6491d` | s | Malgré ce panneau, vous pouvez encore doubler : | IMG expl 186/220 |
| `9eb8506813f0c8b729` | s | Vous approchez : | IMG expl 202/220 |
| `dce501d416e5db1cc6` | s | Ici, avant de vous engager, vous devez : | IMG expl 161/220; ABS impose |
| `ede6968609d285b224` | s | Ce panneau, pour un cycliste : | IMG expl 199/220; ABS obligatoire |
| `ee11b58d97d21d637c` | s | La plaque sous ce panneau : | IMG expl 189/220 |
| `1a0a5812ff8659ba24` | s | Sur une ligne mixte, la partie continue placée de votre cô… | ABS interdit |
| `37fe1af42b8d81059d` | s | Un panneau rond à bord rouge indique : | ABS interdit |
| `37fe1af42b8d8141b1` | D | Une ligne continue au centre de la chaussée : | ABS interdit |
| `37fe1af42b8d81699c` | s | Un panneau rond à fond bleu indique : | — |
| `37fe1af42b8d81f8a2` | s | Une ligne discontinue (axiale) : | COURTE 99 |
| `3cb86b6e4c489d919a` | D | Rouler à cheval sur une ligne continue, sans la franchir, … | — |
| `5a4e6a38ad3e1153f8` | s | Une ligne discontinue tracée le long du bord de la chaussé… | — |
| `f12ee5bea85947a13d` | s | Quand un panneau de chantier contredit un panneau permanen… | ABS impose |

`D` = `datée`, `s` = `stable`. `IMG` = illustrée, budget 70 / 50 / 220. `COURTE` = explication sous 120 caractères, candidate n° 1 du critère 3. `ABS` = absolu ou obligation dans l'explication, à confronter à l'affirmation (écart « règle trop large »). **Un drapeau est une piste, pas un verdict, et son absence n'est pas un quitus : les cartes sans drapeau se relisent aussi.**

- [ ] **Step 1: Relever l'état d'avant, pour pouvoir prouver le mouvement**

Run :

```bash
mkdir -p .passe3 && python3 Tools/audit.py > .passe3/avant-14.txt
grep -E '^### ' .passe3/avant-14.txt
python3 - <<'EOF'
import json, statistics
qs = json.load(open('Valido/Resources/questions.json'))
lot = [q for q in qs if q['subject'] == 'code' and q['topic'] == 'Panneaux & marquage']
el = [len(q['explanation']) for q in lot]
print(len(lot), 'cartes | expl médiane', statistics.median(el),
      '| sous 120 :', sum(1 for x in el if x < 120),
      '| illustrées :', sum(1 for q in lot if q.get('illustration')))
EOF
```

Expected : la ligne de base des Global Constraints, puis `27 cartes … sous 120 : 1 … illustrées : 19`.

- [ ] **Step 2: Lire les 27 cartes à côté de leur ligne de registre**

Run :

```bash
python3 Tools/relire.py "Panneaux & marquage" > .passe3/lot-14.txt
less .passe3/lot-14.txt
```

Lire **la ligne avant la carte**. L'`affirmation` est la référence ; la carte est ce qu'on vérifie contre elle. **Ne rien éditer à cette étape** : lire tout le domaine d'abord, pour que les cartes se corrigent les unes par les autres — deux cartes voisines qui se contredisent (cas n° 8 du §9.5 de la passe 2, « deux verres » contre « deux ou trois verres ») ne se voient qu'en lisant le lot entier.

- [ ] **Step 3: Marquer les trois écarts de justesse**

Pour chaque carte, dans l'ordre du tableau des Global Constraints : **valeur périmée**, puis **règle trop large**, puis **explication au-delà de l'article**. Consigner dans `.passe3/ecarts-14.md` une ligne par écart — `id`, écart, ce que dit la carte, ce que dit l'affirmation, correction envisagée.

**Rouvrir une source dans un seul cas** : la carte affirme quelque chose que l'affirmation ne couvre pas **et** qui n'est pas manifestement faux. Lire alors l'**article consolidé** (Legifrance, ligne « Version en vigueur depuis le … »), jamais une page de synthèse seule : le « Vérifié le » de `service-public` date la lecture, pas la valeur, et `securite-routiere.gouv.fr` ne fait jamais autorité seul sur un chiffre. Liste blanche, et rien d'autre : `legifrance.gouv.fr`, `securite-routiere.gouv.fr`, `service-public.gouv.fr`, `ecologie.gouv.fr`, `sante.gouv.fr`, `unece.org`, `eur-lex.europa.eu`, `cprguidelines.eu`, `erc.edu`, `croix-rouge.fr`, `inrs.fr`.

- [ ] **Step 4: Corriger la justesse dans `Valido/Resources/questions.json`**

Appliquer les corrections de l'étape 3. Quand la valeur périmée était la bonne réponse, **elle devient un distracteur** : c'est exactement ce qu'un candidat aura lu ailleurs. Ne toucher à aucun `id`.

- [ ] **Step 5: Réécrire pour qui découvre la règle**

Les quatre critères des Global Constraints, sur les trois champs. Commencer par les 1 explication(s) sous 120 caractères. Sur les 19 carte(s) illustrée(s), le gain vient de la **coupe** : supprimer la reformulation de la bonne réponse libère la place des trois temps.

- [ ] **Step 6: Renormaliser le fichier et prouver qu'aucun `id` n'a bougé**

Run :

```bash
python3 - <<'EOF'
import json
p = 'Valido/Resources/questions.json'
d = json.load(open(p))
with open(p, 'w', encoding='utf-8') as f:
    json.dump(d, f, ensure_ascii=False, indent=2, sort_keys=True)
    f.write('\n')
print(len(d), 'questions')
EOF
python3 - <<'EOF'
import json, subprocess
avant = json.loads(subprocess.run(
    ['git', 'show', 'HEAD:Valido/Resources/questions.json'],
    capture_output=True, text=True).stdout)
apres = json.load(open('Valido/Resources/questions.json'))
a = [q['id'] for q in avant]
b = [q['id'] for q in apres]
print('mêmes ids :', sorted(a) == sorted(b), '|', len(a), '->', len(b))
print('ajoutés :', sorted(set(b) - set(a)), '| retirés :', sorted(set(a) - set(b)))
EOF
```

Expected : `448 questions`, `mêmes ids : True | 448 -> 448`, et deux listes vides.

- [ ] **Step 7: Chercher les fuites introduites, puis repasser `audit.py`**

Run :

```bash
python3 Tools/relire.py --fuites "Panneaux & marquage" | tail -40
python3 Tools/audit.py > .passe3/apres-14.txt
diff <(grep -E '^### ' .passe3/avant-14.txt) <(grep -E '^### ' .passe3/apres-14.txt) || true
```

Expected : `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10` et `forme/backtick-isole` **absents** du rapport d'après. **Une sortie qui passe de vide à non vide est un échec de la tâche** : corriger dans les données avant de continuer. `expl/paraphrase-litterale` doit avoir baissé si le domaine en portait. Chaque recouvrement listé par `--fuites` se relit à la main — un mot commun est normal, la réponse entière ne l'est pas.

- [ ] **Step 8: Reporter dans `Tools/sources.md`, puis écrire la section du rapport**

Dans `Tools/sources.md` : pour chaque ligne dont ce qui est affirmé a changé, réécrire la colonne `affirmation` et porter `relevé le` à la date de la lecture. Un changement de `nature` se justifie dans la colonne. **Ne pas toucher aux lignes inchangées.**

Dans `Tools/audit-2026-08-passe-3.md`, ajouter :

```markdown
## Panneaux & marquage

27 cartes, 2 `datée`, 19 illustrée(s).

### Écarts de justesse trouvés

| id | écart | ce que disait la carte | ce que dit l'article | correction |
|---|---|---|---|---|

### Doutes signalés, non corrigés

| id | ce qui est douteux | ce qui a été lu | ce qui manque |
|---|---|---|---|

### Pédagogie

- explications sous 120 caractères : 1 à l'entrée, N à la sortie
- cartes dont le budget de 220 a limité l'explication : …
- énoncés reformulés parce qu'ils présupposaient la règle : …

### Mouvements d'`audit.py`

| sortie | avant | après |
|---|---|---|
```

Une section vide se remplit d'**une phrase qui dit qu'elle est vide et pourquoi**, jamais d'un tableau sans ligne : « aucun écart de justesse — les N lignes `datée` du domaine ont toutes été relevées le … et la carte ne dit rien de plus que son affirmation » se vérifie, « (vide) » ne se vérifie pas.

- [ ] **Step 9: Lancer les dix tests du contenu livré**

Run :

```bash
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl boot 'iPhone 17 Pro' 2>/dev/null || true
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  -only-testing:'ValidoTests/leContenuLivréEstValide()' \
  -only-testing:'ValidoTests/lesDeuxMatièresSontPrésentes()' \
  -only-testing:'ValidoTests/aucuneExplicationNeCommenceParUneLettreDeRéponse()' \
  -only-testing:'ValidoTests/chaqueQuestionAAuMoinsDeuxOptionsEtUneBonneRéponse()' \
  -only-testing:'ValidoTests/laBonneRéponseNeDépassePasLaDeuxièmePlusLongueDeDixCaractères()' \
  -only-testing:'ValidoTests/aucuneOptionNeCommenceParUneLettreDeRéponse()' \
  -only-testing:'ValidoTests/chaqueIllustrationRéférencéeExisteDansLeBundle()' \
  -only-testing:'ValidoTests/chaqueAltDécritVraimentLaScène()' \
  -only-testing:'ValidoTests/leBudgetDeHauteurDesQuestionsIllustréesEstTenu()' \
  -only-testing:'ValidoTests/laBanqueGardeSonVolumeIllustré()' 2>&1 | tail -30
```

Expected : `** TEST SUCCEEDED **` **et** la ligne `✔ Test run with 10 test(s)`. Sans la ligne de comptage, la réussite ne prouve rien. Si `Application failed preflight checks` / `Busy` sort sans qu'aucun test n'ait tourné, c'est le simulateur — changer de device via `DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl list devices available` — pas le contenu.

- [ ] **Step 10: Commit**

```bash
git add Valido/Resources/questions.json Tools/sources.md Tools/audit-2026-08-passe-3.md
git commit -m "$(cat <<'EOF'
Reread the « Panneaux & marquage » cards against what the registry records

<Une ligne par écart de justesse corrigé, avec son article et sa
version en vigueur. Puis ce que la réécriture a changé : les
explications qui renommaient la réponse disent maintenant la règle,
sa raison et sa limite. Puis les doutes laissés ouverts, et pourquoi
ils ne sont pas corrigés.>

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>
EOF
)"
```

Le corps se rédige à partir de la section du rapport : il dit **ce qui a bougé et pourquoi**, jamais « fix content ».

---

### Tâche 15 : recompter les repères chiffrés des registres

**Files:**
- Modify: `Tools/couverture.md` — colonne `volume` des quatorze lignes du tableau
- Modify: `Tools/questions.md` — §1, le bloc « Repère chiffré, recompté sur les 448 »
- Modify: `Tools/audit-2026-08-passe-3.md` — section « Repères recomptés »

**Interfaces:**
- Consumes: les treize domaines réécrits (tâches 2 à 14).
- Produces: des registres dont aucun chiffre ne contredit `questions.json`. La tâche 16 cite ces chiffres dans le rapport ; la tâche 17 ne doit trouver aucune divergence.

**Pourquoi cette tâche existe.** Le constat n° 18 du §9.5 de la passe 2 est exactement ce défaut : `couverture.md` portait `Arrêt & stationnement` à 11 pour 17 réelles et `Distances & freinage` à 10 pour 21, parce que les volumes avaient été écrits avant que les domaines ne grossissent. Une passe qui laisse ses registres derrière elle est une régression, même quand chaque carte est juste.

**Ce qui change et ce qui ne change pas.** Les **volumes** de `couverture.md` ne devraient **pas** bouger : cette passe réécrit sans ajouter ni retirer, et les quatorze lignes sont aujourd'hui exactes. Les **moyennes de longueur d'options** du §1 de `questions.md`, elles, bougent forcément : les 1 020 options `code` ont été réécrites. Un volume qui aurait bougé est le signal qu'une carte a été perdue ou dupliquée — à traiter comme un échec, pas à recopier.

- [ ] **Step 1: Recompter les volumes par topic**

Run :

```bash
python3 - <<'EOF'
import json, collections
qs = json.load(open('Valido/Resources/questions.json'))
c = collections.Counter(q['topic'] for q in qs if q['subject'] == 'code')
attendu = {'Arrêt & stationnement': 17, 'Croisement & dépassement': 15,
           'Mécanique & environnement': 20, 'Priorités & intersections': 26,
           'Vitesse': 22, 'Permis & sanctions': 19, 'Panneaux & marquage': 27,
           'Feux': 19, 'Tunnels & passages à niveau': 15,
           'Usagers & partage de la route': 18, 'Alcool & stupéfiants': 18,
           'Distances & freinage': 21, 'Premiers secours': 18}
for t in sorted(c):
    marque = 'OK' if c[t] == attendu.get(t) else '!! ATTENDU %s' % attendu.get(t)
    print(f'{t:32s} {c[t]:3d}  {marque}')
print('total code', sum(c.values()), '| total banque', len(qs))
EOF
```

Expected : `OK` sur les treize lignes, `total code 255 | total banque 448`. **Un `!!` arrête la tâche** : une carte a été perdue ou dupliquée dans une tâche de domaine, et c'est ce défaut-là qu'il faut trouver, pas le volume qu'il faut recopier.

- [ ] **Step 2: Reporter les volumes dans `Tools/couverture.md` si l'étape 1 en a bougé un**

Le tableau du fichier (colonne `volume`) porte aujourd'hui : `Arrêt & stationnement` 17, `Croisement & dépassement` 15, `Mécanique & environnement` 20, `Priorités & intersections` 26, `Vitesse` 22, `Permis & sanctions` 19, `Panneaux & marquage` 27, `Feux` 19 (deux lignes, `Signalisation` et `Visibilité et éclairage`), `Tunnels & passages à niveau` 15, `Usagers & partage de la route` 18, `Alcool & stupéfiants` 18, `Distances & freinage` 21, `Premiers secours` 18. Si l'étape 1 les confirme tous, **ne rien modifier** — et le dire dans le rapport plutôt que de faire un commit vide.

- [ ] **Step 3: Recompter les moyennes de longueur d'options**

Run :

```bash
python3 - <<'EOF'
import json, statistics
qs = json.load(open('Valido/Resources/questions.json'))
def mesure(lot):
    bonnes, distr = [], []
    for q in lot:
        for o in q['options']:
            (bonnes if o['id'] == q['correctID'] else distr).append(len(o['text']))
    return statistics.mean(bonnes), statistics.mean(distr)
for nom, lot in (('toutes', qs),
                 ('swift', [q for q in qs if q['subject'] == 'swift']),
                 ('code', [q for q in qs if q['subject'] == 'code']),
                 ('code illustrées', [q for q in qs if q['subject'] == 'code' and q.get('illustration')]),
                 ('code non illustrées', [q for q in qs if q['subject'] == 'code' and not q.get('illustration')])):
    b, d = mesure(lot)
    print(f'{nom:22s} bonne {b:5.1f}  distracteurs {d:5.1f}  écart {b-d:+.1f}')
EOF
```

Valeurs **d'avant la passe**, à citer dans le rapport pour montrer le mouvement : toutes `43,2 / 42,2` ; `swift` `50,9 / 49,3` (écart `+1,6`) ; `code` `37,3 / 36,8` (écart `+0,5`) ; `code` illustrées `41,5` par option ; `code` non illustrées `35,8`.

- [ ] **Step 4: Réécrire le bloc « Repère chiffré » du §1 de `Tools/questions.md`**

Remplacer les trois phrases qui portent `43,2`, `42,2`, `50,9 / 49,3`, `+1,6`, `37,3 / 36,8`, `+0,5`, puis celles qui portent `41,5` et `35,8`, par les valeurs de l'étape 3, en gardant la date de recomptage à jour (`recompté sur les 448 (2026-08-27)` → la date de la passe). **Le raisonnement qui entoure ces chiffres ne change pas** : l'écart structurel entre `swift` et `code` a une cause — une option `swift` nomme une API et son comportement, une option `code` porte une valeur ou une règle — et cette cause survit au recomptage. Si l'écart `code` s'est **creusé** au-delà de `+1,0`, le dire et l'expliquer : c'est un effet de la réécriture des options, et le seuil dur reste `+10` sur la carte, pas sur la moyenne.

- [ ] **Step 5: Vérifier qu'aucun chiffre de registre ne contredit plus la banque**

Run :

```bash
python3 Tools/audit.py | grep -E '^### |couverture|^code:|^swift:'
grep -nE '\| [0-9]+ \|' Tools/couverture.md
```

Expected : `couverture/` absent du rapport (aucun topic non rattaché), et les volumes du tableau égaux à ceux de l'étape 1. Les deux dernières lignes d'`audit.py` (`code: … écart moyen …`, `swift: … écart moyen …`) doivent correspondre aux écarts recomptés à l'étape 3.

- [ ] **Step 6: Consigner dans le rapport**

Dans `Tools/audit-2026-08-passe-3.md`, ajouter une section :

```markdown
## Repères recomptés

| repère | avant | après |
|---|---|---|
| volume `code` | 255 | … |
| volume illustrées | 49 | … |
| bonne option / distracteurs, toutes | 43,2 / 42,2 | … |
| bonne option / distracteurs, `code` | 37,3 / 36,8 | … |
| `code` illustrées, par option | 41,5 | … |
| `code` non illustrées, par option | 35,8 | … |

Volumes de `couverture.md` : <inchangés / les lignes … corrigées de … à …>.
```

- [ ] **Step 7: Commit**

```bash
git add Tools/couverture.md Tools/questions.md Tools/audit-2026-08-passe-3.md
git commit -m "$(cat <<'EOF'
Recount the registry figures the rewrite moved

Rewriting 1020 `code` options moves the option-length averages the
guide quotes as its own calibration; leaving them stale is the defect
the second pass recorded as finding 18, where the coverage map claimed
11 cards for a domain holding 17.

Volumes are checked rather than copied: this pass rewrites without
adding or removing, so a moved volume means a card was lost or
duplicated, and that is the thing to find.

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

### Tâche 16 : consolider le rapport de passe et publier la nouvelle ligne de base

**Files:**
- Modify: `Tools/audit-2026-08-passe-3.md` — en-tête, synthèse, angles morts, ce que la prochaine passe trouvera prêt
- Modify: `CLAUDE.md` — le paragraphe de la ligne de base d'`audit.py`
- Modify: `Tools/questions.md` — §3, le bloc « La ligne de base, au 2026-08-27 sur 448 questions »

**Interfaces:**
- Consumes: les treize sections de domaine (tâches 2 à 14) et la section « Repères recomptés » (tâche 15).
- Produces: une ligne de base publiée à laquelle la **prochaine** passe se comparera. C'est le livrable le plus durable de cette tâche : une ligne de base fausse coûte une passe entière en fausses alertes.

**Pourquoi la ligne de base doit être republiée.** `expl/paraphrase-litterale` était à 18 dont 10 `code`, et la baisser était un **objectif** de la passe. Si le chiffre baisse sans que `CLAUDE.md` et `questions.md` le disent, la prochaine passe lira « 18 attendu » et prendra son propre bon état pour une amélioration inexpliquée — ou, pire, remontera à 18 sans que rien ne l'arrête. Le §10 de la passe 2 dit la même chose de son côté : `audit-questions.md` est devenu faux sur chacun de ses chiffres en une seule passe.

- [ ] **Step 1: Relever la ligne de base réelle, en fin de passe**

Run :

```bash
python3 Tools/audit.py > .passe3/final.txt
grep -E '^### ' .passe3/final.txt
python3 - <<'EOF'
import re
txt = open('.passe3/final.txt').read()
for kind, n in re.findall(r'^### (\S+)\s+\((\d+)\)', txt, re.M):
    print(f'{kind:28s} {n}')
bloc = re.split(r'^### expl/paraphrase-litterale', txt, flags=re.M)
if len(bloc) > 1:
    print('dont `code` :', bloc[1].count('[code/'))
EOF
```

Expected : les sorties `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10` et `forme/backtick-isole` **absentes**. `expl/paraphrase-litterale` **strictement sous 18**, et sa part `code` strictement sous 10. Si elle est restée à 18, la passe n'a pas atteint son objectif pédagogique : le dire dans le rapport, ne pas republier une ligne de base qui prétend le contraire.

- [ ] **Step 2: Écrire l'en-tête et la synthèse du rapport**

En tête de `Tools/audit-2026-08-passe-3.md`, avant les sections de domaine :

```markdown
# Relecture des 255 questions `code` — passe 3, août 2026

Troisième passe de contenu. La première ([`audit-2026-08.md`](audit-2026-08.md)) a
vérifié des valeurs et l'a consigné en prose ; la deuxième
([`audit-2026-08-passe-2.md`](audit-2026-08-passe-2.md)) a construit le registre de
fraîcheur, la carte de couverture et le registre d'images. Celle-ci lit chaque carte
`code` **contre sa ligne de registre** et la réécrit pour qui découvre la règle.

Spec : [`docs/superpowers/specs/2026-08-27-relecture-code-pedagogie-design.md`](../docs/superpowers/specs/2026-08-27-relecture-code-pedagogie-design.md).

## Ce que la passe a trouvé

| | nombre |
|---|---:|
| cartes relues | 255 |
| valeurs périmées corrigées | … |
| règles énoncées trop largement, resserrées | … |
| explications qui dépassaient l'article, coupées ou sourcées | … |
| doutes signalés sans correction | … |
| sources rouvertes (déclenchement de l'étape 3) | … |
| explications sous 120 caractères | 24 → … |
| fuites d'une carte vers une autre, trouvées et éteintes | … |

## Ce que la passe n'a pas fait, et pourquoi

- Les 193 questions `swift` : hors périmètre de la demande.
- Le plafond de 220 caractères des 49 illustrées : **tenu**. Les cartes où il a limité
  l'explication sont nommées domaine par domaine — c'est un régime pédagogique à deux
  vitesses, assumé, pas un oubli.
- La génération depuis les pages de cours, seule chose qui fera un feed infini (§10 de la
  passe 2). 255 cartes meilleures ne font pas plus de cartes.
```

- [ ] **Step 3: Ajouter au rapport les angles morts et ce qui reste ouvert**

Deux sections finales, sur le modèle du §7 et du §9.5 de la passe 2 :

```markdown
## Ce que l'outillage ne voit toujours pas

| n° | angle mort | ligne d'outil |
|---|---|---|

## Constats parqués

| n° | tâche | constat | statut |
|---|---|---|---|
```

Y verser en particulier : les recouvrements que `--fuites` remonte **sous** le seuil de trois mots pleins (le seuil a été choisi pour la lisibilité, pas parce que deux mots ne fuient jamais), et tout écart de justesse laissé ouvert faute de source de rang 1.

- [ ] **Step 4: Republier la ligne de base dans `Tools/questions.md`**

Au §3, remplacer le bloc de code de la ligne de base par les chiffres de l'étape 1, en datant la mesure du jour de la passe. Conserver les deux faux positifs connus **avec leur explication** (`lettre/reference` : lettre ancrée par l'énoncé ; `forme/markdown` : `/** */` dans un code span) — ils ne sont pas des dettes, et les effacer ferait chercher un bug inexistant à la passe suivante. Conserver aussi l'avertissement sur `forme/backtick-isole`, dont le zéro ne prouve rien sur un lot sans code span.

- [ ] **Step 5: Republier la ligne de base dans `CLAUDE.md`**

Le paragraphe de la section « Commandes » qui commence par « `audit.py` **sort toujours 0** » porte la ligne de base en prose : `longueur/plus-longue` (97), `expl/paraphrase-litterale` (18), `forme/seule-ponctuee` (14) et les deux faux positifs. Y porter les nouveaux chiffres, et **ajouter une phrase** disant que la baisse de `expl/paraphrase-litterale` est le résultat voulu de la passe 3, pas une dérive de mesure. Sans cette phrase, un chiffre qui baisse sans raison écrite se lit comme une erreur.

- [ ] **Step 6: Vérifier que les trois endroits disent la même chose**

Run :

```bash
grep -nE 'paraphrase-litterale|plus-longue|seule-ponctuee' CLAUDE.md Tools/questions.md
python3 Tools/audit.py | grep -E '^### '
```

Expected : les chiffres cités dans `CLAUDE.md` et dans `Tools/questions.md` **identiques** à ceux du rapport d'`audit.py`. Trois endroits qui portent la même valeur sont trois endroits à tenir cohérents : c'est le défaut qui a rendu `audit-questions.md` historique en une passe, et la seule défense est de les relire ensemble ici.

- [ ] **Step 7: Commit**

```bash
git add Tools/audit-2026-08-passe-3.md Tools/questions.md CLAUDE.md
git commit -m "$(cat <<'EOF'
Publish the pass report and the baseline it moved

Lowering expl/paraphrase-litterale was a goal of this pass, not
drift. Left unpublished, the next pass reads "18 expected", takes its
own good state for an unexplained improvement, and has nothing to stop
it climbing back.

Both faux positifs keep their explanation: they are not debt, and
erasing them would send the next pass hunting a bug that does not
exist.

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

### Tâche 17 : suite complète, revue de fin de branche, clôture

**Files:**
- Modify: aucun par défaut. Les corrections que la revue trouve se font dans les données et les registres, jamais dans les tests.

**Interfaces:**
- Consumes: tout ce qui précède.
- Produces: une branche prête à fusionner, dont la preuve est la suite entière et non les dix tests de contenu.

**Pourquoi la suite entière ici, et pas seulement à chaque domaine.** Les tâches de domaine lancent dix tests, ceux qui verrouillent le contenu livré. Les 54 autres — scheduler, répartition 70/30, persistance, view model — ne devraient rien voir d'une réécriture de texte. « Ne devraient pas » n'est pas « ne voient pas » : `QuestionBank.init` valide au chargement et rejette la banque entière en nommant l'id fautif, et plusieurs tests construisent leur banque depuis le fichier livré.

- [ ] **Step 1: Lancer la suite entière**

Run :

```bash
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl boot 'iPhone 17 Pro' 2>/dev/null || true
DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' 2>&1 | tail -40
```

Expected : `** TEST SUCCEEDED **` **et** `✔ Test run with 64 test(s)`. Les lignes `Executed 0 tests` de XCTest sont normales — Swift Testing rapporte à part. Un échec sur un test de contenu se corrige **dans les données**. Un échec sur un test de scheduler ou de persistance après une passe de texte n'est pas un faux positif : c'est probablement une banque devenue invalide au chargement, à lire dans le `ContentError`, qui nomme l'id.

- [ ] **Step 2: Relire le diff entier de la branche, à l'œil**

Run :

```bash
git diff --stat main...HEAD
git log --oneline main..HEAD
git diff main...HEAD -- Tools/sources.md | head -200
```

Chercher trois choses que ni `audit.py` ni les tests ne voient : une ligne de `sources.md` dont la **date** a bougé sans que l'`affirmation` change (une date atteste une lecture — la déplacer sans avoir lu est faux), une `affirmation` élargie pour légitimer une carte au lieu de l'inverse (le registre suit la source, pas la carte), et deux cartes voisines qui se contredisent.

- [ ] **Step 3: Vérifier que rien d'interdit n'a bougé**

Run :

```bash
git diff main...HEAD --stat -- Tools/audit.py ValidoTests/
python3 - <<'EOF'
import json, subprocess
avant = json.loads(subprocess.run(['git', 'show', 'main:Valido/Resources/questions.json'],
                                  capture_output=True, text=True).stdout)
apres = json.load(open('Valido/Resources/questions.json'))
a = {q['id'] for q in avant}
b = {q['id'] for q in apres}
print('mêmes ids sur toute la branche :', a == b, '|', len(a), '->', len(b))
print('code :', sum(1 for q in apres if q['subject'] == 'code'),
      '| illustrées :', sum(1 for q in apres if q.get('illustration')))
import re
LETTRE = re.compile(r'^[A-D]\s*[—–\-.)]')
for q in apres:
    for t in [q['explanation']] + [o['text'] for o in q['options']]:
        if LETTRE.match(t):
            print('!! référence de lettre', q['id'], t[:40])
EOF
```

Expected : **aucune ligne** pour `Tools/audit.py` ni `ValidoTests/` — un seuil relâché est un échec de la passe, quelle qu'en soit la raison. Puis `mêmes ids sur toute la branche : True | 448 -> 448`, `code : 255 | illustrées : 49`, et aucune ligne `!!`.

- [ ] **Step 4: Demander une revue de code**

**REQUIRED SUB-SKILL:** `superpowers:requesting-code-review`. Le périmètre à donner au relecteur : le diff `main...HEAD`, la spec, et les trois questions de l'étape 2 — ce sont celles qu'aucun outil ne couvre. Traiter le retour avec `superpowers:receiving-code-review` : une objection se vérifie avant de s'implémenter.

- [ ] **Step 5: Clôturer la branche**

**REQUIRED SUB-SKILL:** `superpowers:finishing-a-development-branch`. Ne pas fusionner sans avoir montré à Guillaume la ligne `✔ Test run with 64 test(s)` de l'étape 1 et le tableau de synthèse du rapport : la preuve précède l'annonce.

---

## Self-review du plan

Fait après rédaction, contre la spec.

**Couverture de la spec.** Les deux défauts du « Problème » sont pris par les tâches 2 à 14 (étapes 3-4 pour la justesse, étape 5 pour la pédagogie). Les trois écarts de justesse et les quatre critères pédagogiques sont dans les Global Constraints, donc dans chaque tâche. Le budget des illustrées est tenu par l'étape 9 de chaque tâche de domaine et vérifié une dernière fois en tâche 17 étape 3. « Ce qui bouge en même temps que les questions » : `sources.md` en étape 8 de chaque domaine, `couverture.md` en tâche 15, le rapport en étape 8 puis tâche 16. L'angle mort de la fuite carte-à-carte a son outil (tâche 1) et son étape (7) partout. Le « non-problème écarté » — ne pas rouvrir 130 URL — est encodé comme condition de déclenchement à l'étape 3.

**Un écart assumé avec la spec.** La spec dit que la passe n'ajoute pas d'outillage ; la tâche 1 ajoute `Tools/relire.py`. La raison est dans la tâche : la procédure de la spec demande de rapprocher deux fichiers 255 fois, et un sous-agent frais ne peut hériter d'aucun script de session. L'outil est en lecture seule et l'étape 4 le prouve.

**Deux points que le plan ne peut pas trancher d'avance.** Le nombre d'écarts de justesse par domaine est inconnu — un domaine peut n'en avoir aucun, et les tableaux du rapport prévoient ce cas en exigeant une phrase plutôt qu'un tableau vide. Et le seuil de trois mots pleins de `--fuites` est un compromis mesuré, pas une garantie : ce qu'il laisse passer est versé aux angles morts en tâche 16 étape 3.

**Chiffres du plan, tous relevés sur la banque du 2026-08-27** : 448 questions, 255 `code`, 49 illustrées, 130 lignes `datée`, 24 explications `code` sous 120 caractères, 74 portant un absolu, 188 `id` égaux au hachage de leur énoncé, 64 tests dans la suite, 10 tests de contenu livré.
