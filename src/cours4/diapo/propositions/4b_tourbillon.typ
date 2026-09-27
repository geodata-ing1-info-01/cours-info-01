// TD 4b du cours 4 — « La Vague en tourbillon ».
//
// Inclus par `cours4.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`, qui
// en tire la feuille `td_4b_tourbillon.pdf`. Les étapes en résumé : le
// détail, avec le code à coller, est dans le guide `guide_4b_tourbillon.pdf`.
// Les étapes sont celles du TD 4a (`etapes-animation`, dans `schemas.typ`).
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": etapes-animation

#let td = (
  numero: "4b",
  titre: "La Vague en tourbillon",
  annonce: "Créer l'environnement animation, exécuter le notebook tourbillon.ipynb, puis construire le script tourbillon.py fonctionnalité par fonctionnalité : une image, une série, la vidéo ; une branche git par fonctionnalité",
  dossier: "cours4/4b_tourbillon/",
  duree: "105′",
)
#separateur-td(..td)

#etapes-animation(
  "tourbillon", "4b_tourbillon", [`depart/vague.jpg`],
  ("python tourbillon.py vague.jpg --angle 90", "sortie/tourbillon_090.png"),
  ("python tourbillon.py vague.jpg --maximum 360", "--maximum", [les fonctions `angles` et `serie`]),
  "python tourbillon.py vague.jpg --maximum 360 --video",
)
