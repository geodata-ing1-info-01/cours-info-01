# Captures d'écran — Cours 1

Les diapositives illustrent certaines notions par de vraies captures d'écran.
Ces images **ne sont pas versionnées** : elles pèsent lourd pour un dépôt qui
garde tout définitivement, et elles vieillissent à chaque version des logiciels
photographiés. Elles sont distribuées à part, dans une archive à décompresser
ici, et ce dossier ne suit que le présent fichier.

Le jeu de diapositives compile sans elles : chaque capture a un équivalent
dessiné en typst, employé par défaut.

## Compiler avec les captures

```bash
typst compile --root . --input captures=true src/cours1/diapo/cours1.typ
```

Sans l'option, ou si l'archive n'a pas été décompressée, les schémas dessinés
prennent la place des images.

## Fichiers attendus

| Nom du fichier | Ce qu'il montre | Diapositive | Origine |
|----------------|-----------------|-------------|---------|
| `libreoffice_export_pdf.png` | LibreOffice Writer, `raven.odt` ouvert, Fichier → Exporter vers → Exporter au format PDF… | « Le menu d'exportation de LibreOffice » | produite ici |
| `vscode_projet.png` | VSCode sur un petit projet : arborescence, `trajet.py` coloré, terminal ayant lancé `python trajet.py` | « L'éditeur de code » | produite ici |
| `terminal_windows_powershell.jpg` | une fenêtre Windows PowerShell à l'ouverture | « Le terminal » | documentation Microsoft |
| `terminal_linux_gnome.png` | une fenêtre GNOME Terminal à l'ouverture | « Le terminal » | documentation GNOME |
| `vscode_espaces.png` | VSCode, affichage des espaces activé : quatre espaces ligne 2, une tabulation ligne 3, et le `TabError` dans le terminal | « Les caractères invisibles, affichés » | produite ici |
| `vscode_hello.png` | VSCode : les deux projets hello world, et le terminal ayant lancé Python puis compilé et exécuté le C++ | « Les deux exécutions dans l'éditeur » | produite ici |
| `page_html_brut.png` | `raven_brut.html` dans le navigateur, sans feuille de style | « Contenu et présentation » | **reproductible**, voir plus bas |
| `page_html_style.png` | `raven_style.html` avec `style.css`, dans le navigateur | « Contenu et présentation » | **reproductible**, voir plus bas |
| `notebook_jupyterlab.png` | JupyterLab, `trajet.ipynb` ouvert : bloc de texte mis en forme, bloc de code numéroté, sa sortie | « Un notebook dans JupyterLab » | **reproductible**, voir plus bas |
| `apercu_recette.png` | `recette.md` rendu : titre, tableau, liste numérotée, diagramme Mermaid | « Le résultat attendu » | **reproductible**, voir plus bas |
| `anaconda_navigator_accueil.png` | la page d'accueil d'Anaconda Navigator : la liste des environnements en haut sur `base (root)`, les fiches d'applications dont celle de VS Code | « La page d'accueil d'Anaconda Navigator » | documentation Anaconda |

Le nom du fichier est celui du tableau ci-dessus, à la lettre : c'est lui qui
est écrit dans le `.typ`.

## Captures reproductibles

Quatre d'entre elles ne demandent aucune manipulation à la souris : ce sont des
pages web, et un navigateur sans fenêtre les photographie. Elles peuvent donc
être refaites à l'identique quand les données changent.

```bash
D=illustrations/cours1

# les deux pages du poème, avec et sans feuille de style
cd data/cours1/1a_formats/produit/depart
for f in raven_brut raven_style; do
    chromium --headless --disable-gpu --hide-scrollbars \
        --screenshot="../../../../../$D/page_html_${f#raven_}.png" \
        --window-size=900,620 "file://$PWD/$f.html"
done

# le rendu de la recette : pandoc produit le HTML, mermaid dessine le schéma
pandoc data/cours1/1f_markdown/recette.md -t html -o page.html   # + script mermaid
chromium --headless --disable-gpu --hide-scrollbars \
    --virtual-time-budget=25000 --screenshot="$D/apercu_recette.png" \
    --window-size=760,1180 "file://$PWD/page.html"

convert "$D/apercu_recette.png" -trim +repage -bordercolor white -border 12 \
    "$D/apercu_recette.png"
```

