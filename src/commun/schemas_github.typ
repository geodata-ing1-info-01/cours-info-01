// Pages et fenêtres de GitHub, dessinées, pour les cours 5, 6 et 7 v2 (10/11/2026).
//
// Des schémas plutôt que des captures (STYLE.md, « Illustrations et captures d'écran ») :
// rien à refaire quand GitHub change sa mise en page. Ils reprennent les textes anglais
// de l'interface, ceux que l'élève voit. Les tailles sont en `em` : le même dessin sert sur
// une diapositive et dans une image de guide, où le texte est plus petit.
//
// Textes relevés dans la documentation de GitHub et de Git Credential Manager ; la
// fenêtre de Git Credential Manager et le Gestionnaire d'identification de Windows sont à
// vérifier sur un poste de la salle.
#import "theme.typ": accent, encre, estompe, brun, gris, attention, demi-gras, police-code, fenetre

// Un numéro sur un élément du dessin, repris dans les consignes.
#let pastille(n) = box(
  baseline: 20%, inset: (x: 0.3em, y: 0.15em), radius: 0.6em, fill: brun,
  text(size: 0.75em, weight: "bold", fill: white)[#n],
)

// Un bouton de l'interface ; `vif` désigne celui sur lequel cliquer.
#let bouton(texte, vif: false) = box(
  inset: (x: 0.55em, y: 0.3em), radius: 0.25em, baseline: 25%,
  fill: if vif { attention.lighten(82%) } else { gris.lighten(40%) },
  stroke: if vif { 1.4pt + attention } else { 0.6pt + estompe.lighten(40%) },
  text(size: 0.85em, weight: if vif { demi-gras } else { "regular" })[#texte],
)

// Un champ de saisie, avec son contenu.
#let champ(texte, largeur: 12em, code: false) = box(
  width: largeur, inset: (x: 0.45em, y: 0.3em), radius: 0.2em, baseline: 25%,
  stroke: 0.7pt + estompe.lighten(30%), fill: white,
  if code { text(font: police-code, size: 0.85em)[#texte] } else { text(size: 0.85em)[#texte] },
)

// Une case à cocher.
#let case(cochee) = box(
  width: 0.8em, height: 0.8em, baseline: 10%, radius: 0.12em,
  stroke: 0.8pt + if cochee { attention } else { estompe },
  fill: if cochee { attention } else { white },
  if cochee { align(center + horizon, text(size: 0.65em, fill: white, weight: "bold")[✓]) },
)

// Une fenêtre de navigateur : la barre d'adresse, puis la page.
#let navigateur(adresse, corps, largeur: 100%) = block(
  width: largeur, stroke: 1pt + accent.lighten(55%), clip: true,
)[
  #block(width: 100%, fill: gris, inset: (x: 0.6em, y: 0.4em))[
    #box(width: 100%, inset: (x: 0.5em, y: 0.25em), radius: 0.8em, fill: white)[
      #text(font: police-code, size: 0.8em, fill: estompe)[#adresse]
    ]
  ]
  #block(width: 100%, inset: (x: 0.8em, y: 0.6em))[#corps]
]

