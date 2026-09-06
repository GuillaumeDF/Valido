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
que la tâche 3 hérite de la réduction plutôt que de la découvrir — le développement de
chaque décision est en « 2. La grille » ci-dessous, à l'exception de Poids, dont le motif
reste ci-dessus, dans « Ce que ce corpus ne peut pas dire » :

- **Personne** — gardé (OBS-1, OBS-2).
- **Ancrage** — gardé, **qualitativement seulement** (OBS-16).
- **Objet** — gardé (OBS-7).
- **Format** — réduit au nombre de **réponses correctes acceptées** ; la **longueur** des
  propositions sort de la grille (OBS-3, OBS-9).
- **Piège** — **retiré** (OBS-14).
- **Poids** — **retiré**, et `couverture/poids` ne sera pas écrit (raison ci-dessus).

## 2. La grille

Chaque axe est adossé aux observations qui le soutiennent. Un axe que le corpus n'a pas
soutenu est listé plus bas, avec son motif de retrait.

| Axe | Ce qu'il oppose | Observations | Mécanisable ? |
|---|---|---|---|
| Personne | « je », « vous » / impersonnel | OBS-1, OBS-2 | Oui — `forme/impersonnel` (tâche 4). Deux registres du spécimen, mesurés côté Valido par un seul test lexical sur `prompt` : le marqueur de première personne dans le paragraphe qui rejoue la situation (OBS-1, 21/24) et le registre impersonnel du commentaire pédagogique qui le suit (OBS-2, 23/24). Deux motifs de surface, sans ambiguïté sémantique à trancher pour un script. |
| Ancrage | question posée sur une scène vue du poste de conduite / savoir hors situation — **qualitatif seulement**, aucune cible chiffrée | OBS-16 | Oui, avec réserve. `forme/hors-situation` (tâche 4) décrit la part de cartes Valido sans mise en situation explicite, mais ne se compare à **aucun** taux de l'épreuve réelle : OBS-16 est une déclaration qualitative de la source elle-même (« moderniser la forme »), jamais un ratio, et ce corpus ne peut mesurer aucune part illustrée de la vraie banque. Le compteur reste un diagnostic interne à Valido, jamais une cible chiffrée — et ne doit jamais être relu comme telle, par exemple en visant « de 19 % à X % ». |
| Objet | ce que je dois **faire** / ce que la règle **dit** | OBS-7 | Oui — `forme/definitionnel` (tâche 4). Le critère resserré à « au moins 13/24 » (verbe d'action explicite dans le paragraphe de réponse, OBS-7 — le proxy du `prompt` dans ce corpus) transpose en test lexical sur `prompt` — un motif de surface, aussi mou à la marge que le corpus lui-même le signale (Q13, Q17 comptées côté constat faute de verbe net, sans casser le total). |
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
  retiré, plutôt que gardé sur un témoin de l'ancienne banque — la spec (§2) : « un axe
  qu'aucune observation ne soutient est retiré. »
- **Poids** — retiré, et `couverture/poids` ne sera pas écrit. Motif complet en §1, « Ce que
  ce corpus ne peut pas dire » : ne pas le redire une troisième fois ici est le point de la
  tâche 5, pas un oubli.

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

## 3. Les compteurs de forme

Trois compteurs, **informatifs**. Ils mesurent un écart avec l'épreuve, pas un défaut : un
énoncé impersonnel peut être la forme juste sur une carte de signalisation. Les faire
baisser pour eux-mêmes viderait les cartes, ce que la passe 3 a appris à ses dépens sur
`expl/paraphrase-litterale`.

| compteur | effectif sur 255 | faux positifs relevés | ce qu'il mesure vraiment |
|---|---|---|---|
| `forme/impersonnel` | 199 | 0 relevé — recherché sur « on doit/peut », « doit-on », « tu/nous/ton/ta/tes » et l'élision `j’` (apostrophe courbe) dans les 199 cartes flaggées : aucune occurrence. | L'absence de marqueur de première ou deuxième personne (vous/votre/vos/je/mon/ma/mes/j') dans `prompt` — un test de présence, sans ambiguïté sur ce lexique-là. Le critère « ni verbe à l'impératif en tête » de la spec §3 a été abandonné en cours de tâche 3 sans motif écrit ; vérifié après coup, aucun `prompt` des 255 cartes `code` n'ouvre sur un impératif nu — l'abandon ne change donc rien sur la banque actuelle, mais serait à rouvrir si une future carte s'écrivait « Ralentissez dès que : ». |
| `forme/hors-situation` | 200 | **4-6 % estimés**, pas un compte exhaustif. Ma recherche ciblée (`vous croisez`, `vous doublez`, `à l'approche de` + « vous devez », `face à`) en avait trouvé 5/200 (2,5 %) : `De nuit hors agglomération, vous croisez un véhicule…`, `Vous croisez une voie de tramway…`, `Vous doublez un autocar qui fait descendre des enfants…`, `À l'approche d'un carrefour à sens giratoire…, vous devez :`, `Face à un motard accidenté qui respire, son casque :`. Une relecture indépendante, sur un échantillon distinct, en trouve davantage — trois cartes que ma propre recherche n'avait pas prises : `Premier sur un accident, seul, face à une victime consciente et coincée, vous devez :`, `Un véhicule s'apprête à vous dépasser. Vous devez :`, `Un feu de circulation et un panneau de priorité se contredisent. Lequel suivez-vous ?`. Ni l'une ni l'autre lecture n'est exhaustive sur les 200 : le chiffre est une estimation à méthode déclarée (deux échantillons, pas un dépouillement complet), pas une précision. **Le trou de couverture qui explique l'écart** : une scène posée en prose, sans démonstratif ni verbe de déplacement, échappe au motif — et aucun élargissement lexical ne la rattrape sans marquer comme situées des règles générales qui ne le sont pas (« En zone bleue, vous devez : » serait, à tort, marquée comme située si `devez` rejoignait la liste de verbes — c'est une règle générale, pas une scène ; et ce que `Lequel suivez-vous ?` situe, c'est « se contredisent », une scène posée en prose, pas l'inversion interrogative). Des tournures voisines examinées et **écartées** du décompte, parce qu'elles ne sont pas des scènes malgré une tournure proche : `Si vous doublez votre vitesse…` (relation numérique, pas une scène), `Vous dépassez de 30 km/h…` (excès chiffré, pas un dépassement), `Tenir son téléphone en main au volant…` / `La fatigue ou l'usage du téléphone au volant…` (« au volant » générique), `À l'approche d'une intersection, le dépassement :` / `…d'un passage pour piétons, dépasser est :` (règle générale, pas une scène précise). **Ce que le compteur anchre réellement, mesuré deux fois indépendamment** : il coïncide avec « la carte n'a pas d'illustration » sur 249 des 255 cartes (97,6 %) — le test déictique n'en repêche que 6 sur les 206 cartes sans illustration, dont 2 sur un « ces »/« ce » anaphorique plutôt qu'un déictique de scène (`Parmi ces effets, lequel est causé par l'alcool au volant ?`, `Après une infraction ayant entraîné le retrait d'1 point, ce point est récupéré :`). Côté illustré, 44 des 49 cartes matcheraient `DEICTIQUE` même sans l'exemption d'image, et 26 d'entre elles le font sur un pointeur vers l'image elle-même (« ce panneau » ×18, « ce marquage » ×5, « ce signal » ×3). **La conséquence, à écrire parce qu'elle est le point** : le compteur classe comme ancrée exactement la forme dont OBS-16 dit que la réforme de 2016 l'a abandonnée (« le seul panneau et la connaissance de sa signification »). Il ne peut donc **ni** servir de cible à une réécriture **ni** être corrigé en élargissant `DEICTIQUE` — il faudrait au contraire le *restreindre*, ce qui déplacerait une ligne de base publiée aujourd'hui même (200) et retenue parmi les huit compteurs que ce chantier ne doit pas faire bouger. Sans cette dernière clause, un lecteur ultérieur conclut « il suffit d'élargir le motif » ; la mesure dit l'inverse. | La part de cartes Valido sans mise en situation explicite (`ce/cette/cet/ces` + nom, `ici/devant/derrière`, ou `vous` + un verbe de sept listés) et sans illustration — **un diagnostic interne à Valido, comparé à aucun taux de l'épreuve réelle** (aucun n'est mesurable depuis ce corpus, cf. §1). Ne jamais relire ce chiffre comme une cible. |
| `forme/definitionnel` | 94 | 2 sur 94 (2,1 %) — trouvés en vérifiant, pour chaque carte flaggée, si le motif `DEFINITION` matche encore dans la dernière proposition avant le « : » (et non dans une phrase antérieure sans rapport) : `La circulation est arrêtée juste au-delà d'un passage à niveau. Vous :` (la question posée est « que faites-vous », pas une définition — le « est » vient d'une phrase de mise en situation) et `La circulation est figée en files sur toutes les voies. Rouler plus vite qu'une file voisine :` (même mécanisme, question elliptique sans copule propre). | Un `prompt` `code` qui se termine par « : » et contient un verbe de définition/obligation (est/sont/sert à/signifie/indique/impose/doit être/permet de) — proxy lexical de l'axe Objet (« ce que la règle dit » plutôt que « ce que je dois faire »). **Angle mort transversal, mesuré une fois pour toutes** : 13 des 255 cartes `code` (5,1 %) portent un prompt de barème par points, et les 13 sont manquées par ce compteur — vérifié carte par carte contre `questions.json` et contre la liste des 94 prompts flaggés (aucun des 13 n'y figure). Réparties sur **sept** domaines, pas six comme une première estimation non vérifiée l'aurait dit : `Permis & sanctions` ×3 (téléphone en main, défaut de ceinture, cumul d'infractions), `Vitesse` ×4, `Priorités & intersections` ×2, et une carte chacun dans `Feux`, `Alcool & stupéfiants`, `Panneaux & marquage` (`3cb86b6e…`) et `Tunnels & passages à niveau`. La cause : le lexique (est/sont/sert à/signifie/indique/impose/doit être/permet de) ne contient ni « fait perdre », ni « entraîne un retrait de », ni « coûte » — et « Combien de points perdez-vous ? » échappe en plus au test du « : » final, puisqu'elle se termine par un point d'interrogation. Consigné une fois ici pour que les tableaux des dix domaines restants le citent plutôt que de le redécouvrir un par un. |

