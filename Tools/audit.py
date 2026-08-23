#!/usr/bin/env python3
"""Contrôles mécaniques de l'étape 5 de questions.md, plus les pièges de forme.

Usage : python3 Tools/audit.py [chemin/vers/questions.json]

Tout ce qui sort ici n'est que formel : la justesse du contenu (code de la route
en vigueur, exactitude Swift) ne se vérifie pas d'ici — voir l'étape 8.
"""
import json, os, re, sys, unicodedata, collections

PATH = sys.argv[1] if len(sys.argv) > 1 else 'Valido/Resources/questions.json'
QS = json.load(open(PATH))

STOP = set("""a afin ainsi alors apres au aucun aucune aussi autre autres aux avant avec car ce
ceci cela ces cet cette ceux chaque chez comme comment dans de des donc dont du elle elles en
encore entre est et etre eux fait faire fois font hors ici il ils je jusqu la le les leur leurs
lui ma mais mal me meme mes moi mon ne ni non nos notre nous on ont ou par parce pas peu peut
plus pour pourquoi quand que quel quelle quelles quels qui quoi sa sans se sera ses si sien son
sont sous soit sur ta te tes toi ton tous tout toute toutes tres tu un une vers via voici voila
vos votre vous y sert servent sers doit doivent peuvent quelle lorsque lorsqu apres cas cause
type types valeur valeurs faut doit etc lequel laquelle lesquels laquelle entre parmi""".split())

# Majuscules accentuées et lettres ancrées par l'énoncé sont des faux positifs :
# le tri final reste manuel (cf. §3 de questions.md).
# `\w` est unicode : il exclut « Démarrer », « Délimite », « Ça ». L'apostrophe exclut
# « C'est », « D'abord » ; le point et le tiret excluent `.left`, `Foo.B`, « Objective-C ».
# Ce qui passe encore demande un tri à la main : une lettre ancrée par l'énoncé
# (« Le « D » de SOLID », « Le disque « A » ») est légitime.
LETTER = re.compile(r"(?<![\w`.\-])[A-D](?![\w`’'])")

def norm(s):
    s = unicodedata.normalize('NFD', s.lower())
    s = ''.join(c for c in s if unicodedata.category(c) != 'Mn')
    return s

def words(s, n=4):
    return {w for w in re.findall(r"[a-z0-9_]+", norm(s)) if len(w) >= n and w not in STOP}

def opt(q, oid):
    return next(o['text'] for o in q['options'] if o['id'] == oid)

def firstword(t):
    m = re.match(r"[`«\"]?([\wéèêàçûôîùâ']+)", t.strip())
    return norm(m.group(1)) if m else ''

SCENES = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(PATH))),
                      'Assets.xcassets', 'Scenes')
IMAGES_MD = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'images.md')
# Le relevé de provenance : une ligne de tableau par asset. Sans lui une image est
# orpheline — impossible de la remplacer ou de re-sourcer si la licence change.
try:
    RECENSES = set(re.findall(r'^\|\s*`([a-z0-9-]+)`', open(IMAGES_MD).read(), re.M))
except OSError:
    RECENSES = set()

findings = collections.defaultdict(list)
def flag(kind, q, detail):
    findings[kind].append((q['subject'], q['topic'], q['id'], q['prompt'][:70], detail))

