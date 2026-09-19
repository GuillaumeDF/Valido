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
| `croisement/regles` | `Priorités & intersections` | 0 | 1 | à compléter |
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
| `panneaux/panonceaux` | `Panneaux & marquage` | 0 | 2 | à compléter |
| `panneaux/portee` | `Panneaux & marquage`, `Vitesse` | 0 | 10 | à compléter |
| `permis/bareme` | `Distances & freinage`, `Feux`, `Permis & sanctions`, `Priorités & intersections` | 0 | 6 | à compléter |
| `permis/capital-points` | `Permis & sanctions` | 4 | 0 | couvert |
| `permis/probatoire` | `Permis & sanctions` | 4 | 0 | couvert |
| `permis/qualification` | `Permis & sanctions`, `Vitesse` | 0 | 7 | à compléter |
| `permis/recuperation` | `Permis & sanctions` | 3 | 0 | couvert |
| `pn/signalisation` | `Feux` | 0 | 1 | à compléter |
| `priorite/cas-particuliers` | `Distances & freinage`, `Priorités & intersections`, `Usagers & partage de la route` | 2 | 5 | couvert |
| `priorite/giratoire` | `Priorités & intersections` | 1 | 3 | couvert |
| `priorite/regimes` | `Priorités & intersections` | 2 | 4 | couvert |
| `secours/alerte` | `Premiers secours` | 3 | 0 | couvert |
| `secours/gestes` | `Premiers secours` | 5 | 5 | couvert |
| `secours/protection-alerte-secours` | `Premiers secours` | 3 | 1 | couvert |
| `securite/retenue` | `Mécanique & environnement` | 3 | 0 | couvert |
| `signalisation/hierarchie` | `Feux`, `Panneaux & marquage`, `Priorités & intersections`, `Vitesse` | 2 | 4 | couvert |
| `stups/regime` | `Alcool & stupéfiants` | 1 | 2 | couvert |
| `tunnel/conduite` | `Distances & freinage` | 0 | 2 | à compléter |
| `usagers/angles-morts` | `Usagers & partage de la route` | 1 | 1 | couvert |
| `usagers/cyclistes` | `Priorités & intersections`, `Usagers & partage de la route` | 2 | 2 | couvert |
| `usagers/deux-roues-motorises` | `Usagers & partage de la route` | 3 | 0 | couvert |
| `usagers/edpm` | `Usagers & partage de la route` | 4 | 0 | couvert |
| `usagers/pietons` | `Usagers & partage de la route` | 2 | 1 | couvert |
| `usagers/vulnerables` | `Usagers & partage de la route` | 0 | 1 | à compléter |
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
- **`panneaux/couleurs` n'a aucune carte.** Pas une seule du domaine ne prend la couleur
  comme axe indépendant de la forme ; les deux fondations existantes la traitent à
  l'intérieur d'une silhouette. La notion n'entre donc pas encore dans ce tableau.

`marquage/lignes` est l'inverse exact : quatre de ses cinq membres sont **énoncés** en
toutes lettres (continue axiale, discontinue axiale, discontinue de rive, mixte), sans image
et sans cas. Ce sont quatre fondations, pas une — c'est la forme de la carte qui décide, et
elle est ici celle de l'exemple de la spec (« Un panneau triangulaire à bord rouge
annonce : »). Le domaine était bien en panne d'ordre et non de contenu : le boost portera
sur les quatre, ce qui est exactement ce qui les rapproche.
