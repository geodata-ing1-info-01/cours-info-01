// « Ordres de grandeur : temps d'accès » (parties/01_materiel.typ) :
// `barres-temps`, appelée avec les valeurs de la diapositive.
#import "_gabarit.typ": *
#import "../../diapo/schemas.typ": barres-temps
#show: schema-de-cours

#barres-temps((
  ([cache du processeur], 1e-9, [1 ns], accent),
  ([mémoire vive], 1e-7, [100 ns], accent),
  ([SSD], 1e-4, [100 µs], accent),
  ([disque dur], 1e-2, [10 ms], accent),
  ([réseau de la salle], 5e-4, [0,5 ms], attention),
  ([Paris – Marseille], 1.3e-2, [13 ms], attention),
  ([Paris – New York], 7.5e-2, [75 ms], attention),
  ([Paris – Sydney], 2.7e-1, [270 ms], attention),
))
