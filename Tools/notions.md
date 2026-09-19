# Registre des notions

Une ligne par notion, sur le modèle de [`couverture.md`](couverture.md). `Tools/audit.py`
refuse une `notion` absente de ce tableau, et une notion qui n'a aucune carte `fondation`.

Une **notion** est un cran plus fin qu'un `topic` : `Panneaux & marquage` en porte
plusieurs, et une même notion peut traverser plusieurs `topic` — c'est l'axe transversal
que `topic` ne sait pas porter. La colonne « topics concernés » le montre.

Le **rôle** est déclaré, pas déduit. Une `fondation` énonce le système (« Un panneau
triangulaire à bord rouge annonce : ») ; une `application` l'exerce sur un cas (« Ce
panneau indique : »). Aucune heuristique sur le `prompt` ne sait faire la différence.

Surchargeable par `VALIDO_NOTIONS_MD`, ce qui sert à vérifier une règle sur un cas d'essai.

| notion | topics concernés | fondations | applications | verdict |
|---|---|---:|---:|---|
