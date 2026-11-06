# Conventions d'écriture du dépôt

Ce document fixe la façon d'écrire les supports. Il existe parce que la première
version des supports était mal écrite : phrases-choc isolées, gras décoratif,
faux suspense, et des diapositives qui n'étaient que de la prose découpée en
puces. Les règles ci-dessous sont contraignantes.

## Trois registres, trois médias

Un même contenu ne s'écrit pas pareil selon qui le lit et quand.

| Fichier | Lu par | Lu quand | Registre |
|---------|--------|----------|----------|
| `src/cours<n>/diapo/` | l'étudiant, projeté | pendant que l'enseignant parle | **assertion + preuve visuelle**, texte minimal |
| `src/cours<n>/notebook/` | l'étudiant, seul | pendant le TD, et après | **prose autonome**, phrases complètes |
| `syllabus/cours/<n>/` | l'enseignant | à la préparation | **notes de conduite**, télégraphique assumé |

L'erreur à ne pas refaire : écrire les diapositives comme la page de cours.

## Diapositives

La structure suit le modèle *assertion-evidence* de Michael Alley (Penn State),
validé expérimentalement : à discours identique, un auditoire retient mieux une
diapositive portant une idée et une preuve visuelle qu'une liste à puces.
Le titre, en revanche, reste **descriptif** — un groupe nominal, pas une
assertion compressée.

**Quatre règles :**

1. **Le titre nomme le sujet de la diapositive.** « Extension et contenu »,
   « Le système d'exploitation », « Contenu de la séance ». Pas de slogan, pas
   de tournure à contraste (« X, pas Y »), pas de formule qui cherche l'effet.
2. **Une phrase d'annonce sous le titre** (`#annonce[…]`) énonce l'idée quand
   elle ne se lit pas d'elle-même sur la preuve. Une à deux phrases, au
   présent, sans emphase.
3. **Le corps est une preuve visuelle** : un schéma, une sortie de commande, un
   extrait de code, une comparaison. Pas de liste à puces.
