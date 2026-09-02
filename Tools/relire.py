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

# Les trois champs sont `[^|]*` et non `.*?`, comme dans `audit.py:79`. Sur une ligne dont
# l'affirmation contient un `|`, `.*?` trouve quand même un découpage : la ligne est lue avec
# une affirmation tronquée et les colonnes décalées d'un cran, en silence. `[^|]*` ne trouve
# rien, la ligne disparaît du registre, et les deux outils le disent bruyamment — `audit.py`
# en `source/absente`, celui-ci en « AUCUNE ligne dans sources.md ».
LIGNE = re.compile(
    r'^\| `([0-9a-f]{32})` \| (stable|datée) \|([^|]*)\|([^|]*)\|([^|]*)\|\s*$', re.M)


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


def domaine_absent(questions, domaine):
    """Détecte un domaine inconnu ou mal tapé.

    Une typo dans le domaine retournerait « 0 recouvrement(s) sur 0 cartes »,
    impossible à distinguer d'une vraie absence de fuite. C'est le pire cas pour un
    contrôle qui couvre un angle mort : un silence qui ressemble à un quitus.
    La garde signale l'erreur plutôt que de la laisser passer inaperçue.
    """
    lot = cartes(questions, domaine)
    if not lot:
        topics = sorted({q['topic'] for q in questions if q['subject'] == 'code'})
        print(f'Aucune carte `code` dans « {domaine} ». Domaines connus :')
        for t in topics:
            print('  -', t)
        return True
    return False


def afficher(questions, registre, domaine):
    if domaine_absent(questions, domaine):
        return
    lot = cartes(questions, domaine)
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


# Trois mots pleins au minimum : sous ce seuil le recouvrement est du vocabulaire commun
# (« 50 km/h », « 3 points ») et noie le signal — mesuré à 235 faux positifs en sous-chaîne,
# 49 à deux mots, 19 à trois. Le seuil reste le bon ; ce qu'il coûte se compte (voir
# `sous_le_seuil`), il ne se tait plus.
SEUIL_MOTS = 3


def sous_le_seuil(lot):
    """Les cartes dont la bonne réponse ne sera cherchée nulle part.

    `fuites` ne va chercher une bonne réponse dans les explications que si elle porte au
    moins `SEUIL_MOTS` mots pleins — et « mot plein » veut dire cinq caractères après
    normalisation (voir `mots`), pas « mot ». Sur les 255 `code`, **84** passent dessous
    (mesuré le 2026-08-31) : ce sont très exactement les cartes dont la réponse est un
    nombre, celles où une fuite décide de tout.

    **Ce compte bouge avec les options, pas seulement avec le volume de la banque.** Il ne
    dépend que du texte des bonnes réponses : rallonger une option de deux mots la fait
    passer au-dessus du seuil et la retire de cette liste, sans qu'aucune question n'ait
    été ajoutée. C'est arrivé le 2026-08-31 — une bonne réponse de `Feux` a gagné un
    adverbe pour réparer un déséquilibre de longueur et est sortie du sous-seuil, faisant
    passer le compte de 85 à 84. Le chiffre écrit ici, au §3 de `questions.md` et dans le
    rapport de passe est donc un relevé daté, à recompter en faisant tourner l'outil.

    Imprimer « 0 recouvrement(s) sur 18 cartes » sans le dire est le défaut que le
    docstring de `domaine_absent` dénonce sur sa propre garde : un silence qui ressemble à
    un quitus. Le seuil ne bouge pas ; le résumé nomme ce qu'il n'a pas regardé, et le
    point 13 du calibrage dit quoi en faire — un `grep` à la main, que l'outil ne fera
    jamais.
    """
    return [q for q in lot if len(mots(bonne(q))) < SEUIL_MOTS]


def fuites(questions, domaine):
    """Une explication qui contient la bonne réponse d'une AUTRE carte.

    Angle mort n° 2 du §7 de la passe 2 : aucun contrôle d'`audit.py` ne regarde une
    carte à la lumière d'une autre, et la passe 2 a elle-même introduit une fuite de
    cette forme en étoffant une explication.
    """
    if domaine_absent(questions, domaine):
        return
    banque = [q for q in questions if q['subject'] == 'code']
    lot = cartes(questions, domaine)
    trouve = 0
    for q in lot:
        cible = mots(q['explanation'])
        for autre in banque:
            if autre['id'] == q['id']:
                continue
            reponse = mots(bonne(autre))
            if len(reponse) < SEUIL_MOTS:
                continue
            if reponse <= cible:
                trouve += 1
                print(f"{q['id'][:12]} (expl) recouvre la bonne réponse de "
                      f"{autre['id'][:12]} [{autre['topic']}]")
                print(f"    expl    : {q['explanation']}")
                print(f"    réponse : {bonne(autre)}")
    print(f'\n{trouve} recouvrement(s) sur {len(lot)} cartes de « {domaine} ».')
    if trouve:
        print("Chacun se relit à la main : un mot commun est normal, la réponse "
              "entière ne l'est pas.")

    ignorees = sous_le_seuil(banque)
    print(f"Portée réelle du test : {len(banque) - len(ignorees)} bonnes réponses `code` "
          f"sur {len(banque)} ont été cherchées dans ces {len(lot)} explications ; "
          f"{len(ignorees)} sont sous le seuil de {SEUIL_MOTS} mots pleins et n'ont été "
          f"cherchées nulle part.")
    local = sous_le_seuil(lot)
    if not local:
        print(f"Aucune carte de « {domaine} » n'est dans ce cas : les {len(lot)} bonnes "
              f"réponses du domaine sont toutes au-dessus du seuil.")
        return
    print(f"{len(local)} bonne(s) réponse(s) de « {domaine} » sous le seuil, NON TESTÉES — "
          f"à chercher à la main dans les explications et les OPTIONS des voisines "
          f"(point 13 du calibrage) :")
    # `id` entier, pas tronqué : les anciens id Notion partagent leurs douze premiers
    # caractères (`37fe1af42b8d…` couvre une bonne part de la banque), et cette liste sert
    # à greper. Un préfixe qui désigne sept cartes ne nomme rien.
    for q in sorted(local, key=lambda q: q['id']):
        print(f"  - {q['id']}  « {bonne(q)} »")
        print(f"      énoncé : {q['prompt']}")


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