lens_good, lens_bad = [], []
for q in QS:
    ids = [o['id'] for o in q['options']]
    good = opt(q, q['correctID'])
    bad = [o['text'] for o in q['options'] if o['id'] != q['correctID']]
    expl = q['explanation']

    # --- schéma ---
    if sorted(ids) != ['A', 'B', 'C', 'D']: flag('schema/options', q, ids)
    if len({o['text'] for o in q['options']}) != 4: flag('schema/doublon-option', q, '')
    if q['correctID'] not in ids: flag('schema/correctID', q, q['correctID'])
    if not expl.strip(): flag('schema/expl-vide', q, '')
    if set(q) - {'id','subject','topic','difficulty','prompt','options','correctID','explanation','sourceURL','illustration'}:
        flag('schema/cle-hors-schema', q, sorted(set(q)))

    # --- illustration ---
    illu = q.get('illustration')
    if illu is not None:
        if set(illu) != {'asset', 'alt'}:
            flag('schema/illustration-cles', q, sorted(set(illu)))
        asset, alt = illu.get('asset', ''), illu.get('alt', '')
        if not asset.strip(): flag('schema/illustration-asset-vide', q, '')
        # L'imageset doit exister sur le disque. Le test `BundledContentTests` vérifie en
        # plus qu'il se résout dans le bundle compilé ; ici on attrape la faute de frappe
        # avant même le build.
        elif not os.path.isdir(os.path.join(SCENES, asset + '.imageset')):
            flag('image/imageset-absent', q, f'{asset}.imageset')
        elif asset not in RECENSES:
            flag('image/provenance-absente', q, f'{asset} manque dans {IMAGES_MD}')
        # `alt` porte l'énoncé pour qui n'accède pas à l'image : trois mots ne suffisent
        # pas. Seuil aligné sur celui de l'explication.
        if len(alt.strip()) < 40: flag('image/alt-trop-court', q, alt)
        # Si l'énoncé redit ce que l'image montre, l'image est décorative — exactement ce
        # que les questions illustrées ne doivent pas être. Sortie à trier à la main :
        # « carrefour » dans les deux est parfois inévitable.
        commun = words(q['prompt']) & words(alt)
        if len(commun) >= 3: flag('image/enonce-redit-la-scene', q, sorted(commun))

    # --- résidus markdown / méta-options ---
    for label, txt in [('explanation', expl), ('prompt', q['prompt'])] + [(f"opt{o['id']}", o['text']) for o in q['options']]:
        if '**' in txt or '](' in txt: flag('forme/markdown', q, f'{label}: {txt[:60]}')
        if re.search(r'\b(toutes les r|aucune de|ci-dessus)', norm(txt)): flag('forme/meta-option', q, f'{label}: {txt[:60]}')

    # --- références de lettre, options ET explication ---
    for label, txt in [('explanation', expl)] + [(f"opt{o['id']}", o['text']) for o in q['options']]:
        for m in LETTER.finditer(txt):
            flag('lettre/reference', q, f'{label}: …{txt[max(0, m.start()-25):m.end()+25]}…')

    # --- références de lettre ---
    if re.match(r'^\s*[A-D]\s*[—–\-.):]', expl): flag('lettre/expl-debut', q, expl[:40])
    if re.search(r'\b[A-D]\s*:\s*$', expl.strip()) or re.search(r'\b[A-D]\s*:', expl):
        flag('lettre/expl-motif', q, expl[-60:])
    for o in q['options']:
        if re.match(r'^\s*[A-D]\s*[—–\-.)]', o['text']): flag('lettre/option', q, o['text'][:40])

    # --- équilibre de longueur ---
    L = len(good); others = sorted((len(b) for b in bad), reverse=True)
    delta = L - others[0]
    (lens_good if q['subject']=='code' else lens_bad).append((L, sum(others)/3))
    if delta > 10: flag('longueur/plus-10', q, f'bonne={L} vs 2e={others[0]} (+{delta})')
    elif delta > 0: flag('longueur/plus-longue', q, f'bonne={L} vs 2e={others[0]} (+{delta})')
    if L - sum(others)/3 > 20: flag('longueur/registre', q, f'bonne={L} vs moy.distr={sum(others)/3:.0f}')

    # --- fuite de mot d'énoncé (seuil 4) ---
    pw = words(q['prompt'])
    gw = words(good)
    leak = {w for w in pw & gw if not any(w in words(b) for b in bad)}
    if leak: flag('fuite/mot-enonce', q, f"{sorted(leak)} -> «{good[:50]}»")

    # --- backticks / code span ---
    bt = [('`' in o['text']) for o in q['options']]
    gbt = '`' in good
    if bt.count(gbt) == 1 and any(bt) : flag('forme/backtick-isole', q, f"bonne={'avec' if gbt else 'sans'} backtick, seule")

    # --- motif grammatical ---
    fws = [firstword(o['text']) for o in q['options']]
    gfw = firstword(good)
    if len(set(fws)) <= 2 and fws.count(gfw) == 1 and len(set(fws)) == 2:
        flag('forme/ouverture-isolee', q, f"{fws} bonne={gfw}")

    # --- « seule option détaillée » : virgule/parenthèse/nb de mots ---
    nw = [len(o['text'].split()) for o in q['options']]
    gnw = len(good.split())
    if gnw >= 2 * max([len(b.split()) for b in bad]): flag('forme/seule-detaillee', q, f"mots bonne={gnw} vs distr={sorted(nw)}")
    detail_marks = lambda t: ('(' in t) or (',' in t) or (' : ' in t)
    if detail_marks(good) and not any(detail_marks(b) for b in bad):
        flag('forme/seule-ponctuee', q, f"«{good[:60]}»")

    # --- explication qui paraphrase ---
    ng, ne = norm(good).rstrip('.'), norm(expl)
    if ng and ng in ne: flag('expl/paraphrase-litterale', q, f"«{good[:50]}» ⊂ expl")
    ew = words(expl); 
    if gw and len(gw - ew) == 0 and len(ew) <= len(gw) + 3:
        flag('expl/paraphrase-lexicale', q, f"expl={expl[:60]}")
    if len(expl) < 40: flag('expl/trop-courte', q, expl)

order = ['schema/','lettre/','forme/','longueur/','fuite/','expl/','image/']
print(f"== {len(QS)} questions ==\n")
for k in sorted(findings, key=lambda k: (order.index(next(p for p in order if k.startswith(p))), k)):
    v = findings[k]
    print(f"### {k}  ({len(v)})")
    for subj, topic, qid, prompt, detail in v:
        print(f"  [{subj}/{topic}] {qid[:8]} «{prompt}» — {detail}")
    print()

for label, arr in [('code', lens_good), ('swift', lens_bad)]:
    longest = sum(1 for g, m in arr if g > m)
    print(f"{label}: bonne réponse plus longue que la moyenne des distracteurs dans {longest}/{len(arr)} cas; "
          f"écart moyen {sum(g-m for g,m in arr)/len(arr):+.1f} car.")