4. **Ce que l'enseignant dit n'est pas écrit** (principe de redondance de
   Mayer : texte affiché plus même texte prononcé dégrade l'apprentissage). Le
   commentaire va dans `#notes[…]`, visible avec `--input notes=true`.

**Conséquences pratiques :**

- Une idée par diapositive. Un titre contenant « et » qui relie deux sujets
  distincts signale qu'il en faut deux.
- Une énumération de cinq items est le signe qu'il manque un schéma ou un
  tableau.
- Un tableau de comparaison est une preuve visuelle : il est légitime quand la
  comparaison est le propos.
- Des diapositives de séparation (`#separateur(…)`) marquent le passage d'une
  partie à l'autre.
- Principe de cohérence (Mayer) : tout élément qui ne sert pas nuit. Pas
  d'emoji décoratif, pas de couleur qui ne code rien. Le thème n'emploie que
  cinq couleurs, et chacune code une information réelle et répétée : le bleu du
  texte et des diapositives de section, le brun des TD (`separateur-td`,
  `sommaire-td`, `objectif`) qui marque le passage de l'exposé au travail sur machine,
  le gris des encadrés, puis deux couleurs de
  signalement — `attention`, un bleu clair, sur un point à ne pas manquer, et
  `alerte`, un orange, sur une erreur fréquente et ses conséquences. Ces deux
  dernières répondent aux encadrés `note` et `warning` des pages de cours, et
  ne servent jamais à mettre un mot en valeur : le gras s'en charge, et
  seulement sur un terme défini. `alerte` ne s'emploie pas dans un TD,
  où le brun est déjà présent : un avertissement y prend la couleur `attention`,
  par `#avertissement(couleur: attention)[…]`.

**Formulations à éviter**, relevées sur une première version de ce deck :

| Écrit | À écrire |
|-------|----------|
| « Ce module enseigne les gestes que les autres cours supposent acquis » | Titre : « Objectif du cours ». Annonce : « Consolider ou acquérir les bases informatiques nécessaires aux autres enseignements. » |
| « Ce module traite la forme des projets, pas l'algorithmique » | Titre : « Objectif pour la programmation », suivi de ce que cela recouvre. |
| « La séance répond à quatre questions qui s'enchaînent » | « Contenu de la séance » |
| « Un `.odt` est une archive ZIP de fichiers XML » | Titre : « Structure d'un fichier `.odt` ». L'affirmation passe en annonce. |

Les titres des sections des pages de cours suivent la même règle, pour que les
deux supports se répondent.

## Prose (pages de cours, syllabus, README)

La page de cours est lue sans commentaire oral : elle doit se suffire. Elle
s'écrit donc en **phrases complètes et déclaratives**.

**À faire**

- Annoncer ce dont on parle, puis le dire. Pas de suspense.
- Une idée par paragraphe, 3 à 6 lignes.
- Justifier les choix quand ils ne vont pas de soi ; ne pas justifier l'évident.
- Employer le mot technique dès qu'il a été défini, plutôt que des périphrases.

**À proscrire** (relevé sur la première version de ce dépôt)

| Tic | Exemple produit | Correction |
|-----|-----------------|------------|
| Phrase-choc isolée en paragraphe | « Rien de plus. » / « C'est tout. » | l'intégrer à la phrase précédente |
| Faux suspense | « Voilà l'idée centrale, et elle surprend souvent » | énoncer l'idée directement |
| Gras décoratif | trois mots en gras par paragraphe | le gras signale un terme défini, rien d'autre |
| Formule répétée | « Ce que ça montre : » dans chaque encadré | varier, ou supprimer si l'exercice le dit déjà |
| Tiret cadratin en connecteur | « le fichier — celui qu'on ouvre — est binaire » | virgules, parenthèses, ou deux phrases |
| Méta-commentaire pédagogique | « le moment "ah !" de la séance » | réservé aux notes enseignant |
| Auto-annonce | « Voilà pourquoi c'est important » | le montrer, ne pas l'annoncer |
| Question rhétorique | « Cette boîte-là, comment est-elle fabriquée ? » | énoncer ce dont on va parler |
| Emoji comme structure | ✅ ❌ ⚠️ en début de ligne | des mots, ou un tableau |
| Triplets systématiques | tout par groupes de trois | suivre le contenu, pas le rythme |

**Sur les émoji** : `🎓` et `⌨️` sont conservés dans le *syllabus* et les notes
enseignant, où ils codent une information réelle (exposé / TD) et
répétée. Ailleurs, ils sont décoratifs — donc supprimés.

**Sur les procédures et les tableaux** : une suite d'actions s'écrit en liste
numérotée, avec une action par étape, son résultat, puis le renvoi en cas
d'échec. Un renvoi nomme son cas quand il y en a plusieurs. Un tableau présente
des données à deux dimensions, sans ordre de lecture : comparaison,
correspondance, réglages, chemins.

## TD et corrigé

Ce qu'un TD fait constater n'apparaît que dans le corrigé. La colonne
d'observation d'un tableau de TD s'écrit dans `reponse[…]`. Hors de la
compilation `--input corrige=true`, distribuée après la séance, `tableau`
retire cette colonne, avec son en-tête : une feuille PDF ne se remplit pas,
et les diapositives de TD ne sont pas toujours projetées (décision du
27/09/2026). Une case `reponse[…]` dans une colonne qui contient autre chose
reste vide.

L'**effet de pré-test** motive ce choix. Tenter de répondre avant de
connaître la réponse améliore la rétention de celle-ci, y compris quand la
tentative échoue, pourvu que la réponse soit donnée ensuite. La tentative se
fait sur machine, pendant le TD. La correction n'est pas facultative, car
elle rend la tentative profitable. Le guide détaillé la donne à sa fin, dans
« Ce que le TD fait constater », et le corrigé la donne après la séance.

En pratique : ce que l'étudiant produit ou observe est masqué ; la consigne, le
vocabulaire et les définitions ne le sont jamais. Une diapositive de réponses
séparée, comme « Reconnaître un format à son extension — réponses », reste
préférable quand la question se pose à la salle plutôt que sur machine.

Sources : Richland, Kornell & Kao, *Do unsuccessful retrieval attempts enhance
learning?* (JEP:Applied, 2009) —
[texte](https://learninglab.uchicago.edu/Pre-Testing_files/RichlandKornellKao.pdf) ;
Kornell, Hays & Bjork, *Unsuccessful retrieval attempts enhance subsequent
learning* (JEP:LMC, 2009) —
[texte](https://bjorklab.psych.ucla.edu/wp-content/uploads/sites/13/2016/07/Hays_Kornell_RBjork_inpress.pdf).

**Titre et objectif d'une diapositive de TD** (règle du 06/11/2026). Une diapositive
qui donne seulement des étapes oblige l'élève à les suivre sans savoir ce qu'il cherche à
obtenir, et l'empêche de réfléchir à la façon de faire.

- Le titre nomme le sujet, en groupe nominal, sans verbe ni question. Un numéro d'étape
  reste en tête : « Étape B4 · Fonction distance_entre ».
- Une diapositive d'action énonce son objectif dans le bloc `#objectif[…]`, avant les
  consignes. Il donne en une phrase le résultat à obtenir, les fichiers employés, et l'outil
  s'il compte. Il ne révèle pas ce que le TD fait constater : il emploie alors « déterminer
  si » ou « comparer ».
- Chaque consigne sert cet objectif. Une consigne qui sert un autre objectif change de
  diapositive.
- Une action s'écrit en consigne. Elle ne se cache ni dans un encadré, ni dans une annonce,
  ni dans une légende.
- L'objectif nomme les fichiers employés, y compris ceux qu'une étape précédente a produits.
- Une étape à faire en même temps que la salle porte un avertissement, sous l'objectif, qui
  demande d'attendre le signal de l'enseignant.

**Diapositives d'étape de TD** (à l'essai depuis le 30/09/2026). Une
diapositive « Étape n » donne, l'un sous l'autre, ce qu'on doit obtenir à la
fin de l'étape, puis les pistes pour y arriver (gabarit `attendu-pistes`).
Ce sont les seules diapositives où une liste est admise : une coche marque
ce qu'on vérifie, un numéro l'ordre des opérations. Un attendu décrit un
résultat visible, par exemple « `python recette.py` affiche la recette pour
6 personnes », et non une commande ou un fragment de code seuls. Une piste
commence par un verbe. Les deux listes ne sont pas côte à côte, car leurs
lignes sembleraient se répondre.

**Nom d'un TD** (règle du 30/09/2026). Un TD s'appelle « TD » suivi du
numéro de sa séance et d'une lettre : a, b, c, dans l'ordre où la séance
fait ses TD. Le TD 3e est le cinquième TD de la séance 3, et aucun autre TD
du module ne porte ce nom : un renvoi n'a pas besoin d'ajouter « du cours
3 ». La lettre ne dépend pas des parties de l'exposé. Le dossier, le fichier
de `tds/` et le guide portent le même nom (`3e_markdown`). Le statut du TD
est le champ `statut` de son dictionnaire, `"facultatif"`, `"parcours
standard"` ou `"parcours avancé"`, absent quand tous le font. Il est écrit
à côté du numéro sur l'ouverture, le sommaire et le README de l'archive, et
jamais dans le nom du dossier, pour qu'un TD change de statut sans changer
de nom. Les anciens numéros sont dans `src/anciens_noms_td.md`.

## Illustrations et captures d'écran

Un schéma dessiné est préféré par défaut : rien à distribuer, rien à refaire
quand le logiciel change de version, un rendu identique partout. Une capture
d'écran ne se justifie que pour ce qu'un schéma ne peut pas montrer, comme le
nombre réel d'entrées d'un menu ou l'encombrement réel d'une fenêtre.

Quand les deux sont utiles, ils vont sur deux diapositives : le schéma porte
l'idée, la capture porte la preuve. Les mettre côte à côte les rend illisibles
l'un et l'autre.

Les captures ne sont pas versionnées, et leur fabrication est décrite dans
[`illustrations/cours1/README.md`](illustrations/cours1/README.md).

## Tournures corrigées en relecture

Les relectures de septembre 2026 (cours 2, 3 et 5), d'octobre 2026
(cours 1 v2) et de novembre 2026 (cours 2 v2, pages de configuration du site)
ont corrigé les mêmes tournures,
y compris dans des diapositives réécrites après une première correction. Elles s'ajoutent à la
table précédente.

| Tournure | Écrit | Corrigé |
|----------|-------|---------|
| Contraste « X, pas Y », « plutôt que », « et non » | « La ligne du disque est un calcul, pas une mesure » | « La ligne du disque est un calcul » |
| Formule « c'est » | « C'est la diapositive à retenir de la partie » | « Diapositive à retenir » (notes) |
| Chute après deux-points | « La carte mère ne calcule pas : elle relie » | « La carte mère relie les composants par des pistes de cuivre » |
| Image, personnification | « le dépôt vit dans… », « tiré par l'IA », « se suit seul » | « le dépôt reste dans… », « surtout par l'IA », « autonome » |
| Annonce sans verbe | « Dans l'Anaconda Prompt. » | « Les commandes se tapent dans l'Anaconda Prompt. » |
| Annonce qui reformule le titre | « Chaque étape corrige une limite de la précédente » sous un tableau dont une colonne s'intitule « Limite corrigée » | pas d'annonce |
| Verbe vague ou elliptique | « un `import` suffit » | « s'importent sans installation » |
| Constat à la place d'une consigne | « `depart/raven.odt` reste ouvert dans LibreOffice Writer » ; « L'archive se copie de `formationTemp` vers le Bureau, puis s'extrait » | « Dans `depart\`, double-cliquer sur `raven.odt`. » ; « Chacun doit la copier sur le Bureau, puis l'extraire. » |
| Objet sujet d'un verbe d'action, pronom flou | « Chaque export en écrit une copie » | « Exporter en PDF : menu Fichier, Exporter sous, Exporter au format PDF… » |
| Consigne reléguée en fin de phrase | « …une copie, dans un autre format, à enregistrer dans `travail/` » | « Enregistrer dans `travail\` », en tête de la consigne |
| Généralité à la place des cas | « chaque export », « un autre format » | « en PDF », « en PNG » |
| Titre en deux membres reliés par une relative | « La commande `python` et le fichier qu'elle lance » | « Exécution d'un programme Python » |
| Annonce à effet qui répète le schéma | « Chaque outil a sa fenêtre. À chaque modification, il faut passer de l'une à l'autre. » | pas d'annonce ; dans les notes : « après une modification dans Notepad++, il faut enregistrer le fichier, revenir dans Git Bash et relancer `python altitudes.py` » |
| Relative en fin de phrase, cause approximative | « LibreOffice Writer enregistre aussi la mise en forme, que Python ne peut pas lire. » | « Un programme écrit dans LibreOffice Writer est enregistré en `.odt`, et `python` ne peut pas exécuter ce fichier. » |
| Annonce écrite pour remplir la place | « Un fichier `.py` écrit dans l'un de ces outils s'exécute dans les deux autres. » | pas d'annonce |
| Annonce par décompte | « Deux façons de les modifier, au choix : » | « Les réglages se modifient dans l'interface ou dans le fichier : » |
| Titre de colonne en relative | « Ce qu'il obtient » | « Effet » |
| Procédure dans un tableau | « Ce qu'on fait / Ce qu'on doit voir / Sinon » | « 2. Taper `conda --version`, Entrée. La fenêtre affiche `conda 25.x` ou `conda 24.x`. Sinon : A2. » |
| Renvois sans leur cas | « A1, A3 » | « Si le menu ne propose pas « Anaconda Prompt » : A1. Sans `(base)` : A3. » |
| Historique du dépôt dans une page élève | « Le profil « Git Bash » et les deux réglages de l'éditeur ont été ajoutés le 27 septembre 2026 » | supprimé |
| Annonce qui résume des panneaux, verbe vague | « Un import et deux appels s'y ajoutent, et le poste de développement doit d'abord recevoir ce que ces lignes appellent » | pas d'annonce ; légende : « En bleu, les lignes ajoutées au programme du cours 4. » |
| Cellule de tableau sans verbe | « les tuiles du fond, le zoom » | « récupérer les tuiles de fond, gérer le zoom » |
| Sujet abstrait, verbe vague | « Beaucoup de besoins sont déjà couverts par des outils existants » | « Un programme peut appeler des outils écrits et testés par d'autres » |
| Chiasme, parallélisme à effet | « au cours 3, une autre personne utilise votre code ; ici, votre code utilise celui des autres » ; « Une correction y coûte une ligne, alors qu'elle coûte aujourd'hui une refonte » | « Cours 3 : une autre personne utilise le code. Cours 5 : le code appelle des outils écrits par d'autres. » |
| Image dans une note | « Le fichier de projet raccourcit le chemin sur le nouveau poste » | « Avec le fichier de projet, le nouveau poste compte moins d'étapes » |
| Consigne en titre d'une diapositive de TD | « Exporter le document `raven.odt` en PDF et PNG » | titre : « Conversion d'un document en d'autres formats » ; objectif : « exporter `raven.odt` en PDF et en PNG… » |
| Titre en question | « Quels formats permettent la manipulation du texte ? » | titre : « Manipulation du texte selon le format » ; objectif : « reprendre `raven.odt` et ses deux exports, `raven.pdf` et `raven.png`, et déterminer dans lesquels le texte se sélectionne et se cherche. » |
| Annonce raccourcie en titre | « Deux dossiers par TD : `depart/` et `travail/` » | titre : « Organisation des TD » ; l'annonce explique le rôle des deux dossiers |

Sur une diapositive de TD, ce que l'élève doit faire s'écrit en consignes
numérotées (gabarit `consignes`) ou en pistes (`attendu-pistes`) : une
action par ligne, dans l'ordre de la manipulation, le verbe en tête, le
fichier, le menu ou le bouton nommés. Une annonce qui décrit un état
(« reste ouvert », « se copie », « va dans ») oblige l'élève à deviner
l'action.

Une restructuration réécrit des phrases : le texte nouveau repasse par ces
deux tables, et un texte déjà relu se déplace sans être reformulé.
`python outils/verifier_style.py` relève les tournures repérables
automatiquement dans les lignes ajoutées depuis le dernier commit. Il n'en voit
qu'une partie : relire ces deux tables juste avant d'écrire, puis comparer à ces
tables chaque phrase nouvelle, une par une, avant de rendre le texte.

## Encadrés

Un encadré n'est pas un moyen de mettre du texte en valeur. Il signale un
changement de nature du contenu :

| Encadré | Contenu |
|---------|---------|
| `:::{admonition} À faire` | ce que l'étudiant doit faire, à l'impératif |
| `:::{note}` | une précision qu'on peut sauter en première lecture |
| `:::{warning}` | une erreur fréquente et ses conséquences |

Pas d'encadré « à retenir » qui recopie le paragraphe précédent.

## Code et sorties

- Tout extrait de code affiché doit être exécutable tel quel.
- Les sorties montrées sont des sorties réelles, pas reconstituées.
- Un extrait de plus de 15 lignes va dans un fichier, pas dans la page.

## Vérification avant de committer un support

- [ ] Chaque titre de diapositive nomme le sujet, sans slogan ni contraste.
- [ ] Aucune diapositive ne contient de liste à puces, sauf les diapositives d'étape de TD (« TD et corrigé »).
- [ ] Aucun paragraphe d'une seule phrase courte destiné à faire effet.
- [ ] Le gras ne marque que des termes définis.
- [ ] Aucun encadré ne répète le paragraphe voisin.
- [ ] Une suite d'actions est une liste numérotée, et un tableau ne contient que des données à deux dimensions.
- [ ] Les commandes montrées ont été exécutées.
- [ ] Ce que le TD fait constater est dans `reponse[…]`.
- [ ] Une diapositive d'action d'un TD énonce son objectif, et chaque consigne sert cet objectif.
- [ ] Un TD nouveau est un fichier de `tds/` nommé comme son dossier, avec son dictionnaire `td` en tête, importé et inclus par `cours<n>.typ`.
- [ ] Un TD nouveau s'appelle `<séance><lettre>`, la lettre suivant l'ordre de la séance ; son statut est dans `statut`, pas dans son nom.
- [ ] Les chemins cités dans un TD sont ceux de l'archive livrée : `cours1/1c_vscode_python/`, sans `data/` ni `produit/`.
- [ ] `python outils/verifier_diapos.py` ne signale rien.
- [ ] `python outils/verifier_style.py` ne signale rien, ou chaque signalement a été relu.

## Sources

- Michael Alley, *The Craft of Scientific Presentations* — structure
  assertion-evidence : [writing.engr.psu.edu/research.html](https://writing.engr.psu.edu/research.html)
  et le [jeu d'instructions Penn State](https://cpb-us-e1.wpmucdn.com/sites.psu.edu/dist/7/13153/files/2008/10/Assertion-Evidence-Slides-Instruction_Set.pdf)
- Richard Mayer, principes de cohérence, de signalement et de redondance :
  [synthèse](https://www.hartford.edu/faculty-staff/faculty/fcld/_files/12%20Principles%20of%20Multimedia%20Learning.pdf)
- Synthèse des études comparatives :
  [scottjallen.net/sjablog/assertion-evidence](https://www.scottjallen.net/sjablog/assertion-evidence)
- Google developer documentation style guide, procédures et tableaux :
  [procedures](https://developers.google.com/style/procedures) et
  [tables](https://developers.google.com/style/tables)
