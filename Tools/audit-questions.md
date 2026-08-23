# Prompt d'audit des questions

À coller dans une session neuve, à la racine du projet. Refonte après la passe d'août 2026 :
les chiffres et les seuils ci-dessous décrivent l'état **courant**, pas celui de la v1.

---

Audite les 302 questions de Valido : `Valido/Resources/questions.json`.

Lis d'abord `Tools/questions.md` : il contient les 7 règles de distracteur, la règle de
condensation et les 9 pièges de forme déjà établis. Ne les réinvente pas, applique-les.
`Tools/audit-2026-08.md` liste ce que la passe précédente a corrigé et ce qu'elle a laissé
ouvert — commence par là, pour ne pas refaire un travail déjà fait.

**Pour chaque question, vérifie trois choses :**

1. **Clarté** — l'énoncé n'a qu'une lecture possible, et aucune option autre que la bonne
   n'est défendable.
2. **Forme** — la bonne réponse n'est ni la plus longue ni la seule détaillée ; aucun mot de
   l'énoncé n'apparaît uniquement dans elle ; les quatre options partagent la même
   construction grammaticale. Les options sont mélangées à l'exécution : aucune référence de
   lettre nulle part, ni dans les options ni dans l'explication.
3. **Explication** — elle explique le pourquoi, elle ne paraphrase pas la bonne réponse.

**Pour les 128 questions `subject: "code"`, vérifie en plus la conformité au code de la
route français en vigueur** : vitesses, barème de points, seuils d'alcoolémie et peines,
qualifications (contravention / délit), période probatoire, ZFE et Crit'Air, équipements
obligatoires, premiers secours. Sources autorisées : Legifrance, securite-routiere.gouv.fr,
service-public.gouv.fr. Cite la source **et sa date** pour chaque correction. En cas de
doute, signale au lieu de corriger. Quand une valeur a changé, recycle l'ancienne en
distracteur : c'est ce qu'un candidat aura lu ailleurs.

**Deux chantiers laissés ouverts par la passe d'août 2026**, à traiter en priorité :

- La **loi n° 2026-798 du 18 août 2026** modifie L224-1, L233-1, L235-1 et introduit des
  renvois à L236-1 / L236-2. Seul L235-1 a été balayé. Rétention du permis et rodéos restent
  à vérifier — en tenant compte de la décision n° 2026-915 DC du 14 août 2026, qui a censuré
  une partie du texte.
- **ZFE et Crit'Air** : la page ministérielle qui les maintient comme obligatoires datait
  déjà d'un an, contre un vote de suppression à l'Assemblée. À retrancher sur une source
  fraîche.

**Étoffe où c'est utile.** Les sections `swift` minces ont été portées à 8 (Testing,
Networking, AI, Sécurité, Monétisation) ; `Données` est à 7. Côté `code`, six thèmes sont
montés à 13–16, quatre restent à 10 : Feux, Distances & freinage, Arrêt & stationnement,
Mécanique & environnement. Même schéma, mêmes règles.

**Passe le script avant d'écrire** : `python3 Tools/audit.py`. Tout doit être à zéro sauf
`longueur/plus-longue` (informatif), et deux faux positifs connus, documentés au §3 de
`Tools/questions.md` : la lettre ancrée par l'énoncé (« Le « D » de SOLID ») et le
`` `/** */` `` de la question DocC.

**Contraintes dures :**

- Schéma inchangé. `id` existants préservés — ceux des 250 questions d'origine sont des UUID
  de page Notion, les autres un SHA-256 de l'énoncé préfixé `valido-v2:`.
- **Notion n'est plus la source.** Le JSON fait foi : pas de ré-import, pas de
  synchronisation.
- `BundledContentTests` fonctionne en seuils (≥ 295 / ≥ 125 / ≥ 170), pas en égalités. Si tu
  fais varier le volume de plus de quelques questions, mets les seuils à jour.
- Ne touche pas aux deux tests de forme (`laBonneRéponseNeDépassePas…`,
  `aucuneOptionNeCommenceParUneLettreDeRéponse`) : un échec se corrige dans les données.
- Cette commande doit rester verte :
  `DEVELOPER_DIR=/Applications/Xcode-26.3.0.app xcodebuild test -project Valido.xcodeproj -scheme Valido -destination 'platform=iOS Simulator,name=iPhone 17'`
  Un échec sur `Application failed preflight checks` / `Busy` est un simulateur coincé, pas
  ton code : change de device.
- Le dépôt distant est `github.com/GuillaumeDF/Valido` (privé, branche `main`), mais le
  dossier local n'est pas encore un dépôt git : **aucun retour possible**. Pas de commit ni
  de push sans demande explicite, et aucune suppression ou renommage de fichier sans
  validation.

**Rends un rapport** : corrections légales avec source et date, défauts de forme corrigés
avec les chiffres avant/après, questions ajoutées par section, et la liste de ce que tu n'as
pas pu trancher.
