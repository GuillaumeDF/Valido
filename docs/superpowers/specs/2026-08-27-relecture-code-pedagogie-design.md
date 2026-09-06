# Relecture des 255 questions `code` — justesse contre source, et pédagogie

Spec du 2026-08-27. Troisième passe de contenu, après une première d'août 2026 dont le
rapport n'est plus conservé, et la seconde
([`Tools/audit-2026-08-passe-2.md`](../../../Tools/audit-2026-08-passe-2.md)), qui a
construit le registre de fraîcheur sur lequel cette passe s'appuie.

## Le problème

Deux défauts, dans cet ordre.

**1. Le registre dit contre quoi une question a été vérifiée. Rien ne dit que la question
ne va pas plus loin que ça.** `sources.md` porte 255 lignes, dont 130 `datée` avec article,
version en vigueur et date de relevé — affirmation de 461 caractères en médiane. La carte,
elle, tient en un énoncé, quatre options et une explication de 234 caractères. Le contrôle
d'`audit.py` vérifie qu'une ligne **existe** et que sa source est recevable ; il ne peut pas
vérifier que la carte n'affirme rien de plus que la ligne. Mesure du défaut : **74 des 255
explications `code`** portent un absolu ou une obligation (« toujours », « jamais », « dans
tous les cas », « obligatoire », « il suffit de »), réparti sur les treize domaines. Chacun
est peut-être exactement ce que dit l'article — ou une généralisation que l'article ne porte
pas. Personne ne l'a regardé ligne à ligne.

**2. La carte teste, elle n'enseigne pas.** Elle a été écrite pour quelqu'un qui révise, pas
pour quelqu'un qui découvre. **Vingt-quatre** explications `code` sont sous 120 caractères et
se contentent de renommer la bonne réponse :

> `Hors agglomération, pour vous arrêter vous devez de préférence :`
> → « On dégage la chaussée pour ne pas gêner ni créer de danger. »

Qui ne connaît pas la règle n'apprend rien : pas *pourquoi* hors agglomération plutôt
qu'ailleurs, pas ce que « dégager » veut dire, pas où la règle s'arrête. `audit.py` mesure
déjà une partie de ce défaut sous le nom `expl/paraphrase-litterale` — **18** cas, dont
dix `code` — et sa ligne de base l'accepte parce qu'aucune passe ne s'était donné cet
objectif. Cette passe se le donne : **on apprend en lisant la carte, on ne fait pas que se
tester.**

## Le non-problème, écarté d'emblée

**La fraîcheur des relevés.** Les 130 lignes `datée` ont été relevées entre le 2026-08-23 et
le 2026-08-27 : la plus ancienne a quatre jours, le seuil d'alerte d'`audit.py` est à douze
mois. Rouvrir 130 URL pour les redater ne trouverait rien et coûterait la passe entière. Une
source ne se rouvre donc que sur **déclenchement** (voir « Procédure », étape 3), pas
systématiquement.

## Ce qui est décidé

| Décision | Retenu | Écarté |
|---|---|---|
| Autorité de référence | La ligne de `sources.md`, qui porte l'article et sa version | Rouvrir les 130 URL |
| Budget des illustrées | Tenu : 70 / 50 / 220 | Le relever à 300 dans `audit.py` et le test |
| Champs réécrits | Énoncé, options **et** explication | L'explication seule |
| Ordre de marche | Par domaine, du plus `datée` au moins | Par gravité de défaut, en travers des domaines |
| Écart douteux | Signalé dans le rapport, non corrigé | Corrigé au jugé |

**Pourquoi le budget des illustrées est tenu.** Les 49 cartes illustrées `code` plafonnent à
220 caractères d'explication, et leur médiane est déjà à **206** : la marge réelle est d'une
quinzaine de caractères par carte. Le plafond n'est pas une convention, il est écrit dans
`audit.py:135` **et** verrouillé par `leBudgetDeHauteurDesQuestionsIllustréesEstTenu` —
parce que sous une image la carte doit tenir à l'écran sans défilement. Sur ces 49 cartes,
enseigner mieux veut donc dire **couper du redondant pour faire place**, jamais allonger.
Deux régimes pédagogiques cohabiteront, et le rapport le dira carte par carte plutôt que de
le taire. `CLAUDE.md` est explicite — un échec se corrige dans les données, jamais dans le
test — et cette passe ne fait pas exception pour sa propre commodité.

