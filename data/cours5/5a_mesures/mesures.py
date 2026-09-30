"""Quatre mesures de temps sur ce poste : processeur, mémoire, disque, réseau.

    python mesures.py

Chaque mesure est faite trois fois et le meilleur temps est gardé. Le fichier
temporaire de 100 Mo est écrit dans le dossier courant puis supprimé.
"""

import os
import socket
import time
import urllib.request
from pathlib import Path

TAILLE = 100_000_000          # 100 Mo, pour la mémoire et le disque
SERVEUR = "github.com"
URL_TELECHARGEMENT = "https://speed.cloudflare.com/__down?bytes=10000000"   # 10 Mo


def chronometre(fonction, repetitions=3):
    """Le meilleur temps, en secondes, sur plusieurs exécutions."""
    temps = []
    for _ in range(repetitions):
        debut = time.perf_counter()
        fonction()
        temps.append(time.perf_counter() - debut)
    return min(temps)


def additions():
    total = 0
    for i in range(10_000_000):
        total += i
    return total


def copie_memoire(donnees):
    return bytearray(donnees)


def ecriture_disque(chemin, donnees):
    with open(chemin, "wb") as fichier:
        fichier.write(donnees)
        fichier.flush()
        os.fsync(fichier.fileno())      # attendre que le disque ait vraiment écrit


def lecture_disque(chemin):
    return chemin.read_bytes()


def aller_retour():
    """Ouvrir puis fermer une connexion : un aller-retour jusqu'au serveur."""
    socket.create_connection((SERVEUR, 443), timeout=10).close()


def telechargement():
    requete = urllib.request.Request(URL_TELECHARGEMENT, headers={"User-Agent": "mesures.py"})
    with urllib.request.urlopen(requete, timeout=30) as reponse:
        return reponse.read()


def main():
    donnees = os.urandom(TAILLE)
    chemin = Path("temporaire_100mo.bin")

    t = chronometre(additions)
    print(f"processeur   10 millions d'additions   {t * 1000:8.1f} ms"
          f"   soit {t / 10_000_000 * 1e9:6.0f} ns par addition")

    t = chronometre(lambda: copie_memoire(donnees))
    print(f"mémoire      copier 100 Mo             {t * 1000:8.1f} ms"
          f"   soit {TAILLE / t / 1e9:6.1f} Go/s")

    t = chronometre(lambda: ecriture_disque(chemin, donnees))
    print(f"disque       écrire 100 Mo             {t * 1000:8.1f} ms"
          f"   soit {TAILLE / t / 1e6:6.0f} Mo/s")

    t = chronometre(lambda: lecture_disque(chemin))
    print(f"disque       relire 100 Mo             {t * 1000:8.1f} ms"
          f"   soit {TAILLE / t / 1e6:6.0f} Mo/s")
    chemin.unlink()

    try:
        t = chronometre(aller_retour)
        print(f"réseau       un aller-retour           {t * 1000:8.1f} ms"
              f"   vers {SERVEUR}")
    except OSError as erreur:
        print(f"réseau       aller-retour impossible : {erreur}")
    try:
        t = chronometre(telechargement, repetitions=1)
        print(f"réseau       télécharger 10 Mo         {t * 1000:8.1f} ms"
              f"   soit {10_000_000 * 8 / t / 1e6:6.0f} Mbit/s")
    except OSError as erreur:
        print(f"réseau       téléchargement impossible : {erreur}")


if __name__ == "__main__":
    main()
