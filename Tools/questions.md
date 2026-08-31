# Rédiger et maintenir `questions.json`

`Valido/Resources/questions.json` **est** la source. Il n'y a plus de génération : on
édite le fichier, on repasse les contrôles, on lance les tests.

Format : tableau JSON d'objets `Question` (`Valido/Model/Question.swift`), indenté,
clés triées, UTF-8.

```python
json.dump(questions, f, ensure_ascii=False, indent=2, sort_keys=True)
```

État courant : **448 questions** — 255 `code`, 193 `swift`. **Quarante-neuf** portent une
image (voir le [§7](#7-les-questions-illustrées)). La couverture du référentiel ETG, thématique
par thématique, est dans [`couverture.md`](couverture.md) ; la fraîcheur de chaque question
`code`, dans [`sources.md`](sources.md).

## Les champs

- `id` — chaîne non vide, unique. Pour une question nouvelle :
  `hashlib.sha256(('valido-v2:' + prompt).encode()).hexdigest()[:32]`.
- `subject` — `code` ou `swift`.
- `topic` — un thème existant, tel quel (y compris `Outillage & diagnostics`). En créer
  un nouveau se paie en dilution : **treize** thèmes `code`, treize sections `swift`.
  Côté `code` il se paie en plus au contrôle : `audit.py` refuse un `topic` absent de la
  colonne du milieu de [`couverture.md`](couverture.md), donc un thème neuf s'y rattache
  d'abord à une thématique du référentiel ETG.
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
- `sourceURL` — **trois régimes**, et c'est voulu. Sur les 193 `swift` : **149** portent
  l'URL `notion.so` de leur page d'origine, **20** l'URL de la page `developer.apple.com`
  contre laquelle elles ont été écrites, **24** n'ont pas la clé. Sur les 255 `code` :
  jamais — leur fraîcheur est tenue par [`sources.md`](sources.md), qui est un registre
  bien plus fort qu'une URL. **Règle pour la suite : une question `swift` neuve porte
  l'URL de sa documentation**, qui est la seule piste de fraîcheur de ce demi-fichier.
  Quand il n'y en a pas : **clé absente**, pas `null`.
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

Repère chiffré, recompté sur les 448 (2026-08-29) : bonne option **43,1** caractères en
moyenne contre **42,4** pour les distracteurs. Par matière : **50,9 / 49,3** sur les
`swift` (écart **+1,6**), **37,2 / 37,2** sur les `code` (écart **+0,0**).

Sur les `code`, cet écart valait **+0,5** avant la troisième passe de contenu ; la
réécriture des options l'a ramené à zéro, et la bonne réponse dépasse la moyenne de ses
distracteurs sur **121 cartes sur 255** — un poil sous la moitié, c'est-à-dire le partage
qu'on obtiendrait si la longueur ne disait plus rien de la réponse. C'est une mesure, pas
un acquis : le seuil de recevabilité reste **+10 sur la carte** (`longueur/plus-10`), la
moyenne n'en a jamais été un, et un `+0,0` d'ensemble n'interdit pas qu'une carte isolée
porte encore l'indice. Le `swift`, dont la passe n'a touché aucune carte, est resté à
**+1,6** à l'identique : c'est ce qui rattache le mouvement des `code` à la réécriture
plutôt qu'à la mesure.

L'écart entre les deux matières est structurel, pas un défaut : une option `swift`
nomme une API et son comportement, une option `code` porte une valeur ou une règle.
Ce n'est **pas** l'illustration qui l'explique — mesurées à part, les 49 `code`
illustrées sont à **41,3** caractères par option, les 206 autres à **36,2**. Les
illustrées sont donc les plus longues des `code`, à neuf caractères du plafond de 50
que leur impose le [§7](#7-les-questions-illustrées) : c'est là que le budget mord.

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

Pour **lire** une carte à côté de la ligne de `sources.md` qui la couvre — ce qu'`audit.py`
ne fait pas, il vérifie seulement que la ligne existe :

    python3 Tools/relire.py "Vitesse"            # les cartes du domaine + leur ligne de registre
    python3 Tools/relire.py --fuites "Vitesse"   # explications qui recouvrent la réponse d'une autre carte

Lecture seule, sort toujours 0. Le second mode couvre l'angle mort n° 2 du §7 de
[`audit-2026-08-passe-2.md`](audit-2026-08-passe-2.md) — la fuite d'une carte vers une
autre — au seuil de trois mots pleins : en dessous, le recouvrement est du vocabulaire
commun et noie le signal.

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
  caractères, et **énoncé qui redit la scène** ;
- **budget de hauteur** d'une question illustrée (`image/enonce-trop-long`,
  `image/option-trop-longue`, `image/expl-trop-longue`) : 70 / 50 / 220 caractères. Les
  mêmes seuils sont verrouillés sur le livré par un test — voir le [§7](#7-les-questions-illustrées) ;
- **registre de fraîcheur** (`source/*`) : toute question `code` a une ligne dans
  [`sources.md`](sources.md) (`source/absente`), avec une `affirmation` renseignée ; une
  ligne `datée` porte une URL d'un domaine de la liste blanche (`source/hors-liste-blanche`)
  et une date de relevé lisible (`source/date-illisible`) de moins de douze mois
  (`source/releve-perime`) ; une ligne `stable` ne porte ni l'une ni l'autre
  (`source/stable-avec-source`). Une ligne sans question est signalée en fin de rapport
  (`source/ligne-orpheline`) ;
- **carte de couverture** (`couverture/topic-non-rattache`) : tout `topic` `code` figure
  dans la colonne du milieu de [`couverture.md`](couverture.md).

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

**La ligne de base, au 2026-08-29 sur 448 questions.** On se compare à elle, pas à zéro :

```
lettre/reference            1     faux positif connu (lettre ancrée par l'énoncé)
forme/markdown              1     faux positif connu (`/** */` dans un code span)
forme/seule-ponctuee       14     informatif, jamais cumulé avec la longueur
longueur/plus-longue       76     informatif (+1 à +10) — 13 `code`, 63 `swift`
expl/paraphrase-litterale  20     à relire à l'œil, une par une — 12 `code`, 8 `swift`
```

Relevée en fin de passe 3, qui a relu les 255 questions `code` et en a modifié 175. Deux
chiffres ont bougé, et **ni l'un ni l'autre ne se lit sans son explication** :

- `longueur/plus-longue` **97 → 76**, tout le mouvement côté `code` (34 → 13). Il vient de
  l'élargissement des distracteurs, pas du raccourcissement des bonnes réponses : l'écart
  moyen `code` passe de +0,5 à +0,0 caractère. Les 63 `swift` n'ont pas bougé, la passe ne
  les ayant pas touchés.
- `expl/paraphrase-litterale` **18 → 20**, dont `code` 10 → 12. La spec de la passe attendait
  une **baisse** ; il a monté, et c'est le résultat voulu. Le critère pédagogique 3 exige
  qu'une explication énonce **la règle**, sa raison et sa limite ; ce compteur mesure
  l'objectif inverse — ne pas redire la bonne réponse. Sur une carte dont la règle *est* un
  chiffre, l'option correcte *est* ce chiffre, et les deux s'opposent frontalement. La passe
  a tranché pour la pédagogie : trois cartes de secourisme et de passage à niveau ont gagné
  le chiffre qui leur manquait et sont entrées dans la liste, une en est sortie sans qu'aucune
  fuite ne se ferme (l'explication écrit « quatre » là où l'option dit « 4 », et le test de
  sous-chaîne d'`audit.py:194` ne la voit plus).

**Conséquence, à ne pas oublier : `expl/paraphrase-litterale` n'est pas un compteur à
minimiser.** C'est une liste à relire une par une, où trois classes cohabitent — le vrai
défaut (l'explication ne fait que renommer la réponse), le faux positif structurel (la réponse
est un chiffre, il revient, et l'explication ajoute une raison et une limite, autorisé au §1
ci-dessus) et la collision de sous-chaîne (« 35 € » trouvé dans « 135 € »). Une passe qui le
prendrait pour un objectif chiffré **dégraderait le contenu** : la passe 3 en a fait la
démonstration en réécrivant deux explications « pour ne pas le faire remonter », au prix d'une
carte de la cadence de massage cardiaque qui n'énonçait plus la cadence. Les deux ont été
refaites, et le compteur laissé monter.

Vides, et qui doivent le rester : `schema/`, `couverture/`, `source/`, `fuite/`, `image/`,
`longueur/plus-10`, `forme/backtick-isole`. **Attention à ce dernier** : il ne signale que
la bonne réponse **seule** de son côté du backtick (`audit.py:177`) — qu'elle soit la seule à
en porter un ou la seule à n'en pas porter. Un lot de questions sans aucun code span le laisse
donc à zéro sans qu'il ait rien contrôlé, et ailleurs **un seul distracteur qui partage le
statut de la bonne réponse** suffit à le désarmer.

Ce que le script **ne voit pas**, et qu'il faut donc regarder soi-même, est recensé à deux
endroits. Au §7 de [`audit-2026-08-passe-2.md`](audit-2026-08-passe-2.md) d'abord — neuf
angles morts mesurés, dont la fuite d'une carte vers **une autre** carte et l'équilibre de
longueur dans le sens inverse ; **de ces neuf-là**, huit sont ouverts et le neuvième (le
registre d'images lu trop largement) est corrigé. Puis, mesurés sur les 255 `code`, aux
**douze** angles morts de la section « Ce que l'outillage ne voit toujours pas » de
[`audit-2026-08-passe-3.md`](audit-2026-08-passe-3.md), chacun avec le défaut réel qu'il a
laissé passer. Neuf des douze portent une ligne d'outil ; les trois autres n'en ont pas et
ne peuvent pas en avoir — « règle trop large », la récurrence d'une forme de distracteur sur
le lot, et le fait qu'aucun contrôle ne lise une citation de registre jusqu'au bout sont
précisément les défauts qu'**aucune sortie ne mesure**. Un douzième cas est plus retors
encore : `forme/backtick-isole` a bien une ligne (`audit.py:175-177`) et n'a mordu nulle
part, parce que sur un lot sans code span il ne contrôle rien.

---

## 4. Vérifier

Projet Xcode à plat, pas de paquet SwiftPM : `xcodebuild`, pas `swift test`.

```bash
cd /Users/guillaume/Developer/Swift/Valido && \
  DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test \
    -project Valido.xcodeproj -scheme Valido \
    -destination 'platform=iOS Simulator,name=iPhone 17 Pro'
```

Si `xcodebuild` échoue sur `Application failed preflight checks` / `Busy` sans qu'aucun
test n'ait tourné, c'est le simulateur, pas le code : plusieurs runtimes déclarent le
même nom de device et l'un d'eux reste coincé. Changer de device dans `-destination`.

`QuestionBank` valide au chargement et rejette le fichier avec un `ContentError`
**nommant l'identifiant fautif** : banque non vide, identifiants uniques, ≥ 2 options,
`correctID` présent parmi les options, explication non vide, et `illustration` dont
l'`asset` et l'`alt` ne sont ni vides ni blancs. C'est la boucle de retour à
utiliser.

`ValidoTests/BundledContentTests.swift` couvre en plus : volume total **≥ 425**, les deux
matières présentes (**≥ 242** `code`, **≥ 183** `swift`), aucune explication et aucune
**option** ne commençant par une lettre de réponse, options/bonne réponse cohérentes,
**l'équilibre de longueur**, et — pour les questions illustrées — que chaque asset
référencé **se résout dans le bundle compilé**, que son `alt` fait au moins 40 caractères,
que le **budget de hauteur** du [§7](#7-les-questions-illustrées) est tenu
(`leBudgetDeHauteurDesQuestionsIllustréesEstTenu`, 70 / 50 / 220 caractères) et qu'il
**reste** des questions illustrées (`laBanqueGardeSonVolumeIllustré`, **≥ 44**). Ces deux
derniers ont été ajoutés par la passe d'août 2026 : les trois tests d'image plus anciens
vérifient chacun ce qu'une illustration doit respecter, aucun ne vérifiait qu'il en reste
une seule.

Le contrôle d'`audit.py` regarde le disque, celui du bundle regarde le produit livré : une
image posée dans le catalogue mais non compilée passerait le premier. Les seuils de volume
sont à **95 %** des 448 livrées (90 % pour les illustrées) : un effondrement doit casser,
une variation de quelques questions non.

Un échec du test des lettres de réponse, ou de celui de l'équilibre de longueur, se
corrige **dans les données, jamais dans le test**.

---

## 5. Fraîcheur juridique

Tous les contrôles du §3 sont formels. **Rien ne vérifie que le contenu est juste**, et
sur les 255 questions `code` c'est le risque principal : le droit bouge, vite. L'audit
d'août 2026 a trouvé trois questions aux chiffres périmés — dont une qui l'était depuis
**trois jours** (peines pour conduite sous stupéfiants, relevées par la loi n° 2026-798
du 18 août 2026).

Sources autorisées, et elles seules : **legifrance.gouv.fr**,
**securite-routiere.gouv.fr**, **service-public.gouv.fr**, **ecologie.gouv.fr** et
**sante.gouv.fr** (ZFE, gestes de secours), plus **unece.org**, **eur-lex.europa.eu**,
**cprguidelines.eu**, **erc.edu**, **croix-rouge.fr** et **inrs.fr**. La liste exacte et son
détail par rang vivent dans [`sources.md`](sources.md) et dans le tuple `DOMAINES`
d'`audit.py`, **à tenir synchronisés**.

**Pourquoi elle a été élargie au-delà des domaines gouvernementaux.** Six domaines s'ajoutent
aux cinq `.gouv.fr`, et chacun pour **un champ** où il fait autorité et où l'État français
n'écrit pas de chiffre — jamais pour compléter du droit routier :

- **`erc.edu`** et **`croix-rouge.fr`** — les gestes de secours. Aucun `.gouv.fr` ne chiffre
  la cadence des compressions thoraciques ni la profondeur d'un massage : `sante.gouv.fr`
  renvoie à l'enseignement, pas à un barème. **`cprguidelines.eu`** est resté dans le tuple
  mais **ne sert plus aucun contenu** : c'était une transcription erronée du nom « ERC
  Guidelines » en nom de domaine, et l'ERC est `erc.edu`.
- **`unece.org`** et **`eur-lex.europa.eu`** — les normes techniques et le droit européen,
  qui sont en amont du droit français sans y être écrits.
- **`inrs.fr`** — le métabolisme de l'alcool (verre standard, vitesse d'élimination), qui
  est de la santé au travail et non du droit routier.

**Ce qui n'y est pas, et qui pourrait surprendre** : les planches de l'Instruction
interministérielle sur la signalisation routière. Elles ne sont lisibles que chez le Cerema,
qui **n'entre pas** dans cette liste — la version qui fait foi est l'arrêté sur Legifrance.
L'IISR sert de référence de **dessin** ([§7](#7-les-questions-illustrées)), jamais d'autorité
sur un chiffre, et n'apparaît donc jamais en colonne `source` d'une ligne `datée`.

**Trois rangs, et ils ne sont pas interchangeables.** `legifrance.gouv.fr` (« Version en
vigueur depuis le … ») et `service-public.gouv.fr` (« Vérifié le … ») sont les **seules
autorités pour affirmer une valeur**. `securite-routiere.gouv.fr` corrobore et explique,
**jamais seul sur un chiffre** : il servait encore en août 2026 le droit d'avant le
29 décembre 2025 sur le grand excès de vitesse, et il ne date aucune de ses pages. Les huit
autres domaines font autorité sur leur seul champ. Une valeur dont la seule source est de
rang 2 ou 3 **se signale au lieu de s'affirmer**.

Le registre par question est [`sources.md`](sources.md) — une ligne par question `code`,
`stable` ou `datée`, avec ce contre quoi elle a été vérifiée et quand. La carte de ce que
la banque couvre du référentiel est [`couverture.md`](couverture.md). `audit.py` refuse une
question `code` absente du premier et un `topic` absent du second.

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
[`audit-2026-08.md`](audit-2026-08.md) et dans
[`audit-2026-08-passe-2.md`](audit-2026-08-passe-2.md) — le second referme les quatre points
ouverts du premier.

---

## 6. Provenance

Les 250 premières questions venaient de deux bases Notion — `QCM Code` (100, déjà
rédigées en QCM) et `Quiz Swift` (150, des flashcards converties à la main). Cette
origine n'a plus d'effet sur le travail courant, mais elle explique deux choses dans le
fichier :

- les `id` de ces 250 questions sont des **UUID de page Notion sans tirets** ;
- `sourceURL` pointe la page d'origine sur les 150 `swift`, et est absent sur les 100
  `code`, dont la base n'avait pas cette propriété.

Les questions ajoutées depuis se reconnaissent à leur `id` :
`sha256("valido-v2:" + prompt)[:32]`. **Le préfixe est dans l'entrée du hachage, pas dans
l'identifiant** — un `id` de question neuve est trente-deux caractères hexadécimaux, comme
un `id` de Notion, et rien ne les distingue à l'œil. Ce qui les distingue est de
**recalculer le hachage** : s'il retombe sur l'`id`, la question a été créée par une passe.

Au 2026-08-29 : **199** questions créées — la troisième passe n'en ajoute aucune ; 250 →
448 est un solde de 198, et une question a été retirée en chemin, donc le compte se fait
en **créations**, pas en delta. Recompté : **249** `id` à préfixe Notion
(`37fe1af42b8d…`) + **199** `id` frappés = 448. Sur ces 199, **176** portent un `id` qui
est encore le hachage de leur énoncé courant ; ils étaient **188** avant la troisième
passe, qui a réécrit dix-huit énoncés `code` sans toucher à un seul `id`. Les
**vingt-trois** autres ont vu leur énoncé réécrit après coup sans qu'on recalcule l'`id`
— ce qui est le comportement voulu dès qu'une question a été livrée : la progression de
l'utilisateur est indexée sur l'`id` (`Valido/Model/ProgressSnapshot.swift`), donc le
changer efface un historique en silence. **Un `id` de question livrée est immuable, sans
exception.** Une question créée dans une branche jamais fusionnée peut, elle, voir son `id`
suivre son énoncé.

**Notion n'est plus la source** : ni mise à jour, ni ré-import. Le JSON fait foi.

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
schémas se régénèrent avec `./Tools/render-scenes.sh`, jamais à la main : on édite la scène
sous `Tools/Scenes/`, on relance le script.

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

Pour que l'image garde une taille utile, une question illustrée se tient court. **Ces trois
seuils ne sont plus de la prose : ils sont imposés deux fois**, par `audit.py`
(`image/enonce-trop-long`, `image/option-trop-longue`, `image/expl-trop-longue`) et par le
test `leBudgetDeHauteurDesQuestionsIllustréesEstTenu` :

| | seuil | ce qui le contrôle |
|---|---:|---|
| énoncé | **70** caractères | `audit.py` avant le build, le test sur le livré |
| chaque option | **50** caractères | idem |
| explication | **220** caractères | idem |

Mesuré sur les huit premières : à 220 caractères d'explication et un énoncé de trois
lignes, le bandeau descend à 8 %. À quarante-neuf questions illustrées, la prose ne tenait
plus — quatre des huit premières violaient déjà le budget qu'elles étaient censées décrire.

### Les panneaux : un dessin, une norme, un seul endroit

Un panneau se dessine **une fois**, dans `Tools/Scenes/Panneaux.swift`, et les scènes qui
le contiennent réutilisent la même fonction. Un B14 dans une scène de carrefour et un B14
seul sont le même dessin : sans quoi deux versions du même panneau divergent, et le
candidat apprend une forme qui n'existe qu'ici.

La géométrie ne s'invente pas. Elle se relève sur l'**Instruction interministérielle sur la
signalisation routière** (IISR), qui normalise formes, proportions et couleurs, et dont les
planches sont extractibles des PDF du Cerema — la marche à suivre et la partie/page de
chaque panneau sont dans [`images.md`](images.md). Le Cerema **n'entre pas** dans la liste
blanche du [§5](#5-fraîcheur-juridique) : c'est une référence de **dessin**, jamais
l'autorité d'un chiffre. Et on ne recopie jamais le fichier image d'un site officiel :
ce qui est public, c'est la norme, donc on redessine d'après elle.

Ce que l'IISR a déjà corrigé sur nos primitives : un panneau de danger est « entouré par une
bande rouge **bordée elle-même par un listel blanc** » (2e partie, art. 23) — nos triangles
n'avaient qu'un bord ; et ils sont « des triangles équilatéraux dont le côté inférieur est
horizontal » (art. 21), là où nos proportions avaient été choisies à l'œil.

### La couleur ne porte jamais l'information

Les schémas donnent au véhicule du candidat un liseré blanc, pas seulement une teinte, et
les options désignent les véhicules **par leur provenance** (« venant de votre droite »),
jamais par leur couleur. Un daltonien doit pouvoir répondre.

Et **la bonne intention ne suffit pas : ça se mesure.** Une scène de feux respectant la
règle en intention l'a violée en fait — la lampe allumée mesurait 96 en niveaux de gris
contre 119 pour les éteintes, polarité inversée. Avant de commiter un PNG, extraire les
valeurs de gris des zones qui portent la réponse et vérifier que l'écart va dans le bon
sens et qu'il est franc. Deux formes de panneaux qui ne se séparent que par une teinte
(le disque à couronne rouge contre le disque bleu) ne s'illustrent pas : la question reste
en texte.

### Le cadrage

Les scènes sont dessinées en 4:3, la géométrie décisive au centre vertical : c'est la
bande qui survit au recadrage en `.fill` quand le bandeau rétrécit. Une photo se recadre
en 4:3 selon la même règle, à la main — le choix de ce qui doit survivre est un jugement.
