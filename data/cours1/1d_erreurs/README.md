# Trois programmes fautifs — TD 1d, cours 1

Trois fichiers Python courts qui ne s'exécutent pas. Chacun porte une faute
d'un genre différent. Les deux premières se voient dans l'éditeur avant d'être
lancées : le soulignement de l'extension Python désigne la ligne, comme un
correcteur orthographique désigne un mot. La troisième, non — le programme est
correct, c'est la machine qui n'a pas ce qu'il demande.

| Dossier | Ce qu'il contient |
|---|---|
| `depart/` | les trois fichiers fautifs, à ne pas modifier |
| `travail/` | vide : vos copies, celles que vous corrigez |

## Les trois fautes

| Fichier | Faute | Ce que dit le message |
|---|---|---|
| `surface.py` | ligne 5 indentée par quatre espaces, ligne 6 par une tabulation | `TabError: inconsistent use of tabs and spaces in indentation`, ligne 6 |
| `moyenne.py` | deux-points manquants après le `for` | `SyntaxError: expected ':'`, ligne 6, avec un `^` sous la fin de la ligne |
| `chemin.py` | un chemin absolu, `C:/Users/alice/…`, qui n'existe que sur le poste où le programme a été écrit | `FileNotFoundError: [Errno 2] No such file or directory: 'C:/Users/alice/cours1/1a_formats/depart/raven_une_ligne.txt'` |

Messages relevés sur le poste de préparation, avec Python 3.12.14.

La première faute est la seule qui ne se voie pas à l'œil : les deux lignes
sont alignées à l'écran et diffèrent dans le fichier. Il faut l'affichage des
espaces, Affichage → Rendu des espaces → Tout, pour distinguer le point de la
flèche.

La troisième mérite le commentaire. Rien n'est faux dans le programme, et
l'éditeur ne souligne rien : le chemin est celui d'une autre machine. La
correction est un chemin **relatif**, qui part du dossier où le terminal se
trouve et vaut sur tous les postes :
`../1a_formats/depart/raven_une_ligne.txt`. C'est l'erreur la plus fréquente
des rendus de code, et la diapositive « Le chemin d'un fichier » appliquée.

## Déroulé

Copier les trois fichiers de `depart/` dans `travail/`, ouvrir le dossier
`cours1/1d_erreurs/` dans l'éditeur, puis, depuis son terminal :

```bash
conda activate base

python travail/surface.py    # TabError
python travail/moyenne.py    # SyntaxError
python travail/chemin.py     # FileNotFoundError
```

Une fois les trois copies corrigées, les mêmes commandes affichent `294.0`,
`130.05` et `1341 caractères`. La vérification est là : le programme se lance
et ne dit plus rien.

Le chemin relatif de `chemin.py` se compte depuis le dossier où le terminal se
trouve, `cours1/1d_erreurs/`, et non depuis le fichier. Il lit le poème du
TD 1a, dont le dossier doit donc être en place à côté de celui-ci. Dans le
dépôt, il est sous `1a_formats/produit/`, et le chemin à écrire y devient
`../1a_formats/produit/depart/raven_une_ligne.txt`.
