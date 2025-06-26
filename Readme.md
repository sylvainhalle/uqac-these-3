Gabarit de mémoire, thèse et essai du DIM
=========================================

par Sylvain Hallé et Florentin Thullier

Comment utiliser ce gabarit
---------------------------

Cet ensemble de fichiers permet de produire un document de type mémoire,
essai ou thèse suivant les normes de présentation en vigueur au Département
d'informatique et de mathématiques de l'Université du Québec à Chicoutimi.

En quelques étapes rapides:

1. Décompressez le contenu de l'archive dans un répertoire de votre
   choix
2. Ouvrez le fichier `these.tex`, trouvez-y les champs `\UqacTheseTitre`,
   etc. et remplacez-les par les valeurs appropriées
3. Modifiez au besoin le préambule (la ligne débutant par `\documentclass`)
   pour remplacer *these* par *memoire*, *essai*, etc. selon le type de
   document à produire (modifie le contenu de la page titre auto-générée).
   Faites-en de même pour la langue de rédaction (*francais* ou *english*).
4. Localisez la section "Document principal" et ajoutez autant de commandes
   include qu'il y a de fichiers à inclure dans votre document
5. Modifiez au besoin la ligne `\bibliography` pour y inclure les fichiers
   `.bib` appropriés (ou alors mettez simplement vos références dans
   `these.bib)`.

Pour tout le reste, la classe utilise exactement les mêmes commandes et les
mêmes environnements que la classe "book" qui vient par défaut avec LaTeX.
Au besoin, lisez la documentation sur "book" pour comprendre comment
utiliser uqac-these-dim.

Prérequis
---------

Pour travailler en local, il faut minimalement:

- Une distribution LaTeX comme [MiKTeX](https://miktex.org/) ou
  [TeX Live](https://tug.org/texlive/)
- Un (bon) éditeur texte, comme [jEdit](https://jedit.org),
  [Sublime Text](https://www.sublimetext.com/),
  [VS Code](https://code.visualstudio.com/) ou pourquoi pas
  [Vim](https://www.vim.org/)

Il est également possible de créer un nouveau projet sur
[Overleaf](https://overleaf.com). Il suffit de chercher le modèle appelé
"Gabarit mémoire et thèse UQAC DIM v3".

Documentation LaTeX
-------------------

La meilleure référence pour apprendre LaTeX s'appelle
[Une courte introduction à LaTex](https://ctan.org/tex-archive/info/lshort/french).

Sinon, le contenu du gabarit fournit en version condensée tous les exemples
dont vous pourriez avoir besoin pour la rédaction d'un texte en
informatique:

- **Chapitre I**:
  - listes
  - citations
  - liens et références
  - notes de bas de page
  - acronymes
  - figures
  - tableaux
- **Chapitre II**:
  - équations
  - théorèmes et preuves
  - code source

Compilation
-----------

Si vous travaillez en local, vous pouvez évidemment compiler le document en
appelant à la ligne de commande:

    pdflatex these

Cependant, il existe deux autres outils plus appropriés.

### Avec `latexmk`

La manière privilégiée de compiler la thèse est au moyen de l'outil
[`latexmk`](https://mg.readthedocs.io/latexmk.html), qui s'occupe des
multiples passes de compilation, les appels à BibTeX, etc. L'outil est
normalement installé par défaut avec la plupart des distributions LaTeX.

À la ligne de commande, dans le dossier racine du projet, il suffit de
lancer:

    latexmk

Pour nettoyer le dossier de tous les fichiers temporaires, on lance:

    latexmk -c

Finalement, la commande la plus intéressante est:

    latexmk -pvc

qui lance une visionneuse PDF affichant votre document et fait en sorte que
chaque fois que vous modifiez quelque chose dans l'un de vos fichiers
sources et enregistrez vos modifications, l'aperçu est automatiquement mis à
jour (ne fonctionne pas avec Adobe Viewer, cependant).

### Avec `make`

Le projet vient également avec un fichier `Makefile` permettant de compiler
la thèse avec l'outil `make`. Il contient également certaines
fonctionnalités qui ne sont pas supportées par latexmk (comme la
vérification de l'orthographe ou la génération des méta-données PDF, voir
ci-dessous).

La compilation courante s'effectue simplement avec:

    make

Le processus s'arrête avec un code d'erreur non nul si la compilation n'a pu
s'effectuer jusqu'au bout (par exemple, si `pdflatex` a produit un message
d'erreur).

Correction orthographique
-------------------------

Vous êtes bien entendu très fortement encouragés à appliquer un outil de
vérification orthographique et grammaticale à votre texte.

### TeXtidote

On vous recommande entre autres l'utilisation de
[TeXtidote](https://github.com/sylvainhalle/textidote) pour la vérification
de l'orthographe et de la grammaire. L'avantage de cet outil est qu'il
"comprend" les commandes LaTeX et ne les prend pas pour des fautes
d'orthographe. De plus, il peut rapporter les erreurs trouvées aux bons
emplacements directement dans le code source.

Si TeXtidote est installé, la commande `make` vous permet de l'appeler sur
vos fichiers source, comme ceci:

    make file=chapitreX.tex textidote

Autrement, consultez la documentation de TeXtidote pour comprendre comment
l'utiliser.

### Aspell

Une alternative à TeXtidote est le correcteur orthographique
[Aspell](http://aspell.net), qui ne vérifie par contre que l'orthographe. On
l'appelle ainsi:

    make file=chapitreX.tex aspell

La beauté d'Aspell est que, comme TeXtidote, il "comprend" les commandes
LaTeX et ne les prend pas pour des fautes d'orthographe. Mieux, si vous
ajoutez des acronymes et des mots techniques (comme "Bitcoin", "HTML" ou
"endomorphisme"), Aspell s'en souviendra et ne vous arrêtera pas dessus la
prochaine fois que vous repasserez sur vos fichiers.

Mode brouillon
--------------

Par défaut, la thèse est compilée avec l'option `brouillon` dans la
déclaration `\documentclass`. Cette option applique une vérification moins
stricte de la mise en forme, et fournit également une commande `\todo`
permettant d'insérer des marqueurs colorés dans le texte indiquant que
quelque chose reste à faire. Elle affiche en contrepartie un rectangle rouge
indiquant "brouillon" sur la page titre du document.

On retire l'option brouillon pour faire passer la thèse en mode "final".
Dans ce mode, le comportement de certaines commandes est modifié:

- S'il reste des `\todo` dans le texte, ils vont provoquer une erreur et
  arrêter la compilation. Ceci évite de laisser ces marqueurs par mégarde
  dans un document que l'on pense final.
- S'il reste des références non définies, elles vont elles aussi provoquer
  un échec de la compilation. De même, si des figures ou des tableaux ne
  sont jamais référencés dans le texte, une erreur sera également lancée.

L'objectif de ces erreurs "intentionnelles" est d'éviter que ces problèmes
ne se rendent trop loin dans le processus d'évaluation et provoquent des
retards. On peut même combiner le mode final à un paramètre de `latexmk`
(discuté plus haut):

    latexmk -Werror

qui fera en sorte que tout avertissement ("warning") sera interprété comme
une erreur qui arrêtera la compilation --visant encore ici à régler ces
avertissements.

Production du PDF final
-----------------------

L'UQAC demande à ce que le PDF final soit au format
[PDF/A](https://en.wikipedia.org/wiki/PDF/A), selon le *Guide de création
des fichiers pour le dépôt final*.

### Si vous travaillez en local

La compilation produit des documents PDF/A par défaut, il n'y a donc rien de
spécial à faire pour cette étape.

### Si vous utilisez Overleaf

Il faut savoir que la plateforme exécute `pdflatex` et les outils connexes
dans un environnement *sandbox* avec un accès système restreint. Ceci a pour
conséquence un support limité, voire inexistant, pour certaines
étapes essentielles à la génération de documents PDF/A valides. Lorsque
désactivées (et ce même si les instructions sont bien présentes dans la
source), la sortie reste au format PDF standard (par exemple, version 1.7)
sans conformité d'archivage. (Certaines instructions, comme
[celles-ci](https://www.overleaf.com/latex/templates/creating-pdf-slash-a-and-pdf-slash-x-files-with-the-pdfx-package/bbbycnbyqhnm),
ne fonctionnent malheureusement pas et produisent un PDF dont la version
annoncée est PDF-1.7).

Vous avez le choix de:

1. Cloner le projet localement et le compiler (méthode préférable). On
   peut vérifier la conformité du gabarit compilé selon cette méthode
   avec un l'outil gratuit de vérification [VeraPDF](https://verapdf.org).
2. Cloner le projet localement et utiliser la commande `make pdfa`, qui
   produira un fichier appelé `these-pdfa3b.pdf` (méthode moins
   préférable, produit de plus gros fichiers). Cette commande nécessite
   que [Ghostscript](https://www.ghostscript.com) soit installé sur votre
   ordinateur. On peut aussi vérifier la conformité de cette méthode avec le
   même outil.)
3. Utiliser un outil de conversion en ligne, comme celui de
   [pdfforge.org](https://www.pdfforge.org/online/en/pdf-to-pdfa). (Soyez
   cependant conscient que ce faisant, vous remettez un document à un
   service tiers. Vérifiez bien les termes d'utilisation.)

Quelques bonnes pratiques
-------------------------

### Utilisation de l'option `brouillon`

Il est recommandé de rédiger le document en mode brouillon, mais de le
compiler passer en mode final avant toute étape officielle du processus (par
exemple, avant le dépôt initial).

### Inclusion de code source

Utilisez l'environnement `verbatim` pour du code quelconque, et
`lstlisting` pour du code source (ce dernier fait de la coloration
syntaxique).

N'incluez pas vos fragments de code directement dans votre chapitre.
Placez-les plutôt dans des fichiers séparés que vous incluez avec une
instruction `\input`. Donc, ne faites pas ceci:

```latex
On peut le voir avec le code suivant:

\begin{lstlisting}
plein de code bizarre
\end{lstlisting}
```

mais plutôt:

```latex
On peut le voir avec le code suivant:

\input{mon.code.inc.tex}
```

Il y a deux raisons principales:

- Comme le code que vous incluez n'est probablement pas du LaTeX, la
  coloration syntaxique risque d'être perturbée par votre code (parfois
  pour le reste du fichier: imaginez si votre code contient un seul `$`)
- Si vous passez un correcteur orthographique (comme Aspell) sur votre
  source, il ne lira pas le code (et vous épargnera une floppée
  d'avertissements stupides).
  
### Emplacement des figures

Placez vos figures dans le dossier `fig`. Vous n'avez pas besoin de (et ne
devriez pas) écrire `fig/` lorsque vous utilisez `\includegraphics` pour
inclure une figure.

### Warnings et erreurs

N'ignorez pas les *warnings*, et encore moins les erreurs. Même si la
compilation peut se rendre jusqu'au bout en appuyant sur Enter pour passer
par-dessus ces messages, la manoeuvre a des chances de ne pas fonctionner
sur tous les ordinateurs. Presque toujours, la présence d'un message
d'erreur indique un vrai problème avec vos sources --alors réglez-le!

À propos de ce gabarit
----------------------

Il a existé dans le passé deux autres gabarits LaTeX pour les mémoires et
les thèses utilisés au DIM. Le premier fut développé par Sylvain Hallé
(2012) et le second par Florentin Thullier (2018). Les deux gabarits avaient
des points en commun, mais également des options implémentées et gérées de
manière différente. Le présent modèle est une fusion, une refonte et une
simplification reprenant les meilleurs éléments des deux anciens modèles,
tout en ajoutant de nouvelles fonctionnalités. C'est pourquoi il porte la
version 3.

2025-06-25

<!-- wrap=hard:maxLineLen=76: -->