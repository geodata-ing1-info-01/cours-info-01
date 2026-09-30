# Contenu détaillé — Cours 5 : Matériel, réseau, clés SSH et secrets

Vue d'ensemble : [../../01_syllabus_v1.md](../../01_syllabus_v1.md) (section « Cours 5 »).

**Supports** : [`src/cours5/diapo/`](../../../src/cours5/diapo/) (typst, 43 pages d'exposé hors TD, dont la page de titre et cinq séparateurs ; deux photos annotées dans [`illustrations/cours5/`](../../../illustrations/cours5/) ; `--input notes=true` pour la version annotée, `--input corrige=true` pour le corrigé, `--input tds=false` pour le fil du cours).
**TD** : trois, `5a` (mesures), `5b` (clé SSH), `5c` (secret dans l'historique, facultatif). Un fichier par TD dans [`src/cours5/diapo/tds/`](../../../src/cours5/diapo/tds/), un dossier de même nom dans [`data/cours5/`](../../../data/cours5/).
Conventions d'écriture : [`STYLE.md`](../../../STYLE.md).

Objectif : donner les ordres de grandeur du matériel et du réseau qui expliquent la vitesse des outils, puis préparer la forge du cours 6 : une clé SSH sur le compte, et ce qui ne doit jamais entrer dans un dépôt.

---

## Parti pris

La séance 1 a été trop longue pour la salle. Celle-ci est écrite avec moins de TD : deux en séance (35′ en tout) et un facultatif. Le contenu est surtout de la culture générale ; les schémas et deux photos portent l'essentiel, les tableaux le reste, et les notes de conduite sont brèves.

Deuxième jet (20 septembre 2026) : ajout de deux photos annotées (boîtier ouvert, carte mère), de trente ans d'évolution des processeurs, de la puissance et de la consommation des appareils (du téléphone à touches au superordinateur), de l'électricité et du coût des services en ligne, et du sans-fil. Deux diapositives sont passées en notes pour tenir : « Ce que cela change pour un programme » (dans les notes de « Si la mémoire vive valait une seconde ») et « Où une clé SSH sert » (dans les notes de « Prouver qui l'on est », et dans le README du TD 5b). Le compte, après le troisième jet, est de 37 diapositives de contenu, plus la page de titre et cinq séparateurs.

## Ce que les étudiants ont déjà vu

Ce qui suit vient des programmes officiels ; le niveau réel de la salle est à sonder en séance, à l'oral, sur la première diapositive de chaque partie.

| Public | Enseignement | Ce qui recouvre la séance |
|--------|--------------|---------------------------|
| tous ceux qui ont fait un lycée général ou technologique depuis 2019 | SNT en seconde, 1 h 30 par semaine, sept thèmes | thème *Internet* : paquets, routage, adresses IP, DNS ; thème *localisation, cartographie et mobilité* : principe du GPS ; thème *informatique embarquée et objets connectés* |
| ceux qui ont pris la spécialité NSI (une minorité) | NSI en première | architecture de von Neumann : processeur, mémoire, bus, entrées-sorties ; système d'exploitation ; réseaux TCP/IP |
| | NSI en terminale | routage ; sécurité : chiffrement symétrique et asymétrique, HTTPS |
| prépa scientifique | informatique commune (programme 2021) | programmation Python, algorithmique, bases de données ; peu ou pas d'architecture matérielle |
| prépa littéraire | | rien de tout cela |

Conséquences pour la séance :

- **Partie 1 (matériel)** : nouvelle pour presque tous, sauf les anciens NSI, qui ont vu le vocabulaire (processeur, mémoire, bus) sans les ordres de grandeur ni la consommation. Aucune diapositive n'est une redite pour la majorité.
- **Partie 2 (réseau)** : adresse IP et DNS ont été vus en seconde par tous, quatre ans plus tôt, en 1 h 30 par semaine. La diapositive « Adresse, nom et port » se joue comme un rappel, en demandant à la salle ce qu'est le DNS avant de le dire. Débit et latence, la distance, le sans-fil : nouveaux.
- **Partie 3 (prouver qui l'on est)** : les pratiques (identifiant, mot de passe, hameçonnage) sont connues de tous par la vie courante ; ce qui est nouveau est le chiffrage des menaces, le hachage, et la cryptographie asymétrique, vue seulement en terminale NSI.
- **Partie 4 (secrets)** : nouvelle pour tous.

Sources : programme de SNT, arrêté du 17 janvier 2019 (BO spécial n° 1 du 22 janvier 2019) ; programmes de NSI de première et de terminale, mêmes arrêtés ; programme d'informatique commune des CPGE scientifiques, 2021.

Deux fils relient la séance au reste du module :

- les ordres de grandeur reviennent au cours 6 (boucle Python contre numpy, texte contre binaire) et au projet 7 (benchmark) ;
- la clé SSH, le deuxième facteur et le compte sur la forge sont les prérequis du cours 6, et la règle « aucun secret dans un dépôt » vaut pour les deux projets.

## Déroulé

| Partie | Nature | Durée |
|--------|--------|-------|
| Ouverture | cours | 3′ |
| 1. Le matériel | cours | 30′ |
| 2. Le réseau | cours, puis TD 5a | 15′ + 15′ |
| 3. Prouver qui l'on est | cours, puis TD 5b | 20′ + 20′ |
| 4. Les secrets de vos programmes | cours ; TD 5c facultatif | 15′ |
| Clôture | cours | 2′ |

Total : 120′, dont 35′ de TD.

---

## Ouverture (2 diapositives)

1. Page de titre.
2. **Contenu de la séance** : le tableau ci-dessus.

## Partie 1 — Le matériel (🎓 30′, 15 pages)

3. Séparateur.
4. **Les composants d'un ordinateur.** Schéma dessiné : le boîtier avec processeur, mémoire vive, disque, carte graphique (flèche : de l'image affichée au calcul parallèle), carte réseau et alimentation ; l'écran et le clavier à l'extérieur. Un rôle en quelques mots sous chaque composant.
4b. **Un boîtier ouvert.** Photo d'un PC de bureau des années 2010 (Wikimedia Commons, CC BY 4.0), sept repères numérotés : alimentation, carte mère, processeur sous son ventilateur, mémoire vive, disque, emplacements vides, connecteurs arrière. Notes : pas de carte graphique séparée sur un poste de bureau.
4c. **La carte mère.** Photo d'une carte ATX de 2020 (CC0), sept repères : processeur, emplacements mémoire, emplacements pour cartes, emplacement SSD M.2, jeu de puces, connecteurs arrière, alimentation et prises des disques. Ces deux diapositives ne sont produites que si les photos sont en place (`illustrations/cours5/telecharger.py`).
5. **Le processeur.** Quatre cœurs, chacun avec sa file d'instructions ; cadence 3 GHz = 3 milliards de cycles par seconde. Notes : un programme Python ordinaire n'occupe qu'un cœur.
5b. **Température du processeur.** Question à la salle, vote à main levée : 40, 60, 90 ou 150 °C pour un processeur qui calcule sans arrêt.
5c. **Température du processeur — réponses.** Tableau : 30 à 50 °C au repos, 60 à 90 °C en charge sur un poste de bureau, 80 à 100 °C sur un portable fin ; à la limite du fabricant (95 °C AMD, 100 °C Intel), la fréquence baisse. Notes : 50 à 100 W par cm² de puce, et le lien avec la fréquence plafonnée de « Trente ans de processeurs ».
6. **Mémoire vive et disque.** Tableau : taille, temps d'accès, à l'extinction, ce qu'on y trouve. Le lien avec le cours 1 : les variables d'un programme sont en mémoire vive, un fichier est sur le disque, et c'est pour cela qu'il reste.
7. **Le chemin d'une donnée.** Pyramide cache / mémoire vive / disque / réseau, avec taille et temps d'accès à chaque étage. Une donnée traitée par le processeur passe par tous les étages.
8. **Ordres de grandeur : tailles.** Tableau octet, Ko, Mo, Go, To avec un exemple chacun, dont une dalle d'orthophoto (5 000 × 5 000 pixels × 3 octets = 75 Mo). Notes : Ko = 1 000 octets, Kio = 1 024 ; Windows affiche des Kio en les appelant Ko.
9. **Ordres de grandeur : temps d'accès.** Barres sur échelle logarithmique, de la nanoseconde à la seconde : cache, mémoire vive, SSD, disque dur, réseau local, Paris–Marseille, Paris–New York, Paris–Sydney.
10. **Si la mémoire vive valait une seconde.** La même échelle, tableau : mémoire vive 1 s, SSD un quart d'heure, disque dur une journée, Paris–New York une semaine, Paris–Sydney un mois. C'est la diapositive à retenir de la partie.
11. **Processeur et carte graphique : la puce.** Deux puces de même taille, d'après la figure 1 du *CUDA C++ Programming Guide* (NVIDIA) : le processeur, huit cœurs faits surtout de contrôle, et un grand cache ; la carte graphique, des rangées d'unités de calcul avec un contrôle par rangée.
11b. **Processeur et carte graphique : une image.** Une image de 16 × 8 pixels à éclaircir : quatre cœurs par bandes, 32 étapes ; un cœur par pixel, une étape. Notes : les chiffres pour une dalle d'orthophoto, et la démonstration des MythBusters pour NVIDIA.
12. **Trente ans de processeurs.** Nuage de points 1990-2022, échelle log : transistors, fréquence, puissance, cœurs (données de Karl Rupp, CC BY 4.0, générées dans `donnees/tendances.typ`). La fréquence plafonne vers 2005 à 3 GHz, la puissance à 100 W ; les cœurs prennent le relais. Notes : mémoire, disque, prix du Go et modem sur la même période.
13. **Puissance de calcul et consommation.** Tableau du téléphone à touches au superordinateur ASCI Red (1997, 1,3 TFLOPS, 850 kW) : opérations par seconde, puissance, électricité par an. Un smartphone égale ASCI Red pour cent mille fois moins d'électricité.
14. **L'électricité des services en ligne.** Tableau : une question à un assistant d'IA (0,3 à 2 Wh, et 7 à 33 Wh pour un modèle qui raisonne, Jegham et al. 2025), une heure de streaming (80 Wh, IEA), 1 To gardé en ligne un an (40 à 150 kWh, calcul), le même To dans un tiroir (0), les centres de données du monde (415 TWh en 2024, 1,5 % de l'électricité mondiale, l'ordre de grandeur de la France). Notes : l'écart des estimations selon le périmètre ; les 0,24 Wh de Google (serveurs seuls, chiffre du fournisseur) ; l'analyse de cycle de vie de Mistral AI (Carbone 4, ADEME, 2025) : 1,14 g CO₂e et 45 mL d'eau par réponse, fabrication et entraînement compris.
15. **Ce que coûte un service en ligne.** Tableau : site personnel (0 à 60 €/an), OpenStreetMap (100 000 à 170 000 €, plan 2023 de l'OSMF), Wikipédia (3,4 M$ d'hébergement, exercice 2024-2025), Meta (72 milliards de $ d'investissement en 2025).

Passé en notes de la diapositive 10 : ce que cela change pour un programme (lire un fichier une fois, binaire plutôt que texte, numpy, commit local et push réseau).

Sources : Brendan Gregg, *Systems Performance* (2020), table 2.2 des latences ; Peter Norvig et Jeff Dean, « Latency numbers every programmer should know » ; Karl Rupp, *microprocessor-trend-data* ; IEA, *Energy and AI* (avril 2025) et *The carbon footprint of streaming video* (2020) ; Google, *Measuring the environmental impact of delivering AI at Google scale* (août 2025) ; OSMF, *Spending plan for 2023* ; Wikimedia Foundation, rapport d'audit 2024-2025 ; Meta, résultats du quatrième trimestre 2025 ; ASCI Red, Sandia National Laboratories.

## Partie 2 — Le réseau (🎓 15′, 9 pages)

13. Séparateur.
14. **Local et distant.** Schéma dessiné : le poste, le réseau de la salle, celui de l'école, Internet, le serveur ; les distances et les temps d'un aller-retour.
15. **Client et serveur.** Le client envoie une requête, le serveur répond. Tableau : navigateur et site web, `git push` et forge, `ssh` et serveur de calcul.
16. **Adresse, nom et port.** Une adresse SSH et une URL décomposées, comme le chemin de fichier du cours 1 : le protocole, le nom (que le DNS traduit en adresse IP), le port, le chemin.
17. **Débit et latence.** Schéma du tuyau : la latence est le temps du premier octet, le débit le nombre d'octets par seconde. Temps = latence + taille ÷ débit, calculé pour 1 Ko et 1 Go.
18. **La latence dépend de la distance.** Tableau Paris → Marseille, Londres, New York, Tokyo, Sydney : distance, aller-retour mesuré, part de la vitesse de la lumière dans la fibre (200 000 km/s). Source : wondernetwork.com, septembre 2026.
19. **Le débit dépend du lien.** Tableau : Ethernet de la salle, Wi-Fi, 4G, ADSL, et le temps de transfert de 1 Go. Avertissement : les débits sont en bits par seconde, les fichiers en octets, facteur 8.
19b. **Le sans-fil.** Tableau : Bluetooth, Wi-Fi, 4G et 5G, LoRa, GNSS ; portée, débit, latence, usage (dont les corrections RTK par la 4G, et le GNSS qui ne fait que recevoir, à 50 bit/s). Deux règles en légende : une onde est partagée, une onde s'écoute.
20. **Un commit et un push.** Schéma : le commit écrit sur le disque local (millisecondes), le push traverse le réseau (latence, puis débit). Conséquence : on peut travailler sans réseau et pousser quand on veut.

### ⌨️ TD 5a — Les ordres de grandeur de votre poste (15′)

Dossier `cours5/5a_mesures/`. Deux étapes :

1. Gestionnaire des tâches (`Ctrl` + `Maj` + `Échap`), onglet Performance : relever le nombre de cœurs, la cadence, la taille de la mémoire vive, le type et la taille du disque.
2. `python mesures.py` : quatre mesures (10 millions d'additions, copier 100 Mo en mémoire, écrire puis relire 100 Mo sur le disque, un aller-retour vers `github.com` et un téléchargement de 10 Mo). Remplir le tableau, comparer à l'échelle de la diapositive 9.

Ce que le TD fait constater (dans `reponse[…]`) : l'addition prend quelques dizaines de nanosecondes ; la relecture est dix fois plus rapide que l'écriture, parce que le système garde une copie du fichier en mémoire vive ; l'aller-retour réseau se compte en dizaines de millisecondes.

À vérifier en salle avant la séance : que `github.com:443` et `speed.cloudflare.com` répondent depuis les VM, une fois la session réseau ouverte. Le script affiche un message et continue si l'un des deux ne répond pas.

## Partie 3 — Prouver qui l'on est (🎓 20′, 10 pages)

Troisième jet (20 septembre 2026). Le syllabus partait de la cryptographie et arrivait aux secrets sans dire contre quoi on se protège. La partie part maintenant de ce que tout le monde fait, l'identifiant et le mot de passe, donne les quatre façons de perdre un mot de passe avec un chiffre pour chacune, puis une parade par façon. Le deuxième facteur et la clé SSH arrivent comme parades, avec leur raison ; l'empreinte (hachage) arrive en première diapositive, parce que c'est ce que le serveur garde.

21. Séparateur.
22. **Identifiant et mot de passe.** Chaîne : ce qu'on tape, l'empreinte (SHA-256, bcrypt), la comparaison avec l'empreinte gardée à l'inscription. Exemple réel : SHA-256 de « bonjour » et de « Bonjour ». Notes : même calcul que l'identifiant d'un commit ; un site qui renvoie le mot de passe en clair ne le stocke pas en empreinte.
23. **Quatre façons de perdre un mot de passe.** Quatre blocs : deviné (essais en masse, hors ligne sur une fuite d'empreintes), volé sur le serveur (22 % des intrusions commencent par un identifiant volé, Verizon DBIR 2025), volé chez vous (hameçonnage, logiciel espion), intercepté (réseau non chiffré). Annonce : une seule dépend de la longueur. Notes : réutilisation par 60 à 84 % des personnes interrogées ; haveibeenpwned.com.
24. **Combien de temps pour le deviner.** Tableau de quatre mots de passe et du temps hors ligne (Hive Systems 2026, bcrypt, seize RTX 5090) : `123456` instantané (listes de fuites), `Marseille2024!` secondes à heures (dictionnaire, année, signe), 8 caractères aléatoires 130 ans, 7 mots aléatoires hors de portée. Notes : la longueur et le hasard comptent, les classes imposées peu ; les trois équivalents de la CNIL ; pas de changement périodique (CNIL 2022, NIST).
25. **Hameçonnage.** La troisième façon. Courriel dessiné, annoté : domaine de l'expéditeur, urgence, domaine réel du lien, pièce jointe exécutable.
26. **Une parade par menace.** Tableau : deviné → long et aléatoire (gestionnaire) ; volé sur le serveur → un mot de passe par service (gestionnaire) ; volé chez vous → deuxième facteur ; intercepté → chiffrement (HTTPS, SSH, WPA). Annonce : le mot de passe de la messagerie d'abord, il réinitialise les autres.
27. **Le deuxième facteur.** Trois blocs (ce que je sais, ce que j'ai, ce que je suis) et un tableau des formes, de la plus faible à la plus forte : SMS, application à codes, clé physique ou passkey (résiste à l'hameçonnage). Légende : moins 99,2 % de comptes compromis, moins 98,6 % si le mot de passe a fui (Microsoft, 2023). Notes : GitHub l'impose depuis 2023 ; codes de secours.
28. **Une clé à la place du mot de passe.** Schéma cadenas et clé. Annonce : pour une machine ou un programme, rien à taper, rien de secret chez le serveur, rien d'utile sur le réseau. Notes : les quatre menaces reprises ; où la même paire sert (forge, serveur de calcul, `scp`, VS Code à distance).
29. **La connexion SSH.** Diagramme de séquence en quatre flèches : le client se présente, le serveur envoie un défi fermé avec la clé publique, le client le renvoie ouvert, le serveur ouvre l'accès.
30. **Les deux fichiers de la paire.** Sortie réelle de `ssh-keygen` ; `id_ed25519` (419 octets, privée) et `id_ed25519.pub` (107 octets, une ligne, à coller sur la forge).

Disparues par rapport au deuxième jet : « Prouver qui l'on est » (tableau mot de passe / clé, absorbé par 26 et 28), « Empreinte et chiffrement » (absorbé par 22 et 26), « Mots de passe » (remplacé par 24).

### ⌨️ TD 5b — Une clé SSH sur votre compte (20′)

Dossier `cours5/5b_cle_ssh/`. Prérequis : un compte GitHub créé avant la séance (page « Avant les séances »).

1. Dans l'invite de commandes d'Anaconda : `ssh-keygen -t ed25519 -C "prenom.nom@etu.ecole.fr"`, Entrée à chaque question (emplacement par défaut, sans phrase de passe pour aujourd'hui).
2. `type %USERPROFILE%\.ssh\id_ed25519.pub`, copier la ligne.
3. GitHub → Settings → SSH and GPG keys → New SSH key, coller, enregistrer.
4. `ssh -T git@github.com` : accepter l'empreinte du serveur à la première connexion, lire `Hi <compte>! You've successfully authenticated`.

Ce que le TD fait constater : le fichier `.pub` est une seule ligne ; le fichier sans extension n'est jamais ouvert ni copié ; la question `Are you sure you want to continue connecting` est l'empreinte du serveur, posée une fois.

À vérifier en salle avant la séance : que le port 22 sortant est ouvert. Sinon, GitHub accepte SSH sur le port 443 (`ssh.github.com`), avec un fichier `.ssh/config` à fournir dans le dossier du TD. `ssh-keygen` et `ssh` sont installés d'origine sous Windows 10 et 11 (`C:\Windows\System32\OpenSSH`).

## Partie 4 — Les secrets de vos programmes (🎓 15′, 6 pages)

Ce qui est retenu, et pourquoi. Les dix mesures de cybermalveillance.gouv.fr et le guide d'hygiène de l'ANSSI listent plus que ce qu'une séance peut porter. La partie 3 a pris les mots de passe, le deuxième facteur et l'hameçonnage. Celle-ci prend ce qui est propre à des étudiants qui écrivent du code et le publient, les secrets hors du dépôt, et ferme sur les mises à jour et les sauvegardes. Antivirus, achats en ligne, réseaux sociaux et Wi-Fi public sont laissés aux notes.

31. Séparateur. Annonce : un jeton d'API est un mot de passe pour programme, mêmes menaces, une parade de plus.
32. **Ce qui est un secret.** Tableau à garder / à partager : clé privée, mot de passe, jeton d'API ou *token* (service de cartographie, service d'IA), fichier `.env` ; contre clé publique, code, README, données publiques.
33. **Un secret dans un dépôt y reste.** Sortie réelle de `git log -p` : le commit qui supprime `config.py` n'efface pas celui qui l'a ajouté. Légende : 28,65 millions de secrets ajoutés sur GitHub public en 2025, 64 % de ceux de 2022 encore valides en 2026 (GitGuardian, *State of Secrets Sprawl 2026*).
34. **Séparer le code et les secrets.** Dans le dépôt `carte.py`, `config.example.py`, `.gitignore` ; hors dépôt `config.py`.
35. **Si un secret a fui.** Chaîne : révoquer, remplacer, nettoyer, prévenir. La première étape passe avant tout, parce que l'historique a déjà été copié.
36. **Mises à jour et sauvegardes.** Tableau : une mise à jour ferme une faille connue et publiée ; une sauvegarde suit la règle 3-2-1 ; un dépôt poussé sur la forge est une copie du code ; les données ignorées par git sont à sauvegarder à part.

### ⌨️ TD 5c — Un secret dans l'historique (10′, facultatif)

Dossier `cours5/5c_secret_historique/`. Rejouer la diapositive 33 : `git init`, un `config.py` avec une fausse clé, commit ; supprimer, commit ; `git log -p` montre les deux. Puis `.gitignore` et `config.example.py`, et `git status` ne voit plus `config.py`.

## Clôture (1 page)

37. **Vers le cours 6.** Tableau : fait aujourd'hui (compte sur la forge, clé enregistrée, deuxième facteur, règle du `.gitignore`, commit local et push réseau) ; au cours 6 (`clone`, `push`, `pull`, branches en équipe).

---

## Sources

- Programmes du lycée : SNT et NSI, BO spécial n° 1 du 22 janvier 2019, <https://eduscol.education.fr/>.
- Processeurs : Karl Rupp, *microprocessor-trend-data*, CC BY 4.0, <https://github.com/karlrupp/microprocessor-trend-data>.
- Électricité : IEA, *Energy and AI*, avril 2025, <https://www.iea.org/reports/energy-and-ai> ; IEA, *The carbon footprint of streaming video*, 2020 ; Google, *Measuring the environmental impact of delivering AI at Google Scale*, août 2025, <https://arxiv.org/abs/2508.15734> ; ASCI Red, <https://en.wikipedia.org/wiki/ASCI_Red>.
- Coûts : OSMF, *Spending plan for 2023*, <https://operations.osmfoundation.org/2022/12/31/plan.html> ; Wikimedia Foundation, audit 2024-2025 ; Meta, résultats 2025.
- Photos : Wikimedia Commons, voir `illustrations/cours5/README.md`.
- Latences : Brendan Gregg, *Systems Performance*, 2e éd., 2020, table 2.2 ; Jonas Bonér d'après Peter Norvig, « Latency numbers every programmer should know », <https://gist.github.com/hellerbarde/2843375>.
- Aller-retour Paris → villes : <https://wondernetwork.com/pings/Paris> (moyennes relevées le 20 septembre 2026).
- Clés SSH : GitHub Docs, « Generating a new SSH key and adding it to the ssh-agent » ; Microsoft Learn, « Key-based authentication in OpenSSH for Windows ».
- Secrets : GitGuardian, *The State of Secrets Sprawl 2026*, mars 2026, <https://blog.gitguardian.com/the-state-of-secrets-sprawl-2026/>.
- Mots de passe : CNIL, délibération n° 2022-100 du 21 juillet 2022, et <https://www.cnil.fr/fr/mots-de-passe-recommandations-pour-maitriser-sa-securite> ; Hive Systems, *Password Table 2026*, <https://www.hivesystems.com/password-table> ; Verizon, *2025 Data Breach Investigations Report* ; Microsoft, *How effective is multifactor authentication at deterring cyberattacks?*, 2023 ; Bitwarden, *World Password Day Survey 2025*.
- Mesures générales : cybermalveillance.gouv.fr, « Les 10 mesures essentielles pour assurer votre sécurité numérique » ; ANSSI, *Guide d'hygiène informatique*.
