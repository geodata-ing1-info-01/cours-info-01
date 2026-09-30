# Diapositives — Cours 2

La séance est le portage en typst du support Beamer de Florent Geniet,
`cours_introduction_informatique_ing1.pdf` (57 pages, 17 septembre 2026), et
de son TP `TP_session_2.md`.

Le portage suit le support d'origine page pour page : les 57 pages du PDF
sont les 57 pages de l'exposé produit ici, révélation progressive comprise.
Les 51 titres de diapositive qui ne changent pas sont identiques ; les six
autres sont listés plus bas.

> Le support d'origine est dans `livraison/cours2_florent/`, que le
> `.gitignore` exclut du dépôt. Le conserver ailleurs si l'on veut pouvoir
> comparer plus tard.

## Ce que ce dossier ne fait pas comme le cours 1

Le cours 1 suit la structure *assertion-evidence* de [`STYLE.md`](../../../STYLE.md) :
pas de liste à puces, une preuve visuelle par diapositive. Le cours 2 y
déroge : le support de Florent est construit en listes qui se dévoilent, et
la reprise est fidèle. Les formes propres à cette séance sont définies dans
[`style.typ`](style.typ) :

| Gabarit | Rôle |
|---|---|
| `code(…)` | un listing au style du paquet LaTeX `listings` : commentaires en vert, primitives de bash en magenta, sur fond clair, en Latin Modern Mono |
| `code-ligne(…)` | la même chose dans le fil du texte |
| `liste-progressive(etape, items)` | une liste dont les items déjà vus passent en gris |
| `motif(…)` | le surlignage vert des expressions régulières |

Les trois couleurs ajoutées (`#009900`, `#EC008C`, `#8FD35B`) sont relevées au
pixel sur le PDF d'origine. Elles ne sortent pas de ce dossier.

## Rendu Beamer

Le thème commun est une transposition de Bruno ; le PDF de Florent est un
Bruno d'origine. Les deux ont été mesurés (positions et hauteurs des lignes
par `pdftotext -bbox-layout`, couleurs et aplats au pixel) et
[`beamer.typ`](beamer.typ) corrige, pour cette séance seulement, ce qui se
corrige sans toucher au thème.
corrige sans toucher au thème. Les valeurs sont en pourcentage de la hauteur
de page quand c'est ce qui se compare, en points de la page de 297 mm sinon.

| Élément | Beamer (Florent) | Thème commun | Cours 2, `beamer.typ` |
|---|---|---|---|
| page de titre | logo git en fond, découpé en trapèze ; filet ; auteur ; institut et date en plus petit | pas de fond, `sous-titre` sous le filet | `page-titre-beamer` : le fond, et les trois emplacements dans l'ordre de Beamer |
| titre de cadre | Fira Sans **Regular**, 32,1 pt | Medium, 33 pt | `d-beamer` : Regular, 32,1 pt |
| corps | 20,4 pt, avance 1,23 em | 21 pt, 1,34 em | 20,4 pt, 1,23 em |
| position du corps | centré, ressorts 0,65 : 1 | 0,85 : 1 | 0,65 : 1 |
| puces | carré et disque de Computer Modern Symbol | `■` `●`, absents de Fira Sans, pris dans Lato ou DejaVu selon le poste | dessinées (`box`), 0,46 et 0,40 em |
| espacement des items | 6,1 % de la hauteur | 5,6 % | 6,1 % |
| retrait des listes | 25,7 pt, texte 16,8 pt plus loin | 11 et 13 pt | 19 et 17 pt |
| items déjà vus | voile blanc, `#BABFC2` | `estompe`, `#6B7683` | `#BABFC2` |
| listings | Latin Modern Mono 9, 19 pt, avance 1,04 em | DejaVu Sans Mono 15 pt, avance 1,3 em | LM Mono 18 pt, 1,04 em |
| motifs surlignés | police du texte | chasse fixe | police du texte |
| `⇒`, `✓`, `□` | Computer Modern Symbol | police de repli | Latin Modern Math, en mode mathématique |
| apostrophe | `’` | `'` dans les chaînes passées en paramètre | `’` écrit tel quel |

Ce qui reste, et qui demande le thème :

