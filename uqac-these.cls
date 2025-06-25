%% --------------------------------------------------------------------------
%% Classe essai/mémoire/thèse DIM UQAC
%%
%% uqac-these.cls
%% Copyright 2012-2025 Sylvain Hallé, Florentin Thullier
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2008 or later.
%% 
%% This work has the LPPL maintenance status `maintained'.
%% 
%% The Current Maintainer of this work is Sylvain Hallé.
%%
%% This work consists of the file uqac-these.cls.
%%
%% Version: 2.0, last modified 2024-11-04
%% --------------------------------------------------------------------------

%% ------------------------
%% Déclarations
%% ------------------------
\NeedsTeXFormat{LaTeX2e}

%% ------------------------
%% Version et date du package
%% ------------------------
\def\uqacVersion{3.0}
\def\uqacDate{2025/06/25}
\ProvidesClass{uqac-these}[\uqacDate These DIM UQAC, V\uqacVersion par Sylvain Hallé \& Florentin Thullier]

%% ------------------------
%% Commande permettant de définir la discipline du mémoire ou de la thèse.
%% Utilisée pour générer la page titre.
%% ------------------------
\makeatletter
\newcommand{\discipline}[1]{%
\def\uqacProgramme{#1}
}

\def\uqacConcentration{}
\newcommand{\concentration}[1]{%
\def\uqacConcentration{#1}
}
\makeatother

%% ------------------------
%% Choix du type de document
%% ------------------------
%% Thèse
\DeclareOption{these}{%
  \def\uqacType{THESE}
}

%% Projet de thèse
\DeclareOption{projthese}{%
  \def\uqacType{PROJETTHESE}
}

%% Sujet de thèse
\DeclareOption{sujthese}{%
  \def\uqacType{SUJETTHESE}
}

%% Mémoire
\def\uqacmemoire{false}
\DeclareOption{memoire}{%
  \def\uqacType{MEMOIRE}
}

%% Essai
\def\uqacessai{false}
\DeclareOption{essai}{%
  \def\uqacType{ESSAI}
}

%% Rapport
\def\uqacrapport{false}
\DeclareOption{rapport}{%
  \def\uqacType{RAPPORT}
}

%% ------------------------
%% Choix de la langue du document
%% ------------------------
\makeatletter
%% Français
\def\uqacFrancais{false}
\DeclareOption{francais}{%
  \def\uqacFrancais{true}
}

%% Anglais
\def\uqacAnglais{false}
\DeclareOption{anglais}{%
  \def\uqacAnglais{true}
}
\makeatother

%% ------------------------
%% Option brouillon
%% ------------------------
\makeatletter
\def\uqacModeBrouillon{false} %% Pas brouillon par défaut
\DeclareOption{brouillon}{%
  \def\uqacModeBrouillon{true}
}
\makeatother

%% ------------------------
%% Passage des autres options à la classe book
%% ------------------------
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{book}%
}
\ProcessOptions

%% ------------------------
%% Chargement de la classe de base (book)
%% ------------------------
\ifx\pdfoutput\undefined
\LoadClass[12pt,letterpaper,openright,dvips]{book}
\else
\LoadClass[12pt,letterpaper,openright,pdftex]{book}
\fi

%% ------------------------
%% On ne met ici que les packages dont l'absence empêche la compilation
%% du template vide. Incluez vos autres packages (optionnels) dans la thèse.
%% ------------------------
\RequirePackage[T1]{fontenc}
%% Gestion des marges
\RequirePackage{geometry}
%% Inclusion d'images
\RequirePackage{graphicx}
%% En-tête et pied de page
\let\footruleskip\undefined\RequirePackage{fancyhdr}
%% Formatage des titres et sous-titres
\RequirePackage[explicit]{titlesec}
%% Formatage des légendes de tableaux et figures
\RequirePackage{caption}
%% Mise en majuscules de la page titre et des en-tête de chapitres
\RequirePackage{textcase}
%% Interligne simple dans les listes (table des matières, etc.), double ailleurs
\RequirePackage{setspace}
%% Paramètres de la table des matières
\RequirePackage{tocloft}
%% Mise en majuscules plus sécuritaire
\RequirePackage{textcase}
%% On ne pagine pas pages vides
\RequirePackage{emptypage}
%% Requis par le style bibliographique IEEEtran
%\RequirePackage{unicode-math}
%% Gestion de la bibliographie, doit être chargé avant babel
\RequirePackage[numbers]{natbib}
%% Pour le rectangle "brouillon" sur la page titre
\RequirePackage[x11names]{xcolor}
%% Pour faire des rectangles avec la commande "todo"
\RequirePackage{mdframed}
%% Pour évaluer des conditions plus facilement qu'en TeX brut
\RequirePackage{ifthen}

%% ------------------------
%% Chargement conditionnel de babel selon la langue
%% Pour une raison étrange, Babel français hard-code l'usage de petites
%% majuscules pour le mot "Figure"; on doit donc le redéfinir
%% ------------------------
\makeatletter
\ifthenelse{\equal{\uqacFrancais}{true}}{
  \RequirePackage[french]{babel}
}{\ifthenelse{\equal{\uqacAnglais}{true}}{
  \RequirePackage[english]{babel}
}{}}
\makeatother

%% ------------------------
%% Ces packages doivent être chargés après babel
%% ------------------------
%% Meilleure typographie
\RequirePackage[babel]{microtype}
%% Pour définir les légendes des figures
\RequirePackage{caption}
%% Liste des acronymes
\RequirePackage{acro}
%% Gestion des méta-données PDF et affichage des URLs
\RequirePackage[pdfa]{hyperref}
\usepackage{hyperxmp}[2020/03/01]
\usepackage{embedfile}[2020/04/01]

%% ------------------------
%% Définition des polices par défaut
%% ------------------------
%% Use Times font with math support
\RequirePackage{newtxtext,newtxmath}
%% Redefine default sans-serif font as Helvetica
\RequirePackage[scaled]{helvet}
\renewcommand{\sfdefault}{phv}
%% Use Bera Mono as the monospace font
\usepackage{beramono}
\renewcommand{\ttfamily}{%
  \fontfamily{fvm}%
  \fontsize{10pt}{12pt}% Adjust these values as needed
  \selectfont}

%% ------------------------
%% Définition de la commande \todo. Deux versions existent: la version finale
%% déclenche une erreur de compilation, alors que la version brouillon affiche
%% une boîte colorée avec du texte.
%% ------------------------
\newcommand{\todoFinal}[1]{%
  \ClassError{uqac-these-dim}{Il reste des todo dans le document: #1}{Le document n'est pas en mode brouillon et il reste des occurrences de la commande todo. Assurez-vous que tous les todos sont réglés pour compiler le document en mode final.}%
}
\newcommand{\todoBrouillon}[1]{%
  \fcolorbox{red}{red!20}{\parbox{\dimexpr\textwidth-2\fboxsep-2\fboxrule\relax}{%
    \textbf{TODO:} #1%
  }}%
}

%% ------------------------
%% Si l'option brouillon n'est pas active, le comportement de certaines
%% commandes change
%% ------------------------
\ifthenelse{\equal{\uqacModeBrouillon}{false}}{%
  %% Les todo provoquent des erreurs de compilation
  \let\todo=\todoFinal
  %% Les références non-définies provoquent des erreurs de compilation
  \RequirePackage{nag}
  %% Tout ce qui dépasse de la marge provoque une erreur de compilation
  \RequirePackage{silence}
  \WarningFilter{latex}{Overfull \hbox}
}{
  %% Les todo sont visibles
  \let\todo=\todoBrouillon
}

%% ------------------------
%% Uniformisation du texte de certaines légendes
%% ------------------------
\makeatletter
\newcommand{\fixfrenchcaptions}{%
  \AddToHook{begindocument/end}{%
    \def\FB@sc##1{##1}%
    \renewcommand{\figurename}{Figure}%
    \renewcommand{\tablename}{Tableau}%
    \renewcommand{\lstlistlistingname}{Liste des sources}
    \renewcommand{\listfigurename}{Liste des figures}
  }%
}
\newcommand{\fixenglishcaptions}{%
  \AddToHook{begindocument/end}{%
    \def\FB@sc##1{##1}%
    \renewcommand{\lstlistlistingname}{List of Sources}
  }%
}
\makeatother

%% ------------------------
%% Paramètres spécifiques à la langue du document
%% ------------------------
\ifthenelse{\equal{\uqacFrancais}{true}}{%
%% Français
  %% Pas d'alinéas et une ligne vide
  \setlength{\parindent}{0pt}
  \setlength{\parskip}{10pt}
  %% Biblio en français
  \fixfrenchcaptions
  \bibliographystyle{IEEEtranSN_francais}
}{%
%% Anglais
  %% Biblio en anglais
  \fixenglishcaptions
  \bibliographystyle{IEEEtranSN}
}

%% ------------------------
%% Interlignes
%% ------------------------
\newlength{\doubleinter}
\setlength{\doubleinter}{1\baselineskip}

%% ------------------------
%% Marges de la page et interligne
%% ------------------------
\geometry{hmargin={3.5cm,2.5cm},vmargin={3.4cm,3cm}}

%% ------------------------
%% Style de la page
%% ------------------------
\fancyhead[LO,RE]{}
\fancyhead[RO,LE]{\thepage}
\renewcommand{\footrulewidth}{0pt}
\renewcommand{\headrulewidth}{0pt}
\fancyfoot{}
\pagestyle{fancy}
%% On redéfinit le style plain pour ne pas avoir de numéros de page
%% à la première page des chapitres
\fancypagestyle{plain}{%
\fancyhf{} % clear all header and footer fields
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}}
\setlength{\headheight}{14.5pt}

%% ------------------------
%% Numérotation
%% ------------------------
% Redefine chapter number format to Roman numerals for chapter titles
\renewcommand{\thechapter}{\Roman{chapter}}

% Redefine figure and table numbering to use Arabic numerals for chapter numbers
\renewcommand{\thefigure}{\arabic{chapter}.\arabic{figure}}
\renewcommand{\thetable}{\arabic{chapter}.\arabic{table}}
\renewcommand{\theequation}{\arabic{chapter}.\arabic{equation}}

%% ------------------------
%% Style des titres et sous-titres
%% ------------------------

% Style for numbered chapters
\titleformat{\chapter}[block]%
  {\centering\sffamily\bfseries\selectfont}%
  {\MakeTextUppercase{Chapitre \thechapter}}%
  {0cm}%
  {\vskip 0pt\MakeTextUppercase{#1}}%

% Style for unnumbered chapters (e.g., LoF, Bibliography)
\titleformat{name=\chapter,numberless}[block]%
  {\normalfont\centering\sffamily\bfseries\selectfont}%
  {}%
  {0cm}%
  {\vskip 0pt\MakeTextUppercase{#1}}%

\renewcommand{\thesubsection}{\arabic{chapter}.\arabic{section}.\arabic{subsection}}
\titleformat{\subsection}%
[hang]%
{\itshape\selectfont}%
{\MakeTextUppercase{\thesubsection}}% Titre du chapitre
{0.5cm}% Séparation d'avec le corps du chapitre
{\MakeTextUppercase{#1}}% Code à exécuter avant le titre
{}% Code à exécuter après le titre

%% Les chapitres sans numéro apparaissent dans la table des matières aussi
\newcommand{\chapterwithtoc}[1]{%
  \chapter*{#1}%
  \addcontentsline{toc}{chapter}{#1}%
  \markboth{#1}{#1}%
}

%% ------------------------
%% Légende des figures
%% ------------------------
%% Pour une raison étrange, Babel hard-code l'usage de petites majuscules
%% pour le mot "Figure"; on doit donc le redéfinir
%% (cf. http://tex.stackexchange.com/questions/73639/caption-formatting-with-babel-french)
\captionsetup[figure]{name=Figure}
\captionsetup[table]{name=Tableau}
\renewcommand{\captionfont}{\normalfont\small\bfseries}

%% ------------------------
%% Redéfinition des termes en français et en anglais
%% ------------------------
\ifthenelse{\equal{\uqacFrancais}{true}}{%
	\addto\captionsfrench{%
	   \renewcommand\contentsname{Table des mati\`eres}}
	\addto\captionsfrench{%
	   \renewcommand\listfigurename{Liste des figures}}
	\addto\captionsfrench{%
	   \renewcommand\listtablename{Liste des tableaux}}
	\addto\captionsfrench{%
	   \renewcommand\bibname{Bibliographie}}
	\addto\captionsfrench{%
	   \renewcommand\indexname{Index}}
	\addto\captionsfrench{%
	   \renewcommand\figurename{Figure}}
	\addto\captionsfrench{%
	   \renewcommand\tablename{Tableau}}
	\addto\captionsfrench{%
	   \renewcommand\partname{Partie}}
	\addto\captionsfrench{%
	   \renewcommand\chaptername{Chapitre}}
	\addto\captionsfrench{%
	   \renewcommand\appendixname{Appendice}}
	\addto\captionsfrench{%
	   \renewcommand\abstractname{R\'esum\'e}}
	\addto\captionsfrench{%
	   \renewcommand\acrolistname{Liste des abr\'eviations}}
}{%
	\addto\captionsenglish{%
	   \renewcommand\contentsname{Table of Contents}}
   \addto\captionsenglish{%
	   \renewcommand\bibname{References}}
}

%% ------------------------
%% Bouts de texte apparaissant sur la page couverture, en fonction des
%% options passées au document
%% ------------------------
\ifthenelse{\equal{\uqacFrancais}{true}}{%
  \def\uqacauteurpar{par}}{
  \def\uqacauteurpar{by}
}
\ifthenelse{\equal{\uqacType}{THESE}}{%
	\ifthenelse{\equal{\uqacFrancais}{true}}{%
  		\gdef\thesetype{\textbf{\MakeUppercase{th\`ese}}}
   		\gdef\thesegrade{\textbf{\MakeUppercase{philosophi\ae{} doctor (Ph.D.) en \expandafter\expandafter{\uqacProgramme}}}}
   		\gdef\accord{e}
	}{
		\gdef\thesetype{\textbf{\MakeUppercase{thesis}}}
   		\gdef\thesegrade{\textbf{\MakeUppercase{philosophi\ae{} doctor (Ph.D.) in the subject of \expandafter\expandafter{\uqacProgramme}}}}
   		\gdef\accord{e}
	}
}{%
	\ifthenelse{\equal{\uqacType}{PROJETTHESE}}{%
		\ifthenelse{\equal{\uqacFrancais}{true}}{%
	  		\gdef\thesetype{\textbf{\MakeUppercase{projet de th\`ese}}}
	   		\gdef\thesegrade{\textbf{\MakeUppercase{philosophi\ae{} doctor (Ph.D.) en \expandafter\expandafter{\uqacProgramme}}}}
	   		\gdef\accord{}
   		}{
   			\gdef\thesetype{\textbf{\MakeUppercase{thesis project}}}
	   		\gdef\thesegrade{\textbf{\MakeUppercase{philosophi\ae{} doctor (Ph.D.) in the subject of \expandafter\expandafter{\uqacProgramme}}}}
	   		\gdef\accord{}
   		}
	}{
    \ifthenelse{\equal{\uqacType}{SUJETTHESE}}{%
      \ifthenelse{\equal{\uqacFrancais}{true}}{%
          \gdef\thesetype{\textbf{\MakeUppercase{sujet de thèse}}}
          \gdef\thesegrade{\textbf{\MakeUppercase{philosophi\ae{} doctor (Ph.D.) en \expandafter\expandafter{\uqacProgramme}}}}
          \gdef\accord{}
        }{
          \gdef\thesetype{\textbf{\MakeUppercase{thesis subject}}}
          \gdef\thesegrade{\textbf{\MakeUppercase{philosophi\ae{} doctor (Ph.D.) in the subject of \expandafter\expandafter{\uqacProgramme}}}}
          \gdef\accord{}
        }
    }{
      \ifthenelse{\equal{\uqacType}{MEMOIRE}}{%
        \ifthenelse{\equal{\uqacFrancais}{true}}{%
            \gdef\thesetype{\textbf{\MakeUppercase{mémoire}}}
            \gdef\thesegrade{\textbf{\MakeUppercase{maître ès sciences en \expandafter\expandafter{\uqacProgramme}}}}
          \gdef\accord{}
        }{
          \gdef\thesetype{\textbf{\MakeUppercase{Master's thesis}}}
            \gdef\thesegrade{\textbf{\MakeUppercase{Master of Science in the subject of \expandafter\expandafter{\uqacProgramme}}}}
          \gdef\accord{}
        }
      }{
        \ifthenelse{\equal{\uqacType}{ESSAI}}{%
          \ifthenelse{\equal{\uqacFrancais}{true}}{%
              \gdef\thesetype{\textbf{\MakeUppercase{essai}}}
              \gdef\thesegrade{\textbf{\MakeUppercase{ma\^itre \`es sciences en \expandafter\expandafter{\uqacProgramme}}}}
            \gdef\accord{}
          }{
            \gdef\thesetype{\textbf{\MakeUppercase{research essay}}}
              \gdef\thesegrade{\textbf{\MakeUppercase{Master of Science in the subject of \expandafter\expandafter{\uqacProgramme}}}}
            \gdef\accord{}
          }
        }{
          \ifthenelse{\equal{\uqacType}{RAPPORT}}{%
            \ifthenelse{\equal{\uqacFrancais}{true}}{%
                \gdef\thesetype{\textbf{\MakeUppercase{rapport de recherche}}}
                \gdef\thesegrade{\textbf{\MakeUppercase{maître ès sciences en \expandafter\expandafter{\uqacProgramme}}}}
              \gdef\accord{}
            }{
              \gdef\thesetype{\textbf{\MakeUppercase{research report}}}
                \gdef\thesegrade{\textbf{\MakeUppercase{Master of Science in the subject of \expandafter\expandafter{\uqacProgramme}}}}
              \gdef\accord{}
            }
          }
        }
      }
    }
  }
}

%% ------------------------
%% Notes de bas de page
%% ------------------------
\makeatletter
\setlength{\footnotesep}{\doubleinter}
\renewcommand{\@makefntext}[1]%
  {\setlength{\parindent}{2em}%
   \makebox[1.8em][r]{\@makefnmark}#1}
\renewcommand{\footnoterule}{
 \noindent
 \rule{4cm}{0.4pt}
}
\makeatother
\counterwithout*{footnote}{chapter}

%% ------------------------
%% Rendu de la page couverture
%% ------------------------
\makeatletter
\renewcommand{\maketitle}{%
\begin{titlepage}
\begin{center}
\begin{spacing}{2}
\includegraphics[width=1.5in]{uqac-logo}

\vfill

\textbf{\MakeTextUppercase{\@title}}

\vfill

\textbf{\MakeUppercase{\expandafter{\uqacauteurpar} \expandafter{\@author}}}

\vfill

\thesetype{}
\ifthenelse{\equal{\uqacFrancais}{true}}{%
	\textbf{\MakeUppercase{présenté\accord{} à l'Université du Québec à Chicoutimi comme exigence partielle en vue de l'obtention du grade de}}
}{
	\textbf{\MakeUppercase{presented to Université du Québec à Chicoutimi in partial fulfillment of the requierments for the degree of}}
}
\thesegrade{}
\ifx\uqacConcentration\empty
\else
\textbf{\MakeUppercase{\uqacConcentration}}
\fi
\vfill

\textbf{\MakeUppercase{Qu\'ebec, Canada}}
\vfill

\textbf{\MakeUppercase{\textcopyright{} \@author, \@date}}
\vfill
\end{spacing}
%% Rectangle rouge indiquant le mode brouillon le cas échéant
\ifthenelse{\equal{\uqacModeBrouillon}{true}}{%
 \noindent\colorbox{red!20}{%
        \parbox{0.9\textwidth}{%
            \centering
            \textcolor{red}{\bfseries \Large BROUILLON}
        }%
    }
}{}
\end{center}
\end{titlepage}
}
\makeatother

%% Gestion des lignes orphelines
\widowpenalty10000
\clubpenalty10000

%% Cette ligne évite une panoplie de warnings de pdflatex si on inclut
%% des figures PDF de version 1.6 ou supérieure
\pdfminorversion=7

%% On ignore les warnings de pdflatex sur les "PDF page groups"
%% (n'a aucun effet dans notre cas)
\pdfsuppresswarningpagegroup=1

%% ------------------------
%% Les redéfinitions suivantes nécessitent le package etoolbox
%% ------------------------
\RequirePackage{etoolbox}

%% ------------------------
%% Style de la table des matières
%% ------------------------
\makeatletter
\patchcmd{\l@chapter}
  {\bfseries}
  {\normalfont\uppercase}
  {}{}
\makeatother
\renewcommand{\cfttoctitlefont}{\hfill\normalfont\bfseries\MakeUppercase}
\renewcommand{\cftaftertoctitle}{\hfill}
\renewcommand{\cftloftitlefont}{\hfill\normalfont\bfseries\MakeUppercase}
\renewcommand{\cftafterloftitle}{\hfill}
\renewcommand{\cftlottitlefont}{\hfill\normalfont\bfseries\MakeUppercase}
\renewcommand{\cftafterlottitle}{\hfill}
\usepackage{tocloft}

% Add dot leaders to all levels
\renewcommand{\cftpartleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftsubsecleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftsubsubsecleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftparaleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftsubparaleader}{\cftdotfill{\cftdotsep}}

% Limit the depth of the TOC to chapters and sections only
\setcounter{tocdepth}{1}

%% ------------------------
%% Ajustement des espacements verticaux
%% ------------------------

%% Espacements avant et après les équations
\BeforeBeginEnvironment{equation}{\vspace{-0.5cm}}
\AfterEndEnvironment{equation}{\vspace{-0.5cm}}

%% Espacements avant et après les figures
\BeforeBeginEnvironment{figure}{\vspace{1cm}}
\AfterEndEnvironment{figure}{\vspace{-0.5cm}}
\BeforeBeginEnvironment{figure*}{\vspace{1cm}}
\AfterEndEnvironment{figure*}{\vspace{-0.5cm}}

%% Espacements avant et après les tableaux
\BeforeBeginEnvironment{table}{\vspace{0.5cm}}
\AfterEndEnvironment{table}{\vspace{-0.5cm}}

%% Espacements avant et après les algorithmes
\BeforeBeginEnvironment{algorithm}{\vspace{1cm}}
\AfterEndEnvironment{algorithm}{\vspace{1cm}}

%% ------------------------
%% Formatage des légendes pour les figures et les tableaux
%% ------------------------
\captionsetup[figure]{%
  position=bottom,
  labelfont={bf, small, stretch=1.17},
  labelsep=colon,
  textfont={bf, small, stretch=1.17},
  justification=centering
}
\captionsetup[subfloat]{%
  labelfont={small, stretch=1.17},
  textfont={small, stretch=1.17},
  justification=centering
}

\captionsetup[table]{%
  position=top,
  margin=0.5cm,
  labelfont={bf, small, stretch=1.17},
  labelsep=colon, textfont={bf, small, stretch=1.17},
  aboveskip=6pt, belowskip=12pt,
  justification=centering
}
\DeclareCaptionLabelSeparator{colon}{ : }

%% ------------------------
%% Style des titres de listes de figures, tableaux, etc. afin qu'ils soient
%% semblables à ceux des chapitres. Étonnamment, il est très difficile de
%% modifier ce formatage, car les déclarations sont hard-codées à un très
%% bas niveau.
%% ------------------------
\makeatletter

%% Table des matières
\newcommand{\SansTableOfContents}{%
  \cleardoublepage
  \thispagestyle{plain}%
  \vspace*{2.35cm}%
  {\centering
    \sffamily\bfseries\selectfont
    \MakeTextUppercase{\contentsname}\par
  }%
  \vspace{1cm}\par
  \addcontentsline{toc}{chapter}{\contentsname}%
  \begingroup
    \let\clearpage\relax
    \let\cleardoublepage\relax
    \@starttoc{toc}%
  \endgroup
}

%% Liste des figures
\newcommand{\SansListOfFigures}{%
  \cleardoublepage
  \thispagestyle{plain}%
  \vspace*{2.35cm}%
  {\centering
    \sffamily\bfseries\selectfont
    \MakeTextUppercase{\listfigurename}\par
  }%
  \vspace{1cm}\par
  \addcontentsline{toc}{chapter}{\listfigurename}%
  \begingroup
    \let\clearpage\relax
    \let\cleardoublepage\relax
    \@starttoc{lof}%
  \endgroup
}

%% Liste des tableaux
\newcommand{\SansListOfTables}{%
  \cleardoublepage
  \thispagestyle{plain}%
  \vspace*{2.35cm}%
  {\centering
    \sffamily\bfseries\selectfont
    \MakeTextUppercase{\listtablename}\par
  }%
  \vspace{1cm}\par
  \addcontentsline{toc}{chapter}{\listtablename}%
  \begingroup
    \let\clearpage\relax
    \let\cleardoublepage\relax
    \@starttoc{lot}%
  \endgroup
}

%% Liste des sources
\newcommand{\SansListOfSources}{%
  \cleardoublepage
  \thispagestyle{plain}%
  \vspace*{2.35cm}%
  {\centering
    \sffamily\bfseries\selectfont
    \MakeTextUppercase{\lstlistlistingname}\par
  }%
  \vspace{1cm}\par
  \addcontentsline{toc}{chapter}{\lstlistlistingname}%
  \begingroup
    \let\clearpage\relax
    \let\cleardoublepage\relax
    \@starttoc{lol}%
  \endgroup
}

%% Bibliographie
\newcommand{\SansBibliography}[1]{%
  \cleardoublepage
  \thispagestyle{plain}%
  \vspace*{2.35cm}%
  {\centering
    \sffamily\bfseries\selectfont
    \MakeTextUppercase{\bibname}\par
  }%
  \vspace{1cm}\par
  \addcontentsline{toc}{chapter}{\bibname}%
  \bibliography{#1}%
}

\makeatother

%% Environnements verbatim à simple interligne par défaut
\BeforeBeginEnvironment{verbatim}{\def\baselinestretch{1}}

%% ------------------------
%% Création des méta-données PDF. Cette section du code s'assure également que
%% le document produit soit conforme au standard PDF/A, ce qui requiert quelques
%% manipulations (https://tex.stackexchange.com/a/535849).
%% ------------------------
\makeatletter
\hypersetup{%
  pdflang=la,
  pdfapart=3, %set to 1 for PDF/A-1
  pdfaconformance=B
  hidelinks,
  bookmarks = {true},
  pdfauthor = {\@author},
  pdftitle = {\@title},
  pdfproducer = {Package uqac-these-dim V\uqacVersion}
}
\makeatother

%% Codes pour jEdit
%% :mode=latex:wrap=none: