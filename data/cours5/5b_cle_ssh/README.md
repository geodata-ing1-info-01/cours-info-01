# Une clé SSH sur votre compte — TD 5b, cours 5

Fabriquer une paire de clés, coller la clé publique sur GitHub, vérifier la
connexion. Il faut un compte GitHub, créé avant la séance.

| Fichier | Ce qu'il contient |
|---|---|
| `config` | un fichier de secours pour `.ssh/`, si le port 22 est fermé en sortie (section « port 443 ») |

## Déroulé

Dans l'invite de commandes d'Anaconda :

```bash
ssh-keygen -t ed25519 -C "prenom.nom@etu.ecole.fr"
```

Entrée à chacune des trois questions : l'emplacement proposé
(`C:\Users\<vous>\.ssh\id_ed25519`), pas de phrase de passe aujourd'hui. Si
`ssh-keygen` répond `Overwrite (y/n)?`, une paire existe déjà : répondre `n`
et la garder.

```bash
type %USERPROFILE%\.ssh\id_ed25519.pub
```

Copier la ligne entière, du `ssh-ed25519` à l'adresse. Sur github.com : photo
de profil → Settings → SSH and GPG keys → New SSH key ; Title « poste école »,
Key la ligne copiée, Add SSH key.

```bash
ssh -T git@github.com
```

À la première connexion, `Are you sure you want to continue connecting` :
c'est l'empreinte du serveur, `yes`. L'empreinte attendue est publiée par
GitHub, page « GitHub's SSH key fingerprints » :
`SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU` pour la clé ED25519.
Puis `Hi <compte>! You've successfully authenticated` : la clé est reconnue.

## Ce qui se rate

| Ce qui s'affiche | Cause | Remède |
|---|---|---|
| `Permission denied (publickey)` | la clé publique n'est pas sur le compte, ou ce n'est pas la bonne ligne qui a été collée | refaire `type …\id_ed25519.pub`, vérifier que la ligne collée commence par `ssh-ed25519` |
| rien, puis `Connection timed out` | le port 22 est fermé en sortie | section « port 443 » |
| `'ssh-keygen' n'est pas reconnu` | le client OpenSSH de Windows n'est pas dans le `PATH` | `C:\Windows\System32\OpenSSH\ssh-keygen.exe`, ou Git Bash |

L'erreur à éviter : coller le contenu de `id_ed25519` (sans extension),
la clé privée. Elle ne quitte jamais le poste.

## Port 443

GitHub écoute aussi en SSH sur le port 443, le port du web, qu'aucun pare-feu
ne ferme. Le fichier `config` de ce dossier le dit à `ssh` ; le copier dans
`.ssh/` :

```bash
copy config %USERPROFILE%\.ssh\config
ssh -T git@github.com
```

La commande, et tout ce qui suit au cours 6, restent les mêmes.

## Avant la séance

Vérifier depuis une VM de la salle que `ssh -T git@github.com` aboutit sur le
port 22, ou sinon avec le fichier `config`. Vérifier que `ssh-keygen` est
trouvé depuis l'invite de commandes d'Anaconda.
