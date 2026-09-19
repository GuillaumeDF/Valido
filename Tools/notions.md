# Registre des notions

Une ligne par notion, sur le modèle de [`couverture.md`](couverture.md). `Tools/audit.py`
refuse une `notion` absente de ce tableau, et une notion qui n'a aucune carte `fondation`.

Une **notion** est un cran plus fin qu'un `topic` : `Panneaux & marquage` en porte
plusieurs, et une même notion peut traverser plusieurs `topic` — c'est l'axe transversal
que `topic` ne sait pas porter. La colonne « topics concernés » le montre.

Le **rôle** est déclaré, pas déduit. Une `fondation` énonce le système (« Un panneau
triangulaire à bord rouge annonce : ») ; une `application` l'exerce sur un cas (« Ce
panneau indique : »). Aucune heuristique sur le `prompt` ne sait faire la différence.

Surchargeable par `VALIDO_NOTIONS_MD`, ce qui sert à vérifier une règle sur un cas d'essai.

| notion | topics concernés | fondations | applications | verdict |
|---|---|---:|---:|---|
| `alcool/depistage` | `Alcool & stupéfiants` | 1 | 2 | couvert |
| `alcool/metabolisme` | `Alcool & stupéfiants` | 4 | 0 | couvert |
| `alcool/sanctions` | `Alcool & stupéfiants` | 1 | 3 | couvert |
| `alcool/seuils` | `Alcool & stupéfiants` | 3 | 1 | couvert |
| `croisement/regles` | `Croisement & dépassement`, `Priorités & intersections` | 1 | 2 | couvert |
| `depassement/interdictions` | `Croisement & dépassement` | 5 | 1 | couvert |
| `depassement/manoeuvre` | `Croisement & dépassement` | 5 | 2 | couvert |
| `distances/adherence` | `Distances & freinage`, `Mécanique & environnement` | 1 | 4 | couvert |
| `distances/bau` | `Distances & freinage` | 0 | 2 | à compléter |
| `distances/composition-arret` | `Distances & freinage` | 4 | 2 | couvert |
| `distances/intervalle` | `Distances & freinage` | 2 | 3 | couvert |
| `environnement/critair` | `Mécanique & environnement` | 1 | 0 | couvert |
| `environnement/ecoconduite` | `Mécanique & environnement` | 1 | 1 | couvert |
| `feux/eclairage-vehicule` | `Feux` | 5 | 6 | couvert |
| `feux/signaux-tricolores` | `Feux` | 2 | 3 | couvert |
| `marquage/lignes` | `Panneaux & marquage` | 4 | 3 | couvert |
| `marquage/zones` | `Panneaux & marquage`, `Priorités & intersections`, `Usagers & partage de la route` | 0 | 4 | à compléter |
| `mecanique/chargement` | `Mécanique & environnement` | 1 | 1 | couvert |
| `mecanique/entretien` | `Mécanique & environnement` | 3 | 0 | couvert |
| `mecanique/equipements-obligatoires` | `Mécanique & environnement`, `Premiers secours` | 1 | 2 | couvert |
| `mecanique/pneus` | `Mécanique & environnement` | 4 | 0 | couvert |
| `mecanique/temoins` | `Mécanique & environnement` | 2 | 0 | couvert |
| `panneaux/formes` | `Panneaux & marquage`, `Priorités & intersections`, `Vitesse` | 4 | 7 | couvert |
| `panneaux/panonceaux` | `Panneaux & marquage`, `Tunnels & passages à niveau` | 0 | 3 | à compléter |
| `panneaux/portee` | `Panneaux & marquage`, `Vitesse` | 0 | 9 | à compléter |
| `permis/bareme` | `Distances & freinage`, `Feux`, `Permis & sanctions`, `Priorités & intersections`, `Tunnels & passages à niveau` | 0 | 7 | à compléter |
| `permis/capital-points` | `Permis & sanctions` | 4 | 0 | couvert |
| `permis/probatoire` | `Permis & sanctions` | 4 | 0 | couvert |
| `permis/qualification` | `Permis & sanctions`, `Vitesse` | 0 | 7 | à compléter |
| `permis/recuperation` | `Permis & sanctions` | 3 | 0 | couvert |
| `pn/franchissement` | `Tunnels & passages à niveau` | 3 | 1 | couvert |
| `pn/signalisation` | `Feux`, `Tunnels & passages à niveau` | 2 | 2 | couvert |
| `priorite/cas-particuliers` | `Arrêt & stationnement`, `Distances & freinage`, `Priorités & intersections`, `Usagers & partage de la route` | 2 | 6 | couvert |
| `priorite/giratoire` | `Priorités & intersections` | 1 | 3 | couvert |
| `priorite/regimes` | `Priorités & intersections` | 2 | 4 | couvert |
| `secours/alerte` | `Premiers secours` | 3 | 0 | couvert |
| `secours/gestes` | `Premiers secours` | 5 | 5 | couvert |
| `secours/protection-alerte-secours` | `Premiers secours` | 3 | 1 | couvert |
| `securite/retenue` | `Mécanique & environnement` | 3 | 0 | couvert |
| `signalisation/hierarchie` | `Feux`, `Panneaux & marquage`, `Priorités & intersections`, `Vitesse` | 2 | 4 | couvert |
| `stationnement/arret-vs-stationnement` | `Arrêt & stationnement`, `Panneaux & marquage` | 1 | 3 | couvert |
| `stationnement/gradation` | `Arrêt & stationnement` | 0 | 5 | à compléter |
| `stationnement/interdictions` | `Arrêt & stationnement` | 4 | 1 | couvert |
| `stationnement/regles-locales` | `Arrêt & stationnement` | 2 | 0 | couvert |
| `stups/regime` | `Alcool & stupéfiants` | 1 | 2 | couvert |
| `tunnel/conduite` | `Distances & freinage`, `Tunnels & passages à niveau` | 4 | 2 | couvert |
| `tunnel/incident` | `Tunnels & passages à niveau` | 0 | 2 | à compléter |
| `usagers/angles-morts` | `Usagers & partage de la route` | 1 | 1 | couvert |
| `usagers/cyclistes` | `Priorités & intersections`, `Usagers & partage de la route` | 2 | 2 | couvert |
| `usagers/deux-roues-motorises` | `Usagers & partage de la route` | 3 | 0 | couvert |
| `usagers/edpm` | `Usagers & partage de la route` | 4 | 0 | couvert |
| `usagers/pietons` | `Usagers & partage de la route` | 2 | 1 | couvert |
| `usagers/vulnerables` | `Arrêt & stationnement`, `Usagers & partage de la route` | 0 | 2 | à compléter |
| `vitesse/intemperies` | `Vitesse` | 1 | 2 | couvert |
| `vitesse/limites-par-route` | `Vitesse` | 5 | 2 | couvert |
| `vitesse/probatoire` | `Vitesse` | 0 | 3 | à compléter |
| `vitesse/sanctions` | `Vitesse` | 0 | 4 | à compléter |

