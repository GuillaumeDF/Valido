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

**Deux cartes modifiées, sur les options, pas sur la justesse :**

- `0e85e6a79127a2bae73abcc119e278bd` (tunnel, seconde infraction) — le distracteur A
  affirmait « une contravention de cinquième classe, 200 € dus ». 200 € ne correspond à
  aucun montant réel du barème routier (contraventions forfaitaires : 35 / 68 / 135 /
  375 € ; au-delà, la 5e classe n'a pas de forfait et son plafond judiciaire est de
  1 500 €, art. 131-13 5° du code pénal, « 1 500 euros au plus », version en vigueur
  depuis le 01/04/2005, relevé par `WebFetch` le 2026-08-27). Corrigé en « une
  contravention de cinquième classe, jusqu'à 1 500 € » : le distracteur reste faux (ce
  n'est pas une contravention mais un délit), mais son chiffre est désormais réel plutôt
  qu'inventé — le défaut nommé au point 2 du calibrage (« Vitesse » et « 45 / 120 km/h »,
  « Alcool » et « 150 € »). Aucune ligne de `sources.md` à toucher : un distracteur
  affirmé faux n'a pas besoin de ligne, et celui-ci ne recycle pas un chiffre pris
  ailleurs dans la banque — sa source est donc portée ici plutôt que dans le registre.
- `37fe1af42b8d81e7a041ff53b8ef69c2` (non-respect des distances, sanction) — réglé le
  doublon inter-domaines détaillé plus bas.

### Preuve par carte, pour les 19 cartes non modifiées

