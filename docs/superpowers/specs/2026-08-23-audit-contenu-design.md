# Audit de contenu, passe 2 — fraîcheur, couverture, illustrations

Spec du 2026-08-23. Deuxième audit de la banque de questions, après celui d'août 2026
consigné dans [`Tools/audit-2026-08.md`](../../../Tools/audit-2026-08.md).

## Le problème

L'app est jugée bonne ; le contenu ne l'est pas encore. Trois défauts, dans l'ordre de
gravité :

1. **Rien ne garantit qu'une question `code` est à jour.** Les 136 questions `code`
   affirment des vitesses, des barèmes, des sanctions. La passe d'août a vérifié une
   partie de ces valeurs et l'a consignée **en prose**, dans un document qui ne se
   rattache à aucune question. Six mois plus tard, personne ne peut dire quelle question
   a été vérifiée, contre quoi, ni quand. La passe d'août a trouvé un chiffre périmé
   depuis trois jours : le risque n'est pas théorique.
2. **La couverture n'est adossée à rien.** Les dix topics `code` sont une invention du
   dépôt, pas le référentiel de l'épreuve. Plusieurs pans de l'ETG sont absents —
   les autres usagers, le chargement, les équipements de sécurité, les tunnels et
   passages à niveau, les intempéries.
3. **171 des 174 énoncés `swift` sont des fragments** finissant par « : », hérités des
   flashcards Notion. La plupart se tiennent ; certains sont irrépondables sans connaître
   déjà la réponse.

S'y ajoute une occasion manquée : huit questions illustrées sur 310, alors que l'ETG est
un examen visuel. Un panneau se reconnaît, il ne se récite pas.

## Ce qui est décidé

| Décision | Retenu | Écarté |
|---|---|---|
| Énoncés `swift` | Chirurgical : seuls les cassés | Conversion systématique des 171 fragments |
| Illustrations | Large, ~33 nouveaux assets | Panneaux seuls ; ciblage minimal |
| Couverture | Combler, `code` **et** `swift` | Rapport seul ; `code` seulement |
| Sources | Liste blanche élargie aux officiels européens et académiques | Stricte ; ouverte |
| Approche | Par thématique ETG, de bout en bout, socle d'abord | Par chantier ; outillage lourd d'abord |

Le style « fragment » reste la norme de la banque `swift` : il est court, et la contrainte
de hauteur de carte est réelle. Ce qui se corrige, c'est l'ambiguïté, pas le format.

L'approche par thématique est retenue parce qu'elle évite d'écrire les questions deux
fois. Écrire une question puis décider de l'illustrer oblige à la réécrire : l'image doit
lui reprendre sa substance. En traitant un domaine de bout en bout — vérifier, écrire,
illustrer — chaque question naît en sachant si une image la porte.

## Le socle

Quatre chantiers d'outillage, à faire avant de toucher au contenu. Tous suivent le
précédent d'[`images.md`](../../../Tools/images.md) : un registre en markdown, lisible à
l'œil, imposé par `audit.py`.

### `Tools/sources.md` — le registre de fraîcheur

Une ligne par question `code`, sans exception.

| colonne | contenu |
|---|---|
| `id` | l'identifiant de la question |
| `nature` | `stable` ou `datée` |
| `affirmation` | ce qui est vérifié, en une phrase |
| `source` | URL, vide si `stable` |
| `relevé le` | date de consultation, vide si `stable` |

`nature` est **déclarée, pas déduite** : aucun script ne peut décider si « le clignotant
s'utilise à chaque changement de voie » porte une valeur datable. `stable` désigne une
règle sans chiffre ni sanction ; `datée` désigne tout seuil, barème, montant, durée ou
qualification pénale.

`audit.py` vérifie que chaque question `code` a exactement une ligne, que chaque `datée`
porte une URL d'un domaine de la liste blanche **et** une date, et signale les relevés de
plus de douze mois. Une question `code` sans ligne est une erreur dure : c'est la seule
manière d'empêcher qu'une question neuve entre non vérifiée.

### `Tools/couverture.md` — la carte de couverture

Thématique ETG → topics Valido qui la traitent → volume → verdict. `audit.py` refuse un
`topic` `code` qui ne se rattache à aucune thématique déclarée, ce qui attrape à la fois
les fautes de frappe et les topics orphelins.

`topic` est un `String` libre, affiché comme simple étiquette
(`QuestionCardView.swift:124`) et consommé nulle part ailleurs : créer des topics ne coûte
rien en code.