Le notebook se photographie de la même façon, JupyterLab étant lui aussi une
page web. Le notebook de démonstration est fabriqué puis exécuté, pour que la
capture porte de vraies sorties, et le serveur est lancé sur un dossier qui ne
contient que lui — l'arborescence de gauche reste ainsi lisible. Le recadrage
retire le bas de la fenêtre, vide, et la bulle « Jupyter news » qui s'y affiche.

```bash
D=illustrations/cours1
mkdir -p "$D/demo"
# … écrire $D/demo/trajet.ipynb : un bloc Markdown, un bloc de code numpy,
#   un second bloc Markdown qui commente le résultat
jupyter nbconvert --execute --to notebook --inplace "$D/demo/trajet.ipynb"

jupyter lab --no-browser --port=8901 --ServerApp.token=info01demo \
    --ServerApp.root_dir="$D/demo" --ServerApp.open_browser=False &
sleep 8
chromium --headless --disable-gpu --hide-scrollbars --virtual-time-budget=40000 \
    --screenshot="$D/brut.png" --window-size=1400,880 \
    "http://localhost:8901/lab/tree/trajet.ipynb?token=info01demo"
python -c "from PIL import Image; im = Image.open('$D/brut.png'); \
    im.crop((0, 0, im.width, 535)).save('$D/notebook_jupyterlab.png')"
pkill -f "[j]upyter-lab"
rm -rf "$D/demo" "$D/brut.png"
```

> Sous Ubuntu, le Chromium installé en *snap* ne lit ni n'écrit hors de
> `$HOME`, ni dans les dossiers commençant par un point : passer par un dossier
> ordinaire du répertoire personnel, sans quoi la capture montre un
> « Accès au fichier refusé ».

Les autres montrent des fenêtres d'application — VSCode, LibreOffice, un
terminal — et se font à la main : il faut mettre l'interface dans l'état voulu
(un point d'arrêt posé, l'affichage des espaces activé), ce qu'aucun outil ne
reproduit fidèlement.

## Images reprises d'une documentation officielle

Trois images ne sont pas produites ici : ni terminal Windows ni Anaconda
Navigator ne sont disponibles sur le poste de préparation, et il vaut mieux une
capture publiée par l'éditeur qu'une reconstitution. Elles viennent des
documentations officielles, et leurs conditions de reprise sont différentes.

### `terminal_windows_powershell.jpg`

