"""Vérifie que la version boucle et la version numpy de l'effet donnent la même image.

    python test_effet.py

À lancer dans le dossier du projet ; doit afficher `True` sur chaque ligne.
"""
import numpy as np

import train

# Une image au hasard, de la taille des images de la série
image = np.random.default_rng(0).integers(0, 256, size=(480, 640, 3), dtype=np.uint8)

for numero in [0, 1, 2, 50]:
    print("poteaux", numero, np.array_equal(train.poteaux_boucle(image, numero), train.poteaux_numpy(image, numero)))