**Le libellé exact des thématiques est à établir avant tout le reste.** La page officielle
de securite-routiere.gouv.fr est rendue en JavaScript et son corps revient vide ;
l'arrêté du 29 avril 2024 ne porte que l'organisation de l'épreuve. La recherche indique
onze thématiques, pas dix. Cette liste est la fondation de la carte : elle se relève sur
une source officielle, elle ne se reconstitue pas de mémoire. Si aucune source de la liste
blanche ne la donne, on le consigne et on adosse la carte au référentiel le plus officiel
trouvé, en le nommant.

### `Tools/Scenes/` — les primitives de panneaux

`render-scenes.swift` fait 453 lignes pour six scènes, avec les panneaux en fonctions
jetables (`panneauStop`, `panneauCedez`, `panneauRoutePrioritaire`). À quarante scènes le
fichier dépasse 1500 lignes.

Le script est découpé en `Tools/Scenes/*.swift`, compilé par `Tools/render-scenes.sh`
(`swiftc` puis exécution). Une couche de primitives est introduite : `Forme` (disque,
triangle, triangle inversé, octogone, carré, losange) × `Pictogramme`. Un panneau coûte
alors une dizaine de lignes, et surtout **il est dessiné une fois** : l'AB6 sert la
question « ce panneau signifie » et la scène de carrefour qui le contient.

`CLAUDE.md` et `images.md` documentent la nouvelle commande. La règle inchangée : on édite
la scène dans le code, jamais les PNG.

### Budget de hauteur imposé par `audit.py`

Le §7 de `questions.md` chiffre le budget d'une question illustrée — énoncé sur deux
lignes, options de 50 caractères, explication autour de 200 — mais c'est de la prose. À
quarante questions illustrées, ça devient un contrôle dur : sur une question portant une
`illustration`, énoncé ≤ 70 caractères, chaque option ≤ 50, explication ≤ 220.

Sans ce contrôle, une explication trop longue fait tomber le bandeau à 8 % de la carte —
il ne reste qu'une bande de la scène, et rien ne le signale.

## Piste `code` — fraîcheur et couverture

Thématique par thématique, dans l'ordre de leur poids à l'examen. Pour chacune :

1. relire les questions existantes du domaine ;
2. vérifier chaque affirmation datable contre la liste blanche ;
3. remplir le registre de sources ;
4. écrire les questions manquantes ;
5. illustrer celles qui le gagnent.

Un commit par thématique. Les trois règles du §5 s'appliquent sans exception : **citer la
source et sa date**, **signaler au lieu de corriger** en cas de doute, **recycler
l'ancienne valeur en distracteur** — un chiffre périmé est le meilleur distracteur qui
existe, puisque c'est celui que le candidat aura lu ailleurs.

Volume attendu : 136 → environ 190 questions `code`.

### Les points laissés ouverts en août

Cette passe les ferme, ou dit pourquoi elle ne peut pas :

- **Loi n° 2026-798 du 18 août 2026** — seul L235-1 a été balayé. Restent la rétention du
  permis (L224-1), L233-1, et les renvois à L236-1 / L236-2, sachant que la
  [décision n° 2026-915 DC du 14 août 2026](https://www.legifrance.gouv.fr/jorf/id/JORFTEXT000054707332)
  en a censuré une partie. Il faut établir ce qui est en vigueur avant d'écrire.
- **ZFE et Crit'Air** — la page ministérielle a plus d'un an et une suppression a été
  votée à l'Assemblée. Vérifier l'état du droit, pas l'état de la page.
- **Périphérique parisien** — R413-3 permet 70 km/h, la Ville a abaissé à 50. Une question
  est écrivable si l'écart entre règle nationale et arrêté local est le sujet.
- **Drogue + alcool = 9 points** sur service-public contre un plafond de 8 à
  [R223-2](https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000006841413) — la
  contradiction est dans les sources officielles elles-mêmes. Aucune question ne s'y
  adosse ; l'inscrire au registre comme point de vigilance.

### La liste blanche, élargie

Ajoutées à legifrance.gouv.fr, securite-routiere.gouv.fr, service-public.gouv.fr,
ecologie.gouv.fr et sante.gouv.fr :

- **Convention de Vienne sur la signalisation routière** et **EUR-Lex** — la géométrie et
  la sémantique normalisées des panneaux ;
- **ERC Guidelines** et **Croix-Rouge française** — les gestes de premiers secours, dont
  le chiffrage n'existe sur aucun domaine gouvernemental (la passe d'août avait renoncé à
  écrire ces questions pour cette raison) ;
- **INRS** — secours et risques.

