# Forme des questions `code` — diagnostic contre l'épreuve réelle

Spec du 2026-09-06. Quatrième intervention sur le contenu, après les passes 2 et 3
([`Tools/audit-2026-08-passe-2.md`](../../../Tools/audit-2026-08-passe-2.md),
[`Tools/audit-2026-08-passe-3.md`](../../../Tools/audit-2026-08-passe-3.md)) qui ont
construit les registres et vérifié chaque carte `code` contre sa source. **Celle-ci ne
corrige aucune carte** : elle mesure un écart et le chiffre.

## Le problème

Les trois passes précédentes ont vérifié une seule chose : que ce qu'une carte affirme est
vrai, et daté. Elles ont réussi — 92 URL Légifrance, un registre de fraîcheur par question,
une carte de couverture du référentiel. Aucune n'a regardé **si la question ressemble à
celle que l'examen pose**.

Ce n'est pas une omission de rédaction, c'est un angle mort documenté par son absence. Le
seul spécimen officiel de vraies questions ETG que le dépôt connaisse — le PDF
`reponsesquestionspermisauto_v1604.pdf` de la Sécurité routière — a été lu une fois, en
passe 2, uniquement pour récupérer l'étiquette du onzième thème. Ni
[`Tools/questions.md`](../../../Tools/questions.md), ni les trois specs, ni les rapports de
passe ne mentionnent le multi-réponse, le chronomètre, ni le cadrage vu du poste de
conduite.

L'écart pressenti, sur l'échantillon lu à l'ouverture de cette spec :

| Ce que fait Valido | Ce que fait l'ETG |
|---|---|
| « La pression des pneus doit être vérifiée : » | une scène, et « dans cette situation, je… » |
| 49 cartes illustrées sur 255 (19 %) | la scène est le point de départ quasi systématique |
| énoncé impersonnel, définitionnel | énoncé situé, à la première ou deuxième personne |
| une bonne réponse sur quatre | une **ou plusieurs** bonnes réponses |

**Hypothèse à confirmer ou à casser, pas prémisse.** Si la mesure dit que les cartes sont
déjà du bon côté, le rapport le dit et rien ne suit. Une intuition de forme non chiffrée est
exactement ce qui a fait monter `expl/paraphrase-litterale` en passe 3 alors que la spec
attendait une baisse.

## Ce qui est décidé, et ce qui ne l'est pas

Cinq arbitrages sont pris et ne se rouvrent pas dans cette passe :

1. **La réponse unique est gardée.** Le multi-réponse de l'ETG demanderait N taps puis un
   « Valider », donc un état où rien ne s'est encore produit — la friction que la v1 a
   écartée et que le README porte comme décision fondatrice. `Question.correctID` reste un
   singulier, `FeedViewModel.answer(_ optionID:)` reste à un argument. La fidélité se joue
   sur la formulation, le corpus et le piège, pas sur le format de réponse.
2. **La liste blanche s'ouvre aux éditeurs d'ETG, avec corroboration.** Un seul registre,
   `sources.md`, plutôt qu'un second registre de forme. La garantie est maintenue par une
   règle mécanique, pas par une interdiction (§5).
3. **Le corpus est ce qui se lit sans compte.** Aucun travail manuel demandé, aucune série
   fournie depuis un compte d'éditeur.
4. **Diagnostic avant réécriture.** Aucune carte de `questions.json` n'est touchée.
5. **La mesure est double, et la ligne de partage est écrite.** Ce qui se mécanise entre
   dans `audit.py` ; le reste se lit à la main, sur les 255 et non sur un échantillon.

Ce qui reste ouvert et sera décidé sur les chiffres du rapport : combien de cartes
réécrire, sur quels axes, dans quel ordre, et s'il faut le faire.

## 1. Le corpus

Trois strates, par autorité décroissante, et l'ordre est écrit dans le rapport parce qu'il
décide du poids de chaque observation.

**Strate 1 — le spécimen officiel.** `reponsesquestionspermisauto_v1604.pdf`
(securite-routiere.gouv.fr). Les seules vraies questions ETG publiquement disponibles.
Peu nombreuses ; ce sont les seules qui ne soient pas une approximation.

