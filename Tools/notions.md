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
| `alcool/sanctions` | `Alcool & stupéfiants` | 1 | 4 | couvert |
| `alcool/seuils` | `Alcool & stupéfiants` | 3 | 1 | couvert |
| `croisement/regles` | `Croisement & dépassement`, `Priorités & intersections` | 1 | 2 | couvert |
| `depassement/interdictions` | `Croisement & dépassement` | 5 | 1 | couvert |
| `depassement/manoeuvre` | `Croisement & dépassement` | 5 | 2 | couvert |
| `distances/adherence` | `Distances & freinage` | 1 | 3 | couvert |
| `distances/bau` | `Distances & freinage` | 1 | 2 | couvert |
| `distances/composition-arret` | `Distances & freinage`, `Mécanique & environnement` | 4 | 3 | couvert |
| `distances/intervalle` | `Distances & freinage` | 2 | 3 | couvert |
| `environnement/critair` | `Mécanique & environnement` | 1 | 0 | couvert |
| `environnement/ecoconduite` | `Mécanique & environnement` | 1 | 1 | couvert |
| `feux/eclairage-vehicule` | `Feux` | 5 | 6 | couvert |
| `feux/signaux-tricolores` | `Feux` | 2 | 3 | couvert |
| `marquage/lignes` | `Panneaux & marquage` | 4 | 3 | couvert |
| `marquage/zones` | `Panneaux & marquage`, `Priorités & intersections`, `Usagers & partage de la route` | 1 | 4 | couvert |
| `mecanique/chargement` | `Mécanique & environnement` | 1 | 2 | couvert |
| `mecanique/entretien` | `Mécanique & environnement` | 3 | 0 | couvert |
| `mecanique/equipements-obligatoires` | `Mécanique & environnement`, `Premiers secours` | 1 | 2 | couvert |
| `mecanique/pneus` | `Mécanique & environnement` | 4 | 0 | couvert |
| `mecanique/temoins` | `Mécanique & environnement` | 2 | 0 | couvert |
| `panneaux/couleurs` | `Panneaux & marquage` | 1 | 0 | couvert |
| `panneaux/formes` | `Panneaux & marquage`, `Priorités & intersections`, `Vitesse` | 6 | 7 | couvert |
| `panneaux/panonceaux` | `Panneaux & marquage`, `Tunnels & passages à niveau` | 1 | 3 | couvert |
| `panneaux/portee` | `Panneaux & marquage`, `Vitesse` | 1 | 9 | couvert |
| `permis/bareme` | `Distances & freinage`, `Feux`, `Permis & sanctions`, `Priorités & intersections`, `Tunnels & passages à niveau` | 1 | 7 | couvert |
| `permis/capital-points` | `Permis & sanctions` | 4 | 0 | couvert |
| `permis/probatoire` | `Permis & sanctions` | 4 | 0 | couvert |
| `permis/qualification` | `Permis & sanctions`, `Vitesse` | 1 | 7 | couvert |
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
| `stationnement/gradation` | `Arrêt & stationnement` | 1 | 5 | couvert |
| `stationnement/interdictions` | `Arrêt & stationnement` | 4 | 1 | couvert |
| `stationnement/regles-locales` | `Arrêt & stationnement` | 2 | 0 | couvert |
| `stups/regime` | `Alcool & stupéfiants` | 1 | 2 | couvert |
| `tunnel/conduite` | `Distances & freinage`, `Tunnels & passages à niveau` | 4 | 2 | couvert |
| `tunnel/incident` | `Tunnels & passages à niveau` | 1 | 2 | couvert |
| `usagers/angles-morts` | `Usagers & partage de la route` | 1 | 1 | couvert |
| `usagers/cyclistes` | `Priorités & intersections`, `Usagers & partage de la route` | 2 | 2 | couvert |
| `usagers/deux-roues-motorises` | `Usagers & partage de la route` | 3 | 0 | couvert |
| `usagers/edpm` | `Usagers & partage de la route` | 4 | 0 | couvert |
| `usagers/pietons` | `Usagers & partage de la route` | 2 | 1 | couvert |
| `usagers/vulnerables` | `Arrêt & stationnement`, `Usagers & partage de la route` | 1 | 2 | couvert |
| `vitesse/intemperies` | `Vitesse` | 1 | 2 | couvert |
| `vitesse/limites-par-route` | `Vitesse` | 5 | 2 | couvert |
| `vitesse/probatoire` | `Vitesse` | 1 | 3 | couvert |
| `vitesse/sanctions` | `Vitesse` | 1 | 4 | couvert |

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
- **`panneaux/couleurs` n'avait aucune carte.** Pas une seule du domaine ne prenait la
  couleur comme axe indépendant de la forme ; les fondations de `panneaux/formes` la
  traitent à l'intérieur d'une silhouette. *(Refermé le 2026-09-19 : la notion entre dans
  le tableau ci-dessus avec sa fondation, `6f086316`, sur le fond jaune — voir « La
  fondation de couleur » plus bas.)*

