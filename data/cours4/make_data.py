"""Fabrique les fichiers des TD du projet 4.

Deux parcours : le parcours standard fait le TD 4a, le client et le noyau
d'un notebook, puis le TD 4b, reprise du TD 3a du cours 3 ; le parcours
avancé fait le TD 4c, la fenêtre du train. Le dépôt versionne ce que chaque
TD livre tel quel (`depart/environment.yml`, `depart/modeles/`) et les
corrigés du TD 4c (`corriges/`). `build` remplit le `produit/` de chaque TD :
pour 4a, les recettes du cours 3 ; pour 4b, les fichiers du TD 3a du cours 3 ;
pour 4c, les images du décor, dessinées ici.

La montre et le tourbillon, TD 4a et 4b jusqu'au 26/09/2026, sont gardés
comme propositions dans `_propositions/` : `build` ne les fabrique plus, mais
leurs corrigés restent dans `corriges/`, que `illustrations` emploie encore.

    python make_data.py build           # produit/ des TD 4a, 4b et 4c
    python make_data.py illustrations   # les images des schémas, dans illustrations/cours4/

À lancer après `python make_data.py build` du cours 3, qui fabrique
`vague.jpg`. Le notebook de chaque TD est posé dans `produit/depart/notebook/`
par `outils/construire_notebooks.py`.
"""

from __future__ import annotations

import argparse
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

ICI = Path(__file__).parent
TD_MONTRE = ICI / "_propositions" / "4a_montre"
TD_TOURBILLON = ICI / "_propositions" / "4b_tourbillon"
TD_NOYAUX = ICI / "4a_noyaux"
TD_CLI = ICI / "4b_cli"
TD_TRAIN = ICI / "4c_train"
COURS3 = ICI.parent / "cours3"
VAGUE = ICI.parent / "cours3" / "2b_images" / "produit" / "depart" / "vague.jpg"
DEPOT = ICI.parent.parent
ILLUSTRATIONS = DEPOT / "illustrations" / "cours4"
SCHEMA = DEPOT / "src" / "cours4" / "diapo" / "schema_programme.typ"

# Les images de la vidéo montrées dans les schémas : cinq par TD, prises dans
# la série d'images du programme final (corrigé de l'étape B3).
VIGNETTES = {
    "montre": (["--heure", "10:00", "--minutes", "120"], [1, 31, 61, 91, 120]),
    "tourbillon": (["vague.jpg", "--maximum", "360"], [1, 7, 13, 19, 25]),
    "train": (["--images", "120"], [1, 31, 61, 91, 120]),
}
DOSSIERS_TD = {"montre": TD_MONTRE, "tourbillon": TD_TOURBILLON, "train": TD_TRAIN}

CREDITS_TRAIN = (
    "# Décor\n\n"
    "Les images de `decor/` sont dessinées par `make_data.py` (ImageMagick, "
    "des polygones de couleur unie), d'après la scène de la mer du clip "
    "« Moon » de Kid Francescoli, réalisé par le collectif Cauboyz (2017). "
    "Le clip a été tourné avec des décors en carton posés sur une table "
    "tournante : <https://www.youtube.com/watch?v=fdixQDPA2h0>.\n"
)


def vider(produit: Path) -> None:
    """Repart d'un `produit/` vide : rien de ce qu'un essai y a laissé ne part."""
    if produit.exists():
        for ancien in produit.iterdir():
            if ancien.name != ".gitkeep":
                shutil.rmtree(ancien) if ancien.is_dir() else ancien.unlink()
    produit.mkdir(parents=True, exist_ok=True)


