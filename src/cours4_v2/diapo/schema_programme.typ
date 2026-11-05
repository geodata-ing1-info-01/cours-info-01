// Le schéma des étapes du programme d'un TD, seul sur une page ajustée, pour
// en faire une image PNG placée en tête du notebook :
//
//   typst compile --root . --input td=montre --format png --ppi 110 \
//     src/cours4/diapo/schema_programme.typ programme_montre.png
//
// Appelé par `data/cours4/make_data.py build`.
#import "../../commun/prelude.typ": *
#import "schemas.typ": programme-montre, programme-tourbillon, programme-train

#set page(width: 27cm, height: auto, margin: 10pt, fill: white)
#set text(font: police-texte, size: 13pt, fill: accent, lang: "fr")
#show raw: set text(font: police-code)

#let td = sys.inputs.at("td", default: "montre")
#if td == "tourbillon" {
  programme-tourbillon()
} else if td == "train" {
  programme-train()
} else {
  programme-montre()
}