Reproduire : `python3 Tools/audit.py | grep -E '^### forme/'`.

Aucun des trois ne dépasse le tiers de faux positifs fixé comme seuil de resserrement ; les
trois sont déclarés tels quels, à l'image de `lettre/reference` (1) et `forme/markdown` (1).

## 4. La lecture à la main

Treize domaines, un tableau chacun, dans l'ordre où ils ont été lus. Chaque ligne porte un
verdict sur trois axes non mécanisables — ancrage, objet, piège — puis la question directe
(« se poserait-elle à l'examen ? ») et son motif en une phrase. L'axe Piège est **décrit**,
jamais jugé : la spec (§2 d'`audit-2026-09-formes.md`) retire cet axe faute d'appui
postérieur à la réforme de 2016, et rien ci-dessous n'en tire une conclusion de conformité.

**Le critère d'admissibilité, déclaré ici parce qu'il ne l'avait jamais été.** La première
version des trois tableaux ci-dessous répondait « oui » sur les 75 lignes et « non » sur
aucune — y compris sur onze lignes dont le motif nommait lui-même un défaut de forme
(« forme ancien modèle », « photo isolée + question de sens »...) sans que le verdict en
tienne compte. La lecture carte par carte n'était pas en cause — les 75 motifs sont
distincts et les faits qu'ils rapportent se vérifient — mais aucun critère ne séparait
« oui » de « non » : la colonne collectait un « oui » par défaut. En voici un, appliqué
ci-dessous ligne par ligne :

**`non`** = aucune des 24 questions du spécimen n'a cette forme, **ou** OBS-16 nomme cette
forme comme abandonnée par la réforme.
**`partiel`** = la forme est attestée dans le spécimen, mais la carte y ajoute un artefact
étranger — datation de la règle, objet absent de sa propre image, catégorie au lieu d'un
signal précis.
**`oui`** = forme attestée, sans artefact.

**Une convention pour les tableaux qui suivent.** Un désaccord avec un compteur se note
**dans la ligne de la carte elle-même, dans son propre tableau, en nommant le compteur** —
jamais après coup dans la prose d'un autre domaine. `3cb86b6e4c489d919a495408021f062a`
(`Panneaux & marquage`) est ce qui arrive sinon : son désaccord avec `forme/definitionnel`
n'était noté nulle part dans son propre tableau, et la synthèse de lecture du lot (rapport
de tâche, pas ce fichier) ne le nommait pas non plus en évoquant « deux domaines sur trois »
et 6 cartes pour ce blocage lexical — d'où le sous-compte corrigé en §3 (13 cartes sur 7
domaines, vérifiées carte par carte).

### Panneaux & marquage (27 cartes)

