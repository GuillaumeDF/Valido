# Illustrations, gloses et raisons — plan d'implémentation

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Corriger, domaine par domaine, les quatre défauts que treize captures d'usage ont
révélés — l'énoncé qui décrit ce qu'une image devrait montrer, la configuration spatiale
laissée en texte, les gloses à côté de la plaque, et les bonnes réponses sans leur raison.

**Architecture :** Deux outils d'abord (mesure de luminance, préparation d'un imageset
photographique), rodés sur un panneau unique ; puis onze passes de domaine, chacune un
commit, chacune portant les quatre corrections sur toutes ses cartes en une seule écriture.
Un panneau devient une photographie Wikimedia Commons ; un marquage et une configuration
restent des schémas CoreGraphics.

**Tech Stack :** Python 3 (`audit.py`, `relire.py`, outils neufs — Pillow via `uv run
--with pillow`), Swift/CoreGraphics pour les scènes (`Tools/Scenes/`, rendu par
`./Tools/render-scenes.sh`), Swift Testing pour la suite `ValidoTests`.

**Spec :** [`docs/superpowers/specs/2026-09-22-illustrations-gloses-raisons-design.md`](../specs/2026-09-22-illustrations-gloses-raisons-design.md)

## Global Constraints

- **Aucun `id` ne se recalcule.** `id` vaut `sha256("valido-v2:" + prompt)[:32]` **à la
  création** de la carte, jamais après. Soixante-et-un énoncés changent ; les 464 `id`
  restent identiques au bit près.
- **Seuils d'une carte illustrée, imposés deux fois** (par `Tools/audit.py` et par le test
  `leBudgetDeHauteurDesQuestionsIllustréesEstTenu`) : énoncé **70** caractères, chaque
  option **50**, explication **220**. `alt` : **40** caractères au moins.
- **Garde-fou :** une carte qui n'atteint pas 220 caractères d'explication sans perdre sa
  raison **n'est pas illustrée**. Elle reste en texte et le rapport la nomme.
- **Un panneau se photographie, un marquage et une configuration se dessinent.** Les
  panneaux plantés dans les scènes composites (`carrefour-stop`, `carrefour-route-prioritaire`,
  `carrefour-cedez-le-passage`, scènes de vitesse) restent en CoreGraphics.
- **Aucun code de l'app n'est touché** : ni `QuestionCardView`, ni `FeedView`, ni
  `CardScheduler`, ni `SchedulerConfig`. `Tools/Scenes/` n'est pas compilé dans la cible.
- **Résolution d'une photographie** : au moins **1 152 px** sur le grand côté après
  recadrage 4:3 (la taille @3x du bandeau). En dessous, le panneau garde son dessin.
- **Licence d'une photographie** : domaine public ou Creative Commons uniquement. Auteur,
  licence, URL et résolution d'origine dans `Tools/images.md`.
- **Format de `questions.json`** : `json.dump(questions, f, ensure_ascii=False, indent=2,
  sort_keys=True)`. Aucune autre écriture.
- **Ligne de base de `audit.py` au 2026-09-22, sur 464 questions** — c'est à elle qu'on
  compare, jamais à zéro :

  | compteur | valeur | nature |
  |---|---:|---|
  | `lettre/reference` | 1 | faux positif connu |
  | `forme/definitionnel` | 98 | informatif |
  | `forme/hors-situation` | 216 | informatif |
  | `forme/impersonnel` | 215 | informatif |
  | `forme/markdown` | 1 | faux positif connu |
  | `forme/seule-ponctuee` | 14 | informatif |
  | `longueur/plus-longue` | 76 | informatif |
  | `expl/paraphrase-litterale` | 20 | informatif, **ne se minimise pas** |

  Doivent rester **absents de la sortie** : `schema/`, `couverture/`, `source/`, `fuite/`,
  `image/`, `longueur/plus-10`, `forme/backtick-isole`, `notions/non-declaree`,
  `notions/sans-fondation`, `notions/carte-orpheline`.
- **Le simulateur se démarre à la main**, et on vise l'UDID, jamais le nom :

  ```bash
  DEVELOPER_DIR=/Applications/Xcode-27.0.0.app xcrun simctl boot 66921B37-1805-4988-AB69-B51A94490BC0
  ```
- **`-only-testing` exige les parenthèses** — sans elles, 0 test tourne et `** TEST
  SUCCEEDED **` s'affiche quand même. Lire la ligne `✔ Test run with N test(s)`.
- **Commentaires, docs et noms de tests en français** ; types, API et messages de commit en
  anglais. Pas de commentaire si le code suffit à comprendre.

## Review Focus

Cinq façons dont cette passe peut casser quelque chose que rien ne teste aujourd'hui. Chaque
ligne reçoit son test dans la tâche qui possède le code.

1. **Un `id` recalculé après un énoncé réécrit** efface la progression de la carte sans
   qu'aucune sortie ne bronche — le JSON reste valide, l'app démarre, l'historique de
   l'utilisateur pointe dans le vide. → test dans la **tâche 1**.
2. **Un imageset photographique sans variante sombre** s'affiche en rectangle blanc
   éblouissant dans une app en mode sombre ; `audit.py` ne regarde que l'existence du
   dossier. → contrôle `image/variante-sombre-absente` dans la **tâche 2**.
3. **Un imageset à qui il manque une échelle** (`@2x` absent, `@3x` présent) se résout quand
   même — `UIImage(named:)` retombe sur l'autre échelle — et l'app affiche une image
   rééchantillonnée, floue, sans que le test d'asset échoue. → contrôle
   `image/echelle-manquante` dans la **tâche 2**.
4. **Une photographie sans auteur ni licence dans `images.md`** passe le contrôle de
   provenance actuel, qui ne teste que la présence du nom d'asset. L'image devient
   impossible à re-sourcer et non diffusable. → contrôle `image/licence-absente` dans la
   **tâche 2**.
5. **Un énoncé qui décrit encore l'objet après l'arrivée de l'image** rend la carte
   soluble sans regarder — le défaut d'origine, simplement déplacé. → contrôle
   `image/enonce-decrit-l-objet` dans la **tâche 3**.

---

### Task 1: L'outil de mesure de luminance, et le gel des identifiants