def build() -> None:
    # TD 4a : les recettes du cours 3, que le notebook met en page (posé dans
    # `depart/notebook/` par construire_notebooks.py).
    produit = TD_NOYAUX / "produit"
    vider(produit)
    (produit / "travail").mkdir()
    depart = produit / "depart"
    for dossier in sorted((COURS3 / "recettes").iterdir()):
        if dossier.is_dir():
            shutil.copytree(dossier, depart / "recettes" / dossier.name)
    shutil.copy2(COURS3 / "recettes" / "style.css", depart / "style.css")
    print(f"✓ {TD_NOYAUX.name}/produit/depart/")

    # TD 4b : les fichiers du TD 3a du cours 3, sans l'outil portable. Les
    # recettes et leurs photos viennent de son produit/ : lancer d'abord
    # `make_data.py build` du cours 3.
    produit = TD_CLI / "produit"
    vider(produit)
    (produit / "travail").mkdir()
    depart = produit / "depart"
    source = COURS3 / "3a_cli" / "produit" / "depart"
    if source.is_dir():
        shutil.copytree(source, depart, ignore=shutil.ignore_patterns("outils"))
    else:
        print(f"! {source} absent — lancer `make_data.py build` du cours 3")
    for dossier in ("modeles", "secours"):
        shutil.copytree(COURS3 / "3a_cli" / "depart" / dossier, depart / dossier,
                        dirs_exist_ok=True, ignore=shutil.ignore_patterns("__pycache__"))
    print(f"✓ {TD_CLI.name}/produit/depart/")

    # TD 4c : le décor, dessiné ici.
    produit = TD_TRAIN / "produit"
    vider(produit)
    (produit / "travail").mkdir()
    depart = produit / "depart"
    decor_train(depart / "decor")
    (depart / "CREDITS.md").write_text(CREDITS_TRAIN, encoding="utf-8")
    schemas(depart / "notebook", "train")
    print(f"✓ {TD_TRAIN.name}/produit/depart/")


# ---- TD 4c : le décor de la fenêtre du train -----------------------------------
#
# Quatre images en aplats de couleur, d'après le clip « Moon » de Kid
# Francescoli (Cauboyz, 2017) : la scène de la mer, de jour, vue d'un train.
# Coordonnées écrites à la main, pour que chaque exécution donne les mêmes
# fichiers. Les bandes de 1920 pixels se raccordent d'un bord à l'autre : leur
# premier et leur dernier point sont à la même hauteur.

LARGEUR_BANDE = 1920
HORIZON = 270


def polygone(points: list[tuple[int, int]]) -> str:
    return "polygon " + " ".join(f"{x},{y}" for x, y in points)


