#!/bin/bash
# Rejeu de l'histoire de « Git : fonctionnalités » (partie git du cours 2 v2) : les
# commits c1 à c8 du schéma, avec leurs vrais identifiants, pour les graphes et les
# sorties des diapositives suivantes. c1 et c2 sont ceux du TD 2c (même contenu, même
# auteur, mêmes dates), donc 64ed213 et 726d93f. c3 et c5 reprennent le code du TD 3a,
# c6 celui du TD 3b. Le revert et le rebase sont joués sur des copies du dépôt, dans
# des sous-shells : l'histoire principale n'en dépend pas.
#
#   conda activate info01          # python
#   bash rejeu.sh > sortie.txt
set -u
ICI=$(dirname "$(readlink -f "$0")")
DONNEES=$ICI/../../../../data
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
mkdir -p "$S/maison" "$S/depot"
cd "$S/depot"
cp "$DONNEES/cours2_v2/2c_depot_altitudes/depart/altitudes.py" .
git init -q
git config user.name "Alice Martin"
git config user.email alice.martin@ensg.eu

echo "=== c1 et c2 (TD 2c)"
git add altitudes.py
horloge; p git commit -m '"Ajoute le calcul de la moyenne"'
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
git add altitudes.py
horloge; p git commit -m '"Remplace la moyenne par les altitudes extrêmes"'

echo "=== c4 : dénivelé cumulé, branche cumul"
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
git add altitudes.py
horloge; p git commit -m '"Ajoute le dénivelé cumulé"'

echo "=== c3 : fichier texte, master"
p git checkout master
remplace altitudes.py 'altitudes = [79.6, 103.2, 98.3]
' 'altitudes = []
with open("altitudes.txt", encoding="utf-8") as fichier:
    for ligne in fichier:
        altitudes.append(float(ligne))

'
printf '79.6\n103.2\n98.3\n' > altitudes.txt
git add altitudes.py altitudes.txt
horloge; p git commit -m '"Lit les altitudes dans un fichier texte"'
p git log --oneline --graph --all --decorate
p python altitudes.py
p git checkout cumul
p python altitudes.py
p git checkout master

echo "=== variante : revert de c3"
( cp -r "$S/depot" "$S/revert" && cd "$S/revert"
  horloge; p git revert --no-edit HEAD
  p git log --oneline -3
  p git rev-parse "HEAD^{tree}" "HEAD~2^{tree}" )

echo "=== c5 : trace GPS, master"
cp "$DONNEES/cours3_v2/3a_denivele/depart/trace.csv" .
remplace altitudes.py 'with open("altitudes.txt", encoding="utf-8") as fichier:
    for ligne in fichier:
        altitudes.append(float(ligne))
' 'with open("trace.csv", encoding="utf-8") as fichier:
    fichier.readline()
    for ligne in fichier:
        x, y, ele, time = ligne.strip().split(",")
        altitudes.append(float(ele))
'
git add altitudes.py trace.csv
horloge; p git commit -m '"Lit les altitudes d'"'"'une trace GPS"'

echo "=== c6 : seuil, branche cumul"
p git checkout cumul
remplace altitudes.py 'hausse = 0
baisse = 0
for i in range(1, len(altitudes)):
    ecart = altitudes[i] - altitudes[i - 1]
    if ecart > 0:
        hausse = hausse + ecart
    else:
        baisse = baisse - ecart
' 'SEUIL = 2.0
hausse = 0
baisse = 0
reference = altitudes[0]
for altitude in altitudes[1:]:
    ecart = altitude - reference
    if abs(ecart) >= SEUIL:
        if ecart > 0:
            hausse = hausse + ecart
        else:
            baisse = baisse - ecart
        reference = altitude
'
git add altitudes.py
horloge; p git commit -m '"Ajoute un seuil au dénivelé cumulé"'
p git checkout master
p git log --oneline --graph --all --decorate

echo "=== variante : rebase de cumul sur master"
( cp -r "$S/depot" "$S/rebase" && cd "$S/rebase"
  p git checkout cumul
  horloge; p git rebase master
  p git log --oneline --graph --all --decorate
  p git checkout master
  p git merge cumul )

echo "=== c7 : fusion"
horloge; p git merge cumul -m '"Fusionne le dénivelé cumulé"'
p python altitudes.py

echo "=== c8 : renommage"
p git mv altitudes.py stats_trace.py
horloge; p git commit -m '"Renomme le script en stats_trace.py"'
p git log --oneline --graph --all --decorate
}

jouer 2>&1 | sed "s#$S#…#g"