- Source : `reference/docs-conceptual/learn/ps101/media/figure1-2.jpg` du dépôt
  [MicrosoftDocs/PowerShell-Docs](https://github.com/MicrosoftDocs/PowerShell-Docs),
  figure 1-2 de la leçon
  [PowerShell 101 — Getting started](https://learn.microsoft.com/fr-fr/powershell/scripting/learn/ps101/01-getting-started).
- Licence de la documentation : **CC BY 4.0** (`LICENSE.md` du dépôt).
- La copie d'écran relève en plus des
  [règles Microsoft sur les captures](https://www.microsoft.com/en-us/legal/intellectualproperty/copyright/permissions),
  qui autorisent l'usage en documentation pédagogique à quatre conditions :
  ne pas montrer d'écran de démarrage ou de produit non publié, **ne pas
  modifier l'image autrement qu'en la redimensionnant**, ne pas en reprendre un
  fragment, et porter la mention *« Used with permission from Microsoft »*.
- **Conséquence pratique** : ce fichier ne doit être ni recadré, ni recompressé,
  ni réduit en nombre de couleurs, contrairement aux captures produites ici. Le
  `.typ` ne fait que le mettre à l'échelle. La mention figure sur la
  diapositive.

### `terminal_linux_gnome.png`

- Source : `help/C/figures/gnome-terminal.png` du dépôt
  [GNOME/gnome-terminal](https://gitlab.gnome.org/GNOME/gnome-terminal), figure
  du manuel de GNOME Terminal.
- Licence : au choix **CC BY-SA 3.0** ou **GPL v3** (`help/C/legal.xml`).
- **Point à trancher avant diffusion** : CC BY-SA est une licence à partage
  dans les mêmes conditions. Diffuser le PDF avec cette image demande au
  minimum de citer la source et la licence, ce que fait la légende de la
  diapositive. Si cette contrainte n'est pas souhaitée, la remplacer par une
  capture prise sur un poste de l'école règle la question.

### `anaconda_navigator_accueil.png`

- Source : `images/anaconda-desktop/nav-application-dropdown.png` de la
  documentation Anaconda,
  [Getting started with Navigator](https://www.anaconda.com/docs/tools/anaconda-navigator/getting-started),
  illustrant « Filter the application tiles with the applications dropdown
  menu ».
- Recadrée pour retirer le menu déroulant ouvert et la flèche d'annotation de
  la documentation, puis réduite à 1200 px et ramenée à 128 couleurs, comme les
  captures produites ici. Ce qu'il en reste est la liste des environnements sur
  `base (root)` et les fiches d'applications, dont celle de VS Code.
- **Point à trancher avant diffusion** : la documentation Anaconda ne porte pas
  de licence de réutilisation explicite, contrairement à celles de Microsoft et
  de GNOME traitées ci-dessus. L'usage est ici une projection en cours, mais si
  le PDF est diffusé hors de l'école, demander l'autorisation ou refaire la
  capture sur un poste de la salle — c'est de toute façon la version que les
  étudiants ont sous les yeux.

## Format des captures

| Contrainte | Valeur |
|------------|--------|
| Format | PNG, palette indexée (128 couleurs suffisent pour une interface) — sauf pour une image reprise d'une documentation, qu'on ne retouche pas |
| Largeur | 1200 px au plus — au-delà, rien n'est visible de plus sur la projection |
| Poids | 150 Ko par image au plus |
| Cadrage | la fenêtre seule, sans le bureau ni la barre des tâches |
| Contenu | aucune donnée personnelle : ni nom d'utilisateur ni nom de machine dans un chemin ou une invite, ni notification, ni onglet sans rapport |

Recadrer et alléger une capture, avec ImageMagick (déjà dans l'environnement) :

```bash
magick capture.png -crop 1440x715+80+38 +repage -resize 1200x \
       -colors 128 -strip vscode_projet.png
```

`-strip` retire les métadonnées, qui peuvent contenir le nom de la machine.

## Comment celles-ci ont été produites

Sur un **écran virtuel**, et non sur le bureau de quelqu'un : rien n'apparaît à
l'écran, le rendu ne dépend ni du thème du bureau ni de la taille de la
fenêtre, et aucune donnée personnelle ne peut se glisser dans l'image.

```bash
Xvfb :99 -screen 0 1600x1000x24 &

# LibreOffice, avec un profil neuf pour éviter tout réglage hérité
DISPLAY=:99 SAL_USE_VCLPLUGIN=gen \
  soffice -env:UserInstallation=file://$PWD/profil --norestore --nologo \
          --writer raven.odt &

DISPLAY=:99 import -window root capture.png
```

Le menu se déroule au clavier (`Alt`+`F`, puis les flèches), en envoyant les
touches à l'écran virtuel avec l'extension XTEST (`pip install python-xlib`).

Pour VSCode, mêmes principes, plus trois précautions qui font la différence
entre une capture montrable et une capture à refaire :

- `--user-data-dir` et `--extensions-dir` neufs, pour partir d'une installation
  vierge sans extension ni historique ;
- un thème clair et `"editor.minimap.enabled": false`, pour que la fenêtre
  reste lisible une fois réduite à la moitié d'une diapositive ;
- un profil de terminal dont l'invite est réduite à `$` et le dossier de
  travail placé hors du dossier personnel, faute de quoi la capture publie le
  nom de la machine et celui de l'utilisateur.

Le projet photographié est un exemple minimal (`trajet.py`, un fichier de
données, et l'image qu'il produit) : il n'a pas besoin d'exister dans le dépôt,
il sert seulement à ce que la fenêtre montre quelque chose de vrai.
