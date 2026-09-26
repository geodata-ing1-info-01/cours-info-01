// Clôture du cours 1 v2 — incluse en dernier par `cours1_v2.typ`.
// Un fichier inclus n'hérite pas des imports de son appelant.
#import "../../../commun/prelude.typ": *

// Nouveau (v2) : resserré sur les notions de la séance (syllabus v2).
#d("À retenir")[
  #tableau(
    entete: false,
    columns: (auto, 1fr),
    align: left + horizon,
    [Un logiciel], [transforme une entrée en sortie ; un fichier conserve le résultat],
    [Une extension], [nomme le type du fichier, elle ne modifie pas son contenu],
    [Le disque du poste], [garde vos fichiers ; le dossier partagé est à toute la salle],
    [Le terminal], [transmet des commandes à un interpréteur ; au module, Git Bash],
    [Un chemin relatif], [part du dossier courant ; `..` remonte d'un dossier],
    [L'interpréteur python], [exécute le fichier enregistré sur le disque],
    [Un notebook], [texte, code et résultats ; le noyau retient les variables],
  )

  #notes[
    Cours 2 : VS Code configuré en classe entière, Markdown complet, git
    local. Le terminal du cours 2 est Git Bash, dans VS Code.

    Emporter son travail : à préciser (espace personnel, clé USB).
  ]
]
