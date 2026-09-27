// TD 2a du cours 5 — « Une clé SSH sur votre compte ».
//
// Inclus par `cours5.typ`, qui porte les réglages globaux et importe `td`
// pour le sommaire des TD ; compilable seul par `outils/compiler_tds.py`.
#import "../../../commun/prelude.typ": *
#import "../style.typ": terminal

#let td = (
  numero: "2a",
  titre: "Une clé SSH sur votre compte",
  annonce: "Fabriquer une paire de clés, coller la clé publique sur GitHub, vérifier la connexion",
  dossier: "cours5/2a_cle_ssh/",
  duree: "20′",
)
#separateur-td(..td)

#d("Fabriquer la paire de clés")[
  #annonce[
    Taper la commande dans l'invite de commandes d'Anaconda, puis trois fois
    Entrée.
  ]

  #terminal("Anaconda Prompt", "> ssh-keygen -t ed25519 -C \"prenom.nom@etu.ecole.fr\"
Generating public/private ed25519 key pair.
Enter file in which to save the key (C:\\Users\\vous\\.ssh\\id_ed25519):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in C:\\Users\\vous\\.ssh\\id_ed25519
Your public key has been saved in C:\\Users\\vous\\.ssh\\id_ed25519.pub", taille: 13pt)

  #v(0.3em)
  #tableau(
    columns: (auto, 1fr),
    align: (left + horizon, left + horizon),
    [Question], [Réponse],
    [`Enter file in which to save the key`], [Entrée : l'emplacement proposé],
    [`Enter passphrase`], [Entrée, deux fois : pas de phrase de passe aujourd'hui],
    [`Overwrite (y/n)?`], [`n` : une paire existe déjà, la garder],
  )

  #notes[
    L'adresse est une étiquette : elle identifie la clé quand un compte en a
    plusieurs. Chacun met la sienne.

    `ssh-keygen` est installé avec Windows 10 et 11. Si la commande est
    introuvable, `C:\Windows\System32\OpenSSH\` manque au `PATH` ; Git Bash
    fournit aussi `ssh-keygen`.
  ]
]

#d("Coller la clé publique sur GitHub")[
  #annonce[
    Afficher la clé publique, copier la ligne entière et la coller dans le
    compte. Seul le fichier qui se termine par `.pub` se copie.
  ]

  #terminal("Anaconda Prompt", "> type %USERPROFILE%\\.ssh\\id_ed25519.pub
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFKIay24YXuydFOmWVIyBfd3aAkOOtGncHYAqvz+ZW75 prenom.nom@etu.ecole.fr")

  #v(0.3em)
  #tableau(
    columns: (auto, 1fr),
    align: (left + horizon, left + horizon),
    [Étape], [Où],
    [1. copier la ligne], [sélectionner dans le terminal, `Ctrl` + `C` ; du `ssh-ed25519` à l'adresse],
    [2. ouvrir la page des clés], [github.com → photo de profil → Settings → SSH and GPG keys → New SSH key],
    [3. coller], [Title : « poste école » ; Key : la ligne copiée ; Add SSH key],
  )


  #notes[
    Erreur fréquente : coller le contenu de `id_ed25519`, la clé privée. GitHub
    la rejette, mais elle est passée par le presse-papier. Vérifier que la
    ligne commence par `ssh-ed25519`.

    GitHub peut demander le mot de passe ou le deuxième facteur à l'ajout de la
    clé.
  ]
]

#d("Vérifier la connexion")[
  #terminal("Anaconda Prompt", "> ssh -T git@github.com
The authenticity of host 'github.com (140.82.121.4)' can't be established.
ED25519 key fingerprint is SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Hi alice-martin! You've successfully authenticated, but GitHub does not provide shell access.", taille: 12pt)

  #v(0.3em)
  #tableau(
    columns: (auto, 1fr),
    align: (left + horizon, left + horizon),
    [Ce qui s'affiche], [Ce que cela veut dire],
    [`Are you sure you want to continue…`], reponse[première connexion : l'empreinte du serveur, `yes` une fois],
    [`Hi <compte>! You've successfully…`], reponse[la clé est reconnue],
    [`Permission denied (publickey)`], reponse[la clé publique n'est pas sur le compte, ou mauvaise ligne collée],
    [rien, puis `Connection timed out`], reponse[port 22 fermé en sortie : feuille du TD, section « port 443 »],
  )

  #notes[
    L'empreinte affichée est celle de la clé ED25519 de GitHub, publiée sur
    docs.github.com (« GitHub's SSH key fingerprints ») : la comparer. Elle est
    ensuite enregistrée dans `.ssh/known_hosts`.

    Port 22 fermé : GitHub accepte aussi SSH sur le port 443. Copier le fichier
    `config` du dossier du TD dans `.ssh/` ; la commande ne change pas.
  ]
]
