// TD 4a du cours 4 — « La montre du Lapin blanc ».
//
// Inclus par `cours4.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`, qui
// en tire la feuille `td_4a_montre.pdf`. Les étapes en résumé : le détail,
// avec le code à coller, est dans le guide `guide_4a_montre.pdf`. Les étapes
// sont celles du TD 4b (`etapes-animation`, dans `schemas.typ`).
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": etapes-animation

#let td = (
  numero: "4a",
  titre: "La montre du Lapin blanc",
  annonce: "Créer l'environnement animation, exécuter le notebook montre.ipynb, puis construire le script montre.py fonctionnalité par fonctionnalité : une image, une série, la vidéo ; une branche git par fonctionnalité",
  dossier: "cours4/4a_montre/",
  duree: "105′",
)
#separateur-td(..td)

#etapes-animation(
  "montre", "4a_montre", none,
  ("python montre.py --heure 10:05", "sortie/montre_1005.png"),
  ("python montre.py --heure 10:00 --minutes 120", "--minutes", [la fonction `serie`]),
  "python montre.py --heure 10:00 --minutes 120 --video",
)