| id | ancrage | objet | piège | se poserait à l'examen ? | motif |
|---|---|---|---|---|---|
| `11d37be22fd315668cb2930373e95c80` | image isolée (disque seul, pas de scène) | règle | absolu d'énoncé (« ne lève jamais ») contre une option qui est elle-même l'exception qu'il ne lève pas | non | portée réelle et testée d'un panneau de fin d'interdiction, mais photo isolée + question de sens — exactement la forme qu'OBS-16 nomme abandonnée par la réforme |
| `1509ad94aea7c6f82355f3362b10a8e1` | image isolée | faire (ce qu'on ne peut pas faire) | contraste arrêt/stationnement, faux-ami de statut | non | teste une confusion réelle (arrêt implique stationnement) par contraste d'options, mais panneau isolé sans scène — la connaissance de sa signification qu'OBS-16 dit abandonnée, même posée comme une action interdite plutôt qu'une définition |
| `1658abbc16db4667fec7211f8c9b0f93` | image isolée | règle | aucun | non | portée standard (côté, limite à la première intersection), mais photo isolée + question de sens — la forme qu'OBS-16 dit abandonnée |
| `37fe1af42b8d81709c93fcc98510a42d` | semi-situé (marquage photographié sur chaussée) | faire (rejoindre la voie désignée) | contraste avec une option de statu quo (« garder votre voie ») | oui | marquage vu en contexte de chaussée, teste un geste concret — plus proche de l'esprit de la réforme que les panneaux isolés du même lot |
| `37fe1af42b8d8174a3c3e94967027ed1` | image isolée | règle (portée de l'obligation, pas une décision) | aucun | non | distinction B21b/B21-1, contenu solide, mais forme ancien modèle — celle qu'OBS-16 dit remplacée |
| `37fe1af42b8d817881dee3d999a911c3` | image isolée | règle | aucun | non | distinction carré/rond (info/prescription), contenu solide, mais forme ancien modèle — celle qu'OBS-16 dit remplacée |
| `37fe1af42b8d81b3a4b7d484aef5aef8` | semi-situé (chaussée décrite, « de votre côté ») | règle (permis/interdit, pas une action choisie) | paire d'options contraires assumée (deux règles fausses parmi quatre, §2 questions.md) | oui | l'image tranche un cas ambigu — proche de l'esprit « mise en situation » malgré l'absence de scène de conduite complète |
| `37fe1af42b8d81b5aa9fc685af3ba92f` | image isolée | règle | absolu retiré du distracteur (« sans contrainte » sans « aucune ») | non | distinction danger/prescription standard, mais forme ancien modèle — celle qu'OBS-16 dit remplacée |
| `37fe1af42b8d81d68a70da4a7305f6c1` | semi-situé (chaussée décrite) | règle | aucun | oui | marquage rare mais réel, lecture de sens plutôt que décision |
| `443e4299ccb3ff71669f8df6669b8bf4` | image isolée | règle | absolu correct (« même si la route est vide ») contre un distracteur conditionnel | non | contenu classique (arrêt inconditionnel), mais forme ancien modèle — celle qu'OBS-16 dit remplacée |
| `570e5e1ef861e032773f43b44bc817a9` | semi-situé (aire décrite sur la chaussée) | règle | aucun | oui | marquage rare, correctement testé en reconnaissance |
| `7d44f7dd303fce58716234cba54480b1` | image isolée, et hypothétique (le panonceau demandé est absent de l'image) | règle | distracteurs nommant des panonceaux réels mais hors-sujet | non | seule carte du lot à interroger un élément absent de sa propre image — aucune des 24 questions du spécimen n'a cette forme, et le panneau isolé qui la porte est par ailleurs celle qu'OBS-16 dit abandonnée |
| `89bea09b482974f37e7dd7d35aba23f5` | image isolée | règle (une limite : ce qu'il ne prescrit pas) | absolu (« rien ») contre des options d'obligation | non | teste une limite précise (position tenue par le marquage au sol), mais forme ancien modèle — celle qu'OBS-16 dit remplacée |
| `8a1026edb35c31c37ab6df7b29851ef2` | image isolée | règle | aucun | non | reconnaissance de panneau standard, mais forme ancien modèle — celle qu'OBS-16 dit remplacée |
| `9e65525bbce6a6491d37bbf6f180c04c` | image isolée, mais « vous pouvez encore doubler » évoque une exception à choisir | faire (exception) | exception à une interdiction générale | non | teste une exception réelle et précise, plus proche d'une décision que les autres panneaux isolés du lot — mais reste un panneau isolé sans scène, la forme qu'OBS-16 dit abandonnée |
| `9eb8506813f0c8b729b66157ec95a63f` | situé — vraie scène vue du poste de conduite | règle (ce que le panneau fait/ne fait pas) | absolu retiré de l'option (« à l'anneau » supprimé) | oui | seule vraie mise en situation du lot avec `dce501d416e5db1cc6344725007fbad6` — exactement la forme qu'OBS-16 dit visée par la réforme |
| `dce501d416e5db1cc6344725007fbad6` | situé — scène + « ici » + « vous engager » | faire | absolu dans un distracteur (« arrêt complet, roues bloquées ») | oui | mise en situation complète et décision à prendre — la forme la plus proche de la réforme du lot |
| `ede6968609d285b22494f57032c53e2f` | image isolée | règle | aucun | non | distinction conseillé/obligatoire, contenu solide, mais forme ancien modèle — celle qu'OBS-16 dit remplacée |
| `ee11b58d97d21d637c3ec38c7181fa87` | image isolée (mais panonceau réellement visible, à la différence de `7d44f7dd`) | règle | aucun | non | rôle du panonceau testé sur un exemple concret visible dans l'image, sans l'artefact d'objet absent de `7d44f7dd` — mais reste un panneau isolé sans scène, la forme qu'OBS-16 dit abandonnée |
| `1a0a5812ff8659ba24b3b4c750e469e5` | non situé — configuration décrite en mots, sans l'image de sa jumelle `37fe1af42b8d81b3a4b7d484aef5aef8` | règle | aucun | oui | reformule en toutes lettres une configuration que la carte-sœur illustre ; sans image, la lecture demande plus d'effort de représentation qu'à l'examen réel |
| `37fe1af42b8d81059d80e8954b36ed7f` | non situé, générique (catégorie de panneau, pas un panneau précis) | règle | aucun | partiel | seule catégorie générique du domaine (« un panneau rond à bord rouge », pas un panneau donné) — l'examen montre toujours un signal, jamais une classe |
| `37fe1af42b8d8141b1d0e3ca0b855119` | non situé, générique | règle | aucun | oui | rappel d'une règle centrale du code (R412-19), pas besoin de scène pour être testé valablement |
| `37fe1af42b8d81699c2ffbefd648d9a3` | non situé, générique | règle | aucun | partiel | même réserve que le panneau à bord rouge du même lot : teste une catégorie plutôt qu'un panneau réel |
| `37fe1af42b8d81f8a2f3f8bd2afc9d2d` | non situé, générique | règle | paire d'inverses décrite (franchissement autorisé/interdit) | oui | règle centrale testée sans mise en situation, forme standard de rappel |
| `3cb86b6e4c489d919a495408021f062a` | non situé — formulation infinitive générique, pas une scène vécue | **désaccord avec le compteur `forme/definitionnel`** — règle (barème), pas action | distinction chevauchement/franchissement, proche faux-ami | oui | « fait perdre » est hors du lexique du compteur (est/sont/sert à/signifie/indique/impose/doit être/permet de) ; l'objet réel est un barème, pas une décision — même mécanisme que les quatre cartes de `Vitesse` ci-dessous |
| `5a4e6a38ad3e1153f807ec5e0e6ba40e` | non situé, générique | règle | aucun | oui | rappel de règle standard (ligne de rive), pas de mise en situation nécessaire |
| `f12ee5bea85947a13d387f574e817337` | **désaccord avec le compteur — situé en prose** (conflit de signalisation décrit, à la 3ᵉ personne, sans démonstratif ni verbe listé) | faire | aucun | oui | scène décrite en prose (conflit de signalisation rencontré), manquée par `forme/hors-situation` faute de démonstratif ou de « vous » + verbe listé — même angle mort que l'exemple donné en tête de tâche |

**Ce que la lecture a vu et que les compteurs n'ont pas vu :** `forme/hors-situation` est bas
sur ce domaine (8/27) exactement comme prévu — mais pour une raison plus étroite que
« illustré = situé » : sur les 19 cartes illustrées, seules deux (`9eb85068…`, `dce501d4…`)
montrent une vraie scène vue du poste de conduite ; quatre montrent un marquage photographié
en contexte de chaussée (semi-situé) ; les treize autres montrent un panneau isolé sur fond
neutre, associé à un prompt purement définitionnel (« Ce panneau signifie/indique/impose/
prescrit/interdit »). Or OBS-16 (le commentaire du spécimen officiel lui-même, Q4 et Q19)
oppose explicitement « le visuel met le candidat en situation réelle de conduite » à « le
confronter, comme c'était le cas auparavant, au seul panneau et à la connaissance de sa
signification » : ces treize cartes sont, par cette définition même, la forme que la
réforme dit avoir quittée, alors que le compteur les traite comme anchrées au même titre
que les deux scènes réelles. Ce n'est pas une erreur du compteur — il mesure la présence
d'une illustration, pas sa nature — mais une limite de ce que ce diagnostic peut établir
sans corpus de vraies diapositives d'examen. Une deuxième carte (`f12ee5be…`) est un vrai
faux négatif : une scène en prose (contradiction de signalisation rencontrée) manquée faute
de motif lexical, sur le modèle déjà connu.

**Ce n'est pas l'image qui épargne ces cartes — ce n'est pas non plus « par construction ».**
Sur les 31 cartes illustrées lues dans ce lot de trois domaines (19 ici, 8 en `Priorités &
intersections`, 4 en `Vitesse`), 27 échapperaient au compteur même sans l'exemption
d'illustration : leur `prompt` matche `DEICTIQUE` de toute façon (§3), le plus souvent sur un
pointeur direct vers l'image (« ce panneau » ×18, « ce marquage » ×5, « ce signal » ×3 sur
l'ensemble des 255 cartes). Seules les quatre cartes « Qui passe en premier ? »/« Qui doit
céder ? » de `Priorités & intersections` sont sauvées par la seule exemption, sans aucun mot
déictique dans leur `prompt`. Dire que les cartes illustrées échappent au compteur « par
construction », via l'exemption d'image, inverse donc la conclusion pour 27 des 31 : ce
n'est pas l'image qui les épargne, c'est « Ce panneau » — la forme même de l'ancien modèle
que les treize cartes du paragraphe précédent reproduisent par ailleurs.

**Ce que les compteurs ont signalé à tort :** rien à ajouter aux faux positifs déjà
répertoriés en §3 sur ce domaine — les 8 cartes flaggées `forme/hors-situation` sont bien
non situées à la lecture, sauf `f12ee5be…` ci-dessus.

### Priorités & intersections (26 cartes)

| id | ancrage | objet | piège | se poserait à l'examen ? | motif |
|---|---|---|---|---|---|
| `3e5d97761594126d37652be2e0e976dc` | situé — scène + « ces feux » + carrefour décrit | règle (quelle règle reprend) | hiérarchie de repli (feu > priorité à droite), faux-ami possible avec STOP | oui | scène concrète et complète (feu en panne visible), forme conforme à la mise en situation |
| `43dc08f7c9ebc00497a4022e24319683` | situé — scène + « à ce panneau » + « vous devez » | faire | absolu correct (« même quand rien n'arrive ») contre un conditionnel trompeur | oui | scène complète, décision d'action demandée — forme exemplaire |
| `6e1a51d34b4b79e4366d6566795e5151` | situé — scène décrite (pente, véhicule qui monte) | faire (qui doit céder) | contre-intuitif (celui qui descend cède, pas celui qui monte) | oui | scène de conduite réelle et rare (croisement en côte), forme et contenu alignés |
| `8e9464777a61dba3859e3ecc08f7327d` | situé — scène + « vous arrivez » | faire | inversion de la règle par défaut par un panneau | oui | scène complète, teste une inversion de règle — bien alignée avec la mise en situation |
| `dd4c58febe771b6f297f1ca46c2ec75b` | situé — scène giratoire | faire | aucun | oui | scène complète et décision claire |
| `e93ca4d156de5854eafce9393be39274` | situé — scène (carrefour en T décrit) | faire | faux-ami (« rouler sur la voie qui traverse » ne donne pas la priorité) | oui | scène concrète, décision de priorité classique bien testée |
| `ef4cfd171e0e9911a2619b3b06336216` | situé — scène (carrefour + tramway décrits) | faire | absolu correct (priorité indépendante du côté), faux-ami (signal sonore requis) | oui | scène complète, contenu rare (priorité du tramway) bien testé |
| `f255331d3f234810a4807594b43b397f` | situé — scène illustrée (croisement nu, véhicule à droite), malgré un énoncé très court | faire | règle de base, aucun absolu | oui | l'énoncé le plus court du lot (« Qui passe en premier ? »), mais la scène illustrée le précise suffisamment |
| `02f7d6a65856887348bfe8653bb90c6e` | non situé — un lieu (« sur l'anneau ») et une règle de geste, pas un moment | faire (quand signaler) | faux-ami de timing (trop tôt vs trop tard) | oui | un lieu et une condition ne sont pas une scène : la règle vaut pour tout instant passé sur l'anneau, elle ne fixe aucun moment précis — accord avec le compteur |
| `09f18973aee39386ee42782f04d03ec2` | non situé — condition générale (« hors d'une intersection réglée »), pas une scène | faire | faux-ami (croire que le clignotant rend prioritaire) | oui | même construction que « En zone bleue, vous devez : », exclue en §3 comme règle générale : une condition n'est pas un moment — accord avec le compteur |
| `2a9e02b9719028e72fde6fdd6372a1ff` | non situé — formulation générique (barème) | **désaccord avec le compteur `forme/definitionnel`** — règle, pas action | aucun | oui | « fait perdre » est hors du lexique du compteur ; l'objet réel est un barème, pas une décision — même mécanisme que les quatre cartes de `Vitesse` plus loin dans ce rapport |
| `2daf8939fc85f5b288010cf545bb681d` | non situé, générique (catégorie de rond-point, pas un cas précis) | règle | faux-ami (croire que tout rond-point est un carrefour giratoire) | oui | configuration générale (absence de signalisation), pas une scène précise — accord avec le compteur |
| `37fe1af42b8d812fade7d79d309e4c48` | **désaccord — situé** (« vous devez »), déjà documenté en §3 comme faux positif | faire | aucun | oui | scène de conduite claire (approche d'un giratoire), faux positif déjà connu de `forme/hors-situation` — confirmé |
| `37fe1af42b8d815f8684e4cc91d6950f` | **désaccord — situé** (« Lequel suivez-vous ? »), déjà documenté en §3 | faire | exception décrite (jaune clignotant) | oui | scène en prose (contradiction rencontrée), déjà relevée en §3 — confirmé |
| `37fe1af42b8d8161be32fe2fe9808fff` | non situé, générique — définition de panneau sans scène | règle | faux-ami (croire à un arrêt obligatoire comme au STOP) | oui | distinction cédez-le-passage/STOP, contenu solide, forme neutre |
| `37fe1af42b8d817da9fff3054d6ffa3a` | non situé — question de hiérarchie abstraite, « à un carrefour » générique | règle (structure hiérarchique) | aucun absolu depuis la correction | non | seule carte du lot posée en pure abstraction hiérarchique, sans aucun cas concret pour l'ancrer — l'examen teste cette hiérarchie à travers une scène (feu en panne, agent, priorité à droite), jamais comme un classement ; aucune des 24 questions du spécimen n'a cette forme |
| `37fe1af42b8d818293f3f8d862a5a505` | non situé — événement générique (« un véhicule »), pas « vous » | règle | absolu correct (« en toutes circonstances ») | oui | décrit un événement reconnaissable (sirène, gyrophare) mais à la 3ᵉ personne générique, sans scène propre |
| `37fe1af42b8d8184beb9c6687c92ffb5` | non situé, générique | règle | aucun | oui | reconnaissance de panneau sans aucun support visuel — seule ressource, le nom du panneau |
| `37fe1af42b8d818fb7c9efba6c63d91d` | non situé — catégorie générale (« une intersection »), pas un cas précis | règle | exception décrite (chemin de terre/parking) | oui | configuration générale, pas une scène précise — accord avec le compteur, à la différence du giratoire déjà documenté |
| `37fe1af42b8d81bd9426eabc80ab4a05` | non situé, générique | règle (barème) | aucun | oui | contenu factuel solide (4 points) ; l'option correcte flaggée `forme/seule-ponctuee` est une phrase complète normale, faux positif sur la forme, pas sur le fond |
| `37fe1af42b8d81d6aef7ff0b8d193d7f` | non situé, générique | règle | aucun | oui | reconnaissance de panneau sans image, jumelle du losange barré du même lot |
| `37fe1af42b8d81fa9debeaf114b7bf77` | **désaccord — situé** (« vous croisez »), déjà documenté en §3 | faire | absolu retiré, faux-ami (carrefour à feux seulement) | oui | scène de conduite claire, déjà documentée en §3 comme faux positif du compteur — confirmé |
| `700316a2fd86db7d682be208673c92d5` | non situé, générique — question de fonction d'un dispositif | règle | aucun | oui | question de fonction (à quoi sert le sas), forme cohérente avec son objet |
| `b433eefe7ea3ce149e6d6dd09e958a00` | non situé, générique — décrit un dispositif, pas une scène vécue | règle | distracteur nommant une règle étrangère (droite au rouge après arrêt, hors de France) | oui | contenu récent et pointu (panonceau M12, 2012), forme de rappel de dispositif cohérente |
| `defefbae1ae651a95dd247e38524ee36` | non situé, générique (barème) | **désaccord avec le compteur `forme/definitionnel`** — règle, pas action | aucun | oui | « fait perdre » est hors du lexique du compteur ; l'objet réel est un barème, pas une décision — même mécanisme que les quatre cartes de `Vitesse` plus loin dans ce rapport |
| `e0f68dd1324f9a5ffaab945a3d59e197` | non situé — événement générique (« un véhicule »), pas « vous » | règle | faux-ami (priorité à droite ne s'applique pas ici) | oui | décrit un événement précis (sortie de parking) mais à la 3ᵉ personne générique, sans « vous » — plus faible que les cartes qui impliquent directement le candidat |

**Ce que la lecture a vu et que les compteurs n'ont pas vu :** les 18 cartes non illustrées
du domaine sont **toutes** flaggées `forme/hors-situation` (les 8 illustrées, aucune) — dans
ce lot, l'illustration est le seul facteur qui change le verdict du compteur, jamais son
texte. Sur ces 18, trois sont en désaccord avec ma lecture, toutes trois déjà documentées en
§3 comme faux positifs connus (giratoire « vous n'avez pas la priorité », feu/panneau
contradictoires, croisement d'une voie de tramway — confirmées ici). Les quinze autres
cartes non illustrées sont bien non situées à la lecture, dont deux qui avaient d'abord paru
en désaccord avant relecture : `09f18973…` (« hors d'une intersection réglée » pose une
condition générale — même construction que « En zone bleue, vous devez : », exclue en §3 :
une condition n'est pas un moment) et `02f7d6a6…` (« sur l'anneau, votre » place un lieu et
une règle de geste, pas un moment précis). Les treize cartes restantes décrivent des
catégories générales (« un rond-point qu'aucun panneau n'annonce », « une intersection sans
aucune signalisation ») ou des
événements à la 3ᵉ personne générique (« un véhicule qui sort d'un parking », « un véhicule
prioritaire … ») plutôt qu'une scène où le candidat est placé — la nuance entre ces deux
formes n'est pas mécanisable, mais elle est réelle : une carte à la 3ᵉ personne générique
reste, à mes yeux, moins ancrée qu'une carte à « vous » même sans verbe de déplacement.

**Ce que les compteurs ont signalé à tort :** `forme/seule-ponctuee` sur l'option correcte de
`37fe1af42b8d81bd9426eabc80ab4a05` (« De marquer un arrêt complet, puis de céder ») — une
phrase complète et normale, pas un défaut de forme ; le compteur mesure l'absence de
ponctuation finale, pas une brièveté suspecte.

### Vitesse (22 cartes)

| id | ancrage | objet | piège | se poserait à l'examen ? | motif |
|---|---|---|---|---|---|
| `07ef459de55adcb501694169428ffd72` | image isolée (disque seul) | règle | distinction max/min/conseillée, faux-ami de sens | non | reconnaissance de panneau classique, contenu solide, mais forme ancien modèle — celle qu'OBS-16 dit remplacée |
| `37fe1af42b8d815ba42acef16b3119a8` | situé — « cette voie » + scène d'autoroute décrite | règle (un plafond légal, énoncé comme limite d'une scène) | seuil chiffré précis (80 km/h), condition (beau temps, circulation fluide) | oui | scène autoroutière concrète correctement reconnue comme telle ; le chiffre exact est la règle même — forme légitime sur ce contenu |
| `3adc294978b6ac1f640c45e121a0e4f5` | image isolée | règle | paire d'inverses (fin de limitation / limitation) parmi les distracteurs | non | reconnaissance de panneau, distinction solide, mais forme ancien modèle — celle qu'OBS-16 dit remplacée |
| `ed0e45e08fb4f47007934da587b5757c` | situé — « vous fait entrer dans » (verbe de mouvement) | règle (portée zonale), animée par un effet de franchissement | distinction portée zonale/linéaire (rues sécantes) | oui | la formulation en action de franchissement anime une carte autrement définitionnelle — bon compromis sur un contenu à portée complexe |
| `04182c9bbdeb305e21532f9c6913a2a2` | non situé, générique (barème) | **désaccord avec le compteur `forme/definitionnel`** — règle, pas action | seuil chiffré précis (paliers de 10 km/h), déséquilibre de longueur signalé (+3, sous le seuil dur) | oui | « fait perdre » est un verbe de conséquence absent du lexique du compteur (est/sont/sert à/signifie/indique/impose/doit être/permet de) ; l'objet réel est pourtant un barème, pas une décision |
| `14eb253e5dc55f5633de9263f541bf91` | non situé, générique | **désaccord — règle, pas action** | seuil chiffré précis, absence de retrait devenue la bonne réponse (contre-intuitif) | oui | même mécanisme que la carte précédente : « fait perdre » hors lexique du compteur, objet pourtant définitionnel |
| `25390f0f30dbb6402091dc226d63db35` | non situé — « à l'approche d'un chantier » énonce une condition, pas une scène | règle (la vitesse à tenir) | aucun | oui | exactement la construction exclue en §3 (« à l'approche de » + règle) : une condition n'est pas un moment — accord avec le compteur |
| `337bfcb4d034b62de5fe0d77ca0cb0a0` | non situé, générique | règle (qualification juridique) | absolu implicite (dès la première fois, sans récidive), faux-ami avec l'ancien régime | partiel | seule carte du lot à dater explicitement l'entrée en vigueur dans l'énoncé même (« Depuis fin 2025 ») — une marque de fraîcheur utile au produit, mais étrangère au style des 24 questions du spécimen, qui ne datent jamais leur propre règle |
| `37fe1af42b8d812c957fc3415785f6d6` | non situé, générique | règle (chiffre-règle : la règle **est** le nombre) | seuil chiffré, quatre valeurs voisines (10/20/30/50) | oui | la règle testée est un chiffre (20 km/h) : la forme définitionnelle est ici la forme juste, comme l'anticipe la consigne — pas un défaut |
| `37fe1af42b8d81589410cd055e66efc2` | non situé, générique | règle (chiffre-règle) | exception réelle citée en option (70 km/h), pas un distracteur inventé | oui | même cas que la zone de rencontre — chiffre-règle, forme définitionnelle appropriée |
| `37fe1af42b8d816b8bf5d51c4f78466c` | non situé — « Vous dépassez de 30 km/h… » est un excès chiffré, pas une scène (cas déjà examiné et écarté en §3) | **désaccord — règle (barème), pas action**, malgré la 2ᵉ personne | seuil chiffré précis | oui | « Combien de points perdez-vous ? » interroge le barème, pas une décision, malgré la 2ᵉ personne ; « perdez » est hors du lexique du compteur définitionnel |
| `37fe1af42b8d817994d5f81863c7e6ae` | non situé, générique | règle (chiffre-règle) | nuance locale (90 sur décision départementale), faux-ami de généralisation | oui | chiffre-règle avec nuance territoriale réelle, forme appropriée |
| `37fe1af42b8d817a9111e3d52f9e5142` | non situé, générique | **désaccord — règle (barème), pas action** | seuil chiffré, absence de gradation au-delà du seuil (contre-intuitif) | oui | « entraîne un retrait de » est hors du lexique du compteur définitionnel, l'objet est pourtant un barème pur |
| `37fe1af42b8d818da27dc338f75795fe` | non situé, générique (condition météo, pas une scène précise) | règle (chiffre-règle) | paliers de réduction (10-20 km/h selon réseau), faux-ami de généralisation | oui | chiffre-règle conditionné par la météo, forme cohérente avec un contenu par nature numérique |
| `37fe1af42b8d819e9620e4637f95e464` | non situé, générique | règle (chiffre-règle) | aucun | oui | chiffre-règle simple, forme cohérente |
| `37fe1af42b8d81d0bf26d67c5f0ff047` | non situé, générique, mais à la première personne (« puis-je ») | règle (chiffre-règle) | aucun | oui | seule carte du lot à la première personne (« puis-je »), un registre du spécimen (OBS-1, 21/24 à la 1ʳᵉ personne) que ce lot pratique rarement ailleurs |
| `37fe1af42b8d81f9ae87db1419280902` | non situé, générique | règle (chiffre-règle) | seuil chiffré (50 m) précis, option indûment restreinte (« agglomération seulement ») | oui | chiffre-règle conditionné, forme appropriée |
| `61eed52d453ac9d8ab59af70dae8eb3e` | non situé, générique, mais à la 2ᵉ personne (« vous ne dépassez pas ») | règle (un plafond légal, pas une décision) | faux-ami (abattement systématique plutôt qu'un plafond) | oui | formulation à la deuxième personne, plus proche du registre du spécimen que la plupart des cartes du lot, malgré l'absence de scène |
| `87c63a1be4e005f6c846d7798756696f` | non situé, générique, 2ᵉ personne | règle | faux-ami (abattement systématique) | oui | jumelle de la carte précédente, même registre, même plafond testé sur un réseau différent |
| `cac0f9db162887802d4fb15ba97d768f` | non situé — comparaison entre deux catégories, pas une scène | règle (nature comparative, pas une portée simple) | paire d'inverses assumée sur l'exclusivité (§2), quatre options isolant chacune un trait | non | seule carte du lot (et l'une des rares de tout l'échantillon lu) à comparer deux dispositifs plutôt que d'interroger une règle ou une scène unique — une forme sans équivalent dans le spécimen, ce qui est la définition même du « non » |
| `f7370daabea929065f6b2586ca3eea91` | non situé, générique | règle (chiffre-règle) | nuance fine (nombre de voies, pas largeur), faux-ami de critère | oui | chiffre-règle avec un critère fin et réel, forme appropriée |
| `fed604fe7c4b8b3b96adc066a7902138` | non situé, générique | règle (chiffre-règle) | critère distinctif (terre-plein vs nombre de voies), faux-ami de critère, jumelle de la précédente | oui | même forme appropriée à un contenu chiffré |

**Ce que la lecture a vu et que les compteurs n'ont pas vu :** le compteur `forme/
definitionnel` ne compte que 8/22 (36 %) sur ce domaine — à peine en dessous de la moyenne
globale (94/255, 37 %), ce qui **ne confirme pas** l'attente énoncée en tête de tâche
(« devrait être élevé ») si l'on s'en tient au chiffre du compteur seul. Mais son lexique fixe (est/sont/sert à/signifie/indique/impose/
doit être/permet de) ne couvre ni « fait perdre », ni « entraîne un retrait de », ni
« Combien de points perdez-vous ? » — la famille des cartes de barème par point, propre à
ce domaine. En objet réel (ce que demande la carte : un fait de barème, pas une décision),
quatre cartes de plus sont définitionnelles à la lecture (`04182c9b…`, `14eb253e…`,
`37fe1af42b8d816b8bf5d51c4f78466c`, `37fe1af42b8d817a9111e3d52f9e5142`) : 12/22 (55 %),
nettement au-dessus de la moyenne — l'attente se vérifie, mais sur un ensemble de cartes
différent de celui que le compteur peut nommer. La même famille lexicale manque aussi deux
cartes du domaine Priorités & intersections lues plus haut (`2a9e02b9…`, `defefbae…`), donc
ce n'est pas un artefact isolé à Vitesse. Par ailleurs, `25390f0f…` (« à l'approche d'un
chantier ») **n'est pas** un faux négatif de `forme/hors-situation`, contrairement à ce
qu'une première lecture en avait conclu : c'est exactement la construction que §3 exclut
(« à l'approche de » + règle) — une condition, pas une scène ; le compteur a raison de la
classer non située.

**Ce que les compteurs ont signalé à tort :** rien à ajouter aux faux positifs déjà
répertoriés en §3 (les cartes citant « puis-je », « vous dépassez », « vous ne dépassez
pas » restent correctement non-situées sur l'axe Ancrage — seul l'axe Personne y voit une
première ou deuxième personne, ce que `forme/impersonnel` ne flagge d'ailleurs pas pour
elles).

### Distances & freinage (21 cartes)

Domaine sans aucune carte illustrée (0/21) : le levier principal du lot 1 — pictogramme isolé
contre OBS-16 — est structurellement indisponible ici. La quasi-totalité du contenu est un
fait physique de sécurité (temps de réaction, distance de freinage, adhérence) que OBS-7
range explicitement dans « conséquence ou mécanisme », une des trois catégories que porte le
paragraphe de réponse du spécimen sur 24 questions.

| id | ancrage | objet | piège | se poserait à l'examen ? | motif |
|---|---|---|---|---|---|
| `37fe1af42b8d8104b119f947eb9e296d` | non situé, générique | règle (mécanisme : distance parcourue pendant le temps de réaction) | seuil chiffré (14 m) proche d'un distracteur qui en est la moitié (7 m) | oui | fait physique de sécurité retenu par la Sécurité routière — mécanisme attesté par OBS-7, pas une définition de signe ni une scène |
| `37fe1af42b8d811f9954e63cf1aa9ffa` | non situé, générique | procédé de calcul mental (un facteur multiplicateur), pas une règle de circulation | seuil chiffré, valeurs voisines (2/3/5/10) | non | aucune des 24 questions du spécimen n'a cette forme : OBS-7 classe les 24 paragraphes de réponse en décision, conséquence ou mécanisme, jamais en méthode de calcul mnémotechnique — cette carte teste l'astuce de calcul elle-même, pas le fait de sécurité qu'elle sert à retrouver |
| `37fe1af42b8d812c9bb4e393d72d6df0` | non situé, générique | règle (mécanisme : la loi du carré de la vitesse) | seuil chiffré (×4) proche de distracteurs (×2, ×3, ×8) | oui | même famille que la carte précédente, mais énonce directement la relation physique plutôt qu'une méthode pour la retrouver — mécanisme attesté par OBS-7 |
| `37fe1af42b8d812db558cb9e19e11709` | non situé, générique | règle (chiffre-règle : seuil légal, R412-12) | seuil chiffré (2 s) proche de distracteurs (1/3/4 s) | oui | rappel de seuil légal, forme standard de rappel chiffré |
| `37fe1af42b8d815a8de7c20835afd6ac` | non situé, générique | règle (mécanisme : conversion secondes → mètres à vitesse donnée) | seuil chiffré (72 m) proche d'un distracteur qui confond avec la distance d'arrêt complète (130 m, environ le double) | oui | fait physique dérivé d'une règle légale, mécanisme attesté par OBS-7 |
| `37fe1af42b8d817eb292c10d8effbad4` | non situé, générique | règle (mécanisme : composition réaction + freinage) | quatre options isolant chacune un facteur (réaction seule, formule au carré, freinage seul, la somme correcte) | oui | décomposition d'un mécanisme de sécurité, contenu attesté par OBS-7 (« conséquence ou mécanisme ») — à la différence de `cac0f9db…` (`Vitesse`), ce n'est pas la comparaison de deux dispositifs distincts, mais la décomposition d'un seul |
| `37fe1af42b8d81e48a72e74c9a2454a2` | non situé — condition météo (« sur sol mouillé »), pas une scène précise | règle (mécanisme : effet de l'eau sur l'adhérence) | faux-ami (croire que l'ABS compense l'adhérence, ou que l'eau refroidit les freins) | oui | condition générale suivie d'un effet, même construction que les cartes chiffre-règle conditionnées par la météo dans `Vitesse` |
| `37fe1af42b8d81e7a041ff53b8ef69c2` | non situé, générique | règle (barème : amende, points, suspension possible) | seuil de gravité (contravention simple contre peine complémentaire non automatique) | oui | contenu de sanction standard, correctement repéré par `forme/definitionnel` (« est sanctionné par ») |
| `37fe1af42b8d81e98af3c07ec3728454` | non situé, générique | règle (mécanisme : moyenne retenue par la Sécurité routière) | seuil chiffré (1 s) proche de distracteurs (0,5/2/3 s) | oui | fait physique de sécurité, mécanisme attesté par OBS-7 |
| `37fe1af42b8d81ef84ffe4578802422a` | non situé — « au volant » générique, pas une scène (cas déjà exclu en §3) | règle (conséquence : effet sur le temps de réaction) | faux-ami (croire que seul le freinage est allongé, ou que la prudence compense) | oui | rappel de conséquence, contenu attesté par OBS-7 (« conséquence »), accord avec le compteur sur l'ancrage |
| `8ddd0cebb28376040af43feb6f52c098` | non situé, générique | règle (mécanisme : pourquoi la loi choisit les secondes plutôt que les mètres) | faux-ami (croire qu'un seuil en mètres serait plus simple à contrôler) | oui | justifie un choix de rédaction de la règle, mais le contenu testé reste le mécanisme lui-même (la distance croît avec la vitesse), attesté par OBS-7 — à la différence de la carte 2, ce n'est pas une méthode de calcul mais l'explication d'un mécanisme |
| `f376d218b64a41796d6efebc8ad0bb2d` | non situé, générique (catégorie de véhicules : poids lourds hors agglomération) | règle (chiffre-règle : plancher en mètres, R412-12 II) | seuil chiffré (50 m) proche de distracteurs (7 m, une longueur de semi-remorque) | oui | rappel de seuil légal pour un cas particulier, forme standard |
| `9f0fe6e809948a327c918ac0b5987cf9` | non situé — condition d'équipement (« sur un véhicule à ABS »), pas une scène | faire (technique : maintenir la pression) | faux-ami (pomper la pédale, technique pré-ABS) | oui | décision technique de conduite, forme attestée par OBS-7 (13/24 = décision) |
| `4ade42a7e2c69ec43159940235d08c5f` | non situé — condition de conduite (« en aquaplanage »), pas une scène | faire (réaction : lever le pied) | faux-ami (freiner fort, braquer, accélérer — trois réflexes dangereux) | oui | décision face à un aléa de conduite, forme de décision attestée par OBS-7 |
| `a225e45864e11748d6175d67476529d0` | **désaccord avec le compteur `forme/hors-situation`** — situé (scène : insertion sur autoroute depuis une bretelle) | faire (céder le passage) | faux-ami (croire l'autoroute prioritaire, ou pouvoir s'arrêter sur la bretelle) | oui | scène de conduite précise (« en vous insérant… vous »), manquée par le compteur car le verbe est un gérondif (« insérant »), absent des sept verbes listés |
| `aad60a7453493cc6716b731af7579ebc` | non situé, générique | règle (barème : contravention légère, sans point) | faux-ami (confondre avec la sanction, bien plus lourde, de la circulation sur BAU — jumelle de la carte suivante) | oui | contenu de sanction, forme standard |
| `a4f04a8078a925fbc8c5df10f063e065` | non situé, générique | règle (barème : infraction lourde, 135 € et 3 points) | faux-ami (confondre avec le simple arrêt sur BAU, bien plus léger) | oui | jumelle de la carte précédente, même mécanisme de contraste |
| `0e85e6a79127a2bae73abcc119e278bd` | non situé, générique | **désaccord avec le compteur `forme/definitionnel`** — règle (qualification pénale : délit contre contravention) | seuil de gravité (récidive dans l'année suivant une condamnation définitive → délit), condition temporelle précise | oui | « constitue » est hors du lexique du compteur (est/sont/sert à/signifie/indique/impose/doit être/permet de) ; l'objet réel est une qualification juridique, même mécanisme de lexique que les 13 cartes de barème identifiées en §3, mais sur un mot différent |
| `22e6420e179103f65f7935f717521189` | **désaccord avec le compteur `forme/hors-situation`** — situé (scène : sortie de tunnel par vent latéral) | faire (technique : ralentir avant la sortie) | faux-ami (accélérer pour « passer vite » la zone exposée) | oui | scène de conduite précise (« vous sortez… vous »), manquée par le compteur car « sortez » est absent des sept verbes listés — même angle mort que la carte `a225e458…` |
| `36d598b80e93b695b2994fce6172eb50` | non situé — condition météo (« chaussée enneigée ou verglacée »), pas un moment précis | faire (technique : espacer, sans geste brusque) | faux-ami (croire que des pneus hiver suffisent à eux seuls) | oui | condition générale plutôt qu'un moment — accord avec le compteur, à la différence des deux cartes précédentes où un verbe à la 2e personne situe un instant |
| `2362d0ebc53cb6de0732afe1747e9b58` | non situé, générique | règle (repère au sol pour une distance déjà fixée par la loi) | seuil chiffré (deux bandes) proche de distracteurs (une, trois bandes, un vide) | oui | rappel d'un repère pratique d'enseignement, distinct de la règle elle-même (l'explication le dit : « un repère d'enseignement… pas une règle du code ») |

**Ce que la lecture a vu et que les compteurs n'ont pas vu :** ce domaine est le premier du
chantier sans aucune carte illustrée (0/21) — le ressort principal du lot 1 (pictogramme
isolé contre OBS-16) ne peut donc mécaniquement produire aucun « non » ici, et il n'en
produit aucun : le seul « non » du domaine (`37fe1af42b811f99…`) vient d'un mécanisme
entièrement différent — une astuce de calcul mental, jamais un pictogramme — justifié par la
taxonomie même d'OBS-7 (décision/conséquence/mécanisme), qui ne prévoit aucune case pour une
méthode de calcul. Deux scènes réelles (`a225e458…`, `22e6420e…`) sont manquées par
`forme/hors-situation` sur un mécanisme déjà connu (le verbe qui situe la scène n'est pas
dans les sept listés par le compteur — ici un gérondif et un verbe de sortie, ni l'un ni
l'autre déjà cité en §3) : ce sont deux instances nouvelles du même angle mort, propres à ce
domaine. Une carte (`0e85e6a7…`) échappe à `forme/definitionnel` sur un mot différent des 13
cartes de barème déjà recensées en §3 — « constitue » plutôt que « fait perdre »/« entraîne
un retrait de » — ce qui montre que le lexique du compteur est étroit au-delà du seul angle
mort du barème par points.

**Ce que les compteurs ont signalé à tort :** rien à ajouter aux faux positifs déjà
répertoriés en §3 sur ce domaine ; les trois désaccords ci-dessus sont des cartes que le
compteur classe *hors situation* ou *non définitionnelles* alors qu'elles le sont, jamais
l'inverse.

### Mécanique & environnement (20 cartes)

Domaine quasi sans illustration (1/20), et le contenu recoupe directement deux thèmes que le
spécimen déclare lui-même : « Connaître les principaux organes du véhicule » (Q22),
« Connaître les principaux équipements du véhicule » (Q23), et « Conduite écologique et
respectueuse de l'environnement » (Q17) — un recoupement textuel plus direct qu'ailleurs dans
ce chantier, puisque ces trois libellés du spécimen correspondent presque mot pour mot au
`topic` du domaine.

| id | ancrage | objet | piège | se poserait à l'examen ? | motif |
|---|---|---|---|---|---|
| `37fe1af42b8d81139920e49f3f7b6b59` | non situé, générique | règle (connaissance d'un organe du véhicule) | faux-ami (confondre avec la dimension, la pression recommandée, la marque) | oui | connaissance des organes du véhicule — thème directement attesté par le spécimen (Q22) |
| `37fe1af42b8d81209e09c493195df716` | non situé, générique | règle (code couleur des témoins) | faux-ami (confondre avec un entretien à programmer ou une info de confort) | oui | même thème (Q22), code couleur des témoins — connaissance d'organe/équipement |
| `37fe1af42b8d8123abc0da9b2b7a51e0` | non situé, générique | règle (fonction d'un dispositif administratif) | faux-ami (confondre avec l'assurance, le contrôle technique, le télépéage) | oui | thème directement attesté par le spécimen (Q17) |
| `37fe1af42b8d814289adf64bd5b05d0e` | non situé, générique | règle (liste fermée d'équipements obligatoires) | faux-ami (extincteur, éthylotest — jamais ou plus obligatoires) | oui | thème directement attesté (Q23) |
| `37fe1af42b8d814ba731d0f9dafb6945` | non situé — condition de conduite (« sur une longue descente »), pas une scène | faire (technique : rétrograder) | faux-ami (point mort, qui fait perdre le frein moteur ; couper le contact, qui fait perdre la direction assistée) | oui | décision technique de conduite, forme attestée par OBS-7 |
| `37fe1af42b8d8158a15ac34f4b0e4be9` | non situé, générique | règle (liste des niveaux à surveiller) | option qui isole un seul niveau comme « vraiment critique » (le carburant) | oui | connaissance d'entretien, même thème que les organes du véhicule (Q22) |
| `37fe1af42b8d81b99c05ef1ffdacc30e` | non situé, générique | règle (code couleur des témoins) | faux-ami (confondre orange et rouge sur l'urgence de la réaction) | oui | jumelle de `37fe1af42b8d81209e…`, même thème |
| `37fe1af42b8d81c89e88db8c08ca8514` | non situé, générique | **désaccord avec le compteur `forme/definitionnel`** — règle (définition de l'éco-conduite) | faux-ami (vitres ouvertes contre climatisation, présenté à tort comme une règle fixe) | oui | « consiste à » est hors du lexique du compteur (est/sont/sert à/signifie/indique/impose/doit être/permet de) ; thème directement attesté par le spécimen (Q17) |
| `37fe1af42b8d81deaec0cb8830fa0b25` | non situé, générique | règle (chiffre-règle : seuil légal 1,6 mm) | seuil chiffré proche de distracteurs (0,5/3/5 mm) | oui | connaissance d'équipement (Q22/23), forme de rappel chiffré standard |
| `37fe1af42b8d81f4b915cd58b951d9e4` | non situé, générique | règle (méthode de contrôle : à froid) | faux-ami (croire qu'à chaud la mesure reste valable) | oui | connaissance d'entretien (Q22) |
| `cc10180c491d12311f76fc1d4d98ff45` | non situé, générique | **désaccord avec le compteur `forme/definitionnel`** — règle (chiffre-règle : échéance réglementaire) | seuil chiffré (4 ans) proche de distracteurs (3 et 5 ans) | oui | « a lieu » est hors du lexique du compteur ; contenu réglementaire standard sur le véhicule |
| `4477774964dae6e5d1bac49b5a37f3a8` | non situé — condition saisonnière et administrative (« commune soumise à l'obligation »), pas une scène | **désaccord avec le compteur `forme/definitionnel`** — règle (ce qui satisfait l'obligation) | faux-ami (croire qu'un seul pneu hiver par essieu suffit) | oui | « suffisent » est hors du lexique du compteur — même mécanisme de lexique étroit que les deux cartes précédentes, sur un troisième verbe |
| `8e64074daad0e4a72e0fea2da9bac8eb` | non situé, générique | règle (liste fermée d'exceptions, R412-1) | faux-ami (la grossesse déclarée, absente de la liste légale) | oui | connaissance réglementaire, forme de rappel d'exception standard |
| `089e9b57f57bbb155f81da3ec492082f` | non situé, générique | règle (chiffre-règle : seuil d'âge, R412-2) | seuil chiffré (10 ans) proche de distracteurs (4/7 ans, 1,35 m) | oui | connaissance réglementaire sur l'équipement enfant |
| `eac980f55eb23bfd3b1612f506fb81a3` | non situé, générique | règle (condition : airbag désactivé) | faux-ami (croire l'airbag protecteur pour un enfant dos à la route) | oui | connaissance d'équipement de sécurité, forme standard |
| `6c9b9395e9090cd97a7fc4062b7162fc` | non situé, générique | règle (emplacement requis, R416-19) | faux-ami (le coffre, qui s'ouvre trop tard et souvent du mauvais côté) | oui | thème équipement (Q23) |
| `2c0a147d9ba6e61b52c7639089b6f118` | semi-situé — scène réelle (chargement débordant photographié), mais vue de l'extérieur du véhicule, pas du poste de conduite | règle (limite légale de débord, R312-21) | seuil chiffré (3 m) contre un distracteur qui contredit l'image elle-même (« rien ne dépasse de ce côté ») | oui | seule carte illustrée du domaine : une scène réelle et concrète, pas un pictogramme abstrait — plus proche de l'esprit de la réforme que les panneaux isolés d'autres domaines, même si la vue n'est pas depuis le poste de conduite |
| `173c63baae24d7e7db9e2961bebd033f` | non situé, générique | règle (chiffre-règle : seuil administratif du permis B) | seuil chiffré (4 250 kg) proche de trois distracteurs voisins | oui | connaissance réglementaire standard |
| `526d6b502e05eefba3f2066af4c2ab8d` | non situé, générique | règle (mécanisme : traînée aérodynamique) | faux-ami (croire que seul le poids ajouté compte) | oui | mécanisme physique attesté par OBS-7, même famille que les cartes de mécanique de `Distances & freinage` |
| `204454d0e329d40811d4317fabf2ddfa` | non situé, générique | règle (obligation de traitement des déchets dangereux, L541-2) | faux-ami (tri sélectif ordinaire, ferrailleur non agréé) | oui | thème directement attesté (Q17, écologie) |

**Ce que la lecture a vu et que les compteurs n'ont pas vu :** ce domaine ne produit aucun
« non » ni « partiel », et ce n'est pas un relâchement du critère mais la conséquence de deux
faits structurels vérifiables : une seule carte sur vingt porte une illustration (`2c0a147d…`),
et cette illustration montre une scène réelle (un chargement photographié qui déborde), pas un
pictogramme isolé — le seul autre lot de ce chantier avec une part illustrée aussi faible
(`Distances & freinage`, 0/21) produit lui aussi zéro « non » sur ce seul motif. Par ailleurs,
trois thèmes du spécimen (Q17, Q22, Q23) recoupent le `topic` de ce domaine presque mot pour
mot, ce qui n'est vrai d'aucun autre domaine lu jusqu'ici. Trois cartes (`37fe1af42b8d81c89e…`,
`cc10180c…`, `4477774964d…`) échappent à `forme/definitionnel` sur trois verbes distincts
(« consiste à », « a lieu », « suffisent »), tous absents du lexique du compteur — un lexique
déjà connu pour manquer les 13 cartes de barème (§3) et les deux verbes trouvés dans le
tableau de `Distances & freinage` ci-dessus (« constitue ») ; ce domaine en ajoute trois
nouveaux en vingt cartes, la plus forte densité de ce type de désaccord rencontrée dans ce
chantier.

**Ce que les compteurs ont signalé à tort :** rien à ajouter aux faux positifs déjà
répertoriés en §3 sur ce domaine ; les trois désaccords ci-dessus sont des cartes que le
compteur classe *non définitionnelles* alors qu'elles le sont, jamais l'inverse.