**Files:**
- Create: `Tools/luminance.py`
- Create: `Tools/test_luminance.py`
- Modify: `ValidoTests/BundledContentTests.swift` (ajout d'un test en fin de fichier)

**Interfaces:**
- Consumes: rien.
- Produces: `luminance(pixel) -> float`, `point(im, x, y) -> float`,
  `zone(im, x, y, cote) -> tuple[float, float, float]` (moyenne, min, max), et le CLI
  `uv run --with pillow Tools/luminance.py <image> [--point X,Y]... [--zone X,Y,COTE]...`
  qu'utilisent les tâches 2 et 3 pour tout relevé de niveaux de gris.

- [ ] **Step 1: Écrire le test qui échoue**

```python
# Tools/test_luminance.py
import unittest

from PIL import Image

from luminance import luminance, point, zone


class Luminance(unittest.TestCase):
    def testLeBlancVaut255EtLeNoirZero(self):
        self.assertAlmostEqual(luminance((255, 255, 255)), 255.0, places=3)
        self.assertAlmostEqual(luminance((0, 0, 0)), 0.0, places=3)

    def testLaPondérationEstCelleDeRec709PasRec601(self):
        # Rec. 601 donnerait 76,245 sur le rouge pur et 149,685 sur le vert.
        self.assertAlmostEqual(luminance((255, 0, 0)), 54.213, places=3)
        self.assertAlmostEqual(luminance((0, 255, 0)), 182.376, places=3)
        self.assertAlmostEqual(luminance((0, 0, 255)), 18.411, places=3)

    def testUnPointSeLitAuxCoordonnéesDonnées(self):
        im = Image.new("RGB", (4, 4), (0, 0, 0))
        im.putpixel((3, 1), (255, 255, 255))
        self.assertAlmostEqual(point(im, 3, 1), 255.0, places=3)
        self.assertAlmostEqual(point(im, 0, 0), 0.0, places=3)

    def testUneZoneRendMoyenneMinEtMax(self):
        im = Image.new("RGB", (4, 4), (0, 0, 0))
        for x in range(2):
            im.putpixel((x, 0), (255, 255, 255))
        moyenne, mini, maxi = zone(im, 0, 0, 2)
        self.assertAlmostEqual(moyenne, 127.5, places=3)
        self.assertAlmostEqual(mini, 0.0, places=3)
        self.assertAlmostEqual(maxi, 255.0, places=3)

    def testUneImageÀCanalAlphaSeLitQuandMême(self):
        im = Image.new("RGBA", (2, 2), (255, 0, 0, 128))
        self.assertAlmostEqual(point(im, 0, 0), 54.213, places=3)


if __name__ == "__main__":
    unittest.main()
```

- [ ] **Step 2: Lancer le test pour le voir échouer**

```bash
cd /Users/guillaume/Developer/Swift/Valido/Tools
uv run --with pillow python -m unittest test_luminance -v
```

Attendu : `ModuleNotFoundError: No module named 'luminance'`.

- [ ] **Step 3: Écrire `Tools/luminance.py`**

```python
#!/usr/bin/env python3
"""Relevé de luminance sur une image livrée.

Rec. 709 — `Y = 0,2126 R + 0,7152 G + 0,0722 B` — jamais Rec. 601 : c'est la
convention de tous les relevés de `images.md`, et les deux formules divergent de
vingt points sur un rouge de panneau.

    uv run --with pillow Tools/luminance.py image.png --point 251,138 --zone 100,100,30
"""
import argparse

from PIL import Image


def luminance(pixel):
    r, g, b = pixel[:3]
    return 0.2126 * r + 0.7152 * g + 0.0722 * b


def point(im, x, y):
    return luminance(im.convert("RGB").getpixel((x, y)))


def zone(im, x, y, cote):
    rgb = im.convert("RGB")
    valeurs = [
        luminance(rgb.getpixel((i, j)))
        for i in range(x, x + cote)
        for j in range(y, y + cote)
    ]
    return sum(valeurs) / len(valeurs), min(valeurs), max(valeurs)


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("image")
    ap.add_argument("--point", action="append", default=[], metavar="X,Y")
    ap.add_argument("--zone", action="append", default=[], metavar="X,Y,COTE")
    args = ap.parse_args()

    im = Image.open(args.image)
    print(f"{args.image} — {im.width} × {im.height}")
    for spec in args.point:
        x, y = (int(v) for v in spec.split(","))
        print(f"  point {x},{y} : {point(im, x, y):.1f}")
    for spec in args.zone:
        x, y, cote = (int(v) for v in spec.split(","))
        moyenne, mini, maxi = zone(im, x, y, cote)
        print(f"  zone {x},{y} ({cote}×{cote}) : moyenne {moyenne:.1f}, "
              f"min {mini:.1f}, max {maxi:.1f}")


if __name__ == "__main__":
    main()
```

- [ ] **Step 4: Lancer le test pour le voir passer**

```bash
cd /Users/guillaume/Developer/Swift/Valido/Tools
uv run --with pillow python -m unittest test_luminance -v
```

Attendu : `Ran 5 tests` puis `OK`.

- [ ] **Step 5: Geler les identifiants livrés (Review Focus n°1)**

Relever l'empreinte courante :

```bash
cd /Users/guillaume/Developer/Swift/Valido
python3 -c "
import hashlib, json
ids = sorted(q['id'] for q in json.load(open('Valido/Resources/questions.json')))
print(len(ids), hashlib.sha256('\n'.join(ids).encode()).hexdigest())
"
```

Noter les deux valeurs, puis ajouter à la fin de `ValidoTests/BundledContentTests.swift`,
en remplaçant `<COMPTE>` et `<EMPREINTE>` par ce que la commande vient d'imprimer :

```swift
/// Un `id` est la clé de la progression : le renommer efface silencieusement ce qu'un
/// utilisateur a déjà répondu. Comme `id` se calcule depuis le `prompt`, une passe qui
/// réécrit des énoncés est exactement l'occasion de le recalculer par réflexe. Cette
/// empreinte est là pour que ce réflexe échoue bruyamment.
@Test func lesIdentifiantsLivrésSontStables() throws {
    let bank = try QuestionBank.bundled()
    let ids = bank.questions.map(\.id).sorted()
    #expect(ids.count == <COMPTE>)
    let empreinte = SHA256.hash(data: Data(ids.joined(separator: "\n").utf8))
    #expect(empreinte.map { String(format: "%02x", $0) }.joined() == "<EMPREINTE>")
}
```

Ajouter `import CryptoKit` en tête du fichier s'il n'y est pas.

- [ ] **Step 6: Lancer le test Swift pour le voir passer**

```bash
cd /Users/guillaume/Developer/Swift/Valido
DEVELOPER_DIR=/Applications/Xcode-27.0.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,id=66921B37-1805-4988-AB69-B51A94490BC0' \
  -only-testing:'ValidoTests/lesIdentifiantsLivrésSontStables()' 2>&1 | grep -E "✔|✘|Test run"
```

Attendu : `✔ Test run with 1 test(s)`. **Si la ligne dit 0 test, les parenthèses manquent.**

- [ ] **Step 7: Vérifier que le test mord**

Changer temporairement un `id` dans `questions.json`, relancer la commande du step 6,
constater l'échec, puis annuler avec `git checkout Valido/Resources/questions.json`.

- [ ] **Step 8: Commit**

```bash
git add Tools/luminance.py Tools/test_luminance.py ValidoTests/BundledContentTests.swift
git commit -m "Measure luminance with one tool, and freeze the shipped ids

Every grayscale reading in images.md was taken ad hoc; this pass takes
dozens more, so the formula moves into a tested tool. Rec. 709, never
Rec. 601 — the two disagree by twenty points on a sign's red.

The id fingerprint guards the one silent failure this pass can cause:
ids are derived from prompts, sixty-one prompts change, and recomputing
them would orphan every answer a user has given.

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>"
```

---

### Task 2: Le protocole photographique, rodé sur le B21b

**Files:**
- Create: `Tools/photo-panneau.py`
- Create: `Valido/Assets.xcassets/Scenes/panneau-b21b-tout-droit.imageset/` (contenu remplacé)
- Modify: `Tools/audit.py` (trois contrôles neufs)
- Modify: `Tools/images.md` (section « Photographies »)
- Modify: `Valido/Resources/questions.json` (carte `37fe1af42b8d8174a3c3e94967027ed1`)

**Interfaces:**
- Consumes: `Tools/luminance.py` (tâche 1).
- Produces: `uv run --with pillow Tools/photo-panneau.py <source> <asset> --centre X,Y
  --largeur W`, qui écrit un `.imageset` complet (quatre JPEG + `Contents.json`) ; et trois
  compteurs d'audit — `image/variante-sombre-absente`, `image/echelle-manquante`,
  `image/licence-absente` — que toutes les tâches suivantes doivent garder vides.

- [ ] **Step 1: Écrire le script de préparation**

```python
#!/usr/bin/env python3
"""Prépare un imageset photographique à partir d'une source Commons.

    uv run --with pillow Tools/photo-panneau.py source.jpg panneau-b21b-tout-droit \
        --centre 1840,1120 --largeur 2400

Recadre en 4:3 autour du centre donné, sort les deux échelles, et dérive la
variante sombre. `sips` ne sait pas baisser une luminosité, d'où Pillow.
"""
import argparse
import json
import os

from PIL import Image, ImageEnhance

# La taille @3x du bandeau sur l'iPhone visé : 378 pt de large, ratio 4:3.
LARGEUR_3X, HAUTEUR_3X = 1152, 864
LARGEUR_2X, HAUTEUR_2X = 768, 576
QUALITE = 82
# Le mode sombre d'une photographie est dérivé, pas photographié : une image
# livrée telle quelle éblouit dans une app sombre.
EXPOSITION_SOMBRE = 0.62

SCENES = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                      '..', 'Valido', 'Assets.xcassets', 'Scenes')


def recadre(im, cx, cy, largeur):
    hauteur = round(largeur * 3 / 4)
    gauche, haut = cx - largeur // 2, cy - hauteur // 2
    if gauche < 0 or haut < 0 or gauche + largeur > im.width or haut + hauteur > im.height:
        raise SystemExit(f"recadrage hors de l'image ({im.width} × {im.height})")
    if largeur < LARGEUR_3X:
        raise SystemExit(f"recadrage de {largeur} px : il en faut {LARGEUR_3X}")
    return im.crop((gauche, haut, gauche + largeur, haut + hauteur))


def ecris(im, chemin, taille):
    im.resize(taille, Image.LANCZOS).convert("RGB").save(
        chemin, "JPEG", quality=QUALITE, optimize=True)


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("source")
    ap.add_argument("asset")
    ap.add_argument("--centre", required=True, metavar="X,Y")
    ap.add_argument("--largeur", required=True, type=int)
    args = ap.parse_args()

    cx, cy = (int(v) for v in args.centre.split(","))
    clair = recadre(Image.open(args.source), cx, cy, args.largeur)
    sombre = ImageEnhance.Brightness(clair).enhance(EXPOSITION_SOMBRE)

    dossier = os.path.join(SCENES, args.asset + ".imageset")
    os.makedirs(dossier, exist_ok=True)
    for im, nom in ((clair, "clair"), (sombre, "sombre")):
        ecris(im, os.path.join(dossier, f"{nom}@3x.jpg"), (LARGEUR_3X, HAUTEUR_3X))
        ecris(im, os.path.join(dossier, f"{nom}@2x.jpg"), (LARGEUR_2X, HAUTEUR_2X))

    contents = {"images": [
        {"filename": "clair@2x.jpg", "idiom": "universal", "scale": "2x"},
        {"filename": "clair@3x.jpg", "idiom": "universal", "scale": "3x"},
        {"appearances": [{"appearance": "luminosity", "value": "dark"}],
         "filename": "sombre@2x.jpg", "idiom": "universal", "scale": "2x"},
        {"appearances": [{"appearance": "luminosity", "value": "dark"}],
         "filename": "sombre@3x.jpg", "idiom": "universal", "scale": "3x"},
    ], "info": {"author": "xcode", "version": 1}}
    with open(os.path.join(dossier, "Contents.json"), "w") as f:
        json.dump(contents, f, indent=2)
        f.write("\n")
    print(f"{args.asset} : quatre JPEG écrits dans {dossier}")


if __name__ == "__main__":
    main()
```

- [ ] **Step 2: Sourcer la photographie du B21b**

Ouvrir `https://commons.wikimedia.org/wiki/Category:B21b_(road_sign,_France)`. Retenir un
fichier qui satisfait **les quatre critères**, sans exception :

1. le panneau est vu de face, non déformé par la perspective ;
2. il est le sujet principal du cadre ;
3. la largeur du recadrage 4:3 possible autour de lui fait **au moins 1 152 px** ;
4. la licence est domaine public ou Creative Commons.

Télécharger, en remplaçant `<FICHIER>` par le nom exact du fichier Commons :

```bash
mkdir -p /private/tmp/claude-501/-Users-guillaume-Developer-Swift-Valido/465ec398-d8fb-4e3e-b08e-ec6faab56789/scratchpad/photos
curl -L -o /private/tmp/claude-501/-Users-guillaume-Developer-Swift-Valido/465ec398-d8fb-4e3e-b08e-ec6faab56789/scratchpad/photos/b21b.jpg \
  "https://commons.wikimedia.org/wiki/Special:FilePath/<FICHIER>"
uv run --with pillow python -c "
from PIL import Image
im = Image.open('/private/tmp/claude-501/-Users-guillaume-Developer-Swift-Valido/465ec398-d8fb-4e3e-b08e-ec6faab56789/scratchpad/photos/b21b.jpg')
print(im.width, 'x', im.height)"
```

Si la largeur est sous 1 152 px, **reprendre un autre fichier de la catégorie**. Si la
catégorie n'en offre aucun, le B21b garde son dessin : noter la meilleure résolution
trouvée pour le rapport de la tâche 14, et passer au step 5 sans remplacer l'imageset.

- [ ] **Step 3: Produire l'imageset**

```bash
cd /Users/guillaume/Developer/Swift/Valido
rm -f Valido/Assets.xcassets/Scenes/panneau-b21b-tout-droit.imageset/*.png
uv run --with pillow Tools/photo-panneau.py \
  /private/tmp/claude-501/-Users-guillaume-Developer-Swift-Valido/465ec398-d8fb-4e3e-b08e-ec6faab56789/scratchpad/photos/b21b.jpg \
  panneau-b21b-tout-droit --centre <X>,<Y> --largeur <W>
ls Valido/Assets.xcassets/Scenes/panneau-b21b-tout-droit.imageset/
```

Attendu : `Contents.json`, `clair@2x.jpg`, `clair@3x.jpg`, `sombre@2x.jpg`, `sombre@3x.jpg`,
et **aucun `.png`**.

- [ ] **Step 4: Relever les niveaux de gris, dans les deux modes**

```bash
cd /Users/guillaume/Developer/Swift/Valido
for mode in clair sombre; do
  uv run --with pillow Tools/luminance.py \
    Valido/Assets.xcassets/Scenes/panneau-b21b-tout-droit.imageset/$mode@3x.jpg \
    --zone 540,400,40 --zone 40,40,40
done
```

La première zone vise le centre du panneau, la seconde un coin de fond. Noter les quatre
moyennes : elles vont dans `images.md` au step 7. **Le panneau doit se détacher du fond
d'au moins 25 points dans les deux modes** ; sinon, recadrer plus serré et recommencer.

- [ ] **Step 5: Écrire les trois contrôles d'audit qui échouent**

Dans `Tools/audit.py`, à l'intérieur du bloc `# --- illustration ---`, juste après la ligne
qui lève `image/provenance-absente` :

```python
        else:
            dossier = os.path.join(SCENES, asset + '.imageset')
            fichiers = set(os.listdir(dossier))
            # Un imageset photographique sert un JPEG ; un schéma, quatre PNG. Les deux
            # doivent porter leurs deux échelles et leur variante sombre : une échelle
            # manquante se résout quand même, en rééchantillonnant — l'app affiche flou
            # sans que rien n'échoue.
            for echelle in ('@2x', '@3x'):
                if not any(echelle in f for f in fichiers):
                    flag('image/echelle-manquante', q, f'{asset} : {echelle}')
            if not any(f.startswith('sombre') for f in fichiers):
                flag('image/variante-sombre-absente', q, asset)
            if asset in PHOTOS and not LICENCES.get(asset):
                flag('image/licence-absente', q, f'{asset} : ni auteur ni licence dans images.md')
```

Et près de la lecture de `images.md` (autour de la ligne 76), après la construction de
`RECENSES` :

```python
# Une ligne de la section « Photographies » porte cinq colonnes : asset, source, auteur,
# licence, date. Sans auteur ni licence, l'image n'est ni re-sourçable ni diffusable, et le
# contrôle de provenance seul ne le voit pas — il ne teste que le nom.
PHOTOS, LICENCES = set(), {}
for ligne in open(IMAGES_MD, encoding='utf-8'):
    cellules = [c.strip() for c in ligne.split('|')]
    if len(cellules) >= 7 and cellules[1].startswith('`') and 'commons.wikimedia.org' in ligne:
        nom = cellules[1].strip('`')
        PHOTOS.add(nom)
        LICENCES[nom] = bool(cellules[3]) and bool(cellules[4])
```

- [ ] **Step 6: Faire mordre les trois contrôles, un par un**

Chacun se prouve en cassant ce qu'il surveille, puis en restaurant. Soit
`IS=Valido/Assets.xcassets/Scenes/panneau-b21b-tout-droit.imageset`.

**`image/variante-sombre-absente`** :

```bash
cd /Users/guillaume/Developer/Swift/Valido
IS=Valido/Assets.xcassets/Scenes/panneau-b21b-tout-droit.imageset
mv $IS/sombre@2x.jpg $IS/sombre@3x.jpg /tmp/
python3 Tools/audit.py | grep -E "^### image/"
```

Attendu : `### image/variante-sombre-absente  (1)` **et** `### image/echelle-manquante  (0)`
absent — les deux échelles claires sont toujours là. Restaurer :

```bash
mv /tmp/sombre@2x.jpg /tmp/sombre@3x.jpg $IS/
```

**`image/echelle-manquante`** :

```bash
mv $IS/clair@3x.jpg $IS/sombre@3x.jpg /tmp/
python3 Tools/audit.py | grep -A2 "^### image/echelle-manquante"
```

Attendu : le compteur nomme `@3x`. Restaurer :

```bash
mv /tmp/clair@3x.jpg /tmp/sombre@3x.jpg $IS/
```

**`image/licence-absente`** : vider temporairement les colonnes auteur et licence de la
ligne `panneau-b21b-tout-droit` dans `Tools/images.md`, relancer
`python3 Tools/audit.py | grep -A2 "^### image/licence-absente"`, constater le compteur,
puis `git checkout Tools/images.md` ne suffisant pas (le fichier n'est pas encore commité),
remettre les deux valeurs à la main.

Une fois les trois restaurés, `python3 Tools/audit.py | grep -E "^### image/"` ne doit plus
rien imprimer.

- [ ] **Step 7: Écrire la ligne de provenance**

Dans `Tools/images.md`, section « Photographies », ajouter une colonne `résolution
d'origine` à l'en-tête du tableau et une ligne pour le B21b :

```markdown
| asset | source | auteur | licence | relevé le | résolution d'origine |
|---|---|---|---|---|---|
| `panneau-b21b-tout-droit` | [Commons — <TITRE>](<URL>) | <AUTEUR> | <LICENCE> | 2026-09-22 | <W> × <H> |
```

Compléter les deux photographies déjà présentes avec leur résolution d'origine, relevée
avec la même commande qu'au step 2.

- [ ] **Step 8: Réécrire la carte, transfert de la description vers l'image**

Dans `Valido/Resources/questions.json`, carte `37fe1af42b8d8174a3c3e94967027ed1`. Son `alt`
décrit aujourd'hui un dessin (« Disque à fond bleu bordé d'un listel blanc, portant une
flèche blanche dirigée vers le haut ») ; il doit décrire la photographie, rester au-dessus
de 40 caractères, et ne pas partager trois mots pleins avec l'énoncé. **Ne pas toucher à
l'`id`.**

- [ ] **Step 9: Lancer l'audit, la relecture et les tests**

```bash
cd /Users/guillaume/Developer/Swift/Valido
python3 Tools/audit.py | grep -E "^### "
python3 Tools/relire.py --fuites "Panneaux & marquage"
DEVELOPER_DIR=/Applications/Xcode-27.0.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,id=66921B37-1805-4988-AB69-B51A94490BC0' 2>&1 \
  | grep -E "✔|✘|Test run with"
```

Attendu : aucun compteur `image/`, `schema/`, `fuite/` ; les compteurs informatifs à leur
ligne de base ou expliqués ; `✔ Test run with 84 test(s)` — 83 avant la tâche 1, 84 après. La ligne « 64 tests » de `CLAUDE.md` est périmée et se corrige en tâche 14.

- [ ] **Step 10: Commit**

```bash
git add Tools/photo-panneau.py Tools/audit.py Tools/images.md \
  Valido/Assets.xcassets/Scenes/panneau-b21b-tout-droit.imageset \
  Valido/Resources/questions.json
git commit -m "Photograph one sign, and guard what the audit could not see

The B21b proves the whole protocol end to end: source from Commons,
crop 4:3, derive the dark variant, read the grayscale, record author
and licence. Its arrow was a needle where the real one is broad.

Three audit counters come with it. A missing scale still resolves, so
the app blurs silently; a missing dark variant blinds a dark-mode
reader; a photograph with no author cannot be re-sourced or shipped.

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>"
```

---

### Task 3: Domaine `Panneaux & marquage`

C'est le domaine le plus dense — treize cartes du périmètre mécanique, douze panneaux
dessinés à reprendre, et quatre des treize captures. Il rode le reste.

**Files:**
- Modify: `Valido/Resources/questions.json`
- Modify: `Tools/images.md`, `Tools/sources.md`, `Tools/questions.md`
- Modify: `Tools/audit.py` (un contrôle neuf)
- Create: imagesets photographiques sous `Valido/Assets.xcassets/Scenes/`
- Modify: `Tools/Scenes/ScenesPanneaux.swift` si une scène de marquage manque

**Interfaces:**
- Consumes: `Tools/photo-panneau.py` et `Tools/luminance.py` (tâches 1 et 2), les trois
  compteurs d'audit de la tâche 2.
- Produces: la règle de glose et la règle de famille écrites dans `Tools/questions.md`, que
  les tâches 4 à 13 appliquent sans les redécouvrir.

**Les treize cartes du périmètre mécanique :**

| id | énoncé | é / o / x |
|---|---|---|
| `6f086316c1ff1dfa49dce303862e2bc1` | Le fond jaune d'un panneau en fait : | 36 / 59 / 295 |
| `5abe2f7853853a6744f3a71425a0ba6e` | Le panonceau placé sous un panneau : | 36 / 59 / 361 |
| `f12ee5bea85947a13d387f574e817337` | Quand un panneau de chantier contredit un panneau permanent, le conducteur : | 76 / 49 / 235 |
| `3cb86b6e4c489d919a495408021f062a` | Rouler à cheval sur une ligne continue, sans la franchir, fait perdre : | 71 / 41 / 196 |
| `2113eaf703eec8a91ce135e3e96d8082` | Un panneau de forme carrée ou rectangulaire porte : | 51 / 41 / 457 |
| `37fe1af42b8d81059d80e8954b36ed7f` | Un panneau rond à bord rouge indique : | 38 / 35 / 266 |
| `37fe1af42b8d81699c2ffbefd648d9a3` | Un panneau rond à fond bleu, sans liseré rouge, indique : | 57 / 56 / 213 |
| `899646535894ff92314de8bbb12f769a` | Un panneau triangulaire à bord rouge, pointe en haut, annonce : | 63 / 41 / 356 |
| `37fe1af42b8d8141b1d0e3ca0b855119` | Une ligne continue au centre de la chaussée : | 45 / 49 / 264 |
| `37fe1af42b8d81f8a2f3f8bd2afc9d2d` | Une ligne discontinue (axiale) : | 32 / 60 / 231 |
| `5a4e6a38ad3e1153f807ec5e0e6ba40e` | Une ligne discontinue tracée le long du bord de la chaussée délimite : | 70 / 50 / 231 |
| `03041783e81ea879ebb18f4c75170754` | Une prescription signalée par un panneau s'applique : | 53 / 53 / 383 |
| `5f7e9145e72fe9c4830097af9e849196` | Une surface hachurée ou couverte de chevrons, et non un trait : | 63 / 57 / 397 |

**Les deux cartes nommées par les captures, déjà illustrées :**
`9e65525bbce6a6491d37bbf6f180c04c` (énoncé ambigu : ce qu'on double, pas ce qu'on est) et
`37fe1af42b8d8174a3c3e94967027ed1` (traitée en tâche 2).

**Les douze panneaux dessinés restants :** `panneau-a1a-virage`,
`panneau-a13b-passage-pietons`, `panneau-a14-panonceau`, `panneau-ab4-stop`,
`panneau-ab7-fin-priorite`, `panneau-b1-sens-interdit`, `panneau-b3-interdiction-depasser`,
`panneau-b31-fin-interdictions`, `panneau-b6a1-stationnement-interdit`,
`panneau-b6d-arret-interdit`, `panneau-c113-voie-velo`, `panneau-c1a-parking`.

- [ ] **Step 1: Écrire le contrôle qui interdit à un énoncé illustré de décrire l'objet**

Review Focus n°5. Dans `Tools/audit.py`, après le contrôle `image/enonce-redit-la-scene` :

```python
        # Le défaut d'origine de cette passe : un énoncé qui décrit la forme, la couleur
        # ou le liseré de ce que l'image montre se répond sans regarder l'image. Une fois
        # l'image posée, ces mots n'ont plus rien à faire dans l'énoncé.
        # `words` passe par `norm`, qui met en minuscules et dépouille les diacritiques :
        # ces clés s'écrivent donc sans accent, sinon aucune ne matche jamais.
        DESCRIPTEURS = {'rond', 'ronde', 'triangulaire', 'triangle', 'octogone',
                        'octogonal', 'losange', 'carre', 'carree', 'rectangulaire',
                        'lisere', 'listel', 'hachuree', 'chevrons', 'jaune', 'rouge',
                        'bleu', 'bleue', 'blanc', 'blanche'}
        décrits = DESCRIPTEURS & words(q['prompt'], n=3)
        if décrits:
            flag('image/enonce-decrit-l-objet', q, sorted(décrits))
```

- [ ] **Step 2: Lancer l'audit pour voir le contrôle mordre**

```bash
cd /Users/guillaume/Developer/Swift/Valido
python3 Tools/audit.py | grep -A6 "^### image/enonce-decrit-l-objet"
```

Attendu : le compteur apparaît et nomme au moins `9e65525bbce6a6491d37bbf6f180c04c` si son
énoncé porte encore un descripteur, plus toute carte illustrée en infraction. Noter la
liste : c'est le travail du step 4.

- [ ] **Step 3: Sourcer les douze photographies**

Pour chacun des douze panneaux, appliquer les huit points du protocole (spec §4, rodés en
tâche 2) : catégorie Commons `Category:<code> (road sign, France)`, quatre critères,
téléchargement, `photo-panneau.py`, relevé de luminance dans les deux modes, ligne dans
`images.md` avec auteur, licence, URL, date et résolution d'origine, puis **retrait de la
scène** du tableau `scenesPanneaux` et de sa fonction de dessin si plus rien ne l'appelle.

Ce dernier point n'est pas de l'hygiène : `Tools/Scenes/main.swift` parcourt le tableau sans
condition et réécrit `Contents.json` plus quatre PNG pour chaque scène inscrite. Un panneau
photographié qui garde sa scène voit sa photographie effacée au prochain
`./Tools/render-scenes.sh`. Le vérifier explicitement : lancer le script, puis `git status`
sur chaque imageset photographique — JPEG et `Contents.json` intacts, aucun PNG reparu.

Un panneau dont la catégorie n'offre aucune photographie à 1 152 px **garde son dessin** :
supprimer son imageset n'est pas une option, et sa meilleure résolution trouvée se note pour
le rapport.

- [ ] **Step 4: Réécrire les cartes**

Carte par carte, dans l'ordre du tableau ci-dessus, en appliquant les quatre corrections :

1. **Transfert.** Si la carte décrit un objet que le catalogue peut montrer, retirer la
   description de l'énoncé et poser l'`illustration`. `3cb86b6e…`, `f12ee5be…` et
   `03041783…` portent une règle sans objet à montrer : elles restent en texte.
2. **Famille.** `37fe1af42b8d81059d…`, `37fe1af42b8d81699c…`, `899646535894…`,
   `2113eaf703ee…`, `6f086316c1ff…`, `5abe2f785385…` portent une famille : elles
   s'illustrent par **trois instances côte à côte** — une nouvelle scène assemblée depuis
   `Tools/Scenes/Panneaux.swift`, qui les dessine déjà toutes — ou pas du tout.
3. **Budget.** Après transfert, vérifier 70 / 50 / 220. Une explication qui n'y arrive pas
   sans perdre sa raison **reste en texte** : noter le compte pour le rapport.
4. **Raison.** Lire les 33 cartes du domaine, pas seulement les treize : une bonne réponse
   qui surprend porte la raison de la règle, pas seulement son énoncé.

`5f7e9145…` (les chevrons) **ne peut pas** pointer `marquage-zebra` :
`37fe1af42b8d81d68a70da4a7305f6c1` l'utilise déjà, sur la même notion `marquage/zones`, et
la question voisine (« Ce marquage au sol : ») deviendrait indiscernable. Soit la carte
reçoit une scène distincte — une zone de chevrons où un véhicule est arrêté, puisque c'est
l'arrêt qu'elle interroge —, soit elle reste en texte. Son explication passe de 397 à 220
au plus, et si la raison n'y survit pas, c'est le texte qui gagne.

- [ ] **Step 5: Écrire les deux règles neuves dans `Tools/questions.md`**

Au §1, la règle de glose :

```markdown
### Une glose n'explique qu'un mot que l'app n'a jamais introduit

Et elle nomme ce que le candidat verrait, pas un synonyme. Trois formes à refuser :
la glose qui décrit l'objet — « (octogone rouge) », « (triangle pointe en bas) » — et
que l'image rend inutile ; la glose qui traduit le terme officiel en argot — « (codes) »,
« (warning) » — alors que c'est le terme officiel qu'on apprend ; et la glose qui redit
l'évident au lieu de porter ce qui manque, comme « — entre deux files de véhicules — »
sur une carte qui ne dit nulle part qu'elle parle d'un deux-roues motorisé.
```

Au §7, la règle de famille :

```markdown
### Une carte de famille montre la famille, ou rien

« Un panneau rond à bord rouge indique : » ne s'illustre pas avec un B1 : on apprendrait
le B1. Elle s'illustre avec trois instances de la famille côte à côte, ou elle reste en
texte. Si les trois signaux ne tiennent pas lisiblement dans la bande centrale — celle qui
survit au bandeau réduit à 18 % —, c'est le texte qui gagne.
```

- [ ] **Step 6: Mettre `sources.md` à jour**

Une carte dont l'**affirmation** change reçoit une ligne revue. Un énoncé raccourci sans
changement d'affirmation ne touche pas au registre.

- [ ] **Step 7: Lancer l'audit**

```bash
cd /Users/guillaume/Developer/Swift/Valido
python3 Tools/audit.py | grep -E "^### "
```

Attendu : aucun compteur commençant par `schema/`, `couverture/`, `source/`, `fuite/`,
`image/`, `notions/`, ni `longueur/plus-10`, ni `forme/backtick-isole`. Les informatifs se
comparent à la ligne de base des Global Constraints, et tout écart se note pour le rapport.

- [ ] **Step 8: Relire les fuites, à l'outil puis à la main**

```bash
cd /Users/guillaume/Developer/Swift/Valido
python3 Tools/relire.py --fuites "Panneaux & marquage"
```

L'outil ignore toute bonne réponse de moins de trois mots pleins, n'inspecte que les
`explanation` et jamais les options, et ne reconnaît pas une réponse redite autrement. Il
**nomme** les bonnes réponses qu'il n'a pas testées : grepper cette liste à la main dans
les explications du domaine, et lire les 33 cartes côte à côte.

- [ ] **Step 9: Lancer toute la suite**

```bash
cd /Users/guillaume/Developer/Swift/Valido
DEVELOPER_DIR=/Applications/Xcode-27.0.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,id=66921B37-1805-4988-AB69-B51A94490BC0' 2>&1 \
  | grep -E "✔|✘|Test run with"
```

Attendu : `✔ Test run with 84 test(s)`, aucun `✘`. Un échec de
`BundledContentTests` **se corrige dans les données, jamais dans le test** — sauf le seuil
d'illustrées, qui se relève en tâche 14.

- [ ] **Step 10: Commit**

```bash
git add -A Valido/Resources/questions.json Valido/Assets.xcassets/Scenes \
  Tools/images.md Tools/sources.md Tools/questions.md Tools/audit.py Tools/Scenes
git commit -m "Let the picture carry the sign in Panneaux & marquage

Thirteen cards described a sign or a marking in words and then asked the
reader to recognise what had just been described. The description moves
into the image, which is what makes the card unanswerable without it and
pays most of the height budget back.

Family cards show three instances or stay in text: one B1 would teach
the B1, not the family. A new counter refuses a prompt that still names
the shape or the colour of what its image shows.

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>"
```

---

### Task 4: Domaine `Priorités & intersections`

**Files:**
- Modify: `Valido/Resources/questions.json`, `Tools/images.md`, `Tools/sources.md`
- Create: imagesets photographiques et scènes sous `Tools/Scenes/ScenesCarrefour.swift`

**Interfaces:**
- Consumes: le protocole photographique (tâche 2), les règles de glose et de famille écrites
  dans `Tools/questions.md` (tâche 3).
- Produces: rien que les tâches suivantes consomment.

**Les quatorze cartes :**

| id | énoncé | lot | é / o / x |
|---|---|---|---|
| `37fe1af42b8d81bd9426eabc80ab4a05` | Le panneau STOP (octogone rouge) impose : | A, glose | 41 / 50 / 242 |
| `37fe1af42b8d8184beb9c6687c92ffb5` | Le panneau losange jaune barré signifie : | A | 41 / 43 / 170 |
| `37fe1af42b8d81d6aef7ff0b8d193d7f` | Le panneau losange jaune indique : | A | 34 / 44 / 168 |
| `37fe1af42b8d8161be32fe2fe9808fff` | Le panneau « Cédez le passage » (triangle pointe en bas) impose : | A, glose | 65 / 48 / 214 |
| `09f18973aee39386ee42782f04d03ec2` | Pour tourner à gauche hors d'une intersection réglée, vous devez : | B | 66 / 50 / 214 |
| `37fe1af42b8d817da9fff3054d6ffa3a` | Qui a l'autorité la plus élevée pour régler la circulation à un carrefour ? | B | 75 / 48 / 255 |
| `37fe1af42b8d815f8684e4cc91d6950f` | Un feu de circulation et un panneau de priorité se contredisent. Lequel suivez-vous ? | A | 85 / 30 / 260 |
| `b433eefe7ea3ce149e6d6dd09e958a00` | Un panonceau triangulaire à liseré rouge sous un feu tricolore autorise : | A | 73 / 63 / 257 |
| `37fe1af42b8d818293f3f8d862a5a505` | Un véhicule prioritaire (pompiers, SAMU) en intervention avec sirène et gyrophare : | glose | 83 / 51 / 281 |
| `e0f68dd1324f9a5ffaab945a3d59e197` | Un véhicule qui sort d'un parking pour rejoindre la chaussée : | B | 62 / 44 / 222 |
| `37fe1af42b8d81fa9debeaf114b7bf77` | Vous croisez une voie de tramway, hors intersection : | B | 53 / 68 / 162 |
| `37fe1af42b8d812fade7d79d309e4c48` | À l'approche d'un carrefour à sens giratoire (« vous n'avez pas la priorité »), vous devez : | B, glose | 92 / 49 / 259 |
| `2daf8939fc85f5b288010cf545bb681d` | À un rond-point qu'aucun panneau n'annonce, la priorité est : | A | 61 / 54 / 255 |
| `37fe1af42b8d818fb7c9efba6c63d91d` | À une intersection sans aucune signalisation, la priorité est : | B | 63 / 46 / 223 |

- [ ] **Step 1: Sourcer les photographies de panneau**

Protocole photographique de la spec (§4, les huit points), rodé en tâche 2 — sans oublier le point 8, **retirer la scène** du tableau de `Tools/Scenes/` et la fonction de dessin devenue orpheline, sinon `render-scenes.sh` réécrit la photo par le dessin, pour AB4 (STOP), AB3a (cédez le passage), AB6 et AB7
(losange jaune et losange barré) et M12 (panonceau cycliste). Catégories :
`Category:AB4 (road sign, France)`, `Category:AB3a (road sign, France)`,
`Category:AB6 (road sign, France)`, `Category:AB7 (road sign, France)`,
`Category:M12 (road sign, France)`. `panneau-ab4-stop` et `panneau-ab7-fin-priorite`
existent déjà en dessin et **servent déjà d'autres cartes** (`443e4299…` et `7d44f7dd…`) :
leur imageset passe en photographie, ce qui corrige ces deux cartes-là du même coup, mais
les cartes du tableau ci-dessus (`37fe1af42b8d81bd9426…`, `37fe1af42b8d8184beb9…`) reçoivent
**chacune leur propre** photographie — un autre cadrage, un autre exemplaire — ou restent en
texte. Aucun asset ne sert deux cartes.

- [ ] **Step 2: Dessiner les scènes de configuration manquantes**

Les cartes du lot B décrivent des configurations qu'aucune photographie ne montre : sortie
de parking, croisement de voie de tramway hors intersection, tourne-à-gauche hors
intersection réglée. Ajouter les scènes dans `Tools/Scenes/ScenesCarrefour.swift`, en
réutilisant `croisementNu`, `voiture` et les panneaux de `Panneaux.swift`, puis :

```bash
cd /Users/guillaume/Developer/Swift/Valido && ./Tools/render-scenes.sh
```

- [ ] **Step 3: Relever les niveaux de gris de chaque scène neuve**

```bash
cd /Users/guillaume/Developer/Swift/Valido
uv run --with pillow Tools/luminance.py \
  Valido/Assets.xcassets/Scenes/<asset>.imageset/clair@3x.png --zone <X>,<Y>,30
```

Aucune information ne doit reposer sur la couleur seule : l'élément décisif se distingue de
son fond d'au moins 25 points en luminance, en clair **et** en sombre.

- [ ] **Step 4: Réécrire les cartes**

Les quatre corrections sur les quatorze cartes, plus la lecture à la main des 26 cartes du
domaine pour le symptôme 4. Le transfert retire « (octogone rouge) », « (triangle pointe en
bas) », « triangulaire à liseré rouge » des énoncés ; l'explication de `b433eefe…` perd
« créé par l'arrêté du 12 janvier 2012 » et tombe à 185 caractères.

- [ ] **Step 5: Lancer l'audit**

```bash
cd /Users/guillaume/Developer/Swift/Valido
python3 Tools/audit.py | grep -E "^### "
```

Attendu : aucun compteur `schema/`, `couverture/`, `source/`, `fuite/`, `image/`,
`notions/`, `longueur/plus-10`, `forme/backtick-isole`.

- [ ] **Step 6: Relire les fuites, à l'outil puis à la main**

```bash
cd /Users/guillaume/Developer/Swift/Valido
python3 Tools/relire.py --fuites "Priorités & intersections"
```

Grepper à la main la liste des bonnes réponses que l'outil déclare ne pas avoir testées, et
lire les 26 cartes côte à côte.

- [ ] **Step 7: Lancer toute la suite**

```bash
cd /Users/guillaume/Developer/Swift/Valido
DEVELOPER_DIR=/Applications/Xcode-27.0.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,id=66921B37-1805-4988-AB69-B51A94490BC0' 2>&1 \
  | grep -E "✔|✘|Test run with"
```

- [ ] **Step 8: Commit**

```bash
git add -A Valido/Resources/questions.json Valido/Assets.xcassets/Scenes \
  Tools/images.md Tools/sources.md Tools/Scenes
git commit -m "Show the sign and the junction in Priorités & intersections

Four cards spelled out a sign's shape and colour before asking which one
it was. The M12 panonceau loses the 2012 decree date it never needed and
lands inside the height budget on the transfer alone.

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>"
```

---

### Task 5: Domaine `Feux`

**Files:**
- Modify: `Valido/Resources/questions.json`, `Tools/images.md`, `Tools/sources.md`
- Create: scènes sous `Tools/Scenes/ScenesCirculation.swift`

**Interfaces:**
- Consumes: le protocole photographique (tâche 2), les règles de `Tools/questions.md` (tâche 3).
- Produces: rien.

**Les huit cartes :**

| id | énoncé | lot | é / o / x |
|---|---|---|---|
| `37fe1af42b8d81fc9bbbee0a1767bba6` | Au feu jaune (orange) fixe, vous devez : | glose | 40 / 46 / 197 |
| `fc0333a5ae17dd22f31bbbe63d0e8824` | Dans une file de véhicules à allure fortement réduite, les feux de détresse s'imposent : | B | 88 / 49 / 229 |
| `1f62ee2f0d02611c04ed79a57b73412a` | De nuit, hors agglomération, vos deux feux de croisement s'éteignent : | B | 70 / 58 / 519 |
| `d5505e2b6bdcdeb78eecbec2a2a2a724` | De nuit, à l'arrêt sur une chaussée sans éclairage public, vous devez montrer, à l'avant et à l'arrière : | B | 105 / 60 / 226 |
| `6012289234e0766392ac505dbfdbd3ae` | Les feux avant de brouillard peuvent remplacer les feux de croisement : | B | 71 / 52 / 247 |
| `37fe1af42b8d8193887bfe48eab17d43` | Les feux de croisement (codes) sont obligatoires : | B, glose | 50 / 47 / 271 |
| `37fe1af42b8d81adbe05ccc6da87aef7` | Les feux de détresse (warning) servent à : | glose | 42 / 48 / 257 |
| `0ac1e53ac8978390a5725830ebcff433` | À une intersection tenue par un feu jaune clignotant, un cédez-le-passage : | B | 75 / 46 / 219 |

- [ ] **Step 1: Traiter les trois gloses inversées**

`(codes)`, `(warning)` et `(orange)` traduisent un terme officiel en argot. La règle écrite
en tâche 3 les refuse : soit la glose saute, soit elle s'inverse — c'est le terme familier
qui est glosé par l'officiel, jamais l'inverse. `1f62ee2f…` porte une explication de 519
caractères, la plus longue du périmètre : elle n'entrera dans le budget qu'au prix de sa
raison, donc elle **reste en texte** et son compte va au rapport.

- [ ] **Step 2: Dessiner les scènes de configuration**

`d5505e2b…` (à l'arrêt de nuit, feux avant et arrière) et `fc0333a5…` (file à allure
réduite) sont des configurations. `feu-jaune-clignotant` existe déjà pour `0ac1e53a…`.
Ajouter les scènes manquantes dans `Tools/Scenes/ScenesCirculation.swift`, puis :

```bash
cd /Users/guillaume/Developer/Swift/Valido && ./Tools/render-scenes.sh
```

- [ ] **Step 3: Relever les niveaux de gris de chaque scène neuve**

```bash
cd /Users/guillaume/Developer/Swift/Valido
uv run --with pillow Tools/luminance.py \
  Valido/Assets.xcassets/Scenes/<asset>.imageset/clair@3x.png --zone <X>,<Y>,30
uv run --with pillow Tools/luminance.py \
  Valido/Assets.xcassets/Scenes/<asset>.imageset/sombre@3x.png --zone <X>,<Y>,30
```

- [ ] **Step 4: Réécrire les cartes**

Les quatre corrections sur les huit cartes, plus la lecture à la main des 19 cartes du
domaine.

- [ ] **Step 5: Lancer l'audit**

```bash
cd /Users/guillaume/Developer/Swift/Valido
python3 Tools/audit.py | grep -E "^### "
```

- [ ] **Step 6: Relire les fuites, à l'outil puis à la main**

```bash
cd /Users/guillaume/Developer/Swift/Valido
python3 Tools/relire.py --fuites "Feux"
```

- [ ] **Step 7: Lancer toute la suite**

```bash
cd /Users/guillaume/Developer/Swift/Valido
DEVELOPER_DIR=/Applications/Xcode-27.0.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,id=66921B37-1805-4988-AB69-B51A94490BC0' 2>&1 \
  | grep -E "✔|✘|Test run with"
```

- [ ] **Step 8: Commit**

```bash
git add -A Valido/Resources/questions.json Valido/Assets.xcassets/Scenes \
  Tools/images.md Tools/sources.md Tools/Scenes
git commit -m "Stop glossing the official term with slang in Feux

Three prompts explained 'feux de croisement' with '(codes)', 'feux de
détresse' with '(warning)' and 'jaune' with '(orange)' — the official
word, the one being taught, explained by one the app never introduces.

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>"
```

---

### Task 6: Domaine `Vitesse`

**Files:**
- Modify: `Valido/Resources/questions.json`, `Tools/images.md`, `Tools/sources.md`
- Create: scènes sous `Tools/Scenes/ScenesCirculation.swift`

**Interfaces:**
- Consumes: le protocole photographique (tâche 2), les règles de `Tools/questions.md` (tâche 3).
- Produces: rien.

**Les cinq cartes du périmètre mécanique, plus celle de la capture n°1 :**

| id | énoncé | lot | é / o / x |
|---|---|---|---|
| `37fe1af42b8d81589410cd055e66efc2` | En agglomération, quelle est la vitesse maximale par défaut (sans panneau) ? | A, glose | 76 / 7 / 272 |
| `87c63a1be4e005f6c846d7798756696f` | En période probatoire, sur une route à chaussées séparées limitée à 110 km/h, vous ne dépassez pas : | B | 100 / 43 / 256 |
| `f7370daabea929065f6b2586ca3eea91` | Hors agglomération, sur une chaussée à deux voies dans votre sens sans terre-plein central, la limite est : | B | 107 / 8 / 237 |
| `fed604fe7c4b8b3b96adc066a7902138` | Hors agglomération, sur une route à chaussées séparées par un terre-plein central, la vitesse est limitée à : | B | 109 / 45 / 244 |
| `37fe1af42b8d818da27dc338f75795fe` | Par temps de pluie, sur une route à chaussées séparées limitée à 110, votre vitesse max devient : | B | 97 / 8 / 199 |
| `04182c9bbdeb305e21532f9c6913a2a2` | Un dépassement de la vitesse autorisée de 40 à moins de 50 km/h fait perdre : | capture n°1 | 76 / 41 / 233 |

- [ ] **Step 1: Réécrire l'énoncé de la capture n°1**

`04182c9b…` recopie le registre de R413-14 (« dépassement compris entre 40 km/h et moins de
50 km/h ») et se lit comme une vitesse autorisée de 40. L'énoncé dit ce que le conducteur
fait, pas ce que le texte écrit — par exemple « Rouler 40 à 49 km/h au-dessus de la vitesse
autorisée fait perdre : ». **L'`id` ne change pas.** La ligne de `sources.md` reste valable :
l'affirmation, elle, ne bouge pas.

- [ ] **Step 2: Reprendre les trois panneaux de vitesse en photographie**

`panneau-b14-limitation`, `panneau-b33-fin-limitation` et `panneau-b30-zone-30` sont
dessinés dans `ScenesCirculation.swift`. Protocole photographique de la spec (§4, les huit points), rodé en tâche 2 — sans oublier le point 8, **retirer la scène** du tableau de `Tools/Scenes/` et la fonction de dessin devenue orpheline, sinon `render-scenes.sh` réécrit la photo par le dessin, catégories
`Category:B14 (road sign, France)` (1 451 fichiers), `Category:B33 (road sign, France)`,
`Category:B30 (road sign, France)`. Le B30 est dessiné **carré** alors que l'art. 45 de la
4e partie de l'IISR le veut rectangulaire : le défaut est connu, et la photographie le
corrige d'office.

Ces trois panneaux-là ne servent **qu'à leur propre scène isolée** : une fois leur imageset
passé en photographie, `panneauLimitation`, `panneauFinDeLimitation` et `panneauZone30`
n'ont plus d'appelant. Les supprimer de `Tools/Scenes/Panneaux.swift` avec leurs scènes,
dans le même commit. La règle vaut partout : **une fonction de dessin ne se supprime que
lorsque plus aucune scène ne l'appelle.** `panneauStop`, `panneauCedez` et
`panneauRoutePrioritaire` restent — les scènes de carrefour les réutilisent.

- [ ] **Step 3: Dessiner les scènes de configuration de chaussée**

Quatre des cinq cartes opposent des configurations — chaussées séparées par un terre-plein,
deux voies dans le sens sans séparateur — qu'aucune photographie ne cadre proprement.
`autoroute-voie-de-gauche` existe et sert de modèle. Ajouter les scènes puis :

```bash
cd /Users/guillaume/Developer/Swift/Valido && ./Tools/render-scenes.sh
```

- [ ] **Step 4: Relever les niveaux de gris de chaque asset neuf**

```bash
cd /Users/guillaume/Developer/Swift/Valido
uv run --with pillow Tools/luminance.py \
  Valido/Assets.xcassets/Scenes/<asset>.imageset/clair@3x.png --zone <X>,<Y>,30
```

- [ ] **Step 5: Réécrire les cartes**

Attention au garde-fou : quatre de ces cartes sont des chiffres-règles dont l'explication
porte le barème. `expl/paraphrase-litterale` compte déjà quatre cartes `Vitesse` ; **ce
compteur ne se minimise pas**, une carte dont la règle *est* un chiffre doit énoncer ce
chiffre. Lire les 24 cartes du domaine pour le symptôme 4.

- [ ] **Step 6: Lancer l'audit**

```bash
cd /Users/guillaume/Developer/Swift/Valido
python3 Tools/audit.py | grep -E "^### "
```

- [ ] **Step 7: Relire les fuites, à l'outil puis à la main**

```bash
cd /Users/guillaume/Developer/Swift/Valido
python3 Tools/relire.py --fuites "Vitesse"
```

- [ ] **Step 8: Lancer toute la suite**

```bash
cd /Users/guillaume/Developer/Swift/Valido
DEVELOPER_DIR=/Applications/Xcode-27.0.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,id=66921B37-1805-4988-AB69-B51A94490BC0' 2>&1 \
  | grep -E "✔|✘|Test run with"
```

- [ ] **Step 9: Commit**

```bash
git add -A Valido/Resources/questions.json Valido/Assets.xcassets/Scenes \
  Tools/images.md Tools/sources.md Tools/Scenes
git commit -m "Say what the driver does, not what the article writes, in Vitesse

'Un dépassement de la vitesse autorisée de 40 à moins de 50 km/h' is
R413-14's own phrasing, and out of that context it reads as a 40 km/h
limit. Four road layouts that were carried in prose become scenes, and
the B30 stops being square on its way to a photograph.

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>"
```

---

### Task 7: Domaine `Croisement & dépassement`

**Files:**
- Modify: `Valido/Resources/questions.json`, `Tools/images.md`, `Tools/sources.md`
- Create: scènes sous `Tools/Scenes/ScenesCirculation.swift`

**Interfaces:**
- Consumes: les règles de `Tools/questions.md` (tâche 3).
- Produces: rien.

**Les cinq cartes, dont deux nommées par les captures n°3 et n°9 :**

| id | énoncé | lot | é / o / x |
|---|---|---|---|
| `e5b0f585f1a3654ca790b9e391db8203` | Aux traversées de voies ferrées, le dépassement est interdit : | B | 62 / 48 / 209 |
| `2fc1ed8a9c9274f0e06be9f12850f5a4` | La circulation est figée en files sur toutes les voies. Rouler plus vite qu'une file voisine : | B | 94 / 47 / 330 |
| `f1ae9582d692d2bb7febb6a3c936ff34` | Lors d'un croisement, chaque conducteur doit : | B | 46 / 44 / 330 |
| `99824d4de286434d85174502e05ea59d` | Sur une chaussée à double sens de trois voies, pour dépasser : | B, capture n°3 | 62 / 52 / 273 |
| `f5a12ba77751310fe9a210a3b787286a` | À l'approche d'une intersection, le dépassement : | B, capture n°9 | 49 / 45 / 346 |

- [ ] **Step 1: Dessiner la chaussée à trois voies à double sens**

C'est la carte de la capture n°3, celle qu'il a fallu relire plusieurs fois. Vue de dessus,
trois voies, la voie de gauche réservée au sens inverse : `depassement-ligne-discontinue`
donne l'échelle (16 unités par mètre, voie de 56 unités pour 3,50 m). Ajouter la scène dans
`Tools/Scenes/ScenesCirculation.swift`, puis :

```bash
cd /Users/guillaume/Developer/Swift/Valido && ./Tools/render-scenes.sh
```

- [ ] **Step 2: Dessiner l'approche d'intersection**

Capture n°9. La scène doit montrer l'intersection **et** le véhicule qui double, puisque la
règle tient à qui a la priorité. `croisementNu` et `voiture` de `Primitives.swift` la
composent.

- [ ] **Step 3: Relever les niveaux de gris de chaque scène neuve**

```bash
cd /Users/guillaume/Developer/Swift/Valido
uv run --with pillow Tools/luminance.py \
  Valido/Assets.xcassets/Scenes/<asset>.imageset/clair@3x.png --zone <X>,<Y>,30
uv run --with pillow Tools/luminance.py \
  Valido/Assets.xcassets/Scenes/<asset>.imageset/sombre@3x.png --zone <X>,<Y>,30
```

- [ ] **Step 4: Réécrire les cartes**

`f5a12ba7…` porte 346 caractères d'explication dont la dernière phrase désambiguïse
« dépassement *d'*un deux-roues » contre « dépassement *par* un deux-roues » : cette phrase
**est** la raison, elle ne se coupe pas. Si le budget ne l'accepte pas, la carte reste en
texte. Lire les 15 cartes du domaine pour le symptôme 4.

- [ ] **Step 5: Lancer l'audit**

```bash
cd /Users/guillaume/Developer/Swift/Valido
python3 Tools/audit.py | grep -E "^### "
```

- [ ] **Step 6: Relire les fuites, à l'outil puis à la main**

```bash
cd /Users/guillaume/Developer/Swift/Valido
python3 Tools/relire.py --fuites "Croisement & dépassement"
```

- [ ] **Step 7: Lancer toute la suite**

```bash
cd /Users/guillaume/Developer/Swift/Valido
DEVELOPER_DIR=/Applications/Xcode-27.0.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,id=66921B37-1805-4988-AB69-B51A94490BC0' 2>&1 \
  | grep -E "✔|✘|Test run with"
```

- [ ] **Step 8: Commit**

```bash
git add -A Valido/Resources/questions.json Valido/Assets.xcassets/Scenes \
  Tools/images.md Tools/Scenes
git commit -m "Draw the three lanes instead of describing them

'Sur une chaussée à double sens de trois voies' asked the reader to
build the layout in their head before the question even started. Two
scenes carry it now, and the overtaking card keeps the sentence that
separates overtaking a two-wheeler from overtaking as one.

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>"
```

---

### Task 8: Domaine `Arrêt & stationnement`

**Files:**
- Modify: `Valido/Resources/questions.json`, `Tools/images.md`, `Tools/sources.md`
- Create: scènes sous `Tools/Scenes/ScenesCirculation.swift`

**Interfaces:**
- Consumes: les règles de `Tools/questions.md` (tâche 3).
- Produces: rien.

**Les quatre cartes :**

| id | énoncé | lot | é / o / x |
|---|---|---|---|
| `37fe1af42b8d811b96fdf80a7a546c1e` | En agglomération, sur une chaussée à double sens, on stationne : | B | 64 / 46 / 177 |
| `37fe1af42b8d811198bdecd01768828c` | Le stationnement dangereux (135 € et 3 points) se rencontre notamment : | glose | 71 / 43 / 200 |
| `37fe1af42b8d81d793bcc927205f9d79` | S'arrêter ou stationner sur une voie réservée aux bus est : | B | 59 / 47 / 232 |
| `37fe1af42b8d8181a057c984708f0042` | Un stationnement gênant (non « très gênant ») est sanctionné par une amende de : | glose | 80 / 5 / 251 |

- [ ] **Step 1: Traiter les deux gloses de sanction**

« (135 € et 3 points) » et « (non « très gênant ») » livrent le barème dans l'énoncé d'une
carte qui interroge un barème. Vérifier d'abord si elles ne donnent pas la réponse d'une
autre carte du domaine — c'est exactement ce que `relire.py --fuites` ne voit pas, puisqu'il
n'inspecte que les `explanation`.

- [ ] **Step 2: Dessiner ou réutiliser les scènes**

`stationnement-ligne-jaune-continue`, `-discontinue` et `stationnement-en-epi` existent.
`37fe1af42b8d811b9…` (double sens, de quel côté on stationne) demande une scène neuve.

```bash
cd /Users/guillaume/Developer/Swift/Valido && ./Tools/render-scenes.sh
```

- [ ] **Step 3: Relever les niveaux de gris de chaque scène neuve**

```bash
cd /Users/guillaume/Developer/Swift/Valido
uv run --with pillow Tools/luminance.py \
  Valido/Assets.xcassets/Scenes/<asset>.imageset/clair@3x.png --zone <X>,<Y>,30
```

- [ ] **Step 4: Réécrire les cartes**

Les quatre corrections, plus la lecture à la main des 18 cartes du domaine.

- [ ] **Step 5: Lancer l'audit**

```bash
cd /Users/guillaume/Developer/Swift/Valido
python3 Tools/audit.py | grep -E "^### "
```

- [ ] **Step 6: Relire les fuites, à l'outil puis à la main**

```bash
cd /Users/guillaume/Developer/Swift/Valido
python3 Tools/relire.py --fuites "Arrêt & stationnement"
```

- [ ] **Step 7: Lancer toute la suite**

```bash
cd /Users/guillaume/Developer/Swift/Valido
DEVELOPER_DIR=/Applications/Xcode-27.0.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,id=66921B37-1805-4988-AB69-B51A94490BC0' 2>&1 \
  | grep -E "✔|✘|Test run with"
```

- [ ] **Step 8: Commit**

```bash
git add -A Valido/Resources/questions.json Valido/Assets.xcassets/Scenes \
  Tools/images.md Tools/sources.md Tools/Scenes
git commit -m "Take the fine out of the prompt in Arrêt & stationnement

Two prompts carried a scale in parentheses on cards that ask about a
scale. Neither gloss was for the reader; both were notes to the author.

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>"
```

---

### Task 9: Domaine `Usagers & partage de la route`

**Files:**
- Modify: `Valido/Resources/questions.json`, `Tools/images.md`, `Tools/sources.md`
- Create: scènes sous `Tools/Scenes/ScenesCirculation.swift`

**Interfaces:**
- Consumes: les règles de `Tools/questions.md` (tâche 3).
- Produces: rien.

**Les quatre cartes, dont celle de la capture n°12 :**

| id | énoncé | lot | é / o / x |
|---|---|---|---|
| `a6fb8c0684dce67923a3207ee19171c9` | En inter-files — entre deux files de véhicules —, la vitesse ne peut excéder : | B, glose, capture n°12 | 78 / 43 / 353 |
| `45d84549ac552870982bf1315f9a8151` | Hors agglomération, un engin de déplacement personnel motorisé — trottinette électrique, gyroroue — circule : | glose | 109 / 45 / 305 |
| `b7b38d7ae1faf0dd593a1a2446b59ee6` | Hors agglomération, un piéton contraint d'emprunter la chaussée se tient : | B | 74 / 46 / 386 |
| `5f426e8e0d2326304689478d90b749fc` | La circulation inter-files — rouler entre deux files de véhicules — des deux-roues motorisés est : | B, glose | 98 / 42 / 224 |

- [ ] **Step 1: Réparer la glose de la capture n°12**

`a6fb8c06…` glose « inter-files » par « entre deux files de véhicules » — ce que le mot dit
déjà — et **omet le sujet**, alors que sa carte jumelle `5f426e8e…` porte « des deux-roues
motorisés ». L'incise sort, le sujet entre : « En inter-files, la vitesse d'un deux-roues
motorisé ne peut excéder : ». Sur `5f426e8e…`, l'incise sort aussi ; le sujet y est déjà.
**Les deux `id` restent inchangés.**

- [ ] **Step 2: Dessiner la scène d'inter-files**

Deux files de véhicules vues de dessus et un deux-roues entre elles : c'est la configuration
que les deux cartes décrivent en mots, et elle sert aux deux. Ajouter la scène puis :

```bash
cd /Users/guillaume/Developer/Swift/Valido && ./Tools/render-scenes.sh
```

- [ ] **Step 3: Relever les niveaux de gris**

```bash
cd /Users/guillaume/Developer/Swift/Valido
uv run --with pillow Tools/luminance.py \
  Valido/Assets.xcassets/Scenes/<asset>.imageset/clair@3x.png --zone <X>,<Y>,30
uv run --with pillow Tools/luminance.py \
  Valido/Assets.xcassets/Scenes/<asset>.imageset/sombre@3x.png --zone <X>,<Y>,30
```

- [ ] **Step 4: Réécrire les cartes**

Les quatre corrections, plus la lecture à la main des 19 cartes du domaine. `b7b38d7a…`
(386 caractères) et `45d84549…` (305) sont à surveiller sur le garde-fou.

- [ ] **Step 5: Lancer l'audit**

```bash
cd /Users/guillaume/Developer/Swift/Valido
python3 Tools/audit.py | grep -E "^### "
```

- [ ] **Step 6: Relire les fuites, à l'outil puis à la main**

```bash
cd /Users/guillaume/Developer/Swift/Valido
python3 Tools/relire.py --fuites "Usagers & partage de la route"
```

Les deux cartes d'inter-files se relisent **côte à côte** : elles partagent une notion et
l'une porte le régime, l'autre le plafond.

- [ ] **Step 7: Lancer toute la suite**

```bash
cd /Users/guillaume/Developer/Swift/Valido
DEVELOPER_DIR=/Applications/Xcode-27.0.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,id=66921B37-1805-4988-AB69-B51A94490BC0' 2>&1 \
  | grep -E "✔|✘|Test run with"
```

- [ ] **Step 8: Commit**

```bash
git add -A Valido/Resources/questions.json Valido/Assets.xcassets/Scenes \
  Tools/images.md Tools/sources.md Tools/Scenes
git commit -m "Name the rider the inter-files card was always about

The prompt glossed 'inter-files' with 'between two lines of vehicles',
which the word already says, and never mentioned the powered two-wheeler
the rule applies to — while its twin card did. The gloss goes, the
subject arrives, and one scene now serves both cards.

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>"
```

---

### Task 10: Domaine `Tunnels & passages à niveau`

**Files:**
- Modify: `Valido/Resources/questions.json`, `Tools/images.md`, `Tools/sources.md`

**Interfaces:**
- Consumes: le protocole photographique (tâche 2), les règles de `Tools/questions.md` (tâche 3).
- Produces: rien.

**Les quatre cartes :**

| id | énoncé | lot | é / o / x |
|---|---|---|---|
| `5ae4a8d7800141787ada8a389ff74fc1` | Dans un tunnel, s'arrêter le long de la chaussée : | B | 50 / 41 / 316 |
| `bda520451eb11447c3921f8a358742f1` | De jour, à l'entrée d'un tunnel éclairé, vos feux de croisement : | B | 65 / 42 / 464 |
| `5c11020dc34bf45d56cf8438dd8ad79e` | Le panneau qui signale l'entrée d'un tunnel interdit notamment : | A | 64 / 38 / 323 |
| `3a06288bf73bb5254b83a371ae55a854` | À l'entrée d'un tunnel, le panonceau sous le panneau indique : | A | 62 / 40 / 276 |

- [ ] **Step 1: Sourcer les deux panneaux**

Protocole photographique de la spec (§4, les huit points), rodé en tâche 2 — sans oublier le point 8, **retirer la scène** du tableau de `Tools/Scenes/` et la fonction de dessin devenue orpheline, sinon `render-scenes.sh` réécrit la photo par le dessin. `Category:C111 (road sign, France)` pour le panneau
d'entrée de tunnel, et la catégorie du panonceau M9 associé. Les deux cartes du lot A
deviennent « Ce panneau interdit notamment : » et « Ce panonceau indique : », l'objet
passant dans l'image.

- [ ] **Step 2: Réécrire les cartes**

`bda52045…` porte 464 caractères, `5c11020d…` 323, `5ae4a8d7…` 316 : trois des quatre sont
très au-dessus du budget. Le transfert en paie une partie sur les deux cartes de panneau ;
le garde-fou décide du reste. Lire les 16 cartes du domaine pour le symptôme 4.

- [ ] **Step 3: Relever les niveaux de gris des photographies**

```bash
cd /Users/guillaume/Developer/Swift/Valido
for mode in clair sombre; do
  uv run --with pillow Tools/luminance.py \
    Valido/Assets.xcassets/Scenes/<asset>.imageset/$mode@3x.jpg --zone <X>,<Y>,40
done
```

- [ ] **Step 4: Lancer l'audit**

```bash
cd /Users/guillaume/Developer/Swift/Valido
python3 Tools/audit.py | grep -E "^### "
```

- [ ] **Step 5: Relire les fuites, à l'outil puis à la main**

```bash
cd /Users/guillaume/Developer/Swift/Valido
python3 Tools/relire.py --fuites "Tunnels & passages à niveau"
```

- [ ] **Step 6: Lancer toute la suite**

```bash
cd /Users/guillaume/Developer/Swift/Valido
DEVELOPER_DIR=/Applications/Xcode-27.0.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,id=66921B37-1805-4988-AB69-B51A94490BC0' 2>&1 \
  | grep -E "✔|✘|Test run with"
```

- [ ] **Step 7: Commit**

```bash
git add -A Valido/Resources/questions.json Valido/Assets.xcassets/Scenes \
  Tools/images.md Tools/sources.md
git commit -m "Show the tunnel sign rather than name it

Two cards said 'le panneau qui signale l'entrée d'un tunnel' and then
asked which one it was. Three of this domain's four explanations sit far
above the height budget, so the guard rail decides which ones travel.

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>"
```

---

### Task 11: Domaine `Distances & freinage`

Premier des quatre domaines sans aucune carte illustrée.

**Files:**
- Modify: `Valido/Resources/questions.json`, `Tools/images.md`, `Tools/sources.md`
- Create: scènes sous `Tools/Scenes/ScenesCirculation.swift`

**Interfaces:**
- Consumes: les règles de `Tools/questions.md` (tâche 3).
- Produces: rien.

**Les deux cartes :**

| id | énoncé | lot | é / o / x |
|---|---|---|---|
| `36d598b80e93b695b2994fce6172eb50` | Sur une chaussée enneigée ou verglacée, vous : | B | 46 / 43 / 345 |
| `37fe1af42b8d8104b119f947eb9e296d` | À 50 km/h, la distance parcourue pendant le temps de réaction (1 s) est d'environ : | glose | 83 / 4 / 254 |

- [ ] **Step 1: Traiter la glose « (1 s) »**

Elle donne la moitié du calcul dans l'énoncé d'une carte qui demande le résultat du calcul.
Deux sorties : la glose saute et le temps de réaction devient ce que la carte enseigne, ou
elle reste et la carte devient une carte de conversion assumée. Trancher et l'écrire dans le
rapport.

- [ ] **Step 2: Réécrire les cartes**

Les 22 cartes du domaine se lisent à la main pour le symptôme 4 — c'est un domaine de
chiffres, donc celui où « la règle sans sa raison » est le plus probable.

- [ ] **Step 3: Lancer l'audit**

```bash
cd /Users/guillaume/Developer/Swift/Valido
python3 Tools/audit.py | grep -E "^### "
```

- [ ] **Step 4: Relire les fuites, à l'outil puis à la main**

```bash
cd /Users/guillaume/Developer/Swift/Valido
python3 Tools/relire.py --fuites "Distances & freinage"
```

- [ ] **Step 5: Lancer toute la suite**

```bash
cd /Users/guillaume/Developer/Swift/Valido
DEVELOPER_DIR=/Applications/Xcode-27.0.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,id=66921B37-1805-4988-AB69-B51A94490BC0' 2>&1 \
  | grep -E "✔|✘|Test run with"
```

- [ ] **Step 6: Commit**

```bash
git add -A Valido/Resources/questions.json Valido/Assets.xcassets/Scenes \
  Tools/images.md Tools/sources.md Tools/Scenes
git commit -m "Stop handing out half the sum in Distances & freinage

'(1 s)' gave the reaction time inside a prompt that asks what distance
that reaction time covers.

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>"
```

---

### Task 12: Domaine `Mécanique & environnement`

Ce domaine porte deux des captures — la ceinture du taxi et la galerie de toit — qu'aucun
compteur ne signale. Le périmètre mécanique n'y voit qu'une carte ; la lecture à la main en
voit trois.

**Files:**
- Modify: `Valido/Resources/questions.json`, `Tools/sources.md`

**Interfaces:**
- Consumes: les règles de `Tools/questions.md` (tâche 3).
- Produces: rien.

**Les trois cartes :**

| id | énoncé | motif | é / o / x |
|---|---|---|---|
| `37fe1af42b8d81b99c05ef1ffdacc30e` | Un témoin orange (ambre) au tableau de bord signale : | glose inversée | 53 / 45 / 277 |
| `8e64074daad0e4a72e0fea2da9bac8eb` | Le port de la ceinture n'est pas obligatoire : | capture n°2, raison absente | 46 / 40 / 243 |
| `526d6b502e05eefba3f2066af4c2ab8d` | Une galerie de toit chargée, sur autoroute : | capture n°7, glose absente | 44 / 46 / 261 |

- [ ] **Step 1: Donner sa raison à la carte du taxi**

`8e64074d…` est juste — R412-1 exempte bien le conducteur de taxi en service — mais son
explication n'est qu'une liste fermée de six cas à retenir. La bonne réponse surprend, donc
la carte doit porter **pourquoi** cette exemption existe, et pas seulement qu'elle existe.
La liste reste : c'est la règle. Vérifier la raison contre la source avant de l'écrire, et
mettre `sources.md` à jour si l'affirmation s'étend.

- [ ] **Step 2: Gloser « galerie de toit »**

`526d6b50…` emploie le terme sans un mot d'explication. La règle de la tâche 3 s'applique :
la glose nomme ce que le candidat verrait — les barres de portage sur le pavillon — pas un
synonyme.

- [ ] **Step 3: Inverser la glose « (ambre) »**

`37fe1af42b8d81b99…` glose « orange » par « ambre », le mot rare expliquant le mot courant.
Soit la glose saute, soit elle s'inverse.

- [ ] **Step 4: Lire les 21 cartes du domaine pour le symptôme 4**

- [ ] **Step 5: Lancer l'audit**

```bash
cd /Users/guillaume/Developer/Swift/Valido
python3 Tools/audit.py | grep -E "^### "
```

- [ ] **Step 6: Relire les fuites, à l'outil puis à la main**

```bash
cd /Users/guillaume/Developer/Swift/Valido
python3 Tools/relire.py --fuites "Mécanique & environnement"
```

- [ ] **Step 7: Lancer toute la suite**

```bash
cd /Users/guillaume/Developer/Swift/Valido
DEVELOPER_DIR=/Applications/Xcode-27.0.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,id=66921B37-1805-4988-AB69-B51A94490BC0' 2>&1 \
  | grep -E "✔|✘|Test run with"
```

- [ ] **Step 8: Commit**

```bash
git add -A Valido/Resources/questions.json Tools/sources.md
git commit -m "Give the taxi exemption a reason to be believed

The seat-belt card is right and reads like a mistake: a closed list of
six exemptions to memorise, and no word on why a taxi driver is one of
them. A surprising answer without its reason teaches nothing.

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>"
```

---

### Task 13: Domaine `Permis & sanctions`

**Files:**
- Modify: `Valido/Resources/questions.json`, `Tools/sources.md`

**Interfaces:**
- Consumes: les règles de `Tools/questions.md` (tâche 3).
- Produces: rien.

**La carte :**

| id | énoncé | lot | é / o / x |
|---|---|---|---|
| `37fe1af42b8d81d09328df58d56a4dc6` | Le disque « A » (jeune conducteur) doit être apposé : | glose | 53 / 53 / 238 |

- [ ] **Step 1: Traiter la glose « (jeune conducteur) »**

Elle n'est ni inutile ni inversée : « disque A » ne se devine pas. Vérifier seulement
qu'elle ne livre pas la réponse d'une autre carte du domaine, et la garder si elle tient.

- [ ] **Step 2: Lire les 21 cartes du domaine pour le symptôme 4**

C'est le deuxième domaine sans aucune carte illustrée, et un domaine de barèmes : la raison
y manque probablement plus d'une fois.

- [ ] **Step 3: Lancer l'audit**

```bash
cd /Users/guillaume/Developer/Swift/Valido
python3 Tools/audit.py | grep -E "^### "
```

- [ ] **Step 4: Relire les fuites, à l'outil puis à la main**

```bash
cd /Users/guillaume/Developer/Swift/Valido
python3 Tools/relire.py --fuites "Permis & sanctions"
```

- [ ] **Step 5: Lancer toute la suite**

```bash
cd /Users/guillaume/Developer/Swift/Valido
DEVELOPER_DIR=/Applications/Xcode-27.0.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,id=66921B37-1805-4988-AB69-B51A94490BC0' 2>&1 \
  | grep -E "✔|✘|Test run with"
```

- [ ] **Step 6: Commit**

```bash
git add -A Valido/Resources/questions.json Tools/sources.md
git commit -m "Read Permis & sanctions for the rules that state no reason

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>"
```

---

### Task 14: Le rapport, les seuils et la ligne de base

**Files:**
- Create: `Tools/audit-2026-09-illustrations.md`
- Modify: `ValidoTests/BundledContentTests.swift`
- Modify: `CLAUDE.md`
- Modify: `Tools/questions.md` (l'état courant en tête de fichier)
- Delete: `docs/superpowers/plans/2026-09-22-illustrations-gloses-raisons.md`

**Interfaces:**
- Consumes: les relevés de toutes les tâches précédentes.
- Produces: la nouvelle ligne de base, que la prochaine passe comparera.

- [ ] **Step 1: Recompter le livré**

```bash
cd /Users/guillaume/Developer/Swift/Valido
python3 -c "
import json
qs = json.load(open('Valido/Resources/questions.json'))
code = [q for q in qs if q['subject'] == 'code']
illu = [q for q in qs if 'illustration' in q]
print(f'{len(qs)} questions, {len(code)} code, {len(qs) - len(code)} swift, {len(illu)} illustrées')
print('seuil illustrées à 90 % :', int(len(illu) * 0.9))
"
```

- [ ] **Step 2: Relever le seuil d'illustrées**

Dans `ValidoTests/BundledContentTests.swift`, remplacer `#expect(illustrées.count >= 44)`
par la valeur du step 1, et mettre à jour le commentaire qui la documente. **Seul ce
seuil-là se relève** ; les autres échecs se corrigent dans les données.

- [ ] **Step 3: Regeler l'empreinte des identifiants**

Les `id` n'ont pas changé, donc l'empreinte de la tâche 1 doit encore passer. Le vérifier :

```bash
cd /Users/guillaume/Developer/Swift/Valido
DEVELOPER_DIR=/Applications/Xcode-27.0.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,id=66921B37-1805-4988-AB69-B51A94490BC0' \
  -only-testing:'ValidoTests/lesIdentifiantsLivrésSontStables()' 2>&1 | grep -E "✔|✘|Test run with"
```

Attendu : `✔ Test run with 1 test(s)`. **Un échec ici veut dire qu'un `id` a été recalculé
quelque part** — le retrouver et le restaurer, ne pas mettre l'empreinte à jour.

- [ ] **Step 4: Écrire le rapport**

`Tools/audit-2026-09-illustrations.md`, sur le modèle de `audit-2026-09-formes.md` :

1. les compteurs avant et après, avec l'explication de chaque écart ;
2. **les cartes écartées par le garde-fou**, chacune avec son compte de caractères et la
   raison qui n'y entrait pas — c'est la section que la prochaine passe lira en premier ;
3. **les panneaux restés en dessin**, chacun avec la meilleure résolution trouvée sur
   Commons, pour qu'une passe ultérieure reprenne la recherche sans la refaire ;
4. les relevés de niveaux de gris de chaque asset neuf, clair et sombre ;
5. le mouvement de `forme/impersonnel`, `forme/hors-situation` et `forme/definitionnel`,
   **relevé et expliqué, jamais visé** ;
6. ce que l'outillage n'a pas vu.

- [ ] **Step 5: Vérifier qu'aucun registre visuel ne prédit une réponse**

C'est la vérification que le §4 de la spec impose et qu'aucun compteur ne porte. Lister les
paires de cartes d'un même domaine dont les réponses s'opposent, et vérifier qu'elles ne se
distinguent pas par leur registre — l'une en photographie, l'autre en schéma :

```bash
cd /Users/guillaume/Developer/Swift/Valido
python3 -c "
import collections, json, os
qs = json.load(open('Valido/Resources/questions.json'))
scenes = 'Valido/Assets.xcassets/Scenes'
def registre(q):
    a = q.get('illustration', {}).get('asset')
    if not a: return None
    f = os.listdir(os.path.join(scenes, a + '.imageset'))
    return 'photo' if any(n.endswith('.jpg') for n in f) else 'schema'
par = collections.defaultdict(list)
for q in qs:
    if q['subject'] == 'code' and registre(q): par[(q['topic'], q['notion'])].append(q)
for (topic, notion), lot in sorted(par.items()):
    if len({registre(q) for q in lot}) > 1:
        print(f'{topic} / {notion}')
        for q in lot: print(f'    [{registre(q)}] {q[\"prompt\"]}')
"
```

Seules les cartes **illustrées** entrent dans la comparaison : une notion qui mélange du
texte et des images ne dit rien, c'est le cas ordinaire. Au 2026-09-22 la commande imprime
une notion, `panneaux/portee`, où la photo du giratoire voisine trois panneaux dessinés —
c'est précisément ce que cette passe corrige.

Chaque notion imprimée se lit à la main : si le registre suit le **type de question**
(reconnaître un signal contre décider d'une manœuvre), c'est sain ; s'il suit la **réponse**,
la carte fautive change de registre ou perd son image. Écrire le verdict dans le rapport.

- [ ] **Step 6: Mettre `CLAUDE.md` et `Tools/questions.md` à jour**

Dans `CLAUDE.md` : la ligne de base des compteurs, le volume (`464 questions … dont N
illustrées`), et la règle de partage — un panneau se photographie, un marquage et une
configuration se dessinent.

Dans `Tools/questions.md`, l'« État courant » en tête de fichier : le nombre de questions,
la répartition `code`/`swift`, et le nouveau nombre d'illustrées.

- [ ] **Step 7: Lancer l'audit et toute la suite une dernière fois**

```bash
cd /Users/guillaume/Developer/Swift/Valido
python3 Tools/audit.py | grep -E "^### "
DEVELOPER_DIR=/Applications/Xcode-27.0.0.app xcodebuild test \
  -project Valido.xcodeproj -scheme Valido \
  -destination 'platform=iOS Simulator,id=66921B37-1805-4988-AB69-B51A94490BC0' 2>&1 \
  | grep -E "✔|✘|Test run with"
```

- [ ] **Step 8: Supprimer le plan**

Un plan se supprime quand son travail est livré et que son rapport le résume.

```bash
cd /Users/guillaume/Developer/Swift/Valido
git rm docs/superpowers/plans/2026-09-22-illustrations-gloses-raisons.md
```

- [ ] **Step 9: Commit**

```bash
git add -A Tools/audit-2026-09-illustrations.md Tools/questions.md CLAUDE.md \
  ValidoTests/BundledContentTests.swift docs/superpowers/plans
git commit -m "Publish the new baseline for the illustrations pass

The report carries what no counter can: the cards the guard rail kept in
text with their character counts, the signs that found no photograph
sharp enough and the best resolution Commons offered, and the grayscale
readings for every new asset in both modes.

Co-Authored-By: Claude Opus 5 (1M context) <noreply@anthropic.com>"
```
