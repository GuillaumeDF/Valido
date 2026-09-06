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

**Ce que le critère n'a jamais pu tester : le registre.** Sur les 135 cartes lues à ce stade
(`Panneaux & marquage`, `Priorités & intersections`, `Vitesse`, `Distances & freinage`,
`Mécanique & environnement`, `Feux`), la première clause du critère (« aucune des 24
questions du spécimen n'a cette forme ») n'a fondé un verdict que quatre fois — `7d44f7dd…`
(objet absent de l'image), `37fe1af42b8d817da9…` (abstraction hiérarchique sans cas concret),
`cac0f9db…` (comparaison de deux dispositifs), `37fe1af42b8d811f9…` (méthode de calcul
mental) — toujours sur une bizarrerie structurelle, jamais sur un registre. L'axe Personne,
lui, n'a jamais fondé un seul verdict : sa seule occurrence dans toute la section 4
(`37fe1af42b8d81d0bf26d67c5f0ff047`, `Vitesse`) *loue* une carte d'avoir le registre du
spécimen (« puis-je », OBS-1) plutôt que de faire défaut à celles qui ne l'ont pas.

Ce n'est pas un oubli de la lecture : c'est une limite du corpus. Aucune des trois strates ne
porte l'énoncé littéral d'une question du spécimen — §1 le dit dès son avertissement
d'ouverture : la colonne « Personne (§ réponse) » qu'OBS-1 et OBS-2 mesurent est le
paragraphe qui reconstruit la réponse et le commentaire pédagogique qui la suit, tous deux
déclarés distincts de « la question telle qu'elle est lue par le candidat ». Conclure « ce
prompt est impersonnel, donc inadmissible » ferait dire au corpus plus qu'il ne peut établir —
exactement ce que §1 interdit. `forme/impersonnel` (199/255 cartes) reste donc, ici comme
dans les lectures à venir, un **descripteur**, jamais un critère d'admissibilité.

**Ce que le critère n'a jamais pu tester non plus : la forme des options.** OBS-4 le dit dès
la strate 1 : « le PDF ne montre ni l'énoncé ni les propositions elles-mêmes » — le nombre
même de propositions (quatre, A à D) y est déduit, jamais observé. Un verdict qui reposerait
sur « aucune des 24 questions du spécimen n'a cette structure d'options » ferait donc
l'inverse exact de ce que le critère autorise : conclure d'un silence plutôt que d'une forme
absente — un corpus qui ne montre aucune proposition ne peut ni l'attester ni la réfuter. Une
première lecture de `Premiers secours` (tâche 13) l'a fait sur deux cartes dont les quatre
options réordonnent une même liste de trois gestes (Protéger/Alerter/Secourir,
Alerter/Masser/Défibriller) — corrigé en `oui` (Ruling 22, 2026-09-06) : la structure reste
la plus singulière relevée sur les 190 cartes lues à ce stade, mais son inadmissibilité ne
peut pas s'établir contre un corpus qui ne montre aucune proposition.

Ce n'est pas un oubli de la lecture : c'est une limite du corpus, la seconde après le
registre. La première (ci-dessus) porte sur le `prompt` — mesurable, mais distinct de
l'énoncé littéral du spécimen ; celle-ci porte sur les options — ni mesurables, ni même
observées. Ensemble, elles disent ce que le critère ne pourra jamais trancher : le registre
du prompt, et la forme des propositions.

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

Domaine quasi sans illustration (1/20), et le contenu recoupe le **sujet** de trois thèmes
que le spécimen déclare lui-même : « Connaître les principaux organes du véhicule » (Q22),
« Connaître les principaux équipements du véhicule » (Q23), et « Conduite écologique et
respectueuse de l'environnement » (Q17) — un recoupement de sujet plus direct qu'ailleurs
dans ce chantier, puisque ces trois libellés du spécimen correspondent presque mot pour mot
au `topic` du domaine. **Ce recoupement ne porte que sur le sujet, jamais sur la forme** :
OBS-1 enregistre les paragraphes de réponse de Q17/Q22/Q23 comme étant à la première
personne, quand les prompts justifiés ci-dessous contre eux sont impersonnels — « Le témoin
d'usure d'un pneu indique : » partage un sujet avec ces questions, pas un registre (voir le
constat de registre ajouté en tête de la section 4). Les motifs concernés le disent
maintenant en toutes lettres.

| id | ancrage | objet | piège | se poserait à l'examen ? | motif |
|---|---|---|---|---|---|
| `37fe1af42b8d81139920e49f3f7b6b59` | non situé, générique | règle (connaissance d'un organe du véhicule) | faux-ami (confondre avec la dimension, la pression recommandée, la marque) | oui | connaissance des organes du véhicule — sujet attesté par le spécimen (Q22), pas la forme : Q22 est à la première personne (OBS-1), ce prompt est impersonnel |
| `37fe1af42b8d81209e09c493195df716` | non situé, générique | règle (code couleur des témoins) | faux-ami (confondre avec un entretien à programmer ou une info de confort) | oui | même sujet (Q22), pas la forme — code couleur des témoins, connaissance d'organe/équipement |
| `37fe1af42b8d8123abc0da9b2b7a51e0` | non situé, générique | règle (fonction d'un dispositif administratif) | faux-ami (confondre avec l'assurance, le contrôle technique, le télépéage) | oui | sujet attesté par le spécimen (Q17), pas la forme — même réserve que la carte précédente |
| `37fe1af42b8d814289adf64bd5b05d0e` | non situé, générique | règle (liste fermée d'équipements obligatoires) | faux-ami (extincteur, éthylotest — jamais ou plus obligatoires) | oui | sujet attesté (Q23), pas la forme |
| `37fe1af42b8d814ba731d0f9dafb6945` | non situé — condition de conduite (« sur une longue descente »), pas une scène | faire (technique : rétrograder) | faux-ami (point mort, qui fait perdre le frein moteur ; couper le contact, qui fait perdre la direction assistée) | oui | décision technique de conduite, forme attestée par OBS-7 |
| `37fe1af42b8d8158a15ac34f4b0e4be9` | non situé, générique | règle (liste des niveaux à surveiller) | option qui isole un seul niveau comme « vraiment critique » (le carburant) | oui | connaissance d'entretien, même sujet que les organes du véhicule (Q22), pas la forme |
| `37fe1af42b8d81b99c05ef1ffdacc30e` | non situé, générique | règle (code couleur des témoins) | faux-ami (confondre orange et rouge sur l'urgence de la réaction) | oui | jumelle de `37fe1af42b8d81209e…`, même sujet, pas la forme |
| `37fe1af42b8d81c89e88db8c08ca8514` | non situé, générique | **désaccord avec le compteur `forme/definitionnel`** — règle (définition de l'éco-conduite) | faux-ami (vitres ouvertes contre climatisation, présenté à tort comme une règle fixe) | oui | « consiste à » est hors du lexique du compteur (est/sont/sert à/signifie/indique/impose/doit être/permet de) ; sujet attesté par le spécimen (Q17), pas la forme |
| `37fe1af42b8d81deaec0cb8830fa0b25` | non situé, générique | règle (chiffre-règle : seuil légal 1,6 mm) | seuil chiffré proche de distracteurs (0,5/3/5 mm) | oui | connaissance d'équipement — sujet attesté (Q22/23), pas la forme —, et par ailleurs forme de rappel chiffré standard |
| `37fe1af42b8d81f4b915cd58b951d9e4` | non situé, générique | règle (méthode de contrôle : à froid) | faux-ami (croire qu'à chaud la mesure reste valable) | oui | connaissance d'entretien — sujet attesté (Q22), pas la forme |
| `cc10180c491d12311f76fc1d4d98ff45` | non situé, générique | **désaccord avec le compteur `forme/definitionnel`** — règle (chiffre-règle : échéance réglementaire) | seuil chiffré (4 ans) proche de distracteurs (3 et 5 ans) | oui | « a lieu » est hors du lexique du compteur ; contenu réglementaire standard sur le véhicule |
| `4477774964dae6e5d1bac49b5a37f3a8` | non situé — condition saisonnière et administrative (« commune soumise à l'obligation »), pas une scène | **désaccord avec le compteur `forme/definitionnel`** — règle (ce qui satisfait l'obligation) | faux-ami (croire qu'un seul pneu hiver par essieu suffit) | oui | « suffisent » est hors du lexique du compteur — même mécanisme de lexique étroit que les deux cartes précédentes, sur un troisième verbe |
| `8e64074daad0e4a72e0fea2da9bac8eb` | non situé, générique | règle (liste fermée d'exceptions, R412-1) | faux-ami (la grossesse déclarée, absente de la liste légale) | oui | connaissance réglementaire, forme de rappel d'exception standard |
| `089e9b57f57bbb155f81da3ec492082f` | non situé, générique | règle (chiffre-règle : seuil d'âge, R412-2) | seuil chiffré (10 ans) proche de distracteurs (4/7 ans, 1,35 m) | oui | connaissance réglementaire sur l'équipement enfant |
| `eac980f55eb23bfd3b1612f506fb81a3` | non situé, générique | règle (condition : airbag désactivé) | faux-ami (croire l'airbag protecteur pour un enfant dos à la route) | oui | connaissance d'équipement de sécurité, forme standard |
| `6c9b9395e9090cd97a7fc4062b7162fc` | non situé, générique | règle (emplacement requis, R416-19) | faux-ami (le coffre, qui s'ouvre trop tard et souvent du mauvais côté) | oui | sujet équipement (Q23), pas la forme |
| `2c0a147d9ba6e61b52c7639089b6f118` | semi-situé — scène réelle (chargement débordant photographié), mais vue de l'extérieur du véhicule, pas du poste de conduite | règle (limite légale de débord, R312-21) | seuil chiffré (3 m) contre un distracteur qui contredit l'image elle-même (« rien ne dépasse de ce côté ») | oui | seule carte illustrée du domaine : une scène réelle et concrète, pas un pictogramme abstrait — plus proche de l'esprit de la réforme que les panneaux isolés d'autres domaines, même si la vue n'est pas depuis le poste de conduite |
| `173c63baae24d7e7db9e2961bebd033f` | non situé, générique | règle (chiffre-règle : seuil administratif du permis B) | seuil chiffré (4 250 kg) proche de trois distracteurs voisins | oui | connaissance réglementaire standard |
| `526d6b502e05eefba3f2066af4c2ab8d` | non situé, générique | règle (mécanisme : traînée aérodynamique) | faux-ami (croire que seul le poids ajouté compte) | oui | mécanisme physique attesté par OBS-7, même famille que les cartes de mécanique de `Distances & freinage` |
| `204454d0e329d40811d4317fabf2ddfa` | non situé, générique | règle (obligation de traitement des déchets dangereux, L541-2) | faux-ami (tri sélectif ordinaire, ferrailleur non agréé) | oui | sujet attesté (Q17, écologie), pas la forme |

**Ce que la lecture a vu et que les compteurs n'ont pas vu :** ce domaine ne produit aucun
« non » ni « partiel », et ce n'est pas un relâchement du critère mais la conséquence de deux
faits structurels vérifiables : une seule carte sur vingt porte une illustration (`2c0a147d…`),
et cette illustration montre une scène réelle (un chargement photographié qui déborde), pas un
pictogramme isolé — le seul autre lot de ce chantier avec une part illustrée aussi faible
(`Distances & freinage`, 0/21) produit lui aussi zéro « non » sur ce seul motif. Par ailleurs,
trois thèmes du spécimen (Q17, Q22, Q23) recoupent le `topic` de ce domaine presque mot pour
mot, ce qui n'est vrai d'aucun autre domaine lu jusqu'ici — **un recoupement de sujet, jamais
de forme** : OBS-1 place Q17/Q22/Q23 à la première personne, quand les onze cartes qui s'y
justifient ci-dessus sont impersonnelles ; voir le constat de registre en tête de la section 4
sur pourquoi le corpus ne permet pas de trancher davantage. Trois cartes
(`37fe1af42b8d81c89e…`, `cc10180c…`, `4477774964d…`) échappent à `forme/definitionnel` sur
trois verbes distincts (« consiste à », « a lieu », « suffisent »), tous absents du lexique du
compteur — un lexique déjà connu pour manquer les 13 cartes de barème (§3) et le verbe trouvé
dans le tableau de `Distances & freinage` ci-dessus (« constitue ») ; ce domaine en ajoute
trois nouveaux en vingt cartes, la plus forte densité de ce type de désaccord rencontrée dans
ce chantier.

**Ce que les compteurs ont signalé à tort :** rien à ajouter aux faux positifs déjà
répertoriés en §3 sur ce domaine ; les trois désaccords ci-dessus sont des cartes que le
compteur classe *non définitionnelles* alors qu'elles le sont, jamais l'inverse.

### Feux (19 cartes)

Le lot 1 anticipait ce domaine comme le plus riche en « Ce feu / Ce signal » + pictogramme
isolé après `Panneaux & marquage`. Les trois occurrences de « Ce signal » sur l'ensemble des
255 cartes (vérifié par recherche exacte sur `questions.json`) sont bien toutes dans ce
domaine, mais une seule des trois cartes illustrées est épargnée, et pas au titre de
l'illustration en général : au titre de ce que son image montre.

| id | ancrage | objet | piège | se poserait à l'examen ? | motif |
|---|---|---|---|---|---|
| `37fe1af42b8d81038eabdcd0f319857c` | non situé, générique | règle (obligation d'usage, R412-10) | faux-ami (croire que le clignotant n'est utile qu'en présence d'un autre usager visible) | oui | rappel de règle générale, forme standard |
| `37fe1af42b8d8118ab59f3f1a651bb26` | image isolée — l'alt-text ne décrit que le signal (« vu de face »), aucune route, aucun contexte | règle (signification du signal) | absolu (passage prioritaire) contre une règle nuancée (passage sous réserve de la priorité) | non | image isolée + question de sens (« signifie ») — exactement la forme qu'OBS-16 nomme abandonnée par la réforme ; première des trois cartes « Ce signal » du domaine |
| `37fe1af42b8d81659d11e27049af398e` | non situé, générique | **désaccord avec le compteur `forme/definitionnel`** — règle (barème : 4 points) | seuil chiffré (4) proche de distracteurs (1/2/6) | oui | carte de barème par points de ce domaine, l'une des 13 recensées en §3 comme échappant au lexique du compteur (« fait perdre » hors du lexique) |
| `37fe1af42b8d8189a735d41a796aafb6` | **désaccord avec le compteur `forme/hors-situation`** — situé (moment précis : « à un feu vert »), pas une règle générale | faire (passer sous condition) | absolu (priorité absolue sur les piétons), faux-ami (croire qu'il faut accélérer pour dégager) | oui | moment précis + « vous » elliptique, manqué par le compteur car « à un feu vert » n'est ni un « ce/cette » ni l'un des sept verbes listés — même famille qu'un « À l'approche de… vous devez » déjà rescapé en §3 |
| `37fe1af42b8d8193887bfe48eab17d43` | non situé — condition (nuit, visibilité réduite), pas une scène | règle (obligation conditionnée) | faux-ami (croire l'obligation limitée à l'autoroute ou au jour) | oui | condition suivie d'une règle, même construction que les cartes météo de `Vitesse`, accord avec le compteur |
| `37fe1af42b8d81adbe05ccc6da87aef7` | non situé, générique | règle (fonction d'un dispositif, R416-18) | faux-ami (remerciement, autorisation de stationner) | oui | connaissance réglementaire d'équipement, forme standard |
| `37fe1af42b8d81b1b37feb613e893fbf` | non situé — condition météo, pas une scène | règle (conditions d'usage, R416-7) | faux-ami (forte pluie seule, sans neige ni brouillard) | oui | condition météo suivie d'une règle, accord avec le compteur |
| `37fe1af42b8d81c8af99ca09e3710b01` | **désaccord avec le compteur `forme/hors-situation`** — situé, déjà documenté en §3 comme l'un des cinq exemples trouvés par recherche ciblée | faire (passer en feux de croisement) | faux-ami (garder les feux de route, croyant que la distance suffit) | oui | scène de croisement nocturne déjà confirmée situé en §3 |
| `37fe1af42b8d81df975dea92682dad6c` | semi-situé — l'alt-text montre la route et la voie ferrée, pas seulement le signal isolé, à la différence des deux autres cartes « Ce signal » | règle (arrêt absolu imposé par le signal) | absolu correct (« train visible ou non ») contre un faux-ami de priorité à droite | oui | contrairement aux deux autres cartes « Ce signal » du domaine (jaune clignotant seul, flèche seule sur fond neutre), l'image place le signal dans son contexte réel — route coupée par une voie ferrée — plus proche de la mise en situation que la réforme revendique |
| `37fe1af42b8d81fc9bbbee0a1767bba6` | **désaccord avec le compteur `forme/hors-situation`** — situé (moment précis : « au feu jaune fixe, vous devez ») | faire (s'arrêter, sauf danger) | absolu nuancé (l'exception de sécurité) contre un distracteur qui traite le jaune comme le vert | oui | même angle mort que `37fe1af42b8d8189a…` : « devez » n'est pas dans les sept verbes listés par le compteur |
| `0ac1e53ac8978390a5725830ebcff433` | non situé, générique | règle (hiérarchie : le panneau prime, indépendant du feu) | faux-ami (croire le feu prioritaire sur le panneau) | oui | rappel de hiérarchie, même forme que les cartes de hiérarchie de `Priorités & intersections`, accord avec le compteur |
| `1782eca179c97b4c0294cb40b4938c5c` | image isolée — l'alt-text ne décrit que le boîtier et ses lampes, aucune route, aucun contexte | règle (portée de l'autorisation : direction et prudence) | faux-ami (croire l'autorisation totale, ou confondre avec un stop) | non | image isolée + question de sens (« autorise à ») — exactement la forme qu'OBS-16 nomme abandonnée, troisième carte « Ce signal » du domaine |
| `fc0333a5ae17dd22f31bbbe63d0e8824` | non situé, générique (configuration collective, pas un « vous ») | règle (portée : qui est concerné dans la file) | contre-intuitif (l'obligation ne pèse que sur le dernier véhicule) | oui | contenu réglementaire précis, correctement repéré par le compteur (R416-18) |
| `acaf8b468f86cd92d2b61f93637ff9dd` | non situé, générique — « devant » y a un sens spatial/structurel (le repère par défaut), pas un moment vécu ; **faux positif du compteur `forme/hors-situation`**, qui ne le flague pas à cause du seul mot « devant » | règle (repère par défaut, R412-30) | faux-ami (confondre avec le repère du stop non marqué, 5 m) | oui | rappel de repère légal, généraliste malgré le mot « devant » qui satisfait à tort le motif déictique du compteur |
| `362d572a8e9eb2d2940513b207d2e448` | situé — scène complète (« vous roulez… derrière »), correctement repérée par le compteur | faire (passer en feux de croisement) | contre-intuitif (l'éblouissement vient du rétroviseur du véhicule suivi, pas seulement de face) | oui | carte modèle : scène, décision, sans aucun désaccord avec les compteurs |
| `6012289234e0766392ac505dbfdbd3ae` | non situé — condition météo, pas une scène | règle (cas d'usage autorisés, feux avant, R416-7) | faux-ami (limiter à un seul cas parmi les trois) | oui | condition météo suivie d'une règle, accord avec le compteur — jumelle de `37fe1af42b8d81b1…` (même article, cas symétrique : feux avant contre feux arrière) |
| `d5505e2b6bdcdeb78eecbec2a2a2a724` | **désaccord avec le compteur `forme/hors-situation`** — situé (moment précis : arrêté de nuit sans éclairage public) | règle (ce qu'il faut montrer, R416-12) | faux-ami (confondre avec les feux de détresse ou l'antibrouillard arrière) | oui | scène nocturne précise avec « vous devez », manquée par le compteur (« montrer » hors des sept verbes listés) |
| `a3b1d0cf8c4fde31d009c3924754bfba` | non situé — événement précis à la 3ᵉ personne (« un véhicule »), pas « vous » dans l'énoncé | faire (réaction : ralentir, fixer le bord droit) | faux-ami (l'appel de phares, tentant mais aveuglant en plus) | oui | événement concret décrit à la 3ᵉ personne, la décision elle-même n'apparaît que dans les options — accord avec le compteur, même famille que les cartes analogues de `Priorités & intersections` |
| `1f62ee2f0d02611c04ed79a57b73412a` | **désaccord avec le compteur `forme/hors-situation`** — situé (incident précis : extinction des feux de croisement) | faire (réaction : quitter la chaussée, signaler) | faux-ami (rouler aux feux de détresse, qui n'éclairent rien) | oui | incident vécu à l'instant (« vos deux feux… s'éteignent »), manqué par le compteur car « vos » n'est pas un motif déictique couvert |

**Ce que la lecture a vu et que les compteurs n'ont pas vu :** l'avertissement du lot 1 se
vérifie en partie seulement. Les trois occurrences de « Ce signal » de tout le corpus (255
cartes, vérifié par recherche exacte) sont bien concentrées dans ce domaine, et deux des
trois (`37fe1af42b8d8118ab…`, `1782eca179…`) sont bien la forme qu'OBS-16 nomme abandonnée :
leur alt-text ne décrit que le boîtier du signal, sans route ni contexte, exactement comme
les treize panneaux isolés de `Panneaux & marquage`. Mais la troisième (`37fe1af42b8d81df9…`,
le passage à niveau) échappe à ce verdict pour une raison vérifiable et non discrétionnaire :
son alt-text place le signal dans une scène — une route coupée par une voie ferrée — alors
que les deux autres ne montrent que le boîtier lumineux seul. C'est le même test que celui qui
distinguait déjà, dans `Panneaux & marquage`, les deux panneaux « oui » (`9eb85068…`,
`dce501d4…`, tous deux vus depuis le poste de conduite ou dans une scène de carrefour) des
treize panneaux « non » (disque ou losange seuls) : la présence d'un environnement dans
l'image, pas la présence d'une image tout court. Par ailleurs, ce domaine est riche en scènes
à « vous + verbe non listé » que le compteur manque : cinq cartes (`37fe1af42b8d8189a…`,
`37fe1af42b8d81c8af…` déjà connue de §3, `37fe1af42b8d81fc9b…`, `d5505e2b…`, `1f62ee2f…`)
décrivent un moment précis vécu par le candidat sur des verbes ou des tournures absents des
sept listés par `DEICTIQUE` (devez, montrer, vos + verbe pronominal, un lieu bref comme « à un
feu vert ») — quatre de ces cinq sont des instances nouvelles, non répertoriées dans
l'échantillon de six déjà cité en §3.

**Ce que les compteurs ont signalé à tort :** `acaf8b468f86cd92d2b61f93637ff9dd` n'est PAS
flaggé `forme/hors-situation` alors qu'il n'est pas situé à la lecture — le mot « devant » y a
un sens spatial et structurel (le repère par défaut de l'arrêt), pas un moment vécu, et
satisfait pourtant le motif déictique du compteur. C'est le premier faux positif de ce
compteur rencontré dans ce chantier sur son propre motif (les faux positifs précédents
touchaient `forme/seule-ponctuee`, jamais `forme/hors-situation` lui-même) : une confirmation
concrète de la réserve déjà écrite en §3, où « devant » figure parmi les motifs susceptibles
de sur-déclencher.

### Permis & sanctions (19 cartes)

Domaine sans aucune carte illustrée (0/19), comme `Distances & freinage` et `Mécanique &
environnement` : le seul levier structurel qui produit un « non » ailleurs dans ce chantier —
le pictogramme isolé contre OBS-16 — ne peut donc pas jouer ici. Le contenu est presque
entièrement un barème ou une peine légale (points, amendes, prison, délais administratifs) :
un domaine à échelle de sanction, comme `Vitesse` l'était pour les seuils de vitesse, et le
précédent du lot 1 s'applique tel quel — sur une carte dont la règle **est** un chiffre, une
forme définitionnelle est la forme juste, pas un défaut. Le thème du spécimen le plus proche,
Q7 (« Sensibilisation aux conséquences des infractions au code de la route »), reste un
intitulé générique, pas celui de ce domaine : aucune carte ci-dessous ne s'appuie sur un
rapprochement de sujet avec le spécimen — chaque verdict tient sur la forme (chiffre-règle,
qualification pénale, conséquence) attestée par OBS-7, jamais sur un thème.

| id | ancrage | objet | piège | se poserait à l'examen ? | motif |
|---|---|---|---|---|---|
| `0be9d147f1eba292ca2556f4dd19e51a` | non situé, générique | règle (chiffre-règle : peine, 2 ans + 4 500 €) | contraste de régimes (délit pénal vs barème administratif) parmi les distracteurs | oui | peine pénale attestée par un chiffre, chiffre-règle attesté par OBS-7, correctement repérée par le compteur |
| `2b6972fab03433e709d73ccc5a949ac9` | non situé, générique | règle (chiffre-règle : délai de réattribution, 2 ou 3 ans) | seuil conditionné par la gravité du dossier (délit/contravention 4e-5e classe) | oui | chiffre-règle standard, condition claire sans artefact |
| `2d45cedf9b3d349027d751f7aa672d6a` | non situé, générique | règle (qualification pénale : délit) | confusion contravention/délit, faux-ami de gravité | oui | qualification juridique attestée, forme standard de rappel de sanction |
| `302262003495b5750d28f00caeae3b6b` | non situé, générique | règle (chiffre-règle : peine, 2 ans + 30 000 €) | ancien barème (15 000 €) recyclé en distracteur, aggravations réelles (réunion, cumul) en options voisines | oui | chiffre-règle de sanction, forme standard |
| `37fe1af42b8d8132a22dde248e277c2b` | non situé, générique | **désaccord avec le compteur `forme/definitionnel`** — règle (barème), pas action | seuil chiffré proche de distracteurs (1/6 points/aucun) | oui | « fait perdre » est hors du lexique du compteur — l'une des trois cartes de ce domaine parmi les treize recensées en §3 (téléphone en main) ; l'objet réel est un barème, chiffre-règle attesté |
| `37fe1af42b8d8158b3dbf9883bf83560` | non situé, générique | règle (chiffre-règle : plafond de récupération, 4 points) | seuil chiffré (2/4/6/tous) | oui | chiffre-règle standard, correctement repérée par le compteur |
| `37fe1af42b8d8174b45bd538ca3a9483` | non situé, générique | règle (chiffre-règle : capital initial, 6 points) | valeurs voisines (4/6/8/12) | oui | chiffre-règle simple, forme cohérente |
| `37fe1af42b8d81b6a955d17c158afb3c` | non situé, générique | règle (chiffre-règle : rythme de progression conditionné) | rythme comparé entre deux voies d'apprentissage, condition (aucune infraction depuis le début du probatoire) | oui | chiffre-règle avec condition réelle, costaud mais standard — la voie alternative (hors conduite accompagnée) n'apparaît qu'en distracteur, ce n'est pas une carte de comparaison comme `cac0f9db…` (`Vitesse`) |
| `37fe1af42b8d81b7acdacd2079297f09` | non situé, générique | **désaccord avec le compteur `forme/definitionnel`** — règle (barème), pas action | contre-intuitif (rien pour le conducteur, seul le passager paierait) | oui | « coûte » est hors du lexique du compteur — la deuxième des trois cartes de ce domaine parmi les treize recensées en §3 (défaut de ceinture) ; barème attesté, forme définitionnelle appropriée |
| `37fe1af42b8d81c593b3e0a4cb5bb76d` | non situé, générique | règle (chiffre-règle : durée, 3 ans ou 2 ans en conduite accompagnée) | aucun | oui | chiffre-règle standard |
| `37fe1af42b8d81d09328df58d56a4dc6` | non situé, générique | règle (portée de l'obligation : où et quand l'apposer) | absolu erroné (« jamais, l'obligation supprimée ») | oui | obligation réglementaire, forme de rappel standard |
| `37fe1af42b8d81d29ceac642002e46d1` | non situé, générique — « ce point » est anaphorique (renvoie au « 1 point » du prompt), pas un déictique de scène ; **faux positif du compteur `forme/hors-situation`**, déjà nommé en §3, qui ne le flague pas à cause de ce « ce » | règle (chiffre-règle : délai de réattribution, 6 mois) | seuil temporel proche de distracteurs (1 mois/2 ans/jamais) | oui | chiffre-règle standard ; le compteur ne le flague pas hors-situation à cause d'un « ce » anaphorique, déjà documenté en §3 comme faux positif |
| `37fe1af42b8d81ecb163c6b59334b160` | non situé — condition (« lorsque »), pas un moment | règle (conséquence : invalidation) | options contrastées (suspendu un mois/maintenu sous stage/converti en probatoire) contre l'invalidation réelle | oui | condition générale suivie d'une conséquence, forme standard, accord avec le compteur |
| `37fe1af42b8d81ed800ecde73e28760a` | non situé, générique | règle (chiffre-règle : plafond, 12 points) | valeurs intermédiaires réelles du barème progressif (6/8/10) en distracteurs | oui | chiffre-règle simple, forme standard |
| `3e99bcc374a5538e9af609b3038f08ad` | non situé, générique | règle (chiffre-règle : peine, 7 ans + 100 000 €) | gradation cohérente avec le barème réel (3/5/10 ans) parmi les distracteurs | oui | chiffre-règle de sanction récente, forme standard |
| `666bb472f111a4f4634a0e30abdf180a` | non situé, générique | **désaccord avec le compteur `forme/definitionnel`** — règle (barème : plafond de cumul), pas action | contre-intuitif (un distracteur nie l'existence d'un plafond) | oui | « entraînent » est hors du lexique du compteur — la troisième des trois cartes de ce domaine parmi les treize recensées en §3 (cumul d'infractions) ; plafond chiffré attesté, forme appropriée |
| `aa44507977673661e72b2c2ba6a6d885` | non situé — procédure administrative (« le préfet »), pas une scène du candidat | règle (chiffre-règle : délai, 72 heures) | valeurs voisines (24/48/72/96 heures) | oui | chiffre-règle procédural, forme standard |
| `f405372595dbaf85bf875adaf5ac20a4` | non situé, générique | règle (chiffre-règle : plafond, 6 mois ou 1 an aggravé) | gradation entre distracteurs (3 mois/1 an/2 ans) qui pourrait laisser croire à un simple doublement | oui | chiffre-règle standard |
| `bc949f3e3918b2e407b638892b47b540` | non situé — cas particulier (permis étranger) | règle (conséquence : interdiction de circuler un an) | faux-ami (croire à une exemption faute de titre français, ou à une annulation par le préfet local) | oui | cas réglementaire précis, conséquence attestée par OBS-7, forme standard |

**Ce que la lecture a vu et que les compteurs n'ont pas vu :** le compteur
`forme/definitionnel` ne compte que 9/19 (47 %) sur ce domaine ; en objet réel, trois cartes
de plus sont définitionnelles (barème) mais échappent à son lexique — les trois cartes de ce
domaine parmi les treize recensées en §3 (téléphone en main, défaut de ceinture, cumul
d'infractions) — soit 12/19 (63 %), nettement au-dessus de la moyenne globale (94/255,
37 %) : l'attente énoncée en tête de tâche se vérifie sur ce domaine à échelle de sanction,
comme elle s'était déjà vérifiée sur `Vitesse`. Une quatrième carte,
`37fe1af42b8d81d29ceac642002e46d1`, est le faux positif inverse déjà nommé en §3 : « ce
point » y est anaphorique (il renvoie au « 1 point » du prompt), pas un déictique de scène,
mais le compteur `forme/hors-situation` la classe à tort comme située. Aucune carte du
domaine ne repose sur une comparaison de deux dispositifs distincts, une méthode de calcul ou
un objet absent de sa propre image — les trois formes qui avaient produit un « non » en
dehors du levier pictogramme dans les domaines déjà lus.

**Ce que les compteurs ont signalé à tort :** rien à ajouter aux quatre désaccords déjà
nommés ci-dessus dans le tableau.

### Premiers secours (18 cartes)

Seul domaine du chantier dont les sources ne sont pas juridiques — Croix-Rouge, ERC, INRS
plutôt que Légifrance — et le spécimen porte une unique question de ce thème, Q10 (« Gestes
de premier secours », réponses A, C). Sans accès à l'énoncé littéral de Q10 ni à ses options,
la seule chose que le corpus permet de comparer est le registre du paragraphe de réponse : Q10
est à la première personne comme 21 des 24 questions (OBS-1), ce qui n'est pas un trait
distinctif du domaine — le changement de nature des sources ne dit rien sur la forme (§1 : le
registre ne fonde jamais un verdict). Sur la forme elle-même, ce domaine fait apparaître la
structure la plus singulière relevée dans ce chantier — deux cartes dont les quatre options
réordonnent une même liste de trois gestes plutôt que d'opposer quatre faits distincts — mais
le corpus ne montre jamais les options d'une question du spécimen (OBS-4) : il ne peut donc ni
attester ni réfuter cette structure, et les deux cartes restent `oui` (Ruling 22, voir le
blind-spot ajouté en tête de section 4). C'est une observation, pas un verdict : le domaine ne
diffère pas de forme sur cet axe, faute d'un corpus capable d'en juger.

| id | ancrage | objet | piège | se poserait à l'examen ? | motif |
|---|---|---|---|---|---|
| `1ef7d3ed540293c212d9c304ffb297f5` | non situé — condition (« face à »), pas un moment | faire (décision : premier geste) | gestes populaires mais faux (corps gras, glace, percer les cloques) | oui | décision de premier secours, forme attestée par OBS-7 (décision), correctement repérée par le compteur définitionnel |
| `37fe1af42b8d810ca665ffa0e4b32ab7` | non situé, générique | règle (chiffre-règle : numéro d'urgence) | confusion avec d'autres numéros à trois chiffres (115/119/197) | oui | fait chiffré simple, forme standard de rappel |
| `37fe1af42b8d8122b00cdea4e4368822` | non situé, générique | règle (chiffre-règle : numéro d'urgence) | confusion entre numéros d'urgence (15/17/18/112) | oui | même famille que la carte précédente, forme standard |
| `37fe1af42b8d81418280fb4ce8ce85d2` | non situé — condition générale (« en cas de »), pas un moment | faire (décision : comprimer) | gestes contre-productifs (donner à boire, surélever la tête, attendre sans agir) | oui | décision de premier secours, condition générale, accord avec le compteur |
| `37fe1af42b8d8175a7fccbffc2d6bcfa` | non situé, générique | règle (condition : danger immédiat) | options plausibles (sur demande, pour le confort, secouriste présent) qui ne suffisent pas | oui | règle conditionnelle standard, forme attestée |
| `37fe1af42b8d817b9035c1079ede5c00` | non situé, générique | règle (chiffre-règle : distance, 30 m) | emplacements absurdes (coffre, toit, devant le véhicule) contre la distance réelle | oui | chiffre-règle standard |
| `37fe1af42b8d817bb145f7084044c24e` | non situé — condition générale récurrente (« lorsque »), pas un moment précis — accord avec le compteur | faire (décision : quoi indiquer) | fausse pertinence (immatriculation des véhicules) contre l'information réellement utile | oui | décision de premier secours, condition générale plutôt qu'un moment vécu — accord avec le compteur, à la différence de `5fe77bbd…` plus bas |
| `37fe1af42b8d81a092bee8d2faab6224` | non situé — événement décrit à la 3ᵉ personne générique, pas « vous » | règle (consigne : ne pas retirer) | contre-intuitif (on pourrait croire qu'il faut dégager les voies aériennes, vrai seulement si la victime ne respire plus) | oui | consigne de premier secours à la 3ᵉ personne générique, accord avec le compteur, même famille que les cartes analogues déjà lues (`Priorités & intersections`, `Feux`) |
| `37fe1af42b8d81b592ede04857b093b4` | non situé, générique | faire (décision : position latérale de sécurité) | positions plausibles mais dangereuses (semi-assise, sur le dos, assise) | oui | décision de premier secours standard, forme attestée |
| `37fe1af42b8d81f1b1cdfef31d2461b8` | non situé, générique | **forme de réordonnancement** — les quatre options sont les quatre mêmes permutations de trois mots (Protéger/Alerter/Secourir) | quatre permutations d'une même liste, un contraste par ordre seul | oui | forme inhabituelle — la plus singulière relevée dans ce chantier — mais requalifiée en oui (Ruling 22) : OBS-4 dit que le PDF ne montre aucune proposition, donc le corpus ne peut ni attester ni réfuter une structure d'options ; « aucune des 24 questions n'a cette forme » aurait été un argument tiré du silence, pas d'une forme absente |
| `37fe1af42b8d81f7a214d5130ad370f4` | non situé — condition/procédure générale (« pour »), pas un moment précis — accord avec le compteur | faire (décision : baliser) | fausse bonne action (déplacer les victimes, photographier) contre le balisage réel | oui | décision de premier secours, condition générale plutôt qu'un moment vécu — accord avec le compteur |
| `7d456e77187812e3a27ca828062d7938` | non situé, générique | **forme de réordonnancement** — les quatre options sont les quatre mêmes permutations de trois mots (Alerter/Masser/Défibriller) | quatre permutations d'une même liste, un contraste par ordre seul | oui | même motif que `37fe1af42b8d81f1b1cdfef31d2461b8` — forme inhabituelle mais requalifiée en oui (Ruling 22) : le corpus ne montre aucune proposition (OBS-4), il ne peut donc pas établir l'absence de cette structure d'options |
| `b9e656cbd3507444669c24c85777cb54` | non situé, générique | règle (qui peut l'utiliser) | restrictions plausibles mais fausses (secouriste PSC1 seulement, sous instruction du 15) | oui | règle d'usage attestée, forme standard |
| `5fe77bbd3af80ab119da8b5a2686b39c` | **désaccord avec le compteur `forme/hors-situation`** — situé (scène précise et singulière : seul, victime consciente et coincée), déjà documenté en §3 comme l'un des trois cas trouvés par une relecture indépendante | faire (décision : alerter et rester) | fausse bonne action (dégager la victime) contre la réalité (geste technique réservé aux secours) | oui | scène précise et singulière, confirmée située en §3 |
| `fb24f6323a07a07c776d55163d42e028` | non situé, générique | règle (chiffre-règle : 100 à 120 compressions/min) | valeurs voisines qui se chevauchent (60-80/140-160/35-55) | oui | chiffre-règle standard, mécanisme attesté par OBS-7 |
| `82a9e65c1cf2ff4a1a1a944ab59c59f9` | non situé, générique | règle (chiffre-règle : 5 à 6 cm) | valeurs voisines (1-2/3-4/8-10 cm) | oui | chiffre-règle standard, mécanisme attesté |
| `d724a3c3121fafd733552c7d2ba1f5aa` | non situé — 3ᵉ personne générique (« le sauveteur ») | règle (chiffre-règle : rapport 30/2) | grille de quatre couples de valeurs (30/2, 15/2, 30/5, 15/5) | oui | chiffre-règle standard, condition explicite, accord avec le compteur |
| `5e2dbc048917ecebcccbc8d54888acb3` | non situé — sujet impersonnel (« on ») | faire (décision : position) | positions plausibles mais physiologiquement inadaptées (PLS, assise, ventre) | oui | décision de premier secours, forme standard |

**Ce que la lecture a vu et que les compteurs n'ont pas vu :** les deux cartes de
réordonnancement (`37fe1af42b8d81f1b1cdfef31d2461b8`, `7d456e77187812e3a27ca828062d7938`) ne
sont signalées par aucun compteur comme structurellement particulières — `forme/definitionnel`
les flague toutes les deux, ce qui est juste sur le plan lexical (leurs prompts finissent par
« est :») mais ne dit rien de la structure de leurs options. C'est la lecture carte par carte
qui les distingue : leurs quatre options recyclent exactement les mêmes mots dans un ordre
différent, une construction qu'aucune des trois catégories d'OBS-7 (décision, conséquence,
mécanisme) ne prévoit. La première version de cette lecture en avait conclu un « non » —
« aucune des 24 questions du spécimen n'a cette forme » — mais c'était tirer une conclusion
d'un silence : le spécimen ne montre jamais ses propres options (OBS-4), donc rien dans ce
corpus ne peut établir qu'une structure d'options y est absente. Corrigé en `oui` (Ruling 22,
2026-09-06) ; le nouveau blind-spot en tête de section 4 porte cette limite pour les lectures
à venir. Par ailleurs, `5fe77bbd3af80ab119da8b5a2686b39c` confirme, sur un troisième domaine,
le faux négatif de `forme/hors-situation` déjà documenté en §3 (scène singulière, « premier
sur un accident, seul… », manquée car aucun verbe listé ne la couvre) ; deux autres cartes à
« vous » (`…alertez les secours`, `…protéger une zone d'accident`) auraient pu sembler du même
type mais s'en distinguent à la lecture : ce sont des procédures générales (« lorsque »/
« pour »), pas des instants narrés — accord avec le compteur, à la différence de `5fe77bbd…`.

**Ce que les compteurs ont signalé à tort :** rien à ajouter au faux négatif de
`forme/hors-situation` déjà nommé en §3 (`5fe77bbd3af80ab119da8b5a2686b39c`, confirmé ici sur
un troisième domaine). Les 7 cartes flaggées `forme/definitionnel` (numéro d'urgence ×2,
victime à ne déplacer que sous condition, position latérale de sécurité, les deux cartes de
réordonnancement, premier geste face à une brûlure) sont bien de forme définitionnelle à la
lecture, y compris les deux cartes de réordonnancement — le compteur ne se trompe pas sur son
propre motif lexical ; ce qu'il ne mesure pas (la structure des options) n'est pas non plus ce
que le corpus permet de trancher.

### Alcool & stupéfiants (18 cartes)

Domaine sans aucune carte illustrée (0/18), comme `Permis & sanctions` : même absence du
levier structurel (pictogramme isolé contre OBS-16), et un contenu presque entièrement un
seuil chiffré ou une qualification légale (taux d'alcool, peine, retrait de points, dispositif
technique) — même famille de forme que `Vitesse` et `Permis & sanctions`, le précédent du
lot 1 s'applique de la même façon : une carte dont la règle **est** un chiffre appelle une
forme définitionnelle, ce n'est pas un défaut. Aucune des vingt étiquettes de thème distinctes
du spécimen (OBS-6) ne nomme explicitement l'alcool ou les stupéfiants — à la différence de
`Mécanique & environnement`, où trois intitulés du spécimen recoupaient presque mot pour mot
le `topic` du domaine, aucun rapprochement de sujet, même générique, n'est tenté ici : chaque
carte ci-dessous est jugée sur sa forme seule.

| id | ancrage | objet | piège | se poserait à l'examen ? | motif |
|---|---|---|---|---|---|
| `22603ebb1d645f3273bc07e98ab0eb23` | non situé — condition (« après »), pas un moment | règle (obligation, distinction de régimes) | faux-ami (croire le dépistage soumis à un indice d'ivresse, ou réservé aux accidents graves) | oui | règle procédurale attestée (conséquence, OBS-7), forme standard, correctement repérée par le compteur définitionnel |
| `37fe1af42b8d810ea54ddbcc64f356fa` | non situé, générique | règle (qualification pénale : délit sans seuil) | faux-ami (seuil de tolérance, exemption si prescription) | oui | qualification juridique attestée, forme standard de rappel de sanction, même famille que « Conduire sans avoir jamais obtenu le permis est : » (`Permis & sanctions`) |
| `37fe1af42b8d8118b6d3f82929eabdca` | non situé, générique | règle (chiffre-règle : seuil, 0,5 g/L) | valeurs voisines correspondant à d'autres seuils réels (0,2 probatoire, 0,8 délit) | oui | chiffre-règle standard |
| `37fe1af42b8d811eae7dfa1a08ee0f64` | non situé, générique | règle (mécanisme physiologique : vitesse d'élimination) | valeurs voisines qui donneraient une élimination bien plus rapide ou lente | oui | fait physiologique attesté par OBS-7 (mécanisme), même famille que les cartes de mécanique de `Distances & freinage` |
| `37fe1af42b8d81218099fdc3bcfd24c9` | non situé, générique | règle (mécanisme : conversion dose/alcoolémie) | valeurs voisines contre-intuitives (trop bas ou beaucoup trop haut) | oui | fait physiologique attesté, mécanisme, même famille que la carte précédente |
| `37fe1af42b8d817e8e2feffa6987ba00` | non situé — seuil-condition (« à partir de »), pas un moment | règle (qualification : délit) | faux-ami (croire à une contravention simple, ou à une absence de sanction sans trouble visible) | oui | seuil-condition suivi d'une qualification, forme standard, accord avec le compteur |
| `37fe1af42b8d817e9b93c2546ad30ec9` | non situé — seuil-condition, pas un moment | **désaccord avec le compteur `forme/definitionnel`** — règle (barème), pas action | seuil chiffré (6 points), valeur maximale du barème pour une contravention | oui | « fait perdre » est hors du lexique du compteur — la seule carte de ce domaine parmi les treize recensées en §3 ; l'objet réel est un barème, chiffre-règle attesté |
| `37fe1af42b8d81b38194dba0c15484b4` | non situé, générique | règle (chiffre-règle : peine, 3 ans + 9 000 €) | distracteur recyclant l'ancien barème alcool (4 500 €/2 ans), faux-ami de confusion entre régimes | oui | chiffre-règle de sanction, forme standard |
| `37fe1af42b8d81b3b1a2f0bc28c23b22` | non situé, générique — « ces effets » est anaphorique (renvoie aux quatre options qui suivent), pas un déictique de scène ; **faux positif du compteur `forme/hors-situation`**, déjà nommé en §3, qui ne le flague pas à cause de ce « ces » | règle (reconnaissance : effet physiologique réel) | effets inversés ou inventés (meilleure vision nocturne, réaction raccourcie par l'excitation) | oui | reconnaissance factuelle standard (énumération à choix unique) ; le compteur ne le flague pas hors-situation à cause d'un « ces » anaphorique, déjà documenté en §3 comme faux positif — la seconde occurrence de ce faux positif dans ce chantier |
| `37fe1af42b8d81cf8791f73464a2f801` | non situé, générique | règle (chiffre-règle : seuil probatoire, 0,2 g/L) | valeurs voisines (0/0,5/0,8) correspondant à d'autres seuils réels | oui | chiffre-règle standard, jumelle de la carte du permis classique |
| `37fe1af42b8d81f2a662e1b1284f99b9` | non situé, générique | faire (décision : démenti de mythe — attendre) | gestes populaires mais inopérants (douche froide, manger gras, café) | oui | démenti de mythe, décision attestée par OBS-7, même famille que les cartes de mécanique déjà lues (ABS, aquaplanage) |
| `526ffb51f8bc0ed95490405ddc0dfc0f` | non situé — cas numérique appliqué, pas une scène | règle (qualification : infraction ou non selon un seuil déjà fixé) | faux-ami (croire que le seuil probatoire est celui du permis définitif) | oui | application chiffrée d'une règle déjà posée par ailleurs dans le domaine, forme standard |
| `5720fa6a7cd62743982f88a4f3fa5dd2` | non situé, générique | règle (chiffre-règle : peine) | ancien barème recyclé en distracteur (2 ans/4 500 €), confusion avec le cumul stupéfiants (5 ans/15 000 €) | oui | chiffre-règle de sanction, forme standard |
| `749552ac121e0cd77beff969300b8ef9` | non situé, générique | règle (qualification : délit assimilé) | faux-ami (croire à un droit de refus, ou à l'absence de conséquence) | oui | qualification juridique attestée, forme standard |
| `92f3fe40dd9c28ff0010261e74ae6ebe` | non situé, générique | règle (chiffre-règle : peine) | gradation de distracteurs reproduisant d'autres barèmes du domaine (2 ans/4 500 €, 5 ans/15 000 €) | oui | chiffre-règle de sanction, jumelle de la carte sur le refus de dépistage d'alcoolémie |
| `bda97dae02fa9e085f5f6ba0827a4f7b` | non situé — condition (« après »), pas un moment | règle (conséquence assurantielle) | options en tout-ou-rien (sans majoration, avec 400 %, sans préavis) contre la réalité nuancée | oui | conséquence attestée par OBS-7 (catégorie « conséquence »), forme standard, sans artefact |
| `e13df5a7d4151bdeca7a9f914c90cf4e` | non situé, générique | règle (chiffre-règle : peine aggravée, cumul) | gradation cohérente avec le reste du domaine (2/3/5 ans) ; option contre-intuitive (« mêmes peines, sans aggravation ») | oui | chiffre-règle de sanction, forme standard |
| `ef26cca38b9d1abc6fb0b13d76247f35` | non situé, générique | règle (fonction d'un dispositif) | fonctions plausibles mais fausses (coupe le moteur en roulant, enregistre, alerte les forces de l'ordre) | oui | connaissance de dispositif, même forme que les cartes de fonction de dispositif de `Mécanique & environnement` |

**Ce que la lecture a vu et que les compteurs n'ont pas vu :** le compteur
`forme/definitionnel` compte 7/18 (39 %) sur ce domaine, déjà au-dessus de la moyenne globale
(94/255, 37 %) sans même corriger son lexique. Une carte de plus (`37fe1af42b8d817e9b93c2546ad30ec9`,
« fait perdre ») est manquée pour la raison déjà recensée en §3 — la seule carte de ce domaine
parmi les treize du lexique étroit — soit 8/18 (44 %) en objet réel. Une seconde carte,
`37fe1af42b8d81b3b1a2f0bc28c23b22` (« Parmi ces effets… »), est la seconde occurrence dans ce
chantier du faux positif « ce/ces anaphorique » de `forme/hors-situation` déjà nommé en §3 —
« ces effets » renvoie aux quatre options qui suivent, ce n'est pas un déictique de scène, mais
le compteur la classe comme située. Aucune carte du domaine ne repose sur une comparaison de
deux dispositifs distincts, une méthode de calcul ou un réordonnancement d'une liste fixe.

**Ce que les compteurs ont signalé à tort :** `forme/seule-ponctuee` sur la bonne réponse de
`37fe1af42b8d810ea54ddbcc64f356fa` (« Un délit, sans seuil de tolérance ») — une phrase
complète et normale, pas un défaut de forme ; comme déjà noté pour `Priorités &
intersections`, le compteur mesure l'absence de ponctuation interne chez les distracteurs, pas
une brièveté suspecte de la bonne réponse. Rien à ajouter au faux positif de
`forme/hors-situation` déjà nommé ci-dessus.

### Usagers & partage de la route (18 cartes)

Quatre cartes illustrées sur dix-huit, et aucune n'est un pictogramme isolé : les quatre
scènes (feu + sas cycliste, dépassement d'un cycliste, angle mort d'un poids lourd, bus à
l'arrêt) montrent toutes un véhicule ou un usager placé dans un contexte de conduite, jamais
un panneau ou un signal seul sur fond neutre — vérifié à la fois sur l'alt-text et sur le
code source des scènes (`Tools/Scenes/ScenesCirculation.swift`, fonctions `rueBordeeDeDeuxTrottoirs`/`chausseeADoubleSens` plutôt que la scène de panneau isolé de `ScenesPanneaux.swift`). Aucun autre domaine de ce lot ne recoupe le
sujet du spécimen sur un thème aussi net (usagers vulnérables, Q2/Q9/Q11), mais le sujet
n'y est jamais confondu avec la forme.

| id | ancrage | objet | piège | se poserait à l'examen ? | motif |
|---|---|---|---|---|---|
| `39fa27d59e28817c42382c5f4f4e2fc0` | situé — scène de feu et de sas cycliste, vue depuis le poste de conduite | faire (où arrêter le véhicule) | deux lignes d'arrêt proches, confusion sur celle qui vaut pour les véhicules motorisés | oui | scène réelle de conduite (feu + marquage), pas un pictogramme isolé — exactement la forme qu'OBS-16 dit visée par la réforme |
| `9b774739866a136e7c2a9bd69b2f417d` | situé — scène de dépassement d'un cycliste, distance à tenir | faire (respecter la distance) | seuil chiffré précis (1 m/1,5 m) proche de distracteurs voisins | oui | scène concrète où le chiffre-règle est la réponse même, même forme que les cartes autoroutières de `Vitesse` déjà jugées oui |
| `c29b2e7d758f0d17e790fa40f6e83313` | semi-situé — vue de dessus des zones d'angle mort, votre voiture placée dans la plus large | faire (se laisser distancer) | option qui rapproche encore du poids lourd, contre-intuitive | oui | scène réelle (position relative au camion), pas un pictogramme abstrait — même précédent que `2c0a147d9ba6e61b52c7639089b6f118` (`Mécanique & environnement`), vue non depuis le poste de conduite mais scène concrète |
| `f6ef205dcb2d32c5f30ca6ee69a673c8` | situé — scène de bus à l'arrêt, clignotants allumés | faire (ralentir, laisser reprendre la file) | absolu trompeur (« il vous cède le passage ») | oui | scène de conduite complète et décision claire — forme exemplaire au sens d'OBS-16 |
| `058434ed65eee628aefe05ac54ff92d1` | non situé, générique | règle (chiffre-règle : rayon de 50 m) | seuil chiffré proche de distracteurs (10/20/100 m) | oui | chiffre-règle standard, accord avec le compteur |
| `0b13aed9a8d54d809ec67944c7033775` | non situé, générique | règle (portée d'une interdiction) | absolu trompeur (« interdite partout ») contre une exception réelle | oui | qualification juridique attestée, même forme que « Conduire après usage de stupéfiants est : » (`Alcool & stupéfiants`, jugée oui) |
| `45d84549ac552870982bf1315f9a8151` | non situé, générique | règle (où circuler) | absolu trompeur (« n'importe quelle route ») | oui | rappel réglementaire standard, accord avec le compteur |
| `49f761c8ac8bd10ed3bf685b1b112f6c` | **désaccord avec le compteur `forme/hors-situation`** — situé (dépassement d'un autocar scolaire qui fait descendre des enfants), déjà documenté en §3 comme l'un des cinq exemples trouvés par recherche ciblée | faire (réduire l'allure) | absolu trompeur (« la voie étant libre ») | oui | scène de conduite réelle, confirmée en §3 |
| `5f426e8e0d2326304689478d90b749fc` | non situé, générique | règle (qualification : règle du code depuis 2025, pas une expérimentation) | ancien statut expérimental recyclé en distracteur | oui | qualification juridique, forme standard ; la date figure dans une option, pas dans l'énoncé — à la différence de `337bfcb4d034b62de5fe0d77ca0cb0a0` (`Vitesse`, jugée partiel pour une datation « dans l'énoncé même »), aucun artefact de datation dans le prompt ici |
| `7c2284d4cc7f32e90ce8926470fd656a` | non situé, générique (3ᵉ personne, « un enfant ») | règle (condition d'âge) | seuil d'âge proche de distracteurs (douze/dix-huit ans) | oui | connaissance réglementaire, accord avec le compteur |
| `82b915c28f76ff1314ecc8cbc927f9b3` | non situé, générique | règle (portée : qui, où) | restriction fausse (âge du passager, lieu) | oui | rappel d'obligation, forme standard |
| `9eed1fe645eb99123b9a86e348b55f99` | non situé, générique | règle (portée : quels véhicules) | seuil de tonnage proche (12 t) | oui | rappel réglementaire standard |
| `a6fb8c0684dce67923a3207ee19171c9` | non situé, générique | règle (chiffre-règle : deux plafonds) | valeurs voisines (30/50/70 km/h) | oui | chiffre-règle standard, même famille que les cartes de `Vitesse` |
| `b7b38d7ae1faf0dd593a1a2446b59ee6` | non situé, générique (3ᵉ personne, « un piéton ») | règle (position : gauche/droite) | absolu trompeur (jour/nuit inversés) | oui | connaissance réglementaire standard |
| `bf6922c59ca8a1e934e50b69699af54e` | non situé, générique | règle (portée : qui, âge) | seuil d'âge proche (douze ans) | oui | rappel d'obligation, forme standard |
| `d3f45f8d29cf6fb411382286877af9ca` | non situé, générique | règle (chiffre-règle : âge minimal) | valeurs voisines (12/16/18 ans) | oui | la règle testée est un chiffre — forme définitionnelle appropriée, comme l'anticipe la consigne |
| `e6f52409aaec9cc7d19ca28837113023` | non situé, générique (3ᵉ personne, « celui qui pousse ») | règle (position : gauche/droite) | absolu trompeur (« où il veut ») | oui | connaissance réglementaire standard |
| `fe6c39082afe1716a7cfe42d968635a8` | non situé, générique | règle (chiffre-règle : vitesse par construction) | valeurs voisines (20/30/45 km/h) | oui | la règle testée est un chiffre — forme définitionnelle appropriée |

**Ce que la lecture a vu et que les compteurs n'ont pas vu :** les quatre illustrations de ce
domaine sont, sans exception, des scènes construites autour d'un véhicule ou d'un usager en
mouvement — jamais un objet de signalisation seul. Vérifié au niveau du code des scènes, pas
seulement de l'alt-text : `angle-mort-poids-lourd`, `bus-quittant-arret`, `sas-cycliste-feu`
et `depassement-cycliste-distance` appellent toutes une fonction de rue ou de chaussée
(`rueBordeeDeDeuxTrottoirs`, `chausseeADoubleSens`-like), jamais la scène de panneau isolé de
`ScenesPanneaux.swift`. Un seul désaccord, déjà connu de §3 (`49f761c8…`, l'autocar
scolaire). Aucune carte du domaine ne repose sur une comparaison de deux dispositifs, une
méthode de calcul ou un objet absent de sa propre image — les trois formes qui produisent un
« non » ailleurs dans ce chantier en dehors du seul levier pictogramme.

**Ce que les compteurs ont signalé à tort :** rien à ajouter au faux positif déjà documenté en
§3 (`49f761c8…`). Les 21 autres flags des trois compteurs sur ce domaine sont confirmés à la
lecture.

### Arrêt & stationnement (17 cartes)

Trois cartes illustrées sur dix-sept. Un contrôle structurel antérieur à cette lecture avait
compté deux de ces trois comme des « pictos isolés » (voir `progress.md`, prédiction reprise
dans le dispatch de cette tâche). La lecture carte par carte, et surtout le code source des
trois scènes (`Tools/Scenes/ScenesCirculation.swift`, lignes 964-1045), donnent un résultat
inverse : les deux scènes de ligne jaune sont accompagnées, **par construction**, d'une
« même voiture » que le commentaire du code dit explicitement destinée à écarter la lecture
« photo isolée contre schéma » — « Les deux sont donc dessinées, du même point de vue et avec
la même voiture, et seule l'interruption les sépare » — et la scène en épi place « votre
voiture » circulant le long de trois places réellement occupées, pour que « les voitures
disent du stationnement, les places vides disent en épi ». Aucune des trois n'est donc conçue
comme un objet de signalisation seul : la forme abandonnée par OBS-16 (panneau isolé + question
de sens) ne s'y retrouve pas. Le « non » du domaine vient d'un mécanisme entièrement différent,
plus bas dans le tableau.

| id | ancrage | objet | piège | se poserait à l'examen ? | motif |
|---|---|---|---|---|---|
| `0a4e98c4605ec20320f13dec75f7bb9c` | semi-situé — marquage vu en contexte de rue et de trottoir, votre voiture dans la scène (code source) | règle (portée : arrêt et stationnement, pas le seul stationnement) | absolu correct contre des restrictions inventées (livraison, encombrants) | oui | l'alt-text nomme une rue et un trottoir, comme les marquages « oui » de `Panneaux & marquage` (« Chaussée à double sens… ») ; le code de la scène confirme une voiture dessinée exprès pour ne pas être « photo isolée » |
| `639297cf3f0f433daf035978fa8ddfe5` | semi-situé — marquage vu en contexte de rue, votre voiture y circule le long de trois places réellement occupées (code source) | règle (catégorie de stationnement imposée) | trois catégories voisines (bataille/créneau/double file) | oui | scène réelle et habitée, pas un pictogramme abstrait — même précédent que les marquages « oui » de `Panneaux & marquage` |
| `a2673bae092f3eaf438b40910de6fbd4` | semi-situé — marquage vu en contexte de rue et de trottoir, votre voiture dans la scène (code source), jumelle de `0a4e98c4` | règle (portée : stationnement seul, pas l'arrêt) | restriction fausse (heures de livraison) | oui | même précédent que sa jumelle continue |
| `37fe1af42b8d811198bdecd01768828c` | non situé, générique | règle (condition : masque de visibilité) | lieux plausibles mais faux (parking mal éclairé, domicile) | oui | condition générale suivie d'une règle, accord avec le compteur |
| `37fe1af42b8d811b96fdf80a7a546c1e` | non situé, générique (« on ») | règle (côté de stationnement) | inversion gauche/droite | oui | rappel réglementaire standard |
| `37fe1af42b8d812cad07c40f6c51598c` | non situé — comparaison entre deux notions juridiques, pas une règle ou une scène unique | règle (nature comparative) | quatre options isolant chacune un critère | **non** | aucune des 24 questions du spécimen n'a cette forme : comparer deux notions plutôt que d'interroger une règle ou une scène unique, exactement le mécanisme de `cac0f9db162887802d4fb15ba97d768f` (`Vitesse`, « Entre une zone 30 et une zone de rencontre, la différence porte sur : »), déjà jugée non pour ce motif |
| `37fe1af42b8d8134ad4be3c7e29328f1` | non situé, générique | règle (qualification : très gênant) | absolus trompeurs (avertissement, tolérance nocturne) | oui | qualification juridique, même forme que « Conduire après usage de stupéfiants est : » (`Alcool & stupéfiants`) |
| `37fe1af42b8d8148bc29ede5a0015edd` | non situé — condition (hors agglomération), pas un moment | faire (se placer hors chaussée) | fausses bonnes pratiques (feux de détresse, double file) | oui | condition générale suivie d'une règle, accord avec le compteur |
| `37fe1af42b8d8166847cf95009550b0a` | non situé, générique | règle (obligation d'affichage du disque) | fausses modalités (application, horodateur) | oui | c'est la carte que la spec cite elle-même en §3 comme exemple de règle générale à ne pas confondre avec une scène (« En zone bleue, vous devez : ») — confirmé ici : condition générale, pas un instant vécu |
| `37fe1af42b8d8181a057c984708f0042` | non situé, générique | règle (chiffre-règle : montant) | montants réels voisins (90/135/375 €) | oui | chiffre-règle standard |
| `37fe1af42b8d81d793bcc927205f9d79` | non situé, générique | règle (qualification : très gênant) | dérogations fausses (horaire, tolérance) | oui | qualification juridique, forme standard |
| `37fe1af42b8d81e2b806fb6055602586` | non situé — procédure générale (« avant de »), pas un moment précis | faire (clignotant, angles morts, céder le passage) | fausses bonnes pratiques (klaxon, sans contrôle) | oui | procédure générale plutôt qu'un instant vécu, même famille que les cartes-condition déjà rencontrées (`9f0fe6e809948a327c918ac0b5987cf9`, `4ade42a7e2c69ec43159940235d08c5f`, `Distances & freinage`) — accord avec le compteur |
| `37fe1af42b8d81e9b314fcb5ac447202` | non situé, générique | règle (chiffre-règle : durée) | valeurs voisines (1 mois/24 h) | oui | chiffre-règle standard |
| `5139c357024d2a17c499b104d7a01d81` | non situé, générique | règle (chiffre-règle/qualification : périodicité) | rythmes plausibles mais faux (hebdomadaire, quotidien) | oui | chiffre-règle standard |
| `ab50f861852232a60c2b4f29fed21b97` | non situé, générique | **désaccord avec le compteur `forme/definitionnel`** — règle (portée : qui), pas action | restrictions fausses (conducteur seul, passager seul) | oui | « vise » est hors du lexique du compteur (est/sont/sert à/signifie/indique/impose/doit être/permet de) ; l'objet réel est bien une définition de portée, un verbe de plus à ajouter à ceux déjà recensés (« constitue », « consiste à », « a lieu », « suffisent ») |
| `c5d4d52f1aaa89b811c8b17847338968` | non situé, générique | règle (chiffre-règle : montant) | montant voisin réel (borne de recharge, 35 €) | oui | chiffre-règle standard |
| `e6d0b1101f0ac46d63199b5485d17c61` | non situé, générique | règle (chiffre-règle : distance) | valeurs voisines (2/10 m) | oui | chiffre-règle standard |

**Ce que la lecture a vu et que les compteurs n'ont pas vu :** un contrôle antérieur au
chantier avait classé deux des trois illustrations de ce domaine comme des pictogrammes
isolés, en anticipation de ce lot. Le code source des scènes dit l'inverse de son propre aveu
— les trois commentaires cités ci-dessus décrivent un choix délibéré d'y placer un véhicule
(le vôtre, et pour l'épi trois autres) précisément pour ne pas rejouer la forme « photo
isolée ». Aucune des trois cartes ne correspond donc à la forme qu'OBS-16 dit abandonnée. Le
seul « non » du domaine vient d'ailleurs : `37fe1af42b8d812cad07c40f6c51598c` compare deux
notions juridiques (arrêt, stationnement) plutôt que de tester une règle ou une scène unique
— structurellement identique à `cac0f9db…` (`Vitesse`), déjà jugée non pour ce motif, et sans
lien avec l'illustration. Une nouvelle carte échappe au lexique de `forme/definitionnel`
(`ab50f861…`, « vise »), qui rejoint la liste déjà ouverte par les domaines précédents.

**Ce que les compteurs ont signalé à tort :** rien au-delà du désaccord lexical déjà nommé
ci-dessus (`ab50f861…`) ; les autres flags des trois compteurs sur ce domaine sont confirmés à
la lecture.

### Croisement & dépassement (15 cartes)

Quatre cartes illustrées sur quinze, et aucune n'est un pictogramme isolé — toutes montrent
une chaussée avec au moins un véhicule, vue depuis le poste de conduite ou de profil (jamais
la scène de panneau isolé de `ScenesPanneaux.swift`). Ce domaine concentre par ailleurs, sans
qu'aucune lecture n'ait eu à les redécouvrir, quatre exemples déjà nommés en §3 : l'une des
trois cartes trouvées par relecture indépendante (`75e142d9…`), l'un des deux faux positifs
connus de `forme/definitionnel` (`2fc1ed8a…`), et les deux « tournures voisines… écartées du
décompte » de `forme/hors-situation` (`b494d715…`, `f5a12ba7…`). Les citer ici confirme §3,
ça ne le redécouvre pas.

| id | ancrage | objet | piège | se poserait à l'examen ? | motif |
|---|---|---|---|---|---|
| `42078575c362bf24a220380788994e25` | situé — scène complète (chaussée étroite, obstacle à l'arrêt et véhicule en face) | faire (attendre) | inversion de priorité (qui doit céder) | oui | scène de conduite complète, décision claire — forme exemplaire |
| `46269e3e9018b1949b8143894e86c4fc` | situé — scène de dépassement en cours, voie dégagée devant | faire (poursuivre la manœuvre) | ligne discontinue jugée à tort contraignante | oui | scène complète, décision claire |
| `697b226c6270e1cee1a6e4edb95dec42` | situé — scène de sommet de côte, visibilité coupée au-delà | règle (légalité du dépassement dans cette scène précise) | conditionnement trompeur sur la présence d'un véhicule en face | oui | scène réelle et concrète (visibilité coupée), pas un panneau isolé — même si le prompt se termine en « est : », flaggé `forme/definitionnel` |
| `9aaede46c1c808687f89f4a8fb81f9df` | situé — scène de rabattement juste après un dépassement | règle (l'effet du rabattement sur le véhicule doublé) | absolus trompeurs (trop tôt/trop tard mal attribués) | oui | scène réelle précise, décision jugée sur l'effet plutôt que sur une distance chiffrée |
| `07b430ccbde4b33b92be8686899b1ddf` | non situé, générique (3ᵉ personne, « un convoi ») | règle (obligation du convoi encombrant) | fausses bonnes pratiques (feux de détresse, priorité imposée) | oui | rappel réglementaire standard, accord avec le compteur |
| `2fc1ed8a9c9274f0e06be9f12850f5a4` | non situé — état de circulation décrit, pas un moment vécu par « vous » | **désaccord avec le compteur `forme/definitionnel`** — règle (qualification : n'est pas considéré comme un dépassement), question elliptique | seuil de vitesse recyclé d'un autre régime (30 km/h, inter-files) | oui | l'un des deux faux positifs de `forme/definitionnel` déjà documentés en §3 (question elliptique sans copule propre) ; qualification juridique réelle, accord avec le compteur sur l'ancrage |
| `75e142d94ea93f63d0e75fa19a8f8c4f` | **désaccord avec le compteur `forme/hors-situation`** — situé (« Un véhicule s'apprête à vous dépasser »), déjà documenté en §3 comme l'une des trois cartes trouvées par une relecture indépendante | faire (serrer à droite sans accélérer) | absolu trompeur (accélérer pour raccourcir la manœuvre) | oui | scène de conduite confirmée en §3 |
| `93292bac6a7b17452c0e2ad2b30164fa` | non situé — condition météo (neige/verglas), pas une scène | règle (interdiction conditionnée) | fausse généralisation (pluie, nuit) | oui | condition générale suivie d'une règle, accord avec le compteur, même famille que les cartes météo de `Vitesse`/`Feux` |
| `99824d4de286434d85174502e05ea59d` | non situé — configuration de chaussée (trois voies), pas une scène précise | faire (quelle voie prendre pour dépasser) | fausse extension à la voie de gauche | oui | configuration générale plutôt qu'un instant vécu, accord avec le compteur |
| `acfa94cddf8eadadd75d07c9b97a5501` | non situé — condition (« si »), pas un moment | faire (ne pas entamer le dépassement) | repère d'enseignement inventé (dix secondes) | oui | condition générale, accord avec le compteur, même famille que les cartes « à l'approche de » déjà exclues |
| `ad7c53ef7c57cb946c12b29bc36c004f` | non situé, générique | règle (exception qui impose le dépassement par la droite) | fausse généralisation (autoroute saturée) | oui | qualification/obligation, forme standard |
| `b494d71578b339d0259157dd378a3b9b` | non situé — condition (« à l'approche de… »), pas une scène ; déjà documentée en §3 comme tournure voisine écartée du décompte | règle (condition de vérification, pas une interdiction) | seuil de tonnage recyclé d'un autre article (3,5 t) | oui | règle générale, accord avec le compteur — confirmé en §3 |
| `e5b0f585f1a3654ca790b9e391db8203` | non situé — condition (absence de barrière), pas une scène | règle (interdiction conditionnée) | absolu trompeur (« dans tous les cas ») | oui | condition générale, accord avec le compteur |
| `f1ae9582d692d2bb7febb6a3c936ff34` | non situé, générique (« chaque conducteur », pas « vous ») | règle (obligation de croisement) | inversion (se déporter au centre) | oui | rappel réglementaire à la 3ᵉ personne générique, accord avec le compteur |
| `f5a12ba77751310fe9a210a3b787286a` | non situé — condition (« à l'approche de… »), pas une scène ; déjà documentée en §3 comme tournure voisine écartée du décompte | règle (exception qui autorise le dépassement) | absolu trompeur (clignotant substitué à la priorité) | oui | règle générale, accord avec le compteur — confirmée en §3 |

**Ce que la lecture a vu et que les compteurs n'ont pas vu :** rien de neuf — ce domaine
confirme quatre exemples déjà catalogués en §3 (`75e142d9…`, `2fc1ed8a…`, `b494d715…`,
`f5a12ba7…`) plutôt que d'en produire de nouveaux. Les quatre illustrations sont toutes des
scènes de conduite réelles (0 pictogramme isolé, comme mesuré avant cette lecture), et le
compteur les reconnaît correctement comme situées via l'exemption d'image — aucun désaccord
sur les cartes illustrées elles-mêmes. Aucune carte du domaine ne repose sur une comparaison
de deux dispositifs, une méthode de calcul ou une abstraction hiérarchique sans cas concret :
les quinze cartes se lisent oui.

**Ce que les compteurs ont signalé à tort :** rien au-delà des quatre confirmations déjà
nommées en §3.

### Tunnels & passages à niveau (15 cartes)

Trois cartes illustrées sur quinze. Le code source de la seule balise isolée du domaine
(`passage-a-niveau-balises`) le dit sans ambiguïté : « Rien d'autre n'est dessiné, et surtout
**pas la voie ferrée** […] C'est aussi pour cela que la balise est vue de face et seule,
**comme les quatorze panneaux du dossier** » (`Tools/Scenes/ScenesCirculation.swift`, autour
de la ligne 1463) — une déclaration d'intention identique, mot pour mot, à celle qui fonde les
« non » de `Panneaux & marquage` et de `Feux`. Les deux autres illustrations du domaine
(panne en tunnel, véhicule pris entre des demi-barrières) sont au contraire des scènes
dramatiques complètes. Le domaine porte aussi l'une des deux cartes déjà documentées en §3
comme faux positif de `forme/definitionnel` (`d4b4abfd…`), et l'unique carte de barème par
points de ce domaine parmi les treize recensées en §3 (`1fe6ef49…`).

| id | ancrage | objet | piège | se poserait à l'examen ? | motif |
|---|---|---|---|---|---|
| `1cc2591b8808d4aa73d5af596388d948` | image isolée — la balise seule, plantée sur son support ; ni route ni voie ferrée dessinées, par choix explicite du code source | règle (signification : distance restante avant la voie ferrée) | inversion proche/loin | **non** | image isolée + question de sens (« vous annonce ») — exactement la forme qu'OBS-16 nomme abandonnée ; le commentaire de la scène la compare lui-même « aux quatorze panneaux du dossier » |
| `1e329fa1bba26cabf575a76ec127dad4` | situé — scène de panne dans un tunnel, refuge d'urgence visible | faire (rejoindre le refuge) | fausses bonnes pratiques (demi-tour, marcher, s'arrêter sur place) | oui | scène réelle de conduite, décision claire — forme exemplaire |
| `d50cd498f6e5261eb5a2fc9dfe45de90` | situé — scène de véhicule pris entre deux demi-barrières abaissées | faire (forcer le passage) | fausses bonnes pratiques (attendre, reculer) | oui | scène réelle et précise, décision claire |
| `1fe6ef49aad916e076477274c75c3550` | non situé, générique | **désaccord avec le compteur `forme/definitionnel`** — règle (barème), pas action | seuil chiffré (4 points) proche de distracteurs (2/3/6) | oui | « fait perdre » est hors du lexique du compteur — la seule carte de ce domaine parmi les treize recensées en §3 ; barème attesté, forme appropriée |
| `3a06288bf73bb5254b83a371ae55a854` | non situé, générique | règle (fonction d'un panonceau) | fonction plausible mais fausse (hauteur libre, vitesse, issues) | oui | question de fonction d'un dispositif, non illustrée, même forme que les cartes analogues de `Mécanique & environnement`/`Priorités & intersections` déjà jugées oui |
| `5ae4a8d7800141787ada8a389ff74fc1` | non situé, générique | règle (qualification : gênant) | qualification voisine trop sévère (très gênant) | oui | qualification juridique, forme standard |
| `5c11020dc34bf45d56cf8438dd8ad79e` | non situé — référence verbale à un panneau, sans image | règle (une prescription parmi trois) | fausses prescriptions plausibles (changer de voie, remorque) | oui | reconnaissance de panneau par son nom seul, sans support visuel — même forme que les cartes analogues de `Priorités & intersections` (`37fe1af42b8d8184be…`, `37fe1af42b8d81d6ae…`), jugées oui |
| `763ae1f8c7040ecb170a4ed33f09505a` | non situé, générique | règle (trois états des barrières) | généralisation fausse (lignes multiples) | oui | chiffre/condition-règle standard |
| `7148c3a8be7130501aa3da1644986ebb` | situé — scène d'incendie devant vous dans un tunnel | faire (couper le moteur, gagner une issue de secours) | fausses priorités (rester à bord, téléphoner d'abord, faire demi-tour) | oui | scène d'urgence réelle, correctement repérée par le compteur (« devant vous ») |
| `8a6af9d26330dc0f3bfd95d9bf0d7b81` | non situé, générique | règle (fonction d'une pancarte) | fonctions plausibles mais fausses (ligne, voirie) | oui | connaissance de dispositif, forme standard |
| `a88bdac8ef012091a9b0a43b209c3b1b` | non situé — condition (« dans un tunnel »), pas une scène | règle (qui peut allonger l'intervalle) | seuil recyclé d'un autre régime (50 m) | oui | condition générale, accord avec le compteur |
| `bda520451eb11447c3921f8a358742f1` | non situé — condition (« de jour, tunnel éclairé »), pas un moment | règle (obligation d'allumage malgré l'éclairage) | absolu trompeur (veilleuses suffisantes) | oui | condition générale, accord avec le compteur |
| `c084813ff73eacb15dc526232c288610` | non situé, générique | règle (chiffre-règle : délai) | ordre des opérations inversé en distracteur | oui | chiffre-règle standard |
| `d3af170839b4cf693c8bcba1a1e5c45a` | non situé — condition (absence de barrière et de feu), pas un moment | faire (s'assurer avant de traverser) | absolu trompeur (arrêt obligatoire comme à un STOP) | oui | condition générale, accord avec le compteur |
| `d4b4abfd51499d4ab343bbb613acc7ad` | **désaccord avec les compteurs `forme/definitionnel` et `forme/hors-situation`** — situé (scène : file arrêtée juste après un passage à niveau) | faire (attendre la place de dégager la voie) | fausses bonnes pratiques (reculer, avancer jusqu'aux rails) | oui | déjà documentée en §3 comme faux positif du compteur définitionnel (question elliptique, « Vous : » sans verbe) ; scène réelle, manquée aussi par `forme/hors-situation` faute de motif déictique |

**Ce que la lecture a vu et que les compteurs n'ont pas vu :** la prédiction d'un seul
pictogramme isolé sur trois illustrations se vérifie exactement, et le code source de la
scène le confirme dans ses propres termes plutôt que par simple lecture de l'alt-text : le
commentaire de `passage-a-niveau-balises` se compare lui-même « aux quatorze panneaux du
dossier », le vocabulaire même des « non » déjà rendus sur `Panneaux & marquage` et `Feux`.
`d4b4abfd…` cumule deux désaccords sur le même mot : le faux positif de `forme/definitionnel`
déjà nommé en §3, et un faux négatif de `forme/hors-situation` que la première mention en §3
n'avait pas relevé (aucun motif déictique dans « La circulation est arrêtée juste au-delà
d'un passage à niveau. Vous : », qui reste pourtant une scène précise à la lecture) — à noter
pour une future relecture de la ligne `forme/hors-situation` en §3.

**Ce que les compteurs ont signalé à tort :** rien au-delà des deux désaccords déjà nommés
ci-dessus.