`marquage/lignes` est l'inverse exact : quatre de ses cinq membres sont **énoncés** en
toutes lettres (continue axiale, discontinue axiale, discontinue de rive, mixte), sans image
et sans cas. Ce sont quatre fondations, pas une — c'est la forme de la carte qui décide, et
elle est ici celle de l'exemple de la spec (« Un panneau triangulaire à bord rouge
annonce : »). Le domaine était bien en panne d'ordre et non de contenu : le boost portera
sur les quatre, ce qui est exactement ce qui les rapproche.

## Ce que les douze autres domaines ont montré (2026-09-19)

Les 226 cartes restantes ont été lues une par une, domaine par domaine. Le registre passe
de 5 à **57 notions**, et les 255 cartes `code` en portent toutes une. *(Comptes de cette
étape-là : le registre en tient 58 depuis `panneaux/couleurs`, et 271 cartes `code` en
portent une.)*

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

**Vingt et une notions portent moins de quatre cartes distinctes, et ce n'est plus un
défaut.** Depuis le commit `a3b917b`, le seuil d'acquisition vaut
`min(masteryStreak, cartes de la notion)` (`FeedViewModel.swift:71`) : une notion mince
s'acquiert en autant de bonnes réponses qu'elle a de cartes, et sa fondation cesse alors
d'être boostée comme celle de n'importe quelle notion acquise. `environnement/critair`,
**une seule carte**, s'acquiert en une réponse. Le rapport de la tâche 7 en donne la liste
telle qu'elle était alors — vingt-deux, avant que les quinze fondations neuves n'en fassent
passer deux au-dessus de quatre et que `panneaux/couleurs` n'y entre à son tour.

## Les neuf fondations sans chiffre (2026-09-19)

Sept notions sont sorties de `notions/sans-fondation` — `panneaux/portee`,
`panneaux/panonceaux`, `marquage/zones`, `usagers/vulnerables`, `tunnel/incident`,
`distances/bau`, `mecanique/chargement` — et `panneaux/formes` a gagné les **deux membres
de famille** que le compteur ne pouvait pas voir : le **triangle à bord rouge** (danger) et
le **carré ou rectangle** (indication), exercés par sept applications sans qu'aucune carte
les énonce. C'est le constat du domaine pilote, vérifié : le compteur se tait dès la
première fondation, quelle que soit la classe qu'elle énonce.

**Toutes les neuf sont `stable`.** Le partage est celui du brief : une fondation qui aurait
besoin d'un chiffre pour être vraie — barème, amende, seuil, vitesse, durée — n'est pas
écrite ici. C'est pourquoi les six notions restantes (`alcool/sanctions`, `permis/bareme`,
`permis/qualification`, `stationnement/gradation`, `vitesse/probatoire`,
`vitesse/sanctions`) sont exactement celles dont la règle **est** une échelle chiffrée :
leurs fondations sont `datée`, et elles se relèvent contre `DOMAINES_FAIT` avant d'être
écrites.

Ce que ces neuf cartes ont demandé, et qu'aucun contrôle ne mesure : chacune énonce la
règle que ses applications exercent déjà, donc chacune peut **livrer** une réponse voisine.
Le tri s'est fait à la main, carte contre carte, et deux formulations ont été changées pour
cette seule raison — l'explication de `distances/bau`, qui comparait la gravité de l'arrêt
et de la circulation sur la bande (c'est la réponse de ses deux applications), et celle de
`panneaux/formes` sur le triangle, qui donnait la distance d'implantation (c'est la carte
illustrée qui la porte).

## Les six fondations chiffrées (2026-09-19)

