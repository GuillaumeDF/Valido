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
image ou vidéo** — le fichier lui-même est un PDF de texte seul, sans objet image intégré
(vérifié : `file` le rapporte comme document texte de 6 pages). Deux conséquences pour le
tableau ci-dessous :

- La colonne « Personne » mesure le paragraphe de réponse, pas l'énoncé littéral — c'est le
  seul texte disponible qui rejoue la situation, mais ce n'est pas la question telle qu'elle
  est lue par le candidat.
- La colonne « Image » ne peut pas constater une image absente du fichier ; elle relève un
  indice textuel — soit une mention explicite d'un support visuel dans le commentaire
  pédagogique, soit une scène décrite (positions, distances, acteurs) qui suppose une photo
  ou une vidéo sans le dire, soit aucun indice. Trois questions (4, 13, 19) nomment
  explicitement le support : « le visuel met le candidat en situation réelle de conduite »
  (Q4, Q19), « ici le format vidéo permet de bien évaluer la différence de vitesse » (Q13).

**Nombre de propositions.** Seules les lettres A, B, C, D apparaissent dans les 24 lignes
« Bonne(s) réponse(s) », jamais E ni au-delà : quatre propositions par question,
**déduites**, jamais observées directement (le PDF ne montre pas les propositions).

| N° | Image (indice textuel) | Personne (§ réponse) | Bonne(s) réponse(s) | Thème (étiquette du PDF) |
|---:|---|---|---|---|
| 1 | aucun indice | impersonnel | B | Capacité de perception et d'évaluation |
| 2 | indice de scène | 1ère personne | C | Conscience des risques liés aux usagers vulnérables |
| 3 | indice de scène | 1ère personne | A, C | Conscience des risques liés à la conduite de nuit |
| 4 | explicite (« le visuel ») | 1ère personne | A | Connaissance de la réglementation |
| 5 | indice de scène | 1ère personne | A, C | Capacite de perception et d'évaluation *(sic, sans accent dans le PDF)* |
| 6 | aucun indice | 1ère personne | A | Le développement des véhicules a boite automatique |
| 7 | aucun indice | 1ère personne | A, C | Sensibilisation aux conséquences des infractions au code de la route |
| 8 | aucun indice | 1ère personne | B, C | Capacité de perception et d'évaluation |
| 9 | indice de scène | 1ère personne | B | Connaissance des risques liés aux usagers vulnérables *(« Connaissance », vs « Conscience » en Q2)* |
| 10 | aucun indice | 1ère personne | A, C | Gestes de premier secours |
| 11 | indice de scène (« zone B ») | 1ère personne | B, C | Conscience des risques liés aux usagers vulnérables |
| 12 | aucun indice | 1ère personne | A, C | Nouvelles technologies |
| 13 | explicite (« format vidéo ») | 1ère personne | B, D | Capacité de perception, d'évaluation et de décision |
| 14 | indice de scène | impersonnel | B | Conscience des risques liés a la conduite de nuit *(sic, sans accent)* |
| 15 | aucun indice | 1ère personne | A, C | Capacité de perception, d'évaluation et de décision |
| 16 | indice de scène | 1ère personne | B | Conscience des risques en franchissant les intersections |
| 17 | indice de scène | 1ère personne | A, D | Conduite écologique et respectueuse de l'environnement |
| 18 | aucun indice | 1ère personne | A | Capacité de perception et d'évaluation |
| 19 | explicite (« le visuel ») | 1ère personne | A, C | Connaissance de la règlementation *(sic, vs « réglementation » en Q4)* |
| 20 | aucun indice | impersonnel | A, C | Conscience des risques liés à la vitesse |
| 21 | indice de scène | 1ère personne | B | Connaissance de la règle et prise en compte des usagers vulnérables |
| 22 | aucun indice | 1ère personne | A, C | Connaître les principaux organes du véhicule |
| 23 | aucun indice | 1ère personne | A, C | Connaître les principaux équipements du véhicule |
| 24 | aucun indice | 1ère personne | A | Nouvelles technologies / équipements de sécurité |

Trois totaux, reproductibles par relecture directe du tableau : 21/24 paragraphes de réponse
portent un marqueur de première personne (je/j'/mon/ma/mes/m'), 14/24 portent deux bonnes
réponses plutôt qu'une, et 3/24 nomment explicitement un support visuel.

**Un deuxième registre, toujours impersonnel.** Le commentaire pédagogique en italique
(« Le conducteur doit être capable de… ») est impersonnel sur les 24 questions, sans
exception — jamais à la première personne, jamais adressé au candidat. C'est un genre
distinct du paragraphe de réponse : une note à l'intention de qui conçoit ou administre
l'épreuve, pas une reformulation de l'énoncé. Un compteur qui confondrait les deux
paragraphes mesurerait deux choses différentes sous un seul chiffre.

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
  directement dans le document Légifrance.
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
  elle-même.
