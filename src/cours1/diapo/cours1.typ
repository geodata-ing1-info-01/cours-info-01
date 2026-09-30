// Cours 1 — fichier d'assemblage.
//
// Le contenu est dans `parties/` et `tds/`, un fichier par partie de l'exposé
// et par TD. Ce fichier ne porte que les réglages globaux et l'ordre des
// parties : les règles `#show` posées ici s'appliquent à tout ce qui est
// inclus ensuite.
//
//   python outils/compiler_diapos.py                # à projeter
//   python outils/compiler_diapos.py --notes        # avec les notes de conduite
//   python outils/compiler_diapos.py --corrige      # corrigé des TD
//   python outils/compiler_diapos.py --sans-tds     # le fil du cours, un sommaire par bloc de TD
//
// Conventions d'écriture : STYLE.md à la racine. Gabarits : voir
// `src/cours1/diapo/README.md`.

#import "../../commun/prelude.typ": *

#show: diapos.with(
  titre-court: "Introduction à l'informatique",
  auteur-court: "1re année géomatique",
)

// Chaque TD est un fichier de `tds/`, nommé comme le dossier que l'étudiant
// ouvre : `1e_hello_cpp.typ` pour `cours1/1e_hello_cpp/`. Le chiffre est la
// séance ; la lettre, l'ordre dans la séance.
// Chaque fichier se compile aussi seul, en feuille de TD déposée dans son
// dossier de données (`outils/compiler_tds.py`).
//
// Le fichier définit `td`, la description du TD, et l'assemblage l'importe :
// avec `--input tds=false`, chaque bloc de TD est remplacé par une seule
// diapositive, son sommaire, tirée de ces descriptions. `import` n'insère pas
// le contenu du fichier, seulement ses définitions ; c'est `include` qui le
// place. Un `include` ne peut pas prendre de chemin calculé, d'où les deux
// lignes par TD.
#let tds = sys.inputs.at("tds", default: "") != "false"

#import "tds/1a_formats.typ": td as td-1a
#import "tds/1b_archive_odt.typ": td as td-1b
#import "tds/1c_vscode_python.typ": td as td-1c
#import "tds/1d_erreurs.typ": td as td-1d
#import "tds/1e_hello_cpp.typ": td as td-1e
#import "tds/1f_markdown.typ": td as td-1f
#import "tds/1g_notebooks.typ": td as td-1g
#import "tds/1h_recette.typ": td as td-1h
#import "tds/1i_noyaux.typ": td as td-1i
#import "tds/1j_trajet.typ": td as td-1j

#include "parties/00_ouverture.typ"

#include "parties/01_logiciels.typ"
#if tds {
  include "tds/1a_formats.typ"
  include "tds/1b_archive_odt.typ"
} else {
  sommaire-td(td-1a, td-1b)
}

#include "parties/02_programmation.typ"
#if tds {
  include "tds/1c_vscode_python.typ"
  include "tds/1d_erreurs.typ"
  include "tds/1e_hello_cpp.typ"
} else {
  sommaire-td(td-1c, td-1d, td-1e)
}

#include "parties/03_markdown_notebook.typ"
#if tds {
  include "tds/1f_markdown.typ"
  include "tds/1g_notebooks.typ"
} else {
  sommaire-td(td-1f, td-1g)
}

#include "parties/04_projet_python.typ"
#if tds {
  include "tds/1h_recette.typ"
  include "tds/1i_noyaux.typ"
  include "tds/1j_trajet.typ"
} else {
  sommaire-td(td-1h, td-1i, td-1j)
}

#include "parties/99_cloture.typ"