**Pourquoi les trois champs et pas la seule explication.** Une explication qui enseigne sous
un énoncé qui présuppose la règle ne sert à rien : le lecteur a déjà décroché avant d'arriver
à l'explication. Et un distracteur qui n'existe que pour être éliminé par la forme (voir les
neuf pièges du §2 de [`questions.md`](../../../Tools/questions.md)) apprend une mauvaise
habitude de lecture. Les quatre options sont une part de l'enseignement : **ce sont les trois
confusions courantes qu'on nomme**, pas du remplissage.

## Les trois écarts de justesse

La demande nomme trois défauts. Ils se cherchent différemment, et il faut les distinguer
avant d'ouvrir une carte, sinon on cherche le mauvais.

| Écart | Signature | Correction |
|---|---|---|
| **Valeur périmée** | un chiffre de la carte absent de l'affirmation, ou différent | la valeur de l'article ; l'ancienne valeur **devient un distracteur** (§5 règle 3 de `questions.md`) |
| **Règle trop large** | un absolu dans la carte que l'affirmation ne porte pas | rétablir la condition que l'article pose |
| **Explication au-delà de l'article** | une conséquence, une sanction ou une exception que l'affirmation ne mentionne pas | couper, ou sourcer la clause en étendant l'affirmation |

**« Règle trop large » est le défaut le plus probable et le plus invisible.** Il ne produit
aucune sortie d'`audit.py` : la carte est bien formée, sa ligne de registre existe, sa source
est recevable, et elle dit quand même quelque chose que l'article ne dit pas. C'est le cas
qui justifie cette passe à lui seul. Le contre-exemple documenté dans `sources.md` — le
trottoir « très gênant » pour une voiture (R417-11 I 8° a) mais seulement « gênant » pour un
cyclomoteur (R417-10 II 1°) — montre la forme que prend l'erreur : deux articles voisins,
quatre régimes, et une carte qui en énonce un pour tous.

**Un écart douteux se signale, il ne se corrige pas.** Reprise de la règle 2 du §5 de
`questions.md` : un chiffre incertain dans la banque est moins grave qu'un chiffre faux
présenté comme sûr. Le doute va au rapport, avec ce qui a été lu et ce qui manque.

## Le critère pédagogique

« Formulé pour quelqu'un qui découvre la règle » doit être vérifiable à la lecture, sinon
c'est une intention. Quatre critères, appliqués carte par carte.

1. **L'énoncé se comprend sans connaître la réponse.** Une mise en situation ou une question
   dont les termes sont tous introduits. Un énoncé qui n'est répondable que par qui sait déjà
   n'est pas une question, c'est un rappel.
2. **Chaque option nomme une règle réelle**, lisible sans jargon non introduit. Les trois
   distracteurs sont les trois confusions qu'un débutant fait vraiment — pas des variantes
   inventées d'un chiffre (défaut relevé au §9.5 n° 14 de la passe 2).
3. **L'explication tient trois temps : la règle, sa raison, sa limite.** La raison est ce qui
   la rend mémorisable ; la limite — la condition qui la fait cesser — est ce qui empêche de
   la sur-appliquer, et c'est exactement le garde-fou contre le défaut « règle trop large ».
4. **L'explication n'est jamais la bonne option reformulée.** Critère déjà outillé :
   `expl/paraphrase-litterale`. Son compte `code` doit **baisser**, ce qui en fait la seule
   sortie d'`audit.py` dont cette passe attend un mouvement.

Le troisième critère est celui qui donne sa forme au travail. Sur les 49 illustrées, les
trois temps doivent tenir en 220 caractères : c'est possible en coupant la reformulation de
la réponse, qui est précisément ce que le critère 4 condamne. Les deux contraintes tirent
dans le même sens.

## Ce qui ne bouge pas

- **Les `id`.** Un id livré est immuable, la progression est indexée dessus. Réécrire un
  énoncé désynchronise l'id de `sha256("valido-v2:" + prompt)` : c'est déjà le cas de 260 des
  448 questions, l'immuabilité primant sur le hachage. Aucun `id` réécrit, aucun supprimé.
- **Aucune référence de lettre**, nulle part : les options sont mélangées à l'affichage.
- **Les seuils.** 70 / 50 / 220 sur les illustrées, +10 caractères sur l'équilibre de
  longueur, 20 sur l'écart de registre. Ni `audit.py` ni `BundledContentTests` ne sont
  touchés par cette passe.
- **Le volume.** 255 `code`, 49 illustrées. Cette passe réécrit, elle n'ajoute ni ne retire.
- **`docs/superpowers/` antérieur**, qui est de l'historique.

## Ce qui bouge en même temps que les questions

Une correction de contenu qui laisse ses registres derrière elle est une régression : c'est
le défaut n° 18 de la passe 2 (volumes périmés dans `couverture.md`).