- **digischool.fr** — [`/auto/code-gratuit`](https://www.digischool.fr/auto/code-gratuit).
  **Refusé : rendu JavaScript vide.** Le HTML statique ne porte que le titre de la page ;
  aucun autre texte.
- **forum.codeclic.com** — deux fils lus sans connexion : [`/questions-pieges-code-t4453.html`](https://forum.codeclic.com/questions-pieges-code-t4453.html)
  (2 messages visibles) et [`/questions-posees-lors-examen-code-route-t5541.html`](https://forum.codeclic.com/questions-posees-lors-examen-code-route-t5541.html)
  (4 messages visibles, dont un candidat qui reconstitue de mémoire une quarantaine de
  questions de son propre passage). Ce sont des contributions de candidats relayées par un
  éditeur, pas une question officielle ni même la production de l'éditeur — un souvenir non
  vérifiable, à ce titre traité comme le niveau d'autorité le plus bas du corpus.

**Bilan de la strate : 4 domaines tentés, 0 laissant voir une question réelle sans compte.**
Deux se rendent vides côté client (ornikar, digischool), un est un mur de connexion explicite
(envoituresimone), un donne des métadonnées de série sans le contenu (codeclic) ; les deux
seuls fragments utilisables viennent d'un forum attaché à l'un de ces éditeurs, pas de
l'éditeur lui-même.

### Ce que ce corpus ne peut pas dire

La banque officielle n'est pas publique. Un éditeur produit sa propre imitation : la
strate 3 mesure « ce que le marché croit être une vraie question », et ce qu'un éditeur
publie en accès libre est de surcroît ce qu'il a choisi de montrer. Aucun constat du présent
rapport ne s'appuie sur la strate 3 seule sans le dire.

**La strate 3 est revenue quasi vide, et c'est un résultat, pas un accident de recherche.**
Sur les quatre éditeurs de `DOMAINES_FORME`, aucun n'a laissé lire une seule question réelle
sans compte le 2026-09-06 ; ce que la grille de la tâche suivante retiendra de cette strate
tient sur des métadonnées de page (codeclic : nombre de questions, seuil, support
photo/vidéo) et sur deux fils de forum décrivant des structures de piège de mémoire. Ce que
la grille perd : aucune mesure directe de longueur de propositions, de fréquence de piège
par thème, ni de vocabulaire de distracteur chez un éditeur — la strate 3 ne peut corroborer
que ce que la strate 2 borne déjà (40 questions, seuil 35/40, support visuel), pas apporter
une observation qui lui soit propre au niveau de la phrase. La strate 1, minuscule (24
questions) mais seule non approximative, porte donc l'essentiel du poids sur le piège et le
registre ; la strate 3 ne fait que suggérer que le marché des éditeurs raconte la même
chose (mêmes chiffres, même promesse d'ancrage visuel) sans jamais le montrer.

**La strate 1 elle-même a une limite qu'il faut redire ici.** Le paragraphe qui sert de
proxy à l'énoncé dans le tableau ci-dessus est une reconstruction éditoriale de la réponse
correcte, pas l'énoncé lu par le candidat ni le texte des propositions — voir l'avertissement
en tête de la strate 1. Toute observation de « personne grammaticale » ou de « présence
d'image » tirée de ce corpus hérite de cette approximation.

## Observations

| id | strate | source | date | ce qui est observé |
|---|---|---|---|---|
| OBS-1 | 1 | [PDF spécimen](https://www.securite-routiere.gouv.fr/sites/default/files/2020-04/reponsesquestionspermisauto_v1604.pdf) | 2026-09-06 | Le paragraphe de réponse porte un marqueur de première personne (je/j'/mon/ma/mes/m') dans 21 des 24 questions (87,5 %) ; seules Q1, Q14 et Q20 en sont dépourvues. |
| OBS-2 | 1 | [PDF spécimen](https://www.securite-routiere.gouv.fr/sites/default/files/2020-04/reponsesquestionspermisauto_v1604.pdf) | 2026-09-06 | Le commentaire pédagogique en italique qui suit l'étiquette de thème est impersonnel sur les 24 questions sans exception — un registre distinct du paragraphe de réponse, jamais adressé au candidat. |
| OBS-3 | 1 | [PDF spécimen](https://www.securite-routiere.gouv.fr/sites/default/files/2020-04/reponsesquestionspermisauto_v1604.pdf) | 2026-09-06 | 14 des 24 questions (58 %) marquent deux bonnes réponses (ex. « A, C ») plutôt qu'une seule ; aucune n'en marque trois ou quatre. |
| OBS-4 | 1 | [PDF spécimen](https://www.securite-routiere.gouv.fr/sites/default/files/2020-04/reponsesquestionspermisauto_v1604.pdf) | 2026-09-06 | Seules les lettres A, B, C, D apparaissent sur les 24 questions, jamais E ni au-delà : quatre propositions déduites, jamais observées — le PDF ne montre ni l'énoncé ni les propositions elles-mêmes. |
| OBS-5 | 1 | [PDF spécimen](https://www.securite-routiere.gouv.fr/sites/default/files/2020-04/reponsesquestionspermisauto_v1604.pdf) | 2026-09-06 | Le commentaire pédagogique de 3 questions sur 24 (Q4, Q13, Q19) nomme explicitement un support visuel (« le visuel », « le format vidéo ») ; les 21 autres ne le mentionnent pas — le fichier PDF lui-même ne contient aucune image, donc la présence d'image ne peut être comptée que par indice textuel sur cet échantillon, jamais observée directement. |
| OBS-6 | 1 | [PDF spécimen](https://www.securite-routiere.gouv.fr/sites/default/files/2020-04/reponsesquestionspermisauto_v1604.pdf) | 2026-09-06 | Les étiquettes de thème varient orthographiquement pour une même catégorie sur seulement 24 questions (« Conscience des risques liés aux usagers vulnérables » — Q2, Q11 — vs « Connaissance des risques liés aux usagers vulnérables » — Q9 ; « réglementation » vs « règlementation » — Q4 vs Q19 ; accent absent sur « conduite de nuit » — Q3 vs Q14), confirmant à petite échelle l'instabilité déjà relevée dans `couverture.md`. |
| OBS-7 | 1 | [PDF spécimen](https://www.securite-routiere.gouv.fr/sites/default/files/2020-04/reponsesquestionspermisauto_v1604.pdf) | 2026-09-06 | Le paragraphe de réponse décrit une action ou décision explicite du conducteur (« je dois vérifier… », « je m'assure… », « j'allume… ») dans 13 des 24 questions ; les 11 autres (Q1, Q6, Q7, Q8, Q12, Q13, Q14, Q17, Q20, Q23, Q24) se limitent à un constat, une conséquence ou un mécanisme, même quand la phrase est à la première personne. |
| OBS-8 | 2 | [Arrêté du 29 avril 2024, annexe VI (WS-ETG)](https://www.legifrance.gouv.fr/jorf/id/JORFTEXT000049502288) | 2026-09-06 | L'épreuve tire aléatoirement 40 diapositives, pour une durée maximale de 45 minutes, sans temps de réponse par question fixé dans le texte. |
| OBS-9 | 2 | [Arrêté du 29 avril 2024, annexe VI (WS-ETG)](https://www.legifrance.gouv.fr/jorf/id/JORFTEXT000049502288) | 2026-09-06 | Le format légal de réponse est « une combinaison de 0 à 4 lettres parmi A, B, C et D » — le nombre de bonnes réponses n'est jamais fixé à une seule par le droit. |
| OBS-10 | 2 | [Arrêté du 20 avril 2012, art. 2-I-B](https://www.legifrance.gouv.fr/loda/id/JORFTEXT000025803494) | 2026-09-06 | Le seuil de réussite est de 35 bonnes réponses sur 40, en vigueur depuis le 4 décembre 2022. |
| OBS-11 | 2 | [Arrêté du 27 avril 2016](https://www.legifrance.gouv.fr/loda/id/JORFTEXT000032471964) | 2026-09-06 | Abrogé depuis le 5 mai 2024 ; son annexe 2 (programme de l'épreuve) reste, comme en passe 2, une image scannée du fac-similé du JO — illisible en texte, sans changement dû à l'abrogation. |
| OBS-12 | 3 | [ornikar.com/code/gratuit/serie-1](https://www.ornikar.com/code/gratuit/serie-1), [envoituresimone.com/code-de-la-route/quiz](https://www.envoituresimone.com/code-de-la-route/quiz), [codeclic.com/gratuit.php](https://www.codeclic.com/gratuit.php), [digischool.fr/auto/code-gratuit](https://www.digischool.fr/auto/code-gratuit) | 2026-09-06 | Sur les 4 domaines de `DOMAINES_FORME`, aucun n'affiche de question réelle en HTML statique sans compte : rendu JavaScript vide pour 2 (ornikar, digischool), mur de connexion explicite pour 1 (envoituresimone), métadonnées de série sans contenu de question pour 1 (codeclic). |
| OBS-13 | 3 | [codeclic.com/gratuit.php](https://www.codeclic.com/gratuit.php) | 2026-09-06 | La page de métadonnées, seule accessible sans compte, recoupe indépendamment trois chiffres déjà bornés en strate 2 : 40 questions par série, seuil de réussite à 35/40, et « photos prises depuis le poste de conduite et vidéos de situations réelles sur la route ». |
| OBS-14 | 3 | [forum.codeclic.com/questions-pieges-code-t4453.html](https://forum.codeclic.com/questions-pieges-code-t4453.html) | 2026-09-06 | Deux messages, lisibles sans compte, décrivent sept structures de piège rapportées par des candidats (condition qui renverse selon un seuil, exception à une interdiction générale, faux ami de statut, causalité ambiguë entre facteurs d'accident, obligation confondue avec recommandation, seuil numérique précis, signal visuel ambigu) — aucun texte de question n'en est recopié ici. |
| OBS-15 | 3 | [forum.codeclic.com/questions-posees-lors-examen-code-route-t5541.html](https://forum.codeclic.com/questions-posees-lors-examen-code-route-t5541.html) | 2026-09-06 | Quatre messages visibles sans compte, dont un candidat reconstituant de mémoire une quarantaine de questions de son propre passage — un ordre de grandeur qui recoupe OBS-8, mais reste un souvenir personnel non vérifiable, relayé par un éditeur et non une question officielle. |
