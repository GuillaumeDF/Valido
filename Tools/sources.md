# Registre de fraîcheur des questions `code`

Une ligne par question `code`, **sans exception**. `Tools/audit.py` refuse une question
`code` absente de ce tableau : c'est la seule manière d'empêcher qu'une question neuve
entre sans que personne ait dit contre quoi elle a été vérifiée.

`nature` est **déclarée, pas déduite**. Aucun script ne peut décider si « le clignotant
s'utilise à chaque changement de voie » porte une valeur datable.

- `stable` — une règle sans chiffre, sans seuil, sans sanction. Colonnes `source` et
  `relevé le` vides.
- `datée` — tout seuil, barème, montant, durée ou qualification pénale. URL d'un domaine
  de la liste blanche **et** date de relevé obligatoires.

La liste blanche : `legifrance.gouv.fr`, `securite-routiere.gouv.fr`,
`service-public.gouv.fr`, `ecologie.gouv.fr`, `sante.gouv.fr`, `unece.org`,
`eur-lex.europa.eu`, `cprguidelines.eu`, `croix-rouge.fr`, `inrs.fr`. Rien d'autre : les
éditeurs d'ETG et les sites d'auto-école se recopient et périment sans le dire, ce qui est
exactement le défaut que ce registre corrige.

`audit.py` signale un relevé de plus de douze mois. Ce n'est pas une erreur, c'est une
échéance : le droit routier bouge, et la passe d'août 2026 a trouvé un chiffre périmé
depuis trois jours.

**Une page de la liste blanche peut elle-même retarder sur le texte.** Le domaine
`Alcool & stupéfiants` en a donné trois cas le 24 août 2026 : `service-public` F2886
(« Vérifié le 11 juillet 2025 ») donnait encore 2 ans et 4 500 € pour le refus de
dépistage, que la loi du 18 août 2026 avait porté à 3 ans et 9 000 € ; F31551 (« Vérifié
le 27 février 2026 ») listait encore la conduite « en état d'ivresse manifeste », délit
abrogé par cette même loi. Le « Vérifié le » n'atteste donc pas la valeur, il **date la
lecture** — et sur un chiffre récent c'est l'article consolidé de Legifrance, avec sa
ligne « Version en vigueur depuis le … », qui tranche. Une valeur relevée sur
`service-public` se recoupe avec l'article dès que sa date de vérification est antérieure
à la dernière loi du domaine.

Le tableau se remplit **domaine par domaine** : une ligne dont les colonnes `source` et
`relevé le` sont vides classe la question sans l'avoir vérifiée, et `audit.py` la signale
tant qu'elle est `datée`. Le relevé se fait en lisant la source, jamais en la devinant
depuis l'énoncé. Trié par topic pour se relire domaine par domaine.

