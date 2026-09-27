# Les ordres de grandeur de votre poste — TD 1a, cours 5

Deux étapes : lire les caractéristiques du poste dans le gestionnaire des
tâches, puis mesurer quatre temps avec un script fourni.

## Le poste

`Ctrl` + `Maj` + `Échap`, onglet Performance. Relever le nombre de cœurs et
la vitesse de base du processeur, la taille de la mémoire, le type (SSD ou
HDD) et la capacité du disque, la vitesse du lien réseau.

Si le gestionnaire ne s'ouvre pas, `systeminfo` dans l'invite de commandes d'Anaconda donne le
processeur et la mémoire.

## Quatre mesures

Depuis `cours5/1a_mesures/`, dans l'invite de commandes d'Anaconda :

```bash
python mesures.py
```

Le script chronomètre, dans l'ordre : 10 millions d'additions en Python ; la
copie de 100 Mo en mémoire ; l'écriture puis la relecture de 100 Mo sur le
disque ; un aller-retour vers `github.com` ; le téléchargement de 10 Mo. Chaque
mesure est faite trois fois et le meilleur temps est gardé. Le fichier
temporaire est supprimé à la fin.

Sortie sur le poste de préparation (Linux, septembre 2026) :

```
processeur   10 millions d'additions      394.1 ms   soit     39 ns par addition
mémoire      copier 100 Mo                 73.9 ms   soit    1.4 Go/s
disque       écrire 100 Mo               1117.1 ms   soit     90 Mo/s
disque       relire 100 Mo                 76.1 ms   soit   1314 Mo/s
réseau       un aller-retour               22.0 ms   vers github.com
réseau       télécharger 10 Mo            194.1 ms   soit    412 Mbit/s
```

La relecture est plus rapide que l'écriture parce que le système garde en
mémoire vive une copie de ce qu'il vient d'écrire : c'est le cache, l'étage
mémoire vive de la pyramide du cours.

Si le réseau ne répond pas (session réseau non ouverte, pare-feu), le script
l'écrit et s'arrête là ; les quatre autres mesures sont faites.

## Avant la séance

Vérifier depuis une VM de la salle, session réseau ouverte, que `github.com`
répond sur le port 443 et que `speed.cloudflare.com` sert le fichier de 10 Mo.
Relever les valeurs des VM et les reporter dans le corrigé du TD
(`src/cours5/diapo/tds/1a_mesures.typ`).
