"""Le résumé et la carte d'une trace GPX."""

import argparse
import subprocess
from pathlib import Path

import folium

PLAN_IGN = ("https://data.geopf.fr/wmts?SERVICE=WMTS&REQUEST=GetTile&VERSION=1.0.0"
            "&LAYER=GEOGRAPHICALGRIDSYSTEMS.PLANIGNV2&STYLE=normal&FORMAT=image/png"
            "&TILEMATRIXSET=PM&TILEMATRIX={z}&TILEROW={y}&TILECOL={x}")

analyseur = argparse.ArgumentParser(description="Le résumé et la carte d'une trace GPX.")
analyseur.add_argument("gpx", help="le fichier GPX de la trace")
options = analyseur.parse_args()

FICHIER_GPX = Path(options.gpx)
FICHIER_CSV = FICHIER_GPX.with_suffix(".csv")
FICHIER_GEOJSON = FICHIER_GPX.with_suffix(".geojson")
FICHIER_CARTE = FICHIER_GPX.with_suffix(".html")
STATS = Path(__file__).parent / "stats_trace.py"

# Le CSV en Lambert-93, puis le résumé du TD 4a
options_ogr = ["-f", "CSV", "-t_srs", "EPSG:2154", "-lco", "GEOMETRY=AS_XY",
               "-select", "ele,time", "-xyRes", "0.1"]
commande = ["ogr2ogr", FICHIER_CSV, FICHIER_GPX, "track_points"] + options_ogr
subprocess.run(commande, check=True)
commande = ["python", STATS, FICHIER_CSV, "--distance", "--vitesse"]
subprocess.run(commande, check=True)

# La carte
commande = ["ogr2ogr", "-f", "GeoJSON", FICHIER_GEOJSON, FICHIER_GPX, "tracks"]
subprocess.run(commande, check=True)
carte = folium.Map(tiles=PLAN_IGN, attr="Plan IGN", max_zoom=18)
trace = folium.GeoJson(str(FICHIER_GEOJSON))
trace.add_to(carte)
carte.fit_bounds(trace.get_bounds())
carte.save(FICHIER_CARTE)
print(f"carte écrite : {FICHIER_CARTE}")