| Élément | Beamer | Thème commun | Pourquoi ça reste |
|---|---|---|---|
| tout ce que `diapos()` et `page-titre()` composent en dur : titre de la page de titre, pied de page, `annonce` | corps × 1,856 | corps × 1,909, soit 2,8 % de trop | le facteur est une constante du thème ; en faire un paramètre ne changerait rien au cours 1 |
| `′` des durées de TD | — | Lato | glyphe absent de Fira Sans ; convention du dépôt, sans équivalent chez Florent |
| `commande [- option ]` | espaces insérées par `listings` autour des crochets | non | c'est un artefact de `listings`, pas une intention |

Latin Modern Mono et Latin Modern Math viennent avec TeX Live. Sur un poste
qui ne l'a pas, la pile retombe sur DejaVu Sans Mono et DejaVu Math TeX Gyre :
le document compile, avec des listings un peu plus larges.

## Révélation progressive

Le thème n'a pas de mécanisme d'*overlay* : une diapositive qui se dévoile est
simplement écrite autant de fois qu'elle compte d'étapes, et un paramètre
`etape` dit ce qui est visible. Les fichiers de `parties/` emploient pour cela
une boucle `#for`, ou une fonction locale appelée une fois par étape.

C'est ce qui fait que l'exposé compte 57 pages pour 26 diapositives.

## Schémas

