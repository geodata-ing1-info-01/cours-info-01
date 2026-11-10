#!/bin/bash
# Rejeu du TD 2c_depot_altitudes (cours 2 v2) : les commandes du guide, dans
# l'ordre, avec leurs sorties. git 2.34 en français, Python 3.12. Les sorties
# citées par le guide et les diapositives sont dans `sortie.txt`, relevée le
# 06/11/2026. Les dates des commits sont fixées : les identifiants se retrouvent à
# chaque rejeu. À la fin de l'étape 6, le programme doit être celui du corrigé.
#
#   conda activate info01          # python
#   bash rejeu.sh > sortie.txt
set -u
ICI=$(dirname "$(readlink -f "$0")")
DONNEES=$ICI/../../../../../../data/cours2_v2
DEPART=$DONNEES/2c_depot_altitudes/depart
CORRIGE=$DONNEES/corriges/2c_depot_altitudes/altitudes.py
S=$(mktemp -d)   # dossier jetable du rejeu
export LANG=fr_FR.UTF-8 LC_ALL=fr_FR.UTF-8 LANGUAGE=fr
export HOME=$S/maison GIT_CONFIG_NOSYSTEM=1 GIT_PAGER=cat PAGER=cat
T=1790000000
horloge() { T=$((T+60)); export GIT_AUTHOR_DATE="@$T +0200" GIT_COMMITTER_DATE="@$T +0200"; }
p() { echo; echo "\$ $*"; eval "$@" 2>&1; }
remplace() { python3 - "$@" <<'PY'
import sys; f, a, b = sys.argv[1:4]
t = open(f, encoding="utf-8").read(); assert a in t, a
open(f, "w", encoding="utf-8").write(t.replace(a, b, 1))
PY
}

jouer() {
mkdir -p "$S/maison" "$S/td/2c_depot_altitudes/depart" "$S/td/2c_depot_altitudes/travail"
cp "$DEPART/altitudes.py" "$S/td/2c_depot_altitudes/depart/"
cd "$S/td/2c_depot_altitudes"
echo "=== étape 0"
p cp depart/altitudes.py travail/
p cd travail
p python altitudes.py
echo "=== étape 1"
p git init
p ls -a
p git config user.name '"Alice Martin"'
p git config user.email alice.martin@ensg.eu
p git config user.name
p git status
p git add altitudes.py
p git status
horloge; p git commit -m '"Ajoute le calcul de la moyenne"'
p git log --oneline
echo "=== étape 2"
remplace altitudes.py '"""Moyenne d'"'"'une série d'"'"'altitudes, à la main plutôt qu'"'"'avec sum()."""' '"""Altitudes extrêmes d'"'"'une série de mesures."""'
remplace altitudes.py 'total = 0
for altitude in altitudes:
    total = total + altitude
moyenne = total / len(altitudes)
print(f"moyenne : {moyenne:.1f} m")
' 'print(f"altitude minimale : {min(altitudes):.1f} m")
print(f"altitude maximale : {max(altitudes):.1f} m")
print(f"max - min : {max(altitudes) - min(altitudes):.1f} m")
'
p python altitudes.py
p git status
p git diff
p git add altitudes.py
horloge; p git commit -m '"Remplace la moyenne par les altitudes extrêmes"'
p git log --oneline
p git log
echo "=== étape 3"
remplace altitudes.py 'maximale : {max(altitudes):.1f}' 'maximale : {max(altitude):.1f}'
p python altitudes.py
p git diff
p git restore altitudes.py
p git status
p python altitudes.py
echo "=== étape 4"
cat > README.md <<'MD'
# Altitudes

Ce programme affiche des statistiques sur une série d'altitudes, en mètres.

## Utilisation

Écrire les altitudes dans la liste `altitudes`, puis lancer `python altitudes.py`.
MD
p cat README.md
p git add README.md
horloge; p git commit -m '"Ajoute un README"'
cat > notes.txt <<'TXT'
À faire :
- ajouter le dénivelé cumulé
- lire les altitudes dans un fichier texte
TXT
p cat notes.txt
p git status
printf 'notes.txt\n' > .gitignore
p cat .gitignore
p git status
p git add .gitignore
horloge; p git commit -m '"Ignore le fichier de notes"'
p git status
p ls
p git log --oneline
echo "=== étape 5"
p git branch
p git checkout -b cumul
cat >> altitudes.py <<'PY'

hausse = 0
baisse = 0
for i in range(1, len(altitudes)):
    ecart = altitudes[i] - altitudes[i - 1]
    if ecart > 0:
        hausse = hausse + ecart
    else:
        baisse = baisse - ecart
print(f"cumul en hausse : {hausse:.1f} m")
print(f"cumul en baisse : {baisse:.1f} m")
PY
p python altitudes.py
p git add altitudes.py
horloge; p git commit -m '"Ajoute le dénivelé cumulé"'
p git checkout master
p python altitudes.py
remplace altitudes.py '"""Altitudes extrêmes d'"'"'une série de mesures."""' '"""Altitudes extrêmes et dénivelé cumulé d'"'"'une série de mesures."""'
p git add altitudes.py
horloge; p git commit -m '"Complète la description du programme"'
p git log --oneline --graph --all --decorate
horloge; p git merge cumul -m '"Fusionne le dénivelé cumulé"'
p python altitudes.py
p head -1 altitudes.py
p git log --oneline --graph
echo "=== étape 6"
p git checkout -b mesure-4
remplace altitudes.py 'altitudes = [79.6, 103.2, 98.3]' 'altitudes = [79.6, 103.2, 98.3, 92.5]'
p git add altitudes.py
horloge; p git commit -m '"Ajoute la mesure 92.5"'
p git checkout master
remplace altitudes.py 'altitudes = [79.6, 103.2, 98.3]' 'altitudes = [79.6, 103.2, 98.3, 123.7]'
p git add altitudes.py
horloge; p git commit -m '"Ajoute la mesure 123.7"'
horloge; p git merge mesure-4
p git status
p sed -n 1,9p altitudes.py
p python altitudes.py
remplace altitudes.py '<<<<<<< HEAD
altitudes = [79.6, 103.2, 98.3, 123.7]
=======
altitudes = [79.6, 103.2, 98.3, 92.5]
>>>>>>> mesure-4
' 'altitudes = [79.6, 103.2, 98.3, 92.5, 123.7]
'
p sed -n 1,4p altitudes.py
p python altitudes.py
p git add altitudes.py
p git status
horloge; p git commit -m '"Fusionne les deux mesures"'
p git log --oneline --graph --all --decorate
p git branch
cmp -s altitudes.py "$CORRIGE" || echo "! altitudes.py diffère du corrigé"
echo "=== étape 7"
p cd ..
p git clone travail copie
p cd copie
p ls -a
p git log --oneline -3
p git remote -v
p git config user.name
p git config user.name '"Alice Martin"'
p git config user.email alice.martin@ensg.eu
remplace altitudes.py '92.5, 123.7]' '92.5, 123.7, 127.7]'
p python altitudes.py
p git add altitudes.py
horloge; p git commit -m '"Ajoute la mesure 127.7"'
p cd ../travail
p git pull ../copie master
p git log --oneline -3
p sed -n 3p altitudes.py
}

jouer 2>&1 | sed "s#$S/td#…#g"
