# Ligne de base d'`audit.py` — historique

Pourquoi chaque compteur vaut ce qu'il vaut, et pourquoi ses mouvements passés sont voulus.
La valeur courante est dans `CLAUDE.md` ; ce fichier dit d'où elle vient. On le lit avant de
juger un écart à la ligne de base.

## Les compteurs

`audit.py` **sort toujours 0** : c'est le rapport qu'on lit, pas le code de retour. La
ligne de base au 2026-08-29, sur 448 questions, n'est pas vide — `longueur/plus-longue`
(76, informatif, le seuil dur est `plus-10`), `expl/paraphrase-litterale` (20),
`forme/seule-ponctuee` (14) et deux faux positifs connus (`lettre/reference` 1,
`forme/markdown` 1) ; reconfirmée au 2026-09-19 sur 464 questions, ces cinq chiffres n'ont
pas bougé — les seize fondations ajoutées par le chantier des notions n'ont pesé sur aucun
d'eux ; au 2026-09-24, après le chantier des illustrations, toujours les mêmes.
`longueur/plus-longue` seul bouge ensuite, à **77** : un correctif a raccourci d'un
caractère le distracteur D de `37fe1af42b8d8141b1d0e3ca0b855119` (« franchie » →
« franchi »), qui rompt l'égalité 49/49 avec la bonne réponse — elle la dépasse désormais
d'un caractère. Voulu, informatif, `plus-10` reste vide. Doivent
rester **vides** : `schema/`, `couverture/`, `source/`, `fuite/`, `image/`,
`longueur/plus-10`, `forme/backtick-isole` — ce dernier ne mordant que si une option porte
un backtick, son zéro ne prouve rien sur un lot sans code span — et, depuis le 2026-09-19,
`notions/non-declaree`, `notions/sans-fondation` et `notions/carte-orpheline`.
Depuis le 2026-09-06, `source/` recouvre aussi `source/editeur-non-corrobore` : la liste
blanche est scindée en `DOMAINES_FAIT` (autorité sur un chiffre) et `DOMAINES_FORME` (les
éditeurs d'ETG, admis pour la forme des questions), et une ligne `datée` qui ne citerait
qu'un éditeur est refusée. Le registre est surchargeable par `VALIDO_SOURCES_MD`, ce qui
sert à vérifier la règle sur un cas d'essai.
Comparer à cette base, pas à zéro ; le §3 de `Tools/questions.md` dit lesquelles demandent
un tri à la main, et le §7 de `Tools/audit-2026-08-passe-2.md` ce que l'outil ne voit pas.

Trois compteurs de forme sont nés le 2026-09-06 avec le diagnostic
[`Tools/audit-2026-09-formes.md`](Tools/audit-2026-09-formes.md) :
`forme/impersonnel`, `forme/hors-situation` et `forme/definitionnel`. Ils sont
**informatifs**, comme `longueur/plus-longue`, et ne rejoignent pas les compteurs devant
rester vides : ils mesurent l'écart de forme avec l'épreuve réelle, pas un défaut. Les
faire baisser pour eux-mêmes est un contresens — sur une carte de signalisation, un énoncé
impersonnel est souvent la forme juste. Leurs valeurs de départ sont dans le §3 du rapport ;
sa section « Ce que l'outillage ne voit pas » et sa recommandation chiffrée (§4, les 255
cartes lues à la main, 230 `oui` / 3 `partiel` / 22 `non`) sont l'entrée de toute décision de
réécriture — ne pas la rejouer de mémoire, la relire.

**Ces trois compteurs ont encore bougé avec le chantier des notions, et c'est voulu, pas une
dérive.** Mesuré au 2026-09-19 sur 464 questions : `forme/impersonnel` **199 → 215**,
`forme/hors-situation` **200 → 216**, `forme/definitionnel` **94 → 98**. Les seize cartes
`fondation` qui portent l'axe notion expliquent la totalité du mouvement : une fondation
énonce un système, elle est par construction un énoncé abstrait, sans mise en scène et sans
« vous » — exactement ce que ces deux premiers compteurs mesurent. Chaque future fondation
les fera monter d'une unité chacun. Ils restent informatifs ; les faire baisser voudrait dire
écrire des fondations qui n'énoncent rien.

**`forme/hors-situation` 216 → 189 au 2026-09-24, voulu lui aussi.** Le compteur ignore toute
carte illustrée : les vingt-sept cartes qui ont reçu une image dans le chantier des
illustrations en sortent, aucune n'y entre. Une fondation illustrée ne le fait donc pas
monter. `forme/impersonnel` **215 → 216** : un énoncé raccourci a perdu son « votre ».
`forme/definitionnel` reste à 98. Le détail carte par carte est dans
[`Tools/audit-2026-09-illustrations.md`](Tools/audit-2026-09-illustrations.md), §1 et §5.

**Les deux chiffres qui ont bougé à la passe 3 sont voulus, ce ne sont pas des dérives.**
`longueur/plus-longue` **97 → 76** : tout le mouvement est côté `code` (34 → 13), obtenu en
élargissant les distracteurs, pas en raccourcissant les bonnes réponses. Et
`expl/paraphrase-litterale` **18 → 20** (dont `code` 10 → 12) a **monté** là où la spec de la
passe attendait une baisse : le critère pédagogique retenu exige qu'une explication énonce la
règle, et sur une carte dont la règle *est* un chiffre, ce compteur mesure l'objectif inverse.
Trois cartes ont gagné le chiffre qui leur manquait, une est sortie de la liste sans qu'aucune
fuite ne se ferme (elle écrit « quatre » là où l'option dit « 4 » — `audit.py:194` teste une
sous-chaîne). **Donc : `expl/paraphrase-litterale` n'est pas un compteur à minimiser** ; le
faire baisser pour lui-même vide les cartes de ce qu'elles enseignent. Les trois classes à
distinguer sont dans `Tools/audit-2026-08-passe-3.md`, section « La ligne de base
publiée » ; les **douze angles morts** mesurés sont dans la section « Ce que l'outillage
ne voit toujours pas » du même fichier. Neuf des douze portent une ligne d'outil ; les
trois autres n'en ont pas et ne peuvent pas en avoir — « règle trop large », la récurrence
d'une forme de distracteur sur le lot et la citation de registre jamais lue jusqu'au bout
sont précisément ce qu'aucune sortie ne mesure.

## `relire.py --fuites` : ce qu'il a trouvé

Sur les 34 fuites fermées par la passe 3, il en avait trouvé
neuf ; les vingt-cinq autres se sont vues à l'œil, en lisant les cartes voisines côte à côte.
La revue de fin de branche en a fermé **dix de plus** — 44 sur la branche, sans doublon — en
rejouant à la main le point 13 sur les treize domaines ; **aucune** n'a été trouvée par
l'outil. Depuis cette revue, `--fuites` **nomme** les bonnes réponses qu'il n'a pas testées
(84 des 255, relevé du 2026-08-31, recompté à chaque fois car il bouge avec les options) :
c'est cette liste-là qu'on grep à la main.
