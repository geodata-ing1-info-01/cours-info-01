# Images du cours 5 v2

`carte_trace_2.png` : capture de la page `trace_2.html`, écrite par
`data/cours5_v2/programme/carte_trace.py` et ouverte dans Chromium le 06/11/2026. Fond :
Plan IGN, service WMTS de la Géoplateforme de l'IGN. Affichage : Leaflet.

La refaire : lancer le programme, servir la page par `python -m http.server`, puis
`chromium-browser --headless --window-size=900,640 --virtual-time-budget=40000 --screenshot=carte_trace_2.png <adresse>`.

`jupyter_base.png` et `jupyter_noyau_carte.png` : captures de JupyterLab 4.6 sous Linux, le
06/11/2026, pour la partie 5. Un environnement d'essai avec `python=3.12` et `jupyterlab` joue le
rôle de `base`.

Les refaire :

1. Écrire chaque notebook, avec son noyau dans les métadonnées, et l'exécuter par `nbclient`, puis
   raccourcir les chemins de ses sorties en `…/miniforge3` et `…/envs/carte`.
2. Lancer `jupyter lab --no-browser` depuis cet environnement.
3. Ouvrir `http://localhost:<port>/doc/tree/<notebook>.ipynb?token=<jeton>` par
   `chromium --headless --window-size=1100,430 --virtual-time-budget=25000 --screenshot=<fichier>`.
4. Couper la barre d'état, qui affiche « Connecting » pendant une capture : hauteur 336 px pour
   `jupyter_base.png`, 236 px pour `jupyter_noyau_carte.png`.
