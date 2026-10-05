---
title: Problèmes de réseau et de compte
subtitle: Session réseau, proxy, droits du compte
---

Le test du réseau est dans [Premiers tests du poste](../../avant/poste.md).

(dep-reseau)=
## Problèmes

(dep-r1)=
### R1. Rien ne se télécharge

Ce qu'on voit
: Firefox affiche une page de connexion, ou aucune page. `conda create`
  se termine par `CondaHTTPError: HTTP 000 CONNECTION FAILED for url <…>`.
  Dans VS Code, le panneau Extensions reste vide ou affiche « We cannot
  connect to the Extensions Marketplace ». Anaconda Navigator met plusieurs
  minutes à s'ouvrir ({ref}`A4 <dep-a4>`).

Cause
: La session réseau n'est pas ouverte, ou elle a expiré
  ([Premiers tests du poste](../../avant/poste.md)).

Vérifier
: Ouvrir <https://code.visualstudio.com> dans Firefox. Dans un `cmd`,
  `curl.exe -sS -I -m 10 https://repo.anaconda.com` doit répondre par une
  ligne `HTTP/… 200`.

Remède
: Lancer le raccourci d'authentification du bureau [à compléter : nom
  exact], se connecter, puis relancer ce qui avait échoué. Une commande qui
  échoue en fin de séance alors qu'elle passait au début a la même cause.

(dep-r2)=
### R2. Firefox fonctionne, mais conda ou VS Code n'atteignent rien

Ce qu'on voit
: Les pages web s'ouvrent, mais conda répond `ProxyError`, `HTTP 407` ou
  une erreur `SSL`, et le panneau Extensions de VS Code reste vide.

Cause
: Le réseau passe par un proxy, un serveur intermédiaire. Firefox le
  connaît, parce que Windows le lui indique ; conda et VS Code ne le
  connaissent pas tant qu'on ne le leur a pas indiqué.

Vérifier
: Paramètres Windows, Réseau et Internet, Proxy : une adresse y est-elle
  écrite ? Dans un `cmd`, `netsh winhttp show proxy`.

Remède
: [à compléter selon la salle]. Pour conda, écrire dans le fichier
  `C:\Users\<nom>\.condarc` (le créer avec le Bloc-notes s'il n'existe
  pas) :

```yaml
proxy_servers:
  http: http://<proxy>:<port>
  https: http://<proxy>:<port>
```

Pour VS Code : palette, « Preferences: Open Settings (UI) », chercher
`http.proxy`, et y écrire la même adresse.

(dep-r3)=
### R3. Windows demande un mot de passe d'administrateur

Ce qu'on voit
: Un installateur demande un mot de passe qu'on n'a pas. conda répond
  `EnvironmentNotWritableError` ({ref}`A8 <dep-a8>`). `Set-ExecutionPolicy` dans PowerShell répond « Accès refusé ».

Cause
: Les comptes élèves n'ont pas les droits d'administrateur. Anaconda est
  installé pour tous les utilisateurs et son dossier n'est pas modifiable
  par ces comptes.

Ce qui reste possible
: Créer ses propres environnements conda (ils vont dans
  `C:\Users\<nom>\.conda\envs`), installer des extensions VS Code, modifier
  ses propres fichiers de réglages.

Ce qui ne l'est pas
: Modifier ou mettre à jour `base` et Navigator ; changer le réglage de
  PowerShell ({ref}`A7 <dep-a7>`) ; installer un logiciel dans
  `Program Files`.
