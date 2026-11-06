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

GPX = Path(options.gpx)
CSV = GPX.with_suffix(".csv")
GEOJSON = GPX.with_suffix(".geojson")
CARTE = GPX.with_suffix(".html")
STATS = Path(__file__).parent / "stats_trace.py"

# Le CSV en Lambert-93, puis le résumé du TD 4a
commande = ["ogr2ogr", "-f", "CSV", CSV, GPX, "track_points", "-t_srs", "EPSG:2154",
            "-lco", "GEOMETRY=AS_XY", "-select", "ele,time", "-xyRes", "0.1"]
subprocess.run(commande, check=True)
commande = ["python", STATS, CSV, "--distance", "--vitesse"]
subprocess.run(commande, check=True)

# La carte
subprocess.run(["ogr2ogr", "-f", "GeoJSON", GEOJSON, GPX, "tracks"], check=True)
carte = folium.Map(tiles=PLAN_IGN, attr="Plan IGN", max_zoom=18)
trace = folium.GeoJson(str(GEOJSON))
trace.add_to(carte)
carte.fit_bounds(trace.get_bounds())
carte.save(CARTE)
print(f"carte écrite : {CARTE}")
