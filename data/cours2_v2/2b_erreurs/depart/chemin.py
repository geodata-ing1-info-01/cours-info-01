"""Nombre de caractères du poème du TD 1a."""

with open("C:/Users/alice/cours1/1a_formats/depart/raven_une_ligne.txt", encoding="utf-8") as fichier:
    texte = fichier.read()

print(len(texte), "caractères")