Les six notions que la section précédente laissait ouvertes sont fondées, et
`notions/sans-fondation` tombe à **0**. Toutes les six portent une ligne `datée` dans
[`sources.md`](sources.md), relevée le 2026-09-19 sur `legifrance.gouv.fr` : L223-2 et
R413-14, R417-9, R413-5, R234-1 et L234-1 pour le code de la route, 131-12 et 131-13 du
code pénal pour la frontière contravention / délit. Le rang 2
(`securite-routiere.gouv.fr`) n'a servi nulle part : sur ces six sujets, il n'aurait rien
ajouté qu'un article consolidé ne dise mieux.

**Le partage qui a décidé de chaque carte.** Une fondation chiffrée n'est pas la carte qui
donne le chiffre : c'est celle qui énonce **l'arithmétique du barème**, là où ses
applications en donnent une valeur. `permis/bareme` dit que le code écrit le retrait en
fraction du capital et le fixe uniformément pour les délits (L223-2 I et II) sans jamais
écrire « six » ; `vitesse/sanctions` dit que le retrait se gradue sur l'**écart** et sur
rien d'autre, sans reprendre un seul palier ; `alcool/sanctions` dit que ce même retrait ne
se gradue **pas** avec le taux ; `stationnement/gradation` dit lequel des quatre degrés
touche au permis, sans reprendre ni les 35 € ni les 135 € ni les sept jours ;
`vitesse/probatoire` dit à qui et pendant combien de temps le régime s'applique, les trois
plafonds appartenant à ses applications ; `permis/qualification` dit ce qui sépare
l'amende de la prison. **Dans les six cas, la valeur que la carte n'écrit pas est la bonne
réponse d'une application existante** — c'est le critère qui a tranché, et chaque ligne de
registre nomme les cartes concernées.

**Cinq explications de cartes anciennes ont dû être coupées.** Écrire la règle rend
livrante l'explication qui la disait en passant, et le sens de la fuite est celui que
`relire.py` ne regarde pas : l'ancienne carte livre la **neuve**. Les cinq coupes sont
faites du côté qui ne porte pas la réponse de la carte coupée, et elles sont détaillées
dans le rapport de la tâche 8b-2. Deux d'entre elles referment en passant une fuite
**antérieure** entre deux cartes anciennes.

## La fondation de couleur (2026-09-19)

`panneaux/couleurs` était nommée au §1 de la spec et listée au §6.2 parmi les fondations à
écrire ; elle n'a jamais été écrite, et **aucun compteur ne pouvait le dire** :
`notions/sans-fondation` compare les notions **portées par une carte** à celles qui ont une
fondation, donc une notion absente du JSON lui est invisible par construction. C'est
l'angle mort symétrique de celui du domaine pilote — là, le compteur ne voyait pas *quelle*
classe était énoncée ; ici, il ne voit pas la famille qui n'a aucune carte du tout. La
sortie qui l'aurait attrapé n'existe pas : il faudrait comparer le registre au texte d'une
spec.

**La carte ne peut pas énoncer les trois couleurs, et c'est la contrainte qui l'a
dessinée.** Les six fondations de `panneaux/formes` possèdent déjà la grille
couleur × silhouette : le bord rouge y vaut interdiction, le fond bleu obligation, et ces
deux affirmations *sont* leur bonne réponse. Une fondation de couleur qui les redirait
livrerait deux cartes d'un coup — exactement la faute que cette branche a livrée deux fois
avant de la refermer. Reste l'axe que la grille ne touche pas : le **jaune**, qui ne dit
rien de la nature du message et tout de sa durée. C'est le seul endroit où la couleur se lit
vraiment indépendamment de la forme, puisqu'un triangle jaune reste un triangle. La carte
dit donc cela, et rien d'autre ; son explication nomme l'exception (le losange, permanent)
sans dire ce qu'elle signifie, et se tait sur la primauté du temporaire, qui appartient à
`signalisation/hierarchie`.

**La notion vit avec sa seule fondation, et c'est le choix le mieux fondé.** Une seule carte
du lot se décide vraiment sur une couleur — `07ef459de55adcb501694169428ffd72`, le disque à
liseré rouge portant 70, dont les quatre options ne se départagent que par l'anneau. La
déplacer ici lui donnerait une fondation qui ne l'enseigne pas (le jaune n'explique pas le
rouge), alors que `panneaux/formes` la fonde réellement par sa carte du rond à bord rouge.
Elle reste donc où elle est, et `panneaux/couleurs` compte une carte : au seuil
`min(masteryStreak, cartes)`, elle s'acquiert en une réponse.