- **`Tools/sources.md`** — quand la correction change ce qui est affirmé, la colonne
  `affirmation` le dit, et la date de relevé passe à celle de la lecture. Une clause
  d'explication conservée mais absente de l'affirmation s'y ajoute, ou disparaît de la carte.
  Un changement de `nature` (`stable` ↔ `datée`) se justifie dans la colonne.
- **`Tools/couverture.md`** — volumes recomptés en fin de passe, pas au fil de l'eau.
- **`Tools/audit-2026-08-passe-3.md`** — le rapport : par domaine, les écarts trouvés avec
  leur article, les doutes signalés non corrigés, et les cartes illustrées dont le budget a
  limité l'explication.

## L'ordre de marche

Treize domaines, traités de bout en bout. L'ordre suit la densité de `datée`, parce que
c'est là que la justesse est en jeu ; les domaines à forte charge d'images passent en fin,
quand le tour de main sur le budget de 220 est pris.

| # | Domaine | n | `datée` | illustrées |
|---|---|---|---|---|
| 1 | Permis & sanctions | 19 | 19 | 0 |
| 2 | Vitesse | 22 | 19 | 4 |
| 3 | Alcool & stupéfiants | 18 | 17 | 0 |
| 4 | Usagers & partage de la route | 18 | 14 | 4 |
| 5 | Mécanique & environnement | 20 | 12 | 1 |
| 6 | Distances & freinage | 21 | 10 | 0 |
| 7 | Arrêt & stationnement | 17 | 10 | 3 |
| 8 | Premiers secours | 18 | 9 | 0 |
| 9 | Tunnels & passages à niveau | 15 | 8 | 3 |
| 10 | Priorités & intersections | 26 | 5 | 8 |
| 11 | Croisement & dépassement | 15 | 3 | 4 |
| 12 | Feux | 19 | 2 | 3 |
| 13 | Panneaux & marquage | 27 | 2 | 19 |
| | **Total** | **255** | **130** | **49** |

### Procédure, par carte

1. Lire la ligne de `sources.md` **avant** la carte. L'affirmation est la référence ; la
   carte est ce qu'on vérifie contre elle.
2. Chercher les trois écarts du tableau ci-dessus, dans cet ordre.
3. **Rouvrir la source** dans un seul cas : la carte affirme quelque chose que l'affirmation
   ne couvre pas et qui n'est pas manifestement faux. Alors on lit l'article consolidé — pas
   une page de synthèse : le « Vérifié le » de `service-public` date la lecture, pas la
   valeur, et `securite-routiere.gouv.fr` ne fait jamais autorité seul sur un chiffre.
4. Appliquer les quatre critères pédagogiques.
5. Reporter dans `sources.md` si l'affirmation a changé.

### Vérification, par domaine

`python3 Tools/audit.py` puis la suite complète, comparés à la ligne de base du 2026-08-27
inscrite dans `CLAUDE.md` :

```
lettre/reference            1     faux positif connu
forme/markdown              1     faux positif connu
forme/seule-ponctuee       14     informatif
longueur/plus-longue       97     informatif (+1 à +10)
expl/paraphrase-litterale  18     doit BAISSER (dix cas `code`)
```

Vides, et qui doivent le rester : `schema/`, `couverture/`, `source/`, `fuite/`, `image/`,
`longueur/plus-10`, `forme/backtick-isole`.

Deux mouvements sont **attendus** et ne sont pas des régressions : `expl/paraphrase-litterale`
baisse, et `longueur/plus-longue` peut bouger dans les deux sens puisque les options sont
réécrites. Un seul mouvement est interdit : une sortie qui passe de vide à non vide.

**L'angle mort à surveiller de près.** Le §7 n° 2 de la passe 2 recense la fuite d'une carte
vers **une autre** carte, qu'aucun outil ne voit : une explication qui énumère la bonne
réponse d'une question voisine. La passe 2 en a introduit une (`5c11020d` donnant la réponse
de `bda52045`). Une passe qui étoffe 255 explications est exactement la passe qui en
introduit : chaque explication enrichie se relit contre les autres cartes de son domaine.

## Hors périmètre

- **Les 193 questions `swift`.** La demande porte sur les `code`.
- **La génération depuis les pages de cours**, seule chose qui fera un feed infini (§10 de la
  passe 2). Cette passe améliore 255 cartes, elle n'en crée aucune.
- **Les angles morts ouverts du §7** et les constats parqués du §9.5 de la passe 2, sauf
  quand un domaine traité en croise un — auquel cas il est refermé au passage et le rapport
  le dit.
- **Le plafond des illustrées**, arbitré ci-dessus.
