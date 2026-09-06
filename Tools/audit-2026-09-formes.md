# Forme des questions `code` — diagnostic contre l'épreuve réelle, septembre 2026

Quatrième intervention sur le contenu, après les passes 2
([`audit-2026-08-passe-2.md`](audit-2026-08-passe-2.md)) et 3
([`audit-2026-08-passe-3.md`](audit-2026-08-passe-3.md)). **Celle-ci ne corrige aucune
carte** : elle mesure un écart et le chiffre. Aucun `id`, aucune option, aucun `prompt` de
`questions.json` n'a été touché.

Spec : [`docs/superpowers/specs/2026-09-06-formes-questions-etg-design.md`](../docs/superpowers/specs/2026-09-06-formes-questions-etg-design.md).

## 1. Le corpus

Trois strates, par autorité décroissante. L'ordre décide du poids de chaque observation et
il est rappelé à chaque constat qui s'y appuie.

### Strate 1 — le spécimen officiel

`reponsesquestionspermisauto_v1604.pdf` (securite-routiere.gouv.fr), lu intégralement le
2026-09-06. Le fichier compte **24 questions numérotées de 1 à 24, sur 6 pages** — pas une
de plus ; la lecture des six pages ne laisse aucun reste.

**Ce que le PDF montre, et ce qu'il ne montre pas.** Chaque question porte quatre champs
fixes : le numéro, la ligne « Bonne(s) réponse(s) : » suivie d'une ou deux lettres parmi
A–D, un paragraphe qui reconstruit la situation et la réponse correcte, l'étiquette de
thème (petites capitales), puis un commentaire pédagogique en italique. **Le PDF ne
reproduit ni l'énoncé exact posé au candidat, ni le texte des propositions A à D, ni aucune
image ou vidéo de situation de conduite** — le fichier ne porte, en tout et pour tout,
qu'un seul objet image (`21 0 obj`, `/Subtype/Image`, `/Filter/DCTDecode`, 1280 × 509
pixels, 129 351 octets) : le bandeau institutionnel « SÉCURITÉ ROUTIÈRE / VIVRE, ENSEMBLE »
de la page de garde, pas une scène d'examen. Vérifié en comptant les occurrences sur le
fichier brut (`grep -c '/Subtype/Image'` et `grep -c DCTDecode` : 1 chacune) — `file` ne
répond que « PDF document, version 1.3, 6 pages » et ne peut de toute façon pas voir les
objets internes d'un PDF ; l'affirmer autrement était une erreur de la première version de
ce rapport. Deux conséquences pour le tableau ci-dessous :

- La colonne « Personne » mesure le paragraphe de réponse, pas l'énoncé littéral — c'est le
  seul texte disponible qui rejoue la situation, mais ce n'est pas la question telle qu'elle
  est lue par le candidat.
- La colonne « Support visuel nommé » ne peut pas constater une image absente du fichier ;
  elle teste un seul critère reproductible — le commentaire pédagogique nomme-t-il
  explicitement un support visuel ? Un critère à trois voies, avec une catégorie
  intermédiaire « scène suggérée », a été essayé puis abandonné : la frontière n'était pas
  reproductible — Q1 décrit un empiétement sur l'accotement, Q7 suppose un contrôle de
  police, sans que l'un ou l'autre nomme un support, et rien ne garantit qu'un autre lecteur
  les classerait pareil. Seule la mention explicite tient : trois questions (4, 13, 19)
  nomment le support — « le visuel met le candidat en situation réelle de conduite » (Q4,
  Q19), « ici le format vidéo permet de bien évaluer la différence de vitesse » (Q13) — les
  21 autres ne le font pas, ce qui ne dit rien sur si elles sont illustrées ou non.

**Nombre de propositions.** Seules les lettres A, B, C, D apparaissent dans les 24 lignes
« Bonne(s) réponse(s) », jamais E ni au-delà : quatre propositions par question,
**déduites**, jamais observées directement (le PDF ne montre pas les propositions).