Règle / raison / limite telles que la carte les dit :

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
| `37fe1af42b8d817eb292c10d8effbad4` | composition de la distance d'arrêt | règle (réaction + freinage) + raison (fatigue, téléphone, alcool allongent la distance d'arrêt via la réaction) + limite (« sans que le freinage n'y change quoi que ce soit ») |
| `37fe1af42b8d81e48a72e74c9a2454a2` | freinage sur sol mouillé | règle (augmente, adhérence en moins) + raison (adhérence divisée par deux) + limite explicite (« un modèle d'enseignement, pas un chiffre du code » ; réfute directement le distracteur ABS : « l'ABS […] n'empêche […] rien retirer à la distance ») |
| `37fe1af42b8d81e98af3c07ec3728454` | temps de réaction moyen | règle (1 seconde) + raison (percevoir, traiter, décider ; dégradé à deux par fatigue/alcool/téléphone) + limite (« une moyenne d'enseignement, pas une valeur inscrite dans un texte ») |
| `37fe1af42b8d81ef84ffe4578802422a` | fatigue ou téléphone | règle (allongent nettement la réaction) + raison (une longueur de voiture tous les 15 km/h, freinage inchangé) + limite explicite du champ d'application de la sanction (« le téléphone **tenu en main** […] interdit » — pas l'usage mains libres) |
| `4ade42a7e2c69ec43159940235d08c5f` | aquaplanage | règle (lever le pied, sans freiner ni braquer) + raison (les pneus ne guident plus rien, l'ordre donné s'applique brutalement au retour du contact) + limite (« jusqu'à ce que les sculptures reprennent l'eau ») |
| `8ddd0cebb28376040af43feb6f52c098` | secondes plutôt que mètres | règle (la distance grandit avec la vitesse) + raison (citation R412-12 I mot pour mot) + limite (« un nombre de mètres […] vaudrait autant à 30 qu'à 130 km/h ») |
| `9f0fe6e809948a327c918ac0b5987cf9` | ABS en freinage d'urgence | règle (appuyer d'un coup, maintenir) + raison (l'ABS empêche le blocage, la pédale n'a plus besoin d'être relâchée) + limite explicite, contre l'idée reçue (« il ne raccourcit pas la distance de freinage — il conserve la direction ») |
| `a225e45864e11748d6175d67476529d0` | insertion depuis une bretelle (R421-3) | règle (citation mot pour mot, céder le passage) + raison implicite (priorité au flot déjà engagé) + limite (comment s'exécute la règle sans s'arrêter : « utiliser toute la voie d'accélération ») |
| `a4f04a8078a925fbc8c5df10f063e065` | circulation sur la BAU (R412-8) | règle (citation mot pour mot, interdite) + raison (« la bande doit rester libre pour les secours ») + limite explicite, contraste avec l'article voisin (voir « doublon » et « fuites » ci-dessous) |
| `aad60a7453493cc6716b731af7579ebc` | arrêt sur la BAU (R421-7) | règle (35 €, sans point) + raison (« sauf en cas de nécessité absolue » ; présignalisation, dégagement d'urgence) + limite explicite, contraste avec R412-8 (« les 135 € et les 3 points existent bel et bien, mais pour l'article R412-8 […] pas l'arrêt ») |
| `f376d218b64a41796d6efebc8ad0bb2d` | plancher poids lourds (R412-12 II) | règle (50 m) + raison (> 3,5 t ou > 7 m, même vitesse, hors agglomération) + limite explicite (« à 90 km/h, deux secondes valent justement 50 mètres — le plancher ne mord donc qu'en dessous de cette vitesse ») |

Modifiées 2 + non modifiées 19 = 21, sans reste.

### Les options

Relues carte par carte contre les sept règles du §2 de `questions.md`, puis contre le
point 14 du calibrage (« existe-t-il une lecture où le distracteur EST la bonne
réponse ? »). Aucun distracteur invérifiable par pure logique, aucune rupture de motif
grammatical isolant la bonne réponse, aucun distracteur que sa propre carte légitime.
Deux paires méritent d'être nommées parce qu'elles jouent délibérément sur des chiffres
réels recyclés entre cartes voisines : `a4f04a8078a9…` (R412-8, circulation sur la BAU,
135 €/3 points) et `aad60a7453…` (R421-7, arrêt sur la BAU, 35 €/0 point) recyclent
chacune le vrai montant de l'autre comme distracteur — c'est le « rapport de quatre »
que la ligne de registre nomme comme raison d'être de la paire, pas un chiffre inventé.
Sur `a225e45864e11748d6…` (insertion bretelle), le distracteur D (« cédez le passage,
quitte à vous arrêter sur la bretelle ») a été relu contre le point 14 : ce n'est pas un
cas particulier de la bonne réponse C (« cédez le passage aux véhicules déjà sur la
chaussée »), parce que céder le passage s'exécute par l'allure (rejoindre la vitesse du
flot sur la voie d'accélération), jamais par l'arrêt sur la bretelle, qui est le geste
dangereux que l'explication écarte implicitement (« reste à utiliser toute la voie
d'accélération »). Seul le distracteur A de `0e85e6a79127a2bae7…` a été réécrit (voir
« Pédagogie » ci-dessus) ; seule l'option C de `…81e7a0` a été réécrite (voir
« doublon » ci-dessous). `correctID` sur les 21 cartes, mesuré avant et après cette
tâche : A 3, B 5, C 3, D 10 — inchangé par les deux éditions, ni l'une ni l'autre
n'ayant déplacé une bonne réponse d'une lettre à l'autre. Le total est biaisé vers D
(10/21), mais c'est un état préexistant à cette tâche, pas un effet de ses deux
retouches : la consigne de rotation cyclique s'applique quand des *modifications*
empilent la réponse sur une lettre, ce qui ne s'est pas produit ici. Rééquilibrer les
19 cartes non touchées aurait débordé du périmètre de cette tâche — aucune de leurs
options n'a été jugée fautive — donc signalé ici plutôt que corrigé au jugé.

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
plus une suspension « pour une durée de trois ans au plus » (VI de R412-12), déjà
citée dans l'explication de la carte avant cette tâche. La correction porte donc ce
fait déjà affirmé dans l'option elle-même plutôt que de le laisser dans la seule
explication : « 135 € d'amende, 3 points et suspension possible » (47 caractères ;
deuxième distracteur le plus long à 37, écart +10, dans la zone informative
`longueur/plus-longue`, pas dans `longueur/plus-10` qui reste vide). Aucune ligne de
`sources.md` à toucher : le fait était déjà affirmé, seul son emplacement dans la
carte change. `grep -c "135 € d'amende et 3 points de moins" Valido/Resources/questions.json`
ne retrouve plus qu'une occurrence, sur la carte « Permis & sanctions » — inchangée,
comme demandé.

### Fuites — vérification à la main, avec la vraie définition de l'outil

`relire.py --fuites` ne regarde qu'une bonne réponse d'au moins **trois mots pleins**
(jetons `[a-z0-9]+` d'au moins cinq caractères, après minuscule et suppression des
accents). Sur les 21 bonnes réponses du domaine, **huit** tombent sous ce seuil :

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

Les huit cherchées à la main (`grep` sur les 21 explications de `.passe3/lot-07.txt`,
motifs « bandes de », « 14 m »/« quatorze »/« 13,9 », « dizaines… trois », « quadruple »/
« multipliée par quatre », « deux secondes », « 72 m », « une seconde », « 135 € ») :

- **Trois recouvrements réels, tous jugés délibérés et laissés en l'état.** « une
  seconde » (temps de réaction moyen, `…81e98a`) réapparaît dans l'explication de sa
  voisine `…8104b1` (« La Sécurité routière retient une seconde comme moyenne… ») : les
  deux cartes testent explicitement la même valeur sous deux angles complémentaires (le
  temps lui-même, puis la distance qu'il fait parcourir à 50 km/h) — c'est le chaînage
  que le brief annonçait pour ce domaine, pas une fuite. « deux secondes » (intervalle
  de sécurité, `…812db5`) réapparaît dans l'explication de `8ddd0cebb28376040a`
  (« un délai d'au moins deux secondes », citation mot pour mot de R412-12 I) : cette
  carte teste *pourquoi* le code compte en secondes, elle a besoin de citer la valeur
  pour le montrer. Et le contenu numérique de « interdit, et puni de 135 € et 3
  points » (circulation sur la bande d'arrêt d'urgence, `a4f04a8078a9…`) — les deux
  chiffres, pas le mot « interdit » — réapparaît dans l'explication de sa carte-sœur
  `aad60a7453493cc671…` (« Les 135 € et les 3 points existent bel et bien, mais pour
  l'article R412-8 ») : c'est très exactement le contraste que la ligne de
  registre de `a4f04a…` annonce comme la raison d'être de la paire (« deux articles
  voisins, deux régimes… la paire de questions »). Couper cette phrase déferait la seule
  chose que la carte voisine explique ; conformément au point 11 du calibrage, un zéro
  obtenu en abîmant une carte vraie est pire que le recouvrement — gardé, documenté.
- **Cinq propres.** « deux bandes de la ligne de rive », « 14 m », « 3 » (règle des
  dizaines), « 4 » (doublement du freinage) et « 72 m » ne réapparaissent dans aucune
  des vingt autres explications du domaine.

### Mouvements d'`audit.py`

| sortie | avant | après |
|---|---|---|
| `lettre/reference` | 1 | 1 |
| `forme/markdown` | 1 | 1 |
| `forme/seule-ponctuee` | 14 | 14 |
| `longueur/plus-longue` | 95 | 96 |
| `expl/paraphrase-litterale` | 17 | 17 |
| `schema/`, `couverture/`, `source/`, `fuite/`, `image/`, `longueur/plus-10`, `forme/backtick-isole` | vides | vides |

Le seul mouvement, +1 sur `longueur/plus-longue`, vient de la carte `…81e7a0` réglée
ci-dessus (bonne réponse à 47 caractères contre 37 pour le distracteur le plus long,
écart +10) — mouvement attendu et explicitement permis par le plan de la troisième
passe puisque les options sont réécrites. `--fuites "Distances & freinage"` : 1
recouvrement avant et après édition, fortuit et documenté ci-dessous, sur les vingt et
une cartes — inchangé par les deux éditions, qui ne touchaient ni l'une ni l'autre des
deux cartes en cause. `--fuites` sur les cinq domaines déjà clos, revérifié après
édition : 0 sur « Permis & sanctions », « Vitesse », « Alcool & stupéfiants » et
« Mécanique & environnement » ; 1 recouvrement incidental, inchangé et déjà documenté
par la tâche 5, sur « Usagers & partage de la route ».

**Le recouvrement fortuit de `--fuites` sur ce domaine.** `a4f04a8078a925fbc8c5df10f063e065`
(circulation sur la bande d'arrêt d'urgence) recouvre par ses mots pleins la bonne
réponse d'une carte `Vitesse` (« 4 points, avec suspension possible du permis », pour un
dépassement de 40 à 50 km/h). Les deux cartes ne partagent aucun fait : la mienne parle
de trois points, la sienne de quatre, et aucun chiffre n'est le même — seuls
« points », « suspension », « possible » et « permis » sont communs, du vocabulaire
générique du barème routier repris dans une bonne dizaine de cartes de la banque. Gardé
tel quel, conformément au point 11 du calibrage.