**Strate 2 — le texte de l'épreuve.** L'arrêté qui la définit, sur Légifrance : nombre de
questions, seuil de réussite, thèmes, conditions de passation. Il borne la forme sans la
décrire.

**Strate 3 — les éditeurs, en accès libre.** Ornikar, En Voiture Simone, Codeclic,
Digischool, et les pages éditoriales du type « les questions les plus ratées au code ».
Ce qui est réellement lisible sans compte n'est pas connu d'avance : **le rapport liste ce
qui a été lu et ce qui a été refusé**, avec la date, plutôt que de laisser croire à une
couverture qu'il n'a pas.

**Un point d'honnêteté qui doit figurer dans le rapport.** La banque officielle n'est pas
publique ; un éditeur produit sa propre imitation. La strate 3 mesure donc « ce que le
marché croit être une vraie question », ce qui est utile pour le piège et les fréquences,
mais n'est pas la strate 1. Aucun constat ne doit s'appuyer sur la strate 3 seule sans le
dire.

**Droit d'auteur.** On relève des formes, jamais des questions. Aucune question d'éditeur
n'est recopiée dans `questions.json` ni citée intégralement dans le rapport ; une
observation se formule en décrivant la structure (« l'énoncé pose la situation en deux
lignes puis demande l'action »), pas en reproduisant le texte.

## 2. La grille

Elle se **dérive** du corpus : chaque axe conservé doit être adossé à au moins une
observation datée, avec son URL. Un axe qu'aucune observation ne soutient est retiré, même
s'il figure ci-dessous.

| Axe | Ce qu'il oppose |
|---|---|
| Ancrage | question posée sur une scène vue du poste de conduite / savoir hors situation |
| Personne | « je », « vous » / impersonnel |
| Objet | ce que je dois **faire** / ce que la règle **dit** |
| Piège | nuance de la règle, condition qui renverse, faux ami de vocabulaire, distracteur hors sujet |
| Format | nombre et longueur des propositions |
| Poids | fréquence par thème, contre `couverture.md` |

## 3. La mesure mécanique

Quatre compteurs entrent dans `audit.py` et tournent sur les 255 cartes `code`.

- **`forme/impersonnel`** — le `prompt` ne porte ni deuxième personne (« vous », « votre »,
  « vos »), ni première (« je », « j' », « mon », « ma », « mes »), ni verbe à l'impératif
  en tête.
- **`forme/hors-situation`** — la carte n'a pas d'illustration **et** son `prompt` ne porte
  aucun déictique de situation (« ce », « cette », « ici », « devant », « vous arrivez »,
  « vous roulez », « vous approchez »).
- **`forme/definitionnel`** — le `prompt` suit un motif de définition : sujet nominal suivi
  de « est », « sert à », « signifie », « indique », « impose », « doit être », « permet
  de », et se terminant par « : ».
- **`couverture/poids`** — écart, en points, entre la part d'un thème dans les 255 et sa
  part dans le corpus.

**`couverture/poids` n'est implémenté qu'après le relevé de la distribution de référence**,
inscrite dans `couverture.md` avec sa source et sa date. Sans cette table, il mesurerait
contre du vide ; si le corpus ne permet pas de l'établir, le compteur n'est pas écrit et le
rapport dit pourquoi.

**Les quatre naissent informatifs, et c'est écrit dans `CLAUDE.md` au moment où ils sont
créés, pas après coup.** C'est la leçon de `expl/paraphrase-litterale` appliquée d'avance :
un compteur qu'on minimise pour lui-même vide les cartes de ce qu'elles enseignent. Un
énoncé impersonnel n'est pas un défaut en soi — sur une carte de mécanique ou de
signalisation, c'est peut-être la forme juste. Ces compteurs ne rejoignent **pas** la liste
de ceux qui doivent rester vides.

## 4. La lecture à la main

Les 255 cartes, par les treize domaines de la passe 3 — la découpe existe et elle a tenu.
Chaque carte reçoit un verdict sur les axes qu'aucun script n'atteint : la nature du piège,
et « cette question se poserait-elle à l'examen ». **Chaque verdict porte son motif en une
ligne**, pour être contestable carte par carte plutôt que sur un total.

Aucune carte ne sort « non examinée » : le rapport porte un tableau par domaine dont les
effectifs somment à 255.

**Là où le mécanique et la main divergent, c'est le mécanique qui a tort**, et la
divergence est elle-même un résultat : elle alimente la section « ce que l'outillage ne
voit pas », qui est la partie des rapports précédents qui a le plus servi aux suivants.

## 5. La corroboration dans `audit.py`

`audit.py:75` porte aujourd'hui un tuple `DOMAINES` de onze domaines et teste, ligne 217,
que la colonne source d'une ligne `datée` en contient **au moins un**. Il se scinde :

- `DOMAINES_FAIT` — les onze actuels, seule autorité sur un chiffre.
- `DOMAINES_FORME` — les éditeurs retenus par la passe.

Règle : **une ligne `datée` doit toujours porter une URL de `DOMAINES_FAIT` ; une URL de
`DOMAINES_FORME` est admise en plus, jamais seule.** Nouveau flag
`source/editeur-non-corrobore`, qui rejoint la liste des compteurs devant rester vides,
aux côtés de `source/hors-liste-blanche`.

Il naît vide et le reste : aucune carte ne cite d'éditeur dans cette passe. **La règle est
donc vérifiée sur une ligne d'essai fabriquée** — un `sources.md` de test portant une URL
d'éditeur seule doit faire tomber le flag — sinon elle n'est qu'une phrase dans un guide.

Le motif écrit en tête de `sources.md` (« les éditeurs d'ETG et les sites d'auto-école se
recopient et périment sans le dire ») est **conservé et reformulé**, pas effacé : il reste
la raison pour laquelle un éditeur ne peut pas porter un chiffre seul.

## 6. Le livrable

`Tools/audit-2026-09-formes.md`, dans la série existante. Il porte, dans cet ordre : le
corpus effectivement lu et ce qui a été refusé ; la grille dérivée, chaque axe adossé à son
observation ; les quatre compteurs et leur valeur initiale ; les treize tableaux de domaine ;
ce que l'outillage ne voit pas ; et **une recommandation chiffrée** — combien de cartes à
réécrire, sur quels axes, dans quel ordre — qui devient l'entrée de la décision suivante.

### Critères d'acceptation

1. Les effectifs des treize tableaux somment à 255.
2. Chaque axe de la grille porte au moins une observation datée avec son URL.
3. Chaque chiffre du rapport est reproductible par une commande écrite dans le rapport.
4. `source/editeur-non-corrobore` tombe sur la ligne d'essai, et est vide sur le registre réel.
5. La ligne de base publiée est inchangée : `lettre/reference` 1, `forme/markdown` 1,
   `forme/seule-ponctuee` 14, `longueur/plus-longue` 76, `expl/paraphrase-litterale` 20, et
   les sept catégories dures vides.
6. Les 64 tests passent.
7. Le rapport nomme ce qu'il n'a pas pu lire.

## 7. Ce qui ne bouge pas

`Valido/Resources/questions.json` — aucune carte, aucun `id`, aucune option. Le modèle, les
vues, le view model, les tests et les seuils de `BundledContentTests`. Les 255 lignes de
`sources.md` : seul son en-tête de liste blanche est réécrit.

## 8. Risques

**Les éditeurs bloquent la lecture** (compte, paywall, rendu JavaScript — `couverture.md`
documente déjà un cas de page officielle vide au `WebFetch`). Si la strate 3 revient vide,
la grille repose sur les strates 1 et 2, le rapport le dit, et son autorité sur le piège et
les fréquences baisse en conséquence. La passe reste valide ; elle ne prétend pas à ce
qu'elle n'a pas lu.

**Le corpus de strate 3 est une vitrine.** Ce qu'un éditeur publie en accès libre est ce
qu'il a choisi de montrer. Nommé dans le rapport, jamais compensé en silence.

**Les compteurs deviennent des cibles.** Traité au §3 : ils sont écrits informatifs dans
`CLAUDE.md` dès leur création.

**Le jugement à la main est celui d'un seul lecteur.** Traité au §4 : chaque verdict porte
son motif, donc se conteste carte par carte.
