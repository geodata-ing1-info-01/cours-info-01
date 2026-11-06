// Cours 5, version 2 — fichier d'assemblage. PROPOSITION DE TRAVAIL (WIP).
//
// 06/11/2026 : même organisation que le cours 3 v2. La partie 1 pose le problème sans détail
// de Python : réutiliser des outils existants, et les réinstaller sur un autre poste. Les
// parties 2 et 3 traitent les deux cas, un programme et une bibliothèque. La partie 4 traite
// l'environnement et le fichier de projet. La partie 5, en bonus, JupyterLab et le noyau. Les
// TD sont répartis dans l'exposé : le TD 5a après la partie 3, les TD 5b et 5c après la partie
// 4, le TD 5d, facultatif, après la partie 5.
//
// Le cours 5 de 2026 reste inchangé dans `src/cours5/`. Les schémas viennent de là, et ne
// sont pas recopiés. Le matériel sort de la séance, voir `a_reprendre/materiel.typ`, et le TD
// 5a de 2026 devient le TD 3d du cours 3. Du réseau, seuls le client et le serveur restent :
// voir `a_reprendre/reseau.typ`. Passés ailleurs : les mots de passe, les clés SSH et les
// secrets au cours 6 v2 ; la température et la consommation au cours 1 v2.
//
//   python outils/compiler_diapos.py --cours 5_v2
//   python outils/compiler_diapos.py --cours 5_v2 --notes
//   python outils/compiler_diapos.py --cours 5_v2 --corrige
//   python outils/compiler_diapos.py --cours 5_v2 --sans-tds

#import "../../commun/prelude.typ": *

#show: diapos.with(
  titre-court: "Introduction à l'informatique · cours 5, version 2 (proposition)",
  auteur-court: "1re année géomatique",
)

#let tds = sys.inputs.at("tds", default: "") != "false"

#import "tds/5a_distribution.typ": td as td-5a
#import "tds/5b_environnement.typ": td as td-5b
#import "tds/5c_description.typ": td as td-5c
#import "tds/5d_noyau.typ": td as td-5d

#let partie-1 = (
  titre: "Réutiliser des programmes et des bibliothèques",
  annonce: "Ajouter des fonctionnalités sans tout recoder, et réinstaller ensuite ces outils sur un autre poste.",
)
#let partie-2 = (
  titre: "Appeler un programme existant",
  annonce: "Lancer un programme depuis Python, et la façon dont le système le trouve.",
)
#let partie-3 = (
  titre: "Bibliothèques et autres dépendances",
  annonce: "La bibliothèque standard et les bibliothèques à installer, où elles se trouvent, et ce dont elles dépendent.",
)
#let partie-4 = (
  titre: "Environnement et fichier de projet",
  annonce: "Un dossier par projet, et les fichiers qui permettent de le recréer sur un autre poste.",
)
#let partie-5 = (
  titre: "Bonus : JupyterLab et le noyau",
  annonce: "Le client, le serveur, et le Python qui exécute un notebook.",
)

#include "parties/00_ouverture.typ"

// L'exposé.
#separateur(partie-1.titre, annonce: partie-1.annonce)
#include "parties/01_reutiliser.typ"

#separateur(partie-2.titre, annonce: partie-2.annonce)
#include "parties/02_programme.typ"

#separateur(partie-3.titre, annonce: partie-3.annonce)
#include "parties/03_bibliotheques.typ"

#if tds {
  include "tds/5a_distribution.typ"
} else {
  sommaire-td(td-5a)
}

#separateur(partie-4.titre, annonce: partie-4.annonce)
#include "parties/04_environnement.typ"

#if tds {
  include "tds/5b_environnement.typ"
  include "tds/5c_description.typ"
} else {
  sommaire-td(td-5b, td-5c)
}

#separateur(partie-5.titre, annonce: partie-5.annonce)
#include "parties/05_jupyter.typ"

#if tds {
  include "tds/5d_noyau.typ"
} else {
  sommaire-td(td-5d)
}

#include "parties/99_cloture.typ"
