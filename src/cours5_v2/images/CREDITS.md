# Image de la partie sur le fichier GPX

`carte_trace_2.png` : capture de la page `trace_2.html`, écrite par
`data/cours5_v2/programme/carte_trace.py` et ouverte dans Chromium le 06/11/2026. Fond :
Plan IGN, service WMTS de la Géoplateforme de l'IGN. Affichage : Leaflet.

La refaire : lancer le programme, servir la page par `python -m http.server`, puis
`chromium-browser --headless --window-size=900,640 --virtual-time-budget=40000 --screenshot=carte_trace_2.png <adresse>`.
