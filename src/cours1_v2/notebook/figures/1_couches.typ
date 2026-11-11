// « Exécution : couches matérielles et logicielles » (diapo/parties/01_logiciels_stockage.typ),
// sans la question posée sous la pile.
#import "_gabarit.typ": *
#show: schema-de-cours

#couche(
  icone-fenetre(taille: 26pt), "Programmes",
  "LibreOffice, un navigateur, votre script", plein: true,
)
#liaison("« ouvre releve.csv »", "le contenu")
#couche(
  icone-engrenage(taille: 26pt), "Système d'exploitation",
  "Windows, macOS, Linux",
)
#liaison("« écris ces octets »", "les octets lus sur le disque")
#couche(
  icone-puce(taille: 26pt), "Matériel",
  "processeur, mémoire, disque, réseau",
)
