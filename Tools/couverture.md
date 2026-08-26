# Couverture du référentiel ETG

Source du référentiel : [Objectifs et réglementation de l'examen du code](https://www.securite-routiere.gouv.fr/passer-son-permis-de-conduire/preparation-de-lexamen-du-code-de-la-route/objectifs-et), section « Onze thèmes à connaître » (relevé le 2026-08-23).

**Note méthodologique — à lire avant la carte.** Cette page est rendue en JavaScript : un
`WebFetch` classique en revient avec un corps vide (déjà constaté avant cette tâche). Le
contenu ci-dessous vient de l'export JSON qui alimente la page côté serveur
(`<url>?_format=json`, une route Drupal standard), pas d'une supposition sur son contenu.
Cet export sert le texte exact de la page — y compris son incohérence : le titre de section
annonce « Onze thèmes à connaître » et le paragraphe qui suit répète « Les onze thèmes
référencés sont : », mais la liste à puces qui suit n'en compte que **dix**. Cette
divergence est celle du site officiel lui-même (contenu modifié le 2026-03-26 d'après ses
métadonnées), pas une erreur de lecture — elle est signalée ici plutôt que corrigée en
silence.

Le onzième thème manquant a été recoupé sur une deuxième source de la liste blanche : le
PDF officiel [Exemples de questions-réponses de l'épreuve du code de la route](https://www.securite-routiere.gouv.fr/sites/default/files/2020-04/reponsesquestionspermisauto_v1604.pdf)
(PDF statique, lu intégralement) étiquette sa question 10 « Gestes de premier secours », en
citant la loi n° 2015-294 du 17 mars 2015 qui a introduit cette épreuve dans l'examen.
Ce thème n'apparaît dans aucune des dix puces de la page précédente ; il complète la liste
à onze plutôt que de rester une reconstitution de mémoire.

Pistes suivies, dans l'ordre du brief : l'arrêté du 27 avril 2016 (Légifrance,
`JORFTEXT000032471964`) ne porte le programme que dans une annexe reproduite en image dans
le fac-similé du JO — illisible en texte, écarté. Le PDF d'exemples de questions (piste 2)
a donné le onzième thème ci-dessus, mais ses propres étiquettes par question (« Capacité de
perception et d'évaluation », « Conscience des risques liés aux usagers vulnérables », etc.
— quatorze libellés différents relevés sur ses 24 premières questions) forment une grille
plus fine que les onze thèmes de communication et ne s'y recoupent pas proprement ; elles
n'ont pas été retenues comme colonne du tableau. Le REMC (piste 4, arrêté du 13 mai 2013,
`JORFTEXT000027506891`) est un référentiel de *formation* à quatre compétences (matrice
GDE), pas la banque de questions de l'examen — écarté pour cette carte.

Une ligne par couple (thématique officielle, `topic` de `questions.json`). `Tools/audit.py`
refuse un `topic` `code` absent de la colonne du milieu : un topic non rattaché est soit
une faute de frappe, soit un pan de contenu hors référentiel. Le volume est indicatif et
se relit avec `python3 Tools/audit.py`.

| thématique ETG | topic Valido | volume | verdict |
|---|---|---:|---|
| Arrêt et stationnement | `Arrêt & stationnement` | 11 | couvert |
| Croisement et dépassement | `Croisement & dépassement` | 15 | couvert |
| Économie et écoconduite | `Mécanique & environnement` | 10 | à compléter |
| Règles de priorités | `Priorités & intersections` | 21 | couvert |
| Règles de circulation | `Vitesse` | 16 | couvert |
| Règles de circulation | `Permis & sanctions` | 14 | couvert |
| Signalisation | `Panneaux & marquage` | 17 | couvert |
| Signalisation | `Feux` | 19 | couvert |
| Tunnels et passages à niveau | `Tunnels & passages à niveau` | 15 | couvert |
| Visibilité et éclairage | `Feux` | 19 | à compléter |
| Usagers, partage de l'espace public | `Usagers & partage de la route` | 18 | couvert |
| Prise de conscience des risques | `Alcool & stupéfiants` | 14 | couvert |
| Prise de conscience des risques | `Distances & freinage` | 10 | couvert |
| Premiers secours | `Premiers secours` | 13 | couvert |

`Feux` apparaît deux fois : le topic mélange, sans le distinguer dans `questions.json`, les
feux de signalisation (rouge/orange/vert, clignotants) et l'éclairage du véhicule (feux de
croisement, antibrouillard, phares). Le volume affiché (19) est celui du topic entier sur
chaque ligne ; il ne s'additionne pas d'une ligne à l'autre.

La tâche 10 a fait passer le topic de 10 à 19 questions, dont **six** neuves du seul côté
éclairage — feux de détresse en file ininterrompue, feux de croisement derrière un véhicule
suivi de près, feux avant de brouillard, éclairage d'un véhicule à l'arrêt hors zone
éclairée, véhicule mal éclairé croisé de nuit, panne des feux de croisement. Le partage est
désormais de **huit** questions côté signalisation et **onze** côté éclairage. Il reste
implicite dans le fichier : aucun champ ne le porte, et cette carte est le seul endroit où
il est écrit.

Le verdict de la ligne « Visibilité et éclairage » reste `à compléter` malgré ce volume :
juger si onze questions suffisent à couvrir la thématique une fois isolée revient à la
tâche 21, qui referme la passe et voit l'ensemble des dix-sept tâches de contenu — pas à
celle qui vient d'y ajouter des questions.

Le rattachement de `Vitesse` et `Permis & sanctions` à « Règles de circulation », et
d'`Alcool & stupéfiants` et `Distances & freinage` à « Prise de conscience des risques »,
est un jugement de classement, pas une équivalence directe : aucun des onze thèmes ne nomme
explicitement « vitesse », « barème de points » ou « alcool ». Le détail de ce jugement, et
les réserves qui vont avec, sont dans le rapport de la tâche 1 — pas ici.

## Topics à créer (thématiques `absent`)

Trois thématiques n'ont aucun topic `code` chez elles. Ces noms sont **arrêtés ici** : les
tâches 15 à 17 les reprennent tels quels, sans les réinventer.

- `Croisement & dépassement` — pour « Croisement et dépassement ». **Créé par la tâche 16** (2026-08-26), 15 questions.
- `Tunnels & passages à niveau` — pour « Tunnels et passages à niveau ». **Créé par la tâche 17** (2026-08-26), 15 questions.
- `Usagers & partage de la route` — pour « Usagers, partage de l'espace public ». **Créé par la tâche 15** (2026-08-26), 18 questions.
