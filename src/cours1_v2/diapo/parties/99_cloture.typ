// Clôture du cours 1 v2 — incluse en dernier par `cours1_v2.typ`.
// Un fichier inclus n'hérite pas des imports de son appelant.
//
// 09/11/2026 : « À retenir », un tableau de notions, devient une partie à part, avec deux
// aide-mémoire : les commandes de la séance, puis l'édition et le lancement d'un programme
// Python, sur le schéma qui ouvre le cours 2 v2. Les notions du tableau passent dans les
// notes du premier.
#import "../../../commun/prelude.typ": *
#import "../../../cours2_v2/diapo/schemas.typ": schema-rappel-outils

#separateur(
  "À retenir",
  annonce: "Récapituler les commandes de la séance et l'édition d'un programme Python.",
)

// --------------------------------------------
// Les lignes reprennent « Les commandes de base » et « Le chemin d'un fichier en ligne de
// commande », avec les mêmes mots.
#d("Aide-mémoire : terminal et commandes")[
  #show table.cell: set text(size: 13pt)
  #tableau(
    columns: (auto, 1fr, auto, 1fr),
    align: left + horizon,
    table.cell(colspan: 2)[Se déplacer, lister], table.cell(colspan: 2)[Agir sur les fichiers],
    [`pwd`], [affiche le dossier courant], [`cp source destination`], [copie un fichier],
    [`ls dossier`], [liste le dossier nommé], [`mv source destination`], [déplace ou renomme],
    [`ls -a dossier`], [liste aussi les fichiers cachés], [`mkdir nom`], [crée un dossier],
    [`cd dossier`], [descend dans le dossier nommé], [`rm fichier`], [supprime, sans corbeille],
    [`cd ..`], [remonte au dossier parent], [`start fichier`], [ouvre avec le logiciel associé],
    [`which commande`], [affiche le chemin du fichier lancé], [`commande --help`], [affiche l'aide de la commande],
  )

  #v(0.4em)
  #tableau(
    columns: (auto, 1fr, auto, 1fr),
    align: left + horizon,
    table.cell(colspan: 2)[Chemins dans Git Bash], table.cell(colspan: 2)[Noms et raccourcis],
    [`/c/Users/eleve`], [`C:\Users\eleve` dans l'explorateur], [`*`], [remplace toute suite de caractères],
    [`~`], [le dossier personnel], [`"le corbeau.txt"`], [reste un seul argument, malgré l'espace],
    [`..`], [le dossier parent], [`Tab`], [complète un nom commencé],
    [`.`], [le dossier courant], [flèche vers le haut], [rappelle la commande précédente],
  )

  #notes[
    Faire retrouver, pour quelques lignes, la diapositive ou le TD où la commande a servi.

    Notions de la séance, à rappeler à l'oral : un logiciel transforme une entrée en
    sortie, et un fichier conserve le résultat ; l'extension nomme le type du fichier sans
    modifier son contenu ; le disque du poste garde les fichiers de l'élève, le dossier
    partagé est à toute la salle ; une commande désigne un fichier exécutable, cherché dans
    le `PATH` ; un notebook réunit texte, code et résultats, et le noyau retient les
    variables.
  ]
]

// --------------------------------------------
// Le schéma de « Rappel du cours 1 : édition et exécution », au début du cours 2 v2 : la
// séance se termine sur l'image qui ouvre la suivante.
#d("Aide-mémoire : programme Python")[
  #scale(92%, reflow: true, schema-rappel-outils())

  #legende[
    Après chaque modification, enregistrer dans Notepad++, puis relancer dans Git Bash.
    `python` seul ouvre une session interactive, et `exit()` la quitte. `which python`
    affiche le Python lancé.
  ]

  #notes[
    Le cours 2 ouvre sur ce schéma. Il remplace Notepad++ et Git Bash par VS Code,
    configuré en classe entière, puis présente git en local et un README en Markdown. Le
    terminal du cours 2 reste Git Bash, dans VS Code.

    Emporter son travail : à préciser (espace personnel, clé USB).
  ]
]
