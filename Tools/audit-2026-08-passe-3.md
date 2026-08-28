## Permis & sanctions

19 cartes, 19 `datée`, 0 illustrée(s).

### Écarts de justesse trouvés

| id | écart | ce que disait la carte | ce que dit l'article | correction |
|---|---|---|---|---|
| `f405372595dbaf85bf875adaf5ac20a4` | explication au-delà de l'article | « c'est le tribunal, saisi ensuite, qui peut aller jusqu'à cinq ans » | L224-2 ne couvre que la suspension administrative préfectorale (six mois, un an dans les cas graves, doublé pour un professionnel) ; relu intégralement par WebFetch, aucune suite judiciaire n'y figure | clause chiffrée retirée de l'explication, remplacée par un renvoi non chiffré (« La décision définitive, elle, revient au tribunal ») |

Une seule ligne : le tableau ci-dessus ne recense que les écarts carte↔affirmation au sens des
trois écarts de la spec (valeur périmée, règle trop large, explication au-delà de l'article).
Deux constats voisins n'en font pas partie et sont racontés en prose plutôt que forcés dans le
tableau :

- **`37fe1af42b8d81ed800ecde73e28760a`** — l'écart n'était pas entre la carte et l'article, mais
  **dans le registre lui-même** : la ligne de `sources.md` citait le III de R223-1 tronqué
  (« … ne peut être affecté d'un nombre de points supérieur à six », sans la phrase suivante).
  Ce n'est ni une valeur périmée, ni une règle trop large, ni une explication au-delà de
  l'article — la carte, elle, ne s'appuyait pas sur la partie tronquée. La ligne a été
  complétée avec la citation entière (vérifiée mot pour mot par un second WebFetch en fix
  round 1 : exacte, ponctuation incluse, « Version en vigueur depuis le 01/01/2019 »), pour ne
  pas laisser un futur relecteur la lire comme contredisant `37fe1af42b8d81b6a955d17c158afb3c`.
- **`2d45cedf9b3d349027d751f7aa672d6a`** (conduire sans avoir jamais obtenu le permis) — une
  source a été rouverte en première relecture parce que l'explication affirmait une interdiction
  de conduire « jusqu'à cinq ans » et une confiscation du véhicule, deux clauses absentes de
  l'`affirmation`. Le WebFetch sur L221-2 II confirmait les deux comme peines complémentaires
  réelles, mais la ligne de `sources.md:340` n'avait pas été mise à jour en conséquence — défaut
  relevé en fix round 1 et corrigé : les deux citations exactes (« L'interdiction de conduire
  […] pour une durée de cinq ans au plus » et « La confiscation du véhicule […] ») sont
  maintenant dans l'affirmation, `relevé le` porté à la date de cette lecture.

### Doutes signalés, non corrigés

Aucun doute laissé ouvert. Les 19 lignes `datée` du domaine ont été relevées le 2026-08-24 ; six
d'entre elles portent désormais `relevé le` 2026-08-27 : `f405372595dbaf85bf875adaf5ac20a4`,
`37fe1af42b8d81ed800ecde73e28760a`, `2d45cedf9b3d349027d751f7aa672d6a`,
`37fe1af42b8d81b6a955d17c158afb3c`, `37fe1af42b8d81b7acdacd2079297f09` et
`37fe1af42b8d8158b3dbf9883bf83560`. Sur les treize cartes restantes, la carte ne dit rien de plus
que ce que porte sa ligne de registre.

### Pédagogie

- explications sous 120 caractères : 1 à l'entrée, 0 à la sortie.
- cartes dont le budget de 220 a limité l'explication : aucune — le domaine ne porte aucune
  question illustrée, le budget ne s'y applique donc pas.
- énoncés reformulés parce qu'ils présupposaient la règle : 1 —
  `aa44507977673661e72b2c2ba6a6d885` (préfet, délai rétention→suspension). L'énoncé se lisait
  « pour transformer une rétention du permis en suspension », ce qui suppose connue la
  distinction rétention/suspension avant même de lire les options — la distinction n'était
  définie que dans l'explication, en aval, alors que le critère 1 porte sur l'énoncé seul.
  Reformulé : « Après avoir retenu sur-le-champ le permis d'un conducteur, le préfet dispose,
  pour le suspendre ou le rendre, d'un délai de : » — la rétention devient l'action déjà faite
  (« retenu sur-le-champ »), la suspension le choix à venir (« le suspendre ou le rendre »),
  répondable sans glossaire préalable.
- `37fe1af42b8d81b6a955d17c158afb3c` (conduite accompagnée, 12 points en 2 ans) — la carte COURTE
  du domaine (64 caractères à l'entrée), réécrite deux fois. Une première fois pour porter les
  trois temps (règle : trois points par an en AAC contre deux sans elle ; raison : les
  kilomètres déjà roulés encadré, avant l'examen). Une deuxième fois parce que ce qui tenait
  lieu de limite n'en était pas une : « 6 → 8 → 10 → 12 sans AAC » est un contraste, pas « la
  condition qui la fait cesser » (critère 3). La vraie limite — la majoration n'est acquise que
  si aucune infraction n'a fait perdre de points depuis le début du probatoire, un seul retrait
  suffisant à la geler — est maintenant dans l'explication, sourcée mot pour mot dans
  `sources.md:345` (« si aucune infraction ayant donné lieu à retrait de points n'a été commise
  depuis le début de la période probatoire », R223-1 II, relu intégralement par WebFetch). Le
  « la période probatoire elle-même se raccourcit d'autant », vague, est devenu « le délai
  probatoire lui-même passe de trois ans à deux ».
- `37fe1af42b8d81b7acdacd2079297f09` (ceinture) — ne portait ni raison (rien sur ce que la
  ceinture empêche physiquement) ni limite (les dispenses de R412-1 II), et son seul « pourquoi »
  était un renvoi à la carte téléphone (`…8132a2`), qui renvoie elle-même à la ceinture : les
  deux cartes s'expliquaient l'une par l'autre sans rien enseigner. Réécrite avec une raison
  autonome (« heurte le pare-brise ou le tableau de bord au moindre choc, ou est éjectée du
  véhicule ») et une limite sourcée (quatre des six dispenses de R412-1 II, relevées mot pour
  mot par WebFetch et ajoutées à `sources.md:346` : certificat médical, taxi en service,
  livraison porte à porte, véhicule prioritaire en intervention).
- `37fe1af42b8d81ed800ecde73e28760a` (12 points, plafond du permis classique) — ne portait que
  la règle et une conséquence sur le stage ; ni raison (pourquoi 12) ni limite (le probatoire ne
  part pas de 12). Réécrite : la raison tient au probatoire lui-même (le plafond est le capital
  d'un conducteur qui a prouvé, sur toute la période, qu'il ne perdait pas de points), la limite
  aux paliers annuels (six, huit, dix, douze) qui expliquent au passage pourquoi 6, 8 et 10 sont
  des distracteurs plausibles — de vraies valeurs, seulement intermédiaires.
- `37fe1af42b8d8158b3dbf9883bf83560` (stage de sensibilisation) — cas `code` du domaine dans les
  dix `expl/paraphrase-litterale` de la ligne de base (l'explication contenait littéralement
  « 4 points »). Réécrite en épelant « quatre points ». La condition d'obligation, « perdu 3
  points ou plus », est précisée « lors d'une même infraction » — une inférence tirée du
  singulier de `sources.md` (« un retrait de points ») que le rapport de la première relecture
  avait laissée déductible plutôt que de l'écrire ; corrigé en écrivant l'inférence dans
  l'affirmation elle-même (`sources.md:343`) plutôt que de la laisser reposer sur un singulier.
- `0be9d147f1eba292ca2556f4dd19e51a` (conduire malgré une suspension notifiée) — ne donnait
  jamais la peine de base (deux ans, 4 500 €) que porte la bonne option. Ajoutée, en évitant la
  reprise littérale de l'option (« deux ans d'emprisonnement… » contre « 2 ans de prison… »).
- `f405372595dbaf85bf875adaf5ac20a4` (suspension administrative) — voir Écarts de justesse.
- `37fe1af42b8d81d29ceac642002e46d1` (récupération d'1 point après 6 mois) — son explication
  recouvrait, mot pour mot, la réponse de `2b6972fab03433e709d73ccc5a949ac9` (« deux ans, ou
  trois si une contravention de 4e ou 5e classe ou un délit y figure » ⊃ « 2 ans, ou 3 ans si le
  dossier compte un délit »), détecté par `relire.py --fuites` en step 7 de la première relecture
  et laissé de côté à tort. Les chiffres ont été retirés (« les délais s'allongent nettement »),
  remplacés par un renvoi non chiffré vers la carte qui les enseigne. `--fuites` confirme
  0 recouvrement sur le domaine après correction (2 avant, tous deux préexistants à cette
  passe).
- `2d45cedf9b3d349027d751f7aa672d6a` (conduire sans avoir jamais obtenu le permis) — même défaut
  que `0be9d147…` ci-dessus, repéré en fix round 2 en construisant la preuve par carte : elle
  détaillait l'amende forfaitaire et les peines complémentaires sans jamais donner la peine de
  base (un an de prison, 15 000 €) que porte la bonne option — une carte qui parle de tout sauf
  de la règle qu'elle est censée enseigner. Ajoutée, en évitant la reprise littérale de l'option
  (« puni d'un an d'emprisonnement et de 15 000 euros d'amende » contre « puni d'un an de prison
  et 15 000 € d'amende » de l'option) ; `sources.md:340` portait déjà cette peine de base depuis
  le tout premier passage, aucune nouvelle lecture n'a donc été nécessaire pour la sourcer.

**Preuve par carte, pour les dix cartes non modifiées** — la liste que la relecture aurait dû
produire dès le premier passage plutôt que de se limiter aux cartes portant un drapeau.
`2d45cedf9b3d349027d751f7aa672d6a` en avait été omise à tort en fix round 1 : elle porte une
évidence de *justesse* dans la section ci-dessus, mais aucune évidence *pédagogique*. Relue ici
contre les quatre critères, elle ne l'était pas — la règle manquait, voir Pédagogie ci-dessus —
et a été réécrite plutôt que forcée dans un « conforme » de complaisance. Elle sort donc
légitimement de cette liste des cartes non modifiées, qui reste à dix (et non onze) :

| id | rôle | pourquoi jugée conforme |
|---|---|---|
| `2b6972fab03433e709d73ccc5a949ac9` | réattribution des 12 points sans stage | règle (2 ou 3 ans) + raison explicite (« dépend de la gravité de ce qui figure au dossier ») + limite explicite (« une nouvelle infraction fait repartir le compteur ») |
| `302262003495b5750d28f00caeae3b6b` | rodéo motorisé | règle (2 ans/30 000 €) + raison explicite (vise « la répétition intentionnelle de manœuvres dangereuses », pas une faute isolée) + limite/aggravation chiffrée (« commis en réunion, les faits montent à trois ans ») |
| `37fe1af42b8d8132a22dde248e277c2b` | téléphone tenu en main | règle (3 points) + raison explicite (« pas la conversation mais la main occupée et le regard qui quitte la route ») ; limite **implicite**, portée par l'énoncé (« au volant » borne la règle à la conduite) plutôt que par une clause dédiée — jugée borderline mais retenue telle quelle : c'est l'exemple ✅ cité au §1 de `Tools/questions.md`, et y toucher sans mandat clair aurait désynchronisé la doc de l'exemple qu'elle cite |
| `37fe1af42b8d8174b45bd538ca3a9483` | capital initial (6 points) | règle (6 initial) + raison explicite (« pour que la moindre série d'infractions ait une conséquence visible ») ; limite **faible** — la trajectoire vers 12 est décrite sans condition d'arrêt explicite dans cette carte-ci. Jugée borderline, laissée telle quelle : la condition réelle (majoration soumise à l'absence d'infraction depuis le début du probatoire) est désormais portée par la carte voisine sur le même mécanisme (`…81b6a9`) et sa ligne de registre `sources.md:345` |
| `37fe1af42b8d81c593b3e0a4cb5bb76d` | durée du probatoire | règle (3 ans, 2 si AAC) + raison explicite (kilomètres déjà roulés encadré) + limite/extension chiffrée (formation complémentaire : encore un an, ou six mois) |
| `37fe1af42b8d81d09328df58d56a4dc6` | disque « A » | règle (à l'arrière, pendant le probatoire) + raison explicite (prévenir les autres usagers d'une vitesse abaissée) + limite/conséquence (l'oubli est une contravention de 2e classe) |
| `37fe1af42b8d81ecb163c6b59334b160` | invalidation à solde nul | règle + raison (le délai court de la remise, pas de la notification) + limite explicite (récidive dans les 5 ans → 1 an ; examen médical obligatoire dans tous les cas) |
| `3e99bcc374a5538e9af609b3038f08ad` | homicide routier | règle (7 ans/100 000 €) + raison explicite (qualification nouvelle, pas nouvelle peine) + limite explicite (seuil à 2 circonstances → 10 ans/150 000 €) |
| `666bb472f111a4f4634a0e30abdf180a` | cumul simultané (8 points) | règle + raison explicite (deux tiers du capital, ne peut invalider un permis intact) + limite explicite (« ne joue que pour des faits simultanés, pas pour des infractions commises à des dates différentes ») |
| `bc949f3e3918b2e407b638892b47b540` | permis étranger | règle (interdiction 1 an) + raison explicite (la France ne peut pas annuler un titre qu'elle n'a pas délivré) + limite/résolution temporelle (nouveau capital affecté au terme de l'année) |

Deux cartes de ce lot (téléphone, capital initial) sont notées borderline plutôt que pleinement
conformes : elles ont une règle et une raison solides, mais leur limite est implicite ou faible.
Laissées telles quelles pour les raisons données ligne par ligne — pas par défaut d'examen.

### Mouvements d'`audit.py`

| sortie | avant | après |
|---|---|---|
| `lettre/reference` | 1 | 1 |
| `forme/markdown` | 1 | 1 |
| `forme/seule-ponctuee` | 14 | 14 |
| `longueur/plus-longue` | 97 | 97 |
| `expl/paraphrase-litterale` | 18 | 17 |
| `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10`, `forme/backtick-isole` | vides | vides |

`--fuites "Permis & sanctions"` : 2 recouvrements avant correction (tous deux préexistants à
cette passe, non introduits par elle), 0 après — voir Pédagogie ci-dessus pour le détail du
recouvrement corrigé (`…81d29c` → `2b6972fa…`) ; l'autre (`…81b7ac` → une carte de
« Distances & freinage », sur du vocabulaire commun) a disparu comme effet de bord de la
réécriture de la ceinture, sans avoir été le motif de cette réécriture.

## Vitesse

22 cartes, 19 `datée`, 4 illustrée(s).

### Écarts de justesse trouvés

| id | écart | ce que disait la carte | ce que dit l'article | correction |
|---|---|---|---|---|
| `fed604fe7c4b8b3b96adc066a7902138` | règle trop large | « Sans séparateur, on retombe à 80 km/h même sur une route large et rectiligne » | l'affirmation de cette ligne ne porte que sur le régime chaussées-séparées (110 km/h, 100 sous la pluie) ; une carte voisine du même domaine (`f7370daabea929065f6b2586ca3eea91`) établit que, sans terre-plein central mais avec deux voies affectées au même sens, la limite est 90 km/h et non 80 — confirmée mot pour mot par R413-2 I 3° (voir ci-dessous) | la clause « on retombe à 80 km/h » est retirée, remplacée par le renvoi au vrai critère : « Sans lui, la vitesse dépend d'un autre critère — le nombre de voies affectées à votre sens » |

Une seule ligne au sens strict des trois écarts de la spec. Plusieurs constats voisins n'y
entrent pas parce que, dans chacun, la carte disait déjà vrai — c'est le registre qui ne le
portait pas encore, en partie ou en totalité ; racontés en prose plutôt que forcés dans le
tableau. **Revu en fix round 1** après une revue qui a montré que cette liste était
incomplète : deux cartes de plus disaient plus que leur ligne (le barème complet des points,
la table complète des réductions pluie), et une ligne « corrigée » restait en réalité une
synthèse non rattachée à un article en vigueur — voir « Doutes signalés » ci-dessous.

- **`37fe1af42b8d815ba42acef16b3119a8`** (voie de gauche, minimum 80 km/h) — l'explication
  conditionnait déjà l'obligation à « la visibilité suffisante », en plus de la circulation
  fluide que portait seule la ligne de registre. Rouvert : WebFetch sur R413-19
  (`LEGIARTI000006842210`, version en vigueur depuis le 01/06/2001), qui confirme mot pour mot
  la double condition : « En particulier sur autoroute, lorsque la circulation est fluide et
  que les conditions atmosphériques permettent une visibilité et une adhérence suffisantes,
  les conducteurs utilisant la voie la plus à gauche ne peuvent circuler à une vitesse
  inférieure à 80 km/h. » La ligne est complétée avec la citation exacte ; la carte n'a pas
  bougé.
- **`f7370daabea929065f6b2586ca3eea91`** (deux voies même sens sans terre-plein, 90 km/h) —
  l'explication affirmait déjà une réduction sous la pluie à 80 km/h. **Corrigé en fix
  round 1** : la première version de cette ligne couvrait le fait par analogie avec une autre
  catégorie sur une page de synthèse (service-public F19460) plutôt que par une citation
  d'article ; remplacée par R413-2 I 3° et II 3°, cités mot pour mot (WebFetch sur
  `LEGIARTI000042240048`, version en vigueur depuis le 16/08/2020) : « 80 km/h sur les autres
  routes. Toutefois, sur les sections de ces routes comportant au moins deux voies affectées à
  un même sens de circulation, la vitesse maximale est relevée à 90 km/h sur ces seules
  voies. » et « 80 km/h sur les sections des autres routes mentionnées au 3° du I » pour la
  réduction sous la pluie — la section revient à son régime de base, relevée ou non par temps
  sec. La carte n'a pas bougé.
- **`04182c9bbdeb305e21532f9c6913a2a2`** (excès 40 à moins de 50 km/h, 4 points) —
  l'explication affirmait qu'« à partir de 30 km/h de dépassement, le juge peut ajouter une
  suspension du permis et un stage obligatoire ». Rouvert par prudence, et bien nommé : trois
  lectures successives (une recherche puis deux WebFetch sur de mauvais articles) ont d'abord
  donné des seuils contradictoires — 30 km/h, puis un article concernant 50 km/h et abrogé le
  29 décembre 2025 — avant qu'une citation intégrale et verbatim de l'article réellement en
  vigueur, R413-14 (`LEGIARTI000048533039`, version en vigueur depuis le 01/01/2024), ne
  tranche : son II fixe bien le seuil à « 30 km/h ou plus » pour la suspension et le stage.
  **Complété en fix round 1** : une première version de cette ligne ne citait que le palier
  III 1° (40-49 km/h) alors que l'explication détaille les quatre paliers pour montrer la
  progression du risque ; la ligne porte maintenant les quatre paliers, cités mot pour mot,
  puisqu'ils avaient déjà été lus dans le même WebFetch. Le seuil des 50 km/h où l'infraction
  devient un délit, que l'explication garde comme limite, est renvoyé aux lignes des deux
  cartes « grand excès » plutôt que réaffirmé ici, R413-14 s'arrêtant lui-même à « moins de
  50 km/h ».
- **`37fe1af42b8d816b8bf5d51c4f78466c`** (excès 30 km/h, 3 points) — **découvert en fix
  round 1** : la carte détaillait tout le barème (« aucun point sous 5 km/h, 1 de 5 à 20, 2 de
  20 à 30, 3 de 30 à 40, 4 de 40 à 50, 6 au-delà ») et le seuil du délit, alors que la ligne ne
  portait qu'une seule valeur (3 points pour 30 km/h). Deux corrections combinées : la ligne
  est complétée avec les quatre paliers de R413-14 III (même citation que ci-dessus, aucune
  nouvelle lecture nécessaire) ; l'explication, elle, est resserrée sur les quatre paliers que
  R413-14 III couvre réellement — « 6 au-delà » et « devient un délit » sont retirés, cette
  frontière n'étant pas le propos d'une carte sur un excès de 30 km/h et relevant, si elle
  devait être affirmée ici, d'un sourçage séparé (voir Doutes).
- **`37fe1af42b8d818da27dc338f75795fe`** (pluie, chaussées séparées, 100 km/h) — **découvert
  en fix round 1** : la carte listait toute la table des réductions pluie (« 130→110,
  110→100, 90→80 »), la ligne ne portant qu'un seul palier. Complétée avec R413-2 II cité
  intégralement (même lecture que pour `f7370daabea929065f6b2586ca3eea91` ci-dessus) : les
  trois alinéas du II couvrent trois des quatre transitions que l'explication récite, la
  quatrième (80 km/h qui reste 80) étant l'absence de réduction plutôt qu'un alinéa propre.
  La carte n'a pas bougé.
- **`37fe1af42b8d81d0bf26d67c5f0ff047`** (pluie, autoroute, 110 km/h) — même défaut, même
  correction : ligne complétée avec R413-2 II. La clause brouillard que l'explication ajoute
  (« tous réseaux à 50 km/h ») est renvoyée à la ligne de `37fe1af42b8d81f9ae87db1419280902`
  plutôt que réaffirmée ici, R413-2 ne traitant que de la pluie. La carte n'a pas bougé.
- **`337bfcb4d034b62de5fe0d77ca0cb0a0`** et **`37fe1af42b8d817a9111e3d52f9e5142`** (grand
  excès, délit) — la première datait le changement du 22 décembre 2025, sa voisine du 29 : lu
  côte à côte à l'étape 2, cela ressemble à la contradiction que la brève demandait de
  chercher. Rouvert : WebFetch sur service-public.gouv.fr A18723, qui donne le décret
  n° 2025-1269, pris le 22 décembre 2025 et entré en vigueur le 29 décembre 2025 — les deux
  dates étaient exactes, l'une pour la signature, l'autre pour l'entrée en vigueur.
  Les deux explications le disent maintenant. La ligne de `37fe1af42b8d817a9111e3d52f9e5142`
  a été retravaillée une seconde fois en fix round 1 pour une raison différente — voir
  « Doutes signalés ».

### Doutes signalés, non corrigés

**Un doute, ajouté en fix round 1 — il ne l'était pas au premier passage, à tort.**

| id | ce qui est douteux | ce qui a été lu | ce qui manque |
|---|---|---|---|
| `37fe1af42b8d817a9111e3d52f9e5142` | les « 6 points » pour un grand excès ≥ 50 km/h reposent sur service-public.gouv.fr F19460, une page de synthèse, jamais recoupés à un article en vigueur | R413-14-1, qui portait ce régime avant le 29/12/2025, est abrogé depuis cette date par le décret n° 2025-1269 lui-même (confirmé par WebFetch) ; R413-14 (relu intégralement le 2026-08-27) s'arrête explicitement à « moins de 50 km/h » (I) et ne couvre donc pas ce cas | l'article — probablement L413-1 ou un nouvel article réglementaire créé par le même décret — qui fixe aujourd'hui le retrait de points pour le régime délictuel n'a pas été identifié ; les deux dates du décret (peines, 300 €/3 mois/3 750 €) restent, elles, sourcées par A18723 et n'ont pas ce défaut |

La ligne de registre distingue maintenant les deux provenances au lieu d'une seule date
couvrant tout : `relevé le` porte 2026-08-23, la date la **moins** récente des deux figures de
la ligne (les 6 points, non revérifiés dans cette passe), pas 2026-08-27 (date à laquelle
seules les deux dates du décret ont été revérifiées) — conformément à la ruling de la revue :
« un `relevé le` déplacé ne couvre pas les chiffres que la nouvelle lecture n'a pas touchés ».

Sur les autres lignes `datée` du domaine, aucun doute supplémentaire trouvé au fix round 1 :
les compléments de registre (barème complet, table pluie complète) ont tous été rattachés à
un article en vigueur, cité mot pour mot.

### Options (critère 2)

Non traité au premier passage — la brève couvre pourtant énoncé, options **et** explication.
Les 22 cartes relues contre les trois premières règles du §1 de `questions.md` (plausible,
réellement faux, confusion courante plutôt que chiffre inventé) et le piège de forme du §2
(non éliminable par pure logique). Quatre correctifs :

- **`37fe1af42b8d81589410cd055e66efc2`** (agglo par défaut) — option D « 45 km/h » n'est la
  vitesse d'aucune catégorie du code de la route : chiffre inventé. Remplacée par « 20 km/h »
  (zone de rencontre, une vraie confusion avec la zone 30 déjà présente en B).
- **`37fe1af42b8d819e9620e4637f95e464`** (probatoire, autoroute) — option C « 120 km/h » même
  défaut. Remplacée par « 90 km/h », une vitesse réelle (hors-agglomération, deux voies même
  sens) qu'un débutant confond plausiblement avec les plafonds de R413-5.
- **`37fe1af42b8d812c957fc3415785f6d6`** (zone de rencontre) — option C « 10 km/h » n'est pas
  une valeur R110-2 nommée (zone 30 = 30, zone de rencontre = 20, aire piétonne = allure du
  pas, sans chiffre codifié). **Laissée telle quelle**, décision assumée plutôt qu'omise :
  10 km/h est un panneau réel (parkings, voies privées), donc pas un pur non-sens, et aucun
  substitut propre n'existe sans inventer à son tour un chiffre pour l'aire piétonne (dont la
  seule référence officielle est qualitative, « allure du pas », jamais un nombre). Corriger
  ici aurait remplacé un défaut mineur par un autre.
- **`07ef459de55adcb501694169428ffd72`** (panneau B14) — option A « une vitesse **conseillée**
  de 70 km/h » était éliminable par pure forme contre l'énoncé « Ce panneau **impose** : »
  (piège de forme du §2, énoncé et option se contredisent lexicalement sans qu'il soit besoin
  de connaître le panneau). Corrigé en neutralisant l'énoncé plutôt qu'en réécrivant l'option :
  « Ce panneau impose : » → « Ce panneau signifie : » (21/70) ; l'option A reste plausible sous
  la nouvelle formulation (un panneau B24 « vitesse conseillée » existe réellement). En
  contrepartie, l'explication a regagné le contraste « plafond, pas un minimum » qu'une
  réécriture précédente avait fait disparaître — voir Pédagogie.

`cac0f9db162887802d4fb15ba97d768f` (zone 30 vs zone de rencontre) — ses trois distracteurs
d'origine (stationnement payant, heure d'application, largeur de chaussée) ne sont pas des
confusions qu'un débutant fait réellement sur *cette* question, qui porte sur la vitesse et la
priorité piétonne : ce sont des attributs plausibles de zones en général, pas des variantes de
la règle testée. Réécrits en un carré sémantique centré sur ce que la question teste
réellement (vitesse **et** priorité, contre les façons de se tromper sur ce qui change) :

- A « La vitesse maximale, ramenée de 30 à 20 km/h »
- B « La priorité laissée aux piétons sur la chaussée »
- C (inchangée, correcte) « La vitesse et la priorité donnée aux piétons »
- D « Le sens de circulation, ni la vitesse ni la priorité »

**Corrigée une seconde fois en fix round 2** : la première réécriture (ci-dessus, D « Rien :
mêmes règles sous deux noms différents ») était éliminable par la forme même de l'énoncé,
« la différence porte sur : », qui présuppose qu'une différence existe — répondre « Rien » à
une question qui présuppose une différence se repère sans rien connaître aux deux zones,
exactement le piège de forme réglé sur `07ef459d…` un peu plus haut et reproduit ici dans le
seul jeu d'options écrit de zéro par cette tâche. D est réécrite en un quatrième axe réel
(le sens de circulation) plutôt qu'en négation de la question, qui ne pose plus ce problème. A
et B, en miroir strict l'une de l'autre au premier passage (« X seule, Y restant identique » /
« Y seule, X restant identique »), sont aussi reformulées pour rompre le parallélisme
mécanique, sans changer ce qu'elles testent. Les quatre options restent comparables en
longueur (correcte 44, la plus longue des distracteurs 52, moyenne des distracteurs 47,7) et
réellement fausses (les deux zones diffèrent bien sur les deux axes à la fois, le sens de
circulation n'étant pas le critère qui les distingue). Cela déplace cette carte de la liste des
cartes non modifiées vers celle des cartes modifiées — voir Pédagogie et le décompte final.

Aucune autre carte du domaine n'a montré de chiffre inventé, de distracteur non éliminable de
force plus faible que ceux listés ci-dessus, ou de doublon avec un autre distracteur récurrent
de la banque (rien qui rappelle « klaxonner » ou « aucune sanction »).

**Un doublon cross-domaine relevé, non corrigé par décision** : l'option correcte de
`337bfcb4d034b62de5fe0d77ca0cb0a0` (« Un délit, jugé au tribunal correctionnel ») est
verbatim l'option correcte d'une carte d'« Alcool & stupéfiants ». `--fuites` n'inspecte que
les explications, pas les options, donc cet outil ne l'aurait jamais vu. Préexistant à cette
passe, transversal à deux domaines : laissé pour la tâche qui possède l'autre carte plutôt que
tranché ici unilatéralement.

### Pédagogie

- explications sous 120 caractères : 4 à l'entrée, 0 à la sortie —
  `37fe1af42b8d81589410cd055e66efc2` (114 → 272), `37fe1af42b8d817994d5f81863c7e6ae`
  (102 → 211), `37fe1af42b8d818da27dc338f75795fe` (74 → 199) et
  `37fe1af42b8d81f9ae87db1419280902` (80 → 167). Les quatre ne portaient que le résultat
  chiffré ; elles portent maintenant une raison et une limite.
- cartes dont le budget de 220 a limité l'explication : `3adc294978b6ac1f640c45e121a0e4f5`
  (218/220, non modifiée) — deux caractères de marge, la raison à ajouter (voir sa ligne dans
  le tableau des cartes non modifiées) n'a nulle part où tenir sans retirer autre chose ;
  **corrigé en fix round 1** dans le libellé de sa ligne d'évidence plutôt que dans la carte,
  voir « Minor D » de fix round 2. `07ef459de55adcb501694169428ffd72` (208/220) a moins souffert
  du budget : douze caractères de marge ont suffi à porter le contraste « plafond, pas un
  minimum » **et** « pas les conseils » dans la même formulation courte. Les deux autres
  illustrées : `37fe1af42b8d815ba42acef16b3119a8` (208/220, non modifiée) et
  `ed0e45e08fb4f47007934da587b5757c` (203/220, **corrigée en fix round 1** — voir ci-dessous).
  Les quatre tiennent aussi l'énoncé (≤ 70, dont le nouveau « Ce panneau signifie : » à 21) et
  chaque option (≤ 50), non touchées à l'exception de l'énoncé de `07ef459d…`.
- **Correction en fix round 1** : `ed0e45e08fb4f47007934da587b5757c` (panneau zone 30) avait
  perdu, au premier passage, la clause qui porte la bonne réponse. Le budget avait été gagné en
  réduisant « même après plusieurs changements de direction » à « même après un virage » — un
  virage est un coude de rue, alors que la bonne option et l'affirmation parlent toutes deux
  de « rues sécantes » : la coupe avait remplacé le détail qui justifie la réponse par un
  détail qui ne la justifie pas. Réécrite pour restaurer « rues sécantes » tout en gardant les
  trois temps : « Le carré rend la prescription zonale, pour ralentir tout un quartier : elle
  vaut dans les rues sécantes jusqu'au panneau qui la termine. Un disque ne vaut que sur son
  axe et se répète à chaque carrefour. » (203/220).
- deux cartes réécrites en fix round 1 pour ajouter la raison qui manquait, sans laquelle le
  critère 3 n'était pas tenu malgré la revendication du premier passage :
  `37fe1af42b8d817a9111e3d52f9e5142` (grand excès, 6 points) gagne « au-delà de 50 km/h
  d'écart, la marge de freinage disparaît presque entièrement » ; `337bfcb4d034b62de5fe0d77ca0cb0a0`
  gagne, en fix round 1, « jugés trop dangereux pour une simple amende ». **Corrigée une seconde
  fois en fix round 2** : cette formulation attribuait une intention au décret (« a jugé »),
  sans qu'aucune source lue ne porte d'exposé des motifs — A18723 donne le dispositif, pas le
  jugement qui l'a motivé. Reformulée sans attribution : « un tel dépassement met des vies bien
  plus directement en jeu », qui garde la raison sans prêter une pensée au texte.
- deux cartes réécrites en fix round 1 pour corriger « chaque tranche de 10 km/h ajoute un
  point » quand la première tranche du barème (5 à 20 km/h) en fait 15 : `04182c9bbdeb305e21532f9c6913a2a2`
  et `37fe1af42b8d816b8bf5d51c4f78466c` disent maintenant « le barème monte par paliers », sans
  affirmer une largeur de tranche uniforme et fausse.
- `37fe1af42b8d81589410cd055e66efc2` (agglo par défaut) — attribution corrigée en fix round 1 :
  « c'est le panneau d'entrée de ville qui l'impose » devient « R413-3 l'impose […] marquée par
  le panneau d'entrée de ville », après lecture verbatim de R413-3 (`LEGIARTI000028436430`,
  version en vigueur depuis le 10/01/2014) qui donne aussi les 70 km/h de l'option C comme une
  vraie exception (« sur les sections de route où les accès des riverains et les traversées des
  piétons sont en nombre limité »), pas un chiffre inventé. **Défaut recréé et corrigé en fix
  round 2** : la carte avait gagné cet article et cette exception en fix round 1, mais la ligne
  de registre était restée « vitesse maximale par défaut en agglomération (50 km/h) », sans
  R413-3 ni la clause des 70 km/h — Important 1 recréé par la correction même qui devait le
  traiter. La ligne porte maintenant la citation intégrale de R413-3, `relevé le` 2026-08-27.
- **Trois cartes du premier passage, absentes à tort du décompte nominatif jusqu'ici** (le
  total de la section ne totalisait que 14 sur 17 avant fix round 2) :
  - `25390f0f30dbb6402091dc226d63db35` (chantier autoroute) — ne portait pas de limite : ajoutée,
    « La prescription cesse au panneau de fin de chantier, qui rend la limite habituelle. »
  - `61eed52d453ac9d8ab59af70dae8eb3e` (probatoire, route à 70 km/h) et
    `87c63a1be4e005f6c846d7798756696f` (probatoire, chaussées séparées à 110 km/h) — ne
    portaient qu'une règle définitionnelle (plafond, pas abattement) sans raison : chacune
    gagne, avec une formulation différente pour ne pas se répéter mot pour mot, « le temps
    d'accumuler de l'expérience » / « le temps que l'expérience vienne », la raison pour
    laquelle le permis probatoire plafonne plus bas plutôt que d'abattre uniformément.
- énoncés reformulés parce qu'ils présupposaient la règle : toujours aucun de ce type ; un
  énoncé a néanmoins été retouché en fix round 1 pour une raison de forme différente (piège de
  forme du §2, voir « Options » ci-dessus) — `07ef459de55adcb501694169428ffd72`, « Ce panneau
  impose : » → « Ce panneau signifie : ».

**Les cinq cartes non modifiées**, lues contre les quatre critères pédagogiques — quatre
pleinement conformes (règle, raison, limite ; aucune ne reformule sa bonne option), une
(`3adc2949…`) conforme sur trois des quatre critères et honnêtement notée comme telle, voir sa
ligne — `cac0f9db…` en est sortie en fix round 1 (options réécrites, voir Options), ce qui
ramène cette liste de six à cinq :

| id | rôle | pourquoi jugée conforme |
|---|---|---|
| `3adc294978b6ac1f640c45e121a0e4f5` | panneau B33, fin de limitation | règle (« Un « fin de » perd le liseré rouge et gagne l'oblique ») + **contenu**, pas une vraie raison (« Ce qui reprend n'est pas la vitesse qu'on veut, mais la limite générale du type de route » explique *ce qui* reprend, pas *pourquoi* un panneau dédié est nécessaire) + limite (« Lever toutes les interdictions d'un coup demande un panneau sans chiffre », qui distingue du panneau B31) — **relabellé honnêtement en fix round 1**, cette carte n'a pas de raison au sens strict du critère 3, et le budget (218/220, 2 caractères de marge) ne permet pas d'en ajouter une sans retirer autre chose |
| `37fe1af42b8d815ba42acef16b3119a8` | voie de gauche, minimum 80 km/h | règle (« L'article R413-19 impose ce minimum sur la voie la plus à gauche ») + raison (« une voiture lente y crée un obstacle et pousse les autres à se rabattre par la droite ») + limite (« quand le trafic est fluide et la visibilité suffisante », condition désormais confirmée mot pour mot par R413-19 dans le registre) |
| `14eb253e5dc55f5633de9263f541bf91` | excès sous 5 km/h, aucun point | règle (« Le décret du 6 décembre 2023 a supprimé le retrait d'un point sous 5 km/h ») + raison (« la marge d'incertitude des appareils ne justifiait pas de toucher au capital ») + limite/nuance (« L'amende, elle, reste due — 68 € en général, 135 € là où la limite est de 50 km/h ou moins », qui distingue points et amende) |
| `37fe1af42b8d812c957fc3415785f6d6` | zone de rencontre, 20 km/h | règle (20 km/h) + raison (« le piéton y est prioritaire sur tous les véhicules sauf les transports guidés et peut marcher sur toute la largeur de la chaussée ») + limite (« la vitesse doit permettre de s'arrêter pour lui, pas de le contourner », qui borne ce que « prioritaire » signifie concrètement) — option C laissée « 10 km/h » par décision assumée, voir « Options » |
| `f7370daabea929065f6b2586ca3eea91` | deux voies même sens, 90 km/h | règle + raison (« C'est le nombre de voies affectées à votre sens, et non la largeur de la chaussée, qui fait passer la limite de 80 à 90 », qui nomme et écarte la confusion courante) + limite (« sous la pluie, ces deux valeurs retombent respectivement à 80 et à 100 », désormais confirmée mot pour mot par R413-2 dans le registre plutôt que par analogie) |

Dix-sept cartes modifiées (Écarts + Options + Pédagogie ci-dessus, `cac0f9db…` comptée une
seule fois) + cinq non modifiées = 22, sans reste.

### Mouvements d'`audit.py`

| sortie | avant | après |
|---|---|---|
| `lettre/reference` | 1 | 1 |
| `forme/markdown` | 1 | 1 |
| `forme/seule-ponctuee` | 14 | 14 |
| `longueur/plus-longue` | 97 | 97 |
| `expl/paraphrase-litterale` | 17 | 17 |
| `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10`, `forme/backtick-isole` | vides | vides |

**Cinq faux positifs structurels dans `expl/paraphrase-litterale`, non corrigés par choix,
documentés ici pour que les tâches suivantes n'aient pas à retrancher.** Le domaine en porte
cinq des neuf que compte la banque `code` (les dix-sept comptent aussi les cas `swift`) : `37fe1af42b8d812c957fc3415785f6d6` (« 20 km/h »
⊂ expl), `37fe1af42b8d81589410cd055e66efc2` (« 50 km/h »), `37fe1af42b8d817994d5f81863c7e6ae`
(« 80 km/h »), `37fe1af42b8d818da27dc338f75795fe` (« 100 km/h ») et
`37fe1af42b8d819e9620e4637f95e464` (« 110 km/h »). Les quatre dernières sont précisément les
cartes réécrites en step 5 (trois passaient de 74–114 caractères à 199–272) : elles restent
détectées après réécriture parce que la bonne réponse **est** un nombre, et un nombre qui
réapparaît dans une explication qui en donne la raison et la limite n'est pas la paraphrase que
le détecteur cherche à repérer. `Tools/questions.md` §1 le dit explicitement : « Une réponse
chiffrée reprise dans l'explication est normale — le défaut est l'explication qui n'ajoute
rien. » Ce n'est le cas d'aucune des cinq — chacune ajoute une raison et une limite, détaillées
en Pédagogie ci-dessus. `expl/paraphrase-litterale` reste donc à 17 avant et après cette tâche :
la ligne de base ne baisse pas ici, faute de cas `code` à corriger dans ce domaine (les dix cas
`code` originaux visés par la spec sont ailleurs, cf. `docs/superpowers/specs/2026-08-27-relecture-code-pedagogie-design.md`).

`--fuites "Vitesse"` : 4 recouvrements avant toute édition de ce domaine — deux préexistants
dès avant cette passe (`337bfcb4d034b62de5` → `2d45cedf9b3d` [Permis & sanctions] et
`37fe1af42b8d817a91` → une carte d'« Alcool & stupéfiants », plus la même paire en interne au
domaine et vers `2d45cedf9b3d` une seconde fois), tous quatre de même origine : les deux
cartes « grand excès » du domaine partagent nécessairement le vocabulaire « délit »,
« prison », « amende » avec d'autres cartes de sanction de la banque. La réécriture
pédagogique de l'étape 5 a d'abord aggravé ce recouvrement plutôt que de le résorber — en
ajoutant explicitement « jugé au tribunal correctionnel » (qui est mot pour mot la bonne
réponse d'une carte d'« Alcool & stupéfiants ») aux deux explications, un contrôle
intermédiaire est resté à 4 recouvrements. Corrigé en reformulant sans perdre l'information :
« jugé au tribunal correctionnel » retiré (remplacé par une clause qui ne cite aucune des
réponses d'autres cartes), et « prison » remplacé par « emprisonnement » dans l'explication du
retrait de points — le fait reste dit, le mot qui recoupait ne l'est plus. 0 recouvrement
après correction, reconfirmé après fix round 1 (les explications retouchées en fix round 1 ne
réintroduisent ni « tribunal correctionnel » ni « prison »).

## Alcool & stupéfiants

18 cartes, 17 `datée`, 0 illustrée(s).

### Écarts de justesse trouvés

Aucun écart de justesse au sens strict des trois catégories de la spec (valeur périmée, règle
trop large, explication au-delà de l'article) : les 17 lignes `datée` du domaine ont toutes été
relevées le 2026-08-24, dans un mouvement qui a déjà absorbé la loi n° 2026-798 du 18 août
2026 — les peines d'alcoolémie délictuelle, de stupéfiants et de refus de dépistage sont
relevées à 3 ans / 9 000 € sur les cinq lignes concernées (`37fe1af42b8d817e8e`, `37fe1af42b8d81b381`,
`5720fa6a…`, `749552ac…`, `92f3fe40…`), avec l'ancien couple 2 ans / 4 500 € recyclé en
distracteur sur quatre d'entre elles — et le déplacement du délit de « conduite en état
d'ivresse manifeste » de L234-1 II vers L237-1 1° (`749552ac…`). Ce sont les deux cas
cautionnaires que la préface de `sources.md` cite nommément pour ce domaine ; les deux étaient
déjà réglés en ligne avant l'ouverture de cette tâche. Relu carte par carte contre sa ligne
(voir le détail des 18 cartes en Pédagogie et en Options ci-dessous) : aucune carte n'affirme
une valeur que sa ligne contredit, aucune ne porte un absolu (les sept drapeaux `ABS` du lot)
que l'affirmation ne couvre pas, et aucune explication n'ajoute une conséquence, une sanction
ou une exception absente de sa ligne. Rien n'a donc été rouvert au sens de l'étape 3 : la seule
condition d'ouverture — une carte affirme quelque chose que sa ligne ne couvre pas et qui n'est
pas manifestement faux — ne s'est présentée sur aucune des 18.

### Doutes signalés, non corrigés

Aucun doute nouveau. Le seul flottement préexistant du domaine — `bda97dae02fa9e085f`
(majoration d'assurance) s'appuyant sur service-public F2630 sans que l'annexe à l'article
A121-1 du code des assurances ait été consultée — est déjà consigné sur la ligne de registre
elle-même (rang 1 assumé, annexe non lue) ; il n'a pas été rouvert ici, la carte ne prétendant
rien que sa ligne ne couvre.

### Les deux dettes du domaine

**Doublon cross-domaine.** `37fe1af42b8d817e8e2feffa6987ba00` (« À partir de 0,8 g/L de sang,
conduire est : ») portait, à la virgule près, la même option correcte que
`337bfcb4d034b62de5fe0d77ca0cb0a0` de « Vitesse » : « Un délit jugé au tribunal correctionnel »
contre « Un délit, jugé au tribunal correctionnel ». Tranché en réaimant l'option de cette carte
plutôt qu'en expliquant l'identité comme inévitable — mais en deux temps, le premier passage
n'ayant réglé que le doublon littéral. Chronologie complète des sept formulations essayées, sur
les deux tours de cette tâche :

1. « Un délit jugé au tribunal correctionnel » (texte de départ) — écarté : doublon littéral
   avec `337bfcb4…`.
2. « Un délit, avec un retrait de six points » — écarté : recoupait mot pour mot (« délit »,
   « retrait », « points ») les explications de deux autres cartes du même domaine
   (`37fe1af42b8d817e9b` et `749552ac121e0cd77b`, qui discutent toutes deux ce même retrait) ;
   `--fuites` sur ce domaine passait de 0 à 2 recouvrements avec ce brouillon.
3. « Un délit, hors de l'amende forfaitaire » — écarté : ne recoupait plus rien dans le domaine
   mais recoupait deux cartes d'autres domaines (`337bfcb4d034b62de5` de « Vitesse » et
   `2d45cedf9b3d` de « Permis & sanctions »), « amende forfaitaire » étant vocabulaire courant à
   chaque fois qu'une carte de la banque oppose contravention et délit.
4. « Un délit, tranché par un magistrat » — écarté : seule option ponctuée de la carte
   (`forme/seule-ponctuee`, informatif).
5. « Un délit tranché par un magistrat » (virgule retirée) — retenu en fin de premier tour, mais
   **la revue a montré que le défaut n'était pas la forme, il était le fond** : le qualificatif
   partagé avec l'option A (« une contravention de quatrième classe », dont l'explication
   voisine `526ffb51…` associe déjà « jugé au tribunal correctionnel » à une contravention
   discutée à tort) ne distingue en réalité rien — une contravention contestée peut, elle aussi,
   passer devant un juge (tribunal de police). La carte définissait le délit par « quelqu'un le
   juge », qui n'est pas ce qui le sépare de la contravention.
6. « Un délit, passible d'une peine de prison » — corrige le fond : l'emprisonnement n'existe
   pour aucune contravention, quelle que soit sa classe, donc ce qualificatif distingue
   réellement le délit — mais réintroduisait une virgule et, sans elle, redevenait l'option la
   plus longue de la carte (bonne=39 vs 2e=37, exactement le déséquilibre du texte de départ,
   étape 1).
7. **« Un délit passible de prison » — retenu.** Même fait distinctif (emprisonnement possible,
   jamais pour une contravention), sans virgule, et raccourci pour ne plus être l'option la plus
   longue (27 caractères contre 33–37 pour les trois autres).

Vérifié par script contre les 255 cartes `code` : les trois mots pleins de la formulation
retenue (`délit`, `passible`, `prison`) ne sont réunis dans l'explication d'aucune autre carte.
`--fuites` sur « Alcool & stupéfiants », « Vitesse » et « Permis & sanctions » : 0 recouvrement
sur les trois après ce choix. Observation laissée telle quelle, sans y toucher : le seul
« tribunal correctionnel » restant dans le domaine est maintenant sur une option **fausse**
(`526ffb51…` B, « Commet un délit, jugé au tribunal correctionnel », une contravention à tort
qualifiée de délit) — c'est un distracteur qui nomme une confusion réelle, pas un défaut.

**Dissonance « deux verres » / « deux ou trois verres ».** Les deux cartes visées par le §9.5
n° 8 de la passe 2 sont `37fe1af42b8d8118b6d3f82929eabdca` (seuil général, « et deux ou trois
verres pour la franchir ») et `37fe1af42b8d81218099fdc3bcfd24c9` (verre standard, « ce qui met
le seuil légal à portée de deux verres »). Tranché contre l'affirmation INRS TC 152 que les
deux lignes de registre citent : un verre standard fait monter l'alcoolémie de **0,20 à 0,25
g/L** (INRS, rang 3, organisme nommé, édition décembre 2015 ; le dépliant DSR d'avril 2022,
rang 2, retient 0,25 g/L en moyenne — aucune source de rang 1 ne chiffre cette constante
physiologique). Pour
franchir le seuil général de 0,50 g/L : 0,50 / 0,25 = **2** verres à l'estimation haute, 0,50 /
0,20 = **2,5** à l'estimation basse — donc entre deux et trois selon l'individu, jamais un
compte fixe à deux. « Deux ou trois verres » est la formulation qui respecte la fourchette
publiée ; « deux verres » seul l'arrondissait à l'estimation la plus favorable, en contradiction
avec sa propre ligne de registre qui cite les deux bornes. `37fe1af42b8d812180…` a été réécrite
pour dire « deux ou trois verres », identique à sa voisine. La ligne de `37fe1af42b8d81218099fdc3bcfd24c9`
dans `sources.md` porte désormais le calcul et un renvoi explicite vers la ligne de
`37fe1af42b8d8118b6d3f82929eabdca`, qui reste la source du seuil de 0,50 g/L — pas de doublon
de citation entre les deux lignes.

### Le faux positif `expl/paraphrase-litterale`

`37fe1af42b8d817e9b93c2546ad30ec9` (« Conduire avec un taux entre 0,5 et 0,8 g/L fait perdre : »
→ « 6 points ») est l'une des 17 cartes que compte la ligne de base actualisée. Lue contre le
critère : son explication ne se contente pas de renommer « 6 points » — elle donne la **raison**
(« Le barème frappe l'alcool au maximum possible pour une contravention : 6 points, la moitié du
capital, d'un seul coup ») et la **limite** (« Au-delà de 0,8 g/L on change de nature
d'infraction et on passe au délit, sans que le retrait augmente pour autant »), exactement le
garde-fou que `Tools/questions.md` §1 nomme : « Une réponse chiffrée reprise dans l'explication
est normale — le défaut est l'explication qui n'ajoute rien. » Celle-ci ajoute les deux choses
qu'une paraphrase littérale n'ajoute jamais. **Verdict : faux positif, non corrigée.**

### Pédagogie

- explications sous 120 caractères : 0 à l'entrée, 0 à la sortie — aucune carte du domaine n'en
  a jamais compté sous ce seuil (médiane 270 caractères dès l'étape 1), conformément à l'étape 5
  du brief : le gain de cette tâche est sur l'énoncé et les options, pas sur la longueur des
  explications.
- cartes dont le budget de 220 a limité l'explication : aucune, le domaine ne compte aucune
  carte illustrée.
- énoncés reformulés parce qu'ils présupposaient la règle : aucun. Les 18 énoncés se lisent déjà
  sans connaître la réponse (vérifié un par un à l'étape 2) ; aucune modification d'énoncé dans
  cette tâche.
- deux explications complétées pour porter la **raison** ou la **limite** que le critère 3
  demande, sans y toucher pour le budget (aucune contrainte de 220 caractères dans ce domaine) :
  - `22603ebb1d645f3273bc07e98ab0eb23` (dépistage après accident corporel) gagne « la gravité de
    l'enjeu ne laisse pas le temps d'attendre un signe visible », qui explique pourquoi
    l'obligation ne demande aucun soupçon préalable plutôt que de seulement l'affirmer.
  - `37fe1af42b8d810ea54ddbcc64f356fa` (stupéfiants, absence de seuil) gagne une **limite** :
    « mais il faut qu'une analyse sanguine ou salivaire le confirme, un simple soupçon ne suffit
    pas », qui borne la règle « aucun seuil » contre une lecture qui la ferait reposer sur une
    simple accusation. Le fait était déjà dans l'affirmation de la ligne (« il résulte d'une
    analyse sanguine ou salivaire ») ; aucun ajout de registre nécessaire.
- une explication corrigée en fix round 1 parce qu'elle légitimait le distracteur qu'elle aurait
  dû réfuter : `37fe1af42b8d81cf8791f73464a2f801` (seuil probatoire) disait « il équivaut à zéro
  alcool en pratique », ce qui validait l'option B « 0 g/L » plutôt que de l'exclure —
  exactement le distracteur partiellement vrai que le §1 règle 2 de `questions.md` proscrit,
  sur le domaine où c'est le moins sûr (la limite officiellement enseignée aux jeunes
  conducteurs). Réécrite : « Le seuil probatoire n'est pas nul : il est fixé à 0,20 g/L, sous
  l'effet d'un seul verre standard (0,20 à 0,25 g/L par verre). » L'explication argumente
  maintenant *contre* l'option 0, elle ne la cautionne plus. Figure du verre standard déjà
  sourcée sur une ligne voisine ; `sources.md` porte le renvoi plutôt qu'une nouvelle citation.
- une explication corrigée deux fois. En fix round 1, pour un recouvrement que `--fuites` ne
  peut pas voir (le seuil de trois mots pleins ne couvre pas une paraphrase) :
  `37fe1af42b8d811eae7dfa1a08ee0f64` (vitesse d'élimination) disait « rien d'extérieur
  n'accélère ce rythme », qui redit en d'autres mots la bonne réponse de
  `37fe1af42b8d81f2a662e1b1284f99b9` (« Attendre : rien d'autre n'agit »). Retirée : le fait
  reste enseigné en entier par `81f2a6…`, dont c'est le seul objet — mais la retirer sans rien
  y substituer laissait la carte sans **limite** (le seul garde-fou contre le mythe café /
  douche / repas venait de là), régression signalée par la revue et corrigée en **fix round
  2** : « et ce rythme ne s'accélère pas avec la quantité — trois verres ne s'éliminent pas
  plus vite, ils prennent trois fois plus de temps », qui borne la règle sans redire la réponse
  de `81f2a6…` (les deux cartes lues côte à côte ne partagent aucun mot plein de plus de quatre
  lettres). C'est un fait distinct : `81f2a6…` dit que rien d'extérieur n'accélère le rythme,
  `811eae…` dit maintenant que le rythme est le même quelle que soit la quantité — c'est ce qui
  rend l'illustration « trois verres à minuit » réellement démonstrative plutôt que décorative.
- un débat interne réglé sans toucher au fond en round 1, puis corrigé une seconde fois en fix
  round 1 sur la revue (voir « Les deux dettes » ci-dessus pour la chronologie complète) :
  `37fe1af42b8d817e8e2feffa6987ba00`, dont l'option correcte teste maintenant un fait qui
  distingue réellement le délit de la contravention (l'emprisonnement possible), pas seulement
  des mots différents pour la même identité de venue.

**Huit cartes modifiées** au total : les six ci-dessus, plus deux touchées uniquement sur leurs
options (détail dans « Options » ci-dessous) — `37fe1af42b8d811eae7dfa1a08ee0f64` (déjà listée
pour son explication, et dont les trois distracteurs ont aussi été élargis en fourchettes) et
`37fe1af42b8d81b38194dba0c15484b4` (stupéfiants, peine maximale : deux options réécrites).

**Les dix cartes non modifiées**, lues contre les quatre critères pédagogiques et évidencées
individuellement — deux évidences corrigées en fix round 1, qui admettaient une raison
seulement implicite tout en la comptant comme conforme ; elles sont maintenant nommées comme
telles plutôt que forcées dans la colonne « conforme » :

| id | rôle | pourquoi jugée conforme |
|---|---|---|
| `37fe1af42b8d817e9b93c2546ad30ec9` | 0,5–0,8 g/L, retrait de points | conforme au sens du §4 (faux positif motivé ci-dessus) ; règle (« 6 points ») + raison (« le maximum possible pour une contravention […] la moitié du capital ») + limite (« Au-delà de 0,8 g/L on change de nature d'infraction […] sans que le retrait augmente pour autant ») |
| `37fe1af42b8d81b3b1a2f0bc28c23b22` | effets sur la conduite | règle (réduction du champ visuel et des réflexes) + **raison seulement implicite** — la gradation dose-effet (« dès le premier verre […] à partir du seuil légal de 0,5 g/L elles sont tenues pour établies ») situe *quand* les effets sont établis, pas le mécanisme qui les cause ; l'affirmation de la ligne ne va pas plus loin, donc rien à sourcer de plus + limite qui coupe le mythe de la compensation (« Aucune ne se compense par la volonté de rester vigilant ») |
| `37fe1af42b8d81f2a662e1b1284f99b9` | accélérer l'élimination | règle (rien n'accélère) + raison (« L'alcool est éliminé par le foie à un rythme fixe ») + limite qui nomme les trois mythes et ce qu'ils changent réellement (« café, douche ou repas modifient la sensation d'ébriété, pas le taux mesuré par l'éthylomètre ») |
| `526ffb51f8bc0ed95490405ddc0dfc0f` | probatoire à 0,4 g/L | règle (infraction dès 0,4 g/L, seuil probatoire 0,2) + raison (« vaut pendant toute la période probatoire, quel que soit l'âge ») + limite qui évite la sur-généralisation vers le délit (« mais elle reste une contravention, le délit commençant à 0,8 g/L ») |
| `5720fa6a7cd62743982f88a4f3fa5dd2` | 0,9 g/L, peine maximale | règle (dans l'option, en chiffres : « 3 ans de prison et 9 000 € d'amende » — l'explication ne la répète pas en toutes lettres) + **raison seulement par contraste**, pas une cause (« c'est l'ancien barème, resté dans presque tous les manuels, qui donne deux ans et 4 500 € » ancre le chiffre contre la confusion la plus probable, sans dire pourquoi le législateur a choisi ce montant — aucune source lue ne porte d'exposé des motifs) + limite (« La peine de cinq ans […] est réservée au cumul », qui distingue de `e13df5a7…`) |
| `749552ac121e0cd77beff969300b8ef9` | refus de dépistage alcool | règle (délit, même peine que 0,8 g/L) + raison (« le législateur l'a calée sur ce qu'elle permet d'éviter : sans cela, refuser serait toujours plus avantageux que souffler ») + limite (« seules les peines complémentaires restent différentes, la suspension du permis plafonnée à trois ans pour le refus contre cinq ans pour le délit ») |
| `92f3fe40dd9c28ff0010261e74ae6ebe` | refus de dépistage stupéfiants | règle (même peine que l'alcool) + raison-par-parité (« encourt la même peine que celui de l'alcoolémie ») + limite qui distingue du cumul (« celui du cumul alcool et stupéfiants, à cinq ans et 15 000 €, sanctionne une infraction plus lourde ») |
| `bda97dae02fa9e085f5f6ba0827a4f7b` | assurance après accident | règle (couvre les tiers, exclut le conducteur, majore de 150 %) + raison (« La responsabilité civile est obligatoire : elle joue pour les tiers quoi qu'ait fait l'assuré ») + limite (« 400 % ne s'applique qu'en cas d'infractions multiples […] mais seulement avec un mois de préavis ») |
| `e13df5a7d4151bdeca7a9f914c90cf4e` | cumul alcool + stupéfiants | règle (« cinq ans […] et 15 000 € ») + raison physiologique (« Les deux produits combinent leurs effets sur la vigilance au lieu de s'annuler ») + limite (« la confiscation du véhicule devient obligatoire, la juridiction devant motiver spécialement pour y renoncer ») |
| `ef26cca38b9d1abc6fb0b13d76247f35` | éthylotest antidémarrage | règle (bloque le démarreur, pas le moteur lancé) + raison implicite par contraste avec le distracteur A + limite/séquence (« cette interdiction ne s'applique qu'à l'issue de cette peine — le condamné ne conduit donc pas pendant la suspension […] Passer outre est un délit distinct ») |

Huit cartes modifiées (`22603ebb…`, `37fe1af42b8d810ea5…`, `37fe1af42b8d8118b6…`,
`37fe1af42b8d812180…`, `37fe1af42b8d817e8e…`, `37fe1af42b8d81cf87…`, `37fe1af42b8d811eae…`,
`37fe1af42b8d81b381…`) + dix non modifiées = 18, sans reste.

### Options (critère 2)

Les 18 cartes relues contre les trois premières règles du §1 de `questions.md` (plausible,
réellement faux, confusion courante plutôt que chiffre inventé) et le piège de forme du §2 (non
éliminable par pure logique). **Ce paragraphe a été refait en fix round 1** : le premier passage
concluait « aucune autre carte du domaine n'a montré de chiffre inventé » et « aucun distracteur
récurrent n'apparaît dans ce domaine », deux affirmations que la revue a trouvées fausses contre
les cartes elles-mêmes. Quatre correctifs au total :

- **`37fe1af42b8d8118b6d3f82929eabdca`** (seuil général) — option D « 1 g/L de sang » n'est le
  seuil d'aucune catégorie du droit routier français : seuls 0,20 (probatoire), 0,50 (général)
  et 0,80 g/L (délit) sont codifiés, et la carte teste déjà les trois autres (A, B, C).
  Remplacée par « 0 g/L de sang », qui nomme une confusion réelle et répandue (la croyance en
  une tolérance zéro) plutôt qu'un quatrième seuil inventé.
- **`37fe1af42b8d81cf8791f73464a2f801`** (seuil probatoire) — même défaut sur l'option B
  « 0,3 g/L », valeur qui n'existe dans aucune des trois catégories. Remplacée par « 0 g/L »,
  même correctif — mais l'explication de cette carte, elle, validait ce distracteur au lieu de
  le contredire ; voir Pédagogie ci-dessus pour la correction, faite dans le même geste en fix
  round 1. Les deux cartes couvrant ensemble 0 / 0,2 / 0,5 / 0,8 n'introduisent pas de doublon
  de distracteur : c'est la même confusion réelle (tolérance zéro) réutilisée deux fois dans le
  même domaine, comme le permet la règle 5 du §1 (« la confusion courante est le meilleur
  distracteur ») — à distinguer du défaut que vise la règle 7, qui porte sur un distracteur
  générique et vide de sens répété au point de devenir un signal, non sur une confusion réelle
  propre au domaine.
- **`37fe1af42b8d811eae7dfa1a08ee0f64`** (vitesse d'élimination) — **découvert en fix round 1** :
  l'option correcte (« 0,1 à 0,15 g/L par heure ») était le seul intervalle des quatre options
  face à trois valeurs ponctuelles, **et** la plus longue de six caractères (`audit.py` :
  bonne=24 vs 2e=18, +6) — le cumul de forme que le §2 de `questions.md` proscrit, déjà corrigé
  une fois sur la carte voisine `37fe1af42b8d81218099fdc3bcfd24c9` dont la ligne de registre
  enregistre le geste (« Les options ont été élargies en fourchettes »). Même correctif ici : A
  (0,5 → « 0,4 à 0,6 g/L par heure »), B (0,05 → « 0,02 à 0,05 g/L par heure ») et D (1 →
  « 0,8 à 1,2 g/L par heure ») deviennent des fourchettes, chacune un ordre de grandeur
  plausible mais faux (surestimation ou sous-estimation), sans toucher à l'intervalle correct.
  Son explication a par ailleurs regagné une limite en fix round 2 (voir Pédagogie ci-dessus) :
  cette carte porte désormais les quatre critères sur ses trois champs, alors qu'elle n'en
  portait que deux à l'ouverture de cette tâche.
- **`37fe1af42b8d81b38194dba0c15484b4`** (stupéfiants, peine maximale) — **découvert en fix
  round 1**, deux défauts sur la même carte :
  - option B « Aucune peine en l'absence d'accident » était éliminable par la forme de l'énoncé
    lui-même (« expose à une peine pouvant aller jusqu'à : », qui présuppose qu'une peine
    existe — §1 règle 4) : répondre « aucune » à une question qui présuppose une peine se
    repère sans rien connaître au sujet. Réécrite en une croyance que l'énoncé ne réfute pas :
    « La seule suspension du permis » (une vraie conséquence, mais incomplète — pas la bonne
    réponse).
  - option C « 150 € d'amende, sans peine de prison » nommait un montant qui n'existe dans
    aucun barème du droit routier (la 4ᵉ classe forfaite à 135 €, une contravention maximale à
    750 €) — même défaut que les deux seuils d'alcoolémie inventés ci-dessus, sur un chiffre
    plutôt qu'un seuil. Corrigée en « 135 € d'amende, sans peine de prison ». **Provenance de
    ce chiffre, comme le veut la ruling sur le geste unique** : ce n'est pas une valeur affirmée
    par cette carte (un distracteur est affirmé faux, il n'a pas besoin de ligne de registre),
    c'est un montant réel recyclé d'ailleurs dans la banque — le forfait de la contravention de
    4ᵉ classe, fixé par le 5° de l'article R49 du code de procédure pénale, cité mot pour mot sur
    plusieurs lignes de `sources.md` (par exemple celle de `37fe1af42b8d811198bdecd01768828c`,
    stationnement dangereux). Aucune ligne de registre n'a été touchée pour ce distracteur ; le
    même principe vaut pour les trois fourchettes de `37fe1af42b8d811eae…` ci-dessus, qui sont
    des estimations et non des valeurs affirmées.

Sur les grandeurs continues restantes (effet d'un verre standard, `37fe1af42b8d81218099fdc3bcfd24c9`),
les options sont des estimations physiologiques et non des seuils légaux catégoriels : elles ne
sont pas soumises au même test d'existence qu'un chiffre de droit, une fourchette d'ordre de
grandeur n'ayant pas besoin de correspondre à une catégorie codifiée. Les options en points
(`37fe1af42b8d817e9b…` : 1, 2, 3 points) reprennent le barème réel de R223-1 utilisé ailleurs
dans le code pour d'autres infractions ; les options en peines restantes (750 €, 2 ans/4 500 €,
5 ans/15 000 €) sont soit l'ancien barème recyclé (règle 3 du §5 de `questions.md`), soit un
régime réel voisin (le cumul) cité à sa vraie place et distingué en explication.

Le doublon cross-domaine (`37fe1af42b8d817e8e2feffa6987ba00` face à `337bfcb4d034b62de5` de
« Vitesse ») est traité en détail dans « Les deux dettes du domaine » ci-dessus.

**Le distracteur en forme de négation, recompté après le fix round 1.** Le premier passage
affirmait qu'aucun distracteur récurrent de la banque (« klaxonner », « aucune sanction »,
« rien ») n'apparaissait dans ce domaine — vrai au sens strict (aucun de ces trois mots), mais ça
laissait passer une famille plus large que la revue a nommée : un distracteur qui nie toute
conséquence plutôt que d'en nommer une plus faible. Avant le fix round 1 elle comptait cinq
cartes sur dix-huit ; la correction de `37fe1af42b8d81b381…` B (ci-dessus, qui n'est plus une
négation) la ramène à **quatre** : `37fe1af42b8d817e8e…` C (« Sans sanction en l'absence de
trouble »), `37fe1af42b8d81b3b1…` D (« Aucun effet mesurable en dessous de 0,5 g/L »),
`749552ac…` C (« Sans conséquence, faute d'infraction établie ») et `e13df5a7…` D (« Les mêmes
peines, sans aggravation »). **Verdict : acceptable, à surveiller plutôt qu'à corriger.** Les
quatre nomment une croyance réelle et distincte (pas de remplissage générique), ce qui les
distingue du défaut que vise la règle 7 — mais le point commun de forme (la négation) sur 4/18
est plus dense qu'ailleurs dans la banque, un effet secondaire probable d'un domaine où presque
toute question porte sur une sanction : « aucune conséquence » y est une réponse fausse plus
souvent que dans un domaine qui n'en parle pas systématiquement. Le corriger en profondeur
demanderait de réaimer quatre cartes déjà conformes sur les trois autres règles, ce que la
consigne de ce tour interdit explicitement (« ne pas réécrire cinq cartes en masse pour rendre
une phrase vraie ») ; signalé pour qu'une passe future qui croiserait ce même motif dans
« Permis & sanctions » ou « Vitesse » (non vérifié ici) sache qu'il n'est pas propre à ce
domaine.

### Mouvements d'`audit.py`

| sortie | avant | après |
|---|---|---|
| `lettre/reference` | 1 | 1 |
| `forme/markdown` | 1 | 1 |
| `forme/seule-ponctuee` | 14 | 14 |
| `longueur/plus-longue` | 97 | 95 |
| `expl/paraphrase-litterale` | 17 | 17 |
| `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10`, `forme/backtick-isole` | vide | vide |

`longueur/plus-longue` baisse de deux, composition différente de celle rapportée avant le fix
round 1 : `37fe1af42b8d817e8e…` (bonne=39 vs 2e=37, +2 à l'origine) en sort après réécriture de
son option correcte — passée par un point haut à 39 dans un brouillon intermédiaire (chronologie
complète ci-dessus), réglé par le raccourcissement final à 27 caractères — et
`37fe1af42b8d811eae…` (bonne=24 vs 2e=18, +6, le plus grand écart du domaine) en sort après
l'élargissement de ses trois distracteurs en fourchettes. `--fuites` : 0 recouvrement sur
« Alcool & stupéfiants », « Vitesse » et « Permis & sanctions » avant et après ce tour ; les
brouillons intermédiaires qui en avaient introduit sont détaillés dans « Les deux dettes du
domaine ».

## Usagers & partage de la route

18 cartes, 14 `datée`, 4 illustrée(s). Section réécrite en entier une seconde fois (fix round 2) :
deux défauts supplémentaires trouvés après le premier round de corrections, l'un sur une carte
déjà corrigée une fois (`a6fb8c0684…`), l'autre sur une carte que rien n'avait signalée
(`c29b2e7d…`).

### Écarts de justesse trouvés

| id | écart | ce que disait la carte | ce que dit l'article | correction |
|---|---|---|---|---|
| `a6fb8c0684dce67923a3207ee19171c9` | règle trop large, deux fois | round 1 : « sur une chaussée où la vitesse autorisée atteint 70 km/h » (aucune condition de type de route ni de véhicule). Round 2, après une première correction : « entre les deux voies de gauche d'une autoroute ou d'une route à chaussées séparées par un terre-plein central, à deux voies par chaussée au moins et 70 km/h autorisés » — toujours trop large, et cette fois la cause était dans le registre lui-même | `Tools/sources.md:426` fermait ses guillemets **au milieu de la phrase**, juste après « 70 km/h », sans « … » — masquant la suite : « en application des articles R. 413-2 ou R. 413-3, **nonobstant** la fixation d'une vitesse maximale autorisée plus faible […], **lorsqu'en raison de sa densité**, la circulation s'y est établie en files ininterrompues sur toutes les voies […] ». Une autoroute vide à 130 ne remplit pas la condition que la carte affirmait (« 70 km/h autorisés ») ; une route abaissée à 50 par arrêté de police la remplit quand même (« nonobstant ») si la circulation y est dense | citation complétée dans `sources.md` (phrase entière, sans troncature — voir Fix round 2 du rapport de tâche) ; la carte, elle, ne tente plus de résumer ce champ d'application en une clause courte — l'explication se limite aux deux plafonds de vitesse et à la restriction de voies, ce que l'énoncé et les options testent réellement |
| `b7b38d7ae1faf0dd593a1a2446b59ee6` | règle trop large, corrigée en deux temps | round 1 : aucune exception. Round 2, après une première correction : « sauf si cela **compromet** sa sécurité » — l'exception restaurée, mais rétrécie (l'article dit « est **de nature à** compromettre », un seuil plus bas que « compromet » effectivement) — et la seconde exception de l'article (« ou sauf circonstances particulières ») restait absente | R412-36 alinéa 2 : « sauf si cela **est de nature à** compromettre leur sécurité **ou sauf circonstances particulières** » — deux exceptions distinctes, toutes deux déjà citées mot pour mot dans `sources.md` depuis le round 1 | les deux nuances restaurées : « est de nature à compromettre » et « ou sauf circonstances particulières » toutes deux dans l'explication ; l'exemple (virage sans visibilité) reformulé en « il peut alors **s'en écarter** » plutôt que « changer de côté », pour ne plus pointer vers le distracteur C (« près du bord droit ») |
| `c29b2e7d758f0d17e790fa40f6e83313` | explication au-delà de l'article (type 3) | « Le flanc droit est **le plus grand** angle mort d'un poids lourd » | l'affirmation dit explicitement : « **Aucune source de rang 1 ne cote un angle mort** : R313-32-1 rend la signalisation obligatoire sans donner aucune dimension » — la comparaison (« le plus grand ») n'est couverte par rien | adoucie en « un angle mort **signalé comme tel** », qui s'appuie sur ce que R313-32-1 impose réellement (signalisation obligatoire sur les côtés d'un véhicule > 3,5 t, carte voisine `9eed1fe6…`) sans affirmer une taille relative que personne ne mesure |
| `e6f52409aaec9cc7d19ca28837113023` | règle trop large (citation au mauvais paragraphe) | « Assimilé au piéton par R412-34, il en garde toutes les autres obligations » | la ligne de registre ne citait que le 2° du II de R412-34, qui désigne *qui* est assimilé, pas ce que l'assimilation couvre ; le III le fait, mot pour mot : « les conducteurs sont tenus d'observer les règles imposées aux piétons » | citation du III ajoutée à `sources.md` à la place du seul II 2° ; carte réécrite pour séparer l'exception (bord droit) de la règle qui l'entoure (assimilation au piéton) |

**La phrase complète de R412-11-3 I**, relevée mot pour mot le 2026-08-27, assemblée à partir de
trois lectures WebFetch distinctes sur l'article consolidé (la première refusant de la citer en
entier pour longueur, contournée en la découpant en deux segments plus une confirmation de la
jonction) :

> « Sur les autoroutes et les routes à deux chaussées séparées par un terre-plein central et
> dotées d'au moins deux voies chacune, où la vitesse maximale autorisée est supérieure ou égale
> à 70 km/h en application des articles R. 413-2 ou R. 413-3, nonobstant la fixation d'une
> vitesse maximale autorisée plus faible par l'autorité de police de la circulation en
> application de l'article R. 413-1, lorsqu'en raison de sa densité, la circulation s'y est
> établie en files ininterrompues sur toutes les voies, y compris celles réservées, le cas
> échéant, à la circulation de certaines catégories particulières de véhicules ou d'usagers,
> tout conducteur d'un véhicule d'une largeur d'un mètre maximum relevant de la catégorie L3e ou
> L5e définie à l'article R. 311-1 peut circuler entre les files de véhicules situées sur les
> deux voies, ayant le même sens de circulation, les plus à gauche d'une chaussée. »

Version en vigueur depuis le 11/01/2025, confirmée par un WebFetch séparé. Cette phrase est
maintenant entière dans `Tools/sources.md:426`, sans « … » ; la carte n'en reprend que ce que
l'énoncé teste (les deux plafonds de vitesse, la restriction de voies), pas le champ
d'application complet — trop dense pour être résumé en une clause courte sans le trahir, comme
l'a montré une deuxième tentative infructueuse.

### Doutes signalés, non corrigés

Aucun.

### Pédagogie

- explications sous 120 caractères : 0 à l'entrée, 0 à la sortie.
- cartes dont le budget de 220 a limité l'explication : les 4 illustrées, toutes mesurées après
  la passe complète (deux fix rounds compris) — `39fa27d5…` 219/220, `9b774739…` 190/220,
  `c29b2e7d…` 192/220, `f6ef205d…` 212/220.
- énoncés reformulés pour introduire un terme technique non glosé ailleurs sur la carte : 3 —
  `45d84549…`, `5f426e8e…`, `a6fb8c0684…` (« engin de déplacement personnel motorisé » et
  « inter-files », glosés en incise dans l'énoncé).
- explications réécrites pour porter une raison qui manquait : 8 au total sur les deux rounds —
  `058434ed…`, `45d84549…`, `49f761c8…`, `7c2284d4…`, `bf6922c5…`, `e6f52409…`, `82b915c2…`,
  `9eed1fe6…`. Ces deux dernières ont été retouchées une seconde fois ce round-ci : la raison
  ajoutée au round 1 était formulée à la voix de l'article (« R431-1-2 protège les mains… »,
  « R313-32-1 impose… pour indiquer… ») alors que `sources.md` ne porte aucune clause de finalité
  pour ni l'une ni l'autre — reformulées à la voix du raisonnement de la carte (« Les mains sont
  le premier appui au sol en cas de chute, ce qui explique pourquoi R431-1-2… », « Cyclistes et
  piétons y voient où ils sortent du champ de vision du chauffeur : … R313-32-1 impose… »), sur
  le modèle déjà utilisé par `45d84549…` (« où les voitures roulent trop vite pour eux »).
- explication complétée pour restaurer une exception que l'affirmation portait déjà, puis
  affinée une seconde fois : `b7b38d7ae…` — voir Écarts de justesse.
- explication adoucie pour retirer une comparaison non sourcée : `c29b2e7d…` — voir Écarts de
  justesse. Carte illustrée, 202 → 192 caractères (la reformulation raccourcit plutôt qu'elle
  n'allonge).
- explication resserrée après une deuxième correction infructueuse sur le même champ
  d'application : `a6fb8c0684…` — voir Écarts de justesse.
- clause déplacée pour ne plus changer de sens : `7c2284d4…`. « sauf décision contraire de
  l'autorité de police » (ajoutée au round 1 en fin de phrase, juste avant « Passé cet âge…
  jamais l'espace des piétons ») se lisait comme si l'autorité pouvait *autoriser* au-delà de
  huit ans, alors que l'article la met sur la tolérance elle-même : l'autorité peut *interdire*
  ce que le I bis accorde en dessous de huit ans. Déplacée en tête, juste après « tolère sur le
  trottoir » : « tolère sur le trottoir, sauf décision contraire de l'autorité de police, les
  cyclistes de moins de huit ans… ».
- mot ajusté pour ne plus affirmer un terme absent de l'article dans les deux sens :
  `fe6c3908…`. « change **simplement** de catégorie » (round 1, pour éviter la conséquence
  légale non sourcée « n'a plus rien à faire sur la voie publique ») sous-affirmait à son tour —
  « simplement » n'est pas plus dans R311-1 que ne l'était la conséquence retirée. Devenu
  « change de catégorie », qui ne dit que ce que l'article dit.
- recouvrement incidental documenté, non corrigé par une réécriture : `e6f52409…` recouvre
  toujours, à trois mots pleins (`comme`, `passage`, `piéton`), la bonne réponse de `c5d4d52f1aaa`
  [Arrêt & stationnement] (« de 135 €, comme sur un passage piéton »), sans aucun rapport de
  contenu entre les deux cartes. Laissé tel quel : le corriger demanderait d'affaiblir « céder le
  passage » (R412-37 n'accorde pas de priorité automatique au piéton, donc « céder la priorité »,
  essayé une fois, était moins exact) pour la seule commodité de l'outil.

**Preuve par carte, pour les 3 cartes non modifiées** — règle / raison / limite telles que la
carte les dit :

| id | rôle | pourquoi jugée conforme |
|---|---|---|
| `39fa27d59e28817c42382c5f4f4e2fc0` | sas cycliste, ligne d'arrêt | règle (ligne en retrait pour les véhicules motorisés) + raison explicite (« le cycliste démarre ainsi dans le champ de vision des conducteurs, plutôt qu'à leur droite ») ; pas de limite légale à poser, la carte ne portant aucune valeur de droit (`stable`). Budget illustrée à 219/220, aucune marge |
| `f6ef205dcb2d32c5f30ca6ee69a673c8` | bus quittant un arrêt | règle (ralentir, au besoin s'arrêter) + raison explicite (« l'indicateur… ouvre un droit ») + limite explicite, doublement conditionnée comme l'article (« en agglomération » et « un arrêt signalé comme tel ») — carte la plus complète du lot |
| `0b13aed9a8d54d809ec67944c7033775` | trottinette sur le trottoir | règle (interdite sauf décision de l'autorité) + raison explicite (« réserve le trottoir aux piétons ») + limite explicite (conditions de l'autorisation : allure du pas, sans gêner) |

Les 15 autres cartes du domaine sont modifiées (`058434ed…`, `45d84549…`, `49f761c8…`,
`7c2284d4…`, `bf6922c5…`, `e6f52409…`, `9b774739…`, `d3f45f8d…`, `fe6c3908…`, `82b915c2…`,
`5f426e8e…`, `a6fb8c0684…`, `9eed1fe6…`, `b7b38d7a…`, `c29b2e7d…`) — modifiées 15 + non modifiées
3 = 18, sans reste.

### Mouvements d'`audit.py`

| sortie | avant (2026-08-27, début de tâche) | après (fix round 2) |
|---|---|---|
| `lettre/reference` | 1 | 1 |
| `forme/markdown` | 1 | 1 |
| `forme/seule-ponctuee` | 14 | 14 |
| `longueur/plus-longue` | 95 | 95 |
| `expl/paraphrase-litterale` | 17 | 17 |
| `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10`, `forme/backtick-isole` | vides | vides |

Diff vide contre la ligne de base d'avant tâche, aux deux rounds de correction. `--fuites
"Usagers & partage de la route"` : 1 recouvrement, incidental, documenté ci-dessus — pas 0, par
choix. `--fuites` sur les trois domaines déjà clos (« Permis & sanctions », « Vitesse »,
« Alcool & stupéfiants ») : 0 avant et après ce round.

## Mécanique & environnement

20 cartes, 12 `datée`, 1 illustrée(s).

### Écarts de justesse trouvés

| id | écart | ce que disait la carte | ce que dit l'article | correction |
|---|---|---|---|---|
| `089e9b57f57bbb155f81da3ec492082f` | règle trop large | « Un système homologué de retenue est exigé pour tout enfant [de moins de dix ans] », sans réserve, avec pour seule limite dans l'explication l'enfant déjà adapté à la ceinture (III 1°) | R412-2 III liste **trois** dispenses, pas une : 1° la morphologie adaptée à la ceinture (déjà dans la carte), 2° le certificat médical d'exemption, 3° « tout enfant transporté dans un taxi ou dans un véhicule de transport en commun » — relu en entier par deux `WebFetch` indépendants et concordants (le second citant nommément la cross-référence au 2° du II de R412-1, peu compatible avec une hallucination) | explication complétée : « sauf enfant déjà adapté à la ceinture, en taxi ou en transport en commun » ; ligne de `sources.md` réécrite pour porter les trois points du III, `relevé le` passé à 2026-08-27 |

C'est le cas visé par le point 12 du calibrage : l'énoncé pose un champ d'application (« pour
tout enfant ») sans le borner, et l'ancienne ligne de registre ne citait que la première des
trois dispenses de R412-2 III — elle n'était pas tronquée en plein milieu d'une phrase, mais
tronquée **entre les points** d'une énumération, ce qui est le même défaut sous une autre forme.
La bonne réponse (le seuil de dix ans, option A) reste inchangée : l'écart ne portait pas sur la
valeur mais sur ce que l'explication omettait de borner.

**Sept autres articles du domaine ont été relus en entier pour la même raison** (le domaine
« est plein de champs d'application », dit la consigne) sans y trouver d'écart :
R312-21/R312-22 (chargement — aucune exception de catégorie de véhicule, seuils confirmés
mot pour mot par `WebFetch`) ; R416-19 III (triangle/gilet — les deux/trois-roues et les
véhicules agricoles sont exemptés, mais la carte est déjà bornée « à bord d'une voiture », donc
hors du champ de l'exemption) ; R318-2 I (Crit'Air — le classement vaut pour les catégories M,
N, L, mais la carte n'affirme que la *fonction* du certificat, pas son champ d'application, donc
la restriction de catégorie ne la contredit pas) ; D314-8 (pneus hiver — M2/M3/N2/N3 ont des
règles distinctes des M1/N1 cités par la carte, mais l'énoncé ne prétend couvrir que le cas
véhicule léger, implicite dans tout le domaine) ; R323-22 (contrôle technique — bornée aux
« véhicules légers », la carte se limite déjà à « une voiture neuve », hors du cas des
professionnels exemptés) ; R412-3 I (siège dos à la route — l'article porte trois cas
d'exception, la carte n'en teste qu'un, celui du dispositif orienté vers l'arrière, sans
prétendre à l'exhaustivité) ; R412-1 II (dispense de ceinture — liste confirmée close à six
points, sans septième point ni dispense de grossesse, `WebFetch` cité mot pour mot).

**Fix round 1 — un second écart, trouvé dans le registre lui-même, pas dans la carte.** Sur
`37fe1af42b8d8123abc0da9b2b7a51e0` (Crit'Air), la ligne de `sources.md` citait le II de
L2213-4-1 tronqué : « Les zones à faibles émissions mobilité sont délimitées par un arrêté »
suivi du mot « local » **hors des guillemets**, juste avant la clause qui continue la phrase de
l'article (« … qui fixe les mesures de restriction de circulation applicables, détermine les
catégories de véhicules concernés et précise les motifs légitimes pour lesquels des dérogations
individuelles peuvent être accordées »). C'est le point 12 du calibrage à la lettre, trouvé dans
le domaine qui était censé le chercher : la carte, elle, n'affirme rien de plus que ce que
l'article dit — le caractère local de l'arrêté est exact (pouvoir de police du maire ou du
président de l'EPCI, L2213-4-1 étant au CGCT) — mais la citation mentait par omission en laissant
croire que « local » venait du texte cité. Corrigé : citation portée jusqu'à la fin de la phrase,
« local » redescendu en prose après la parenthèse ; `relevé le` passé à 2026-08-27.

### Doutes signalés, non corrigés

| id | ce qui est douteux | ce qui a été lu | ce qui manque |
|---|---|---|---|
| `173c63baae24d7e7db9e2961bebd033f` | la durée de la formation exigée entre 3 500 et 4 250 kg de PTAC cumulé, que la carte ne chiffre pas (« une formation s'y ajoute ») | l'intitulé de l'arrêté du 17 janvier 2013, qui porte les deux bornes de poids mais pas la durée ; une relecture `WebFetch` de cette passe rapporte un article 2 fixant une durée de sept heures, quatre hors circulation et trois en circulation — non mise entre guillemets ici faute d'une seconde lecture pour la confirmer mot pour mot | une seconde source, ou une lecture directe du PDF de l'arrêté, pour confirmer ce chiffre avant de l'écrire dans la carte — une seule extraction assistée ne vaut pas la citation mot pour mot qu'exige `sources.md` ; le doute déjà signalé par la ligne de registre avant cette tâche est donc maintenu, avec cette piste en plus pour la passe suivante |

### Pédagogie

- explications sous 120 caractères : 3 à l'entrée, 0 à la sortie — `37fe1af42b8d81209e`
  (témoin rouge, 90→213), `37fe1af42b8d81b99c` (témoin orange, 80→202),
  `37fe1af42b8d81c89e` (éco-conduite, 96→253).
- cartes dont le budget de 220 a limité l'explication : aucune. L'unique illustrée
  (`2c0a147d9ba6e61b52c7639089b6f118`) était déjà à 175/220 avant cette tâche ; la réécriture
  (ajout d'une raison — « pour rester visible » — au feu de gabarit) l'amène à 190/220. Correction
  au rapport de première ronde : la formule « sans qu'aucune coupe n'ait été nécessaire »
  surclaimait — le même geste a compressé « un mètre » en « 1 m » pour faire de la place, une
  coupe réelle bien que sans effet sur le sens. Non touchée en fix round 1.
- énoncés reformulés parce qu'ils présupposaient la règle : aucun. Les 20 énoncés du domaine
  se lisent déjà sans connaître la réponse (aucun terme non introduit, aucune question qui ne
  se pose que pour qui sait déjà) ; relus un par un, aucun n'a été touché.
- carte `37fe1af42b8d81209e` (témoin rouge) et `37fe1af42b8d81b99c` (témoin orange) — la fuite
  croisée (le rouge donnait le sens de l'orange) a bien été coupée en première ronde, mais la
  revue a trouvé que ce qui restait labellisé « limite » dans les deux cas était en réalité une
  **réfutation de distracteur** (« sans attendre la fin du trajet », qui ne vise que l'option D
  du rouge) plutôt qu'une condition qui fait cesser la règle. Fix round 1 : le rouge porte
  maintenant une vraie limite (sur autoroute, gagner la bande d'arrêt d'urgence plutôt que
  s'arrêter sur une voie de circulation) ; l'orange, une vraie limite aussi (si le témoin se met
  à clignoter, l'anomalie s'aggrave et il faut s'arrêter — la règle « continuer prudemment »
  cesse alors de s'appliquer).
- `37fe1af42b8d8158a15ac34f4b0e4be9` (niveaux à surveiller) — l'ABS « aucun » d'origine
  (« aucun témoin n'alerte avant que le manque ne soit déjà installé ») avait été remplacé en
  première ronde par « aucun n'a de jauge continue au tableau de bord », qui reste faux sur les
  véhicules à jauge d'huile graduée à l'écran. Fix round 1 : « aucun n'a de jauge **sous les
  yeux du conducteur** comme le carburant » — vrai même sur ces véhicules, la lecture y étant un
  geste actif (menu, tige), jamais une aiguille en vue permanente. Le geste a laissé un reliquat
  de la formulation précédente (« et, contrairement au carburant, […] comme le carburant »,
  « carburant » cité deux fois pour le même contraste) : nettoyé en fix round 2, une seule
  mention.
- `37fe1af42b8d81c89e88db8c08ca8514` (éco-conduite) — trois passes. La « limite » de première
  ronde ne réfutait que les distracteurs A/D (accélérer fort, rapport bas), sans être une vraie
  condition ; corrigée en fix round 1 en ajoutant que le régime modéré cesse d'être économique
  s'il tombe trop bas pour la charge, ce qui force le moteur au lieu de l'économiser — ce
  correctif tient. Mais le même fix round 1 a introduit un second défaut en voulant traiter le
  distracteur C (« Rouler vitres ouvertes plutôt qu'en climatisant » — un demi-vrai, vrai en
  ville, faux sur route rapide, que l'énoncé « consiste **notamment** à » ne suffit pas à
  exclure) : la phrase ajoutée disait « la traînée coûtant plus sur route rapide que la
  climatisation, l'inverse en ville », ce qui **confirme** C sous la lecture ville — exactement
  le défaut de §1 règle 2 de `questions.md`, un distracteur partiellement vrai que l'énoncé ne
  rend pas faux. Fix round 2 : la nuance vitesse-dépendante est retirée sans être remplacée par
  une prise de position ; à la place, l'explication dit pourquoi le choix vitres/climatisation
  n'est de toute façon pas une **règle** d'éco-conduite fiable (le compromis dépend de la
  vitesse, contrairement à l'anticipation qui marche en toute circonstance) — ce qui explique
  l'écart avec B sans jamais affirmer que C serait juste quelque part.
- **Point 13 du calibrage — bonnes réponses invisibles à `--fuites`, cherchées à la main, refait
  en fix round 2 avec la bonne définition.** Le rapport de fix round 1 comptait les mots par
  simple séparation sur les espaces et ne trouvait qu'une carte sous le seuil : ce n'est pas ce
  que fait l'outil. `relire.py::mots()` normalise (accents retirés, minuscules), découpe en
  jetons `[a-z0-9]+`, ne garde que ceux d'au moins **cinq** caractères, et `fuites()` ignore
  toute bonne réponse dont ce sac compte **moins de trois** jetons. Refait avec cette définition
  sur les vingt bonnes réponses du domaine, six tombent sous le seuil :
  `37fe1af42b8d81deaec0cb8830fa0b25` (« 1,6 mm », 0 jeton), `173c63baae24d7e7db9e2961bebd033f`
  (« 4 250 kg de PTAC cumulés », 1 : `cumules`), `089e9b57f57bbb155f81da3ec492082f` (« de moins
  de dix ans », 1 : `moins`), `8e64074daad0e4a72e0fea2da9bac8eb` (« pour le conducteur d'un taxi
  en service », 2 : `conducteur`, `service` — `taxi` fait quatre caractères, sous le seuil de
  cinq), `6c9b9395e9090cd97a7fc4062b7162fc` (« à portée de main dans l'habitacle », 2 :
  `portee`, `habitacle`), `cc10180c491d12311f76fc1d4d98ff45` (« dans les six mois avant ses
  quatre ans », 2 : `avant`, `quatre`).

  Les six cherchées à la main dans les dix-neuf autres explications du lot (`grep`, script
  Python reproduisant `mots()`, puis lecture des occurrences trouvées) : cinq propres, une
  trouvée — déjà connue, la mutuelle `1,6 mm` / `139920` détaillée ci-dessous, corrigée dans les
  deux cartes. Les cinq autres ne réapparaissent nulle part ailleurs dans le domaine, **sauf**
  un mot isolé sans portée : « taxi » figure à la fois dans l'explication de
  `8e64074d…` (sa propre bonne réponse, normal) et dans celle de `089e9b57f…` (retenue
  enfant, « transporté en taxi ou en transport en commun », ajoutée en première ronde) — deux
  règles distinctes (dispense de ceinture du conducteur de taxi contre dispense de siège enfant
  pour l'enfant transporté en taxi) qui partagent un mot de vocabulaire, pas un sens ; les deux
  jetons qui comptent pour `8e64074d…` (`conducteur`, `service`) n'apparaissent pas dans
  l'explication de `089e9b57f…`. Documenté comme fortuit, non corrigé.

  Sur `37fe1af42b8d81deaec0cb8830fa0b25` (« 1,6 mm ») : elle apparaissait en entier, chiffre
  compris, dans l'explication de sa voisine `37fe1af42b8d81139920e49f3f7b6b59` (témoin d'usure)
  — recouvrement doublement invisible à `--fuites` (moins de trois jetons **et** hors du champ
  qu'un simple compte de mots pleins aurait repéré). La réciproque était vraie en d'autres mots :
  l'explication de `81deae` disait « le témoin d'usure […] est placé exactement à ce niveau »,
  soit la réponse de `139920` (« la limite légale de profondeur ») paraphrasée. Le rapport de
  première ronde affirmait « une relecture à la main n'en trouve pas d'autre » : le fichier le
  contredisait. Les deux cartes réécrites : `139920` porte maintenant une vraie raison (pourquoi
  le seuil compte — l'eau qui ne s'évacue plus) sans réciter le chiffre ; `81deae` a perdu la
  phrase qui nommait le témoin d'usure. `grep -c "1,6 mm" Valido/Resources/questions.json`
  limité aux deux cartes confirme une seule occurrence restante, sur `81deae` elle-même.
- `37fe1af42b8d814ba731d0f9dafb6945` (frein moteur en descente) — « Au point mort ou contact
  coupé, on perd ce frein — et l'assistance de direction » se lisait, au distributif, comme
  perdant l'assistance de direction dès le point mort seul, ce qui est faux (le moteur tourne
  encore). Corrigé : « Au point mort, on perd ce frein moteur ; contact coupé, on perd en plus
  l'assistance de direction » — les deux conséquences rattachées chacune à sa cause.
- `37fe1af42b8d814289adf64bd5b05d0e` (équipements de sécurité) — deux défauts. La « limite »
  listait ce que d'autres options proposent (extincteur, trousse, éthylotest), donc réfutait des
  distracteurs plutôt que de poser une condition ; et « ne sont pas exigés sur une voiture
  particulière » affirmait une négative sur tout le droit français quand la ligne de registre ne
  couvre que leur absence de R416-19. Réécrit avec une vraie limite, déjà dans l'affirmation
  mais absente de la carte : le gilet doit être **revêtu**, pas seulement présent, dès qu'on
  descend sur la chaussée — le triangle, lui, n'a que l'obligation de présence. Et « n'y figurent
  pas » remplace la négative généralisée, exactement à la portée de la ligne de registre.
- `204454d0e329d40811d4317fabf2ddfa` (huile et batterie usagées) — même défaut de labellisation :
  la « limite » de la revue initiale ne faisait que réfuter les distracteurs (tri sélectif,
  ferrailleur non agréé). La ligne de registre porte pourtant une vraie limite, déjà écrite mais
  non exposée dans la carte : le régime du particulier (L541-2) n'est pas celui du professionnel,
  qui relève de R543-3. Ajoutée à l'explication, sans toucher `sources.md` puisque le fait y
  était déjà.
- `089e9b57f57bbb155f81da3ec492082f` (retenue enfant) — la revue a relevé que l'explication ne
  nommait que deux des trois dispenses de R412-2 III (adaptée à la ceinture, taxi/transport en
  commun), le certificat médical restant absent alors que la place le permettait. Pas trompeur
  (aucun « seulement »), mais incomplet ; la troisième dispense a été ajoutée.

**Preuve par carte, pour les 8 cartes non modifiées** — règle / raison / limite telles que la
carte les dit :

| id | rôle | règle / raison / limite |
|---|---|---|
| `173c63baae24d7e7db9e2961bebd033f` | catégorie B + remorque | règle (« les deux PTAC additionnés n'excèdent pas 4 250 kg ») + limite explicite (« au-delà, il faut le permis BE » ; « Entre 3 500 et 4 250 kg avec une remorque de plus de 750 kg, une formation s'y ajoute ») ; pas de raison physique à un seuil de catégorie administrative |
| `37fe1af42b8d8123abc0da9b2b7a51e0` | vignette Crit'Air | règle (classement selon motorisation, norme d'émission, date de première immatriculation) + raison implicite (base de lecture des restrictions) + limite explicite, la clé du domaine ZFE : « dont le périmètre relève d'un arrêté local ». Carte inchangée en fix round 1 ; seule sa ligne de registre a bougé (voir écart ci-dessus) |
| `37fe1af42b8d81f4b915cd58b951d9e4` | pression des pneus | règle (à froid) + raison explicite (l'air chauffe en roulant, fausse lecture à chaud) + limite explicite (« si on ne peut pas faire autrement », correction de +0,3 bar) |
| `4477774964dae6e5d1bac49b5a37f3a8` | équipement hivernal (loi Montagne) | règle (pneus hiver ou chaînes, au choix) + limite explicite doublement locale/nationale (le choix est national, D314-8 ; « Quelles communes sont concernées […] dépend d'un arrêté préfectoral ») — même garde-fou que la carte Crit'Air |
| `526d6b502e05eefba3f2066af4c2ab8d` | galerie de toit sur autoroute | règle (traînée d'air) + raison explicite (croît avec le carré de la vitesse) + limite explicite (« Vide, elle coûte encore, mais moins » — réfute directement le distracteur qui prétend le contraire) |
| `8e64074daad0e4a72e0fea2da9bac8eb` | dispenses de ceinture | règle (liste fermée de R412-1) + limite explicite (« La grossesse n'y est pas — il y faut un certificat ») ; raison portée par le mot « fermée » lui-même |
| `cc10180c491d12311f76fc1d4d98ff45` | premier contrôle technique | règle (quatre ans puis tous les deux ans) + limite explicite (deux mois de contre-visite après une défaillance majeure, seul point du domaine à ne reposer que sur un rang 2 — `service-public` F2878 — la ligne de registre le dit déjà, aucune action) ; pas de raison physique à une cadence réglementaire |
| `eac980f55eb23bfd3b1612f506fb81a3` | siège enfant dos à la route à l'avant | règle (admis si l'airbag est désactivé) + raison explicite (« la tête se trouve juste devant le coussin gonflable ») + limite explicite (« À l'arrière, la question ne se pose pas ») |

Douze cartes modifiées au total, les six de première ronde plus six trouvées par la revue —
`2c0a147d9ba6e61b52c7639089b6f118` (chargement, raison ajoutée), `089e9b57f57bbb155f81da3ec492082f`
(retenue enfant, écart de justesse puis troisième dispense complétée), `37fe1af42b8d81209e`
(témoin rouge, fuite coupée puis vraie limite), `37fe1af42b8d81b99c` (témoin orange, idem),
`37fe1af42b8d81c89e` (éco-conduite, vraie limite puis distracteur confirmé par erreur puis corrigé), `37fe1af42b8d8158a1`
(niveaux à surveiller, absolu corrigé deux fois), `37fe1af42b8d81139920` (témoin d'usure, vraie
raison sans le chiffre), `37fe1af42b8d81deae` (profondeur pneus, cross-référence coupée),
`6c9b9395` (gilet, distracteur remplacé), `37fe1af42b8d814ba7` (frein moteur, lecture
distributive corrigée), `37fe1af42b8d814289` (équipements, vraie limite et négative resourcée),
`204454d` (huile et batterie, vraie limite exposée) — modifiées 12 + non modifiées 8 = 20, sans
reste.

**Les options.** Relues carte par carte contre les sept règles du §2 de `questions.md`, puis une
deuxième fois contre le point 14 du calibrage (« existe-t-il une lecture où le distracteur EST la
bonne réponse ? »). C'est cette deuxième passe qui a trouvé le défaut réel du domaine : sur
`6c9b9395e9090cd97a7fc4062b7162fc` (gilet), le distracteur B disait « dans la boîte à gants du
passager », qui **est** dans l'habitacle et à portée de main — un cas particulier de la bonne
réponse (« à portée de main dans l'habitacle »), pas une réponse fausse, et l'explication ne
réfutait que le coffre, ce qui le légitimait au lieu de l'écarter. Remplacé par « sous la
banquette arrière, qu'il faut soulever » — dans l'habitacle mais non atteignable en conduisant,
donc non un cas particulier de C — en évitant délibérément le mot « portée » pour ne pas
fabriquer une paire d'inverses avec la bonne réponse. Sur les chiffres de distracteur : à
reformuler honnêtement plutôt qu'à se contredire soi-même, comme la première ronde l'a fait pour
`173c63ba` (masses 3 500 / 5 000 / 4 750 kg) — 3 500 kg est le vrai seuil B/C1, mais 5 000 et
4 750 kg ne correspondent à aucun seuil nommé du droit routier : ce sont des valeurs plausibles
qui encadrent la vraie borne (4 250 kg) par pas de quelques centaines de kilos, pas des seuils
réels recyclés, et le rapport le dit maintenant sans se contredire dans la même phrase. Les
profondeurs de pneu (0,5 / 5 / 3 mm) restent dans l'ordre de grandeur réel du sujet — l'arrêté
cité par la carte porte lui-même une tolérance de +0,6/-0 mm autour du seuil, et 3 mm est le
seuil de remplacement que conseillent les manufacturiers. Aucun distracteur éliminable par la
forme de son propre énoncé : les options de chaque carte partagent un même patron grammatical.
Aucun distracteur que la carte légitime elle-même, hors le cas corrigé ci-dessus.
`correctID` réparti sur les vingt cartes avant cette tâche (A 2, B 6, C 7, D 5) et inchangé,
aucune option n'ayant été réordonnée — le remplacement de B sur `6c9b9395` ne touche pas C.

**Recouvrement structurel documenté, non corrigé — raison corrigée en fix round 2.**
`6c9b9395e9090cd97a7fc4062b7162fc` (gilet) et `37fe1af42b8d814289adf64bd5b05d0e` (équipements)
se recoupent par les **options**, un angle mort de `--fuites` qui ne regarde que les
explications : l'option A du gilet nomme « le triangle » au grand jour, ce qui prévient une
bonne part de la réponse d'« équipements » (triangle + gilet, contre extincteur/trousse,
trousse/couverture, éthylotest/ampoules). La revue a raison de le relever : la justification
donnée en fix round 1 — le point 11 du calibrage interdirait d'affaiblir une phrase vraie pour
satisfaire un outil — ne tenait pas ici, puisqu'un correctif sans coût existe (reformuler le
distracteur de mauvaise localisation du gilet sans nommer le triangle ; « dans le coffre, sous
les bagages » porterait le même défaut sans la fuite). Le recouvrement reste néanmoins non
corrigé, pour la raison qui tient réellement : c'est un contenu antérieur à cette tâche, les
deux réponses restent correctes et défendables, et rien dans le périmètre de la tâche 6
n'imposait d'y toucher — laissé pour une passe de consolidation plutôt que retouché ici sur un
motif inventé après coup.

**Ce que `couverture.md` dit manquer.** La ligne du domaine porte le verdict « à compléter »,
seul des treize à ne pas être `couvert` : sur les 20 cartes, six seulement portent vraiment la
thématique officielle « Économie et écoconduite » (éco-conduite, frein moteur, galerie de toit,
pression des pneus, Crit'Air, huile et batterie usagées) — les quatorze autres sont des
équipements, du chargement et de la retenue des enfants, logés ici faute de thématique dédiée
dans le référentiel ETG. Cette tâche ne change pas ce compte : elle réécrit les vingt cartes
existantes, elle n'en ajoute aucune. Ce que `couverture.md` propose pour combler l'écart —
consommation et vitesse, arrêt du moteur, entretien et rejets, choix du rapport — reste hors
périmètre d'une passe qui n'ajoute pas de contenu.

### Mouvements d'`audit.py`

| sortie | avant (2026-08-27, début de tâche) | après (fix round 1) |
|---|---|---|
| `lettre/reference` | 1 | 1 |
| `forme/markdown` | 1 | 1 |
| `forme/seule-ponctuee` | 14 | 14 |
| `longueur/plus-longue` | 95 | 95 |
| `expl/paraphrase-litterale` | 17 | 17 |
| `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10`, `forme/backtick-isole` | vides | vides |

Diff vide contre la ligne de base d'avant tâche, aux trois rondes. Aucune des douze cartes
modifiées ne touche l'équilibre de longueur d'une manière qui ferait bouger `longueur/plus-longue`
— y compris le remplacement d'option sur `6c9b9395` (A 31, B 46, C 33 — la bonne réponse —, D 36).
Elle n'est pas la plus longue, ce qui suffit à ne déclencher aucun flag ; elle n'est pas non plus
la plus courte, contrairement à ce qu'affirmait le rapport de fix round 1 — A l'est de deux
caractères, corrigé ici en fix round 2. `--fuites "Mécanique & environnement"` : 0 recouvrement
sur 20 cartes, mesuré avant édition (par `git stash` temporaire), après chaque ronde. `--fuites`
sur les quatre domaines déjà clos, revérifié à chaque ronde : 0 sur « Permis & sanctions »,
« Vitesse » et « Alcool & stupéfiants » ; 1 recouvrement incidental, inchangé et déjà documenté,
sur « Usagers & partage de la route ».

## Distances & freinage

21 cartes, 10 `datée`, 0 illustrée(s).

### Écarts de justesse trouvés

Aucun écart de justesse (valeur périmée, règle trop large, explication au-delà de
l'article) trouvé sur les 21 cartes. La seconde passe (`4a5dcfe Distances: sort the
normative from the pedagogical`) avait déjà fait, pour ce domaine précisément, le
travail que cette tâche s'apprêtait à refaire : trier le modèle pédagogique de la norme
(préface de `sources.md`, paragraphe « Un chiffre normatif et un ordre de grandeur
pédagogique ne se sourcent pas pareil »), reclasser en `stable` **assumé** les cinq
valeurs sans aucun texte possible (temps de réaction d'une seconde, règle du chiffre
des dizaines × 3, doublement du freinage sur sol mouillé, doublement à la vitesse au
carré, repère des deux bandes de peinture), et relever mot pour mot par `WebFetch` les
quatre chiffres normatifs (R412-12 I et II, R421-3, R421-7). Les 21 cartes ont été
relues clause par clause contre leur ligne — chaque condition de champ d'application
(« dans l'année suivant une condamnation définitive », « hors agglomération », « plus de
3,5 tonnes ou plus de 7 mètres », « sauf nécessité absolue », « téléphone tenu en main »)
est présente dans l'énoncé ou l'explication, jamais élargie — sans en trouver un seul.
Les cinq cartes portant un absolu (`ABS jamais/interdit/doit`) ont chacune été
confrontées à sa ligne : dans les cinq cas l'absolu reproduit une citation mot pour mot
de l'affirmation (« il n'est jamais égal à zéro », « est interdit », « doit céder le
passage », « est interdite »), aucun n'élargit la règle.

**Ce que la justesse ne couvrait pas.** La revue de première ronde a montré que ce
constat, vrai pour la justesse, ne s'étendait pas au critère 3 (rule/reason/limite) ni
à la précision de mes propres citations. Deux nuances, pour ne pas répéter la même
surclaim :

- Les guillemets de `sources.md` relus pour ce domaine se ferment sur des **propositions
  complètes** — pas nécessairement sur des phrases entières de l'article. C'est ce que
  j'ai vérifié (aucune clause tronquée entre deux virgules, comme sur `Usagers`), pas une
  garantie que toute citation ferme une phrase de l'article : les deux ne sont pas la
  même chose, et seule la première a été contrôlée systématiquement.
- Sourcer une valeur est une chose ; l'écrire dans une carte qui enseigne — rule, reason,
  **et** limite, sur les trois champs — en est une autre. Le fix round 1 ci-dessous porte
  entièrement là-dessus.

### Doutes signalés, non corrigés

Aucun doute nouveau. Le seul point resté ouvert par la ligne de registre —
l'entrecroisement autoroutier, écarté de `a225e45864e11748d6175d67476529d0` faute de
source de rang 1 — est une décision déjà prise et déjà expliquée dans `sources.md`, pas
un doute que cette relecture aurait laissé en suspens.

### Pédagogie

- explications sous 120 caractères : 0 à l'entrée, 0 à la sortie. Le domaine part
  d'explications déjà étoffées (médiane 332 caractères) ; le gain de cette tâche porte
  sur les options, pas sur l'allongement d'un texte déjà substantiel.
- cartes dont le budget de 220 a limité l'explication : aucune, le domaine ne porte
  aucune illustrée.
- énoncés reformulés parce qu'ils présupposaient la règle : aucun. Les 21 énoncés se
  lisent déjà sans connaître la réponse (mise en situation ou question fermée, tous les
  termes introduits) ; relus un par un, aucun n'a nécessité de reformulation.

**Round 0 — deux cartes modifiées, sur les options, pas sur la justesse :**

- `0e85e6a79127a2bae73abcc119e278bd` (tunnel, seconde infraction) — le distracteur A
  affirmait « une contravention de cinquième classe, 200 € dus ». 200 € ne correspond à
  aucun montant réel du barème routier (contraventions forfaitaires : 35 € (2e classe),
  68 € (3e classe), 135 € (4e classe, tarif normal) ; le 375 € qui sert de distracteur sur
  `…81e7a0` dans ce même lot est le forfait **majoré** de cette même 4e classe, pas un
  palier distinct du barème. Au-delà, la 5e classe n'a pas de forfait et son plafond
  judiciaire est de 1 500 €, art. 131-13 5° du code pénal,
  « 1 500 euros au plus », version en vigueur depuis le 01/04/2005, relevé par `WebFetch`
  le 2026-08-27). Corrigé en « une contravention de cinquième classe, jusqu'à 1 500 € » :
  le distracteur reste faux (ce n'est pas une contravention mais un délit), mais son
  chiffre est désormais réel plutôt qu'inventé — le défaut nommé au point 2 du calibrage
  (« Vitesse » et « 45 / 120 km/h », « Alcool » et « 150 € »). Aucune ligne de
  `sources.md` à toucher : un distracteur affirmé faux n'a pas besoin de ligne, et
  celui-ci ne recycle pas un chiffre pris ailleurs dans la banque — sa source est donc
  portée ici plutôt que dans le registre.
- `37fe1af42b8d81e7a041ff53b8ef69c2` (non-respect des distances, sanction) — réglé le
  doublon inter-domaines détaillé plus bas.

**Fix round 1 — six cartes de plus, sur le critère 3 et sur les options, aucune sur la
justesse.** La revue a trouvé deux cartes qui échouaient franchement au critère 3 malgré
une justesse intacte (calibrage point 1, exactement le défaut qui a coûté à
`Permis & sanctions`), deux options non traitées lors du premier passage (point 2, la
« umbrella sentence »), et un compte de fuites refait à la main avec la bonne définition
(point 13) :

- `37fe1af42b8d817eb292c10d8effbad4` (composition de la distance d'arrêt) — l'explication
  entière tenait en une phrase : « C'est pourquoi tout ce qui allonge le temps de
  réaction […] allonge la distance d'arrêt sans que le freinage n'y change quoi que ce
  soit. » Trois défauts dans cette seule phrase : la règle n'y était jamais énoncée (elle
  ne vit que dans l'option D) ; « C'est pourquoi » n'avait donc pas d'antécédent dans le
  texte lui-même ; et il n'y avait pas de limite — à 164 caractères, la plus courte du
  domaine, exactement le profil que le seuil `COURTE` (120) laisse passer. Réécrite en
  trois temps : la règle d'abord (« La distance d'arrêt additionne ce que le conducteur
  parcourt en réagissant et ce qu'il parcourt en freinant »), la raison déjà présente
  (fatigue/téléphone/alcool), puis une vraie limite tirée de deux faits déjà affirmés
  ailleurs dans le domaine — la réaction croît comme la vitesse, le freinage comme son
  carré (`37fe1af42b8d812c9b…`) — donc leur poids relatif s'inverse : réaction dominante à
  faible allure, freinage dominant au-delà. Aucun fait nouveau, `sources.md` note
  seulement la réécriture.
- `a225e45864e11748d6175d67476529d0` (insertion depuis une bretelle) — trois défauts :
  **pas de raison** (ma table de première ronde écrivait « raison implicite », ce qui
  n'est pas une raison écrite sur la carte — calibrage point 1, une carte honnêtement
  « raison absente » vaut mieux que forcée en conforme) ; **le distracteur D inclus dans
  la bonne réponse** — « cédez le passage, quitte à vous arrêter sur la bretelle »
  contient l'affirmation de C et n'ajoute qu'une manière de l'exécuter (point 14 : qui
  cède le passage en s'arrêtant a bien cédé le passage), et l'explication ne l'excluait
  qu'implicitement (« reste à utiliser toute la voie d'accélération »), la même forme que
  la boîte à gants sur `Mécanique` ; et **une fuite vers une carte du même lot** — « un de
  plus que le non-respect des distances » donnait le nombre exact de points de
  `37fe1af42b8d81e7a0…` (options 0/1/3/6) sans rien à savoir d'autre, invisible à
  `--fuites` puisque l'outil ne regarde que le sens de fuite carte-vers-réponse-externe,
  pas les comparaisons numériques internes. Réécrite : une raison (« le flot déjà engagé
  roule à pleine vitesse et ne peut ni s'arrêter ni se déporter ») ; une vraie réfutation
  de D, sourcée par renvoi plutôt que répétée — l'arrêt sur la bretelle reste interdit par
  R421-7 (ligne de `aad60a7453493cc671…`), comme sur toute chaussée autoroutière, sauf
  nécessité absolue ; et la comparaison de points supprimée, remplacée par le chiffre
  brut (135 €, quatre points) sans comparaison.
- `37fe1af42b8d81e7a041ff53b8ef69c2` (sanction des distances) — **round 2 de la même
  carte** : l'option correcte réécrite en round 0 (« 135 € d'amende et 3 points de
  moins » → « 135 € d'amende, 3 points et suspension possible ») était à +10 caractères du
  distracteur le plus long — un caractère sous `longueur/plus-10`, qui doit rester vide,
  et surtout la bonne réponse la plus longue des quatre, le tell le plus fiable d'un QCM
  (§1 de `questions.md`). Raccourcie à « 135 €, 3 points et suspension possible »
  (38 caractères, +1). Minor du round de revue traité dans le même geste : l'explication
  ne disait pas que la suspension, contrairement à l'amende et aux points, est une
  **peine complémentaire** qui exige un juge — c'est exactement ce que « possible »
  signale dans l'option, et l'explication le dit maintenant, avec la citation exacte du
  VI relevée par `WebFetch` (« la peine complémentaire de suspension […] cette suspension
  pouvant être limitée à la conduite en dehors de l'activité professionnelle »).
- `f376d218b64a41796d6efebc8ad0bb2d` (plancher poids lourds) — options traitées pour la
  première fois (la « umbrella sentence » du round 0 ne nommait que deux cartes). Le
  distracteur A, « au moins 100 mètres entre eux », ne correspond à aucun seuil réel du
  domaine — ses voisins B (« les deux secondes, rien de plus ») et C (« une longueur de
  semi-remorque ») sont, eux, de vraies confusions. Remplacé par « au moins 7 mètres entre
  eux », qui recycle le seuil de longueur du II lui-même, déjà sur cette ligne (« ou dont
  la longueur dépasse 7 mètres ») : la confusion entre le critère d'application (la
  longueur du véhicule) et la distance à tenir est une confusion réelle, pas un chiffre
  inventé, et elle ne crée aucune fuite nouvelle (ce chiffre n'est la bonne réponse
  d'aucune autre carte du domaine).
- `aad60a7453493cc6716b731af7579ebc` (arrêt sur la BAU) — minor du round de revue : « Les
  135 € et les 3 points existent bel et bien, mais pour l'article R412-8 » se lisait
  comme si R412-8 était seul à porter ce barème, alors que R412-12 V/VII (distances de
  sécurité, même lot) le porte aussi. Incise ajoutée — « comme pour le non-respect des
  distances de sécurité » — en renvoi vers la ligne de `37fe1af42b8d81e7a0…`, sans
  répéter son chiffre.
- `a4f04a8078a925fbc8c5df10f063e065` (circulation sur la BAU) — minor du round de revue :
  la carte n'avait de limite que par contraste avec sa voisine (« à comparer avec
  R421-7 »), pas de limite à elle. Ajoutée : R432-1 dispense les véhicules d'intérêt
  général prioritaires (police, gendarmerie, secours, SAMU) de cette interdiction
  « lorsqu'ils font usage de leurs avertisseurs spéciaux dans les cas justifiés par
  l'urgence de leur mission et sous réserve de ne pas mettre en danger les autres
  usagers de la route », version en vigueur depuis le 01/06/2001, relevé mot pour mot par
  `WebFetch`. Effet de bord découvert en revérifiant les fuites (voir plus bas) : la
  phrase qui portait cette limite reprenait aussi « suspension […] possible » et
  « points », qui recouvraient en entier la nouvelle bonne réponse de `…81e7a0` — reformulée
  (« peut s'y ajouter ») sans perte de sens, pour ne garder que le recouvrement fortuit
  déjà documenté plus bas.
- `8ddd0cebb28376040af43feb6f52c098` (secondes plutôt que mètres) — minor du round de
  revue : « Un nombre de mètres, lui, vaudrait autant à 30 qu'à 130 km/h » est la raison
  reformulée, pas une limite. Ajoutée : le principe n'est pas absolu, le II du même
  article fixe malgré tout un plancher en mètres pour les poids lourds hors
  agglomération — renvoi à la ligne de `f376d218b64a41796d…`, sans répéter son texte.

### Preuve par carte, pour les 13 cartes non modifiées

Huit cartes ont rejoint la liste des modifiées entre le round 0 et le fix round 1 (voir
« Pédagogie » ci-dessus) ; il en reste treize dont le contenu n'a pas bougé. Règle /
raison / limite telles que la carte les dit :

| id | rôle | règle / raison / limite |
|---|---|---|
| `22e6420e179103f65f7935f717521189` | vent latéral à la sortie d'un tunnel | règle (« ralentissez avant la sortie, volant tenu ferme ») + raison (« c'est là que la rafale surprend, et qu'elle déporte le plus ») + limite (qui est le plus exposé : « les deux-roues et les véhicules à grande surface latérale ») |
| `2362d0ebc53cb6de0732afe1747e9b58` | repère au sol de l'intervalle | règle (deux bandes de peinture ≈ 90 m) + raison (géométrie IISR, 39 m de trait pour 13 m de vide) + limite explicite, la clé du modèle (« un repère d'enseignement […] pas une règle du code — la règle, elle, se compte en secondes » ; « sur une bretelle, la modulation change ») |
| `36d598b80e93b695b2994fce6172eb50` | neige ou verglas | règle (« espacez fortement, sans geste brusque ») + raison (« l'adhérence s'effondre […] chaque ordre brusque consomme le peu de prise qui reste ») + limite (« des pneus hiver améliorent la prise, ils ne la rendent pas normale ») |
| `37fe1af42b8d8104b119f947eb9e296d` | distance de réaction à 50 km/h | règle (14 m) + raison (13,9 m parcourus par seconde) + limite (« un ordre de grandeur d'enseignement, jamais une valeur du code, et qui ne descend jamais à zéro ») |
| `37fe1af42b8d811f9954e63cf1aa9ffa` | règle des dizaines × 3 | règle (× 3) + raison (calcul détaillé, 50 → 15 m, 90 → 27 m) + limite (« majore un peu la réalité […] c'est un moyen de calcul de tête, pas une règle écrite dans un texte ») |
| `37fe1af42b8d812c9bb4e393d72d6df0` | doublement de la vitesse et freinage | règle (× 4) + raison (« la distance de freinage croît comme le carré de la vitesse ») + limite (« c'est de la physique, pas une règle du code ») |
| `37fe1af42b8d812db558cb9e19e11709` | intervalle de sécurité (R412-12 I) | règle (« deux secondes, dit le premier alinéa ») + raison (repère fixe, un intervalle en secondes suit la vitesse) + limite explicite (distingue la prudence — allonger sur chaussée mouillée — de l'obligation légale : « même si le texte ne l'exige pas ») |
| `37fe1af42b8d815a8de7c20835afd6ac` | intervalle en mètres à 130 km/h | règle (72 m) + raison (36 m/s) + limite explicite (« il ne faut pas confondre cet intervalle avec la distance d'arrêt, qui approche 130 mètres ») |
| `37fe1af42b8d81e48a72e74c9a2454a2` | freinage sur sol mouillé | règle (augmente, adhérence en moins) + raison (adhérence divisée par deux) + limite explicite (« un modèle d'enseignement, pas un chiffre du code » ; réfute directement le distracteur ABS : « l'ABS […] n'empêche […] rien retirer à la distance ») |
| `37fe1af42b8d81e98af3c07ec3728454` | temps de réaction moyen | règle (1 seconde) + raison (percevoir, traiter, décider ; dégradé à deux par fatigue/alcool/téléphone) + limite (« une moyenne d'enseignement, pas une valeur inscrite dans un texte ») |
| `37fe1af42b8d81ef84ffe4578802422a` | fatigue ou téléphone | règle (allongent nettement la réaction) + raison (une longueur de voiture tous les 15 km/h, freinage inchangé) + limite explicite du champ d'application de la sanction (« le téléphone **tenu en main** […] interdit » — pas l'usage mains libres) |
| `4ade42a7e2c69ec43159940235d08c5f` | aquaplanage | règle (lever le pied, sans freiner ni braquer) + raison (les pneus ne guident plus rien, l'ordre donné s'applique brutalement au retour du contact) + limite (« jusqu'à ce que les sculptures reprennent l'eau ») |
| `9f0fe6e809948a327c918ac0b5987cf9` | ABS en freinage d'urgence | règle (appuyer d'un coup, maintenir) + raison (l'ABS empêche le blocage, la pédale n'a plus besoin d'être relâchée) + limite explicite, contre l'idée reçue (« il ne raccourcit pas la distance de freinage — il conserve la direction ») |

Modifiées 8 (2 en round 0, 6 en fix round 1) + non modifiées 13 = 21, sans reste. Cinq
des treize non modifiées ont vu leurs options **tourner** pour rééquilibrer `correctID`
(voir plus bas) : la rotation ne change aucun texte, seulement la lettre qui le porte,
et n'est donc pas comptée comme une modification de contenu.

### Les options

Relues carte par carte contre les sept règles du §2 de `questions.md`, puis contre le
point 14 du calibrage (« existe-t-il une lecture où le distracteur EST la bonne
réponse ? »). Deux paires recyclent délibérément le vrai chiffre l'une de l'autre comme
distracteur — `a4f04a8078a9…` (R412-8, circulation sur la BAU, 135 €/3 points) et
`aad60a7453…` (R421-7, arrêt sur la BAU, 35 €/0 point) — c'est le « rapport de quatre »
que la ligne de registre nomme comme raison d'être de la paire, pas un chiffre inventé.
Le fix round 1 a traité les deux cas que la revue a nommés et qu'un premier passage avait
laissés de côté : le distracteur D de `a225e45864e11748d6…` (inclus dans C, voir
« Pédagogie ») et le distracteur A de `f376d218b64a41796d…` (« 100 mètres », sans seuil
réel, voir « Pédagogie »). Aucun autre distracteur du lot n'a paru, à cette seconde
lecture, éliminable par pure logique, isolé par la forme, ou légitimé par sa propre
carte.

**Une observation non corrigée, pour une passe suivante.** Le distracteur D de
`…81e7a0`, « 375 € d'amende et 6 points de moins », associe un montant réel —
375 € est le forfait majoré de la 4e classe, voir « Pédagogie » — à un nombre
de points qui ne correspond pas de façon évidente à cette classe (6, quand le
barème du domaine reste à 3 pour la 4e classe partout ailleurs sur ce lot).
Repéré au fix round 2, non modifié ici : hors des constats de cette ronde, et
l'option reste fausse par ailleurs (ce n'est ni le montant ni le nombre de
points de l'infraction) ; signalé pour la prochaine passe plutôt que corrigé au
jugé.

**`correctID` — rééquilibré ce round.** Mesuré au début de la tâche (round 0, avant toute
édition) : A 3, B 5, C 3, D 10, un total biaisé vers D que le rapport de round 0
qualifiait, à tort, de hors périmètre puisqu'aucune *édition* ne l'avait produit. La
revue a corrigé cette lecture : `Tools/questions.md` §1 pose la règle sur le **fichier**
(« un fichier où la réponse est toujours A est suspect »), pas sur les seules éditions,
et prescrit le remède dans la même phrase — tourner les textes des options,
cycliquement, sans effet sur le contenu. Fix round 1 : cinq des dix cartes `D` ont
tourné (`22e6420e179103f65f…`, `2362d0ebc53cb6de07…` d'un cran ; `37fe1af42b8d811f99…` de
deux ; `37fe1af42b8d812db5…`, `37fe1af42b8d815a8d…` de trois), les cinq autres restant
`D` sans y toucher. Chaque rotation vérifiée par script : même quatre textes, seule la
lettre correcte change, et le nouvel écart de longueur (bonne réponse contre distracteurs)
recalculé pour chacune — toutes négatives ou nulles, aucune ne s'approche de
`longueur/plus-10`. Résultat : A 5, B 6, C 5, D 5, sur 21 — plus la répartition
attendue de 5,25 par lettre que ne l'était 3/5/3/10.

### Le doublon inter-domaines

`37fe1af42b8d81b7acdacd2079297f09` (« Permis & sanctions », ceinture) et
`37fe1af42b8d81e7a041ff53b8ef69c2` (« Distances & freinage », distances de sécurité)
partageaient mot pour mot la même bonne réponse : « 135 € d'amende et 3 points de
moins ». Les deux valeurs sont réelles et bien sourcées (R412-1 III/IV pour la
ceinture, R412-12 V/VII pour les distances : même classe, même retrait) — ce n'est pas
un chiffre inventé, c'est une coïncidence de barème entre deux infractions distinctes.
Le risque n'est pas la fausseté mais l'apprentissage d'une phrase plutôt que d'une
règle : qui voit les deux cartes apprend « 135 € et 3 points » comme un motif qui
revient, pas pourquoi chacune des deux règles existe.

`Permis & sanctions` est clos ; le mouvement se fait donc côté `Distances & freinage`,
et une différence de substance existe réellement : la ligne de registre de la ceinture
(relue le 2026-08-27, `WebFetch` mot pour mot) ne porte **aucune** suspension de
permis — seulement l'amende et les trois points. La ligne des distances, elle, porte en
plus la peine complémentaire de suspension « pour une durée de trois ans au plus » (VI
de R412-12). La correction porte donc ce fait déjà affirmé dans l'option elle-même
plutôt que de le laisser dans la seule explication : « 135 € d'amende, 3 points et
suspension possible » en round 0. Round 1 l'a raccourcie une seconde fois — « 135 €,
3 points et suspension possible » (38 caractères, +1 sur le distracteur le plus long,
contre +10 en round 0, qui frôlait `longueur/plus-10`) — sans rien retirer au fait
distinctif. Aucune ligne de `sources.md` à toucher pour le doublon lui-même : le fait
était déjà affirmé, seul son emplacement dans la carte a changé.
`grep -c "135 € d'amende et 3 points de moins" Valido/Resources/questions.json`
ne retrouve plus qu'une occurrence, sur la carte « Permis & sanctions » — inchangée,
comme demandé.

### Fuites — vérification à la main, avec la vraie définition de l'outil

`relire.py --fuites` ne regarde qu'une bonne réponse d'au moins **trois mots pleins**
(jetons `[a-z0-9]+` d'au moins cinq caractères, après minuscule et suppression des
accents). Sur les 21 bonnes réponses du domaine (mesurées en round 0, avant toute
édition), **huit** tombaient sous ce seuil :

| id | bonne réponse | mots pleins (≥ 5 car.) | n |
|---|---|---|---|
| `2362d0ebc53cb6de0732afe1747e9b58` | « deux bandes de la ligne de rive » | `bandes`, `ligne` | 2 |
| `37fe1af42b8d8104b119f947eb9e296d` | « 14 m » | — | 0 |
| `37fe1af42b8d811f9954e63cf1aa9ffa` | « 3 » | — | 0 |
| `37fe1af42b8d812c9bb4e393d72d6df0` | « 4 » | — | 0 |
| `37fe1af42b8d812db558cb9e19e11709` | « 2 secondes » | `secondes` | 1 |
| `37fe1af42b8d815a8de7c20835afd6ac` | « 72 m » | — | 0 |
| `37fe1af42b8d81e98af3c07ec3728454` | « 1 seconde » | `seconde` | 1 |
| `a4f04a8078a925fbc8c5df10f063e065` | « interdit, et puni de 135 € et 3 points » | `interdit`, `points` | 2 |

**Round 0 avait sous-compté : les greps ne portaient que sur les explications, jamais
sur les énoncés, et deux motifs avaient été cherchés de façon incomplète.** Repris en
fix round 1 sur les deux champs à la fois (`grep` sur les 21 ÉNONCÉ et EXPL de
`.passe3/lot-07.txt`) :

```
$ grep -n "bandes de\|deux bandes" .passe3/lot-07.txt
$ grep -n "14 m\|quatorze\|13,9\|13,88" .passe3/lot-07.txt
$ grep -n "dizaines\|trois fois\|multipli.*trois" .passe3/lot-07.txt
$ grep -n "quadruple\|multipli.*quatre\|carré de la vitesse\|quatre fois" .passe3/lot-07.txt
$ grep -n "deux secondes\|2 secondes" .passe3/lot-07.txt
$ grep -n "72 m\|soixante-douze" .passe3/lot-07.txt
$ grep -n "une seconde\|1 seconde\|(1 s)" .passe3/lot-07.txt
$ grep -n "135 €\|3 points" .passe3/lot-07.txt
```

Compte corrigé, par bonne réponse sous le seuil :

- **« une seconde » / « 1 seconde »** (temps de réaction moyen, `…81e98a`) : **trois**
  occurrences hors sa propre carte, pas une seule. Round 0 n'avait vu que l'explication
  de `…8104b1` (« La Sécurité routière retient une seconde comme moyenne… »). Le grep sur
  les deux champs en trouve deux de plus : l'explication de `37fe1af42b8d811f99…» (règle
  des dizaines — « En une seconde, un véhicule parcourt… ») et l'énoncé de `…8104b1`
  lui-même (« la distance parcourue pendant le temps de réaction **(1 s)** »). Un
  quatrième candidat, écarté en le lisant : l'énoncé de `0e85e6a79127a2bae7…» commence
  par « En tunnel, **une seconde** infraction » — « seconde » y est l'ordinal d'une
  récidive, pas l'unité de temps ; un grep naïf le compte, une lecture ne le retient pas.
  Les trois occurrences réelles restent défendables sous le même chaînage qu'en round 0 :
  `…8104b1` calcule la distance parcourue pendant cette même seconde, `…811f99` s'en sert
  comme unité de calcul de tête, l'énoncé de `…8104b1` la pose en donnée du problème
  plutôt que de l'affirmer comme règle — aucune des trois ne remplace ce que `…81e98a`
  enseigne (pourquoi une seconde, et jusqu'où).
- **« deux secondes » / « 2 secondes »** (intervalle de sécurité, `…812db5`) : **cinq**
  occurrences hors sa propre carte, pas une. Round 0 n'avait vu que l'explication de
  `8ddd0cebb28376040a…` (citation mot pour mot de R412-12 I). Le grep en trouve quatre de
  plus : les explications de `2362d0ebc53cb6de07…` (« plus que les deux secondes exigées
  à 130 km/h »), de `37fe1af42b8d81ef84…` (« un temps de réaction qui passe d'une à deux
  secondes ») et de `f376d218b64a41796d…` (« à 90 km/h, deux secondes valent justement
  50 mètres »), plus l'énoncé de `37fe1af42b8d815a8d…` (« l'intervalle de sécurité de
  **2 secondes** représente environ »). Les quatre restent défendables, mais pas pour la
  même raison : les trois premières citent la même règle de droit (R412-12 I) pour
  l'appliquer à un autre usage — le repère au sol, le temps de réaction dégradé, le
  plancher poids lourds — exactement le chaînage annoncé pour ce domaine ; la quatrième
  (`…81ef84`) est une coïncidence **documentée comme telle** ailleurs dans le lot, puisque
  `…81e98a` appelle déjà « 2 secondes » « à la fois le temps de réaction dégradé et
  l'intervalle légal — la confusion utile ». Aucune des cinq ne donne la réponse de
  `…812db5` sans en connaître la règle par ailleurs.
- **« interdit, et puni de 135 € et 3 points »** (circulation sur la BAU, `a4f04a…`) :
  compte inchangé, une seule occurrence — le contenu numérique (135 €, 3 points), pas le
  mot « interdit » — dans l'explication de `aad60a7453493cc671…`, déjà documentée en
  round 0 comme le contraste voulu de la paire R412-8/R421-7. Aucune occurrence
  supplémentaire en énoncé.
- **Cinq propres, confirmées sur les deux champs.** « deux bandes de la ligne de rive »,
  « 14 m », « 3 » (règle des dizaines), « 4 » (doublement du freinage) et « 72 m » ne
  réapparaissent, ni en énoncé ni en explication, dans aucune des vingt autres cartes du
  domaine.

### Mouvements d'`audit.py`

| sortie | round 0 (avant) | round 0 (après) | fix round 1 | fix round 2 |
|---|---|---|---|---|
| `lettre/reference` | 1 | 1 | 1 | 1 |
| `forme/markdown` | 1 | 1 | 1 | 1 |
| `forme/seule-ponctuee` | 14 | 14 | 14 | 14 |
| `longueur/plus-longue` | 95 | 96 | 96 | 96 |
| `expl/paraphrase-litterale` | 17 | 17 | 17 | 17 |
| `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10`, `forme/backtick-isole` | vides | vides | vides | vides |

`longueur/plus-longue` reste à 96 à toutes les rondes, mais pas pour la même carte dans
le même état : `…81e7a0` y contribue toujours, à +1 caractère au lieu de +10 depuis le
fix round 1 — la marge de sécurité qu'il devait ajouter, `longueur/plus-10` restant vide
partout. `--fuites "Distances & freinage"` : 1 recouvrement en round 0 (avant et après
édition), toujours 1 après le fix round 1 mais sur une carte différente à l'intérieur du
domaine, **0 après le fix round 2**. `--fuites` sur les cinq domaines déjà clos,
revérifié après le fix round 2 : 0 sur « Permis & sanctions », « Vitesse »,
« Alcool & stupéfiants » et « Mécanique & environnement » ; 1 recouvrement incidental,
inchangé et déjà documenté par la tâche 5, sur « Usagers & partage de la route ».

**Le recouvrement fortuit de `--fuites` sur ce domaine, refermé au fix round 2.** En
round 0, `a4f04a8078a925fbc8c5df10f063e065` (circulation sur la BAU) recouvrait la bonne
réponse d'une carte `Vitesse` (« 4 points, avec suspension possible du permis », pour un
dépassement de 40 à 50 km/h) par le seul vocabulaire générique du barème (« points »,
« suspension », « possible », « permis »), sans chiffre commun (trois points contre
quatre) : un recouvrement fortuit qui **prédatait cette tâche**, déjà présent en round 0
avant toute édition. Le fix round 1 l'a fait disparaître par effet de bord — en retirant
« possible » de l'explication de `a4f04a…` pour régler la fuite vers `…81e7a0` — mais en
a créé un **autre**, cette fois-ci **causé par le fix round 1 lui-même** et non hérité :
la précision ajoutée sur `…81e7a0` (« il faut un juge pour la prononcer — ce que
« possible » veut dire dans la réponse ») réintroduisait les trois mêmes mots pleins
(« points », « suspension », « possible ») contre la même carte `Vitesse`, sur une carte
qui n'avait jamais fui vers elle auparavant.

Mon rapport de fix round 1 qualifiait ce second recouvrement de non corrigeable sans
annuler le correctif, en invoquant le point 11 du calibrage (protéger une phrase vraie
d'un outil). C'était une application incorrecte du point 11 : celui-ci protège une
phrase vraie qu'*abîmer* coûterait du contenu réel, pas une glose finale qui peut être
retirée sans rien perdre. La substance du minor 1 — la suspension est une peine
complémentaire, discrétionnaire, qui exige un juge — tient sans le mot « possible » :
l'explication se referme sur « il faut un juge pour la prononcer. », et le gloss final
est retiré. Fix round 2 confirme : `--fuites "Distances & freinage"` retombe à
**0 recouvrement sur 21 cartes**, gratuitement.

## Arrêt & stationnement

17 cartes, 10 `datée`, 3 illustrée(s).

### Écarts de justesse trouvés

| id | écart | ce que disait la carte | ce que dit l'article | correction |
|---|---|---|---|---|
| `37fe1af42b8d81e9b314fcb5ac447202` (stationnement abusif) | explication au-delà de l'article | « un arrêté local peut raccourcir ce délai, et la fourrière devient possible » — sans condition | R417-12 relu intégralement par `WebFetch` le 2026-08-27 : « Lorsque le conducteur ou le titulaire du certificat d'immatriculation est absent ou refuse, malgré l'injonction des agents, de faire cesser le stationnement abusif, l'immobilisation et la mise en fourrière peuvent être prescrites » — la fourrière n'est ni immédiate ni automatique, elle suppose un agent, une injonction et un refus | explication reformulée : « La fourrière suppose un conducteur absent ou qui refuse d'obtempérer à l'injonction d'un agent » ; ligne de `sources.md` complétée de la citation exacte |
| `37fe1af42b8d81e9b314fcb5ac447202` (stationnement abusif) | règle trop large — **trouvé en revue, corrigé au fix round 1** | « le véhicule est réputé abusif où qu'il soit garé, même sur un emplacement autorisé et gratuit » | R417-12, ligne de registre réécrite ce même round : « un même point de **la voie publique ou de ses dépendances** » — sept jours dans une allée privée ne sont pas abusifs au sens de cet article | « où qu'il soit garé » → « sur la voie publique ou ses dépendances », le reste de la phrase (« même sur un emplacement autorisé et gratuit ») conservé tel quel, il reste vrai à l'intérieur de ce périmètre |

Round 0 n'avait trouvé que le premier des deux écarts sur cette carte. Le second — la
portée géographique de l'article, laissée trop large par la carte elle-même et non par
sa ligne de registre, qui la portait déjà correctement (« un même point de la voie
publique ou de ses dépendances ») — est exactement le défaut que la méthode clause par
clause (point 10 du calibrage) est censée attraper, et round 0 l'a manqué en comparant
la carte à son affirmation par blocs plutôt que proposition par proposition. Aucun autre
écart trouvé sur les seize autres cartes, aux deux rondes.

### Chaque carte nommant un lieu ou un véhicule, à l'alinéa

R417-11 a été relu **dans son intégralité** par `WebFetch` le 2026-08-27 (chapeau, I 1°
à 8°, sous-alinéas a-d du 8°, II, III), plutôt que de faire confiance aux citations déjà
présentes dans le registre sans les revérifier.

Chapeau de R417-11 (cité mot pour mot) : « Est considéré comme très gênant pour la
circulation publique l'arrêt ou le stationnement : ». Le 8° a son propre chapeau :
« D'un véhicule motorisé à l'exception des engins de déplacement personnel motorisés,
des cyclomobiles légers et des cycles à pédalage assisté », puis a) « Sur les trottoirs,
à l'exception des motocyclettes, tricycles à moteur et cyclomoteurs ».

| id | lieu / véhicule | alinéa vérifié |
|---|---|---|
| `37fe1af42b8d8134ad4be3c7e29328f1` | passage piéton (stationner dessus) | R417-11 I 5° — « D'un véhicule sur les passages réservés à la circulation des piétons en traversée de chaussée » |
| `37fe1af42b8d81d793bcc927205f9d79` | voie réservée aux bus | R417-11 I 1° — « D'un véhicule sur les chaussées et voies réservées à certaines catégories de véhicules, sauf en cas de nécessité absolue » ; distinct de l'emplacement d'arrêt de bus lui-même (R417-10 II 2°, gênant et non très gênant) |
| `c5d4d52f1aaa89b811c8b17847338968` | bouche d'incendie / borne de recharge | R417-11 I 8° d) (« Au droit des bouches d'incendie », très gênant, 135 €) contre R417-10 III 3° (borne de recharge, gênant, 35 €) — le contre-exemple nommé par la préface de `sources.md`, vérifié à l'alinéa et non à la catégorie |
| `e6d0b1101f0ac46d63199b5485d17c61` | cinq mètres en amont d'un passage piéton | R417-11 I 8° c) — « Sur une distance de cinq mètres en amont des passages piétons dans le sens de la circulation, en dehors des emplacements matérialisés à cet effet » ; réserve qui vient du c) lui-même, pas du chapeau du 8° (voir la correction de registre plus bas) |

Cinq cartes de plus nomment un lieu propre à un article distinct de R417-10/11 :
`37fe1af4…811198` (R417-9, dangereux, conditionné à « lorsque la visibilité est
insuffisante ») ; `37fe1af4…8181a0` (R417-10 IV, la classe générale) ; `37fe1af4…166847`
(R417-3, zone bleue) ; `37fe1af4…811b96` (R417-1 I, chaussée à double sens) ;
`37fe1af4…8148bc2` (R417-4 I, accotement hors agglomération).

**Le round 0 avait couvert le lieu que chaque carte teste, jamais les lieux que son
explication cite en plus — et c'est là que deux erreurs de catégorie se cachaient**
(revue, fix round 1) :

- `37fe1af42b8d8134ad4be3c7e29328f1` disait « Trottoir, place réservée et voie cyclable
  relèvent de la même catégorie très gênante, à 135 € ». Faux sur les deux points : le
  trottoir n'est très gênant qu'à l'alinéa a), qui exclut nommément « les motocyclettes,
  tricycles à moteur et cyclomoteurs » (pour eux, R417-10 II 1°, gênant, 35 €) ; et
  « place réservée » est plus large que l'alinéa 3°, qui ne vise que les « emplacements
  réservés aux véhicules portant une carte mobilité inclusion ». L'énumération fautive a
  été retirée (voir Pédagogie) plutôt que corrigée mot à mot, parce qu'elle ne portait
  pas de limite au sens du critère 3 — une vraie limite l'a remplacée.
- `37fe1af42b8d8181a057c984708f0042` disait « très gênant, 4e classe à 135 €, pour ce
  qui touche aux trottoirs, passages piétons, places réservées et voies réservées » —
  même défaut. Corrigée en qualifiant chaque lieu à son alinéa exact : « le trottoir
  (voiture) », « l'emplacement carte mobilité inclusion ».

Sur les neuf cartes qui nomment un lieu ou un véhicule, plus les deux qualifications
ci-dessus une fois corrigées, aucune carte n'étend plus le régime d'un alinéa vers un
autre : chacune reste dans son alinéa propre.

### Doutes signalés, non corrigés

Aucun doute nouveau signalé ce round. Le seul point resté ouvert par la ligne de
registre — l'échéance du 01/01/2027 sur `e6d0b1101f0ac46d63199b5485d17c61` — est une
décision déjà prise et déjà expliquée dans `sources.md` (ne pas rouvrir avant l'échéance) :
ce n'est pas un doute que cette relecture laisse ouvert.

### Pédagogie

- explications sous 120 caractères à l'entrée : 3 (109, 59, 86), réécrites round 0.
- cartes dont le budget de 220 a limité l'explication : **`0a4e98c4605ec20320…`**
  (marquage jaune continu, 215/220 à l'entrée). Round 0 l'avait laissée telle quelle en
  disant qu'aucune carte n'était limitée par le budget ; c'était faux — cette carte
  n'avait aucune raison (deux renvois croisés vers d'autres marquages en tenaient lieu).
  Fix round 1 a coupé les deux renvois pour loger un raisonnement à leur place, mais ce
  raisonnement (« le stationnement n'étant, par définition, que ce qui n'est pas de
  l'arrêt (R110-2), interdire l'un interdit l'autre ») s'est révélé une fausse
  déduction — voir Fix round 2, qui la retire et déclare la raison absente plutôt que
  d'en forcer une autre.
- énoncés reformulés parce qu'ils présupposaient la règle : aucun, aux deux rondes.

**Round 0 — trois cartes réécrites sur le critère 3, toutes trois COURTE :**

- `37fe1af42b8d812cad07c40f6c51598c` (arrêt vs stationnement) — règle (R110-2, durée +
  présence du conducteur), raison, limite.
- `37fe1af42b8d8148bc29ede5a0015edd` (arrêt hors agglomération) — citation exacte,
  raison, limite ; option C resserrée (voir Longueur).
- `37fe1af42b8d81e2b806fb6055602586` (quitter sa place) — l'explication ne parlait que
  de R415-11 (céder le passage) alors que l'option porte aussi le clignotant et les
  angles morts, actions de R417-8 qu'aucune phrase n'expliquait ; réécrite pour porter
  les deux articles.

**Fix round 1 — cinq cartes de plus réécrites sur le critère 3, trouvées par la revue :**

- `0a4e98c4605ec20320f13dec75f7bb9c` (marquage continu, illustrée) — avait la règle,
  aucune raison, deux renvois croisés vers les cartes sœurs en guise de limite (voir
  Fuites). Réécrite avec la raison logique R110-2 ci-dessus ; le zigzag (sourcé par
  `images.md`, pas une carte du domaine) reste comme seul renvoi.
- `639297cf3f0f433daf035978fa8ddfe5` (stationnement en épi, illustrée) — avait la règle,
  aucune raison, et « Une seule manœuvre à l'entrée, la sortie se fait en marche
  arrière » n'est pas une limite (une condition qui fait cesser la règle) mais une
  conséquence de conduite. Réécrite : raison (entrer en un seul mouvement), limite
  réelle (l'angle n'est fixé par aucun texte, seulement par la planche — ce qui porte
  aussi au rapport la réserve que `sources.md:231` demandait sans jamais la recevoir,
  voir minor 7 plus bas).
- `a2673bae092f3eaf438b40910de6fbd4` (marquage discontinu, illustrée) — la limite
  existait (contraste avec la continue) mais fuyait deux cartes sœurs à la fois (voir
  Fuites). Réécrite pour rester autonome : le tableau de l'art. 113-2 E assigne un rôle
  par style, et le même tracé complété de LIVRAISON change de sens.
- `37fe1af42b8d8134ad4be3c7e29328f1` (passage piéton) — la « limite » était une
  énumération d'autres lieux très gênants, donc pas une condition de cessation, **et**
  portait la double erreur de catégorie ci-dessus. Réécrite : l'arrêt y est puni comme
  le stationnement (pas seulement l'installation prolongée), et R417-5 punit aussi
  l'empiètement à une classe inférieure — c'est la qualification la plus sévère qui
  l'emporte : une vraie limite, sourcée par l'affirmation elle-même.
- `5139c357024d2a17c499b104d7a01d81` (unilatéral alterné) — aucune raison (le texte
  était redit deux fois plutôt qu'expliqué), et l'heure du changement citée comme
  « limite » est un élément de la règle, pas sa condition de cessation. Réécrite :
  raison (répartir l'usage de la voie, souvent pour le nettoyage), limite réelle
  (n'existe que si un maire l'a institué — rien ne l'impose par défaut).

Cartes illustrées : les trois ont été réécrites au fix round 1 (voir ci-dessus et
Longueur), toutes mesurées sous 220.

### Preuve par carte, pour les 4 cartes non modifiées

Treize cartes ont été modifiées au total sur les trois rondes : les trois COURTE du
round 0 (`37fe1af42b8d812cad07c40f6c51598c`, `37fe1af42b8d8148bc29ede5a0015edd`,
`37fe1af42b8d81e2b806fb6055602586`), l'écart de justesse
(`37fe1af42b8d81e9b314fcb5ac447202`), la carte tournée pour `correctID`
(`37fe1af42b8d8166847cf95009550b0a`), sept de plus au fix round 1
(`0a4e98c4605ec20320f13dec75f7bb9c`, `639297cf3f0f433daf035978fa8ddfe5`,
`a2673bae092f3eaf438b40910de6fbd4`, `37fe1af42b8d8134ad4be3c7e29328f1`,
`37fe1af42b8d8181a057c984708f0042`, `5139c357024d2a17c499b104d7a01d81`,
`c5d4d52f1aaa89b811c8b17847338968`), et une de plus au fix round 2
(`ab50f861852232a60c2b4f29fed21b97`, voir Fix round 2) — chacune nommée avec ce qui a
changé et pourquoi dans « Pédagogie », « Longueur », « Les options » ou « Fix round 2 »
ci-dessus/dessous. Il reste **4** cartes strictement non modifiées (le contenu de
`e6d0b1101f0ac46d63199b5485d17c61` n'a pas bougé non plus ; seule sa ligne de registre a
été corrigée, voir minor 8). Règle / raison / limite telles que chacune les dit :

| id | rôle | règle / raison / limite |
|---|---|---|
| `37fe1af42b8d811198bdecd01768828c` | stationnement dangereux | règle (masque de visibilité : virage, sommet, intersection, passage à niveau) + limite explicite (« Un stationnement seulement gênant, lui, ne coûte aucun point », cohérent avec la ligne de `…8181a0`) |
| `37fe1af42b8d811b96fdf80a7a546c1e` | côté de stationnement, double sens | règle (à droite) + raison (« placerait le conducteur du mauvais côté au moment de sortir, face au trafic ») + limite explicite (« Les deux côtés ne sont permis qu'en sens unique ») |
| `37fe1af42b8d81d793bcc927205f9d79` | voie réservée aux bus | règle (très gênant) + raison (« renvoie tout un bus dans le trafic général, avec ses passagers ») + limite explicite (« seule la nécessité absolue l'excuse, jamais l'absence de bus ») |
| `e6d0b1101f0ac46d63199b5485d17c61` | cinq mètres en amont d'un passage piéton | règle (5 m) + raison (« qu'un enfant engagé sur le passage soit vu à temps ») + limite explicite (amont seulement, cède devant un emplacement matérialisé) ; seule sa ligne de registre a bougé ce round (minor 8), pas la carte |

**La treizième carte modifiée porte un vide déclaré plutôt qu'une raison forcée** :
`0a4e98c4605ec20320f13dec75f7bb9c` (marquage continu) a règle (« interdit l'arrêt
lui-même, pas seulement le stationnement ») et limite (le zigzag réserve un arrêt de
bus, un cas distinct) mais **raison absente** — voir Fix round 2 pour pourquoi la
raison ajoutée au fix round 1 a été retirée plutôt que réparée, et pourquoi aucune
raison de remplacement n'a été trouvée dans les sources disponibles : la portée du
tableau IISR (continue = arrêt, ce qui comprend le stationnement) est une convention
stipulée par le texte, pas une règle qui se déduit ou s'explique par ailleurs sur cette
carte, au même titre que l'angle de l'épi sur `639297cf…` n'a pas de raison textuelle
et ne s'appuie que sur une planche.

Modifiées (13, nommées ci-dessus) + non modifiées évidencées (4) = 17, sans reste.

### Longueur — point 15 du calibrage

**Round 0**, deux corrections : `37fe1af4…8148bc2` (option C « hors de la chaussée » →
« hors chaussée », 49→43, n'était plus la plus longue) et `37fe1af42b8d8166847cf95009550b0a`
(option correcte « bien visible » → « visible », 47→42, +3 sur la deuxième).

**Fix round 1**, une correction supplémentaire trouvée par la revue et manquée par le
round 0 : `37fe1af42b8d81e2b806fb6055602586` (quitter sa place) — l'option correcte
« Mettre le clignotant, contrôler les angles morts et céder le passage » (68 car.) était
la plus longue des quatre, à +5 sur la deuxième (63) : un défaut du point 15 même sous le
seuil dur, que le round 0 avait laissé passer en le classant « structurel » (trois
actions réelles contre une par distracteur) sans le mesurer contre l'alternative. Elle
condense au même sens : « Clignotant, angles morts, puis céder le passage » (47 car.),
qui n'est plus la plus longue (D, 63, le redevient).

### Les options

Sept règles du §2 de `questions.md` relues carte par carte, puis le point 14 du
calibrage.

**Le distracteur « véhicules encombrants » (`0a4e98c4…` et `a2673bae…`) — corrigé au fix
round 1.** Round 0 l'avait qualifié de concept sans base textuelle, gardé « pour la
symétrie pédagogique » — un motif que ni le spec ni le calibrage ne reconnaît, et la
revue l'a relevé à raison. La base existe : R414-9 (et son jumeau R414-2, mêmes termes,
même seuil, ligne de `07b430ccbde4b33b92be8686899b1ddf`) définissent le « gabarit
encombrant » à *plus de deux mètres de large ou sept mètres de long, remorque et
chargement compris*, à l'exception des transports en commun en agglomération — c'est un
seuil chiffré réel, mais d'un régime entièrement différent (le dépassement d'un convoi
large, pas le marquage au sol). Le distracteur transpose ce concept réel à un endroit où
il ne joue aucun rôle : rien dans le tableau de l'art. 113-2 E ne conditionne
l'interdiction d'arrêt ou de stationnement au gabarit du véhicule. C'est exactement le
mécanisme déjà validé pour le distracteur « 30 km/h » de `2fc1ed8a9c9274f0e06be9f12850f5a4`
(un seuil réel d'un régime voisin, transposé à tort) : gardé, mais avec sa provenance
maintenant nommée, comme le point 3 du calibrage l'exige pour tout chiffre recyclé.

**`c5d4d52f1aaa89b811c8b17847338968` (bouche d'incendie) — deux points :**

- Le distracteur C (« de 135 €, plus trois points comme un stationnement dangereux »)
  recycle le montant exact d'une carte voisine (`37fe1af4…811198`, R417-9) avec un
  nombre de points qui ne s'applique pas ici (R417-11 ne retire aucun point) : réel,
  plausible, faux pour la bonne raison — gardé.
- **Trouvé en revue (minor 6) :** l'énoncé demandait « l'amende », alors que deux
  options (B et C) portent 135 € — le seul discriminant entre elles, les trois points de
  C, n'a rien à voir avec « l'amende » telle que posée. Corrigé : l'énoncé demande
  maintenant « la sanction », ce qui rend la comparaison entre B (135 €, sans point) et C
  (135 € plus trois points, faux) directement pertinente à la question posée.

Aucun autre distracteur n'a paru, à cette relecture, éliminable par pure logique, isolé
par la forme, ou légitimé par sa propre carte.

### `correctID` — mesuré et rééquilibré

Inchangé depuis le round 0 : **A 6, B 5, C 4, D 2** avant édition, **A 4, B 5, C 4, D 4**
après, par rotation cyclique de `37fe1af42b8d8166847cf95009550b0a` et
`37fe1af42b8d81e9b314fcb5ac447202` (A → D sur les deux, texte inchangé). Le fix round 1
n'a touché ni les options ni le `correctID` d'aucune carte pour cette raison ; les
modifications d'options du round (`…81e2b8`, `c5d4d52f…`) ont chacune été vérifiées pour
ne pas déplacer la lettre correcte.

### Fuites — automatique, à la main, et une famille manquée en round 0

```
$ python3 Tools/relire.py --fuites "Arrêt & stationnement"
0 recouvrement(s) sur 17 cartes de « Arrêt & stationnement ».
```

Zéro aux deux rondes — et c'est précisément le problème que la revue a nommé : `--fuites`
teste une inclusion d'ensemble de mots pleins (`Tools/relire.py:119`) et **n'inspecte
jamais les options**, seulement les explications contre des réponses d'au moins trois
mots pleins. Round 0 avait traité cet angle mort pour les réponses courtes (point 13 du
calibrage, sept réponses grep-ées à la main, tableau ci-dessous) mais pas pour une fuite
**conceptuelle, en d'autres mots** entre deux explications — exactement le point 5 du
calibrage, distinct du point 13, et la revue a eu raison de les nommer séparément.

**Quatre recouvrements trouvés en revue, tous internes au trio des marquages jaunes
et à leur voisine `37fe1af42b8d812cad…`, corrigés au fix round 1 :**

- `0a4e98c4…` expliquait « Interrompue en tirets, elle ne viserait plus que le
  stationnement » — la réponse même de `a2673bae…` (« le stationnement, l'arrêt restant
  permis »), dont l'`alt` décrit justement une ligne en tirets.
- `a2673bae…` expliquait en retour « Continue, le même trait supprimerait aussi cet
  arrêt » — la réponse de `0a4e98c4…` (« l'arrêt du véhicule autant que son
  stationnement »).
- `a2673bae…` expliquait aussi « on peut s'immobiliser le temps de faire monter ou
  descendre quelqu'un, sans quitter les commandes » — les deux critères exacts de
  `37fe1af42b8d812cad…` (durée + présence du conducteur), en d'autres mots.
- `c5d4d52f…` répondait « de 135 €, **comme sur un passage piéton** » — la classification
  de `37fe1af4…8134ad4` donnée en comparaison directe.

Chacune des quatre cartes réécrites au fix round 1 (voir Pédagogie et Les options) l'a
été sans réintroduire le renvoi : `0a4e98c4…` et `a2673bae…` n'expliquent plus l'une par
l'autre, `a2673bae…` ne redit plus la définition de `…812cad…`, et l'option de
`c5d4d52f…` dit maintenant « de 135 €, la classe des infractions très gênantes » — le
même fait, sans nommer la carte qui le teste ailleurs. Vérifié à la main : aucun des
nouveaux textes ne contient plus les mots pleins de la réponse qu'il citait.

**Les sept réponses courtes (point 13 du calibrage), grep-ées à la main sur énoncés et
explications, round 0 — toujours valables, aucune n'a changé de statut au fix round 1 :**

| id | bonne réponse | mots pleins (≥ 5 car.) | n |
|---|---|---|---|
| `37fe1af42b8d811198bdecd01768828c` | « Dans un virage ou au sommet d'une côte » | `virage`, `sommet` | 2 |
| `37fe1af42b8d811b96fdf80a7a546c1e` | « À droite, dans le sens de la circulation » | `droite`, `circulation` | 2 |
| `37fe1af42b8d8134ad4be3c7e29328f1` | « Un stationnement très gênant, à 135 € » | `stationnement`, `genant` | 2 |
| `37fe1af42b8d8181a057c984708f0042` | « 35 € » | — | 0 |
| `37fe1af42b8d81e9b314fcb5ac447202` | « 7 jours au même endroit » | `jours`, `endroit` | 2 |
| `5139c357024d2a17c499b104d7a01d81` | « semi-mensuel, avec un changement de côté le 15 » | `mensuel`, `changement` | 2 |
| `c5d4d52f1aaa89b811c8b17847338968` | « de 135 €, la classe des infractions très gênantes » | `passage`, `pieton` (retirés au fix round 1) → aucun mot plein propre à la réponse | 0 |

`virage`/`sommet`, `droite`/`circulation`, `sept jours`/`même endroit`,
`mensuel`/`changement` : uniquement dans la carte propriétaire, zéro recouvrement.
`135 €`/`très gênant` et `35 €` : constante partagée par tout un régime (quatre cartes
très gênantes de R417-11 affirment 135 €, deux cartes gênantes affirment 35 €), documenté
comme fortuit (point 11 du calibrage) — ce ne sont **pas** les mêmes recouvrements que
les quatre trouvés en revue ci-dessus, qui portaient sur des phrases entières et des
réponses spécifiques, pas sur une constante de classe.

### Le faux positif de paraphrase — confirmé, et nommé calibrage point 16

`37fe1af42b8d8181a057c984708f0042` (gênant simple) : `audit.py:194` fait `norm(good) in
norm(expl)`, une recherche de sous-chaîne sans limite de mot. « 35 € » est une
sous-chaîne littérale de « 1**35 €** », une valeur différente citée par contraste — la
revue l'a confirmé et l'a ajouté à `calibrage.md` comme un **troisième type** de ce
signal, ni le défaut réel ni le faux positif structurel du point 8 (une réponse chiffrée
qui revient normalement). Nuance apportée par le fix round 1 : l'explication réécrite
pour la précision trottoir/carte mobilité inclusion contient maintenant « soit 35 €
d'amende forfaitaire » — donc le chiffre « 35 » y figure aussi **littéralement**, cette
fois en toute légitimité (point 8, une réponse chiffrée reprise pour préciser la
correspondance classe → montant, un vrai ajout pour qui ne la connaît pas encore). Le
compte du drapeau ne change pas (toujours cette seule carte du domaine), seule sa nature
exacte s'est déplacée de la collision pure vers un mélange collision + réutilisation
légitime.

### Mouvements d'`audit.py`

| sortie | avant (round 0) | après round 0 | après fix round 1 | après fix round 2 |
|---|---|---|---|---|
| `lettre/reference` | 1 | 1 | 1 | 1 |
| `forme/markdown` | 1 | 1 | 1 | 1 |
| `forme/seule-ponctuee` | 14 | 14 | 14 | 14 |
| `longueur/plus-longue` | 96 | 94 | 93 | 93 |
| `expl/paraphrase-litterale` | 17 | 17 | 17 | 17 (inchangé) |

`schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10` et
`forme/backtick-isole` : vides aux quatre relevés. `longueur/plus-longue` baisse de 3 au
total (deux resserrements round 0, un de plus au fix round 1) ; le fix round 2 ne touche
aucune longueur d'option, il ne bouge rien ici. Aucune régression aux trois rondes.

### Neuf minors du fix round 1

1. `…81e2b8` — voir Longueur.
2. `Tools/sources.md:229` — le `relevé le` était passé à 2026-08-27 alors que seule la
   clause de fourrière avait été rouverte ce jour-là ; les 35 € et R49 3° CPP dataient du
   2026-08-25. La ligne dit maintenant explicitement lequel des deux éléments a été
   revérifié quand.
3. `…8148bc2` — « Sans accotement, on **s'en** rapproche au maximum » attachait « en » à
   un accotement qui, par hypothèse, n'existe pas. Corrigé en « on serre le bord au
   maximum ».
4. `…812cad…` — « de nombreux articles ne sanctionnent que le stationnement » n'était
   dans aucune ligne et contredisait le motif dominant du lot (R417-9/10/11 visent
   « l'arrêt ou le stationnement » ensemble). Corrigé en nommant les deux cas réels
   (R417-12, R417-3 : stationnement seul) contre les trois qui visent les deux ; renvoi
   ajouté à la ligne de `sources.md`.
5. `…8181a0` — voir la table des lieux ci-dessus ; « soit 35 € d'amende forfaitaire »
   ajouté.
6. `c5d4d52f…` — voir Les options.
7. `Tools/sources.md:231` — la réserve « en bataille »/« en créneau », vocabulaire
   d'auto-école absent de tout texte, promise « à porter au rapport » depuis la lecture
   du 2026-08-25, n'avait jamais atteint aucun `audit-2026-08*.md`. Portée ici (voir
   Pédagogie, réécriture de `639297cf…`) et dans le rapport de tâche.
8. `Tools/sources.md:235` (`e6d0b1101f0ac46d63…`) — la ligne affirmait que l'exception de
   véhicule du chapeau du 8° était « la raison d'être » de la réserve « hors emplacement
   matérialisé », alors que cette réserve vient du c) lui-même et n'a aucun lien avec le
   chapeau. Corrigé, les deux faits séparés.
9. Voir Pédagogie — `0a4e98c4…` est la carte que le budget de 220 a limitée.

### Fix round 2 — une fausse déduction retirée, une raison implicite remplacée

**Open 1 — `0a4e98c4605ec20320f13dec75f7bb9c` (marquage continu) : la raison ajoutée au
fix round 1 était une fausse déduction.** Le texte disait « Le stationnement n'étant,
par définition, que ce qui n'est pas de l'arrêt (R110-2), interdire l'un interdit
l'autre. » R110-2 partage arrêt et stationnement en deux catégories **disjointes** —
le stationnement étant tout ce qui échoue au test de l'arrêt. Interdire l'une des deux
ne dit rien de l'autre par le seul fait de cette partition ; une lecture littérale
pointerait plutôt dans l'autre sens. La vraie raison pour laquelle un marquage continu
interdit les deux à la fois est une **convention stipulée** par le tableau de l'IISR
que la ligne de la carte cite déjà (art. 113-2 E), pas une déduction à partir de R110-2.

Cherché sans trouver : aucune clause de l'affirmation, d'`images.md` ou de R417-11/-10
n'énonce **pourquoi** le tableau IISR fait de la continue le cas le plus large plutôt
que l'inverse — c'est une décision de nomenclature, comme le sont « en épi » vs
« perpendiculaire » sur `639297cf…`, qui n'a pas non plus de raison textuelle au-delà de
la planche. Conclusion : **raison absente**, déclarée plutôt que remplacée par une
seconde raison inventée. La carte garde règle (« interdit l'arrêt lui-même, pas
seulement le stationnement ») et limite (le zigzag réserve un arrêt de bus, un marquage
distinct) ; le renvoi « (R110-2) » est retiré avec la phrase qui le portait, ce qui
éteint de lui-même le manque de renvoi que la revue avait signalé en non-bloquant sur
`sources.md`. 194 → 165 caractères, largement sous 220.

**Open 2 — `ab50f861852232a60c2b4f29fed21b97` (ouverture de portière) : « dangereusement »
dans l'énoncé n'est pas une raison dans l'explication.** Le spec scope le critère 3 au
champ `explanation` ; et l'adverbe de l'énoncé est la **condition de déclenchement** de
la règle (R417-7 ne punit que si la manœuvre « constitue un danger »), pas une
explication de pourquoi la règle existe — c'est ce que le lecteur doit déjà analyser pour
comprendre la question, pas ce qu'il apprend en la lisant. L'explication ne disait que
la règle, un exemple et une limite de portée, jamais le danger réel que le texte vise
(un cycliste ou un piéton fauché par une portière ouverte sans regarder). Ajouté : « une
portière ouverte sans regarder peut faucher un cycliste ou un piéton qui longe le
véhicule ». Cette carte passe donc de la table des non-modifiées à celle des modifiées ;
elle a maintenant règle, raison et limite tous trois dans l'explication elle-même.

Aucune autre carte touchée ce round. Les deux corrections sont indépendantes : la
première retire un défaut introduit au fix round 1, la seconde corrige un défaut de
round 0 qu'une justification à l'œil (« la raison vit dans l'énoncé ») avait laissé
passer deux rondes de suite.

### Vérifications, fix round 2

```
$ python3 Tools/relire.py --fuites "Arrêt & stationnement"
0 recouvrement(s) sur 17 cartes de « Arrêt & stationnement ».
```

Les six autres domaines finis re-testés dans le même geste, tous à 0 :
`Permis & sanctions` (19), `Vitesse` (22), `Alcool & stupéfiants` (18),
`Usagers & partage de la route` (18), `Mécanique & environnement` (20),
`Distances & freinage` (21).

`audit.py` inchangé par rapport à après fix round 1 (voir la table ci-dessus) : ni les
options ni le `correctID` d'aucune carte n'ont bougé ce round, seules deux explications.
`longueur/plus-10`, `schema/`, `couverture/`, `source/`, `fuite/`, `image/` et
`forme/backtick-isole` toujours vides.

Illustrée re-mesurée : `0a4e98c4…` 22/48/165 (contre 194 après fix round 1), largement
sous 220 ; `639297cf…` et `a2673bae…` non touchées ce round, toujours à 219 et 215.

`✔ Test run with 10 tests in 0 suites passed after 0.066 seconds.` / `** TEST SUCCEEDED **`
sur les dix tests du contenu livré, simulateur `iPhone 17 Pro`
(`66921B37-1805-4988-AB69-B51A94490BC0`). `git status --short` avant `git add` :
`Valido/Resources/questions.json` seul modifié, `CLAUDE.md` toujours untracked, aucun
`Contents.json` reformaté.

## Premiers secours

18 cartes, 9 `datée`, 0 illustrée(s).

**Cette section a été corrigée deux fois après revue.** Le fix round 1 a confirmé le
règlement de la dette 112/119, le tri loi/geste sur son principe et la discipline de
sourçage rang 3, mais a trouvé cinq raisons coupées à tort, une carte devenue fausse dans
un cas réel du même lot, deux explications réécrites au prix de la pédagogie pour garder
un compteur plat, une fuite de mot d'énoncé oubliée et plusieurs comptages erronés dans
cette section elle-même. Le fix round 2 a **vérifié les cinq raisons restaurées mot pour
mot contre les PDF ERC et la page Croix-Rouge** (relus intégralement une seconde fois,
indépendamment) et confirmé la carte casque **médicalement correcte dans ses deux
branches** — mais a trouvé que la correction du round 1 avait, en réglant la médecine,
cassé la question : l'énoncé de la carte casque n'avait pas reçu la même portée que
l'explication, et une réfutation réécrite ailleurs donnait la réponse d'une carte voisine.
Le détail des deux rounds est à la fin ; les tableaux ci-dessous sont la version deux fois
corrigée, pas la version d'origine.

### Tri loi / geste, fait avant l'ouverture d'une source

Une seule carte juridique : `b9e656cbd3507444` (DAE), R6311-15 du code de la santé
publique, rang 1. **Rang 1 : 2** — le triangle (`37fe1af42b8d817b90…`, arrêté du
30/09/2008, publié sur Legifrance) rejoint le DAE, ce que la première version de cette
section avait classé à tort en rang 2. **Rang 2 : 7** — cinq cartes de conduite routière
sur `securite-routiere.gouv.fr` (déplacer une victime `…8175a7`, casque `…81a092`,
protéger/alerter/secourir `…81f1b1`, protéger une zone `…81f7a2`, victime coincée
`…5fe77bbd`) et **deux** sur `service-public.gouv.fr` (112 `…810ca6`, sapeurs-pompiers
`…8122b0`) — ces deux dernières classées à tort en gestes médicaux de rang 3 dans la
première version : `service-public.gouv.fr` est un site `.gouv.fr` mais n'est pas
Legifrance, donc rang 2, pas rang 1 ni rang 3. **Rang 3 : 9** — les gestes médicaux ERC ou
Croix-Rouge (brûlure, hémorragie, alerter les secours, PLS, position de massage, ordre
alerter/masser/défibriller, profondeur, ratio, cadence). 2 + 7 + 9 = 18.

`cprguidelines.eu` vérifié : absent de toute colonne `source` de ce domaine et de toute la
banque ; il ne subsiste que dans le tuple `DOMAINES` d'`audit.py` et dans la prose de la
préface. Rien à corriger.

**Un mélange loi/geste trouvé et corrigé par la revue.** `b9e656cbd3507444…` (DAE)
affirmait, avant ce round : « C'est ce qui a permis d'en ouvrir l'usage à tout le monde,
sans condition de formation » — un lien de causalité entre un fait technique (rang 3,
l'appareil n'analyse et ne choque que si nécessaire) et une règle de droit (rang 1, le
décret de 2007) que ni la source technique ni le décret n'énoncent. Corrigé : les deux
faits sont désormais juxtaposés, sans lien causal affirmé. C'est exactement le mélange que
le tri loi/geste devait empêcher, et il avait échappé à la première relecture parce que le
mélange était dans l'explication de la carte, pas dans le classement du domaine.

### Écarts de justesse trouvés

Aucune valeur périmée. Le défaut dominant est « explication au-delà de l'article », mais
le premier passage a mal appliqué le test : il a coupé une raison dès qu'elle n'était pas
dans **la page ouverte**, sans chercher le reste du domaine whitelisté — exactement
l'erreur que le calibrage nomme maintenant au point 19. Sur neuf raisons coupées en round
0, quatre seulement résistent à une recherche élargie ; les cinq autres étaient de vraies
raisons, absentes de la seule brochure grand public d'`erc.edu` mais présentes ailleurs
sur le même domaine (le document professionnel *ERC Guidelines 2025 Adult Basic Life
Support*, `erc.edu/media/wrhj5sye/gl2025-04-bls-e.pdf`, et la page 55 du livret grand
public lui-même, dans une section que la première lecture n'avait pas ouverte).

**Coupé et confirmé après recherche élargie (3, plus une réécrite) :**

| id | ce que disait la carte | ce que dit la source | correction |
|---|---|---|---|
| `37fe1af42b8d8122b0` (18) | « le plus proche du terrain pour un accident » | F33954 dit seulement « par exemple en cas d'incendie ou d'accident de la route » ; aucune source du domaine ne parle de proximité | reformulation fidèle, sans le motif inventé |
| `37fe1af42b8d817b90` (triangle) | « c'est à peu près la distance de réaction à 100 km/h » | l'arrêté du 30/09/2008 ne motive pas les 30 m ; recherche élargie sur `erc.edu`/`croix-rouge.fr` sans objet, ce n'est pas leur domaine ; aucune source du lot ne fait ce rapprochement | rôle du triangle (avertir), sans le calcul non sourcé, et « si nécessaire » repris tel quel de l'arrêté plutôt que narrowé à « si la visibilité l'exige » (fix round 1, minor) |
| `1ef7d3ed540293c212` (brûlure) | « la glace referme les vaisseaux » | la page ne mentionne jamais la glace | round 0 : simple silence de la source, ce qui **affaiblissait** la réfutation de l'option D (calibrage point 6, un distracteur rendu plus défendable). Fix round 1 : réfuté par la plage de température que la page affirme (« 15-25°C » : la glace en est exclue), et raison sourcée ajoutée pour le plafond enfant (« risque hypothermique […] en raison de la surface corporelle plus importante », même page) |
| `37fe1af42b8d817bb1` (alerter) | « Ne raccrochez jamais le premier » (ABS signalé) | la page ne dit rien de la fin d'appel, seulement « répondre aux questions posées » | remplacé par la consigne réellement affirmée ; fix round 1 : « le régulateur » (jargon non introduit) et « rester en ligne » (au-delà de la citation) retirés à leur tour |

**Coupé à tort en round 0, restauré en fix round 1 après recherche élargie sur tout
`erc.edu` (calibrage point 19) — cinq raisons réelles :**

| id | raison coupée à tort | où elle se trouve réellement | correction |
|---|---|---|---|
| `37fe1af42b8d81a092` (casque) | « risque d'aggraver une lésion de la nuque » | ERC Guidelines 2025, livret grand public, **p. 55**, protocole ABCDE : « Has the person fallen from a height or experienced major trauma? (Consider cervical spine injury) […] Do not move the person unless they are in an unsafe situation » | raison rétablie (lésion du rachis cervical, traumatisme majeur), **et portée elle-même corrigée** — voir plus bas, c'est le défaut le plus grave du round 0 |
| `5fe77bbd3af80ab119` (coincée) | « risque d'aggraver une lésion vertébrale » | même page 55, même citation | raison rétablie, ajoutée à la suite de la phrase d'ouverture ; la formulation non sourcée du round 0 (« n'est pas à la portée d'un témoin seul ») **reste la clause d'ouverture de la carte** — ni retirée ni reléguée en second plan, contrairement à ce qu'affirmait la première version de cette ligne (corrigé en fix round 2) |
| `82a9e65c1cf2ff4a1a` (profondeur) | « ne chasse pas assez de sang » / « fractures de côtes » / « lésions du foie » | absent du livret grand public **et** absent des ERC Guidelines 2025 Adult Basic Life Support (PDF professionnel lu en entier) ; en revanche ce document professionnel dit : « Chest compressions are […] the most accessible means of maintaining cerebral and organ perfusion […] Their effectiveness depends on correct hand position and chest compression depth, rate, and degree of chest wall recoil » et fixe explicitement la borne haute : « avoiding excessive chest compression depths greater than 6cm » | raison rétablie sur la perfusion (pas sur les fractures/lésions, qui restent absentes de tout le domaine cherché) ; la borne haute est maintenant sourcée comme un choix explicite de l'ERC, pas une extrapolation |
| `d724a3c3121fafd733` (ratio) | « chute de pression artérielle » à chaque pause | absent du livret grand public ; présent dans le document professionnel : « Pauses in chest compressions interrupt perfusion and must be avoided to minimise the risk of ischaemic injury » | raison rétablie, sourcée sur le document professionnel |
| `fb24f6323a07a07c77` (cadence) | « le cœur ne se remplit pas » / « la poitrine n'a pas le temps de remonter » | absent du livret grand public ; le document professionnel motive la borne basse par la perfusion (citation ci-dessus) et la borne haute par le relâchement complet : « avoiding leaning on the chest between compressions to allow full chest wall recoil », corroboré par croix-rouge.fr (« laissez la poitrine reprendre sa position initiale afin de permettre au sang de revenir vers le cœur », pages arrêt cardiaque et noyade) | raison rétablie **et le chiffre 100-120 réécrit dans l'explication**, voir « Pédagogie » |

**Round 2 : les cinq citations vérifiées mot pour mot, indépendamment.** La revue a
retéléchargé les deux PDF ERC et rerelu la page brûlure de croix-rouge.fr plutôt que de se
fier aux citations déjà portées par cette ligne. Verdict : quatre citations disent
exactement ce que cette table leur fait dire. La cinquième, sur `fb24f6323a07a07c77`, dit
bien ce qui est cité mais **motive autre chose que ce que la ligne lui faisait motiver** —
le relâchement complet, pas le plafond de 120 min⁻¹ — corrigé séparément, voir les
minors.

**Le vrai critère que le round 0 appliquait, nommé par la revue.** Ce n'était pas le test
du point 18 (« la raison est-elle dans la source, ou déduite ? ») mais une asymétrie : tout
mécanisme physiologique était coupé, toute raison de conduite était gardée — et les
raisons de conduite gardées (`…81f1b1`, la partie « obstruction des voies aériennes » de
`…81b592`) ne sont pas davantage citées mot pour mot que celles qui ont été coupées. Le
calibrage en tire deux points : chercher tout le domaine whitelisté avant de couper
(point 19), et appliquer le test symétriquement (même point) — garder une raison non
sourcée interdit d'en couper une autre pour ce seul motif.

### Le défaut le plus grave : une absolue qui contredisait la propre chaîne CPR du lot

`37fe1af42b8d81a092…` (casque) affirmait, en sortie du round 0 : « Un simple témoin n'a ni
la formation ni le **matériel** pour l'ôter sans risque : ce geste attend les secours,
**seuls habilités** à le faire. **Aucune exception n'est prévue par les recommandations :
la règle vaut pour tout accident de moto.** » Trois défauts qui se cumulaient : retirer un
casque ne demande pas de matériel ; personne n'est « habilité » à faire un geste de
secours, c'est du vocabulaire légal appliqué à un geste, précisément la confusion que le
tri loi/geste doit empêcher ; et l'absence de source pour l'exception (ce que la ligne de
registre dit réellement) était devenue, dans la carte, un universel positif. Le défaut
était aussi factuellement faux : pour un motard **qui ne respire plus**, il faut retirer le
casque pour dégager les voies aériennes et pratiquer le massage et le bouche-à-bouche —
exactement ce qu'enseignent `7d456e77…` et `5e2dbc0489…` du même domaine. Une carte suivie
à la lettre dans ce cas-là fait faire le mauvais geste.

Corrigé en fix round 1 : « Ne doit pas être retiré avant les secours » reste la bonne
réponse par défaut, mais l'explication porte maintenant sa vraie portée — « Tant que le
motard respire […] S'il ne respire plus, en revanche, il faut le retirer » — et sa vraie
raison, sourcée p. 55 du livret ERC (traumatisme majeur, lésion du rachis cervical).
« Seuls habilités » et « aucune exception » sont retirés.

**Round 2 : la médecine était juste, la question ne l'était plus.** La revue a vérifié
l'explication mot pour mot contre le PDF (citation exacte, pagination correcte — le livret
grand public numérote une page derrière l'index du PDF, vérifié) et l'a jugée **correcte
dans ses deux branches** : un lecteur qui la suit laisse le casque tant que la victime
respire et le retire si elle ne respire plus. Mais l'option D, « Doit être retiré pour
dégager les voies aériennes », est **exactement** ce que l'explication prescrit dans sa
seconde branche — et l'énoncé, « Face à un motard accidenté, son casque : », n'excluait
cette branche nulle part. La carte enseignait donc, dans ses propres mots, que D est juste
dans un cas que l'énoncé admet : le test des points 2 et 14 du calibrage (« existe-t-il
une lecture où le distracteur EST la bonne réponse ? ») répondait oui, et c'est la lecture
que la carte fournissait elle-même. Corrigé en donnant à l'énoncé la même portée qu'à
l'explication : « Face à un motard accidenté **qui respire**, son casque : ». Sous cet
énoncé, D redevient faux sans ambiguïté. Ajouté au calibrage, point 14 : quand une
explication gagne un « en revanche », relire les quatre options contre la branche
nouvelle — corriger la médecine ne suffit pas tant que la question garde deux réponses.

### La dette du §9.5 n°13 de la passe 2 (« 112 »/« 119 »)

Confirmée par la revue sur la page en ligne : le titre réel de la rubrique F33954 est bien
« Enfance en danger (violences sur mineurs) : 119 et 116 111 », et la description est bien
« destiné à tout enfant ou adolescent victime de violences ». Les deux textes cohabitent
sur la même fiche sans se contredire ; réglé en étendant l'affirmation de `sources.md` vers
la **source** (le titre réel de la page), pas vers la carte — aucun texte de carte touché.
La table de preuve ci-dessous ajoute une ligne pour cette carte (`…810ca6`), qui n'en avait
pas dans la première version bien que son texte n'ait jamais bougé.

### Doutes signalés, non corrigés

Aucun doute nouveau. Le seul point qui y ressemble — la PLS enseignée sans la réserve
« pas de traumatisme » de l'ERC p. 54 — est une décision de pilotage déjà écrite dans
`sources.md` avant cette tâche, pas un doute laissé ouvert par cette relecture.

### Pédagogie

- explications sous 120 caractères : 4 à l'entrée (`…8175a7` 91, `…817bb1` 90, `…81a092`
  86, `…81f7a2` 90), 0 à la sortie.
- cartes dont le budget de 220 a limité l'explication : aucune, le domaine ne porte
  aucune illustrée.
- énoncés reformulés parce qu'ils présupposaient la règle : un, en fix round 2 —
  `37fe1af42b8d81a092` (casque), voir « Le défaut le plus grave » : l'énoncé ne portait
  aucune portée alors que la médecine en imposait une.

**`37fe1af42b8d8175a7` (déplacer victime), rewrite évidencé à part (point 1 du
calibrage) — la seule des 91 → 120 caractères que le compte agrégé ci-dessus ne détaille
pas.** Avant : « On ne déplace une victime que face à un danger vital immédiat, sinon on
attend les secours. » (91, règle seule, aucune raison ni limite explicite). Après : la
règle précise sa seule condition sourcée (danger immédiat, exemple de l'incendie), une
limite qui exclut nommément les trois motifs des distracteurs (confort, froid, demande de
la victime, puis en fix round 1 la présence d'un secouriste diplômé), et une clause de
fin qui répond à « qui la déplace alors ? » (les secours). Round 1 a ajouté la clause sur
le secouriste ; round 2 n'a pas retouché cette carte.

**Une réécriture qui gardait un compteur plat au prix de la pédagogie, corrigée.**
`fb24f6323a07a07c77` (cadence) ne disait plus, en sortie de round 0, quelle était la
cadence : « L'ERC retient une plage plus large ; la Croix-Rouge n'en garde que la borne
basse, pour simplifier l'apprentissage. Les deux sources se recoupent : aucune ne valide un
rythme plus lent, ni plus rapide, que celui qu'elles recommandent. » Plus large que
*quoi*, pour qui ne connaît pas la réponse ? La dernière phrase est une tautologie, et
« pour simplifier l'apprentissage » un motif inventé. `82a9e65c1cf2ff4a1a` (profondeur)
avait la même forme : « L'ERC et la Croix-Rouge retiennent exactement la même profondeur »
était un appel à la concordance là où la raison aurait dû être. Les deux réécritures
avaient été faites pour empêcher `expl/paraphrase-litterale` de remonter — exactement ce
que le calibrage interdit maintenant au point 20 : un compteur gardé plat au prix d'une
carte qui n'enseigne plus est un mensonge sur l'état du fichier. Les deux explications
disent maintenant le chiffre et sa raison sourcée (voir la table ci-dessus) ; le compteur
est monté en conséquence, documenté plus bas plutôt que combattu.

**13 cartes modifiées dans `questions.json` + 1 carte à registre seul modifié + 4 cartes
non modifiées = 18, sans reste.** (La première version de cette section comptait
« 14 + 4 = 18 », ce qui ne correspondait à aucun état réel du fichier : deux des
« 14 » — `…810ca6` et `b9e656cb…` — étaient explicitement notées « carte inchangée »
dans le détail, et `b9e656cb…` l'est devenue au sens plein seulement dans ce round.)

Cartes modifiées (texte JSON), les deux rounds cumulés : `1ef7d3ed…` (brûlure),
`…8122b0` (18), `…8175a7` (déplacer), `…817b90` (triangle), `…817bb1` (alerter),
`…81a092` (casque), `…81f7a2` (protéger zone), `5e2dbc0489…` (position de massage,
round 0 seulement), `5fe77bbd…` (coincée), `82a9e65c…` (profondeur), `b9e656cb…` (DAE,
round 1 seulement), `d724a3c3…` (ratio), `fb24f632…` (cadence). Registre seul modifié,
texte de carte inchangé : `…810ca6` (112, dette 112/119). Non modifiées : hémorragie
(`…814182`), PLS (`…81b592`), ordre protéger/alerter/secourir (`…81f1b1`), ordre
alerter/masser/défibriller (`7d456e77…`).

### Preuve par carte, pour les 5 cartes non modifiées

| id | rôle | règle / raison / limite |
|---|---|---|
| `37fe1af42b8d810ca665ffa0e4b32ab7` | 112 | règle (« Le 112 est le numéro d'urgence commun à toute l'Union européenne, utilisable dans tous ses pays ») + raison/limite (« l'appel d'urgence passe même quand le forfait est épuisé ou l'abonnement résilié ») + complément qui la distingue des numéros thématiques (« 119 pour l'enfance en danger » — dette 112/119 réglée sans toucher ce texte) |
| `37fe1af42b8d81418280fb4ce8ce85d2` | hémorragie abondante | règle (« Comprimer la plaie sans relâcher ») + raison (« le seul geste qui réduise le débit de l'hémorragie ») + limite (« Relâcher pour regarder la plaie annule l'effet ») |
| `37fe1af42b8d81b592ede04857b093b4` | position latérale de sécurité | règle (« En position latérale de sécurité ») + raison (obstruction des voies aériennes sur le dos, drainage sur le côté) + **pas de limite portée par la carte elle-même** : la réserve ERC (pas de PLS en cas de traumatisme) est **sciemment non appliquée**, décision de pilotage déjà écrite dans `sources.md`, non rouverte ici (correction du round 0, qui appelait « limite » ce qui n'était que la seconde moitié de la raison) |
| `37fe1af42b8d81f1b1cdfef31d2461b8` | protéger/alerter/secourir | règle (« Protéger – Alerter – Secourir ») + raison, non citée mot pour mot mais définitionnelle (le sens même de « protéger » en secours routier, recoupé par `…81f7a2` du même domaine) + **pas de limite distincte** : la séquence n'a pas d'exception affirmée, signalé plutôt que masqué |
| `7d456e77187812e3a27ca828062d7938` | alerter/masser/défibriller | règle (« Alerter, masser, défibriller ») + raison sourcée mot pour mot (« chaque minute de retard avant la défibrillation fait chuter les chances de survie d'environ 10 % ») + limite (« Masser […] jusqu'à l'arrivée de l'appareil ») |

### Les options

Trois distracteurs allongés pour vrai en round 0 (marcher **seule**, mettre à l'abri,
**pour vous aider**) — des confusions réelles, pas des remplissages. Deux défauts trouvés
par la revue et corrigés en fix round 1 :

- `37fe1af42b8d8175a7…` (déplacer victime), option D — « Jamais, même si le véhicule
  prend feu » était éliminable par pure forme : seule option absolue (« jamais »), la plus
  courte des quatre, et contredite mot pour mot par l'option C qui couvre déjà le cas de
  l'incendie. Remplacée par « Seulement si un secouriste diplômé est présent sur place »,
  une confusion réelle (l'idée qu'il faudrait un tiers qualifié pour agir), qui ne se
  laisse plus éliminer par sa seule forme.
- `37fe1af42b8d81a092…` (casque), option C — « N'a pas d'incidence sur la conduite à
  tenir » était une variante de « rien », le type de distracteur que les règles 6/7 du §1
  de `questions.md` (« jamais aucune… », comptage des distracteurs récurrents) ciblent.
  Remplacée par « Peut être retiré pour vérifier l'identité de la victime », une confusion
  réelle et non un remplissage.

**Round 2, minor : un distracteur introduit en round 0 restait sans réfutation.**
`37fe1af42b8d8175a7…` (déplacer victime), option D, remplacée en round 0 par « Seulement
si un secouriste diplômé est présent sur place » (voir ci-dessus) : un vrai distracteur,
mais que l'explication ne réfutait pas — elle n'excluait que « le confort, le froid, la
propre demande » de la victime. Corrigé : « ni la présence d'un secouriste diplômé » ajouté
à l'énumération des motifs insuffisants.

**Une carte encore fausse après round 0, corrigée en fix round 1 : `…f7a2` (protéger
zone).** L'option C, allongée en round 0 en « … pour les mettre à l'abri », et
l'explication qui affirmait en plus « Déplacer les victimes n'est pas un geste de
protection : c'est un geste de secours » ouvraient une lecture où C devenait défendable —
la doctrine du dégagement d'urgence range précisément le déplacement d'une victime en
danger dans les gestes de protection, et l'affirmation n'était sourcée nulle part
(points 2 et 14 du calibrage). Fix round 1 : l'explication réfute C sur son motif propre
(« pour les mettre à l'abri » n'est pas un danger immédiat) et la classification retirée —
mais en écrivant « ce n'est pas un danger immédiat, **la seule condition qui autorise à
déplacer une victime** », ce qui donne mot pour mot la bonne réponse de la carte voisine
`37fe1af42b8d8175a7…` (« Si elle court un danger immédiat […] »), dont l'explication ouvre
elle-même sur « **Le seul motif qui autorise à déplacer une victime** est un danger
immédiat ». `--fuites` est structurellement aveugle ici : il lui faut les cinq mots pleins
de la bonne réponse au complet, et seuls deux y sont — exactement le cas que les points 5
et 17 réservent à la relecture manuelle, et la première version de cette section
affirmait le contraire (« `…f7a2` ne redonne pas la condition de `…8175a7` au-delà d'un
renvoi de sens »), sur la phrase que ce même fix venait de réécrire. **Round 2** :
l'exclusivité retirée, l'explication réfute C sur son seul motif (« ce n'est pas un
danger immédiat »), sans nommer la condition unique.

**Une carte qui redonnait la réponse de sa voisine, non vue par `--fuites` (point 13),
manquée en round 0.** `37fe1af42b8d8122b0…` (18) finissait sur « le **112** l'appel
européen qui redirige vers l'un des trois » — `112` étant, mot pour mot, la bonne réponse
de la carte voisine `…810ca6`. `--fuites` ne le voit pas (« 112 » ne compte aucun mot
plein), ce qui est exactement pourquoi le point 13 impose un grep à la main — et le round 0
affirmait « aucune occurrence hors de sa propre carte », sur une phrase que son propre
diff venait de réécrire. Corrigé : l'énumération s'arrête à « le 17 la police ou la
gendarmerie », le quatrième numéro étant décrit (« standard européen commun ») sans être
nommé.

**`d724a3c3…` (ratio) — une ouverture qui contournait le test de substring sans corriger
le fond, corrigée.** Le round 0 avait remplacé « 30 compressions **et** 2 insufflations »
par « 30 compressions **puis** 2 insufflations » — un mot changé, qui passe sous
`audit.py:194` (test de sous-chaîne) sans satisfaire le critère 4 (l'explication reste une
reformulation de la bonne réponse). Fix round 1 : l'explication redit le chiffre tel quel
et assume la sortie de `expl/paraphrase-litterale` — la classe structurelle du point 8, un
chiffre repris qui porte en plus sa raison (voir la table des écarts).

Aucun autre distracteur du lot n'a paru éliminable par pure logique, isolé par la forme, ou
légitimé par sa propre carte.

**Fuite (point 5/17 du calibrage) — une seule, éteinte en round 0.** `5e2dbc048917`
(position de massage) citait dans son explication les trois mots pleins de la bonne
réponse de `…81b592` (« position latérale de sécurité »), contenu vrai et sourcé (ERC
p. 54) mais qui donnait la réponse d'une autre carte mot pour mot. Reformulé pour garder le
fait sans les trois mots. `python3 Tools/relire.py --fuites "Premiers secours"` : 1
recouvrement avant correction, 0 après, **et 0 après le fix round 1**.

**Point 13 (réponses courtes que `--fuites` ignore) — grep à la main, une réponse
manquante en round 0.** Bonnes réponses sous le seuil de trois mots pleins : « 112 »,
« 18 », « 5 à 6 centimètres » (1 mot plein), « 100 à 120 compressions par minute »
(2 mots), « 30 compressions et 2 insufflations » (2 mots), et **`5e2dbc0489…`, « Sur le
dos, à plat, sur un support ferme »** (2 mots : `support`, `ferme`) — absente de la liste
du round 0, qui en comptait cinq au lieu de six, exactement le piège du découpage naïf déjà
nommé au point 13 du calibrage. `grep` de chacune des six contre les 17 autres
explications du domaine, refait en fix round 1 : aucune occurrence hors de sa propre carte.

**Point 17 (relecture à la main, distincte du point 13) — refaite en fix round 1 sur le
texte corrigé.** Le lot chaîné relu côte à côte après les corrections de casque et de
coincée (qui introduisent « rachis cervical », « masser », « bouche-à-bouche ») : aucun de
ces mots ne recoupe les trois mots pleins des bonnes réponses de `7d456e77…`
(« alerter », « masser », « défibriller » — aucun des trois ne s'y trouve) ni de `d724a3c3…`
(« compressions », « insufflations » — sous le seuil de toute façon). Aucune fuite
nouvelle introduite par les corrections de ce round.

**Round 2 : la fuite de `…f7a2` vers `…8175a7` (ci-dessus, « Les options ») qualifie cette
affirmation — elle n'était pas la seule, et deux recouvrements partiels, en dessous du
seuil des trois mots pleins mais réels, restent dans le fichier sans y avoir été
introduits par cette tâche : `d724a3c3121fafd733`, dans la clause inchangée « comprimer
seul, sans interruption, **à au moins 100 par minute** », partage deux mots pleins
(`moins`, `minute`) avec la bonne réponse de `fb24f6323a07a07c77` (« 100 à 120
compressions **par minute** », qui en compte deux elle-même : `compressions`, `minute`) —
sous le seuil de trois qui déclencherait `--fuites`, donc un recouvrement fortuit, pas une
fuite au sens du point 11. `5fe77bbd3af80ab119`, dans sa clause de fin inchangée
« protéger, alerter, puis rester en contact », redit dans l'ordre deux des trois mots
pleins de la bonne réponse de `37fe1af42b8d81f1b1` (« Protéger – Alerter – Secourir ») —
également sous le seuil. Aucun des deux n'est corrigé : ce sont des mots communs au
vocabulaire du domaine (« minute », « protéger », « alerter »), pas la réponse entière, et
les deux existaient avant cette tâche.

**`correctID` — mesuré avant et après édition, aucune rotation nécessaire.** Avant : A 5,
B 4, C 4, D 5 (18 cartes). Aucune lettre n'a changé de carte pendant cette tâche
(rééquilibrage par longueur d'option, pas par rotation) : distribution après identique.

### Les quatre `expl/paraphrase-litterale`

`37fe1af42b8d810ca6` (« 112 ») et `37fe1af42b8d8122b0` (« 18 ») : classe 2 du point 8/16
du calibrage, faux positif structurel — chiffre court repris, non corrigé, comme
attendu.

**Deux occurrences nouvelles, assumées en fix round 1, pas évitées au prix du contenu.**
`fb24f6323a07a07c77` (« 100 à 120 compressions par minute ») et `d724a3c3121fafd733`
(« 30 compressions et 2 insufflations ») redisent désormais leur bonne réponse en toutes
lettres — et portent chacune, dans la même phrase ou la suivante, une raison sourcée
absente de la version qui évitait le chiffre (voir la table des écarts). Classe 2 des deux :
un chiffre ou un couple de chiffres, repris légitimement, qui n'est plus seul dans
l'explication. `expl/paraphrase-litterale` : 17 avant ce fix round, **19 après** — une
hausse assumée, documentée ici, pas combattue en rongeant la pédagogie (calibrage
point 20). Pour mémoire, la version précédente de cette section annonçait « Deux »
occurrences évitées puis en nommait trois et écrivait « Les trois » — la version
corrigée en nomme trois, correctement : `…817bb1`, `82a9e65c…` et `fb24f632…` avaient
chacune, à un moment du brouillon, reproduit leur bonne réponse mot pour mot avant d'être
réécrites (`…817bb1` définitivement, les deux autres réintroduites volontairement en fix
round 1 pour la raison ci-dessus).

**Une collision évitée pendant la correction du round 0, non liée au compteur final.**
En corrigeant `1ef7d3ed…` (brûlure), une première tentative écrivait « 15 et 25 °C » :
`audit.py` interprète le « C » isolé de « °C » comme une référence de lettre
(`lettre/reference`, regex `(?<![\w`.\-])[A-D](?![\w'’])`, qui ne reconnaît pas « ° »
comme caractère de mot). Détecté par un audit intermédiaire avant commit, corrigé en
« 15 et 25 degrés » ; `lettre/reference` est resté à 1 (le faux positif connu, hors
domaine) du premier au dernier audit de cette tâche.

### Minors du round 2

- **`fb24f6323a07a07c77` (cadence), attribution corrigée dans `sources.md`.** La ligne
  faisait dire à la citation ERC sur le relâchement (« avoiding leaning on the chest
  between compressions to allow full chest wall recoil ») qu'elle motivait le plafond de
  120 min⁻¹ ; elle motive le relâchement lui-même, et le même document précise qu'aucune
  étude ne porte sur les mesures de « leaning ». Le lien rythme → relâchement incomplet
  que porte l'explication de la carte est mécaniquement sûr mais reste une inférence de la
  carte, pas une affirmation de l'ERC sous cette forme — la ligne le dit maintenant
  (point 3 du calibrage : le registre suit la source).
- **`1ef7d3ed540293c212` (brûlure), réfutation corrigée sur deux options.** L'explication
  attribuait aux cloques percées le même effet qu'au corps gras (« retardent tous deux la
  cicatrisation ») ; la page dit autre chose pour chacune — barrière naturelle contre
  l'infection pour les cloques, chaleur retenue et cicatrisation ralentie pour le corps
  gras. Les deux citations exactes ajoutées à `sources.md` dans le même geste que la
  correction de la carte (elles n'y étaient pas, alors que la clause précédente s'appuyait
  déjà sur la page sans la citer).
- **`5fe77bbd3af80ab119` (coincée), description corrigée dans cette section** (voir la
  table des raisons restaurées) : la carte n'a jamais retiré sa clause d'ouverture non
  sourcée, contrairement à ce qu'affirmait la version précédente.

### Mouvements d'`audit.py`

| sortie | avant tâche 9 | après round 0 | après fix round 1 | après fix round 2 |
|---|---|---|---|---|
| `lettre/reference` | 1 | 1 | 1 (un aller-retour à 2 pendant l'édition, corrigé avant commit) | 1 |
| `forme/markdown` | 1 | 1 | 1 | 1 |
| `forme/seule-ponctuee` | 14 | 14 | 14 (aucune carte du domaine) | 14 |
| `longueur/plus-longue` | 93 | 90 | 90 (aucune option retouchée n'a changé son statut de plus longue) | 90 (l'énoncé de `…81a092` a bougé, pas ses options ; aucun changement de statut) |
| `expl/paraphrase-litterale` | 17 | 17 | **19** (deux occurrences nouvelles, classe 2, documentées ci-dessus — hausse assumée) | 19 (inchangé ; les quatre occurrences du domaine reclassées classe 2, aucune classe 1 ni 3, confirmé par un rejeu local d'`audit.py:194`) |
| `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10`, `forme/backtick-isole` | vides | vides | vides | vides |

`python3 Tools/relire.py --fuites` sur les huit domaines déjà traités (les sept
précédents et « Premiers secours ») : **0** partout, avant, après le fix round 1 et après
le fix round 2.

**Vérifications, fix round 1.**

```
$ python3 Tools/audit.py > .passe3/apres-09-r2.txt
$ diff <(grep -E '^### ' .passe3/apres-09b.txt) <(grep -E '^### ' .passe3/apres-09-r2.txt)
5c5
< ### expl/paraphrase-litterale  (17)
---
> ### expl/paraphrase-litterale  (19)
```
```
$ python3 Tools/relire.py --fuites "Premiers secours"
0 recouvrement(s) sur 18 cartes de « Premiers secours ».
$ for d in "Permis & sanctions" "Vitesse" "Alcool & stupéfiants" "Usagers & partage de la route" \
           "Mécanique & environnement" "Distances & freinage" "Arrêt & stationnement"; do
    python3 Tools/relire.py --fuites "$d" | tail -1
  done
0 recouvrement(s) sur 19 cartes de « Permis & sanctions ».
0 recouvrement(s) sur 22 cartes de « Vitesse ».
0 recouvrement(s) sur 18 cartes de « Alcool & stupéfiants ».
0 recouvrement(s) sur 18 cartes de « Usagers & partage de la route ».
0 recouvrement(s) sur 20 cartes de « Mécanique & environnement ».
0 recouvrement(s) sur 21 cartes de « Distances & freinage ».
0 recouvrement(s) sur 17 cartes de « Arrêt & stationnement ».
```
```
$ python3 -c "…"  # ids
mêmes ids : True | 448 -> 448
```

`✔ Test run with 10 tests in 0 suites passed after 0.062 seconds.` / `** TEST SUCCEEDED **`
sur les dix tests du contenu livré, simulateur `iPhone 17 Pro`
(`66921B37-1805-4988-AB69-B51A94490BC0`). `git status --short` avant `git add`, fix
round 1 : `Tools/sources.md` et `Valido/Resources/questions.json` modifiés, `CLAUDE.md`
toujours untracked, aucun `Contents.json` reformaté.

**Vérifications, fix round 2.**

```
$ python3 - <<'EOF'
import json
p = 'Valido/Resources/questions.json'
d = json.load(open(p))
with open(p, 'w', encoding='utf-8') as f:
    json.dump(d, f, ensure_ascii=False, indent=2, sort_keys=True)
    f.write('\n')
print(len(d), 'questions')
EOF
448 questions
$ python3 -c "…"  # ids
mêmes ids : True | 448 -> 448
```
```
$ python3 Tools/audit.py > .passe3/apres-09-r5.txt
$ diff <(grep -E '^### ' .passe3/apres-09-r4.txt) <(grep -E '^### ' .passe3/apres-09-r5.txt)
(vide — aucune sortie n'a bougé)
```
```
$ python3 Tools/relire.py --fuites "Premiers secours"
0 recouvrement(s) sur 18 cartes de « Premiers secours ».
$ for d in "Permis & sanctions" "Vitesse" "Alcool & stupéfiants" "Usagers & partage de la route" \
           "Mécanique & environnement" "Distances & freinage" "Arrêt & stationnement"; do
    python3 Tools/relire.py --fuites "$d" | tail -1
  done
0 recouvrement(s) sur 19 cartes de « Permis & sanctions ».
0 recouvrement(s) sur 22 cartes de « Vitesse ».
0 recouvrement(s) sur 18 cartes de « Alcool & stupéfiants ».
0 recouvrement(s) sur 18 cartes de « Usagers & partage de la route ».
0 recouvrement(s) sur 20 cartes de « Mécanique & environnement ».
0 recouvrement(s) sur 21 cartes de « Distances & freinage ».
0 recouvrement(s) sur 17 cartes de « Arrêt & stationnement ».
```

`✔ Test run with 10 tests in 0 suites passed after 0.068 seconds.` / `** TEST SUCCEEDED **`
sur les dix tests du contenu livré, simulateur `iPhone 17 Pro`
(`66921B37-1805-4988-AB69-B51A94490BC0`). `git status --short` avant `git add`, fix
round 2 : `Tools/sources.md` et `Valido/Resources/questions.json` modifiés, `CLAUDE.md`
toujours untracked, aucun `Contents.json` reformaté.

## Tunnels & passages à niveau

15 cartes, 8 `datée`, 3 illustrée(s).

### Écarts de justesse trouvés

| id | écart | ce que disait la carte | ce que dit l'article | correction |
|---|---|---|---|---|
| `8a6af9d26330dc0f3bfd95d9bf0d7b81` | règle trop large | « chaque traversée automatique porte soit un téléphone d'alerte, soit une pancarte » — universel, sans condition | art. 12 de l'arrêté du 18 mars 1991 : ce choix ne vaut qu'« au plus tard au 1er janvier 2020 » et **en dessous** d'un certain trafic (« moment de circulation… inférieur à 30 000 ») ; au-delà, l'article impose deux postes téléphoniques, sans option de pancarte | explication réécrite pour porter la condition (détail des rondes ci-dessous) |
| `3a06288bf73bb5254b83a371ae55a854` | explication au-delà de l'article | « Savoir combien il en reste devant soi décide de tout le reste : en cas d'incendie, entre ressortir par ses propres moyens et gagner à pied une issue de secours » — un mécanisme causal reliant longueur du panonceau et décision d'incendie, propre au domaine (le brief nommait d'avance ce piège : « la fumée monte, donc… ») | l'affirmation ne porte que la nomenclature du panonceau M2 (IISR 5e partie, art. 75-2, 1) ; aucune source blanche ne relie la lecture du panonceau à un arbitrage incendie | clause coupée (détail des rondes ci-dessous) |
| `7148c3a8be7130501aa3da1644986ebb` | explication au-delà de l'article | « L'ordre compte donc — couper le contact, évacuer avec tous les passagers, gagner une issue de secours, et alerter ensuite […] » — affirme un ordre strict entre « gagner l'issue » et « alerter » | relecture complète de la page (`WebFetch`, `?_format=json`) : la section « En cas d'incendie » est une suite de branches conditionnelles, et l'alerte (branche 2) précède toute mention des issues de secours (branche 5) — l'inverse de ce que la carte affirmait | réécrite deux fois (round 0 puis fix round 1, détail ci-dessous), la carte du fix round 1 était elle-même fautive sur deux autres points, voir plus bas |

### Doutes signalés, non corrigés

| id | ce qui est douteux | ce qui a été lu | ce qui manque |
|---|---|---|---|
| `d50cd498f6e5261eb5a2fc9dfe45de90` | le distracteur D, « reculez pour repasser derrière le bras d'entrée », est-il faux pour une raison qu'une source blanche affirme, ou seulement en pratique ? | `WebFetch` sur la page « Passage à niveau » de `securite-routiere.gouv.fr` (rang 2) : « Dégagez votre véhicule en enfonçant la barrière, elle est conçue pour ne pas résister à ce type de choc. » « Évacuez tous les passagers du véhicule. » « Alertez au plus vite un agent SNCF avec le téléphone du passage à niveau ou composez le numéro inscrit sur la pancarte. » — aucune mention d'un sens à privilégier, ni des barrières « intérieures ». Un premier jet de ce rapport citait entre guillemets une phrase sur des « stickers réfléchissants… barrières intérieures » : cette phrase n'est **pas** sur cette page (vérifié en la refetchant), et a été retirée plutôt que corrigée par une meilleure citation, faute d'en trouver une | une source de rang 1/2/3 qui tranche le sens (avancer plutôt que reculer) une fois pris entre quatre demi-barrières cassables. Le distracteur reste jugé faux, mais sur un fondement générique non sourcé (reculer reprend à l'aveugle, sous pression, un trajet déjà engagé), du même registre que la raison non sourcée mais non contestée de `bda52045` (l'œil et la pénombre) — la carte elle-même n'affirme aucun sens, son énoncé ne parlant que de « forcer le bras » |

### Pédagogie

- explications sous 120 caractères : 0 à l'entrée, 0 à la sortie. Le domaine part
  d'explications déjà étoffées (médiane 304 caractères) ; le travail a porté sur la
  justesse, les fuites et le critère 3 (rule/reason/limite), pas sur un allongement de
  texte.
- cartes dont le budget de 220 a limité l'explication : `1e329fa1bba26cabf5` (moteur cale)
  est la seule des trois illustrées à avoir été réécrite, en 200/220 après le fix round 1
  (220/220 pile au round 0, sans marge et avec une redite — voir « Fix round 1 » ci-dessous).
  `1cc2591b8808d4aa73` (205/220) et `d50cd498f6e5261eb5` (208/220) n'ont pas été touchées.
- énoncés reformulés parce qu'ils présupposaient la règle : aucun.
- **critère 3 (règle/raison/limite) relu sur les 15 cartes, pas seulement les flaguées** :
  trois cartes sans écart de justesse échouaient franchement à ce critère
  (`c084813ff73eacb15d`, sans la règle elle-même ; `d4b4abfd51499d4ab3`, sans raison ;
  `763ae1f8c7040ecb17`, avec une réfutation de distracteur étiquetée « limite » à la place
  de la vraie limite). Réécrites au fix round 1, détail ci-dessous.

### Round 0 — trois écarts de justesse, deux fuites, cinq cartes modifiées

Repris tel quel du premier jet de cette tâche :

- `8a6af9d26330dc0f3b`, `3a06288bf73bb5254b`, `7148c3a8be7130501a` — les trois écarts de
  justesse ci-dessus.
- `1e329fa1bba26cabf5`, `1fe6ef49aad916e076` — deux fuites trouvées par
  `relire.py --fuites` (détail dans « Fuites » ci-dessous), sans rapport avec la justesse.

### Fix round 1 — la carte incendie était fautive sur trois points, plus criterion 3 sur trois autres cartes, plus deux longueurs

Une revue a confronté la réécriture du round 0 à l'énoncé et aux options, pas seulement à
la source — c'est le complément apporté au point 18 du calibrage (« pas inventé » n'est
pas « correct »).

**1. `7148c3a8be7130501a` — le refus spatial était faux dans l'autre sens.** L'énoncé pose
« Un véhicule prend feu **devant vous** » ; l'option C est « faire demi-tour **pour
ressortir par l'entrée** ». La réécriture du round 0 réfutait C par « faire demi-tour
**vers le foyer** revient à s'y exposer » : un demi-tour éloigne du feu qui est devant,
il n'en rapproche pas. La dérivation coupée au round 0 (« la fumée remonte l'ouvrage plus
vite qu'un piéton ») n'était pas sourcée, mais celle qui l'a remplacée était fausse, pas
seulement non sourcée — un défaut plus grave. Une première correction a essayé de réparer
C par l'interdiction que porte le panneau C111 (« interdit de faire demi-tour, en tout
point », sourcée sur la ligne de `5c11020dc34bf45d56cf8438dd8ad79e`) ; relue contre les
options de `5c11020d`, cette formulation aurait donné d'avance sa bonne réponse
(« d'y faire demi-tour, en tout point ») à qui lit les deux cartes — exactement le défaut
que la ligne de `5c11020d` évite déjà pour `bda52045`. Fixée sans invoquer le C111 : le
distracteur est réfuté par le même risque que « rester à bord » (le temps perdu à
manœuvrer, quel que soit le sens, laisse la fumée rejoindre le conducteur), un fait
générique qui ne redit la réponse d'aucune autre carte.
- **2. « avec tous les passagers » avait disparu.** La branche 5 de la page dit
  « quittez votre véhicule **avec tous les passagers** » ; le round 0 l'avait perdue en
  réécrivant. Restaurée.
- **3. La carte enseignait encore l'ordre qu'elle prétendait avoir cessé d'enseigner.**
  Le round 0 écrivait « gagner l'issue de secours la plus proche ; **on y** alerte » — le
  « y » renvoyant à l'issue de secours, l'alerte restait placée après elle, l'inverse de
  ce que la page soutient (l'alerte est la branche 2, avant toute mention des issues de
  secours). Découplé : « On alerte par les téléphones de secours de l'ouvrage, jamais
  depuis un mobile personnel », sans « y » et sans lien de succession avec la phrase qui
  précède. La raison du canal, que la page donne gratuitement (« qui ne permettent pas de
  vous localiser »), est ajoutée — la carte ne se contentait plus d'interdire le mobile,
  elle ne disait pas pourquoi.
- Explication finale (350 caractères, non illustrée) : « Rester à bord ou revenir sur ses
  pas revient à laisser la fumée vous rejoindre, elle qui tue avant les flammes. La
  priorité est de couper le moteur et de sortir avec tous les passagers vers l'issue de
  secours la plus proche. On alerte par les téléphones de secours de l'ouvrage, jamais
  depuis un mobile personnel, qui ne permet pas de vous localiser. » Règle (couper le
  moteur, tous les passagers, issue de secours) + raison (la fumée tue avant les flammes,
  quel que soit ce qu'on tente d'autre) + canal sourcé avec sa raison.
- **4. `Tools/sources.md:405` se contredisait elle-même.** La ligne ouvrait encore sur
  « couper le contact, évacuer avec tous les passagers, gagner une issue de secours,
  donner l'alerte par les téléphones de l'ouvrage » — exactement la séquence que la note
  ajoutée en dessous qualifiait de non soutenue, et « couper le contact » n'est ni ce que
  dit la page (« coupez votre moteur en laissant la clé sur le contact ») ni ce que dit la
  carte (« couper le moteur »). Réécrite : la tête de ligne porte maintenant les branches
  de la page, citées mot pour mot dans leur ordre réel, avec la raison du canal ; la note
  datée devient la trace du fix plutôt qu'une justification qui contredisait la tête.
- **Une carte de plus au fait : `5c11020dc34bf45d56` protégeait `bda52045` mais pas
  `1e329fa1`.** Sa ligne de registre documentait déjà avoir coupé la prescription
  « feux de croisement » pour ne pas donner d'avance la réponse de `bda52045` ; elle
  citait encore « arrêt et stationnement interdits hors des emplacements d'arrêt
  d'urgence », qui nomme l'emplacement d'arrêt d'urgence — la bonne réponse de
  `1e329fa1bba26cabf5` — et élimine au passage deux de ses distracteurs (« faire
  demi-tour », « vous arrêter sur place »). `--fuites` ne le voit pas : « emplacements »
  (carte) contre « emplacement » (réponse) est une inflexion différente. Coupée à son
  tour ; l'explication ne nomme plus que l'interdiction de faire demi-tour.
- **Criterion 3 sur trois cartes non touchées par la justesse ni par une fuite :**
  - `c084813ff73eacb15d` — l'explication donnait la raison (l'annonce est calée sur le
    train) et réfutait des distracteurs, mais **n'énonçait jamais la règle elle-même**
    (vingt secondes). Ajoutée en tête : « Les feux s'allument vingt secondes au moins
    avant l'arrivée du train ». Le §1 de `questions.md` autorise explicitement la reprise
    d'une réponse chiffrée ; `expl/paraphrase-litterale` en gagne une occurrence
    (voir « Mouvements d'`audit.py` »), classée faux positif structurel du point 8 du
    calibrage, pas corrigée en sens inverse.
  - `d4b4abfd51499d4ab3` — aucune raison : la carte disait la règle et la limite
    (« la règle ne demande pas de juger le risque : elle demande d'attendre la place »)
    sans jamais dire *pourquoi* un véhicule immobilisé est dangereux. Ajoutée : « Un train
    ne peut ni s'arrêter court ni se déporter : un véhicule resté sur les rails
    deviendrait un obstacle qu'il percuterait sans pouvoir l'éviter » — le même fait
    générique, non sourcé par un article mais non contesté non plus, que celui qui
    fonde déjà la bonne réponse de `d50cd498` (« il ne peut pas s'arrêter court »).
  - `763ae1f8c7040ecb17` — la phrase étiquetée « limite » dans la table du round 0
    réfutait en réalité le distracteur des voies multiples ; la vraie limite (à quel
    moment le passage redevient permis) n'était pas dite. Ajoutée : « Barrières relevées
    et immobiles, en revanche, le passage redevient libre. » Relu contre les quatre
    options après l'ajout du « en revanche » (point 14 du calibrage) : aucune ne devient
    défendable — l'option A (« seulement une fois les demi-barrières immobiles ») ne
    précise pas « relevées » et reste donc fausse, les options B et C sont sans rapport
    avec cet état.
  - `bda520451eb11447c3` — la table du round 0 étiquetait « sans condition d'heure ni
    d'éclairage de l'ouvrage » comme la limite, alors que c'est une reformulation de la
    règle elle-même ; la vraie limite (jusqu'où l'obligation court) était déjà sourcée sur
    cette même ligne de registre (« le C112 indique également la fin des prescriptions
    édictées par le panneau C111 ») mais absente de la carte. Ajoutée en fin
    d'explication : « Cette obligation vaut jusqu'au panneau de sortie, le C112, qui la
    termine. » Aucun ajout à `sources.md` : le fait y était déjà.
- **Deux longueurs.** `7148c3a8` — la carte d'urgence la plus lourde du lot — avait sa
  bonne option la plus longue (+4) : l'option C, réécrite pour le point 1
  ci-dessus, est passée de 43 à 76 caractères, et la bonne option D (47) n'est plus la
  plus longue (delta −29). `8a6af9d26330dc0f3b` avait sa bonne option la plus longue de
  +1 ; touché dans le même geste, l'option B est passée de « la vitesse à ne pas dépasser
  sur la traversée » à « la vitesse **maximale** à ne pas dépasser sur la traversée »
  (54 caractères, delta −8). Deux cartes du lot restent avec la bonne option la plus
  longue ou à égalité — `5ae4a8d7800141787a` (+3) et `d3af170839b4cf693c` (égalité,
  delta 0, jamais signalée par `audit.py` qui ne teste que `delta > 0`) — inchangées :
  aucun texte de ces deux cartes n'a été touché par cette tâche, aux deux rondes, et la
  revue les qualifie de préexistantes plutôt que de les faire porter par ce fix.
- **`8a6af9d26330dc0f3b`, minor : « de part et d'autre des rails » rattaché aux deux
  branches.** La citation ne l'attache littéralement qu'aux pancartes (« Ces pancartes
  sont installées… de part et d'autre des voies ferrées ») ; la phrase de la carte le
  laissait lire comme valant aussi pour le téléphone seul. Réattaché à la seule pancarte :
  « une pancarte donnant ce numéro **et posée de part et d'autre des rails** ».
- **`3a06288bf73bb5254b`, minor : raison quasi tautologique et absence de limite.**
  Réécrite : « Un panonceau ne redit jamais le panneau qu'il accompagne, il en précise la
  portée […] » (raison : ce type de contenu plutôt qu'un autre) et « Cette indication
  n'existe que là où l'entrée elle-même doit l'être — un tunnel trop court pour l'exiger
  n'en porte pas » (limite, sans citer le seuil de 300 m que la ligne interdit d'affirmer).
- **`1e329fa1bba26cabf5`, minors : redite et modificateur mal accroché.** La version du
  round 0 tenait à 220/220 pile en disant deux fois la même chose (« ne prévoit aucun
  espace pour se ranger ailleurs qu'au refuge » / « c'est le seul endroit prévu pour s'y
  arrêter ») et faisait pendre « Signalé et souvent doté d'un poste d'appel » avec
  « le véhicule immobilisé » entre les deux occurrences de son antécédent. Réécrite :
  « Une chaussée de tunnel n'a ni voie de secours ni bas-côté : le véhicule immobilisé y
  devient l'obstacle. Le refuge — signalé, souvent doté d'un poste d'appel — est le seul
  point prévu pour s'y ranger. » (200/220). « Refuge » n'apparaît plus qu'une fois comme
  sujet, ses deux qualificatifs entre tirets juste avant son verbe.
- **`d50cd498f6e5261eb5`, vérification demandée.** Voir « Doutes signalés, non corrigés »
  ci-dessus : la citation sur les « barrières intérieures » n'a pas résisté à un nouveau
  `WebFetch` et est retirée sans être remplacée par une autre citation, faute d'en trouver
  une qui tranche le sens.

### Preuve par carte, pour les 5 cartes non modifiées

Dix cartes ont été réécrites, aux deux rondes, pour justesse, fuite ou critère 3 (voir
ci-dessus) ; il en reste cinq dont le texte n'a jamais bougé. Règle / raison / limite
telles que la carte les dit — et, quand l'étiquette « limite » ne correspond pas au
troisième temps, le dire plutôt que le maquiller (le défaut nommé sur `bda52045` et
`763ae1f8` au fix round 1) :

| id | rôle | règle / raison / limite |
|---|---|---|
| `1cc2591b8808d4aa73` | balises J10 (nombre de bandes) | règle (« la première … porte trois bandes ; les suivantes en portent deux, puis une seule ») + raison (« Moins il reste de bandes, plus la voie ferrée est proche ») + **pas de limite distincte, honnêtement** : nomenclature descriptive, les trois balises épuisent le champ, aucune condition à poser |
| `d50cd498f6e5261eb5` | demi-barrières abaissées, véhicule sur les rails | règle (« avancez en forçant le bras, conçu pour céder ») + raison (« la priorité du convoi est absolue et il ne peut pas s'arrêter court : dégager passe avant tout le reste ») + **pas de limite distincte, honnêtement** : « l'alerte à l'exploitant ne vient qu'ensuite » réfute l'ordre inverse de l'option A, ce n'est pas une borne du champ d'application |
| `5ae4a8d7800141787a` | arrêt le long de la chaussée en tunnel | règle (« est gênant, au même titre que sur un pont ») + raison (« une chaussée de tunnel n'a ni accotement ni échappatoire, et un véhicule laissé dessus devient l'obstacle ») + limite réelle (« sauf décision contraire de l'autorité de police ») |
| `d3af170839b4cf693c` | PN sans barrière ni feu | règle (« traversez après avoir regardé des deux côtés ») + raison (« le code ne demande pas l'arrêt mais la certitude : on ne s'engage qu'après s'être assuré qu'aucun convoi n'approche ») + limite réelle (« l'arrêt obligatoire existe, mais il tient à un panneau posé là par arrêté du préfet, jamais à l'absence de barrière ») |
| `a88bdac8ef012091a9` | intervalle de sécurité en tunnel | règle (« peut être allongé par l'autorité de police ») + raison (« deux secondes partout, puis réserve un cas… ») + limite réelle (« aucun chiffre national ne s'attache au tunnel — c'est la signalisation de l'ouvrage qui dit l'intervalle à tenir, et elle se lit à l'entrée ») |

Modifiées 10 (`8a6af9d2`, `3a06288b`, `7148c3a8`, `1e329fa1`, `1fe6ef49aad9`, `5c11020d`,
`c084813f`, `d4b4abfd`, `763ae1f8`, `bda52045`) + non modifiées 5 = 15, sans reste.
`a88bdac8ef012091a9` n'a jamais eu son texte touché dans `questions.json` : seule sa ligne
de `sources.md` a reçu un renvoi (round 0) ; comptée ici parmi les non modifiées.

### Les options

Relues carte par carte contre les sept règles du §2 de `questions.md`, puis contre le
point 14 du calibrage (« existe-t-il une lecture où le distracteur EST la bonne
réponse ? »), aux deux rondes.

- `d50cd498f6e5261eb5` (demi-barrières abaissées) — le distracteur D, « reculez pour
  repasser derrière le bras d'entrée », a été confronté au risque d'être une seconde
  réponse défendable (les quatre demi-barrières sont également cassables). Signalé en
  doute plutôt que tranché : voir « Doutes signalés, non corrigés ».
- `1fe6ef49aad916e076` (franchir irrégulièrement) — les quatre chiffres de points (2, 4,
  6, 3) sont chacun un palier réel du barème : aucun n'est inventé.
- `7148c3a8be7130501a` (véhicule prend feu) — l'option C, réécrite au fix round 1 pour
  porter le refus spatial correct (voir ci-dessus), reste une seconde lecture rejetée à
  dessein : « face aux véhicules qui arrivent » décrit un risque réel du demi-tour en
  tube unique sans affirmer qu'il est interdit, pour ne pas donner d'avance la réponse de
  `5c11020d`.
- Aucun autre distracteur du lot n'a paru, aux deux lectures, éliminable par pure
  logique, isolé par la forme, ou légitimé par sa propre carte — y compris sur les cinq
  cartes non modifiées listées ci-dessus.

**`correctID` — déjà équilibré, aucune rotation.** Mesuré avant toute édition : A 4, B 4,
C 4, D 3 sur 15. Les dix éditions touchent `explanation` et, sur deux cartes
(`7148c3a8`, `8a6af9d2`), une longueur d'option — jamais `correctID` ni le sens d'une
bonne réponse. Distribution après les deux rondes : inchangée, A 4 / B 4 / C 4 / D 3.

### Fuites — point 13 et point 17, séparément

**Point 13 — réponses sous trois mots pleins, grep à la main sur énoncés et explications
de toute la banque, avec des identifiants complets (pas tronqués à 12 caractères, qui
regroupe à tort plusieurs cartes distinctes du fichier).** Trois bonnes réponses du
domaine tombent sous le seuil de l'outil :

| id | bonne réponse | mots pleins (≥ 5 car.) | n |
|---|---|---|---|
| `5ae4a8d7800141787a` | « est gênant, au même titre que sur un pont » | `genant`, `titre` | 2 |
| `bda520451eb11447c3` | « s'allument quand même, pour être vu » | `allument`, `quand` | 2 |
| `5c11020dc34bf45d56` | « d'y faire demi-tour, en tout point » | `faire`, `point` | 2 |

Grep exhaustif (script Python, identifiants complets) sur `prompt` et `explanation` des
448 questions : zéro occurrence hors la carte elle-même pour les phrases exactes
« même titre que sur un pont », « quand même, pour être vu » et « demi-tour, en tout
point ». Le seul recouvrement trouvé est le mot isolé « gênant », **8 occurrences sur 5
questions distinctes** (et non 6 sur 2, chiffre d'un premier jet faussé par des
identifiants tronqués à 12 caractères qui font apparaître comme une seule carte
plusieurs questions différentes du domaine `Arrêt & stationnement` partageant le même
préfixe) : `37fe1af42b8d811198bdecd01768828c`, `37fe1af42b8d8134ad4be3c7e29328f1`,
`37fe1af42b8d8181a057c984708f0042` (4 occurrences : « gênant » et « très gênant », dans
le prompt et dans l'explication), `37fe1af42b8d81d793bcc927205f9d79`,
`c5d4d52f1aaa89b811c8b17847338968`. Toutes dans `Arrêt & stationnement`, vocabulaire de
catégorie légale (gênant / très gênant) partagé par construction — aucune ne cite la
phrase entière « au même titre que sur un pont », recouvrement fortuit documenté comme
tel (point 11 du calibrage), pas corrigé au prix d'une phrase abîmée.

**Point 17 — chaque explication relue contre les bonnes réponses et les options des
cartes voisines, y compris reformulées.** `--fuites` a trouvé, au round 0, deux
recouvrements réels, corrigés (voir « Round 0 » ci-dessus) : `1e329fa1` contre une carte
`Panneaux & marquage`, `1fe6ef49aad9` contre une carte `Priorités & intersections`.

Une **troisième fuite, intra-domaine, trouvée à la main et jamais vue par `--fuites`**
(l'outil ne compare que les mots pleins, ici sous le seuil de trois) : `5c11020d` donnait
d'avance la bonne réponse de `1e329fa1` (voir « Fix round 1 »). Et une **quatrième,
évitée en écrivant plutôt que trouvée après coup** : la première réparation envisagée
pour `7148c3a8` aurait donné d'avance la réponse de `5c11020d` en citant l'interdiction du
C111 ; la lecture des options de `5c11020d` avant de commiter l'a écartée.

`python3 Tools/relire.py --fuites "Tunnels & passages à niveau"` : **0 recouvrement sur
15 cartes**, aux deux rondes. Revérifié sur les huit domaines déjà clos après le fix round
1 : **0** partout (`Permis & sanctions`, `Vitesse`, `Alcool & stupéfiants`,
`Usagers & partage de la route`, `Mécanique & environnement`, `Distances & freinage`,
`Arrêt & stationnement`, `Premiers secours`).

### Registre (`Tools/sources.md`)

Quatre lignes touchées, aux deux rondes :

- `7148c3a8be7130501aa3da1644986ebb` — réécrite deux fois. Round 0 : trois citations
  partielles remplacées par une relecture complète en branches. Fix round 1 : la tête de
  ligne, qui rouvrait encore l'ancienne séquence (« couper le contact, évacuer avec tous
  les passagers, gagner une issue de secours, donner l'alerte »), est remplacée par les
  branches citées mot pour mot dans leur ordre réel ; la note datée devient la trace du
  fix, pas une justification qui contredisait la tête (point 7 du calibrage : le fichier
  doit tenir ce que le rapport affirme).
- `a88bdac8ef012091a9b0a43b209c3b1b` — round 0 seulement : clause ajoutée en renvoi (le
  « deux secondes partout » de l'explication est le I de R412-12, déjà sourcé sur une
  ligne `Distances & freinage`, non répété).
- `5c11020dc34bf45d56cf8438dd8ad79e` — fix round 1 : clause ajoutée documentant la
  seconde coupe (protection de `1e329fa1`, voir ci-dessus) et sa correction ultérieure
  (le renvoi vers `7148c3a8` retiré une fois que celui-ci a cessé d'utiliser ce fait).

Les onze autres lignes du domaine sont inchangées, y compris leurs dates de relevé :
aucune valeur affirmée n'a changé sur ces cartes, seule leur formulation pédagogique.

### Mouvements d'`audit.py`

| sortie | avant (baseline) | round 0 | fix round 1 |
|---|---|---|---|
| `lettre/reference` | 1 | 1 | 1 |
| `forme/markdown` | 1 | 1 | 1 |
| `forme/seule-ponctuee` | 14 | 14 | 14 |
| `longueur/plus-longue` | 90 | 90 | 88 |
| `expl/paraphrase-litterale` | 19 | 19 | 20 |
| `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10`, `forme/backtick-isole` | vides | vides | vides |

`longueur/plus-longue` baisse de 90 à 88 au fix round 1 : les corrections de
`7148c3a8` (+4 → −29) et `8a6af9d2` (+1 → −8) retirent chacune une occurrence, un
mouvement dans le sens attendu par le point 15 du calibrage, pas une régression.
`expl/paraphrase-litterale` monte de 19 à 20 : une seule carte nouvelle,
`c084813ff73eacb15d`, dont la bonne réponse chiffrée (« vingt secondes au moins avant
l'arrivée du train ») a été réintroduite dans l'explication pour corriger un échec du
critère 3 (la règle n'était jamais énoncée). Faux positif structurel au sens du point 8
du calibrage : la réponse est un chiffre, sa reprise est normale, et l'explication ajoute
la raison (l'annonce est calée sur le train) et la réfutation des distracteurs — ce n'est
pas la carte qui n'ajoute rien, c'est la seule façon d'énoncer une règle chiffrée. Compté,
pas corrigé en sens inverse (point 20 du calibrage : un compteur plat obtenu en vidant une
carte de sa substance est pire que le mouvement lui-même). Aucune sortie n'est passée de
vide à non vide, aux deux rondes.

Commandes et sorties (étapes 1, 6, 7, 9 ; fix round 1 revérifié en entier) :

```
$ python3 Tools/audit.py > .passe3/avant-10.txt && grep -E '^### ' .passe3/avant-10.txt
### lettre/reference  (1)
### forme/markdown  (1)
### forme/seule-ponctuee  (14)
### longueur/plus-longue  (90)
### expl/paraphrase-litterale  (19)

$ # … cinq puis cinq éditions supplémentaires, renormalisation …
$ python3 -c "… mêmes ids …"
mêmes ids : True | 448 -> 448
ajoutés : [] | retirés : []

$ python3 Tools/relire.py --fuites "Tunnels & passages à niveau" | tail -40
0 recouvrement(s) sur 15 cartes de « Tunnels & passages à niveau ».
$ for d in "Permis & sanctions" "Vitesse" "Alcool & stupéfiants" \
           "Usagers & partage de la route" "Mécanique & environnement" \
           "Distances & freinage" "Arrêt & stationnement" "Premiers secours"; do
    python3 Tools/relire.py --fuites "$d" | tail -3
  done
0 recouvrement(s) sur 19/22/18/18/20/21/17/18 cartes respectivement.

$ python3 Tools/audit.py > .passe3/apres-10-round1-final.txt
$ diff <(grep -E '^### ' .passe3/avant-10.txt) <(grep -E '^### ' .passe3/apres-10-round1-final.txt)
4,5c4,5
< ### longueur/plus-longue  (90)
< ### expl/paraphrase-litterale  (19)
---
> ### longueur/plus-longue  (88)
> ### expl/paraphrase-litterale  (20)

$ DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test […] 2>&1 | tail -30
✔ Test run with 10 tests in 0 suites passed after 0.066 seconds.
** TEST SUCCEEDED **
```

`git status --short` avant `git add`, fix round 1 : `Tools/sources.md` et
`Valido/Resources/questions.json` seuls modifiés, `CLAUDE.md` toujours untracked, aucun
`Contents.json` reformaté.

## Priorités & intersections

26 cartes, 5 `datée`, 8 illustrée(s).

### Écarts de justesse trouvés

| id | écart | ce que disait la carte | ce que dit l'article | correction |
|---|---|---|---|---|
| `37fe1af42b8d818293f3f8d862a5a505` | explication au-delà de l'article (nuance imprécise, hors champ) | « La Sécurité routière confirme qu'un feu franchi pour dégager la voie est relevé par le radar sans contravention automatique, sauf contrôle humain si le véhicule prioritaire n'est pas lui-même flashé. » | Rouvert par `WebSearch` (la page `securite-routiere.gouv.fr` citée ne se laisse pas lire par `WebFetch`, contenu chargé en JS) : chaque photo radar est **toujours** revue par un OPJ ; ce qui compte est que le véhicule prioritaire **apparaisse sur la photo**, pas une alternative « automatique / contrôle humain » comme la carte le construisait. La nuance, en plus d'être imprécise, ne distingue aucune des 4 options (aucune ne porte sur le radar) : c'est un ajout hors du champ que la carte teste. | Retirée. Remplacée par une limite tirée du texte même de R415-12, relu mot pour mot sur Legifrance le 2026-08-28 : « annonçant leur approche par l'emploi des avertisseurs spéciaux prévus pour leur catégorie » — la priorité tient à l'usage effectif de leurs avertisseurs spéciaux, pas au type de véhicule. |

Un seul écart sur 26 cartes. Les cinq lignes `datée` du domaine ont chacune été relues
contre l'article consolidé (R415-6, R415-11, R415-12, l'arrêté du 12 janvier 2012 créant
le panonceau M12, et le R415-5 sous-jacent à `defefbae1ae651a95dd247e38524ee36`),
`WebFetch`/`WebSearch` à l'appui plutôt que la seule ligne de `sources.md` — parce que ce
domaine est justement celui où la comparaison clause par clause (point 10 du calibrage)
est la plus exigeante : trois cartes reposent sur la distinction rond-point/carrefour à
sens giratoire, deux sur STOP vs cédez-le-passage, deux sur le tramway. **Correction
après revue : la première rédaction de ce paragraphe omettait R415-11 de l'énumération
alors que la carte piéton (`2a9e02b9719028e72fde6fdd6372a1ff`) en dépend — l'article avait
bien été lu en substance (le « 6 points » et l'extension de 2018 sont exacts, confirmés
ci-dessous par un second `WebFetch`), seule l'énumération était incomplète.**

**R415-11** (« au piéton s'engageant régulièrement dans la traversée d'une chaussée ou
manifestant clairement l'intention de le faire », version en vigueur depuis le 19/09/2018,
relu le 2026-08-28) confirme mot pour mot la carte `2a9e02b9719028e72fde6fdd6372a1ff` :
le « ou » est inclusif, la carte ne dit rien de plus. **R415-9** (et non R415-5, qui ne
parle que de « routes différentes » et ne mentionne aucune exception) est l'article qui
couvre réellement l'exception « chemin de terre / parking / propriété privée » que
portent `e0f68dd1324f9a5ffaab945a3d59e197` et `37fe1af42b8d818fb7c9efba6c63d91d` :
« Tout conducteur qui débouche sur une route […] à partir d'un accès non ouvert à la
circulation publique, d'un chemin de terre ou d'une aire de stationnement […] doit céder
le passage à tout autre véhicule » (version en vigueur depuis le 17/11/2010, relu le
2026-08-28 — ajouté aux deux lignes `stable` de `sources.md`). Les deux cartes restaient
justes avec la seule doctrine (« la priorité à droite ne joue qu'entre voies de même
nature »), mais cette doctrine n'était pas nécessaire : l'article la dit lui-même, plus
directement. **R415-10** (« Tout conducteur abordant un carrefour à sens giratoire est
tenu […] de céder le passage aux usagers circulant sur la chaussée qui ceinture le
carrefour ») ne définit pas lui-même ce qui fait qu'un rond-point *est* un carrefour à
sens giratoire ; cette définition vit dans **R110-2** (« carrefour à sens giratoire :
place ou carrefour comportant un terre-plein central matériellement infranchissable,
ceinturé par une chaussée mise à sens unique par la droite sur laquelle débouchent
différentes routes et **annoncé par une signalisation spécifique** », version en vigueur
depuis le 25/04/2022, relu le 2026-08-28) — c'est cette clause de signalisation qui fonde
`2daf8939fc85f5b288010cf545bb681d` (« sans la signalisation qui le désigne, un rond-point
reste soumis à la priorité à droite »), pas R415-10 : cohérent, pas trop large, mais mal
référencé dans la première rédaction de ce paragraphe, qui observait l'absence sans
pointer où la définition vit réellement. **R422-3** confirme mot pour mot les deux cartes
tramway, y compris la clause qui les limite (« sauf pour les véhicules de transport public
[...] dont les conducteurs doivent respecter la signalisation à prescriptions absolues »).
**L'arrêté M12** confirme la citation exacte de `sources.md` (« en toute prudence et en
respectant la priorité de passage accordée aux autres usagers ») ; la carte
`b433eefe7ea3ce149e6d6dd09e958a00` la paraphrase en « aux piétons et aux véhicules de la
voie croisée », plus concret que le texte mais pas plus large que lui (à un feu tricolore,
les seuls « autres usagers » disposant du passage sont précisément ceux-là) — gardé tel
quel, pas un doute.

### Doutes signalés, non corrigés

Aucun. Les cinq lignes `datée` ont chacune été revérifiées contre l'article consolidé
(voir ci-dessus) ; le seul point qui ne tenait pas (le rang 2 sur le radar) avait une
réponse claire dans les résultats de recherche eux-mêmes, pas un doute qui serait resté
en suspens faute de source.

### Pédagogie

- explications sous 120 caractères : 3 à l'entrée (`37fe1af42b8d812fade7d79d309e4c48` 78,
  `37fe1af42b8d8161be32fe2fe9808fff` 100, `37fe1af42b8d81d6aef7ff0b8d193d7f` 81), **0** à
  la sortie.
- cartes dont le budget de 220 a limité l'explication : `6e1a51d34b4b79e4366d6566795e5151`
  (croisement en pente) — un premier ajout de la raison physique portait l'explication à
  238 caractères ; retravaillée à 193 en fusionnant l'arrêt et le recul en une seule
  proposition, sans perdre la limite (« sauf si c'est nettement plus facile pour celui qui
  monte, près d'une place d'évitement »), puis retouchée une seconde fois en fix round 1
  (200/220, voir plus bas — la raison de la première version pointait dans le mauvais
  sens). `dd4c58febe771b6f297f1ca46c2ec75b` (insertion sur giratoire) — la limite ajoutée
  (le cas du rond-point non giratoire) a été réduite à sa forme la plus courte possible,
  « Sans triangle, un rond-point suit une autre règle. » (218/220), pour ne pas dépasser.
  Deux cartes touchées en fix round 1 (voir plus bas) l'ont aussi été sous cette
  contrainte : `8e9464777a61dba3859e3ecc08f7327d` (219 → 209/220) et
  `f255331d3f234810a4807594b43b397f` (214 → 207/220).
- énoncés reformulés parce qu'ils présupposaient la règle : aucun. Les 26 énoncés se
  lisent déjà sans connaître la réponse — mises en situation avec tous les termes
  introduits (les scènes illustrées portent le contexte dans l'`alt`), ou questions
  fermées neutres (« Qui passe en premier ? », « Qui a l'autorité la plus élevée… »).
  Aucun n'a nécessité de reformulation.

**Six cartes modifiées, sur la pédagogie (critère 3) et un écart (818293) :**

- `37fe1af42b8d812fade7d79d309e4c48` (giratoire, véhicules déjà engagés) — COURTE (78
  car.) : la règle était nue (« les usagers déjà dans l'anneau sont prioritaires »), sans
  raison ni limite. Réécrite en 259 caractères : règle sourcée (R415-10, « impose de
  céder le passage à qui circule déjà sur l'anneau »), limite reliée à la carte voisine
  sans lui voler sa réponse (« Un rond-point sans cette signalisation suit une autre
  règle »). **Note de méthode** : un premier brouillon employait « l'anneau se comporte
  comme une route prioritaire », une analogie qui aurait confondu deux mécanismes de
  priorité que le domaine tient justement séparés (R415-10 pour l'anneau, R415-9/AB6 pour
  la route à caractère prioritaire) — retiré avant commit. Un second brouillon employait
  « R415-10 donne la priorité à l'anneau », qui recouvrait mot pour mot la bonne réponse
  d'une carte `Panneaux & marquage` (`9eb8506813f0c8b729b66157ec95a63f`, « un giratoire où
  la priorité est à l'anneau ») — détecté par `--fuites` après coup, corrigé en évitant le
  mot « priorité » au profit de « céder le passage ». Les deux versions écartées ne sont
  restées dans aucun commit.
- `37fe1af42b8d8161be32fe2fe9808fff` (cédez le passage, triangle) — COURTE (100 car.) :
  la carte disait *que* l'arrêt n'est pas obligatoire, jamais pourquoi. Réécrite en 214
  caractères : règle (« impose de céder le passage, pas de s'arrêter »), raison (« l'arrêt
  n'est qu'un moyen, dû seulement si un véhicule approche »), limite/contraste avec le
  STOP conservée.
- `37fe1af42b8d81d6aef7ff0b8d193d7f` (losange jaune, signification) — COURTE (81 car.) :
  pure paraphrase (« signale une route à caractère prioritaire sur tout son parcours »).
  Réécrite en 164 caractères : raison ajoutée (la priorité à droite cesse de s'appliquer
  aux intersections traversées) et limite (« jusqu'au panneau qui l'annule »).
- `37fe1af42b8d818293f3f8d862a5a505` (véhicule prioritaire, sirène/gyrophare) — écart de
  justesse traité ci-dessus. La limite ajoutée (usage effectif des avertisseurs) vient du
  texte même de R415-12, pas d'une déduction.
- `6e1a51d34b4b79e4366d6566795e5151` (croisement en pente, illustrée) — la carte donnait
  déjà la règle et la limite, jamais la raison. Ajoutée : « cela se maîtrise mieux en
  descente qu'en côte » — fait physique non controversé, déjà admis comme non sourcé pour
  ce type de raisonnement par `Distances & freinage` (« un ordre de grandeur pédagogique
  ne se source pas comme une norme »). 202 → 193 caractères (budget illustrée tenu).
- `dd4c58febe771b6f297f1ca46c2ec75b` (insertion sur giratoire, illustrée) — la carte
  n'avait pas de limite. Ajoutée, brève pour tenir le budget : le cas du rond-point sans
  triangle suit une autre règle, sans donner la réponse de `2daf8939fc85f5b288010cf545bb681d`.
  167 → 218 caractères.

### Fix round 1 (revue externe, 2026-08-28) — cinq cartes de plus, aucune sur la justesse

Une revue a confronté ce rapport à son propre fichier de preuve plutôt qu'aux intentions
qu'il déclarait, et a trouvé cinq défauts que le round 0 n'avait pas vus — trois fuites
sémantiques que `--fuites` ne mesure pas (mots pleins insuffisants d'un côté ou de
l'autre), un critère 3 raté malgré une justification budgétaire qui ne tenait pas, et
quatre options héritées où la bonne réponse est la plus longue. Le calibrage en tire un
point 21 : **la table de preuve elle-même est la preuve la moins chère à relire, et
c'est celle qu'on relit le moins.** Deux des cartes ci-dessous (`815f86…`, `f255331…`)
étaient précisément dans la table des « non modifiées », citées sans être relues contre
leurs voisines.

**1. `37fe1af42b8d815f8684e4cc91d6950f` et `37fe1af42b8d817da9fff3054d6ffa3a` se
donnaient mutuellement leur réponse.** `815f86…` expliquait « D'où la hiérarchie agent,
puis feu, puis panneau, puis marquage, puis priorité à droite » — soit la réponse
complète de `817da9…` (« Qui a l'autorité la plus élevée… » → « L'agent »). Et
`817da9…` porte la même énumération pour sa propre raison d'être (elle est sa réponse à
lui). `--fuites` ne le voit pas : la réponse de `817da9…` compte quatre mots pleins
(`agent`, `regle`, `circulation`, `place`) mais deux d'entre eux (`circulation`,
`place`) sont absents du texte de `815f86…`, ce qui casse le sous-ensemble exigé par
l'outil — un recouvrement **sémantique**, pas **littéral**. La règle : la hiérarchie
appartient à `817da9…`, dont c'est le sujet exact ; `815f86…` n'avait besoin que de son
propre cas (feu vs panneau) et du jaune clignotant. Énumération retirée de `815f86…`
(335 → 260 caractères), `817da9…` non touchée.

**2. `f255331d3f234810a4807594b43b397f` échouait au critère 3, et la justification
budgétaire du round 0 était fausse.** La carte énonçait la règle puis réfutait deux
distracteurs, sans jamais poser de limite ; le round 0 l'excusait par le budget
(214/220) et par un renvoi à `818fb7…`, deux motifs que le critère exclut. Le budget
était en outre un faux prétexte : la clause finale, « — la direction prise ne change
rien à qui doit céder. » (54 caractères), ne fait que répéter « aller tout droit n'en
donne pas davantage » de la phrase précédente. Retirée ; une vraie limite ajoutée à sa
place, « Sauf panneau, giratoire ou sortie de parking. » (44 caractères). 214 → 207
caractères, avec une limite au lieu d'une redite.

**3. Deux fuites sémantiques dans le cluster « route à caractère prioritaire », que
l'argument structurel ne couvre pas.** L'argument structurel (point 8/11/16 du
calibrage) protège le **vocabulaire** du panneau AB6, pas n'importe quelle phrase qui
l'entoure :
   - `8e9464777a61dba3859e3ecc08f7327d` expliquait « tant qu'il n'est pas barré, la
     priorité à droite cesse de s'appliquer » — ce qui dit, en creux, ce que signifie le
     panneau **barré**, exactement la réponse de `37fe1af42b8d8184beb9c6687c92ffb5`. La
     clause a été retirée et remplacée, à longueur égale, par une limite qui ne pointe
     vers rien d'autre : la route est prioritaire **sur cet axe, pas toute la zone**.
     219 → 209 caractères.
   - Le round 0 avait lui-même ajouté à `37fe1af42b8d81d6aef7ff0b8d193d7f` un second
     pointeur vers la même voisine, « jusqu'au panneau qui l'annule » — présenté dans le
     rapport comme un gain pédagogique, c'en était un au prix d'une fuite neuve. Retiré,
     remplacé par la même limite d'axe. 164 → 168 caractères.
   - Le compte de `--fuites` sur le cluster reste à **3**, inchangé et volontairement :
     les trois occurrences qui restent sont toutes la désignation officielle du panneau
     (« route à caractère prioritaire »), qu'aucune reformulation ne fait disparaître
     sans vider les cartes — la revue elle-même juge ce plancher légitime. Ce qui a
     changé, ce sont les deux clauses qui donnaient en plus la réponse **d'une carte
     précise** ; celles-là sont parties.

**4. Quatre options héritées où la bonne réponse était la plus longue, mesurées et
corrigées plutôt que couvertes par un renvoi au test.** Le round 0 répondait à ce risque
par « vérifiée par le test… », ce que le point 15 du calibrage interdit précisément :
les catégories d'audit ne dispensent pas de mesurer. Aucune de ces quatre options n'avait
été touchée par cette tâche ; les quatre distracteurs ci-dessous sont étoffés, jamais la
bonne réponse raccourcie (§2 de `questions.md`) :
   - `37fe1af42b8d8161be32fe2fe9808fff` — A « De faire valoir une priorité absolue »
     (36) → « De faire valoir une priorité absolue sur la voie » (48). Bonne réponse C
     (46) : +2 → −2.
   - `b433eefe7ea3ce149e6d6dd09e958a00` — B « Les bus à franchir le feu rouge sans
     marquer l'arrêt » (52) → « Les bus à franchir le feu rouge sans jamais marquer
     l'arrêt » (59). Bonne réponse D (58) : +6 → −1.
   - `37fe1af42b8d818293f3f8d862a5a505` — D « Est prioritaire hors agglomération
     seulement » (44) → « Est prioritaire hors agglomération, jamais en ville » (51).
     Bonne réponse B (48) : +4 → −3.
   - `37fe1af42b8d81fa9debeaf114b7bf77` — A « Le premier arrivé sur la voie ferrée
     passe » (42) → « Le premier arrivé sur la voie ferrée passe, comme ailleurs » (58).
     Bonne réponse C (62) reste la plus longue (+3, `longueur/plus-longue`, informatif),
     mais l'écart signalé par la revue portait sur la **moyenne** des distracteurs
     (62 − 52 = 10,0) : remontée à (58+59+55)/3 = 57,3, écart ramené à 4,7.

   Chaque distracteur reste faux, plausible et non éliminable par la forme ; aucun ne
   devient défendable. `longueur/plus-longue` passe de 88 à 85 (les quatre occurrences
   retirées), un mouvement dans le sens attendu par le point 15, pas une régression.

**5. `37fe1af42b8d818293f3f8d862a5a505` — la limite ajoutée en round 0 rétrécissait sa
propre affirmation.** R415-12 conditionne la priorité à l'usage des « avertisseurs
spéciaux prévus pour leur catégorie » ; la carte disait « par sirène et gyrophare »,
ce qui ajoute une condition (le signal lumineux) que l'article ne pose pas — l'énoncé,
lui, peut légitimement citer les deux comme exemple concret de la scène, mais
l'explication généralise la règle et doit reprendre le terme de l'article. Corrigé en
« l'usage effectif de leurs avertisseurs spéciaux ». 266 → 281 caractères (l'option D a
aussi changé dans le même diff, voir point 4).

**6. `6e1a51d34b4b79e4366d6566795e5151` — la raison ajoutée en round 0 pointait dans le
mauvais sens, lue littéralement.** « Cela se maîtrise mieux en descente qu'en côte »
décrit le mauvais mouvement : le véhicule qui descend et qui doit reculer remonte la
pente qu'il vient de descendre — c'est un redémarrage en côte, pas une manœuvre en
descente. Le vrai mécanisme (un véhicule à l'arrêt en côte redémarre mal, exposé au
recul) coûte le même nombre de caractères et met la charge au bon endroit : c'est
précisément parce que redémarrer en côte est difficile que la règle en dispense le
véhicule qui monte. La même réécriture a aussi perdu « en premier » du texte de R414-3
(qui ne survivait plus que dans l'option correcte, « le véhicule qui descend s'arrête
d'abord ») ; restauré dans l'explication. 193 → 200 caractères.

**Vérification, fix round 1** (les commandes complètes sont en fin de section) :
mêmes `id` (448 → 448), `--fuites` du domaine toujours à **3** (le plancher structurel,
confirmé légitime), `--fuites` des neuf domaines déjà clos toujours à **0**, `audit.py`
sans mouvement de vide à non-vide (`longueur/plus-longue` 88 → 85, seul mouvement,
attendu), les 8 illustrées dans le budget, `git status` propre, `✔ Test run with 10
tests in 0 suites passed`.

### Fix round 2 (revue externe, 2026-08-29) — deux cartes de plus, une table corrigée

Une seconde revue a fermé Important 2, 3 et 4 du fix round 1 et vérifié le point le plus
sensible (les quatre distracteurs étoffés restent réels, non éliminables par la forme, ne
deviennent des cas particuliers de rien, et ne sont pas des outliers dans l'autre sens).
Trois défauts restaient ouverts, et le troisième s'est produit **dans l'artefact censé
réparer le point 21** : la table de preuve elle-même, réécrite en fix round 1, n'avait
pas été relue une fois rendue.

**1. La fuite mutuelle `815f86` / `817da9` n'avait été fermée que d'un côté.**
`815f86…` avait perdu son énumération, mais `37fe1af42b8d817da9fff3054d6ffa3a` gardait
« D'où l'ordre agent, puis feu, puis panneau, puis marquage, puis priorité à droite » —
soit, en clair, que le feu l'emporte sur le panneau, exactement la réponse de `815f86…`
(« un feu et un panneau se contredisent, lequel suivez-vous » → le feu). La hiérarchie
appartient légitimement à `817da9…` (sa réponse est « L'agent »), mais seule sa **tête**
lui est nécessaire, pas la queue qui trahit sa voisine. Retirée : « D'où l'ordre agent,
puis feu, puis panneau, puis marquage, puis priorité à droite. » devient « L'agent reste
donc, dans tous les cas, l'autorité la plus élevée d'un carrefour. » — la règle et la
raison (agent adaptable contre feu qui n'applique qu'un cycle) restent intactes, la queue
de l'énumération disparaît. 229 → 227 caractères. `37fe1af42b8d817da9…` est donc
lui-même une carte **modifiée** à partir de ce round, et quitte la table des « non
modifiées » ci-dessous.

**2. `37fe1af42b8d81fa9debeaf114b7bf77` restait le tell qu'il devait cesser d'être, et
mon rapport affirmait le contraire.** Le fix round 1 n'avait étoffé que le distracteur A
(42 → 58) ; B restait à 59 et la bonne réponse C (62) restait la plus longue, à +3 — la
même marge qu'avant l'édition, ce que `longueur/plus-longue` confirmait déjà
arithmétiquement (88 → 85, pas 84). Mon résumé de `task-11-report.md` disait pourtant
« Les quatre bonnes réponses ne sont plus les plus longues », ce qui était faux pour
celle-ci ; le texte de cette section, plus prudent, admettait le +3 et l'excusait par la
moyenne des distracteurs — une excuse que le point 15 n'accorde pas : le défaut existe
dès +1. Corrigé en étoffant B plutôt qu'en touchant à la bonne réponse : « Vous êtes
prioritaire, un véhicule guidé restant prévisible » (59) → « … restant **toujours**
prévisible » (68). La bonne réponse (62) n'est plus la plus longue (delta −6), B ne
devient pas un outlier (68 contre 55 pour D, loin du double), et le distracteur reste
faux et non défendable pour la même raison qu'avant : le véhicule guidé est prévisible
**parce qu'**il est prioritaire, mais cela ne rend personne d'autre prioritaire.
`longueur/plus-longue` passe de 85 à **84**.

**3. La table de preuve, réécrite en fix round 1 pour corriger le point 21, refaisait le
point 21 sur elle-même.** Trois défauts distincts, trouvés en relisant le **rendu** de la
table plutôt que l'édition qui l'avait produite : le texte annonçait que
`37fe1af42b8d81fa9d…` avait quitté la table pour la section « Fix round 1 », mais sa
ligne (« tramway hors intersection ») y restait ; l'en-tête annonçait 15 cartes non
modifiées quand la table en comptait 16 lignes ; et le compte « 9 genuine sur 15 »
n'énumérait que huit id, plus une « note ci-dessus » qui n'en nommait aucun. Avec le
retrait de `817da9…` (point 1 ci-dessus) en plus de celui de `81fa9d…`, la table
descend maintenant à **14** lignes, en-tête et contenu accordés. Reprise ligne par ligne
plutôt que recomptée de tête : sur les 14 cartes réellement non modifiées, **7** portent
une limite genuine (`3e5d97…`, `e93ca4d…`, `ef4cfd…`, `2daf8939…`, `8184be…`, `818fb7…`,
`defefbae…`) — nommées explicitement ci-dessous, pas comptées par soustraction.

**Stale cross-reference.** La colonne « correction » de `37fe1af42b8d818293…` dans
« Écarts de justesse trouvés » citait encore « la sirène et du gyrophare », la formule
que ce même round avait remplacée dans la carte par « leurs avertisseurs spéciaux » ;
alignée.

**Vérification, fix round 2** : mêmes `id` (448 → 448), `--fuites` du domaine toujours à
**3** (plancher inchangé, aucune des deux éditions ne touchait au cluster AB6),
`--fuites` des neuf domaines déjà clos toujours à **0** (revérifié y compris à seuil 1,
sans restriction à trois mots pleins, sur les deux cartes touchées : aucune collision),
`audit.py` : `longueur/plus-longue` 85 → **84** (le seul mouvement, attendu, aucune sortie
de vide à non-vide), `✔ Test run with 10 tests in 0 suites passed`, `git status` propre.
Les neuf sections précédentes de ce fichier revérifiées byte-identiques.

### Preuve par carte, pour les 14 cartes non modifiées

Corrigée deux fois : en fix round 1 (calibrage point 21 : la table elle-même n'avait pas
été relue) puis en fix round 2, quand une seconde revue a lu le **rendu** de cette même
correction et trouvé qu'elle ne s'était pas appliquée à elle-même — une ligne
(`81fa9d…`) que le texte disait partie était restée, l'en-tête ne comptait pas les
lignes réelles, et le compte de limites genuines n'en nommait pas assez pour son total.
Sept cartes ont quitté cette table au total, vers les sections « Fix round 1 » et
« Fix round 2 » ci-dessus : `815f86…`, `f255331…`, `8e9464…`, `b433…`, `81fa9d…`
(round 1, sur les options ; confirmée retirée en round 2) et `817da9…` (round 2, sur
l'explication). Il en reste 14, et cette fois le compte a été fait en énumérant chaque
id, pas en soustrayant de tête.

| id | rôle | règle / raison / limite |
|---|---|---|
| `3e5d97761594126d37652be2e0e976dc` | feux hors service, priorité qui reprend | règle (« c'est la règle de l'article R415-5 qui revient, celle du croisement nu ») + raison (« un feu éteint ne prescrit plus rien : la hiérarchie redescend d'un cran ») + **limite** (« s'il ne reste ni agent, ni panneau, ni marquage ») |
| `43dc08f7c9ebc00497a4022e24319683` | STOP, obligation | règle (« l'immobilisation complète, à la ligne et non au niveau du poteau, même quand rien n'arrive ») ; **raison absente** (la carte pose un contraste, pas un pourquoi causal) ; **limite absente** — « ce qui le sépare du cédez-le-passage » est un contraste avec un autre panneau, pas une condition qui ferait cesser l'obligation de STOP elle-même. Même défaut que sa jumelle `37fe1af42b8d81bd94…` ci-dessous. |
| `e93ca4d156de5854eafce9393be39274` | carrefour en T, insertion | règle (« chacun cède à qui vient de sa droite — et vous êtes à sa droite ») + raison (réfute le mythe : « rouler sur la voie qui traverse ne confère par elle-même aucune priorité ») + **limite** (« faute de panneau, de marquage ou de feu ») |
| `ef4cfd171e0e9911a2619b3b06336216` | tramway, carrefour illustré | règle (« sa priorité ne dépend pas du côté ») + raison (« un tramway ne peut ni s'écarter ni s'arrêter court ») + **limite** (« Seule une signalisation absolue l'arrête ») |
| `02f7d6a65856887348bfe8653bb90c6e` | clignotant sur giratoire | règle (« après la sortie qui précède celle que vous prenez ») + raison (« il fait démarrer celui qui attend à la branche précédente, persuadé que vous lui laissez la place ») ; **limite absente**, non dite en round 0 — aucune condition ne fait cesser cette règle de pratique dans le lot |
| `09f18973aee39386ee42782f04d03ec2` | tourner à gauche hors intersection réglée | règle (« Céder le passage aux véhicules venant en face ») + raison (« le clignotant annonce une intention, il ne crée aucun droit ») ; **limite absente** — « y compris les deux-roues qui remontent la file » élargit qui est concerné (un champ), ce n'est pas une condition d'exception |
| `2a9e02b9719028e72fde6fdd6372a1ff` | refus de priorité à un piéton, 6 pts (`datée`) | règle (« 6 points, au même titre qu'une alcoolémie ») + raison (« le barème la place au niveau le plus élevé possible pour une contravention ») ; **limite absente** — « depuis 2018, l'obligation vaut aussi pour le piéton qui manifeste clairement l'intention » est une extension de champ (qui est couvert), pas une condition d'exception. R415-11 relue mot pour mot le 2026-08-28 : confirme le « ou » inclusif entre engagé et manifestant l'intention. |
| `2daf8939fc85f5b288010cf545bb681d` | rond-point sans panneau | règle (« à droite, donc aux véhicules qui s'y engagent ») + **limite** qui est tout l'objet de la carte (« un rond-point n'est un carrefour à sens giratoire que si la signalisation le dit […] sans eux, l'article R415-10 ne s'applique pas ») — la clause de signalisation vient de **R110-2**, pas de R415-10 (voir « Écarts de justesse trouvés ») |
| `37fe1af42b8d8184beb9c6687c92ffb5` | losange jaune barré | règle (« La fin d'une route à caractère prioritaire ») + raison (« vous dispensait des règles ordinaires sur tout un itinéraire ») + **limite** non absolue (« le plus souvent la priorité à droite », pas systématiquement — un vrai hedge, pas un contraste maquillé) |
| `37fe1af42b8d818fb7c9efba6c63d91d` | priorité à droite, aucune signalisation | règle (« Au véhicule venant de la droite ») + raison (« une règle unique et mémorisable plutôt qu'un arbitrage au cas par cas ») + **limite** (« ni sur un giratoire, ni face à un véhicule sortant d'un chemin de terre ou d'un parking ») — sourcée à **R415-9** (voir « Écarts de justesse trouvés »), pas seulement à la doctrine de la « voie de même nature » |
| `37fe1af42b8d81bd9426eabc80ab4a05` | STOP (`datée`) | règle (« De marquer un arrêt complet, puis de céder », « roues bloquées à la ligne, avant même de regarder ») + conséquence datée (4 points) ; **raison absente** ; **limite absente** — même défaut que `43dc08f7c9eb…` : le contraste avec le « Cédez le passage » éclaire la règle, il n'est pas une condition qui la limite |
| `e0f68dd1324f9a5ffaab945a3d59e197` | sortie de parking | règle (« Cède le passage à toute la circulation ») + raison (« la priorité à droite ne joue qu'entre voies de même nature ») ; **limite absente** — « d'un parking, d'une station-service, d'un chemin de terre ou d'une propriété privée » énumère qui est concerné (un champ, sourcé **R415-9**, voir « Écarts de justesse trouvés »), ce n'est pas une exception à la règle elle-même |
| `700316a2fd86db7d682be208673c92d5` | sas cycliste | règle (« Placer les cyclistes devant les voitures à l'arrêt ») + raison (« dans le champ de vision des conducteurs — ce qui règle la principale cause d'accident au feu ») ; **limite absente** — l'emplacement physique du sas n'est pas une condition d'exception |
| `defefbae1ae651a95dd247e38524ee36` | refus de priorité entre véhicules, 4 pts (`datée`) | règle (« 4 points, comme un feu rouge franchi ») + raison (« le code aligne au même niveau tout ce qui crée un conflit de trajectoire ») + **limite** (« seul le refus de priorité à un piéton monte au-dessus » — chiffre repris **délibérément**, en option, par `2a9e02b9719028e72f…`, voir « Les options ») |

Compte honnête des limites, sur les **14** lignes ci-dessus, chacune nommée : **7**
genuine (`3e5d97…`, `e93ca4d…`, `ef4cfd…`, `2daf8939…`, `8184be…`, `818fb7…`,
`defefbae…`) et **7** absentes ou mal étiquetées en round 0 (`43dc08…`, `02f7d6a6…`,
`09f18973…`, `2a9e02b9…`, `81bd94…`, `e0f68dd1…`, `700316a2…`) — contre 15/15 affichées
en round 0, et contre un « 9 sur 15 » en fix round 1 qui ne nommait que huit id et
comptait une carte (`81fa9d…`) qui n'aurait déjà plus dû être dans cette table. Les 12
cartes modifiées (round 0 + fix round 1 + fix round 2, dont `817da9…` et `81fa9d…`
ajoutées en dernier) portent chacune une limite ajoutée ou déjà réelle — détail dans les
sections « Six cartes modifiées », « Fix round 1 » et « Fix round 2 » ci-dessus.

Modifiées 12 + non modifiées 14 = 26, sans reste.

### Les options

Relues carte par carte contre les sept règles du §2 de `questions.md`, puis contre le
point 14 du calibrage (« existe-t-il une lecture où le distracteur EST la bonne
réponse ? »), et rechecquées après chaque nouvelle branche d'explication (point 14
étendu). Aucun chiffre inventé : les distracteurs chiffrés du domaine (2, 3, 4, 6 points ;
sur `2a9e02b9…` et `defefbae1ae6…`) sont tous des paliers réels du barème, déjà utilisés
comme bonnes réponses ailleurs dans le domaine ou dans le reste de la banque — pas de
valeur fabriquée façon « 45 km/h » ou « 150 € ». Aucun distracteur éliminable par la
forme de son propre énoncé. Un cas revu de près pour le point 14 : sur
`37fe1af42b8d8184beb9c6687c92ffb5` (losange jaune barré), l'explication dit que la fin du
losange ramène « le plus souvent » à la priorité à droite — au même moment, le
distracteur B affirme que le panneau *signifie* « une intersection avec priorité à
droite ». Les deux ne se contredisent pas : B décrit le panneau lui-même (faux, le
panneau ne dit que la fin du caractère prioritaire, pas ce qui vient après), l'explication
décrit la conséquence pratique la plus fréquente à l'intersection suivante — le hedge
(« le plus souvent », pas « toujours ») est ce qui empêche l'explication de légitimer B.
Aucun distracteur n'est un cas particulier de la bonne réponse : vérifié en particulier
sur `37fe1af42b8d812fade7d79d309e4c48` (giratoire) où C (« Appliquer la priorité à droite
dans l'anneau ») et B (« Vous arrêter systématiquement ») sont deux vraies confusions
distinctes de A, pas des variantes de A. `37fe1af42b8d815f8684e4cc91d6950f` (feu vs
panneau) reste à part : sa bonne réponse « Le feu tricolore » (16 caractères) est la plus
**courte** des quatre — A 22, C 27, D 30 — ce qui n'est pas le tell documenté par
`questions.md` §1 (qui porte sur la réponse la plus **longue**) ni un outlier au sens du
point 15 (aucune option n'atteint le double d'une autre) ; non touchée pour cette raison.

**Round 0 avait répondu à la question du point 15 par un renvoi au test plutôt que par
une mesure — exactement ce que le point interdit.** Quatre bonnes réponses **héritées**
(le diff de cette tâche n'y touchait aucune option) étaient la plus longue de leur carte :
`37fe1af42b8d8161be…` (46 vs 40), `b433eefe7ea3ce149e…` (58 vs 52),
`37fe1af42b8d818293…` (48 vs 44) et `37fe1af42b8d81fa9d…` (62 vs 59, et +10,0 sur la
moyenne des distracteurs). Fix round 1 les a mesurées et corrigées en étoffant un
distracteur sur chacune, jamais en raccourcissant la bonne réponse (détail et chiffres
dans « Fix round 1 » ci-dessus) : aucune des quatre bonnes réponses n'est plus la plus
longue de sa carte, et l'écart de moyenne sur `81fa9d…` retombe de 10,0 à 4,7. Aucun des
quatre distracteurs modifiés n'est devenu défendable comme seconde réponse.

**Deux recouvrements internes, réels mais délibérés — nommés plutôt que couverts par
« aucun autre recouvrement ».** Ni l'un ni l'autre n'est une fuite au sens de la passe
(aucun ne donne l'intégralité d'une réponse par un mot de moins de cinq lettres ou par un
chiffre isolé, et les deux servent une pédagogie de contraste que `questions.md` §1
règle 5 recommande explicitement) :
- `37fe1af42b8d81bd9426eabc80ab4a05` (STOP, `datée`) explique « le "Cédez le passage", où
  l'arrêt n'est requis que si quelqu'un arrive » — presque mot pour mot la bonne réponse
  de `37fe1af42b8d8161be32fe2fe9808fff` (« De laisser passer, en s'arrêtant si
  nécessaire ») ; `43dc08f7c9ebc00497a4022e24319683` porte la même forme, plus atténuée
  (« où seule la priorité est due »). C'est le contraste STOP / cédez-le-passage que le
  domaine construit délibérément sur ses quatre cartes du sujet (deux stables, deux
  `datée`) — chacune apprend sa règle en la distinguant de l'autre, pas en la cachant.
- `defefbae1ae651a95dd247e38524ee36` (4 points, refus de priorité entre véhicules) est
  cité **par son chiffre**, en option, par `2a9e02b9719028e72fde6fdd6372a1ff` (« 4 points,
  comme un refus de priorité ordinaire ») : la carte piéton enseigne la contravention
  ordinaire (4) pour mieux marquer pourquoi la sienne (6) est plus sévère. Vérifié
  cohérent (les deux cartes citent 4 points pour le même fait) et délibéré, pas une fuite
  à corriger — c'est un renvoi construit, pas un hasard de vocabulaire.
- `b433eefe7ea3ce149e6d6dd09e958a00` (panonceau M12) : sa **raison** dans la table de
  preuve ci-dessus (« il autorise le cycliste à passer sans s'arrêter dans la direction
  indiquée par la flèche ») redit la règle plutôt que d'expliquer pourquoi la dérogation
  existe. Aucune source blanche consultée sur ce domaine n'énonce le motif (le texte de
  l'arrêté autorise et conditionne, il ne justifie pas) ; relabellisé **raison absente**
  plutôt que remplacé par une déduction non sourcée (point 18 du calibrage). Sa limite
  (« à condition de céder le passage… ») reste, elle, une vraie condition d'exception.

**`correctID` — mesuré, non rebalancé.** Avant comme après cette tâche, y compris après
le fix round 1 (aucun `correctID` déplacé, seuls des textes d'options ont changé sur
quatre cartes) : A 7, B 7, C 7, D 5 sur 26. Écart de deux entre la lettre la plus et la
moins servie sur un lot de 26 — proche de la répartition attendue de 6,5 par lettre, pas
lopsided au sens du critère de rééquilibrage.

### Point 13 — bonnes réponses sous trois mots pleins, cherchées à la main

Définition reprise du fichier (`Tools/relire.py:mots`, pas du bon sens) : tokens
`[a-z0-9]+` d'au moins cinq caractères après minuscule et suppression des accents. Sur les
26 bonnes réponses du domaine, deux tombent sous le seuil de trois mots pleins que
`--fuites` exige côté « réponse » :

| id | bonne réponse | mots pleins (≥ 5 car.) | n |
|---|---|---|---|
| `37fe1af42b8d815f8684e4cc91d6950f` | « Le feu tricolore » | `tricolore` | 1 |
| `37fe1af42b8d81d6aef7ff0b8d193d7f` | « Une route où vous êtes prioritaire » | `route`, `prioritaire` | 2 |

Recherchées à la main sur les 26 ÉNONCÉ et EXPL du domaine (`grep -n` sur
`.passe3/lot-11-final.txt`) :

- **« feu tricolore » / « feux tricolores »** : trois occurrences hors sa propre carte —
  l'option C (distracteur) de `37fe1af42b8d817da9fff3054d6ffa3a` (« Les feux tricolores,
  qui rythment la circulation »), l'affirmation et l'énoncé de
  `b433eefe7ea3ce149e6d6dd09e958a00` (le panonceau M12 est posé sous un feu tricolore).
  Aucune n'est une **explication** donnant la réponse de `815f86` : la première est un
  distracteur d'une autre carte (teste une confusion, n'en révèle aucune), la seconde
  n'est que le décor de scène du panonceau M12 (le feu y est une donnée du problème, pas
  la réponse à « lequel suivez-vous »). Verdict, pour ces deux occurrences : pas de
  fuite. **Une troisième occurrence a été manquée à cette première lecture** : la propre
  explication de `815f86` reprenait la hiérarchie complète de sa voisine
  `37fe1af42b8d817da9fff3054d6ffa3a`, ce qui n'est pas un recouvrement de « feu tricolore »
  mais un recouvrement de la réponse de `817da9` (« L'agent… ») — trouvé par la revue,
  pas par ce grep, et détaillé en « Fix round 1 » point 1.
- **« route » + « prioritaire »** (ensemble) : trois occurrences hors sa propre carte,
  toutes dans le même triangle de cartes sur le losange jaune/AB6 —
  `8e9464777a61dba3859e3ecc08f7327d` (« désigne une route à caractère prioritaire »),
  `37fe1af42b8d8184beb9c6687c92ffb5` (bonne réponse elle-même, « La fin d'une route à
  caractère prioritaire ») et l'option distractrice de `dd4c58febe771b6f297f1ca46c2ec75b`
  (« l'anneau n'est pas une route prioritaire »). C'est le recouvrement déjà signalé par
  `--fuites` (voir plus bas, cluster « route à caractère prioritaire ») plus une variante
  sous le seuil : les trois cartes portent la même désignation officielle du panneau AB6
  sous trois angles (ce qu'il signifie, ce qu'annonce sa fin, ce qu'il n'est pas dans un
  giratoire) — vocabulaire technique obligatoire, pas une fuite qui dispenserait de
  connaître la matière. La troisième occurrence (l'option de `dd4c58…`) est un
  distracteur, pas une explication : elle teste exactement la confusion inverse (que
  l'anneau soit une route prioritaire), elle ne la valide pas. Verdict : recouvrement
  structurel documenté (voir cluster ci-dessous), pas une fuite corrigible sans abîmer le
  vocabulaire du panneau.

### Point 17 — relecture séparée, contre les voisines et leurs options, y compris `Panneaux & marquage`

Les 26 explications relues une à une contre les bonnes réponses **et** les options des
cartes voisines du domaine, puis contre les 27 cartes de `Panneaux & marquage` qui
partagent le même vocabulaire de signalisation (STOP, cédez-le-passage, losange jaune,
giratoire — requête ciblée sur ces mots-clés dans les 27 cartes du domaine).

**Cluster interne, structurel, ruled acceptable par la revue.** Trois cartes du domaine
désignent le même panneau AB6 (« route à caractère prioritaire ») sous trois angles :
`37fe1af42b8d81d6aef7ff0b8d193d7f` (ce qu'il signifie), `37fe1af42b8d8184beb9c6687c92ffb5`
(ce qu'annonce sa fin) et `8e9464777a61dba3859e3ecc08f7327d` (qui passe en premier à un
carrefour qui le porte). `--fuites` en trouve 3, avant et après le fix round 1. Comme
pour un chiffre qui revient légitimement (point 8 du calibrage), le terme officiel du
panneau ne peut pas être évité sans vider les trois cartes de ce qu'elles enseignent —
il a donc été conservé, y compris dans la carte réécrite (`37fe1af42b8d81d6ae…`), plutôt
que paraphrasé pour faire baisser un compteur (point 20 du calibrage). Cette conclusion a
été revérifiée et confirmée par une revue externe : **le domaine peut légitimement finir
à 3 plutôt qu'à 0, le premier des domaines traités à en avoir le droit.** Ce que le
compte de 3 ne couvrait pas, en revanche — et que la revue a trouvé, à côté du
vocabulaire — sont deux fuites **sémantiques** entre deux mêmes cartes du cluster, sous
le seuil de `--fuites` (une clause qui donne la réponse d'une voisine en d'autres mots
qu'une simple reprise de terme) : détaillées et corrigées en « Fix round 1 » ci-dessus
(`8e9464…` disait ce que signifie le panneau barré, `81d6ae…` pointait vers le même
panneau barré). Le compte de 3 reste inchangé après leur retrait, précisément parce que
ce n'était pas le vocabulaire qui posait problème.

**Un troisième recouvrement, interne au domaine, manqué en round 0.**
`37fe1af42b8d815f8684e4cc91d6950f` et `37fe1af42b8d817da9fff3054d6ffa3a` se donnaient
mutuellement leur réponse par la même énumération de hiérarchie — détaillé et corrigé en
« Fix round 1 » (point 1). Ni l'un ni l'autre sens n'est détecté par `--fuites` (les deux
réponses courtes, « Le feu tricolore » et « L'agent qui règle la circulation sur place »,
ne satisfont le seuil de trois mots pleins que dans un sens, et le sous-ensemble de mots
pleins échoue de justesse dans l'autre — voir le détail au point 1 de « Fix round 1 »).
C'est exactement le type de recouvrement que le point 17 est censé attraper à la lecture,
et que la première lecture n'a pas vu : la carte source de l'erreur, `815f86…`, était
elle-même citée dans la table de preuve des « non modifiées » sans être relue contre sa
voisine `817da9…`.

**Mirroir avec `Panneaux & marquage`, trouvé dans les deux sens.**

1. La carte `7d44f7dd303fce58716234cba54480b1` de `Panneaux & marquage` (« Ce panneau
   annonce la fin : du caractère prioritaire de votre route ») a pour explication : « […]
   il annonce que **la route perd son caractère prioritaire** au prochain carrefour. » —
   ceci recouvre mot pour mot (trois mots pleins : `route`, `caractere`, `prioritaire`) la
   bonne réponse de **ma** carte `37fe1af42b8d8184beb9c6687c92ffb5` (« La fin d'une route
   à caractère prioritaire »). C'est une carte de `Panneaux & marquage` qui fuit vers la
   mienne, pas l'inverse — hors de mon périmètre d'édition (`Tools/questions.json`
   n'appartient qu'à la tâche 11 pour les cartes « Priorités & intersections »). **Signalé
   ici pour la tâche 13**, qui verra cette carte avec la visibilité complète des douze
   domaines précédents : la correction naturelle est côté `Panneaux & marquage`, en
   paraphrasant sa propre conséquence pratique sans reprendre l'expression exacte de la
   bonne réponse d'une carte d'un autre domaine testant la même chose.
2. Vérifié aussi dans l'autre sens sur les deux cartes `Panneaux & marquage` les plus
   proches du domaine — `dce501d416e5db1cc6344725007fbad6` (cédez-le-passage sans STOP,
   correcte : « céder le passage, sans obligation de vous arrêter ») et
   `9eb8506813f0c8b729b66157ec95a63f` (giratoire, correcte : « un giratoire où la priorité
   est à l'anneau ») : aucune des 26 explications de mon domaine, y compris les deux
   réécrites sur le même sujet (`37fe1af42b8d8161be…` cédez-le-passage,
   `37fe1af42b8d812fad…` giratoire), ne recouvre leurs mots pleins — vérifié par script
   après coup sur l'ensemble des 448 bonnes réponses, pas seulement au seuil de 3 (voir
   note de méthode ci-dessus : un brouillon intermédiaire de `37fe1af42b8d812fad…`
   recouvrait bien `9eb8506813f0c8b729…`, corrigé avant commit).

Round 0 disait « aucun autre recouvrement, interne ou croisé, trouvé aux points 13 et 17 »
— faux sur le point qui compte le plus : la table de preuve elle-même, citée en entier
deux paragraphes plus haut, portait la démonstration du contraire (calibrage point 21).
Après fix round 1 : les deux fuites sémantiques du cluster AB6 fermées (compte `--fuites`
inchangé à 3, plancher structurel), la fuite `815f86`/`817da9` fermée, et les deux
recouvrements STOP/cédez-le-passage et 4-points/6-points **nommés comme délibérés**
plutôt que tus (voir « Les options »). Aucun autre recouvrement, interne ou croisé, trouvé
après cette seconde lecture.

### Les 8 cartes illustrées, mesurées

| id | énoncé | options (max) | explication |
|---|---:|---:|---:|
| `f255331d3f234810a4807594b43b397f` | 22/70 | 45/50 | 207/220 |
| `8e9464777a61dba3859e3ecc08f7327d` | 51/70 | 49/50 | 209/220 |
| `43dc08f7c9ebc00497a4022e24319683` | 26/70 | 49/50 | 191/220 |
| `e93ca4d156de5854eafce9393be39274` | 67/70 | 50/50 | 200/220 |
| `dd4c58febe771b6f297f1ca46c2ec75b` | 54/70 | 50/50 | 218/220 |
| `3e5d97761594126d37652be2e0e976dc` | 54/70 | 50/50 | 193/220 |
| `ef4cfd171e0e9911a2619b3b06336216` | 38/70 | 50/50 | 207/220 |
| `6e1a51d34b4b79e4366d6566795e5151` | 51/70 | 49/50 | 200/220 |

Les 8 tiennent le budget, mesuré par script (pas estimé) après chaque édition, round 0
et fix round 1. `dd4c58…` (218) reste la plus proche du plafond ; `8e9464…` (219 → 209)
et `f255331…` (214 → 207) ont gagné de la marge en fix round 1 en perdant la clause qui
fuyait ou en coupant une redite, jamais en perdant du sens.

### Mouvements d'`audit.py`

| sortie | avant (round 0) | après (round 0) | après (fix round 1) |
|---|---|---|---|
| `lettre/reference` | 1 | 1 | 1 |
| `forme/markdown` | 1 | 1 | 1 |
| `forme/seule-ponctuee` | 14 | 14 | 14 |
| `longueur/plus-longue` | 88 | 88 | **85** |
| `expl/paraphrase-litterale` | 20 | 20 | 20 |
| `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10`, `forme/backtick-isole` | vides | vides | vides |

`longueur/plus-longue` baisse de 88 à 85 en fix round 1 : les quatre bonnes réponses
héritées qui étaient la plus longue de leur carte (`8161be…`, `b433…`, `818293…`,
`81fa9d…`) ne le sont plus, chacune corrigée en étoffant un distracteur (détail en
« Fix round 1 », point 4). C'est le mouvement que le point 15 du calibrage demande, pas
une régression. Aucune sortie n'est passée de vide à non vide, aux deux rondes.

Commandes et sorties (étapes 1, 6, 7, 9) :

```
$ mkdir -p .passe3 && python3 Tools/audit.py > .passe3/avant-11.txt && grep -E '^### ' .passe3/avant-11.txt
### lettre/reference  (1)
### forme/markdown  (1)
### forme/seule-ponctuee  (14)
### longueur/plus-longue  (88)
### expl/paraphrase-litterale  (20)
$ python3 -c "…"   # 26 cartes | expl médiane 210.5 | sous 120 : 3 | illustrées : 8

$ python3 Tools/relire.py "Priorités & intersections" > .passe3/lot-11.txt   # lecture, 26 cartes contre leur ligne

$ # … 6 éditions de questions.json, 1 édition de sources.md (818293), renormalisation …
$ python3 -c "…"   # mêmes ids : True | 448 -> 448 | ajoutés : [] | retirés : []

$ python3 Tools/relire.py --fuites "Priorités & intersections" | tail -6
3 recouvrement(s) sur 26 cartes de « Priorités & intersections ».
Chacun se relit à la main : un mot commun est normal, la réponse entière ne l'est pas.

$ python3 Tools/audit.py > .passe3/apres-11.txt
$ diff <(grep -E '^### ' .passe3/avant-11.txt) <(grep -E '^### ' .passe3/apres-11.txt)
$ diff .passe3/avant-11.txt .passe3/apres-11.txt   # rien, fichiers identiques

$ DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test -project Valido.xcodeproj \
    -scheme Valido -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
    -only-testing:'ValidoTests/leContenuLivréEstValide()' [# … 10 tests …] 2>&1 | tail -30
✔ Test run with 10 tests in 0 suites passed after 0.067 seconds.
** TEST SUCCEEDED **
```

`git status --short` avant `git add`, round 0 : `Tools/sources.md` et
`Valido/Resources/questions.json` seuls modifiés, `CLAUDE.md` toujours untracked, aucun
`Contents.json` reformaté.

Commandes et sorties, **fix round 1** (revue externe du 2026-08-28) :

```
$ # … 9 cartes éditées (explications : 815f86, f255331, 8e9464, 81d6ae, 6e1a51, 818293 ;
$ #     options : 8161be A, b433 B, 818293 D, 81fa9d A), renormalisation …
$ python3 -c "… comparaison des id avant/après (contre HEAD, avant la tâche 11) …"
mêmes ids : True | 448 -> 448

$ python3 - <<'EOF'   # budget des 8 illustrées, mesuré
… voir table « Les 8 cartes illustrées, mesurées »
EOF

$ python3 Tools/audit.py > .passe3/apres-11-round1.txt
$ diff <(grep -E '^### ' .passe3/avant-11.txt) <(grep -E '^### ' .passe3/apres-11-round1.txt)
4c4
< ### longueur/plus-longue  (88)
---
> ### longueur/plus-longue  (85)

$ python3 Tools/relire.py --fuites "Priorités & intersections" | tail -6
3 recouvrement(s) sur 26 cartes de « Priorités & intersections ».
Chacun se relit à la main : un mot commun est normal, la réponse entière ne l'est pas.

$ for d in "Permis & sanctions" "Vitesse" "Alcool & stupéfiants" \
           "Usagers & partage de la route" "Mécanique & environnement" \
           "Distances & freinage" "Arrêt & stationnement" "Premiers secours" \
           "Tunnels & passages à niveau"; do
    python3 Tools/relire.py --fuites "$d" | tail -1
  done
0 recouvrement(s) sur les neuf domaines déjà clos, tous inchangés

$ DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test […] 2>&1 | tail -15
✔ Test run with 10 tests in 0 suites passed after 0.068 seconds.
** TEST SUCCEEDED **

$ git status --short   # après questions.json, sources.md et ce rapport
 M Tools/audit-2026-08-passe-3.md
 M Tools/sources.md
 M Valido/Resources/questions.json
?? CLAUDE.md
```

Un seul mouvement d'`audit.py` (`longueur/plus-longue` 88 → 85, attendu, détaillé
ci-dessus), aucun de vide à non-vide. `Tools/sources.md` touché deux fois au total : en
round 0 pour l'écart de `818293…`, en fix round 1 pour ajouter la citation de R415-9 aux
deux lignes `stable` (`e0f68dd1…`, `818fb7…`). Aucun `Contents.json` reformaté aux deux
rondes ; `CLAUDE.md` toujours untracked, jamais ajouté au commit.

## Croisement & dépassement

15 cartes, 3 `datée`, 4 illustrée(s).

### Écarts de justesse trouvés

| id | écart | ce que disait la carte | ce que dit l'article | correction |
|---|---|---|---|---|
| `f1ae9582d692d2bb7febb6a3c936ff34` | règle trop large | « Les croisements s'effectuent à droite […] demande à chacun de se rapprocher du bord droit » sans aucune limite | R414-1, 3e alinéa (déjà noté en prose dans la ligne de registre) : une signalisation d'intersection aménagée impose l'inverse — serrer à gauche | limite ajoutée à l'explication : « Une signalisation d'intersection aménagée peut toutefois imposer l'inverse, en demandant de serrer à gauche. » |

Un seul écart, sur une carte non drapeautée. Les trois lignes `datée` (`07b430cc…`,
`75e142d9…`, `93292bac…`) ont chacune été relues clause par clause contre R414-9, R414-16
et R414-17 : aucune valeur périmée, aucune condition de champ d'application élargie —
gabarit (2 m / 7 m), points retirés (2, pas 3), neige/verglas (pas la pluie) reproduisent
tous l'affirmation mot pour mot.

Les cinq cartes portant un absolu ou une obligation (`ABS toutes les` sur `2fc1ed8a…`,
`ABS interdit` sur `697b226c…` et `99824d4d…`, `ABS jamais` sur `93292bac…`,
`ABS aucun/impose` sur `b494d715…`) ont chacune été confrontées à sa ligne, l'absolu
retrouvant à chaque fois sa borne dans le corps même de la carte : « interdit […] quand la
visibilité vers l'avant manque, et cite le sommet de côte comme cas typique » sur
`697b226c…` (jamais l'absence de véhicule en face) ;
« jamais la pluie » sur `93292bac…` est la clarification elle-même, pas une
généralisation (le texte ne vise que neige et verglas) ; « interdit […] d'emprunter la
voie la plus à gauche d'une chaussée à double sens de plus de deux voies » sur
`99824d4d…` porte sa condition dans la même phrase ; « il impose de s'être assuré
qu'aucun piéton n'est engagé sur le passage » sur `b494d715…` reproduit exactement la
condition de vérification de R414-5, pas une interdiction. Le cinquième, `2fc1ed8a…`, est
examiné séparément ci-dessous.

**Le cas `2fc1ed8a9c9274f0e06be9f12850f5a4`, examiné et non corrigé.** R414-15 ne joue
que « sur les routes à sens unique et sur les routes à plus de deux voies » ; l'énoncé
(« La circulation est figée en files sur toutes les voies. Rouler plus vite qu'une file
voisine ») ne nomme pas ce type de route, ce qui ressemble d'abord au même défaut que
`f1ae9582…`. Vérifié géométriquement avant de trancher : pour qu'une « file voisine » de
même sens existe à comparer, il faut déjà au moins deux voies dans le même sens de
circulation — ce qui, arithmétiquement, ne peut se produire que sur une route à sens
unique (la totalité des voies va dans le même sens) ou sur une route à plus de deux voies
(au moins trois, dont deux du même côté). Le scénario décrit par l'énoncé satisfait donc
la condition de l'article par construction, dans toutes ses lectures plausibles ; ce
n'est pas une carte comparable à `f1ae9582…`, où l'exception (l'aménagement signalé) est
une configuration réelle que rien dans l'énoncé n'exclut. L'explication porte d'ailleurs
déjà la limite (« R414-15 ne joue que sur les routes à sens unique ou à plus de deux
voies […] Hors de ce cas, remonter par la droite reste un dépassement par la droite ») :
seul l'énoncé ne la nomme pas, sans en avoir besoin. Non modifiée.

### Doutes signalés, non corrigés

Aucun doute laissé ouvert. Les trois lignes `datée` du domaine ont été relevées le
2026-08-26 sur Legifrance, et aucune carte n'affirme une valeur ou une portée que
l'affirmation ne couvre pas. Le seul point qui a demandé une vérification externe à la
ligne — le champ d'application de R414-15 sur `2fc1ed8a…`, ci-dessus — a été tranché par
le calcul, pas par une source rouverte, et n'est donc pas un doute qui reste en suspens.

### Pédagogie

- explications sous 120 caractères : 0 à l'entrée, 0 à la sortie. Le domaine part
  d'explications déjà étoffées (médiane 231 caractères sur les 15) ; le seul mouvement de
  cette tâche est l'ajout d'une limite manquante sur une carte, pas un allongement de
  texte court.
- cartes dont le budget de 220 a limité l'explication : les 4 illustrées tiennent déjà
  rule + raison + limite dans leur budget sans reformuler la bonne réponse (mesures
  ci-dessous) ; aucune n'a été éditée, le budget n'a donc contraint aucune réécriture
  cette tâche-ci.
- énoncés reformulés parce qu'ils présupposaient la règle : aucun. Les 15 énoncés se
  lisent sans connaître la réponse — mise en situation (les 4 illustrées, `07b430cc…`,
  `2fc1ed8a…`, `75e142d9…`, `9aaede46…`) ou question à compléter par les options
  (les autres). `2fc1ed8a…` a été examiné pour ce critère précisément (voir ci-dessus) et
  jugé complet tel quel.

**Les 4 cartes illustrées, mesurées (inchangées) :**

| id | énoncé | options (max) | explication |
|---|---:|---:|---:|
| `42078575c362bf24a220380788994e25` | 33 / 70 | 49 / 50 | 196 / 220 |
| `46269e3e9018b1949b8143894e86c4fc` | 36 / 70 | 47 / 50 | 214 / 220 |
| `697b226c6270e1cee1a6e4edb95dec42` | 45 / 70 | 47 / 50 | 216 / 220 |
| `9aaede46c1c808687f89f4a8fb81f9df` | 44 / 70 | 47 / 50 | 215 / 220 |

Les quatre respectent déjà le budget 70/50/220 et enseignent rule + raison + limite sans
reformuler leur bonne réponse (critère 4, `expl/paraphrase-litterale` reste à 0 sur ce
domaine avant comme après) : aucune n'a été éditée.

### Preuve par carte, pour les 14 cartes non modifiées

| id | rôle | règle / raison / limite |
|---|---|---|
| `07b430ccbde4b33b92be8686899b1ddf` | convoi hors gabarit | règle (« son conducteur réduit sa vitesse et, au besoin, s'arrête ou se gare ») + raison (gabarit > 2 m de large ou 7 m de long, remorque et chargement compris) + limite (« Les transports en commun en agglomération en sont dispensés ») |
| `2fc1ed8a9c9274f0e06be9f12850f5a4` | files denses, vitesse relative | règle (« n'est pas considéré comme un dépassement ») + raison/limite explicite (« R414-15 ne joue que sur les routes à sens unique ou à plus de deux voies […] Hors de ce cas, remonter par la droite reste un dépassement par la droite ») — voir l'examen ci-dessus |
| `42078575c362bf24a220380788994e25` | obstacle sur sa voie | règle (« c'est empiéter sur la moitié gauche de la chaussée ») + raison (« R414-7 ne l'autorise que si la circulation en sens inverse n'en est pas gênée ») + limite (« L'obstacle est de votre côté : l'attente aussi ») |
| `46269e3e9018b1949b8143894e86c4fc` | achever un dépassement engagé | règle (« rien n'oblige à interrompre la manœuvre ») + raison (« La voie de gauche est dégagée et la ligne discontinue autorise à l'emprunter ») + limite (« R414-10 demande seulement de revenir à droite ensuite, sans faire ralentir le véhicule doublé ») |
| `697b226c6270e1cee1a6e4edb95dec42` | sommet de côte | règle (« interdit tout dépassement sur chaussée à double sens quand la visibilité vers l'avant manque ») + raison (« cite le sommet de côte comme cas typique ») + limite/clarification (« Ce n'est pas ce qui vient en face qui l'interdit, c'est de l'ignorer ») |
| `75e142d94ea93f63d0e75fa19a8f8c4f` | se faire dépasser | règle (« serrer immédiatement sur sa droite sans accélérer ») + raison (« Accélérer allonge la manœuvre et le temps passé sur la voie de gauche ») + limite (« c'est le seul manquement de cet article qui coûte des points, deux en l'occurrence ») |
| `93292bac6a7b17452c0e2ad2b30164fa` | neige ou verglas, > 3,5 t | règle (« ni dépassement ni changement de file, au-delà de 3,5 tonnes comme pour un ensemble de plus de 7 mètres ») + raison/portée (« R414-17 vise la neige et le verglas, jamais la pluie ») + limite (le distracteur pluie/autoroute explicitement écarté dans le corps même de l'explication) |
| `99824d4de286434d85174502e05ea59d` | chaussée à trois voies | règle (« interdit à qui dépasse d'emprunter la voie la plus à gauche d'une chaussée à double sens de plus de deux voies ») + raison (« ce qui revient à la laisser à ceux qui viennent en face ») + limite (« La voie centrale est celle du dépassement ») |
| `9aaede46c1c808687f89f4a8fb81f9df` | rabattement trop court | règle (« demande de revenir sur sa droite sans provoquer le ralentissement du véhicule dépassé ») + raison (« Se rabattre à un mètre de son pare-chocs l'oblige à lever le pied ») + limite (« la place n'est reprise que quand elle ne coûte rien ») |
| `acfa94cddf8eadadd75d07c9b97a5501` | ne pas s'engager si sur le point d'être dépassé | règle (le 3° de la condition, « vous êtes sur le point d'être dépassé ») + raison (rappel des deux autres conditions, reprendre sa place et une vitesse relative brève) + limite/image (« Deux dépassements emboîtés mettraient trois véhicules de front ») |
| `ad7c53ef7c57cb946c12b29bc36c004f` | dépassement par la droite obligatoire | règle (« deux cas à part : le véhicule qui se dispose à tourner à gauche, et celui qui circule sur une voie ferrée ») + raison (« Le contourner par la gauche croiserait sa trajectoire ») + limite (seuls ces deux cas, le distracteur générique « vous fait signe » n'en fait pas partie) |
| `b494d71578b339d0259157dd378a3b9b` | passage pour piétons | règle (« il impose de s'être assuré qu'aucun piéton n'est engagé sur le passage ») + raison (« Le danger tient au masque ») + limite (« R414-5 ne prononce pas d'interdiction », distingue la condition de vérification d'une interdiction pure) |
| `e5b0f585f1a3654ca790b9e391db8203` | voie ferrée sans barrière | règle (« vise les seules traversées dépourvues de barrière et de demi-barrière ») + raison (« rien n'y matérialise l'arrêt, et le véhicule doublé masque justement la voie ») + limite (« Là où une barrière existe, c'est elle qui commande ») |
| `f5a12ba77751310fe9a210a3b787286a` | dépassement près d'une intersection | règle (« lève l'interdiction pour qui aborde une intersection où les autres doivent lui laisser le passage, ou dont le franchissement est réglé par des feux ou par un agent ») + raison (la priorité de passage justifie l'exception) + limite/distinction (« C'est le dépassement d'un deux-roues qui échappe à l'interdiction, pas le dépassement par un deux-roues ») |

Modifiée 1 (`f1ae9582…`) + non modifiées 14 = 15, sans reste.

### Les options

Relues carte par carte contre les sept règles du §2 de `questions.md`, puis contre le
point 14 du calibrage (« existe-t-il une lecture où il est la bonne réponse ? »). Aucun
distracteur inventé sans existence réelle : le seul chiffre qui n'est
pas dans le texte de son propre article — « dix secondes » sur `acfa94cd…` — est nommé
comme repère d'enseignement par la ligne de registre elle-même, pas comme une valeur du
code, et reste une confusion réelle plutôt qu'un nombre sorti de nulle part ; les valeurs
recyclées (« 30 km/h » sur `2fc1ed8a…`, « 3,5 t » sur `b494d715…`) sont chacune la vraie
valeur d'un **autre** article de la banque, notée comme telle par la ligne de registre.
Aucun distracteur éliminable par la seule forme de l'énoncé, aucun légitimé par
l'explication de sa propre carte, et aucun qui soit un cas particulier de la bonne
réponse une fois relu après l'ajout de la limite sur `f1ae9582…` (les quatre options —
serrer à droite, rester au milieu, se déporter au centre, passer en feux de route — sont
inchangées par cet ajout et restent quatre comportements distincts). `correctID`
inchangé : la seule édition porte sur l'explication, aucune option n'a été touchée, donc
aucune rotation n'était nécessaire.

**`correctID` — mesuré avant et après, inchangé.** A 4, B 4, C 4, D 3 sur les 15 cartes,
aux deux bouts de la tâche : la répartition était déjà proche de l'uniforme (3,75 par
lettre) et l'unique édition ne touche aucune option, donc aucune rotation n'a été
nécessaire.

### Recoupement croisé avec « Usagers & partage de la route » et « Vitesse »

**`Usagers & partage de la route`** teste la distance latérale au dépassement d'un
cycliste (`9b774739866a136e7c2a9bd69b2f417d`, énoncé « Vous dépassez ce cycliste en le
laissant à au moins : », réponse « 1 m de son guidon », IV de R414-4). Aucune des 15
cartes du lot ne mentionne de cycliste, de distance latérale ni de chiffre en mètres pour
un dépassement ; `acfa94cd…` cite bien le II de R414-4, mais son 3° (ne pas entamer un
dépassement si l'on est soi-même sur le point d'être dépassé) est un alinéa distinct de
celui que teste `Usagers`. Aucun recouvrement.

**`Vitesse`** ne porte, après vérification, aucune carte sur ce qu'une ligne continue
interdit — cette matière (R412-19, franchir coûte 3 points, chevaucher 1) vit dans
`Panneaux & marquage` (`37fe1af42b8d8141…`, `3cb86b6e4c489d919…`), domaine non encore
traité par cette passe. `697b226c…` cite « une ligne continue » uniquement dans la
citation intégrale de R414-11 conservée au registre (l'exception qui laisse libre la
partie gauche d'une ligne continue), jamais dans le corps de la carte elle-même — la
scène ne montre ni ligne continue ni deux-roues, et l'explication ne mentionne aucun des
deux, conformément à la note déjà portée par le registre (« Aucune des deux réserves ne
joue sur la scène »). Aucun recouvrement, ni avec `Vitesse` ni avec `Panneaux & marquage`.

### Point 13 — réponses sous trois mots pleins, cherchées à la main

Sur les 15 bonnes réponses du lot, une seule tombe sous le seuil de trois mots pleins
(jetons `[a-z0-9]+` d'au moins cinq caractères, minuscules et accents retirés) :

| id | bonne réponse | mots pleins (≥ 5 car.) | n |
|---|---|---|---|
| `acfa94cddf8eadadd75d07c9b97a5501` | « vous êtes sur le point d'être dépassé » | `depasse`, `point` | 2 |

```
$ python3 - <<'EOF'
import json
qs = json.load(open('Valido/Resources/questions.json'))
for q in qs:
    if q['subject'] != 'code': continue
    champs = [q['prompt'], q['explanation']] + [o['text'] for o in q['options']]
    if any("être dépassé" in c.lower() or "point d'être dépassé" in c.lower() for c in champs):
        print(q['id'][:18], q['topic'])
EOF
acfa94cddf8eadadd7 Croisement & dépassement
```

Une seule occurrence dans toute la banque `code`, sur la carte elle-même (son option D,
la bonne réponse). Aucune autre carte — dans ce domaine ou ailleurs — n'énonce ni ne
paraphrase « être sur le point d'être dépassé » en énoncé, option ou explication.
`75e142d9…` (« Un véhicule s'apprête à vous dépasser ») décrit la situation inverse (qui
dépasse, pas qui est sur le point d'être dépassé une deuxième fois) et teste une règle
différente (R414-16, pas R414-4 II 3°) : proximité thématique attendue dans un domaine
bâti sur le même vocabulaire, pas une fuite.

### Point 17 — relecture séparée, contre les bonnes réponses et les options des voisines

Les 15 explications relues une par une contre les bonnes réponses **et** les options des
14 autres cartes du lot, y compris reformulées : aucune n'énonce la réponse d'une autre.
Les recoupements de vocabulaire partagé sont attendus et non des fuites — « dépassement »,
« voie de gauche », « véhicule doublé » reviennent sur plusieurs cartes parce que le
domaine entier porte sur le même geste, jamais avec la valeur ou la condition qui
distingue une carte d'une autre. Cas vérifiés en particulier, les groupes de cartes qui
partagent une même scène ou un même article :

- `46269e3e…` (achever le dépassement) et `9aaede46…` (rabattement) portent toutes deux
  la même obligation de R414-10 (revenir à droite sans faire ralentir le véhicule
  doublé/dépassé), chacune dans ses propres mots (« sans faire ralentir le véhicule
  doublé » pour l'une, « sans provoquer le ralentissement du véhicule dépassé » pour
  l'autre) — chacune teste un moment différent de la manœuvre (pendant vs après), et ni
  l'une ni l'autre ne cite le fait distinctif de l'autre (la ligne discontinue dégagée
  pour l'une, le mètre de distance pour l'autre).
- `93292bac…` (neige/verglas, > 3,5 t) et `b494d715…` (passage piéton) partagent le
  chiffre « 3,5 t », mais seulement dans une **option fausse** de `b494d715…`
  (« interdit aux seuls véhicules de plus de 3,5 t ») — jamais dans son explication, et
  la ligne de registre documente ce recyclage comme volontaire.
- `e5b0f585…` (voie ferrée) et le topic `Tunnels & passages à niveau` : la carte est
  écrite « au titre du dépassement » (registre), ne mentionne aucun chiffre de délai ni
  de fonctionnement des barrières — le régime du franchissement lui-même reste hors de ce
  domaine.
- `697b226c…` (sommet de côte) et `f5a12ba7…` (intersection) partagent R414-11 en entier
  (alinéas 1 et 2) mais testent chacun un alinéa distinct, sans jamais citer la condition
  propre à l'autre.

Voir aussi la section dédiée ci-dessus pour `Usagers & partage de la route` et `Vitesse`.

### Commandes et sorties, étapes 1, 6, 7, 9

```
$ mkdir -p .passe3 && python3 Tools/audit.py > .passe3/avant-12.txt
$ grep -E '^### ' .passe3/avant-12.txt
### lettre/reference  (1)
### forme/markdown  (1)
### forme/seule-ponctuee  (14)
### longueur/plus-longue  (84)
### expl/paraphrase-litterale  (20)
$ python3 - <<'EOF'   # comptage du lot
… voir Step 1 …
EOF
15 cartes | expl médiane 231 | sous 120 : 0 | illustrées : 4

$ python3 Tools/relire.py "Croisement & dépassement" > .passe3/lot-12.txt   # lecture des 15 cartes contre leur ligne

$ python3 - <<'EOF'   # renormalisation
… voir Step 6 …
EOF
448 questions

$ python3 - <<'EOF'   # comparaison des id avant/après (contre HEAD, avant la tâche 12)
… voir Step 6 …
EOF
mêmes ids : True | 448 -> 448
ajoutés : [] | retirés : []

$ python3 Tools/relire.py --fuites "Croisement & dépassement" | tail -40
0 recouvrement(s) sur 15 cartes de « Croisement & dépassement ».

$ python3 Tools/audit.py > .passe3/apres-12.txt
$ diff <(grep -E '^### ' .passe3/avant-12.txt) <(grep -E '^### ' .passe3/apres-12.txt) || true
(rien : les deux fichiers ont les mêmes cinq lignes `### `, aucune sortie vide n'est
devenue non vide)

$ DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcrun simctl boot 'iPhone 17 Pro' 2>/dev/null || true
$ DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test -project Valido.xcodeproj \
    -scheme Valido -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
    -only-testing:'ValidoTests/leContenuLivréEstValide()' [# … 10 tests …] 2>&1 | tail -30
✔ Test run with 10 tests in 0 suites passed after 0.067 seconds.
** TEST SUCCEEDED **

$ git status --short   # après questions.json ; Contents.json non reformatés cette fois
 M Valido/Resources/questions.json
?? CLAUDE.md
```

### Mouvements d'`audit.py`

| sortie | avant | après |
|---|---|---|
| `lettre/reference` | 1 | 1 |
| `forme/markdown` | 1 | 1 |
| `forme/seule-ponctuee` | 14 | 14 |
| `longueur/plus-longue` | 84 | 84 |
| `expl/paraphrase-litterale` | 20 | 20 |
| `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10`, `forme/backtick-isole` | vides | vides |

Aucun mouvement : la seule édition ajoute une clause à une explication déjà sous les
seuils informatifs, sans toucher une option ni une longueur. `expl/paraphrase-litterale`
reste à 20 (ni régression, ni le mouvement attendu — ce domaine n'y contribuait aucune
carte avant la tâche, et n'y en contribue toujours aucune). `--fuites` sur le domaine :
0 recouvrement avant et après édition, sur 15 cartes.
