// TD 3c du cours 3 v2 — « Encodage et écriture d'un fichier ».
//
// Nouveau (v2), 04/11/2026 : la partie 2 de l'exposé, sur la première ligne de
// `parcours.txt`, dont le `ê` de `Forêt` occupe deux octets ; puis l'écriture d'un
// résumé, en mode `"w"` et `"a"`. Corrigé : `data/cours3_v2/corriges/3c_encodage/`.
// Sorties relevées sur ce corrigé, Python 3.12.
//
// Inclus par `cours3_v2.typ` ; compilable seul par
// `outils/compiler_tds.py --cours 3_v2`.
#import "../../../commun/prelude.typ": *
#import "../schemas.typ": sortie
#import "../../../cours1_v2/diapo/schemas.typ": consignes, comment, commandes, constat

#let td = (
  numero: "3c",
  titre: "Encodage et écriture d'un fichier",
  annonce: "Objectif : lire la même ligne d'un fichier selon l'encodage, puis écrire le résultat du programme dans un fichier",
  dossier: "cours3/3c_encodage/",
  duree: "20′",
)
#separateur-td(..td)

#d("Lire une ligne selon l'encodage")[
  #consignes(
    taille: 16pt,
    [Aller dans le dossier du TD, copier ses fichiers, puis ouvrir une session interactive : #commandes("cd ../../3c_encodage", "cp depart/* travail/", "cd travail", "python")],
    [Lire la première ligne de `parcours.txt` en UTF-8 : #commandes("f = open(\"parcours.txt\", encoding=\"utf-8\")", "f.readline()")
      #constat[`'Forêt,2 km\n'`]],
    [Lire la même ligne en cp1252 : #commandes("f = open(\"parcours.txt\", encoding=\"cp1252\")", "f.readline()")
      #constat[`'ForÃªt,2 km\n'` : les deux octets de `ê` sont lus comme deux caractères.]],
    [Lire la même ligne sans la décoder : #commandes("f = open(\"parcours.txt\", \"rb\")", "f.readline()")
      #constat[`b'For\xc3\xaat,2 km\n'` : le `ê` occupe les octets `c3` et `aa`.]],
    [Quitter la session : `exit()`.],
  )

  #notes[
    Les trois fichiers ouverts restent ouverts jusqu'à `exit()`. Dans un programme,
    employer `with`.

    À vérifier sur un poste de la salle : dans le terminal de VS Code, `ê` et
    `Ãª` s'affichent correctement.
  ]
]

#d("Écrire le résumé dans un fichier")[
  #consignes(
    taille: 16pt,
    [À la fin de `travail/altitudes.py`, ajouter ces lignes :
      #v(2pt)
      #sortie("with open(\"resume.txt\", \"w\", encoding=\"utf-8\") as sortie:\n    sortie.write(f\"{FICHIER.name} : seuil {SEUIL}, hausse {hausse:.1f} m, baisse {baisse:.1f} m\\n\")", taille: 11pt)],
    [Enregistrer le fichier, puis lancer le programme deux fois : #commandes("python altitudes.py trace.csv", "python altitudes.py trace.csv -s 2")],
    [Afficher le résumé : `cat resume.txt`.
      #constat[Une seule ligne, celle du seuil 2.0 : le mode `"w"` vide le fichier à l'ouverture.]],
    [Remplacer `"w"` par `"a"`, enregistrer, puis relancer les deux commandes et `cat resume.txt`.
      #constat[Trois lignes : le mode `"a"` écrit à la fin du fichier.]],
  )

  #notes[
    `\n` : `write` n'ajoute pas de fin de ligne, contrairement à `print`.

    `resume.txt` part du dossier du terminal. `FICHIER.name` donne le nom du
    fichier, sans son dossier.

    Pour ceux qui vont vite : écrire le résumé à côté de la trace, avec
    `FICHIER.parent / "resume.txt"`.
  ]
]
