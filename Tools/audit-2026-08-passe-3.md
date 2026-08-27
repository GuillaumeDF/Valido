## Permis & sanctions

19 cartes, 19 `datée`, 0 illustrée(s).

### Écarts de justesse trouvés

| id | écart | ce que disait la carte | ce que dit l'article | correction |
|---|---|---|---|---|
| `f405372595dbaf85bf875adaf5ac20a4` | explication au-delà de l'article | « c'est le tribunal, saisi ensuite, qui peut aller jusqu'à cinq ans » | L224-2 ne couvre que la suspension administrative préfectorale (six mois, un an dans les cas graves, doublé pour un professionnel) ; relu mot pour mot par WebFetch, il « ne mentionne aucune suspension judiciaire ultérieure » | clause chiffrée retirée de l'explication, remplacée par un renvoi non chiffré (« La décision définitive, elle, revient au tribunal ») |
| `37fe1af42b8d81ed800ecde73e28760a` | explication au-delà de l'article (registre, pas la carte) | l'`affirmation` de `sources.md` citait le III de R223-1 tronqué : « … ne peut être affecté d'un nombre de points supérieur à six » | le III se poursuit par « Ce nombre est augmenté de la majoration résultant de l'application du II du présent article » (relevé mot pour mot par WebFetch) : le « six » est un socle, pas un plafond qui figerait le probatoire | carte inchangée (elle ne s'appuyait pas sur la partie tronquée) ; ligne de `sources.md` complétée avec la citation entière, pour ne pas laisser un futur relecteur la lire comme contredisant `37fe1af42b8d81b6a9…` (progression 6 → 9 → 12 en conduite accompagnée) |

Une source a été rouverte sans donner lieu à correction : `2d45cedf9b3d349027d751f7aa672d6a`
(conduire sans avoir jamais obtenu le permis) affirme dans son explication une interdiction de
conduire « jusqu'à cinq ans » et une confiscation du véhicule, deux clauses que l'`affirmation`
de `sources.md` ne citait pas mot pour mot. Relu sur Legifrance (L221-2 II, WebFetch), les deux
sont bien des peines complémentaires réelles de cet article — carte et registre laissés tels
quels.

### Doutes signalés, non corrigés

Aucun doute laissé ouvert. Les 19 lignes `datée` du domaine ont été relevées le 2026-08-24 (deux
d'entre elles rerelevées le 2026-08-27, ci-dessus), et sur les dix-sept cartes restantes la
carte ne dit rien de plus que ce que porte sa ligne de registre.

### Pédagogie

- explications sous 120 caractères : 1 à l'entrée, 0 à la sortie. La carte concernée,
  `37fe1af42b8d81b6a955d17c158afb3c` (« Sans aucune infraction, un permis probatoire en
  conduite accompagnée atteint 12 points en : »), tenait en 64 caractères
  (« En AAC : 6 → 9 → 12 en deux ans. Sans AAC : +2/an sur trois ans. ») — un rappel, pas une
  explication. Réécrite pour porter les trois temps : la règle (trois points par an en
  conduite accompagnée, deux sans elle), sa raison (les kilomètres déjà roulés encadré, avant
  l'examen), sa limite (le contraste chiffré avec la progression sans AAC, et le raccordement à
  la période probatoire elle-même plus courte).
- cartes dont le budget de 220 a limité l'explication : aucune — le domaine ne porte aucune
  question illustrée, le budget ne s'y applique donc pas.
- énoncés reformulés parce qu'ils présupposaient la règle : aucun — les 19 énoncés se
  comprenaient déjà sans connaître la réponse ; seuls des champs `explanation` ont été touchés.
- `37fe1af42b8d8158b3dbf9883bf83560` (stage de sensibilisation) était le cas `code` du domaine
  compté dans les dix `expl/paraphrase-litterale` de la ligne de base : son explication
  contenait littéralement « 4 points », la bonne option. Réécrite pour épeler « quatre points »
  et ajouter la raison (le stage ne remet pas le compteur à zéro, d'où le plafond annuel) et une
  limite plus précise (le seuil de trois points perdus qui rend le stage obligatoire s'entend
  « lors d'une même infraction », tel que le porte `sources.md`). `audit.py` confirme la sortie
  du domaine de cette catégorie (18 → 17 sur l'ensemble de la banque, dont neuf `code`
  restants).
- `0be9d147f1eba292ca2556f4dd19e51a` (conduire malgré une suspension notifiée) expliquait la
  moitié de capital retirée et l'annulation possible sans jamais donner la peine de base
  (deux ans d'emprisonnement, 4 500 € d'amende) que porte pourtant la bonne option : ajoutée,
  avec un vocabulaire qui ne reprend pas littéralement l'option (« deux ans d'emprisonnement… »
  contre « 2 ans de prison… » de l'option), pour ne pas retomber dans le défaut symétrique.

### Mouvements d'`audit.py`

| sortie | avant | après |
|---|---|---|
| `lettre/reference` | 1 | 1 |
| `forme/markdown` | 1 | 1 |
| `forme/seule-ponctuee` | 14 | 14 |
| `longueur/plus-longue` | 97 | 97 |
| `expl/paraphrase-litterale` | 18 | 17 |
| `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10`, `forme/backtick-isole` | vides | vides |
