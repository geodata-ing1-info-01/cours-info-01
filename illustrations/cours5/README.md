# Illustrations — Cours 5

Deux photos, prises sur Wikimedia Commons sous licence libre, et le dessin
xkcd n° 936 (CC BY-NC 2.5 : usage non commercial, auteur cité). Les photos
sont annotées par les diapositives elles-mêmes (des repères numérotés posés
sur l'image, et une légende à côté). `telecharger.py` récupère les trois
fichiers ; ils sont versionnés, comme ceux du cours 1.

```bash
python illustrations/cours5/telecharger.py
python outils/compiler_diapos.py --cours 5      # les emploie si elles sont là
```

Sans elles, le schéma dessiné des composants est projeté seul, sans la photo
du boîtier ouvert à sa droite.

| Nom du fichier | Ce qu'il montre | Diapositive | Origine |
|----------------|-----------------|-------------|---------|
| `boitier_ouvert.jpg` | un PC de bureau des années 2010 ouvert : alimentation, carte mère, ventilateur du processeur, deux barrettes de mémoire, disque dans son berceau, emplacements de cartes vides | « Les composants d'un ordinateur » | [Bluechip-PC; Mitte der 2010er](https://commons.wikimedia.org/wiki/File:Bluechip-PC;_Mitte_der_2010er_20240827_HOF8538-HDR_RAW-Export.png), PantheraLeo1359531, CC BY 4.0 |
| `xkcd_936.png` | le dessin *Password Strength* : `Tr0ub4dor&3`, 28 bits, contre quatre mots tirés au hasard, 44 bits | « L'entropie d'un mot de passe » | [xkcd n° 936](https://xkcd.com/936/), Randall Munroe, 2011, CC BY-NC 2.5 |
| `carte_mere.jpg` | une carte mère ATX de 2020 (Gigabyte B550 UD AC) avec le ventilateur du processeur et deux barrettes de mémoire en place | « La carte mère », en commentaire depuis le 19/10/2026 | [Gigabyte B550 UD AC-Y1 - Front](https://commons.wikimedia.org/wiki/File:Gigabyte_B550_UD_AC-Y1_-_Front.png), Nicolasfoster, CC0 |

Les repères sont posés en fractions de la largeur et de la hauteur de l'image
(`photo-reperee` dans `src/cours5/diapo/schemas.typ`) : ils suivent la photo
quelle que soit la taille à laquelle elle est projetée. Changer de photo
demande de les replacer.