| N° | Support visuel nommé | Personne (§ réponse) | Bonne(s) réponse(s) | Thème (étiquette du PDF) |
|---:|---|---|---|---|
| 1 | non | impersonnel | B | Capacité de perception et d'évaluation |
| 2 | non | 1ère personne | C | Conscience des risques liés aux usagers vulnérables |
| 3 | non | 1ère personne | A, C | Conscience des risques liés à la conduite de nuit |
| 4 | oui (« le visuel ») | 1ère personne | A | Connaissance de la réglementation |
| 5 | non | 1ère personne | A, C | Capacite de perception et d'évaluation *(sic, sans accent dans le PDF)* |
| 6 | non | 1ère personne | A | Le développement des véhicules a boite automatique |
| 7 | non | 1ère personne | A, C | Sensibilisation aux conséquences des infractions au code de la route |
| 8 | non | 1ère personne | B, C | Capacité de perception et d'évaluation |
| 9 | non | 1ère personne | B | Connaissance des risques liés aux usagers vulnérables *(« Connaissance », vs « Conscience » en Q2)* |
| 10 | non | 1ère personne | A, C | Gestes de premier secours |
| 11 | non | 1ère personne | B, C | Conscience des risques liés aux usagers vulnérables |
| 12 | non | 1ère personne | A, C | Nouvelles technologies |
| 13 | oui (« format vidéo ») | 1ère personne | B, D | Capacité de perception, d'évaluation et de décision |
| 14 | non | impersonnel | B | Conscience des risques liés a la conduite de nuit *(sic, sans accent)* |
| 15 | non | 1ère personne | A, C | Capacité de perception, d'évaluation et de décision |
| 16 | non | 1ère personne | B | Conscience des risques en franchissant les intersections |
| 17 | non | 1ère personne | A, D | Conduite écologique et respectueuse de l'environnement |
| 18 | non | 1ère personne | A | Capacité de perception et d'évaluation |
| 19 | oui (« le visuel ») | 1ère personne | A, C | Connaissance de la règlementation *(sic, vs « réglementation » en Q4)* |
| 20 | non | impersonnel | A, C | Conscience des risques liés à la vitesse |
| 21 | non | 1ère personne | B | Connaissance de la règle et prise en compte des usagers vulnérables |
| 22 | non | 1ère personne | A, C | Connaître les principaux organes du véhicule |
| 23 | non | 1ère personne | A, C | Connaître les principaux équipements du véhicule |
| 24 | non | 1ère personne | A | Nouvelles technologies / équipements de sécurité |

Trois totaux, reproductibles par relecture directe du tableau : 21/24 paragraphes de réponse
portent un marqueur de première personne (je/j'/mon/ma/mes/m'), 14/24 portent deux bonnes
réponses plutôt qu'une, et 3/24 nomment explicitement un support visuel.

**Un deuxième registre, presque toujours impersonnel.** Le commentaire pédagogique en
italique (« Le conducteur doit être capable de… ») est impersonnel sur 23 des 24 questions
— jamais à la première personne, jamais adressé au candidat — sauf Q13, qui glisse sur « le
poids lourd et le véhicule qui **nous** dépasse » (seule occurrence de nous/notre/nos sur
les 24 blocs). Une exception sur 24 ne casse pas l'observation, mais elle est écrite ici
plutôt que lissée. C'est par ailleurs un genre distinct du paragraphe de réponse : une note
à l'intention de qui conçoit ou administre l'épreuve, pas une reformulation de l'énoncé. Un
compteur qui confondrait les deux paragraphes mesurerait deux choses différentes sous un
seul chiffre.

### Strate 2 — le texte de l'épreuve

Trois textes Légifrance, lus par `WebFetch` le 2026-09-06 (un `curl` direct sur
legifrance.gouv.fr renvoie un défi Cloudflare — « Just a moment… », JavaScript requis —
vérifié séparément ; la lecture ci-dessous vient donc de l'outil de fetch, pas d'un accès
brut).

