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
d'entre elles ont été rerelevées ou complétées le 2026-08-27 (les cinq listées ci-dessus, plus
`37fe1af42b8d8158b3dbf9883bf83560` pour une précision déductive écrite en clair — voir
Pédagogie). Sur les treize cartes restantes, la carte ne dit rien de plus que ce que porte sa
ligne de registre.

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

**Preuve par carte, pour les dix cartes non modifiées** — la liste que la relecture aurait dû
produire dès le premier passage plutôt que de se limiter aux cartes portant un drapeau :

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