| id | nature | affirmation vérifiée | source | relevé le |
|---|---|---|---|---|
| `22603ebb1d645f3273bc07e98ab0eb23` | datée | dépistage d'alcoolémie imposé au conducteur impliqué dans un accident « ayant occasionné un dommage corporel », et seulement possible pour « tout accident quelconque de la circulation » ; L234-3, version en vigueur depuis le 27/05/2021 (loi n° 2021-646 du 25 mai 2021, art. 66) | https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000043541041 | 2026-08-24 |
| `37fe1af42b8d810ea54ddbcc64f356fa` | datée | conduite après usage de stupéfiants : délit sans seuil de dose, constitué dès qu'« il résulte d'une analyse sanguine ou salivaire » que l'usage a eu lieu ; L235-1 I, version en vigueur depuis le 20/08/2026 (loi n° 2026-798 du 18 août 2026, art. 30) | https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000054724851 | 2026-08-24 |
| `37fe1af42b8d8118b6d3f82929eabdca` | datée | seuil de 0,50 g/L de sang ou 0,25 mg/L d'air expiré pour « les autres conducteurs », R234-1 I 2°, version en vigueur depuis le 24/08/2019 ; corroboré par service-public F2881, vérifié le 11 juillet 2025, qui donne la même équivalence | https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000038954545 | 2026-08-24 |
| `37fe1af42b8d811eae7dfa1a08ee0f64` | datée | vitesse d'élimination : « L'élimination de cette substance psychoactive est de l'ordre de 0,15 g.l-1 par heure » et « il faut donc environ 1h30 pour éliminer un verre standard de 10 g d'alcool », INRS TC 152, Références en santé au travail n° 144, décembre 2015. Borne basse 0,10 g/L corroborée, rang 2 et page non datée, par le dépliant DSR d'avril 2022 https://www.securite-routiere.gouv.fr/sites/default/files/2022-09/sr_alcool_depliant_bd_2022.pdf relevé le 2026-08-24. Aucune source de rang 1 ne chiffre ce rythme : c'est une constante physiologique, pas une valeur de droit | https://www.inrs.fr/dms/inrs/CataloguePapier/DMT/TI-TC-152/tc152.pdf | 2026-08-24 |
| `37fe1af42b8d81218099fdc3bcfd24c9` | datée | un verre standard de 10 g d'alcool pur — 25 cl à 5 degrés, 10 cl à 12 degrés — « fait augmenter l'alcoolémie de 0,2 à 0,25 g.l-1 environ », INRS TC 152, décembre 2015 ; le dépliant DSR d'avril 2022 (rang 2) retient 0,25 g/L en moyenne. Les options ont été élargies en fourchettes : la valeur unique 0,20 g/L était plus étroite que les deux sources | https://www.inrs.fr/dms/inrs/CataloguePapier/DMT/TI-TC-152/tc152.pdf | 2026-08-24 |
| `37fe1af42b8d817e8e2feffa6987ba00` | datée | délit à partir de 0,80 g/L de sang ou 0,40 mg/L d'air expiré, puni de trois ans d'emprisonnement et 9 000 € ; L234-1 I, version en vigueur depuis le 20/08/2026. L'explication portait « 4 500 €, 2 ans » : ce couple avait cessé d'être en vigueur dès le 11 juillet 2025, un an avant la loi n° 2026-798. Six points au titre du IV (« la moitié du nombre maximal »), R223-1 I fixant ce maximum à douze | https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000054724895 | 2026-08-24 |
| `37fe1af42b8d817e9b93c2546ad30ec9` | datée | contravention de la quatrième classe entre 0,50 et 0,80 g/L et « réduction de six points du permis de conduire », R234-1 IV, version en vigueur depuis le 24/08/2019 ; barème corroboré par service-public F31551, vérifié le 27 février 2026 | https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000038954545 | 2026-08-24 |
| `37fe1af42b8d81b38194dba0c15484b4` | datée | trois ans d'emprisonnement et 9 000 € d'amende pour la conduite après usage de stupéfiants, L235-1 I première phrase, version en vigueur depuis le 20/08/2026 ; l'explication opposait ces peines à un chiffre alcool périmé (2 ans, 4 500 €), retiré | https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000054724851 | 2026-08-24 |
| `37fe1af42b8d81b3b1a2f0bc28c23b22` | datée | effets de l'alcool sur le champ visuel et les réflexes. La précision « dès 0,3 g/L » est retirée : aucune source de la liste blanche ne la porte. Le dépliant DSR d'avril 2022 (rang 2, non daté) situe les conséquences « dès le premier verre » et les tient pour établies « à partir de 0,5 g d'alcool par litre de sang » ; ce seuil légal est confirmé par service-public F2881, vérifié le 11 juillet 2025 | https://www.service-public.gouv.fr/particuliers/vosdroits/F2881 | 2026-08-24 |
| `37fe1af42b8d81cf8791f73464a2f801` | datée | seuil de 0,20 g/L de sang ou 0,10 mg/L d'air expiré pour le titulaire d'un permis « soumis au délai probatoire défini à l'article L. 223-1 », donc pendant toute la période et non la seule première année ; R234-1 I 1°, version en vigueur depuis le 24/08/2019 ; corroboré par service-public F2881, vérifié le 11 juillet 2025 | https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000038954545 | 2026-08-24 |
| `37fe1af42b8d81f2a662e1b1284f99b9` | stable | seul le temps élimine l'alcool dans le sang, aucun geste ne l'accélère |  |  |
| `526ffb51f8bc0ed95490405ddc0dfc0f` | datée | à 0,4 g/L un conducteur probatoire est en infraction, son seuil étant de 0,20 g/L (R234-1 I 1°, en vigueur depuis le 24/08/2019), et l'infraction reste une contravention puisque le délit commence à 0,80 g/L (L234-1 I, en vigueur depuis le 20/08/2026) | https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000038954545 | 2026-08-24 |
| `5720fa6a7cd62743982f88a4f3fa5dd2` | datée | peine maximale du délit d'alcoolémie : trois ans d'emprisonnement et 9 000 € d'amende, L234-1 I, version en vigueur depuis le 20/08/2026 ; le couple 2 ans et 4 500 €, en vigueur jusqu'au 10 juillet 2025 et encore servi par la plupart des manuels, est recyclé en distracteur | https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000054724895 | 2026-08-24 |
| `749552ac121e0cd77beff969300b8ef9` | datée | refus de se soumettre aux vérifications d'alcoolémie : délit puni de trois ans d'emprisonnement et 9 000 € d'amende, avec réduction de la moitié du nombre maximal de points ; L234-8, version en vigueur depuis le 20/08/2026 (loi n° 2026-798, art. 7). La peine était de deux ans et 4 500 € jusqu'au 19/08/2026, et service-public F2886, vérifié le 11 juillet 2025, sert encore cet ancien chiffre : une page de rang 1 peut retarder sur le texte. L'option se référait à la « conduite en état d'ivresse manifeste », délit abrogé par la même loi au II de L234-1, et a été reformulée | https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000054724456 | 2026-08-24 |
| `a2aef876d84d666217ef6d2db811ac63` | datée | seuil de 0,20 g/L de sang ou 0,10 mg/L d'air expiré « chez le conducteur d'un véhicule de transport en commun », R234-1 I 1°, version en vigueur depuis le 24/08/2019, qui y range aussi le permis probatoire, l'apprentissage et le conducteur astreint à un éthylotest antidémarrage ; contravention de la quatrième classe et six points au titre du IV | https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000038954545 | 2026-08-24 |
| `bda97dae02fa9e085f5f6ba0827a4f7b` | datée | après un accident causé sous l'effet de l'alcool ou de stupéfiants : « votre assurance ne couvrira pas vos propres dommages », la victime « peut prétendre à une indemnisation », majoration de prime de 150 % (400 % en cas d'infractions multiples) et résiliation possible avec « un délai de préavis d'1 mois » ; service-public F2630, vérifié le 24 février 2025 | https://www.service-public.gouv.fr/particuliers/vosdroits/F2630 | 2026-08-24 |
| `e13df5a7d4151bdeca7a9f914c90cf4e` | datée | cumul alcool et stupéfiants : « les peines sont portées à cinq ans d'emprisonnement et 15 000 euros d'amende » et la confiscation du véhicule devient obligatoire sauf décision spécialement motivée ; L235-1 I seconde phrase et II 8°, version en vigueur depuis le 20/08/2026. Contradiction signalée en août et tranchée ici : les 9 points du tableau service-public F31551 (vérifié le 27 février 2026) ne heurtent pas le plafond de huit points de R223-2, qui ne vise que « plusieurs infractions entraînant retrait de points commises simultanément » ; le IV de L235-1 retire « par dérogation à l'article L. 223-2 » les trois quarts du nombre maximal de points, soit 9 des 12 de R223-1 I, pour une infraction unique. Aucune question ne s'appuie sur ce chiffre, conformément au plan | https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000054724851 | 2026-08-24 |
| `ef26cca38b9d1abc6fb0b13d76247f35` | datée | éthylotest antidémarrage : interdiction de conduire un véhicule qui n'en est pas équipé, jusqu'à cinq ans comme peine complémentaire du délit (L234-2 I 7°, en vigueur depuis le 20/08/2026) et jusqu'à trois ans pour la contravention (R234-1 III 2°, en vigueur depuis le 24/08/2019) ; l'inobservation est punie de deux ans et 4 500 € (L234-16, en vigueur depuis le 30/09/2021). Ligne passée de `stable` à `datée` : le régime porte des durées et une qualification pénale | https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000054724874 | 2026-08-24 |
| `0a4e98c4605ec20320f13dec75f7bb9c` | stable | portée d'un marquage jaune continu (interdiction d'arrêt et de stationnement) |  |  |
| `37fe1af42b8d811198bdecd01768828c` | datée | amende et points pour un stationnement dangereux (135 €, 3 points) |  |  |
| `37fe1af42b8d811b96fdf80a7a546c1e` | stable | côté de stationnement autorisé sur une chaussée à double sens en agglomération |  |  |
| `37fe1af42b8d812cad07c40f6c51598c` | stable | critères distinguant l'arrêt du stationnement (durée et présence du conducteur) |  |  |
| `37fe1af42b8d8134ad4be3c7e29328f1` | datée | amende pour un stationnement très gênant sur un passage piéton (135 €) |  |  |
| `37fe1af42b8d8148bc29ede5a0015edd` | stable | emplacement recommandé pour s'arrêter hors agglomération (l'accotement) |  |  |
| `37fe1af42b8d8166847cf95009550b0a` | datée | obligation du disque en zone bleue et durée gratuite habituelle (souvent 1 h 30) |  |  |
| `37fe1af42b8d8181a057c984708f0042` | datée | amende pour un stationnement gênant simple (35 €), distincte du très gênant (135 €) |  |  |
| `37fe1af42b8d81d793bcc927205f9d79` | datée | classement et amende du stationnement sur une voie réservée aux bus (très gênant, 135 €) |  |  |
| `37fe1af42b8d81e2b806fb6055602586` | stable | précautions à prendre avant de quitter une place de stationnement |  |  |
| `37fe1af42b8d81e9b314fcb5ac447202` | datée | durée au-delà de laquelle un stationnement est jugé abusif (7 jours) |  |  |
| `37fe1af42b8d8104b119f947eb9e296d` | datée | distance parcourue pendant le temps de réaction à 50 km/h (environ 14 m) |  |  |
| `37fe1af42b8d811f9954e63cf1aa9ffa` | datée | coefficient utilisé pour estimer la distance de réaction (chiffre des dizaines × 3) |  |  |
| `37fe1af42b8d812c9bb4e393d72d6df0` | datée | effet du doublement de la vitesse sur la distance de freinage (multipliée par 4) |  |  |
| `37fe1af42b8d812db558cb9e19e11709` | datée | intervalle de sécurité minimal recommandé avec le véhicule précédent (2 secondes) |  |  |
| `37fe1af42b8d815a8de7c20835afd6ac` | datée | distance correspondant à un intervalle de sécurité de 2 secondes à 130 km/h (environ 72 m) |  |  |
| `37fe1af42b8d817eb292c10d8effbad4` | stable | composition de la distance d'arrêt (distance de réaction + distance de freinage) |  |  |
| `37fe1af42b8d81e48a72e74c9a2454a2` | datée | effet de la pluie sur la distance de freinage (à peu près doublée) |  |  |
| `37fe1af42b8d81e7a041ff53b8ef69c2` | datée | amende et points pour non-respect des distances de sécurité (135 €, 3 points) |  |  |
| `37fe1af42b8d81e98af3c07ec3728454` | datée | temps de réaction moyen retenu pour un conducteur (environ 1 seconde) |  |  |
| `37fe1af42b8d81ef84ffe4578802422a` | datée | amende et points pour usage du téléphone en main allongeant le temps de réaction (135 €, 3 points) |  |  |
| `37fe1af42b8d81038eabdcd0f319857c` | stable | situations imposant l'usage du clignotant (changement de direction ou de voie) |  |  |
| `37fe1af42b8d8118ab59f3f1a651bb26` | stable | signification d'un feu jaune clignotant (passage prudent selon les règles de priorité) |  |  |
| `37fe1af42b8d81659d11e27049af398e` | datée | points retirés pour franchissement d'un feu rouge fixe (4 points) |  |  |
| `37fe1af42b8d8189a735d41a796aafb6` | stable | condition de passage à un feu vert (intersection dégagée) |  |  |
| `37fe1af42b8d8193887bfe48eab17d43` | stable | conditions d'obligation des feux de croisement (nuit et visibilité réduite) |  |  |
| `37fe1af42b8d81adbe05ccc6da87aef7` | stable | usage des feux de détresse (signaler un danger ou un ralentissement brutal) |  |  |
| `37fe1af42b8d81b1b37feb613e893fbf` | datée | conditions d'utilisation des feux arrière antibrouillard (brouillard/neige, article R416-7) |  |  |
| `37fe1af42b8d81c8af99ca09e3710b01` | stable | passage en feux de croisement au croisement d'un véhicule de nuit |  |  |
| `37fe1af42b8d81df975dea92682dad6c` | stable | signification d'un feu rouge clignotant (arrêt absolu) |  |  |
| `37fe1af42b8d81fc9bbbee0a1767bba6` | stable | conduite à tenir au feu orange fixe (arrêt, sauf danger à freiner) |  |  |
| `37fe1af42b8d81139920e49f3f7b6b59` | datée | signification du témoin d'usure d'un pneu (limite légale de profondeur, 1,6 mm) |  |  |
| `37fe1af42b8d81209e09c493195df716` | stable | signification d'un témoin rouge au tableau de bord (anomalie grave, arrêt nécessaire) |  |  |
| `37fe1af42b8d8123abc0da9b2b7a51e0` | stable | fonction de la vignette Crit'Air (classement des véhicules selon leurs émissions) |  |  |
| `37fe1af42b8d814289adf64bd5b05d0e` | stable | équipements de sécurité obligatoires à bord d'une voiture (gilet, triangle) |  |  |
| `37fe1af42b8d814ba731d0f9dafb6945` | stable | technique recommandée en longue descente pour éviter la surchauffe des freins (frein moteur) |  |  |
| `37fe1af42b8d8158a15ac34f4b0e4be9` | stable | niveaux à surveiller régulièrement sur un véhicule (huile, refroidissement, frein, lave-glace) |  |  |
| `37fe1af42b8d81b99c05ef1ffdacc30e` | stable | signification d'un témoin orange au tableau de bord (anomalie à surveiller) |  |  |
| `37fe1af42b8d81c89e88db8c08ca8514` | stable | principes de l'éco-conduite (anticipation, régime moteur modéré) |  |  |
| `37fe1af42b8d81deaec0cb8830fa0b25` | datée | profondeur minimale légale des sculptures d'un pneu (1,6 mm) |  |  |
| `37fe1af42b8d81f4b915cd58b951d9e4` | datée | moment de contrôle de la pression des pneus et correction à chaud (+0,3 bar) |  |  |
| `11d37be22fd315668cb2930373e95c80` | stable | portée du B31 : il lève les interdictions signalées, non celles qui découlent d'un texte général comme l'agglomération (IISR 4e partie, art. 68-1) |  |  |
| `1a0a5812ff8659ba24b3b4c750e469e5` | stable | interdiction imposée par la partie continue d'une ligne mixte (dépassement et franchissement) |  |  |
| `37fe1af42b8d81059d80e8954b36ed7f` | stable | signification d'un panneau rond à liseré rouge (interdiction, applicable ici) |  |  |
| `37fe1af42b8d8141b1d0e3ca0b855119` | datée | interdiction du franchissement **et** du chevauchement d'une ligne continue, seule exception étant le chevauchement pour dépasser un cycle, un cyclomobile léger ou un engin de déplacement personnel motorisé ; 3 points et 1 point (R412-19, version en vigueur depuis le 16 janvier 2022) | https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000039278107/ | 2026-08-24 |
| `37fe1af42b8d81699c2ffbefd648d9a3` | stable | signification d'un panneau rond à fond bleu (obligation) |  |  |
| `37fe1af42b8d81709c93fcc98510a42d` | stable | obligation portée par les flèches de rabattement : emprunter la voie située du côté qu'elles indiquent (IISR 7e partie, art. 115-3, B) |  |  |
| `37fe1af42b8d8174a3c3e94967027ed1` | stable | portée du B21b : obligation d'aller tout droit **à la prochaine intersection**, le B21-1 étant celui qui impose de tourner avant lui (IISR 4e partie, art. 65, A et B) |  |  |
| `37fe1af42b8d817881dee3d999a911c3` | stable | nature informative des panneaux carrés (type C) contre nature prescriptive des panneaux ronds (type B) — IISR 5e partie, art. 69-1 et 4e partie, art. 45 |  |  |
| `37fe1af42b8d81b3a4b7d484aef5aef8` | stable | règle de lecture d'une ligne mixte : franchissable seulement si la discontinue est la plus proche du véhicule au début du dépassement (IISR 7e partie, art. 113, A) |  |  |
| `37fe1af42b8d81b5aa9fc685af3ba92f` | stable | signification d'un panneau triangulaire à liseré rouge (danger à venir), implanté 100 à 200 m en amont hors agglomération (IISR 2e partie, art. 21 et 25) |  |  |
| `37fe1af42b8d81d68a70da4a7305f6c1` | stable | portée des hachures : elles couvrent les surfaces normalement inutilisées d'une zone non circulable, inclinaison 2 pour 1 (IISR 7e partie, art. 117, A) |  |  |
| `37fe1af42b8d81f8a2f3f8bd2afc9d2d` | stable | portée d'une ligne discontinue axiale (franchissement autorisé) |  |  |
| `3cb86b6e4c489d919a495408021f062a` | datée | points retirés pour chevauchement (1 point) et franchissement (3 points) d'une ligne continue axiale ou séparative (R412-19, version en vigueur depuis le 16 janvier 2022) | https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000039278107/ | 2026-08-24 |
| `443e4299ccb3ff71669f8df6669b8bf4` | stable | forme octogonale exclusive au panneau STOP (IISR 1re partie, art. 5-1) et arrêt inconditionnel qu'il impose (IISR 3e partie, art. 42-2, E) |  |  |
| `5a4e6a38ad3e1153f807ec5e0e6ba40e` | stable | ce que délimite une ligne discontinue en bord de chaussée (bande d'arrêt d'urgence ou accotement) |  |  |
| `9eb8506813f0c8b729b66157ec95a63f` | stable | priorité à l'anneau dans un carrefour à sens giratoire annoncé par panneau |  |  |
| `dce501d416e5db1cc6344725007fbad6` | stable | obligation de céder le passage sans arrêt au panneau cédez-le-passage |  |  |
| `1509ad94aea7c6f82355f3362b10a8e1` | stable | portée du B6d : « la réglementation de l'interdiction de l'arrêt inclut celle du stationnement » (IISR 4e partie, art. 55-3, A, 1) |  |  |
| `1658abbc16db4667fec7211f8c9b0f93` | stable | portée du B6a1 : l'interdiction ne vaut que du côté où le panneau est posé, et jusqu'à la prochaine intersection (IISR 4e partie, art. 55, A, 2) |  |  |
| `570e5e1ef861e032773f43b44bc817a9` | stable | damier rouge et blanc réservé au marquage des voies de détresse, « destinées à arrêter un véhicule en perdition » (IISR 7e partie, art. 113-1, A, 3 et art. 118-10) |  |  |
| `7d44f7dd303fce58716234cba54480b1` | stable | portée de l'AB7 : sans panonceau de distance, il annonce la perte de priorité au prochain carrefour (IISR 3e partie, art. 42-3, B) |  |  |
| `89bea09b482974f37e7dd7d35aba23f5` | stable | l'A13b n'existe qu'en signalisation avancée du passage piéton, la position étant tenue par le marquage au sol (IISR 2e partie, art. 40 ; 7e partie, art. 118) |  |  |
| `8a1026edb35c31c37ab6df7b29851ef2` | stable | portée du B1 : « indique au début des chaussées en sens unique que les véhicules peuvent seulement y circuler en sens inverse » (IISR 4e partie, art. 50-1) |  |  |
| `9e65525bbce6a6491d37bbf6f180c04c` | stable | portée du B3 : interdiction de dépasser « tous les véhicules à moteur autres que les véhicules à deux roues sans side-car » (IISR 4e partie, art. 52) |  |  |
| `ede6968609d285b22494f57032c53e2f` | stable | le C113 signale une voie « conseillée et réservée » aux cyclistes ; la piste ou bande *obligatoire* relève de la prescription (IISR 5e partie, art. 75-3) |  |  |
| `ee11b58d97d21d637c3ec38c7181fa87` | stable | rôle du panonceau : « donner une ou des informations supplémentaires à celles du signal », et l'A14 « doit autant que possible être complété par un panonceau M9 précisant la nature du danger » (IISR 1re partie, art. 9-1, B ; 2e partie, art. 41) |  |  |
| `f12ee5bea85947a13d387f574e817337` | stable | principe de cohérence de la signalisation temporaire : un panneau permanent contredit par une signalisation de chantier « doit alors être masqué provisoirement » (IISR 8e partie, art. 120, B) — donc seule la signalisation temporaire reste en vigueur, et c'est elle que le conducteur suit |  |  |
| `2b6972fab03433e709d73ccc5a949ac9` | datée | délai de récupération automatique du capital de points (2 ans, ou 3 ans avec délit) |  |  |
| `2d45cedf9b3d349027d751f7aa672d6a` | datée | qualification et peine pour conduite sans permis jamais obtenu (délit, 1 an, 15 000 €) |  |  |
| `37fe1af42b8d8132a22dde248e277c2b` | datée | points retirés pour usage du téléphone tenu en main au volant (3 points) |  |  |
| `37fe1af42b8d8158b3dbf9883bf83560` | datée | points récupérés par un stage de sensibilisation (4 points au maximum, une fois par an) |  |  |
| `37fe1af42b8d8174b45bd538ca3a9483` | datée | capital de points initial en permis probatoire (6 points) |  |  |
| `37fe1af42b8d81b6a955d17c158afb3c` | datée | durée pour atteindre 12 points en conduite accompagnée (2 ans, +3 points/an) |  |  |
| `37fe1af42b8d81b7acdacd2079297f09` | datée | amende et points pour défaut de port de la ceinture (135 €, 3 points) |  |  |
| `37fe1af42b8d81c593b3e0a4cb5bb76d` | datée | durée de la période probatoire (3 ans, ou 2 ans en conduite accompagnée) |  |  |
| `37fe1af42b8d81d09328df58d56a4dc6` | datée | durée d'obligation du disque « A » (toute la période probatoire, pas seulement la première année) |  |  |
| `37fe1af42b8d81d29ceac642002e46d1` | datée | délai de récupération d'un point unique perdu (6 mois) |  |  |
| `37fe1af42b8d81ecb163c6b59334b160` | datée | conséquence de l'invalidation du permis à 0 point (repasser interdit pendant 6 mois) |  |  |
| `37fe1af42b8d81ed800ecde73e28760a` | datée | capital maximal de points d'un permis classique (12 points) |  |  |
| `3e99bcc374a5538e9af609b3038f08ad` | datée | peine de base pour homicide routier (7 ans, 100 000 €) et seuil d'aggravation |  |  |
| `666bb472f111a4f4634a0e30abdf180a` | datée | plafond de retrait de points pour des infractions simultanées (8 points) |  |  |
| `37fe1af42b8d810ca665ffa0e4b32ab7` | datée | numéro d'appel d'urgence européen unique (112) et sa disponibilité sans SIM ni réseau |  |  |
| `37fe1af42b8d8122b00cdea4e4368822` | datée | numéro d'appel des sapeurs-pompiers (18), distinct du SAMU (15) et de la police (17) |  |  |
| `37fe1af42b8d81418280fb4ce8ce85d2` | stable | geste correct face à une hémorragie abondante (compression continue de la plaie) |  |  |
| `37fe1af42b8d8175a7fccbffc2d6bcfa` | stable | condition pour déplacer une victime d'accident (danger immédiat uniquement) |  |  |
| `37fe1af42b8d817b9035c1079ede5c00` | datée | distance de mise en place du triangle de présignalisation (environ 30 m, article R416-19) |  |  |
| `37fe1af42b8d817bb145f7084044c24e` | stable | informations à transmettre lors d'un appel aux secours (lieu, nombre de victimes, état) |  |  |
| `37fe1af42b8d81a092bee8d2faab6224` | stable | consigne relative au casque d'un motard accidenté (ne pas le retirer avant les secours) |  |  |
| `37fe1af42b8d81b592ede04857b093b4` | stable | position à adopter pour une victime inconsciente qui respire (position latérale de sécurité) |  |  |
| `37fe1af42b8d81f1b1cdfef31d2461b8` | stable | ordre des étapes face à un accident (protéger, alerter, secourir) |  |  |
| `37fe1af42b8d81f7a214d5130ad370f4` | stable | gestes de protection d'une zone d'accident (balisage, feux de détresse, gilet) |  |  |
| `5fe77bbd3af80ab119da8b5a2686b39c` | stable | conduite à tenir seul face à une victime consciente coincée (alerter et rester, ne pas dégager) |  |  |
| `7d456e77187812e3a27ca828062d7938` | datée | ordre des gestes de réanimation (alerter, masser, défibriller) et perte de chances de survie par minute (environ 10 %) |  |  |
| `b9e656cbd3507444669c24c85777cb54` | datée | absence de condition de formation pour l'usage d'un défibrillateur automatisé externe |  |  |
| `09f18973aee39386ee42782f04d03ec2` | stable | obligation de céder le passage lors d'un tourne-à-gauche hors intersection réglée |  |  |
| `02f7d6a65856887348bfe8653bb90c6e` | stable | usage du clignotant droit avant de quitter l'anneau d'un giratoire : R412-10 impose d'avertir de son intention, le moment relève de la pratique enseignée |  |  |
| `2a9e02b9719028e72fde6fdd6372a1ff` | datée | refus de priorité au piéton qui s'engage ou manifeste clairement l'intention de traverser : 6 points, R415-11 en vigueur depuis le 19/09/2018 ; barème corroboré par service-public F31551, vérifié le 27/02/2026 | https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000037411323 | 2026-08-24 |
| `2daf8939fc85f5b288010cf545bb681d` | stable | R415-10 ne vaut qu'au carrefour à sens giratoire : sans la signalisation qui le désigne, un rond-point reste soumis à la priorité à droite de R415-5 |  |  |
| `3e5d97761594126d37652be2e0e976dc` | stable | règle qui reprend à un carrefour dont les feux sont hors service : la priorité à droite de R415-5, faute d'agent, de panneau ou de marquage |  |  |
| `37fe1af42b8d812fade7d79d309e4c48` | stable | priorité aux véhicules déjà engagés dans un carrefour à sens giratoire |  |  |
| `37fe1af42b8d815f8684e4cc91d6950f` | stable | priorité du feu tricolore sur un panneau de priorité contradictoire |  |  |
| `37fe1af42b8d8161be32fe2fe9808fff` | stable | obligation de céder le passage sans arrêt obligatoire au panneau cédez-le-passage |  |  |
| `37fe1af42b8d817da9fff3054d6ffa3a` | stable | hiérarchie de priorité entre agent, feu, panneau et marquage (l'agent au sommet) |  |  |
| `37fe1af42b8d818293f3f8d862a5a505` | datée | céder le passage « en toutes circonstances » aux véhicules d'intérêt général prioritaires annonçant leur approche, 4 points, R415-12 en vigueur depuis le 01/06/2001 ; nuance radar corroborée, rang 2 (page non datée), par https://www.securite-routiere.gouv.fr/les-medias/les-faq/faq-radar/suis-je-sanctionne-si-je-grille-un-feu-pour-laisser-passer-un-vehicule relevé le 2026-08-24 : pas d'avis de contravention automatique, sauf si le véhicule d'urgence est lui-même flashé ; sinon un contrôle humain décide | https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000006842252 | 2026-08-24 |
| `37fe1af42b8d8184beb9c6687c92ffb5` | stable | signification du panneau losange jaune barré (fin de route à caractère prioritaire) |  |  |
| `37fe1af42b8d818fb7c9efba6c63d91d` | stable | priorité à droite par défaut en l'absence de toute signalisation |  |  |
| `37fe1af42b8d81bd9426eabc80ab4a05` | datée | arrêt au STOP « à la limite de la chaussée abordée » et 4 points, R415-6 en vigueur depuis le 01/06/2001 ; barème corroboré par service-public F31551, vérifié le 27/02/2026 | https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000006842245 | 2026-08-24 |
| `37fe1af42b8d81d6aef7ff0b8d193d7f` | stable | signification du panneau losange jaune (route à caractère prioritaire) |  |  |
| `37fe1af42b8d81fa9debeaf114b7bf77` | stable | priorité de passage du matériel roulant sur voie ferrée établie sur la route ou la traversant à niveau, intersection ou non (R422-3 I), un tramway restant tenu par la signalisation à prescriptions absolues |  |  |
| `43dc08f7c9ebc00497a4022e24319683` | stable | obligation d'arrêt complet à la ligne au panneau STOP, avant de céder le passage |  |  |
| `6e1a51d34b4b79e4366d6566795e5151` | stable | croisement difficile sur forte déclivité : le véhicule descendant s'arrête le premier (R414-3 I) et recule, sauf si c'est manifestement plus facile pour celui qui monte, près d'une place d'évitement (R414-3 III) |  |  |
| `700316a2fd86db7d682be208673c92d5` | stable | fonction du sas cycliste (placer les cyclistes devant les voitures à l'arrêt) |  |  |
| `8e9464777a61dba3859e3ecc08f7327d` | stable | priorité conférée par le panneau losange jaune sur la route transversale |  |  |
| `b433eefe7ea3ce149e6d6dd09e958a00` | datée | panonceau M12 créé par l'arrêté du 12 janvier 2012 (JO du 27/01/2012) : triangle pointe en bas, fond blanc bordé de rouge, pictogramme jaune, toujours associé à un feu tricolore ; franchissement « en toute prudence et en respectant la priorité de passage accordée aux autres usagers » | https://www.legifrance.gouv.fr/jorf/id/JORFTEXT000025202146 | 2026-08-24 |
| `dd4c58febe771b6f297f1ca46c2ec75b` | stable | priorité à l'anneau d'un giratoire, qui arrive toujours par la gauche |  |  |
| `defefbae1ae651a95dd247e38524ee36` | datée | refus de priorité entre véhicules à une intersection : 4 points, R415-5 en vigueur depuis le 01/06/2001 ; barème corroboré par service-public F31551, vérifié le 27/02/2026 | https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000006842244 | 2026-08-24 |
| `e0f68dd1324f9a5ffaab945a3d59e197` | stable | obligation de céder le passage en sortant d'un parking vers la chaussée |  |  |
| `e93ca4d156de5854eafce9393be39274` | stable | règle de priorité à droite appliquée à une insertion en T ou en croix |  |  |
| `ef4cfd171e0e9911a2619b3b06336216` | stable | priorité du tramway quel que soit le côté d'où il arrive, sans condition de signal sonore (R422-3 I), le tramway restant tenu par la signalisation à prescriptions absolues |  |  |
| `f255331d3f234810a4807594b43b397f` | stable | priorité à droite par défaut en l'absence de signalisation |  |  |
| `04182c9bbdeb305e21532f9c6913a2a2` | datée | points retirés pour un excès de vitesse de 40 à moins de 50 km/h (4 points, suspension possible) | https://www.service-public.gouv.fr/particuliers/vosdroits/F19460 | 2026-08-23 |
| `07ef459de55adcb501694169428ffd72` | stable | sens du disque à liseré rouge (B14) : une vitesse maximale, valable sur le seul axe où il est planté |  |  |
| `14eb253e5dc55f5633de9263f541bf91` | datée | excès inférieur à 5 km/h : aucun point retiré, amende de 68 € ou 135 € (décret n° 2023-1150 du 6 décembre 2023, en vigueur le 1ᵉʳ janvier 2024, confirmé) | https://www.service-public.gouv.fr/particuliers/vosdroits/F19460 | 2026-08-23 |
| `25390f0f30dbb6402091dc226d63db35` | stable | la vitesse à l'approche d'un chantier est celle qu'affiche la signalisation temporaire |  |  |
| `337bfcb4d034b62de5fe0d77ca0cb0a0` | datée | qualification délictuelle du grand excès de vitesse (≥50 km/h) depuis le décret du 22 décembre 2025 | https://www.service-public.gouv.fr/particuliers/actualites/A18723 | 2026-08-23 |
| `37fe1af42b8d812c957fc3415785f6d6` | datée | vitesse maximale en zone de rencontre (20 km/h) et priorité du piéton sur les véhicules, R110-2 (nuance « sauf transports guidés » corroborée par le code de la rue) | https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000039277970 | 2026-08-23 |
| `37fe1af42b8d81589410cd055e66efc2` | datée | vitesse maximale par défaut en agglomération (50 km/h) | https://www.service-public.gouv.fr/particuliers/vosdroits/F19460 | 2026-08-23 |
| `37fe1af42b8d815ba42acef16b3119a8` | datée | vitesse minimale imposée sur la voie la plus à gauche d'autoroute (80 km/h, circulation fluide) | https://www.service-public.gouv.fr/particuliers/vosdroits/F19460 | 2026-08-23 |
| `37fe1af42b8d816b8bf5d51c4f78466c` | datée | points retirés pour un excès de vitesse de 30 km/h (3 points) | https://www.service-public.gouv.fr/particuliers/vosdroits/F31551 | 2026-08-23 |
| `37fe1af42b8d817994d5f81863c7e6ae` | datée | vitesse limite hors agglomération sur route à double sens sans séparateur central (80 km/h, 90 sur décision locale) | https://www.service-public.gouv.fr/particuliers/vosdroits/F19460 | 2026-08-23 |
| `37fe1af42b8d817a9111e3d52f9e5142` | datée | grand excès ≥50 km/h : 6 points et peines du délit depuis le 29 décembre 2025 (300 € forfaitaire, 3 mois, 3 750 €) | https://www.service-public.gouv.fr/particuliers/actualites/A18723 | 2026-08-23 |
| `37fe1af42b8d818da27dc338f75795fe` | datée | réduction de vitesse sous la pluie sur route à chaussées séparées limitée à 110 (100 km/h) | https://www.service-public.gouv.fr/particuliers/vosdroits/F19460 | 2026-08-23 |
| `37fe1af42b8d819e9620e4637f95e464` | datée | vitesse maximale autorisée sur autoroute en période probatoire (110 km/h), R413-5 | https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000006842183 | 2026-08-23 |
| `37fe1af42b8d81d0bf26d67c5f0ff047` | datée | vitesse maximale sur autoroute par temps de pluie (110 km/h) | https://www.service-public.gouv.fr/particuliers/vosdroits/F19460 | 2026-08-23 |
| `37fe1af42b8d81f9ae87db1419280902` | datée | vitesse limite par visibilité inférieure à 50 m (50 km/h, tous réseaux) | https://www.service-public.gouv.fr/particuliers/vosdroits/F19460 | 2026-08-23 |
| `3adc294978b6ac1f640c45e121a0e4f5` | stable | sens du disque barré d'une oblique (B33) : fin de la limitation, retour à la limite générale de la route |  |  |
| `61eed52d453ac9d8ab59af70dae8eb3e` | datée | les plafonds du permis probatoire ne relèvent jamais une limite affichée plus basse (110 / 100 / 80), R413-5 | https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000006842183 | 2026-08-23 |
| `87c63a1be4e005f6c846d7798756696f` | datée | plafond de vitesse probatoire sur route à chaussées séparées limitée à 110 (100 km/h), R413-5 | https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000006842183 | 2026-08-23 |
| `cac0f9db162887802d4fb15ba97d768f` | datée | vitesses et priorité piétonne comparées : zone 30 (30 km/h), zone de rencontre (20 km/h), aire piétonne (allure du pas), R110-2 | https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000039277970 | 2026-08-23 |
| `ed0e45e08fb4f47007934da587b5757c` | datée | vitesse de la zone 30 (30 km/h), R110-2 ; portée zonale (rues sécantes comprises) corroborée par le guide technique zone 30 | https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000039277970 | 2026-08-23 |
| `f7370daabea929065f6b2586ca3eea91` | datée | vitesse limite hors agglomération sur une section à deux voies dans le même sens sans terre-plein (90 km/h) | https://www.service-public.gouv.fr/particuliers/vosdroits/F19460 | 2026-08-23 |
| `fed604fe7c4b8b3b96adc066a7902138` | datée | vitesse limite hors agglomération sur route à chaussées séparées par terre-plein central (110 km/h, 100 sous la pluie) | https://www.service-public.gouv.fr/particuliers/vosdroits/F19460 | 2026-08-23 |
