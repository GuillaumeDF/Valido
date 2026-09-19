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

Volumes recomptés le **2026-08-27** par la tâche 21, à la clôture de la passe : 255 questions
`code`. Plusieurs lignes affichaient encore le volume qu'elles avaient avant les tâches de
contenu — `Arrêt & stationnement` disait 11 pour 17, `Distances & freinage` 10 pour 21.

| thématique ETG | topic Valido | volume | verdict |
|---|---|---:|---|
| Arrêt et stationnement | `Arrêt & stationnement` | 17 | couvert |
| Croisement et dépassement | `Croisement & dépassement` | 15 | couvert |
| Économie et écoconduite | `Mécanique & environnement` | 20 | à compléter |
| Règles de priorités | `Priorités & intersections` | 26 | couvert |
| Règles de circulation | `Vitesse` | 22 | couvert |
| Règles de circulation | `Permis & sanctions` | 19 | couvert |
| Signalisation | `Panneaux & marquage` | 27 | couvert |
| Signalisation | `Feux` | 19 | couvert |
| Tunnels et passages à niveau | `Tunnels & passages à niveau` | 15 | couvert |
| Visibilité et éclairage | `Feux` | 19 | couvert |
| Usagers, partage de l'espace public | `Usagers & partage de la route` | 18 | couvert |
| Prise de conscience des risques | `Alcool & stupéfiants` | 18 | couvert |
| Prise de conscience des risques | `Distances & freinage` | 21 | couvert |
| Premiers secours | `Premiers secours` | 18 | couvert |

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

**Verdict de « Visibilité et éclairage », rendu par la tâche 21 : `couvert`.** Les onze
questions du versant éclairage tiennent la thématique — obligation de croisement, feux de
route et leur abaissement, antibrouillard avant et arrière, détresse en file, véhicule à
l'arrêt hors zone éclairée, véhicule mal éclairé croisé de nuit, panne des croisements,
clignotant. Le critère est celui déjà appliqué à « Signalisation », dont les huit questions
du versant signaux ont valu `couvert`. Ce qui relève de la **visibilité** au sens strict —
brouillard, pluie, distance de visibilité — vit dans `Vitesse` et `Distances & freinage`,
et n'est donc pas un trou.

**Ce qui reste, et qu'aucun verdict ne dit** : le partage entre les deux thématiques n'existe
que dans ce fichier. Une passe qui voudrait le rendre opposable scinderait le topic en deux
(`Feux` pour les signaux, un `Éclairage` neuf pour le reste). L'opération est sans risque —
le `topic` n'entre pas dans le calcul de l'`id`, qui ne hache que l'énoncé — mais elle est du
contenu, pas de la documentation, et cette tâche-ci est documentaire.

**Verdict de « Économie et écoconduite », rendu par la tâche 21 : `à compléter` maintenu, et
c'est le seul reste de couverture de la passe.** Le topic a doublé (10 → 20) sans que la
thématique gagne à proportion : **six** questions la portent vraiment — éco-conduite, frein
moteur en descente, galerie de toit et traînée, pression des pneus, classement Crit'Air,
huile et batterie usagées. Les quatorze autres sont des **équipements, du chargement et de la
retenue des enfants**, logés ici par la tâche 13 faute de thématique officielle qui les
accueille. Le compte de la colonne est donc juste et le verdict le contredit exprès : c'est
le volume du topic qui est à 20, pas celui de la thématique. Ce qu'une passe suivante
écrirait ici : consommation et vitesse, arrêt du moteur, entretien et rejets, choix du
rapport — tous chiffrables sur `ecologie.gouv.fr`, qui est dans la liste blanche.

Le rattachement de `Vitesse` et `Permis & sanctions` à « Règles de circulation », et
d'`Alcool & stupéfiants` et `Distances & freinage` à « Prise de conscience des risques »,
est un jugement de classement, pas une équivalence directe : aucun des onze thèmes ne nomme
explicitement « vitesse », « barème de points » ou « alcool ». Le détail de ce jugement, et
les réserves qui vont avec, sont dans le rapport de la tâche 1 — pas ici.

## Second axe : les libellés de compétence du spécimen

La table ci-dessus classe les treize `topic` sur les onze thèmes de communication de la
Sécurité routière, une taxonomie de **règles** (signalisation, priorités, stationnement…).
Le spécimen officiel de l'épreuve (`reponsesquestionspermisauto_v1604.pdf`, lu intégralement
le 2026-09-19) étiquette ses 24 questions avec **quatorze libellés** qui sont une taxonomie
de **compétences** — perception, conscience du risque, connaissance de la réglementation —
et qui ne se déduisent pas de la première grille. Un domaine sans bac dans la table du haut
ne peut jamais être signalé manquant : c'est exactement ce qui a laissé quatre compétences
invisibles depuis l'origine (voir `docs/superpowers/specs/2026-09-19-notions-maitrise-design.md`,
§1, « Quatre domaines absents depuis le départ »). Cette seconde table les rend visibles ;
leur écriture est un plan séparé.

| libellé de compétence (spécimen) | topic Valido | verdict |
|---|---|---|
| Conscience des risques liés aux usagers vulnérables | `Usagers & partage de la route` | couvert |
| Conscience des risques liés à la conduite de nuit | `Feux` | couvert |
| Connaissance de la réglementation | `Panneaux & marquage` | couvert |
| Sensibilisation aux conséquences des infractions au code de la route | `Permis & sanctions` | couvert |
| Gestes de premier secours | `Premiers secours` | couvert |
| Conscience des risques en franchissant les intersections | `Priorités & intersections` | couvert |
| Conduite écologique et respectueuse de l'environnement | `Mécanique & environnement` | couvert |
| Conscience des risques liés à la vitesse | `Vitesse` | couvert |
| Connaissance de la règle et prise en compte des usagers vulnérables | `Arrêt & stationnement` | couvert |
| Connaître les principaux organes du véhicule | `Mécanique & environnement` | couvert |
| Perception, attention, prise d'information | — | absent |
| Nouvelles technologies / ADAS (aides à la conduite) | — | absent |
| Boîte automatique et véhicule électrique | — | absent |
| Instruments du tableau de bord | — | absent |

Les dix premières lignes ne prétendent pas épuiser la compétence qu'elles nomment — le
spécimen en tire des cas précis (un piéton entre deux voitures, une distance de sécurité en
secondes) quand la banque Valido couvre la règle sous forme de familles ; c'est un verdict de
présence, pas d'équivalence. Quatre `topic` (`Alcool & stupéfiants`, `Croisement &
dépassement`, `Distances & freinage`, `Tunnels & passages à niveau`) n'apparaissent dans
aucune ligne : le spécimen, sur ses 24 questions, ne porte aucun libellé qui leur corresponde
directement — ils restent couverts par la première table, sur l'axe des règles.

## Topics à créer (thématiques `absent`)

Trois thématiques n'avaient aucun topic `code` chez elles. Ces noms ont été **arrêtés ici** :
les tâches 15 à 17 les ont repris tels quels, sans les réinventer. **Les trois sont créées ;
plus aucune thématique du référentiel n'est `absent`.**

- `Croisement & dépassement` — pour « Croisement et dépassement ». **Créé par la tâche 16** (2026-08-26), 15 questions.
- `Tunnels & passages à niveau` — pour « Tunnels et passages à niveau ». **Créé par la tâche 17** (2026-08-26), 15 questions.
- `Usagers & partage de la route` — pour « Usagers, partage de l'espace public ». **Créé par la tâche 15** (2026-08-26), 18 questions.
