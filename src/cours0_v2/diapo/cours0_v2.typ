// Présentation du module, version 2 — séance 0, projetée en ouverture de la séance 1
// (décision du 11/11/2026). Les diapositives sont dans `presentation.typ`, inclus aussi
// par `cours1_v2.typ` ; ce fichier les compile seules.
//
// « Objectif du cours » et « Objectifs du module liés à la programmation » viennent de
// l'introduction retirée du cours 1 v2 le 04/11/2026 (fichier supprimé le 11/11/2026),
// avec le tableau des demandes mis à jour d'après les séances v2. La progression, les
// notions reprises et le programme des TD sont nouveaux, et décrivent les supports v2
// tels qu'ils sont au 11/11/2026. Les deux schémas sont dans `schemas.typ`, et la page
// d'introduction du site les affiche (`src/introduction.md`).
//
//   python outils/compiler_diapos.py --cours 0_v2            # à projeter
//   python outils/compiler_diapos.py --cours 0_v2 --notes    # notes de conduite
//
// Conventions d'écriture : STYLE.md à la racine.

#import "../../commun/prelude.typ": *

#show: diapos.with(
  titre-court: "Introduction à l'informatique · présentation du module",
  auteur-court: "1re année géomatique",
)

#include "presentation.typ"