def nuage(x: int, y: int, longueur: int, epaisseur: int) -> str:
    """Un nuage en lanière : pointu à gauche, coupé net à droite."""
    return polygone([(x, y), (x + longueur, y - epaisseur // 2), (x + longueur, y + epaisseur // 2)])


def voile(x: int, haut: int, bas: int, largeur: int) -> str:
    """Une voile : un triangle, le côté gauche presque vertical."""
    return polygone([(x, haut), (x + 2, bas), (x + largeur, bas)])


def colline(crete: list[tuple[int, int]]) -> str:
    """Une bande de terre : la ligne de crête, fermée par le bas de l'image."""
    return polygone(crete + [(LARGEUR_BANDE, 480), (0, 480)])


def dessiner(cible: Path, taille: str, fond: str, formes: list[tuple[str, str]], net: bool = False) -> None:
    """Une image : le fond, puis chaque forme (couleur, primitive -draw). `net` : sans lissage des bords."""
    commande = ["magick", "-size", taille, "xc:" + fond]
    if net:
        commande.append("+antialias")
    for couleur, primitive in formes:
        commande += ["-fill", couleur, "-draw", primitive]
    commande.append("PNG32:" + str(cible))
    subprocess.run(commande, check=True)


VOILES = [voile(180, 286, 352, 26), voile(470, 268, 318, 16), voile(1010, 280, 350, 26),
          voile(1380, 266, 316, 15), voile(1650, 272, 322, 17)]
CRETE_JAUNE = [(0, 382), (420, 330), (900, 405), (1300, 345), (1650, 398), (1920, 382)]


def decor_train(dossier: Path) -> None:
    """fond.png (fixe), plan.png (défile), fenetre.png (fixe, par-dessus) ; plage.png, le second plan du TD 7.

    voiles.png et plage_jaune.png séparent les deux parties de plan.png, pour
    l'annexe du guide (plusieurs plans, plusieurs vitesses).
    """
    dossier.mkdir(parents=True, exist_ok=True)
    dessiner(dossier / "fond.png", "640x480", "#a9ddd3", [
        ("#cfe7b9", nuage(270, 150, 370, 12)),
        ("#cfe7b9", nuage(60, 196, 300, 18)),
        ("#cfe7b9", nuage(440, 222, 200, 10)),
        ("#4b5bcc", f"rectangle 0,{HORIZON} 640,480"),
        ("#5b6bd8", f"rectangle 0,{HORIZON + 30} 640,{HORIZON + 31}"),
    ])
    voiles = [("#f3cfc9", v) for v in VOILES]
    plage_jaune = [("#f6c23f", colline(CRETE_JAUNE))]
    dessiner(dossier / "plan.png", f"{LARGEUR_BANDE}x480", "none", voiles + plage_jaune)
    dessiner(dossier / "voiles.png", f"{LARGEUR_BANDE}x480", "none", voiles)
    dessiner(dossier / "plage_jaune.png", f"{LARGEUR_BANDE}x480", "none", plage_jaune)
    crete = [(0, 432), (520, 396), (1000, 458), (1480, 408), (1920, 432)]
    dessiner(dossier / "plage.png", f"{LARGEUR_BANDE}x480", "none", [
        ("#f6dcb0", colline([(x, y - 2) for x, y in crete])),
        ("#e8801d", colline(crete)),
    ], net=True)
    # La fenêtre : opaque partout, sauf la vitre, transparente. Le masque est
    # dessiné sans lissage : chaque pixel est soit opaque, soit transparent.
    subprocess.run(["magick", "-size", "640x480", "xc:#0b0b0b",
                    "(", "-size", "640x480", "xc:white", "+antialias", "-fill", "black",
                    "-draw", "roundrectangle 40,30 599,449 56,56", ")",
                    "-alpha", "off", "-compose", "CopyOpacity", "-composite",
                    "PNG32:" + str(dossier / "fenetre.png")], check=True)


# ---- TD 4c : les images des schémas de la composition ------------------------
#
# Les schémas du début du notebook (`src/cours4/diapo/schemas_train.typ`)
# montrent le décor lui-même : les images ci-dessous en sont tirées. Un damier
# gris et blanc marque les pixels transparents.

EMPRISE = 640            # la largeur d'une image de la vidéo
DECALAGE_SCHEMA = 400    # le décalage de l'image montrée par les schémas
DEBORDEMENT_SCHEMA = 1500  # un décalage où l'emprise dépasse la bande
# L'annexe du guide : chaque plan et sa vitesse, en pixels par image ; l'image
# montrée est la numéro NUMERO_PLANS.
PLANS_ANNEXE = [("voiles", 4), ("plage_jaune", 8), ("plage", 16)]
NUMERO_PLANS = 40


def sur_damier(image, case: int = 16):
    """L'image (tableau RGBA) posée sur un damier gris et blanc : un tableau RGB."""
    import numpy as np
    hauteur, largeur = image.shape[:2]
    y, x = np.mgrid[0:hauteur, 0:largeur]
    damier = np.where(((x // case + y // case) % 2 == 0)[..., None], 255, 222).astype(float)
    alpha = image[..., 3:4] / 255
    return (image[..., :3] * alpha + damier * (1 - alpha)).astype(np.uint8)


def cylindre(bande, centre: int, cible: Path) -> None:
    """La bande enroulée sur un cylindre vertical, vue d'un peu au-dessus.

    La colonne `centre` de la bande est face à nous ; l'emprise, 640 colonnes
    autour d'elle, est encadrée. La face arrière, vue par l'ouverture du
    haut, est éclaircie. Rendu à deux fois la taille, puis réduit.
    """
    import numpy as np
    from PIL import Image, ImageDraw
    k = 2
    hauteur_bande, largeur_bande = bande.shape[:2]
    rayon = largeur_bande / (2 * np.pi)
    ellipse = 0.22 * rayon          # la demi-hauteur des cercles vus de biais
    marge = 14
    largeur, hauteur = int(2 * (rayon + marge)), int(hauteur_bande + 2 * ellipse + 2 * marge)
    cx, haut = largeur / 2, marge + ellipse
    Y, X = np.mgrid[0:hauteur * k, 0:largeur * k] / k
    sinus = np.clip((X - cx) / rayon, -1, 1)
    dedans = np.abs(X - cx) <= rayon
    rendu = np.full((hauteur * k, largeur * k, 3), 255, np.uint8)
    for face in ("arriere", "avant"):
        angle = np.arcsin(sinus) if face == "avant" else np.pi - np.arcsin(sinus)
        u = np.round(centre + angle * rayon).astype(int) % largeur_bande
        v = np.round(Y - haut - ellipse * np.cos(angle)).astype(int)
        visible = dedans & (v >= 0) & (v < hauteur_bande)
        couleurs = bande[np.clip(v, 0, hauteur_bande - 1), u]
        if face == "arriere":
            couleurs = (couleurs * 0.45 + 255 * 0.55).astype(np.uint8)
        rendu[visible] = couleurs[visible]
    image = Image.fromarray(rendu)
    dessin = ImageDraw.Draw(image)

    def point(angle: float, y: float) -> tuple[float, float]:
        return (k * (cx + rayon * np.sin(angle)), k * (y + ellipse * np.cos(angle)))

    def arc(debut: float, fin: float, y: float) -> list[tuple[float, float]]:
        return [point(a, y) for a in np.linspace(debut, fin, 200)]

    trait, contour = "#6b7683", "#182936"
    dessin.line(arc(0, 2 * np.pi, haut), fill=trait, width=2 * k)
    dessin.line(arc(-np.pi / 2, np.pi / 2, haut + hauteur_bande), fill=trait, width=2 * k)
    for cote in (-1, 1):
        dessin.line([point(cote * np.pi / 2, haut), point(cote * np.pi / 2, haut + hauteur_bande)], fill=trait, width=2 * k)
    # Le raccord, colonne 1 919 contre colonne 0, en tirets s'il est sur la face avant.
    raccord = ((largeur_bande - centre) % largeur_bande) / rayon
    raccord = raccord - 2 * np.pi if raccord > np.pi else raccord
    if abs(raccord) < np.pi / 2:
        for y in np.arange(haut, haut + hauteur_bande, 24):
            dessin.line([point(raccord, y), point(raccord, min(y + 14, haut + hauteur_bande))], fill="#B35309", width=3 * k)
    demi = EMPRISE / 2 / rayon
    dessin.line(arc(-demi, demi, haut) + arc(demi, -demi, haut + hauteur_bande) + [point(-demi, haut)],
                fill=contour, width=4 * k, joint="curve")
    image.resize((largeur, hauteur), Image.LANCZOS).save(cible)


def images_schemas_train(decor: Path) -> None:
    """Les images des schémas de la composition, dans illustrations/cours4/ : `train_*.png`."""
    import numpy as np
    from PIL import Image
    lire = lambda nom: np.asarray(Image.open(decor / nom).convert("RGBA"))  # noqa: E731
    plan, fenetre = lire("plan.png"), lire("fenetre.png")
    Image.open(decor / "fond.png").convert("RGB").save(ILLUSTRATIONS / "train_fond.png")
    Image.fromarray(sur_damier(plan)).save(ILLUSTRATIONS / "train_plan.png")
    Image.fromarray(sur_damier(fenetre)).save(ILLUSTRATIONS / "train_fenetre.png")
    subprocess.run(["magick", str(decor / "fond.png"),
                    "(", str(decor / "plan.png"), "-roll", f"-{DECALAGE_SCHEMA}+0",
                    "-crop", f"{EMPRISE}x480+0+0", "+repage", ")", "-composite",
                    str(ILLUSTRATIONS / "train_plan_sur_fond.png")], check=True)
    subprocess.run(["magick", str(ILLUSTRATIONS / "train_plan_sur_fond.png"),
                    str(decor / "fenetre.png"), "-composite",
                    str(ILLUSTRATIONS / "train_image.png")], check=True)
    cylindre(sur_damier(plan), DEBORDEMENT_SCHEMA + EMPRISE // 2, ILLUSTRATIONS / "train_cylindre.png")

    # Les images du guide : le plan à 1 500 découpé seul, puis tourné ; la
    # fenêtre posée avant le plan (lignes du conflit dans le mauvais ordre).
    def composer(cible: str, *morceaux: list[str]) -> None:
        commande = ["magick", str(decor / "fond.png")]
        for morceau in morceaux:
            commande += morceau + ["-composite"]
        subprocess.run(commande + [str(ILLUSTRATIONS / cible)], check=True)

    def plan_decale(nom: str, decalage: int, tourner: bool = True) -> list[str]:
        if tourner:
            return ["(", str(decor / nom), "-roll", f"-{decalage}+0", "-crop", f"{EMPRISE}x480+0+0", "+repage", ")"]
        return ["(", str(decor / nom), "-crop", f"{EMPRISE}x480+{decalage}+0", "+repage", ")"]

    fenetre_seule = [str(decor / "fenetre.png")]
    composer("train_decoupe_1500.png", plan_decale("plan.png", DEBORDEMENT_SCHEMA, tourner=False))
    composer("train_tourne_1500.png", plan_decale("plan.png", DEBORDEMENT_SCHEMA))
    composer("train_ordre_inverse.png", fenetre_seule, plan_decale("plan.png", DECALAGE_SCHEMA))

    # L'annexe : trois plans, trois vitesses, l'image numéro NUMERO_PLANS.
    for nom in ("voiles", "plage_jaune", "plage"):
        Image.fromarray(sur_damier(lire(nom + ".png"))).save(ILLUSTRATIONS / f"train_bande_{nom}.png")
    composer("train_plans.png", *[plan_decale(nom + ".png", NUMERO_PLANS * vitesse) for nom, vitesse in PLANS_ANNEXE],
             fenetre_seule)
    print(f"✓ {ILLUSTRATIONS.relative_to(DEPOT)}/train_fond.png, train_plan.png … train_cylindre.png")


def illustrations() -> None:
    """Les vignettes des schémas : le programme final lancé une fois par TD, cinq images réduites."""
    ILLUSTRATIONS.mkdir(parents=True, exist_ok=True)
    for nom, (options, numeros) in VIGNETTES.items():
        td = DOSSIERS_TD[nom]
        programme = ICI / "corriges" / td.name / ("b6" if nom == "train" else "b3") / (nom + ".py")
        with tempfile.TemporaryDirectory() as dossier:
            if nom == "tourbillon":
                shutil.copy(VAGUE, Path(dossier) / "vague.jpg")
            if nom == "train":
                decor_train(Path(dossier) / "decor")
                images_schemas_train(Path(dossier) / "decor")
            subprocess.run([sys.executable, str(programme), *options], cwd=dossier, check=True)
            images = Path(dossier) / "sortie" / "images"
            for rang, numero in enumerate(numeros, start=1):
                source = images / ("img_" + str(numero).zfill(4) + ".png")
                cible = ILLUSTRATIONS / (nom + "_" + str(rang) + ".jpg")
                subprocess.run(["magick", str(source), "-resize", "320x", "-quality", "85", str(cible)], check=True)
        print(f"✓ {ILLUSTRATIONS.relative_to(DEPOT)}/{nom}_1.jpg … {nom}_{len(numeros)}.jpg")


def schemas(depart_notebook: Path, nom: str) -> None:
    """Le schéma des étapes du programme, en PNG, à côté du notebook livré."""
    cible = depart_notebook.parent / "illustrations" / ("programme_" + nom + ".png")
    cible.parent.mkdir(parents=True, exist_ok=True)
    subprocess.run(["typst", "compile", "--root", str(DEPOT), "--input", "td=" + nom,
                    "--format", "png", "--ppi", "110", str(SCHEMA), str(cible)], check=True)


def main() -> None:
    analyseur = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    analyseur.add_argument("commande", choices=("build", "illustrations"))
    options = analyseur.parse_args()
    illustrations() if options.commande == "illustrations" else build()


if __name__ == "__main__":
    main()