Toujours des institutions : aucun éditeur d'ETG, aucun site d'auto-école. Ces sites se
recopient et périment sans le dire, ce qui est exactement le défaut qu'on corrige.
`questions.md` §5 est mis à jour.

## Piste `code` — les illustrations

Environ dix-huit panneaux et quinze scènes, soit ~33 nouveaux assets et une banque passant
de 8 à ~40 questions illustrées.

Le critère de sélection est celui du §7, appliqué strictement : **si la question se tient
sans l'image, elle n'est pas illustrée.** En pratique, illustrer une question existante
veut dire lui retirer ce que l'image dira — « Que signifie le panneau AB6 ? » devient « Ce
panneau signifie : ». Une question dont le texte ne peut pas céder sa substance à une
image reste en texte, et la liste de ces refus fait partie du livrable.

Contraintes tenues, toutes déjà écrites au §7 : cadrage 4:3, géométrie décisive au centre
vertical, liseré blanc sur le véhicule du candidat, désignation des véhicules par leur
provenance et jamais par leur couleur, `alt` qui **est** l'énoncé pour qui n'accède pas à
l'image.

Chaque asset reçoit sa ligne dans `images.md`. Tous les nouveaux sont des schémas
générés — aucune source tierce, donc aucune question de licence.

## Piste `swift`

### Les énoncés cassés

Les 174 sont relus avec un critère reproductible, pas au ressenti. Un énoncé est cassé
s'il tombe dans l'un des trois cas :

- il est irrépondable sans connaître déjà la réponse ;
- la bonne réponse dépend d'un contexte que l'énoncé ne donne pas ;
- il nomme une API sans dire quelle dimension est demandée — son rôle, son comportement,
  sa disponibilité.

La liste des énoncés retenus est soumise avant réécriture : c'est un jugement, et il doit
être validé avant d'être appliqué à trente ou quarante questions. Volume attendu : 20 à 40
énoncés touchés.

### Les trous

Inventaire iOS 26, Swift 6.2 et Xcode 26 contre les treize topics existants, puis 15 à 25
questions. Sources `developer.apple.com` et `swift.org`, portées en `sourceURL` comme le
reste de la banque `swift`.

## Vérification

`audit.py` se compare à la **ligne de base documentée** — `longueur/plus-longue` 98,
`expl/paraphrase-litterale` 23, `forme/seule-ponctuee` 14, plus deux faux positifs connus
— et non à zéro. Cette base bougera avec le volume ; la nouvelle base est consignée dans la
note d'audit.

Suite complète sur `iPhone 17 Pro` : trois runtimes déclarent un device `iPhone 17` et l'un
d'eux reste coincé. Vérifier la ligne `✔ Test run with N test(s)`, pas le
`** TEST SUCCEEDED **`.

`BundledContentTests` : seuils relevés à environ 95 % du nouveau volume, dans l'esprit
actuel — un effondrement casse, une variation de quelques questions non. Deux tests
ajoutés : nombre de questions illustrées, et budget de hauteur des questions illustrées.
Un échec s'y corrige **dans les données, jamais dans le test**.

## Livrables

- `Valido/Resources/questions.json` — ~190 `code` (dont ~40 illustrées) et ~195 `swift`
- `Tools/sources.md`, `Tools/couverture.md` — les deux registres neufs
- `Tools/Scenes/`, `Tools/render-scenes.sh` — le script découpé, primitives de panneaux
- `Valido/Assets.xcassets/Scenes/` — ~33 imagesets, quatre PNG chacun
- `Tools/audit.py` — contrôles registre, couverture, budget de hauteur
- `Tools/audit-2026-08-passe-2.md` — le rapport : corrections avec sources et dates,
  points signalés non corrigés, refus d'illustration, nouvelle ligne de base
- `Tools/questions.md` §5 et §7, `Tools/images.md`, `CLAUDE.md` — mis à jour
- `ValidoTests/BundledContentTests.swift` — seuils et deux tests neufs

Branche `audit-contenu-2026-08`, commit à chaque phase.

## Hors périmètre

- Aucune modification de l'app : ni vue, ni view model, ni scheduler, ni persistance. Le
  seul fichier Swift de la cible touché serait un modèle, et rien dans cette passe ne le
  demande — `topic` est déjà un `String` libre.
- Aucune photographie nouvelle. Les deux photos Wikimedia existantes restent ; les
  nouveaux visuels sont tous des schémas générés.
- Aucun retour à Notion. Le JSON fait foi.
- Pas de conversion systématique des fragments `swift`.
