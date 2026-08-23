# Rédiger et maintenir `questions.json`

`Valido/Resources/questions.json` **est** la source. Il n'y a plus de génération : on
édite le fichier, on repasse les contrôles, on lance les tests.

Format : tableau JSON d'objets `Question` (`Valido/Model/Question.swift`), indenté,
clés triées, UTF-8.

```python
json.dump(questions, f, ensure_ascii=False, indent=2, sort_keys=True)
```

État courant : **310 questions** — 136 `code`, 174 `swift`. Huit portent une image (voir le [§7](#7-les-questions-illustrées)).

## Les champs

- `id` — chaîne non vide, unique. Pour une question nouvelle :
  `hashlib.sha256(('valido-v2:' + prompt).encode()).hexdigest()[:32]`.
- `subject` — `code` ou `swift`.
- `topic` — un thème existant, tel quel (y compris `Outillage & diagnostics`). En créer
  un nouveau se paie en dilution : dix thèmes `code`, treize sections `swift`.
- `difficulty` — `facile`, `moyen` ou `costaud`.
- `prompt` — voir plus bas. Backticks conservés autour des identifiants.
- `options` — exactement 4, d'`id` `"A"`, `"B"`, `"C"`, `"D"`.
- `correctID` — la lettre. **Réparti à peu près uniformément** sur A/B/C/D. L'app
  mélange les options à l'affichage, donc ça ne compte que pour qui lit le JSON — mais
  un fichier où la réponse est toujours A est suspect. Pour rééquilibrer : faire
  **tourner les textes** d'options (rotation cyclique) jusqu'à ce que la bonne réponse
  tombe sur la lettre visée. L'ordre A–D ne porte aucun sens, l'opération est sans
  effet sur le contenu.
- `explanation` — non vide, au moins 40 caractères.
- `sourceURL` — présent sur les 150 questions `swift` d'origine. Sur une question
  nouvelle : **clé absente**, pas `null`.
- `illustration` — `{ asset, alt }` quand l'image porte l'énoncé, clé absente sinon.
  Détail au [§7](#7-les-questions-illustrées).

---

## 1. Écrire une question

Si la question porte une image, lire aussi le [§7](#7-les-questions-illustrées) : le
budget de hauteur y impose un énoncé et des options plus courts qu'ailleurs.

### `prompt` : un énoncé, pas un titre

Une phrase qui se lise naturellement **avant** une liste d'options, en français. Elle
se termine par `:` — ou par `?` pour une vraie question fermée.

| À éviter | `prompt` |
|---|---|
| La macro `@Entry` (iOS 18) ? | La macro `@Entry` (iOS 18) sert à : |
| Que garantit `Sendable` ? | `Sendable` garantit : |
| `weak` vs `unowned` : lequel choisir ? | Entre `weak` et `unowned` : |

### La bonne option : condenser, sans appauvrir

Une réponse en prose complète serait trois fois plus longue que les distracteurs, et
**l'option la plus longue étant la bonne est l'indice le plus fiable de tout QCM.** La
bonne option est une *affirmation condensée*, de longueur et de forme grammaticale
comparables aux trois distracteurs ; la prose complète reste dans `explanation`.

Pour `@Entry` : option = « déclarer une clé d'`EnvironmentValues` en une ligne » — pas
la phrase entière sur `EnvironmentKey` et les extensions.

Repère chiffré : longueur moyenne de la bonne option **52,5** caractères contre
**50,5** pour les distracteurs. Écart moyen actuel **+1,8** sur les `swift`, **+1,5**
sur les `code`.

### `explanation` : le pourquoi, jamais la paraphrase

Elle explique *pourquoi* c'est la bonne réponse, elle ne la reformule pas. Une réponse
chiffrée reprise dans l'explication est normale — le défaut est l'explication qui
**n'ajoute rien** :

> ❌ « 3 points, plus 135 € d'amende. »
> ✅ « Le barème range le téléphone au même niveau que la ceinture ou les distances de
> sécurité. Ce qui est visé n'est pas la conversation mais la main occupée et le regard
> qui quitte la route. »

Elle ne commence jamais par une lettre de réponse (`^[A-D]\s*[—–\-.)]`) et ne finit
jamais par un motif `[A-D] :`. **Les options sont mélangées à l'exécution** : une
explication qui commence par « B — » désigne une position qui n'existe plus.

### Les trois distracteurs — les sept règles

1. **Plausible pour qui sait à moitié.** Chacun nomme un concept, une API ou un
   comportement réel. Jamais de non-sens, jamais de blague.
2. **Réellement faux.** Après l'avoir écrit, vérifier qu'il n'est pas une seconde
   réponse défendable. Un distracteur discutable est un bug, pas une aspérité. Cas
   réels retirés : « Universal Link : ouvre l'app sans confirmation de l'utilisateur »
   (c'est un avantage réel des Universal Links) et « Keychain : vidé à la
   désinstallation » (comportement iOS depuis 10.3). Attention aussi aux distracteurs
   **partiellement** vrais, que seul l'énoncé rend faux : les checkouts SPM *sont* dans
   `DerivedData/SourcePackages`, `mxSignpost` *remonte* bien des événements d'usage, un
   générique non contraint *accepte* bien n'importe quel type, un en-tête `Range`
   *permet* bien de reprendre un téléchargement.
3. **Forme et longueur comparables** à la bonne option : même construction
   grammaticale, même ordre de grandeur en caractères.
4. **Non éliminable par pure logique.** Quelqu'un qui ne connaît pas le sujet ne doit
   pas pouvoir remonter à la réponse par la seule forme des options. Voir les pièges
   ci-dessous.
5. **La confusion courante est le meilleur distracteur.** Préférer l'API voisine ou la
   règle voisine qu'on mélange vraiment : `@main` pour `@Entry`, `T...` pour les
   parameter packs, `ObservableObject` pour `@Observable`, StoreKit 1 pour StoreKit 2,
   `Sendable` pour `actor`, `nonisolated` pour `isolated` ; « cédez le passage » pour le
   STOP, le seuil de 0,5 g/L pour le seuil probatoire de 0,2, les anciennes peines pour
   les nouvelles.
6. **Jamais** « toutes les réponses ci-dessus », « aucune », ni aucune méta-option.
7. **Compter les distracteurs récurrents sur l'ensemble de la banque**, pas seulement à
   l'intérieur d'une question. « Klaxonner » servait de mauvaise réponse dans **sept**
   questions `code` : le candidat apprend que ce n'est jamais la réponse, et sept
   questions perdent un distracteur. Même piège pour « Aucune sanction », « Rien ».

Et un corollaire de la règle 1 : **un distracteur absurde ne fait pas travailler la
question, il la ramène à trois options.** Retirés pour ce motif : « Un témoin rouge
allumé : *Tout va bien* », « Niveaux à surveiller : *la peinture*, *la pression des
sièges* », « L'alcool s'élimine : *instantanément après un repas* ».

### Recadrer plutôt que jeter

Si un sujet ne peut pas devenir un QCM honnête — réponse en liste, snippet de code,
question trop ouverte pour avoir une bonne réponse unique — **ne pas forcer**. Mais
avant d'écarter, déplacer l'angle de l'énoncé :

- « Documents vs Caches vs tmp ? » (trois définitions, pas de réponse unique)
  → « un fichier que l'app peut retélécharger à tout moment va dans : » → `Caches`,
  les trois dossiers servant d'options. La liste complète reste dans `explanation`.
- « CloudKit : public vs private vs shared ? » → « la base `shared` contient : », les
  deux autres bases en distracteurs.
- « Les couches de VIPER ? » → « la couche qui porte la logique métier » (l'énumération
  en option se résolvait par les initiales).

---

## 2. Les neuf pièges de forme

Ceux qui ont réellement coûté des corrections.

- **Écart de registre.** *Le plus coûteux.* La bonne réponse est rédigée en procédure
  complète, les distracteurs en un ou deux mots. Mesuré sur les 100 `code` de la v1 :
  +12,1 caractères d'écart moyen, ramenés à +1,5.

  ```
  Avant   A  Démarrer rapidement                                          (19)
          B  Mettre le clignotant, contrôler les angles morts et céder…    (68)  ← bonne
          C  Klaxonner                                                     (9)
          D  Reculer d'abord                                              (15)

  Après   A  Démarrer sans attendre, en comptant sur les autres pour freiner  (62)
          B  Mettre le clignotant, contrôler les angles morts et céder…       (68)  ← bonne
          C  Klaxonner pour signaler votre départ, puis vous insérer          (54)
          D  Reculer pour dégager l'avant, puis sortir sans contrôle          (54)
  ```

  Corriger en **étoffant les distracteurs**, jamais en raccourcissant la bonne réponse :
  c'est elle qui porte la formulation juste, et la tronquer abîme le contenu pour sauver
  une statistique.

- **Fuite de mot d'énoncé.** Un mot distinctif du `prompt` réapparaît **seulement** dans
  la bonne option. Un lecteur sans aucune connaissance apparie les deux. Correctif :
  soit placer le même mot dans un distracteur, soit le retirer de la bonne option
  (l'information reste dans `explanation`). Exemples corrigés : `hangs` → l'énoncé
  devient « une interface qui se fige par intermittence » ; `Glass` → l'option perd
  `.glassEffect()` ; `usure` → l'option dit « la limite légale de profondeur » ;
  `brouillard` → l'énoncé dit « feux arrière antibrouillard ».
  **Le seuil du détecteur compte** : une première passe à 7 caractères a laissé passer
  `await`, `hangs` et `glass`. Descendre à **4 caractères**, avec une liste de mots vides
  française et les accents normalisés.

- **Rupture de motif grammatical.** Trois distracteurs en « De… » et une bonne réponse
  en groupe nominal : le lecteur rompu au QCM choisit la forme isolée. Aligner les
  quatre ouvertures (« il… », « on… », « le type… », « De… »).

- **Genre isolé.** Piège propre au français : « Une interdiction / **Un danger** / Une
  obligation / Une indication » — la seule masculine se repère sans rien connaître.
  Équilibrer à deux-deux, en reformulant un distracteur (« Un ordre à exécuter dès le
  panneau franchi » pour l'obligation).

- **Marqueur de détail isolé.** Plus fin que la longueur : la bonne réponse est la seule
  à porter une virgule, une parenthèse ou une seconde proposition. Le signal ne devient
  exploitable que **cumulé avec la longueur** — c'est ce cumul qu'il faut ramener à zéro,
  pas la virgule elle-même. Et préférer une vraie seconde proposition à une virgule
  postiche : « le type circule entre tâches, sans être copié » plutôt que « le type doit
  être partagé, entre plusieurs tâches », qui s'entend faux.

- **Indice de code span inversé.** La bonne réponse est la seule option **sans**
  backticks — ou la seule avec. Équilibrer.

- **Paire d'inverses.** Deux options exactement contraires ramènent le tirage à 50 % :
  le lecteur sait que la réponse est l'une des deux. Écarté pour `private(set)`
  (lecture/écriture inversées), pour l'échange `#`/`@` entre macros freestanding et
  attached, pour « hors du thread principal » face à `@MainActor`, pour
  « début de priorité » face à « fin de priorité ».

- **Distracteurs qui s'auto-dénoncent.** « En async/await, on récupère du JSON avec : »
  où les trois distracteurs affichent tous un completion handler, un `Publisher` ou un
  appel synchrone : la bonne réponse est la seule avec `await`. Mettre au moins un
  distracteur **async mais inadapté** (ici `URLSession.shared.bytes(from:)`).

- **Référence de lettre.** Nulle part, ni dans les options ni dans l'explication. Les
  options sont mélangées à l'exécution.

---

## 3. Contrôles avant écriture

```bash
python3 Tools/audit.py            # défaut : Valido/Resources/questions.json
```

Le script couvre :

- identifiants uniques et non vides ;
- `subject` dans `{code, swift}`, `difficulty` dans `{facile, moyen, costaud}` ;
- exactement 4 options d'`id` `A`–`D`, textes distincts deux à deux ;
- `correctID` présent parmi les `options` ;
- `explanation` non vide, ≥ 40 caractères, ne commençant pas par `^[A-D]\s*[—–\-.)]`,
  ne finissant pas par `[A-D] :` ;
- aucun résidu markdown (`**`, `](`) ;
- aucune méta-option (`toutes les`, `aucune`, `ci-dessus`) ;
- aucune clé hors schéma `Question` ;
- **équilibre de longueur** : la bonne option ne dépasse pas de plus de 10 caractères la
  deuxième plus longue ;
- **écart de registre** : la bonne option ne dépasse pas de plus de 20 caractères la
  *moyenne* des trois distracteurs. C'est ce contrôle-là, et non le précédent, qui
  attrape les distracteurs d'un mot ;
- **marqueur de détail cumulé** : aucune question où la bonne option est à la fois la
  seule ponctuée et la plus longue ;
- **fuite de mot d'énoncé** au seuil de 4 caractères ;
- **référence de lettre** dans les options *et* l'explication ;
- **explication qui paraphrase** : signalée quand tous ses mots pleins sont déjà dans la
  bonne option ;
- sur une question illustrée : `illustration` réduite à `asset` et `alt`, imageset
  **présent sur le disque**, asset **recensé dans `images.md`**, `alt` d'au moins 40
  caractères, et **énoncé qui redit la scène**.

Trois sorties demandent un **tri à la main**, elles produisent des faux positifs :

- `lettre/reference` — les majuscules accentuées sont exclues par le motif, mais une
  lettre **ancrée par l'énoncé** reste signalée et est légitime : « Le « D » de SOLID »,
  « Le disque « A » ».
- `forme/markdown` — `` `/** */` `` dans la question DocC est dans un code span.
  `QuestionCardView.styled()` parse en `.inlineOnlyPreservingWhitespace`, donc les
  astérisques s'affichent littéralement.
- `image/enonce-redit-la-scene` — trois mots pleins communs entre `prompt` et `alt`. Un
  « carrefour » des deux côtés est parfois inévitable ; un énoncé qui décrit la scène,
  jamais.

Le reste doit être à zéro. `longueur/plus-longue` (bonne réponse plus longue de 1 à 10
caractères) est informatif : le seuil dur est `longueur/plus-10`.

---

## 4. Vérifier

Projet Xcode à plat, pas de paquet SwiftPM : `xcodebuild`, pas `swift test`.

```bash
cd /Users/guillaume/Developer/Swift/Valido && \
  DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
    -project Valido.xcodeproj -scheme Valido \
    -destination 'platform=iOS Simulator,name=iPhone 17'
```

Si `xcodebuild` échoue sur `Application failed preflight checks` / `Busy` sans qu'aucun
test n'ait tourné, c'est le simulateur, pas le code : plusieurs runtimes déclarent le
même nom de device et l'un d'eux reste coincé. Changer de device dans `-destination`.

`QuestionBank` valide au chargement et rejette le fichier avec un `ContentError`
**nommant l'identifiant fautif** : banque non vide, identifiants uniques, ≥ 2 options,
`correctID` présent parmi les options, explication non vide, et `illustration` dont
l'`asset` et l'`alt` ne sont ni vides ni blancs. C'est la boucle de retour à
utiliser.

`ValidoTests/BundledContentTests.swift` couvre en plus : volume total ≥ 295, les deux
matières présentes (≥ 125 `code`, ≥ 170 `swift`), aucune explication et aucune **option**
ne commençant par une lettre de réponse, options/bonne réponse cohérentes,
**l'équilibre de longueur**, et — pour les questions illustrées — que chaque asset
référencé **se résout dans le bundle compilé** et que son `alt` fait au moins 40
caractères. Le contrôle d'`audit.py` regarde le disque, celui-là regarde le produit
livré : une image posée dans le catalogue mais non compilée passerait le premier. Les seuils sont volontairement sous les 302 livrées : un
effondrement du volume doit casser, une variation de quelques questions non.

Un échec du test des lettres de réponse, ou de celui de l'équilibre de longueur, se
corrige **dans les données, jamais dans le test**.

---

## 5. Fraîcheur juridique

Tous les contrôles du §3 sont formels. **Rien ne vérifie que le contenu est juste**, et
sur les 128 questions `code` c'est le risque principal : le droit bouge, vite. L'audit
d'août 2026 a trouvé trois questions aux chiffres périmés — dont une qui l'était depuis
**trois jours** (peines pour conduite sous stupéfiants, relevées par la loi n° 2026-798
du 18 août 2026).

Sources autorisées, et elles seules : **legifrance.gouv.fr**,
**securite-routiere.gouv.fr**, **service-public.gouv.fr** (plus **ecologie.gouv.fr** et
**sante.gouv.fr** pour les ZFE et les gestes de secours).

À revérifier à chaque passe : vitesses, barème de points, seuils d'alcoolémie et peines,
période probatoire, sanctions et qualifications (contravention / délit), équipements
obligatoires, ZFE et Crit'Air, premiers secours.

Trois règles de conduite :

1. **Citer la source et sa date** pour chaque correction. Une page service-public porte
   un « Vérifié le … », un article Legifrance une version en vigueur : les relever.
2. **Signaler au lieu de corriger** en cas de doute. Un chiffre incertain dans la banque
   est moins grave qu'un chiffre faux présenté comme sûr.
3. **Recycler l'ancienne valeur en distracteur.** « 4 500 € et 2 ans de prison » était
   la bonne réponse jusqu'en août 2026 ; c'est maintenant le meilleur distracteur de la
   question, parce que c'est exactement ce qu'un candidat aura lu ailleurs.

Le relevé des sources déjà consultées, et la liste des points laissés ouverts, sont dans
[`audit-2026-08.md`](audit-2026-08.md).

---

## 6. Provenance

Les 250 premières questions venaient de deux bases Notion — `QCM Code` (100, déjà
rédigées en QCM) et `Quiz Swift` (150, des flashcards converties à la main). Cette
origine n'a plus d'effet sur le travail courant, mais elle explique deux choses dans le
fichier :

- les `id` de ces 250 questions sont des **UUID de page Notion sans tirets** ;
- `sourceURL` pointe la page d'origine sur les 150 `swift`, et est absent sur les 100
  `code`, dont la base n'avait pas cette propriété.

Les 52 questions ajoutées en août 2026 se reconnaissent à un `id` en SHA-256 de l'énoncé
préfixé `valido-v2:`, et à l'absence de `sourceURL`. **Notion n'est plus la source** : ni
mise à jour, ni ré-import. Le JSON fait foi.

---

## 7. Les questions illustrées

Une question illustrée n'est pas une question décorée : **l'image porte l'énoncé**. « Qui
passe en premier ? » n'a aucun sens sans le carrefour. Si la question se tient sans
l'image, l'image n'a rien à faire là.

```json
"illustration": {
  "asset": "carrefour-priorite-droite",
  "alt": "Croisement à quatre branches, sans panneau ni marquage au sol ; vous montez tout droit et un véhicule arrive de votre droite pour traverser."
}
```

- `asset` — nom d'un imageset de `Valido/Assets.xcassets/Scenes/`. Rien d'autre :
  l'image est locale, l'app n'ouvre aucune connexion.
- `alt` — **l'énoncé, pour qui n'accède pas à l'image.** Ce n'est pas du confort : sans
  lui la question est injouable au lecteur d'écran, parce que l'énoncé y est
  littéralement absent. Même seuil que `explanation` : 40 caractères au moins.
- Sur une question sans image : **clé absente**, pas `null` — comme `sourceURL`.

D'où viennent les images, et sous quelles conditions : [`images.md`](images.md). Les
schémas se régénèrent avec `swift Tools/render-scenes.swift`, jamais à la main.

### L'énoncé ne redit pas la scène

Un énoncé qui décrit l'image la rend décorative. « Cette ligne jaune continue le long de
la bordure du trottoir interdit : » se répond sans regarder — l'énoncé a déjà tout dit. Le
bon énoncé est « Ce marquage interdit : », et c'est l'image qui dit lequel.
`audit.py` signale trois mots pleins communs entre `prompt` et `alt` ; la sortie demande
un tri à la main, « carrefour » des deux côtés étant parfois inévitable.

### Le budget de hauteur, qui est la vraie contrainte

Le bandeau réclame jusqu'à 38 % de la carte avant réponse, 18 % après. Il **cède** quand
le texte n'a plus la place — aucun texte de la carte n'est compressible, donc l'image est
le seul élément qui puisse reculer. Conséquence pratique : sur une carte chargée le
bandeau tombe sous les 18 %, et il ne reste qu'une bande de la scène.

Pour que l'image garde une taille utile, une question illustrée se tient court :

- énoncé sur **deux lignes** au plus (≈ 60 caractères) ;
- options de **50 caractères** au plus, comme le reste de la banque ;
- explication autour de **200 caractères** — c'est elle qui mange le plus après le verdict.

Mesuré sur les huit premières : à 220 caractères d'explication et un énoncé de trois
lignes, le bandeau descend à 8 %.

### La couleur ne porte jamais l'information

Les schémas donnent au véhicule du candidat un liseré blanc, pas seulement une teinte, et
les options désignent les véhicules **par leur provenance** (« venant de votre droite »),
jamais par leur couleur. Un daltonien doit pouvoir répondre.

### Le cadrage

Les scènes sont dessinées en 4:3, la géométrie décisive au centre vertical : c'est la
bande qui survit au recadrage en `.fill` quand le bandeau rétrécit. Une photo se recadre
en 4:3 selon la même règle, à la main — le choix de ce qui doit survivre est un jugement.