// La page d'un dépôt. `modele` : le dépôt est marqué « Template », et le bouton
// « Use this template » est celui à employer. `menu` : le contenu du menu ouvert sous le
// bouton « Code ». `reperes` : un dictionnaire, nom de l'élément → numéro.
#let page-depot(compte, depot, fichiers: (), modele: false, menu: none, reperes: (:)) = {
  let repere(nom) = if nom in reperes { h(0.3em) + pastille(reperes.at(nom)) }
  navigateur("github.com/" + compte + "/" + depot)[
    #text(size: 1.05em)[#text(fill: attention)[#compte] / #text(weight: "bold", fill: attention)[#depot]]
    #h(0.5em)
    #box(inset: (x: 0.4em, y: 0.1em), radius: 0.7em, stroke: 0.6pt + estompe,
         text(size: 0.7em, fill: estompe)[#if modele [Public template] else [Public]])
    #repere("nom")
    #v(0.2em)
    #text(size: 0.8em, fill: estompe)[#underline[Code] #h(1em) Pull requests #repere("pr") #h(1em) Settings]
    #line(length: 100%, stroke: 0.5pt + gris.darken(10%))
    #v(-0.3em)
    #grid(
      columns: (auto, 1fr, auto), column-gutter: 0.5em, align: horizon,
      bouton[master ▾],
      [],
      [
        #if modele [#bouton(vif: true)[Use this template ▾]#repere("modele") #h(0.3em)]
        #bouton(vif: not modele)[Code ▾]#repere("code")
      ],
    )
    #if menu != none {
      v(0.2em)
      align(right, menu)
    }
    #if fichiers.len() > 0 {
      v(0.2em)
      block(width: 100%, stroke: 0.6pt + gris.darken(10%), inset: (x: 0.5em, y: 0.3em),
        stack(spacing: 0.35em, ..fichiers.map(nom => text(size: 0.8em)[#nom])))
    }
  ]
}

// Le menu du bouton « Code », onglet HTTPS : l'adresse à donner à `git clone`.
#let menu-code(adresse, repere: none) = box(
  stroke: 0.8pt + estompe.lighten(20%), radius: 0.3em, fill: white,
  inset: (x: 0.6em, y: 0.5em),
)[
  #set align(left)
  #text(size: 0.8em, weight: demi-gras)[Clone]
  #v(-0.2em)
  #text(size: 0.75em)[#underline[HTTPS] #h(0.8em) #text(fill: estompe)[SSH #h(0.8em) GitHub CLI]]
  #v(-0.1em)
  #champ(adresse, largeur: auto, code: true) #box(width: 0.9em, height: 0.9em, baseline: 15%, stroke: 0.7pt + estompe)
  #if repere != none { pastille(repere) }
]

// Le formulaire de création d'un token classique.
#let formulaire-token(note: "td7a", expiration: "7 days", reperes: (:)) = {
  let repere(nom) = if nom in reperes { h(0.3em) + pastille(reperes.at(nom)) }
  navigateur("github.com/settings/tokens/new")[
    #text(size: 1.05em, weight: "bold")[New personal access token (classic)]
    #v(0.1em)
    #grid(
      columns: (auto, 1fr), column-gutter: 0.8em, row-gutter: 0.5em, align: (right + horizon, left + horizon),
      text(size: 0.85em, weight: demi-gras)[Note], [#champ(note) #repere("note")],
      text(size: 0.85em, weight: demi-gras)[Expiration], [#champ(expiration + " ▾", largeur: 7em) #repere("expiration")],
      text(size: 0.85em, weight: demi-gras)[Select scopes], [
        #case(true) #text(size: 0.85em)[*repo* #h(0.4em) #text(fill: estompe)[Full control of private repositories]] #repere("repo") \
        #case(false) #text(size: 0.85em, fill: estompe)[workflow] \
        #case(false) #text(size: 0.85em, fill: estompe)[admin:org …]
      ],
    )
    #v(0.2em)
    #bouton(vif: true)[Generate token]#repere("generer")
  ]
}

// Le token généré, affiché une seule fois.
#let token-genere(repere: none) = navigateur("github.com/settings/tokens")[
  #block(width: 100%, fill: attention.lighten(88%), inset: 0.5em)[
    #text(size: 0.85em)[Make sure to copy your personal access token now. You won't be able to see it again!]
  ]
  #v(0.1em)
  #champ("ghp_••••••••••••••••••••••••••••••••", largeur: 19em, code: true)
  #box(width: 0.9em, height: 0.9em, baseline: 15%, stroke: 0.7pt + estompe)
  #if repere != none { pastille(repere) }
]

