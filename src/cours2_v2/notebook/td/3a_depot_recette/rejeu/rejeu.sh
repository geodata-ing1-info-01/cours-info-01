#!/bin/bash
# Rejeu du TD 3a_depot_recette (cours 2 v2) : les commandes du guide, dans
# l'ordre, avec leurs sorties. git 2.43 et pandoc 3, en français. Les sorties
# citées par le guide et les diapositives sont dans `sortie.txt`, relevée le
# 26/09/2026. Les identifiants de commit changent à chaque rejeu à partir de
# l'étape 4 : le .odt produit par pandoc porte une date.
#
#   conda activate info01          # pandoc et magick
#   bash rejeu.sh > sortie.txt
set -u
ICI=$(dirname "$(readlink -f "$0")")
DEPART=$ICI/../../../../../../data/cours2_v2/3a_depot_recette/depart
S=$(mktemp -d)   # dossier jetable du rejeu
export LANG=fr_FR.UTF-8 LC_ALL=fr_FR.UTF-8 LANGUAGE=fr
export HOME=$S/maison GIT_CONFIG_NOSYSTEM=1 GIT_PAGER=cat PAGER=cat
T=1790000000
horloge() { T=$((T+60)); export GIT_AUTHOR_DATE="@$T +0200" GIT_COMMITTER_DATE="@$T +0200"; }
rm -rf "$S/maison" "$S/td"
mkdir -p "$S/maison" "$S/td/3a_depot_recette/depart" "$S/td/3a_depot_recette/travail"
cp "$DEPART/recette.md" "$S/td/3a_depot_recette/depart/"
# La photo de la recette, remplacée par un aplat : son contenu ne change rien aux sorties.
magick -size 64x48 xc:"#d9a441" "$S/td/3a_depot_recette/depart/crepes.jpg"
cd "$S/td/3a_depot_recette"
p() { echo; echo "\$ $*"; eval "$@" 2>&1; }
remplace() { python3 - "$@" <<'PY'
import sys; f, a, b = sys.argv[1:4]
t = open(f, encoding="utf-8").read(); assert a in t, a
open(f, "w", encoding="utf-8").write(t.replace(a, b, 1))
PY
}
echo "=== étape 0"
p cp depart/recette.md depart/crepes.jpg travail/
p cd travail
p git config --global user.name '"Alice Martin"'
p git config --global user.email alice.martin@ensg.eu
p git config --global --list
echo "=== étape 1"
p git init
p ls -a
p git status
p git add recette.md crepes.jpg
p git status
horloge; p git commit -m '"Ajoute la recette des crêpes"'
p git log --oneline
echo "=== étape 2"
remplace recette.md "| Œufs | 4 |" "| Œufs | 3 |"
p git status
p git diff
p git add recette.md
horloge; p git commit -m '"Réduit les œufs à trois"'
p git log --oneline
p git log
echo "=== étape 3"
remplace recette.md "6. Cuire dans une poêle chaude, une minute par face." "6. Cuire."
p git status
p git diff
p git restore recette.md
p git status
echo "=== étape 4"
p pandoc recette.md -o recette.html
p pandoc recette.md -o recette.odt
p ls
p git status
p git add recette.odt
horloge; p git commit -m '"Ajoute la recette au format .odt"'
remplace recette.md "| Lait | 500 ml |" "| Lait | 600 ml |"
p pandoc recette.md -o recette.odt
p git status
p git diff
p git rm --cached recette.odt
printf '*.html\n*.odt\n' > .gitignore
p cat .gitignore
p git status
p git add .gitignore recette.md
horloge; p git commit -m '"Ignore les fichiers produits par pandoc"'
p git status
p ls
echo "=== étape 5"
p git branch
p git checkout -b sans-gluten
remplace recette.md "| Farine | 250 g |" "| Farine de sarrasin | 250 g |"
p git add recette.md
horloge; p git commit -m '"Remplace la farine de blé par du sarrasin"'
p git log --oneline --graph --all
p git checkout master
p grep Farine recette.md
printf '\n## Conseil\n\n> La pâte se conserve 24 heures au réfrigérateur.\n' >> recette.md
p git add recette.md
horloge; p git commit -m '"Ajoute un conseil de conservation"'
p git log --oneline --graph --all
p git log --oneline --graph --all --decorate
p git checkout sans-gluten
p grep Farine recette.md
p git checkout master
p grep Farine recette.md
horloge; p git merge sans-gluten -m '"Fusionne la variante sans gluten"'
p git log --oneline --graph
p git log --oneline --graph --decorate -3
p grep -n -e Farine -e Conseil recette.md
echo "=== étape 6"
p git checkout -b pour-18
remplace recette.md "*Pour 12 crêpes" "*Pour 18 crêpes"
p git add recette.md
horloge; p git commit -m '"Passe la recette à 18 crêpes"'
p git checkout master
remplace recette.md "1 heure de repos.*" "2 heures de repos.*"
p git add recette.md
horloge; p git commit -m '"Allonge le repos à deux heures"'
horloge; p git merge pour-18
p git status
p sed -n 1,10p recette.md
remplace recette.md "<<<<<<< HEAD
*Pour 12 crêpes — 10 minutes de préparation, 2 heures de repos.*
=======
*Pour 18 crêpes — 10 minutes de préparation, 1 heure de repos.*
>>>>>>> pour-18
" "*Pour 18 crêpes — 10 minutes de préparation, 2 heures de repos.*
"
p sed -n 1,4p recette.md
p git add recette.md
p git status
horloge; p git commit -m '"Fusionne la version pour 18 crêpes"'
p git log --oneline --graph
p git branch