- **Arrêté du 29 avril 2024 portant cahier des charges pour l'organisation des épreuves
  théoriques du permis de conduire** ([`JORFTEXT000049502288`](https://www.legifrance.gouv.fr/jorf/id/JORFTEXT000049502288)),
  publié au JO du 4 mai 2024, **en vigueur**. Annexe VI (spécifications WS-ETG) : « un
  tirage aléatoire de 40 diapositives est proposé au lancement de l'examen » ; durée
  maximale de l'épreuve 45 minutes, sans temps de réponse par question spécifié ; « le
  candidat répond par une combinaison de 0 à 4 lettres parmi A, B, C et D » — le format
  légal autorise explicitement de 0 à 4 bonnes réponses par question, jamais fixé à une
  seule. Annexe V, point [M-29] : le résultat communique « les thèmes pédagogiques
  correspondant aux erreurs réalisées », sans lister ces thèmes dans le texte lu. Son
  article 13 abroge l'arrêté du 27 avril 2016. Ses annexes I à IX sont en **texte lisible**
  directement dans le document Légifrance. Elle spécifie une taille et une résolution
  d'écran pour le poste candidat (annexe V, [M-1]/[M-2] : 9 pouces, 1 024 × 768 pixels) mais
  **ne décrit nulle part la nature d'une diapositive** — ni photo, ni image, ni vidéo n'y
  est mentionnée.
- **Arrêté du 20 avril 2012 fixant les conditions d'établissement, de délivrance et de
  validité du permis de conduire** ([`JORFTEXT000025803494`](https://www.legifrance.gouv.fr/loda/id/JORFTEXT000025803494)),
  article 2-I-B, version en vigueur depuis le 4 décembre 2022 : « L'épreuve théorique
  générale … est déclarée réussie lorsque le candidat obtient un nombre de réponses justes
  supérieur ou égal à 35 sur un total de quarante questions. »
- **Arrêté du 27 avril 2016** ([`JORFTEXT000032471964`](https://www.legifrance.gouv.fr/loda/id/JORFTEXT000032471964)),
  **abrogé depuis le 5 mai 2024**. Son annexe 2 (« Règlement de l'examen théorique
  général ») n'existe que sous forme d'image scannée du fac-similé du JO — confirmé de
  nouveau, illisible en texte, comme déjà consigné dans `couverture.md` lors de la passe 2 ;
  ce constat n'a pas changé avec son abrogation.

Ce que ces trois textes bornent : 40 questions par épreuve, 35 correctes requises pour
réussir, 45 minutes au total sans minuterie par question codifiée, et un format de réponse
à cases multiples (0 à 4 lettres) — jamais une réponse unique imposée par le droit.

### Strate 3 — les éditeurs, en accès libre

Les quatre domaines de `DOMAINES_FORME`, tentés un par un le 2026-09-06, sur leur page de
test gratuit la plus directe trouvée par recherche (aucune des quatre n'a de page
« questions les plus ratées » distincte de sa page de test) :

- **ornikar.com** — [`/code/gratuit/serie-1`](https://www.ornikar.com/code/gratuit/serie-1).
  **Refusé : rendu JavaScript vide.** Un `curl` direct sur le HTML statique le confirme —
  le corps ne contient que la coquille marketing et trois occurrences de « No items
  found. » ; les quatre boutons de test (facile/intermédiaire/difficile/niveau examen) sont
  vides sans exécution du script.
- **envoituresimone.com** — [`/code-de-la-route/quiz`](https://www.envoituresimone.com/code-de-la-route/quiz).
  **Refusé : mur de connexion.** Le HTML statique ne porte qu'un texte de présentation et
  la liste des dix thèmes ; le seul point d'entrée vers le quiz est un lien « Se connecter ».
  Aucune question, aucun chiffre de minuterie n'est présent dans ce fichier — une durée de
  « 20 secondes par question » était apparue dans un résumé de recherche préalable, mais
  elle ne figure pas dans le HTML de cette page une fois lu directement ; elle n'est donc
  **pas** retenue ici.
- **codeclic.com** — [`/gratuit.php`](https://www.codeclic.com/gratuit.php). **Partiellement
  lu : métadonnées oui, questions non.** Le HTML statique liste les six séries gratuites
  (thème dominant, nombre de questions, difficulté, date de mise à jour) et un paragraphe de
  présentation, mais le contenu des questions est derrière un bouton « LANCER LE TEST » sans
  URL directe dans le code source — refusé au niveau de l'interaction, pas de la page
  elle-même. Ce même paragraphe annonce « 40 questions de code de la route en 30 minutes » —
  quinze minutes de moins que les 45 minutes de l'arrêté (OBS-8) — exactement le type
  d'écart que `sources.md` interdit à un chiffre d'éditeur seul de porter sans corroboration.
- **digischool.fr** — [`/auto/code-gratuit`](https://www.digischool.fr/auto/code-gratuit).
  **Refusé : rendu JavaScript vide.** Le HTML statique ne porte que le titre de la page ;
  aucun autre texte.
- **forum.codeclic.com** — deux fils lus sans connexion : [`/questions-pieges-code-t4453.html`](https://forum.codeclic.com/questions-pieges-code-t4453.html)
  (2 messages visibles, premier message daté du **13 novembre 2012**) et
  [`/questions-posees-lors-examen-code-route-t5541.html`](https://forum.codeclic.com/questions-posees-lors-examen-code-route-t5541.html)
  (4 messages visibles, premier message daté du **29 septembre 2014**, dont un candidat qui
  reconstitue de mémoire une quarantaine de questions de son propre passage). **Les deux
  fils sont antérieurs à la nouvelle banque de questions entrée en vigueur le 2 mai 2016** —
  ce qu'ils décrivent est la forme de l'ancienne banque, pas de l'actuelle (détail dans
  OBS-14, OBS-15, et « Ce que ce corpus ne peut pas dire »). Ce sont par ailleurs des
  contributions de candidats relayées par un éditeur, pas une question officielle ni même la
  production de l'éditeur — un souvenir non vérifiable, à ce titre traité comme le niveau
  d'autorité le plus bas du corpus.

**Bilan de la strate : 4 domaines tentés, 0 laissant voir une question réelle sans compte.**
Deux se rendent vides côté client (ornikar, digischool), un est un mur de connexion explicite
(envoituresimone), un donne des métadonnées de série sans le contenu (codeclic) ; les deux
seuls fragments utilisables viennent d'un forum attaché à l'un de ces éditeurs, pas de
l'éditeur lui-même. Les quatre domaines restent dans `DOMAINES_FORME` d'`audit.py` — la
règle de corroboration qu'ils y servent est saine, et la porte doit rester ouverte pour une
passe qui aurait accès à leur contenu réel — mais il faut le dire sans détour : **aucun des
quatre n'a livré quoi que ce soit à cette passe-ci.**

### Ce que ce corpus ne peut pas dire

La banque officielle n'est pas publique. Un éditeur produit sa propre imitation : la
strate 3 mesure « ce que le marché croit être une vraie question », et ce qu'un éditeur
publie en accès libre est de surcroît ce qu'il a choisi de montrer. Aucun constat du présent
rapport ne s'appuie sur la strate 3 seule sans le dire.

**La strate 3 est revenue quasi vide, et c'est un résultat, pas un accident de recherche.**
Sur les quatre éditeurs de `DOMAINES_FORME`, aucun n'a laissé lire une seule question réelle
sans compte le 2026-09-06 ; ce que la grille de la tâche suivante retiendra de cette strate
tient sur des métadonnées de page (codeclic : nombre de questions, seuil) et sur deux fils
de forum décrivant des structures de piège ou un récit de mémoire, tous deux antérieurs à la
réforme du 2 mai 2016 (voir plus bas). Ce que la grille perd : aucune mesure directe de
longueur de propositions, de fréquence de piège par thème, ni de vocabulaire de distracteur
chez un éditeur — la strate 3 ne peut corroborer que ce que la strate 2 borne déjà en
chiffre (40 questions, seuil 35/40), pas apporter une observation qui lui soit propre au
niveau de la phrase. **Le « support photo/vidéo » que codeclic annonce (OBS-13) n'est
corroboré par aucun texte de loi** : l'arrêté du 29 avril 2024 fixe une taille et une
résolution d'écran (annexe V, [M-1]/[M-2] : 9 pouces, 1 024 × 768) mais ne décrit nulle part
la nature d'une diapositive — ni photo, ni image, ni vidéo. C'est un constat de strate 3
seule, non corroboré, aussi faible qu'OBS-5 (3/24) pour toute l'hypothèse d'ancrage de la
spec. La strate 1, minuscule (24 questions) mais seule non approximative, porte donc
l'essentiel du poids sur le registre.

**Le piège n'a aucun appui postérieur à la réforme.** Les deux fils de forum d'où viennent
OBS-14 et OBS-15 datent respectivement du 13 novembre 2012 et du 29 septembre 2014 — tous
deux antérieurs de plusieurs années à la nouvelle banque de questions entrée en vigueur le
2 mai 2016, celle-là même que le spécimen revendique « moderniser » (commentaires Q4, Q19 :
OBS-16). Ce que ces deux fils décrivent est donc la forme de l'**ancienne** banque — le
contre-modèle de cette passe, pas un témoin de l'actuelle. L'axe Piège n'a, au total,
aucune observation datée d'après le 2 mai 2016 dans ce corpus.

**`couverture/poids` n'est pas établissable depuis ce corpus.** Le spécimen porte 24
questions sur environ dix-sept catégories normalisées (vingt chaînes exactes distinctes,
OBS-6), qui ne se recoupent pas proprement avec les onze thèmes officiels de communication
— déjà constaté à plus grande échelle dans `couverture.md`. L'arrêté du 29 avril 2024
mentionne les thèmes pédagogiques sans les énumérer (annexe V, [M-29]). Aucune table de
référence « part d'un thème dans la vraie banque » n'est donc écrivable depuis ce que ce
rapport a pu lire ; le compteur n'est pas écrit, pour cette raison précise plutôt que par
omission.

**La strate 1 elle-même a une limite qu'il faut redire ici.** Le paragraphe qui sert de
proxy à l'énoncé dans le tableau ci-dessus est une reconstruction éditoriale de la réponse
correcte, pas l'énoncé lu par le candidat ni le texte des propositions — voir l'avertissement
en tête de la strate 1. Toute observation de « personne grammaticale » ou de « support
visuel » tirée de ce corpus hérite de cette approximation.

### Ce qui reste de la grille, après ce corpus

Les six axes de la spec (§2) ne sortent pas tous intacts de cette lecture. Décidé ici pour
que la tâche 3 hérite de la réduction plutôt que de la découvrir :

- **Personne** — gardé, solide (OBS-1 : 21/24).
- **Ancrage** — gardé **qualitativement seulement**, sur OBS-16. Une direction, jamais un
  ratio : ce corpus ne peut jamais dire quelle part de la vraie banque est illustrée, et
  aucun axe ne doit viser « passer de 19 % à X % ».
- **Objet** — gardé, sur OBS-7 (critère resserré à « au moins 13/24 »).
- **Format** — réduit au **nombre** de propositions (OBS-9, tiré du droit : 0 à 4 lettres
  possibles). La **longueur** des propositions sort de la grille : aucune observation du
  corpus ne la mesure.
- **Piège** — **retiré**. Son seul appui, OBS-14, est antérieur à la réforme du 2 mai 2016
  (ci-dessus) — la spec (§2) : « un axe qu'aucune observation ne soutient est retiré. »
- **Poids** — **retiré**, et `couverture/poids` ne sera pas écrit (raison ci-dessus).

## 2. La grille

Chaque axe est adossé aux observations qui le soutiennent. Un axe que le corpus n'a pas
soutenu est listé plus bas, avec son motif de retrait.

| Axe | Ce qu'il oppose | Observations | Mécanisable ? |
|---|---|---|---|
| Personne | « je », « vous » / impersonnel | OBS-1, OBS-2 | Oui — `forme/impersonnel` (tâche 4). Deux registres, mesurables séparément par un test lexical sur le texte livré : le marqueur de première personne dans le paragraphe qui rejoue la situation (OBS-1, 21/24) et le registre impersonnel du commentaire pédagogique qui le suit (OBS-2, 23/24). Deux motifs de surface, sans ambiguïté sémantique à trancher pour un script. |
| Ancrage | question posée sur une scène vue du poste de conduite / savoir hors situation — **qualitatif seulement**, aucune cible chiffrée | OBS-16 | Oui, avec réserve. `forme/hors-situation` (tâche 4) décrit la part de cartes Valido sans mise en situation explicite, mais ne se compare à **aucun** taux de l'épreuve réelle : OBS-16 est une déclaration qualitative de la source elle-même (« moderniser la forme »), jamais un ratio, et ce corpus ne peut mesurer aucune part illustrée de la vraie banque. Le compteur reste un diagnostic interne à Valido, jamais une cible chiffrée — et ne doit jamais être relu comme telle. |
| Objet | ce que je dois **faire** / ce que la règle **dit** | OBS-7 | Oui — `forme/definitionnel` (tâche 4). Le critère resserré à « au moins 13/24 » (verbe d'action explicite dans le paragraphe de réponse, OBS-7) transpose en test lexical sur `explanation` — un motif de surface, aussi mou à la marge que le corpus lui-même le signale (Q13, Q17 comptées côté constat faute de verbe net, sans casser le total). |
| Format | nombre et longueur des propositions — **réduit** au nombre de réponses correctes acceptées ; la longueur sort de la grille, aucune observation ne la mesure | OBS-3, OBS-9 | Non — voir « Le cas Format » ci-dessous. |

**Le cas Format.** L'écart est réel et doublement corroboré : le droit autorise de 0 à 4
lettres correctes par question (OBS-9) et le spécimen en porte la trace, 14 des 24 questions
marquant deux bonnes réponses plutôt qu'une, jamais trois ni quatre (OBS-3). Mais rien dans
cette passe n'agit dessus, pour deux raisons distinctes et non pour une seule. D'abord, le
**nombre d'options** affichées (toujours quatre, A–D) est déjà couvert par `schema/options` ;
un second compteur mesurerait la même chose sous un autre nom. Ensuite, le **nombre de
réponses correctes** est un choix de produit déjà tranché en amont de cette passe, pas par ce
rapport : « la réponse unique est gardée » (spec, « Ce qui est décidé, et ce qui ne l'est
pas », point 1) — `Question.correctID` reste un singulier. Mesurer l'écart entre 0-4 et 1 ne
débouche donc sur aucune décision que cette passe puisse prendre. Un chiffre qu'aucune
décision en aval ne peut consommer n'est pas un diagnostic ; aucun compteur n'est écrit pour
cet axe, et ce n'est pas un oubli.

### Axes retirés

- **Piège** — retiré. Son unique appui, OBS-14, décrit sept structures de piège relevées sur
  un fil de forum daté du 13 novembre 2012 — antérieur de plus de trois ans à la réforme du
  2 mai 2016 que le spécimen lui-même revendique comme une modernisation de la forme des
  questions (OBS-16). Un axe qu'aucune observation postérieure à la réforme ne soutient est
  retiré, plutôt que gardé sur un témoin de l'ancienne banque.
- **Poids** — retiré. Le spécimen répartit 24 questions sur environ dix-sept étiquettes de
  thème, elles-mêmes instables orthographiquement (OBS-6), qui ne se recoupent pas proprement
  avec les onze thèmes officiels de communication ; l'arrêté du 29 avril 2024 mentionne des
  « thèmes pédagogiques » sans les énumérer. Aucune table « part d'un thème dans la vraie
  banque » n'est donc écrivable depuis ce corpus, et `couverture/poids` ne sera pas écrit —
  pour cette raison précise, pas par omission.

## Observations

| id | strate | source | date | ce qui est observé |
|---|---|---|---|---|
| OBS-1 | 1 | [PDF spécimen](https://www.securite-routiere.gouv.fr/sites/default/files/2020-04/reponsesquestionspermisauto_v1604.pdf) | 2026-09-06 | Le paragraphe de réponse porte un marqueur de première personne (je/j'/mon/ma/mes/m') dans 21 des 24 questions (87,5 %) ; seules Q1, Q14 et Q20 en sont dépourvues. |
| OBS-2 | 1 | [PDF spécimen](https://www.securite-routiere.gouv.fr/sites/default/files/2020-04/reponsesquestionspermisauto_v1604.pdf) | 2026-09-06 | Le commentaire pédagogique en italique qui suit l'étiquette de thème est impersonnel sur 23 des 24 questions, la seule exception étant Q13 (« le véhicule qui nous dépasse ») — un registre par ailleurs distinct du paragraphe de réponse, jamais adressé au candidat. |
| OBS-3 | 1 | [PDF spécimen](https://www.securite-routiere.gouv.fr/sites/default/files/2020-04/reponsesquestionspermisauto_v1604.pdf) | 2026-09-06 | 14 des 24 questions (58 %) marquent deux bonnes réponses (ex. « A, C ») plutôt qu'une seule ; aucune n'en marque trois ou quatre. |
| OBS-4 | 1 | [PDF spécimen](https://www.securite-routiere.gouv.fr/sites/default/files/2020-04/reponsesquestionspermisauto_v1604.pdf) | 2026-09-06 | Seules les lettres A, B, C, D apparaissent sur les 24 questions, jamais E ni au-delà : quatre propositions déduites, jamais observées — le PDF ne montre ni l'énoncé ni les propositions elles-mêmes. |
| OBS-5 | 1 | [PDF spécimen](https://www.securite-routiere.gouv.fr/sites/default/files/2020-04/reponsesquestionspermisauto_v1604.pdf) | 2026-09-06 | Le commentaire pédagogique de 3 questions sur 24 (Q4, Q13, Q19) nomme explicitement un support visuel (« le visuel », « le format vidéo ») ; les 21 autres ne le mentionnent pas — le fichier PDF lui-même ne contient aucune image, donc la présence d'image ne peut être comptée que par indice textuel sur cet échantillon, jamais observée directement. |
| OBS-6 | 1 | [PDF spécimen](https://www.securite-routiere.gouv.fr/sites/default/files/2020-04/reponsesquestionspermisauto_v1604.pdf) | 2026-09-06 | Les étiquettes de thème varient orthographiquement pour une même catégorie sur seulement 24 questions (« Conscience des risques liés aux usagers vulnérables » — Q2, Q11 — vs « Connaissance des risques liés aux usagers vulnérables » — Q9 ; « réglementation » vs « règlementation » — Q4 vs Q19 ; accent absent sur « conduite de nuit » — Q3 vs Q14), confirmant à petite échelle l'instabilité déjà relevée dans `couverture.md`. |
| OBS-7 | 1 | [PDF spécimen](https://www.securite-routiere.gouv.fr/sites/default/files/2020-04/reponsesquestionspermisauto_v1604.pdf) | 2026-09-06 | Le paragraphe de réponse décrit une action ou décision explicite du conducteur (« je dois vérifier… », « je m'assure… », « j'allume… ») dans **au moins 13 des 24 questions** ; le critère est mou à la marge — Q13 et Q17 énoncent aussi une décision (ne pas signaler un dépassement, ne pas rétrograder) mais sont comptées côté constat, faute d'un verbe d'action net. Les 9 questions restantes (Q1, Q6, Q7, Q8, Q12, Q14, Q20, Q23, Q24) sont sans ambiguïté un simple constat, une conséquence ou un mécanisme, même à la première personne. |
| OBS-8 | 2 | [Arrêté du 29 avril 2024, annexe VI (WS-ETG)](https://www.legifrance.gouv.fr/jorf/id/JORFTEXT000049502288) | 2026-09-06 | L'épreuve tire aléatoirement 40 diapositives, pour une durée maximale de 45 minutes, sans temps de réponse par question fixé dans le texte. |
| OBS-9 | 2 | [Arrêté du 29 avril 2024, annexe VI (WS-ETG)](https://www.legifrance.gouv.fr/jorf/id/JORFTEXT000049502288) | 2026-09-06 | Le format légal de réponse est « une combinaison de 0 à 4 lettres parmi A, B, C et D » — le nombre de bonnes réponses n'est jamais fixé à une seule par le droit. |
| OBS-10 | 2 | [Arrêté du 20 avril 2012, art. 2-I-B](https://www.legifrance.gouv.fr/loda/id/JORFTEXT000025803494) | 2026-09-06 | Le seuil de réussite est de 35 bonnes réponses sur 40, en vigueur depuis le 4 décembre 2022. |
| OBS-11 | 2 | [Arrêté du 27 avril 2016](https://www.legifrance.gouv.fr/loda/id/JORFTEXT000032471964) | 2026-09-06 | Abrogé depuis le 5 mai 2024 ; son annexe 2 (programme de l'épreuve) reste, comme en passe 2, une image scannée du fac-similé du JO — illisible en texte, sans changement dû à l'abrogation. |
| OBS-12 | 3 | [ornikar.com/code/gratuit/serie-1](https://www.ornikar.com/code/gratuit/serie-1), [envoituresimone.com/code-de-la-route/quiz](https://www.envoituresimone.com/code-de-la-route/quiz), [codeclic.com/gratuit.php](https://www.codeclic.com/gratuit.php), [digischool.fr/auto/code-gratuit](https://www.digischool.fr/auto/code-gratuit) | 2026-09-06 | Sur les 4 domaines de `DOMAINES_FORME`, aucun n'affiche de question réelle en HTML statique sans compte : rendu JavaScript vide pour 2 (ornikar, digischool), mur de connexion explicite pour 1 (envoituresimone), métadonnées de série sans contenu de question pour 1 (codeclic). |
| OBS-13 | 3 | [codeclic.com/gratuit.php](https://www.codeclic.com/gratuit.php) | 2026-09-06 | La page de métadonnées, seule accessible sans compte, recoupe deux chiffres déjà bornés en strate 2 : 40 questions par série et seuil de réussite à 35/40. Elle annonce en plus « photos prises depuis le poste de conduite et vidéos de situations réelles sur la route » — une affirmation de strate 3 **seule**, qu'aucun texte de loi ne corrobore (l'arrêté de 2024 fixe une taille d'écran, jamais la nature d'une diapositive). |
| OBS-14 | 3 | [forum.codeclic.com/questions-pieges-code-t4453.html](https://forum.codeclic.com/questions-pieges-code-t4453.html) | contenu du 2012-11-13 (lu le 2026-09-06) | Deux messages décrivent sept structures de piège rapportées par des candidats (condition qui renverse selon un seuil, exception à une interdiction générale, faux ami de statut, causalité ambiguë entre facteurs d'accident, obligation confondue avec recommandation, seuil numérique précis, signal visuel ambigu). **Antérieur de plus de trois ans à la réforme du 2 mai 2016** : ces structures décrivent la forme de l'ancienne banque, pas de celle en vigueur. Aucun texte de question n'en est recopié ici. |
| OBS-15 | 3 | [forum.codeclic.com/questions-posees-lors-examen-code-route-t5541.html](https://forum.codeclic.com/questions-posees-lors-examen-code-route-t5541.html) | contenu du 2014-09-29 (lu le 2026-09-06) | Quatre messages visibles sans compte, dont un candidat reconstituant de mémoire une quarantaine de questions de son propre passage — un ordre de grandeur qui recoupe OBS-8. **Antérieur de plus d'un an et demi à la réforme du 2 mai 2016** : ce récit décrit un passage sous l'ancienne banque, pas un témoin de l'actuelle, et reste de toute façon un souvenir personnel non vérifiable relayé par un éditeur. |
| OBS-16 | 1 | [PDF spécimen](https://www.securite-routiere.gouv.fr/sites/default/files/2020-04/reponsesquestionspermisauto_v1604.pdf) | 2026-09-06 | Les commentaires pédagogiques de Q4 et Q19 déclarent explicitement le changement d'ancrage : « La nouvelle banque de questions de l'examen du code de la route s'attache à moderniser la forme des questions … Ici, le visuel met le candidat en situation réelle de conduite, plutôt que le confronter, comme c'était le cas auparavant, au seul panneau et à la connaissance de sa signification. » Une déclaration qualitative de la source elle-même, pas un ratio mesuré sur l'échantillon. |