## Ce que le domaine pilote a montré

`Panneaux & marquage` a été annoté le premier, ses 27 cartes lues une par une. Quatre
constats qui servent aux douze domaines suivants, et au lot de fondations à écrire :

- **« couvert » ne veut pas dire « fondé ».** `panneaux/formes` porte quatre fondations —
  le rond à bord rouge, le rond à fond bleu, l'octogone et le triangle pointe en bas, ces
  deux derniers vivant dans `Priorités & intersections` — et le contrôle se tait. Mais le
  **triangle à bord rouge** (danger) et le **carré ou rectangle** (indication) sont exercés
  sans qu'aucune carte ne les énonce. Le compteur est par notion, pas par membre de la
  famille : **une seule fondation suffit à le faire taire, quelle que soit la classe qu'elle
  énonce** — une famille à moitié enseignée passe donc « couvert ». Il attrape bien la notion
  à **zéro** fondation, et c'est déjà beaucoup ; ce qu'il ne voit pas, c'est *laquelle* des
  six classes est énoncée. Seule la lecture à la main voit qu'il manque le triangle à bord
  rouge et le carré, et elle doit **chercher hors du `topic`** : deux des quatre fondations
  ont été trouvées dans un autre domaine, et une notion transversale ne s'annote pas
  domaine par domaine sans balayer les `topic` voisins.
- **`panneaux/portee` est le plus gros manque du domaine** : neuf cartes exercent l'étendue
  d'une prescription — où elle commence, jusqu'où elle court, ce qu'elle couvre — et aucune
  ne dit la règle. C'est le premier candidat du lot de fondations, à égalité avec les formes.
- **`panneaux/panonceaux` et `marquage/zones`** (hachures, damier de voie de détresse) ont
  deux applications chacun et pas une ligne qui dise ce qu'est un panonceau, ni ce qu'une
  surface peinte réserve. Deux familles que le balayage de la spec n'avait pas vues.
  *(Comptes du 2026-09-19 : les douze domaines leur ont ajouté des membres — trois cartes
  pour les panonceaux, quatre pour les zones. Le manque de fondation, lui, est intact.)*
