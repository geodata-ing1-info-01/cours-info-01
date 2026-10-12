---
title: "Annexe — Comparer deux versions d'un fichier"
subtitle: Ce qui a changé entre deux versions, et pourquoi la réponse dépend du format
jupytext:
  text_representation:
    extension: .md
    format_name: myst
kernelspec:
  name: python3
  display_name: Python 3
---

:::{note}
Cette page n'est pas jouée en séance : elle se fait seule, et prépare le cours 2.
Elle repart d'un fichier déjà écrit, la recette mise en forme en Markdown en
séance, dans `cours1/1f_markdown/depart/`.
:::

Le choix d'un format décide de ce qu'on peut faire du fichier ; comparer deux
versions en est le meilleur test. La question « qu'est-ce qui a changé » reçoit
deux réponses selon l'outil.

Un traitement de texte y répond par le **suivi des modifications** : Writer et
Word enregistrent les corrections dans le document lui-même, avec leur auteur et
leur date, à condition que la fonction ait été activée avant la frappe. L'unité
y est le mot.

Un outil de comparaison y répond autrement : il prend deux fichiers quelconques,
calcule après coup ce qui les sépare, et donne son résultat **ligne par ligne**.
Rien n'est enregistré dans les fichiers, et rien ne leur est demandé sinon
d'être du texte. C'est cette seconde réponse qui vaut pour du code, et c'est une
raison de plus d'écrire une instruction par ligne.

```{code-cell} python
import difflib
from pathlib import Path

def dossier_seance(depart: Path = Path.cwd()) -> Path:
    """Le dossier de la séance, celui qui contient `1a_formats/`.

    Le notebook s'ouvre depuis l'archive du cours, depuis le dépôt ou pendant
    la construction du book, et le dossier courant change à chaque fois : on
    remonte donc jusqu'à le trouver.
    """
    for dossier in [depart, *depart.parents]:
        for candidat in (dossier, dossier / "data" / "cours1"):
            if (candidat / "1a_formats").is_dir():
                return candidat
    raise FileNotFoundError("dossier de la séance introuvable depuis " + str(depart))

recette = dossier_seance() / "1f_markdown" / "depart" / "recette.md"
avant = recette.read_text(encoding="utf-8").splitlines(keepends=True)
apres = [
    ligne.replace("1 heure de repos", "2 heures de repos")
         .replace("| Lait | 500 ml |", "| Lait | 600 ml |")
    for ligne in avant
]

differences = list(difflib.unified_diff(
    avant, apres, fromfile="recette.md", tofile="recette_v2.md"
))
print("".join(differences[:7]))
```

Ce format s'appelle le *diff unifié*, et il est le même partout : `diff -u`, la
vue de comparaison de VSCode et `git diff` écrivent tous ceci. Les deux
premières lignes nomment les versions comparées. `@@ -1,6 +1,6 @@` donne
l'endroit : six lignes à partir de la première, de part et d'autre. Vient
ensuite le contenu, où une ligne inchangée commence par une espace, une ligne
retirée par `-` et une ligne ajoutée par `+`.

Les lignes inchangées ne sont pas décoratives : c'est ce *contexte* qui permet
de retrouver l'endroit dans un fichier qui a bougé par ailleurs, sans se fier au
seul numéro de ligne.

```{code-cell} python
texte = "".join(differences)
modifiees = [l for l in texte.splitlines() if l[:1] in "+-" and l[:3] not in ("---", "+++")]
print(f"{len(texte.splitlines())} lignes de différences, dont {len(modifiees)} de contenu")
print(f"{len(texte.encode('utf-8'))} octets, contre {recette.stat().st_size} pour la recette entière")
```

Ces quelques centaines d'octets suffisent à reconstruire la seconde version à
partir de la première : c'est ce qu'on appelle un **correctif**, ou *patch*.
Pendant vingt ans, les contributions aux projets libres se sont envoyées ainsi,
par courriel.

:::{admonition} À faire — modifier, comparer, appliquer
:class: tip

Le dossier `cours1/1f_markdown/depart/` contient `comparer.py`, un programme d'une
quarantaine de lignes qui n'emploie que la bibliothèque standard.

1. Ouvrez `recette.md`, puis **Fichier → Enregistrer sous**, sous le nom
   `recette_v2.md`. Dans cette copie, faites passer le repos à deux heures et le
   lait à 600 ml.
2. Clic droit sur `recette.md`, **Sélectionner pour comparer** ; puis clic droit
   sur `recette_v2.md`, **Comparer avec l'élément sélectionné**. Deux lignes sont
   signalées, les trente-huit autres sont identiques.
3. Faites faire la même comparaison par un programme, et gardez son résultat
   dans un fichier :

   ```bash
   python comparer.py creer recette.md recette_v2.md modifs.diff
   ```

4. Ouvrez `modifs.diff` dans l'éditeur, et lisez son en-tête et sa première
   section.
5. Reconstruisez la seconde version à partir de la première et du fichier de
   différences, sous un troisième nom :

   ```bash
   python comparer.py appliquer recette.md modifs.diff recette_v3.md
   ```

6. Comparez `recette_v3.md` et `recette_v2.md` dans l'éditeur. Il n'y a aucune
   différence : le fichier de différences a suffi.

Rien n'est modifié sur place, ce qui permet de vérifier le résultat avant de
s'en servir. Un correctif appliqué sur une version qui n'est pas celle d'où il
vient est refusé, et le programme nomme alors la ligne qui ne correspond pas.
:::

## Ce qu'une comparaison peut dire d'un fichier binaire

Converties en `.odt`, les deux mêmes versions ne se comparent plus. `pandoc
recette.md -o recette.odt` produit un document de 127 047 octets, la photo
comprise ; la seconde version, qui diffère de deux mots, en produit un de la
même taille, dont 965 octets diffèrent du premier. Un `.odt` est une archive compressée : deux mots
changés y redistribuent un cinquième des octets, et aucune ligne n'y est
lisible.

```bash
python comparer.py creer recette.odt recette_v2.odt modifs.diff
```

```
recette.odt n'est pas un fichier texte : ses octets ne se lisent pas comme des
caractères. D'un fichier binaire, une comparaison ne peut dire que s'il diffère
d'un autre, pas ce qui y a changé.
```

C'est la réponse complète à « pourquoi un `.odt` se versionne mal », et la
raison pour laquelle un `.ipynb` se compare moins bien qu'un fichier MyST : le
premier est du texte, mais du texte produit par un programme, où une exécution
change des dizaines de lignes.