Ils étaient des images matricielles, montées hors LaTeX. Ils sont redessinés
avec [cetz](https://typst.app/universe/package/cetz/) 0.4.2, le seul paquet du
dépôt, déjà employé au cours 1.

| Fichier | Contenu |
|---|---|
| [`../../commun/schemas_git.typ`](../../commun/schemas_git.typ) | `graphe-git` et ses annotations : le cours 6 les reprendra |
| [`schemas.typ`](schemas.typ) | arborescence, invite commentée, dossier `.git`, cycle de vie d'un fichier, git-flow, « Git : c'est quoi ? », sorties de terminal |

Une exception : les logos de la diapositive « Git : c'est quoi ? » sont
repris tels quels, découpés dans le support d'origine, dans
[`illustrations/cours2/logos/`](../../../illustrations/cours2/logos/). Ce sont
des marques, qu'un tracé approché rendrait moins reconnaissables. Ils sont
affichés par `image(…)` à chaque compilation, et non par `illustration(…)`,
qui les réserverait à `--input captures=true` : le document ne compile pas
sans eux. Leurs largeurs sont des multiples de `echelle`, comme le reste du
dessin.

`graphe-git` prend une liste de commits (un nom, une colonne, une voie, ses
parents) et un `etape` qui dit lesquels sont déjà là. Les annotations d'une
seule diapositive (HEAD, l'ellipse rouge, l'étoile de conflit) passent par
`extra`, une fonction qui reçoit la position d'un commit et le module de
dessin : sans cela, il faudrait une option par annotation.

Le dessin suit les conventions de Pro Git et du paquet LaTeX gitdags, que
reprennent Learn Git Branching et git-sim : l'identifiant du commit est
dans la pastille (`c7` ; déduit du nom ou de l'étiquette, ou donné par
`id`), l'arête pleine va de l'enfant vers le parent, sens du pointeur dans
git, une branche est un cartouche accroché au dernier commit de sa voie (ou
au commit nommé par `commit`), HEAD un cartouche relié par une flèche, et un
commit à deux parents, une fusion, porte un double trait. Chaque voie a sa
couleur : le tronc en `accent`, puis `brun` et `attention`. Le support
d'origine dessinait des pastilles vides reliées en tirets, avec « commit n »
en dessous ; les mêmes appels donnent le nouveau dessin.

Aucun paquet spécialisé n'existe pour les graphes git : le registre typst
(1607 paquets au 19 septembre 2026) n'en contient pas. `fletcher` et
`diagraph` auraient ajouté une dépendance pour un résultat moins réglable.

Les hauteurs se règlent par `echelle`, qui multiplie l'unité du dessin.
L'identifiant dans la pastille suit cette échelle, pour y tenir ; les autres
textes (étiquettes, cartouches), non. Un dessin trop réduit fait donc se
chevaucher les étiquettes. À surveiller en déplaçant un schéma.

### L'invite commentée

`invite-commentee` compose l'invite du terminal avec les couleurs que bash lui
donne (l'utilisateur en vert, le dossier courant en bleu) et pose une
accolade sous chacune des trois parties nommées. Les positions sont calculées
au caractère près : DejaVu Sans Mono a une chasse de 0,602 em, donc la largeur
d'un caractère ne dépend que du corps, et une accolade se place sous le
septième caractère sans rien mesurer.

### L'arborescence

Chaque nœud porte le côté où son nom se pose : `dessus`, `dessous`, `gauche`
ou `droite`. Un nom placé au-dessus chevauche l'arête qui arrive du parent ;
placé au-dessous, celle qui descend vers les enfants. Le côté est donc choisi
nœud par nœud, celui qu'aucun trait n'occupe. En déplaçant un nœud, il faut
revoir ce champ.

## Écarts avec le support d'origine

| Diapositive | Ce qui change | Pourquoi |
|---|---|---|
| page de titre | « Cours 2 », comme le cours 1 | la page de titre est celle du module, pas celle d'un auteur ; Florent est crédité dessous, avec la date de la séance |
| 8 (×5) | titre « Git : c'est quoi ? » au lieu de « intro » | « intro » est un reste de découpage : le titre projeté n'annonçait rien |
| 4 | `mkdir` au lieu de `mkdire` | coquille |
| 7 | `.txt` au lieu de `.txr` | coquille |
| 5, 9, 10, 26 | « Les fichiers », « accès », « tous les », « ne comprend pas », « état initial », « en termes de », « qu'on travaille » | fautes d'accord et d'orthographe |
| 18 | « commit courant » au lieu de « commit currant » | coquille |

Le reste — texte, ordre, schémas, découpage des étapes — suit l'original.

## TD

Le TP d'origine est un exercice unique : ses 27 questions construisent le
même projet. Il est découpé en cinq TD, joués chacun après la partie qui
l'outille. Le dépôt qu'ils construisent reste dans
`data/cours2/2a_premier_depot/travail/projet_2` d'un TD à l'autre.

| TD | Questions | Joué après |
|---|---|---|
| `2a_premier_depot` | 1 à 5 | le dépôt local |
| `2b_branches` | 6 à 17 | les branches |
| `2c_annuler` | 18 à 20 | les branches |
| `2d_conflits` | 21 à 25 | les branches |
| `2e_livrer` | 26 et 27 | les bonnes pratiques |

Trois corrections ont été faites au sujet : `sub()` n'existait pas dans la
liste des fonctions à écrire et devient `neg()` ; le motif de l'expression
régulière passe en chaîne brute ; le `README` demandé en markdown prend son
extension. Le détail est dans les README de `data/cours2/`.

Quatre autres, relevées en rejouant les TD le 24 septembre 2026 : la
question 14 fait créer `src/`, absent de la branche `operations` ; la
question 7 fait écrire la ligne d'image du logo, que l'archive ne fournit
pas ; les questions 19 et 25 signalent l'éditeur vim, comme la question 17 ;
la question 20 ajoute un commit sur `main_code` avant le rebase. Sans ce
commit, `main_code` ne contenait que des commits déjà dans `develop`, et le
rebase ne refaisait rien : aucun identifiant ne changeait.

## Compiler

```bash
conda activate info01

python outils/compiler_diapos.py --cours 2              # à projeter, 74 pages
python outils/compiler_diapos.py --cours 2 --notes      # version annotée
python outils/compiler_diapos.py --cours 2 --corrige    # corrigé des TD
python outils/compiler_diapos.py --cours 2 --sans-tds   # le fil du cours, 60 pages
python outils/compiler_tds.py --cours 2                 # une feuille par TD

python outils/verifier_diapos.py src/cours2/diapo/cours2.pdf
```

`cours2.pdf` fait 74 pages : 57 d'exposé et 17 de TD. La version annotée en
fait autant, page pour page, comme le demande le
[README du cours 1](../../cours1/diapo/README.md).

`verifier_diapos.py` traite un sous-titre, composé à 21 pt, comme la première
ligne du corps, et mesure alors un écart nul. Aucune diapositive du cours 2
n'emploie `sous-titre`, et le verdict vaut donc tel quel.