- **`panneaux/couleurs` n'a aucune carte.** Pas une seule du domaine ne prend la couleur
  comme axe indépendant de la forme ; les deux fondations existantes la traitent à
  l'intérieur d'une silhouette. La notion n'entre donc pas encore dans ce tableau.

`marquage/lignes` est l'inverse exact : quatre de ses cinq membres sont **énoncés** en
toutes lettres (continue axiale, discontinue axiale, discontinue de rive, mixte), sans image
et sans cas. Ce sont quatre fondations, pas une — c'est la forme de la carte qui décide, et
elle est ici celle de l'exemple de la spec (« Un panneau triangulaire à bord rouge
annonce : »). Le domaine était bien en panne d'ordre et non de contenu : le boost portera
sur les quatre, ce qui est exactement ce qui les rapproche.

## Ce que les douze autres domaines ont montré (2026-09-19)

Les 226 cartes restantes ont été lues une par une, domaine par domaine. Le registre passe
de 5 à **57 notions**, et les 255 cartes `code` en portent toutes une.

**La règle de partage tenue sur les 226.** Une `fondation` a un énoncé **abstrait** — pas
d'image, pas de scène, pas de « vous » placé dans une situation — **et** sa bonne réponse
énonce la règle d'une classe **sur l'axe propre de la famille**. Tout le reste est une
`application` : la carte a besoin d'une entrée particulière (une image, une scène, une
vitesse, un panneau) ou elle croise l'axe de la famille avec un autre. C'est la règle qui
sépare « En agglomération, la vitesse maximale par défaut » (fondation : l'axe de
`vitesse/limites-par-route` *est* le type de route) de « Jeune conducteur en période
probatoire : quelle vitesse maximale sur autoroute ? » (application : l'axe de
`vitesse/probatoire` est le régime du novice, et la carte le croise avec un type de route).

**Un chiffre attaché à une infraction n'est pas une fondation.** Les cartes de barème
(« … fait perdre : 3 points ») et de qualification (« … est puni de : deux ans et 4 500 € »)
nomment bien une classe, mais ce qu'elles en donnent est une **conséquence**, pas une règle
de conduite, et la structure de l'échelle — les paliers de retrait, la frontière
contravention / délit — n'est énoncée par aucun énoncé de la banque. `permis/bareme` (7),
`permis/qualification` (7), `vitesse/sanctions` (4) et `stationnement/gradation` (5) sont
donc **entièrement en applications**. Ce sont quatre fondations à écrire, pas quatre
annotations à corriger.

**Trois prévisions du balayage ne survivent pas à la lecture**, et c'est la leçon du pilote
rejouée : avant de déclarer une famille non fondée, il faut lire ses cartes, pas la spec.
`vitesse/intemperies` est fondée (« Par brouillard, avec une visibilité inférieure à 50
mètres, la vitesse est limitée à : ») ; `feux/eclairage-vehicule` l'est **cinq fois** (le
clignotant, les codes, les antibrouillard avant et arrière, les détresses — chacun nomme un
feu et donne sa règle) ; et `permis/qualification` n'est pas la famille des catégories de
permis mais celle de la **nature** de l'infraction, six cartes de ce domaine plus le grand
excès de vitesse.

**Deux familles nées de la lecture**, absentes du balayage : `signalisation/hierarchie`
(agent > temporaire > feu > panneau > marquage : six cartes, quatre `topic`, deux fondations
dont l'une vivait dans `Panneaux & marquage` et l'autre dans `Priorités & intersections`) et
`mecanique/entretien` (niveaux, contrôle technique, déchets dangereux). `securite/retenue`
élargit la `securite/retenue-enfants` attendue : les dispenses de ceinture et les deux
cartes de siège enfant sont le même bloc R412-1 à R412-3.

**Vingt-deux notions portent moins de quatre cartes distinctes** et ne peuvent donc pas être
acquises (`SchedulerConfig.masteryStreak` = 4). Sur celles qui portent déjà une fondation,
cette fondation sera **boostée indéfiniment** : c'est le défaut symétrique de la notion non
fondée, et il n'a pas de sortie d'outil. Le cas extrême est `environnement/critair`, **une
seule carte**, qui est une fondation. La liste complète est dans le rapport de la tâche 7.
