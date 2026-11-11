// La fenêtre de Git Credential Manager, onglet Token. Schéma d'après GCM 2.x, à vérifier en salle.
#import "../../../../../commun/prelude.typ": *
#import "../../../../../commun/schemas_github.typ": *
#set page(width: auto, height: auto, margin: 10pt, fill: white)
#set text(font: police-texte, size: 10pt, fill: accent, lang: "fr")
#block(width: 9cm, fenetre-connexion(onglet: "token", reperes: (onglet: 1, champ: 2, valider: 3)))
