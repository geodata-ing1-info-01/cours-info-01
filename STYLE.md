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
  `sommaire-td`) qui marque le passage de l'exposé au travail sur machine,
  le gris des encadrés, puis deux couleurs de
  signalement — `attention`, un bleu clair, sur un point à ne pas manquer, et
  `alerte`, un orange, sur une erreur fréquente et ses conséquences. Ces deux
  dernières répondent aux encadrés `note` et `warning` des pages de cours, et
  ne servent jamais à mettre un mot en valeur : le gras s'en charge, et
  seulement sur un terme défini. `alerte` ne s'emploie pas dans un TD,
  où le brun est déjà présent.

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

## TD et corrigé

Ce qu'un TD fait constater ne se projette pas pendant qu'il se fait. La
colonne d'observation d'un tableau de TD s'écrit dans `reponse[…]` : elle devient un filet à compléter à la projection, et n'apparaît
que dans la compilation `--input corrige=true`, distribuée après la séance.

Deux résultats motivent ce choix, et fixent aussi sa limite.

- **Effet de pré-test.** Tenter de répondre avant de connaître la réponse
  améliore la rétention de celle-ci, y compris quand la tentative échoue,
  pourvu que la réponse soit donnée ensuite. La correction n'est donc pas
  facultative : c'est elle qui rend la tentative profitable.
- **Notes guidées.** Un support à trous produit de meilleurs résultats qu'un
  support complet, à condition qu'il reste un squelette : l'erreur documentée
  est de laisser si peu à compléter que le support redevient complet.

En pratique : ce que l'étudiant produit ou observe est masqué ; la consigne, le
vocabulaire et les définitions ne le sont jamais. Une diapositive de réponses
séparée, comme « Reconnaître un format à son extension — réponses », reste
préférable quand la question se pose à la salle plutôt que sur machine.

Sources : Richland, Kornell & Kao, *Do unsuccessful retrieval attempts enhance
learning?* (JEP:Applied, 2009) —
[texte](https://learninglab.uchicago.edu/Pre-Testing_files/RichlandKornellKao.pdf) ;
Kornell, Hays & Bjork, *Unsuccessful retrieval attempts enhance subsequent
learning* (JEP:LMC, 2009) —
[texte](https://bjorklab.psych.ucla.edu/wp-content/uploads/sites/13/2016/07/Hays_Kornell_RBjork_inpress.pdf) ;
synthèse sur les notes guidées, Ohio State University —
[ada.osu.edu/guided-notes](https://ada.osu.edu/guided-notes).

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

Les relectures de septembre 2026 (cours 2, 3 et 5) ont corrigé les mêmes
tournures, y compris dans des diapositives réécrites après une première
correction. Elles s'ajoutent à la table précédente.

| Tournure | Écrit | Corrigé |
|----------|-------|---------|
| Contraste « X, pas Y », « plutôt que », « et non » | « La ligne du disque est un calcul, pas une mesure » | « La ligne du disque est un calcul » |
| Formule « c'est » | « C'est la diapositive à retenir de la partie » | « Diapositive à retenir » (notes) |
| Chute après deux-points | « La carte mère ne calcule pas : elle relie » | « La carte mère relie les composants par des pistes de cuivre » |
| Image, personnification | « le dépôt vit dans… », « tiré par l'IA », « se suit seul » | « le dépôt reste dans… », « surtout par l'IA », « autonome » |
| Annonce sans verbe | « Dans l'Anaconda Prompt. » | « Les commandes se tapent dans l'Anaconda Prompt. » |
| Annonce qui reformule le titre | « Chaque étape corrige une limite de la précédente » sous un tableau dont une colonne s'intitule « Limite corrigée » | pas d'annonce |
| Verbe vague ou elliptique | « un `import` suffit » | « s'importent sans installation » |

Une restructuration réécrit des phrases : le texte nouveau repasse par ces
deux tables, et un texte déjà relu se déplace sans être reformulé.
`python outils/verifier_style.py` relève les tournures repérables
automatiquement dans les lignes ajoutées depuis le dernier commit.

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
- [ ] Aucune diapositive ne contient de liste à puces.
- [ ] Aucun paragraphe d'une seule phrase courte destiné à faire effet.
- [ ] Le gras ne marque que des termes définis.
- [ ] Aucun encadré ne répète le paragraphe voisin.
- [ ] Les commandes montrées ont été exécutées.
- [ ] Ce que le TD fait constater est dans `reponse[…]`.
- [ ] Un TD nouveau est un fichier de `tds/` nommé comme son dossier, avec son dictionnaire `td` en tête, importé et inclus par `cours<n>.typ`.
- [ ] Les chemins cités dans un TD sont ceux de l'archive livrée : `cours1/2a_vscode_python/`, sans `data/` ni `produit/`.
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