// La fenêtre de Git Credential Manager au premier accès à github.com en HTTPS.
// `onglet` : "token" ou "navigateur", l'onglet sélectionné.
#let fenetre-connexion(onglet: "token", reperes: (:)) = {
  let repere(nom) = if nom in reperes { h(0.3em) + pastille(reperes.at(nom)) }
  fenetre("Git Credential Manager")[
    #align(center)[
      #text(size: 1.05em, weight: "bold")[Connect to GitHub]
      #v(0.1em)
      #text(size: 0.8em)[
        #if onglet == "navigateur" [#underline[*Browser/Device*]] else [Browser/Device]
        #h(1.5em)
        #if onglet == "token" [#underline[*Token*]] else [Token]
        #repere("onglet")
      ]
      #v(0.2em)
      #if onglet == "token" [
        #champ(text(fill: estompe)[Personal access token], largeur: 14em) #repere("champ") \
        #v(0.1em)
        #bouton(vif: true)[Sign in]#repere("valider")
      ] else [
        #bouton(vif: true)[Sign in with your browser]#repere("valider") \
        #v(0.1em)
        #bouton[Sign in with a code]
      ]
    ]
  ]
}

// Le Gestionnaire d'identification de Windows, l'identifiant de GitHub déplié.
#let gestionnaire-identification(compte: "alice-martin", repere: none) = fenetre("Gestionnaire d'identification")[
  #text(size: 0.8em)[
    #box(inset: (x: 0.5em, y: 0.25em), stroke: 0.6pt + estompe)[Informations d'identification Web]
    #box(inset: (x: 0.5em, y: 0.25em), stroke: 1.2pt + attention, fill: attention.lighten(85%))[*Informations d'identification Windows*]
  ]
  #v(0.2em)
  #text(size: 0.85em, weight: demi-gras)[Informations d'identification génériques]
  #block(width: 100%, stroke: 0.6pt + gris.darken(10%), inset: 0.5em)[
    #text(size: 0.85em)[*#"git:https://github.com"* #h(1fr) ▴] \
    #text(size: 0.75em, fill: estompe)[Nom d'utilisateur : #compte] \
    #text(size: 0.8em)[Modifier #h(0.8em) #text(fill: attention, weight: demi-gras)[#underline[Supprimer]]]
    #if repere != none { pastille(repere) }
  ]
]

// Le bandeau qui suit le push d'une branche, sur la page du dépôt.
#let bandeau-pr(compte, depot, branche, repere: none) = navigateur("github.com/" + compte + "/" + depot)[
  #block(width: 100%, fill: gris.lighten(30%), stroke: 0.6pt + estompe.lighten(30%), inset: 0.5em)[
    #grid(
      columns: (1fr, auto), align: horizon,
      text(size: 0.85em)[#text(font: police-code)[#branche] had recent pushes less than a minute ago],
      [#bouton(vif: true)[Compare & pull request]#if repere != none { h(0.3em) + pastille(repere) }],
    )
  ]
]

// La page d'une pull request ouverte, avant la fusion.
#let page-pr(compte, depot, titre, branche, commits: 2, reperes: (:)) = {
  let repere(nom) = if nom in reperes { h(0.3em) + pastille(reperes.at(nom)) }
  navigateur("github.com/" + compte + "/" + depot + "/pull/1")[
    #text(size: 1.05em, weight: "bold")[#titre #text(fill: estompe, weight: "regular")[\#1]]
    #v(0.1em)
    #box(inset: (x: 0.45em, y: 0.15em), radius: 0.7em, fill: estompe, text(size: 0.75em, fill: white)[Open])
    #h(0.4em)
    #text(size: 0.8em)[#compte wants to merge #commits commits into #text(font: police-code)[master] from #text(font: police-code)[#branche]]
    #v(0.2em)
    #block(width: 100%, stroke: 0.6pt + gris.darken(10%), inset: 0.5em)[
      #text(size: 0.85em, weight: demi-gras)[This branch has no conflicts with the base branch] \
      #v(0.1em)
      #bouton(vif: true)[Merge pull request ▾]#repere("fusion")
      #h(0.6em)
      #if "confirmer" in reperes [#bouton[Confirm merge]#repere("confirmer")]
    ]
  ]
}
