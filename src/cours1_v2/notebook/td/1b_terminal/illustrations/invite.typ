// L'invite de Git Bash, annotée, pour le guide du TD 1b (cours 1 v2).
#import "../../../../../commun/prelude.typ": *
#set page(width: auto, height: auto, margin: 12pt, fill: white)
#set text(font: police-texte, size: 10pt, fill: accent, lang: "fr")
#let repere(n) = box(fill: brun, radius: 50%, inset: 3pt, text(size: 9pt, weight: "bold", fill: white)[#n])
#let vert = rgb("#2f9e44")
#let violet = rgb("#9c36b5")
#let jaune = rgb("#b08800")
#let c(t, couleur) = text(font: police-code, size: 11pt, fill: couleur, t)
#block(width: 17cm, fill: rgb("#101010"), inset: 10pt)[
  #set text(fill: white)
  #c("(base)", white) #h(4pt) #repere(1) \
  #c("eleve@POSTE-12", vert) #repere(2) #h(4pt) #c("MINGW64", violet) #repere(3) #h(4pt) #c("~/Desktop/info01/cours1/1b_terminal", jaune) #repere(4) \
  #c("$", white) #repere(5) #h(4pt) #c("ls depart", white) #repere(6)
]
#v(6pt)
#block(width: 17cm)[
  #set text(size: 10pt)
  #table(
    columns: (auto, auto, 1fr), stroke: 0.5pt + estompe.lighten(40%), inset: 5pt,
    [], [Dans l'invite], [Ce qu'il désigne],
    repere(1), [`(base)`], [l'environnement conda actif ; absent tant que conda n'est pas configuré dans Git Bash (TD 1c)],
    repere(2), [`eleve@POSTE-12`], [l'utilisateur, puis le nom de la machine],
    repere(3), [`MINGW64`], [Git Bash sous Windows],
    repere(4), [`~/Desktop/…/1b_terminal`], [le dossier courant ; `~` est le dossier personnel, `C:\Users\eleve`],
    repere(5), [`$`], [Git Bash attend une commande],
    repere(6), [`ls depart`], [la commande tapée, validée par Entrée],
  )
]
