%% --------------------------------------------------------------------------
%% Classe essai/mémoire/thèse DIM UQAC
%%
%% uqac-these-dim.cls
%% Copyright 2012-2024 Sylvain Hallé, Florentin Thullier
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
\ProvidesClass{uqac-these-dim}[2024/11/04 These DIM UQAC, V3.0 par Sylvain Halle \& Florentin Thullier]

%% ------------------------
%% Numéro de version
%% ------------------------
\def\@uqactheseversion{3.0}

%% ------------------------
%% Choix du type de document
%% ------------------------
%% Thèse
\def\@uqacthese{false}
\DeclareOption{these}{%
  \def\@uqacthese{true}
}

%% Projet de thèse
\def\@uqacprojthese{false}
\DeclareOption{projthese}{%
  \def\@uqacprojthese{true}
}

%% Sujet de thèse
\def\@uqacsujthese{false}
\DeclareOption{sujthese}{%
  \def\@uqacsujthese{true}
}

%% Mémoire
\def\@uqacmemoire{false}
\DeclareOption{memoire}{%
  \def\@uqacmemoire{true}
}

%% Essai
\def\@uqacessai{false}
\DeclareOption{essai}{%
  \def\@uqacessai{true}
}

%% Rapport
\def\@uqacrapport{false}
\DeclareOption{rapport}{%
  \def\@uqacrapport{true}
}

%% ------------------------
%% Choix de la langue du document
%% ------------------------
%% French
\def\@uqacfrench{false}
\DeclareOption{francais}{%
  \def\@uqacfrench{true}
}

%% English
\def\@uqacenglish{false}
\DeclareOption{rapport}{%
  \def\@uqacenglish{true}
}

%% ------------------------
%% Option brouillon
%% ------------------------
\def\@uqacpdcbrouillon{false} %% Pas brouillon par défaut
\DeclareOption{brouillon}{%
  \def\@uqacpdcbrouillon{true}
}

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
\RequirePackage{geometry}
\RequirePackage[T1]{fontenc}
\RequirePackage{graphicx}
\RequirePackage{ifthen}
\let\footruleskip\undefined\RequirePackage{fancyhdr}
\RequirePackage[explicit]{titlesec}
%% Formatage des légendes de tableaux et figures
\RequirePackage{caption}
\RequirePackage{textcase}
%% Pour interligne simple dans les listes (table des matières, etc.) et
%% double dans le reste
\RequirePackage{setspace}
%% Paramètres de la table des matières
\RequirePackage{tocloft}
%% Mise en majuscules plus sécuritaire
\RequirePackage{textcase}
%% On ne pagine pas pages vides
\RequirePackage{emptypage}
%% Liste des acronymes
\RequirePackage{acro}
%% Requis par le style bibliographique IEEEtran
\RequirePackage{amsmath}
%% Gestion de la bibliographie, doit être chargé avant babel
\RequirePackage[numbers]{natbib}
%% Pour le rectangle "brouillon" sur la page titre
\RequirePackage{color}
%% Pour faire des rectangles avec la commande "todo"
\RequirePackage{mdframed}
%% Babel en anglais ou en français
\ifthenelse{\equal{\@uqacenglish}{true}}{%
  \RequirePackage[english]{babel}
}{
  \RequirePackage[french]{babel}
}

%% ------------------------
%% Ces packages doivent être chargés après babel
%% -----------------------
\RequirePackage[babel]{microtype} %% Meilleure typographie
\RequirePackage{caption} %% Pour définir les légendes des figures
\RequirePackage[hidelinks,bookmarks=true]{hyperref} %% Méta-données PDF

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
%% Si l'option brouillon n'est pas active, le comportement de certaines
%% commandes change
%% ------------------------
\ifthenelse{\equal{\@uqacpdcbrouillon}{false}}{%
  %% Les todo provoquent des erreurs de compilation
  \newcommand{\todo}[1]{\ClassError{uqac-these-dim}{Il reste des todo dans le document: #1}{Le document n'est pas en mode brouillon et il reste des occurrences de la commande todo. Assurez-vous que tous les todos sont réglés pour compiler le document en mode final.}}
  %% Les références non-définies provoquent des erreurs de compilation
  \RequirePackage{nag}
  %% Tout ce qui dépasse de la marge provoque une erreur de compilation
  \RequirePackage{silence}
  \WarningFilter{latex}{Overfull \hbox}
}{
  %% Les todo sont visibles
  \newcommand{\todo}[1]{%
        \fcolorbox{red}{red!20}{\parbox{\dimexpr\textwidth-2\fboxsep-2\fboxrule\relax}{%
            \textbf{TODO:} #1%
        }}%
  }
}

%% ------------------------
%% Paramètres spécifiques à la langue du document
%% ------------------------
\ifthenelse{\equal{\@uqacfrench}{true}}{%
%% Français
  %% Pas d'alinéas et une ligne vide
  \setlength{\parindent}{0pt}
  \setlength{\parskip}{10pt}
  %% Biblio en français
  \bibliographystyle{IEEEtranSN_francais}
}{%
%% Anglais
  %% Biblio en anglais
  \bibliographystyle{IEEEtranSN}
}

%% ------------------------
%% Interlignes
%% -----------------------
\newlength{\simpleinter}
\setlength{\simpleinter}{\baselineskip}
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
\titleformat{\chapter}%
[block]%
{\centering\bfseries\selectfont}%
{\MakeTextUppercase{Chapitre \thechapter}}% Titre du chapitre
{0cm}% Séparation d'avec le corps du chapitre
{\vskip 0pt\MakeTextUppercase{#1}}% Code à exécuter avant le titre
{}% Code à exécuter après le titre

\renewcommand{\thesection}{\arabic{chapter}.\arabic{section}}
\titleformat{\section}%
[hang]%
{\bfseries\selectfont}%
{\MakeTextUppercase{\thesection}}% Titre du chapitre
{0.5cm}% Séparation d'avec le corps du chapitre
{\MakeTextUppercase{#1}}% Code à exécuter avant le titre
{}% Code à exécuter après le titre

\renewcommand{\thesubsection}{\arabic{chapter}.\arabic{section}.\arabic{subsection}}
\titleformat{\subsection}%
[hang]%
{\itshape\selectfont}%
{\MakeTextUppercase{\thesubsection}}% Titre du chapitre
{0.5cm}% Séparation d'avec le corps du chapitre
{\MakeTextUppercase{#1}}% Code à exécuter avant le titre
{}% Code à exécuter après le titre

%% Les chapitres sans numéro apparaissent dans la table des matières aussi
\let\stdchapter\chapter
\renewcommand*\chapter{%
  \@ifstar{\starchapter}{\@dblarg\nostarchapter}}
\newcommand*\starchapter[1]{\addcontentsline{toc}{chapter}{#1}\stdchapter*{#1}}
\def\nostarchapter[#1]#2{\stdchapter[{#1}]{#2}}

%% ------------------------
%% Légende des figures
%% ------------------------
%% Pour une raison étrange, Babel hard-code l'usage de petites majuscules
%% pour le mot "Figure"; on doit donc le redéfinir
%% (cf. http://tex.stackexchange.com/questions/73639/caption-formatting-with-babel-french)
\captionsetup[figure]{name=Figure}
\captionsetup[table]{name=Tableau}
\renewcommand{\captionfont}{\normalfont\small\bfseries}

%% Redéfinition des termes en français et en anglais
\ifthenelse{\equal{\@uqacfrench}{true}}{%
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
%% Notes de bas de page
%% ------------------------
\setlength{\footnotesep}{\doubleinter}
\renewcommand{\@makefntext}[1]%
  {\setlength{\parindent}{2em}%
   \makebox[1.8em][r]{\@makefnmark}#1}
\renewcommand{\footnoterule}{
 \noindent
 \rule{4cm}{0.4pt}
}
\counterwithout*{footnote}{chapter}

%% ------------------------
%% Bouts de texte apparaissant sur la page couverture, en fonction des
%% options passées au document
%% ------------------------
\def\concentration#1{\gdef\@concentration{#1}}
\concentration{}
\def\degreeyear#1{\gdef\@degreeyear{#1}}
\def\programme#1{\gdef\@programme{#1}}
\programme{}
\degreeyear{\the\year}
\ifthenelse{\equal{\@uqacfrench}{true}}{%
  \def\@uqacauteurpar{par}}{
  \def\@uqacauteurpar{by}
}

\ifthenelse{\equal{\@uqacthese}{true}}{%
	\ifthenelse{\equal{\@uqacfrench}{true}}{%
  		\gdef\thesetype{\textbf{\MakeUppercase{th\`ese}}}
   		\gdef\thesegrade{\textbf{\MakeUppercase{philosophi\ae{} doctor (Ph.D.) en \expandafter\expandafter{\@programme}}}}
   		\gdef\accord{e}
	}{
		\gdef\thesetype{\textbf{\MakeUppercase{thesis}}}
   		\gdef\thesegrade{\textbf{\MakeUppercase{philosophi\ae{} doctor (Ph.D.) in the subject of \expandafter\expandafter{\@programme}}}}
   		\gdef\accord{e}
	}
}{%
	\ifthenelse{\equal{\@uqacprojthese}{true}}{%
		\ifthenelse{\equal{\@uqacfrench}{true}}{%
	  		\gdef\thesetype{\textbf{\MakeUppercase{projet de th\`ese}}}
	   		\gdef\thesegrade{\textbf{\MakeUppercase{philosophi\ae{} doctor (Ph.D.) en \expandafter\expandafter{\@programme}}}}
	   		\gdef\accord{}
   		}{
   			\gdef\thesetype{\textbf{\MakeUppercase{thesis project}}}
	   		\gdef\thesegrade{\textbf{\MakeUppercase{philosophi\ae{} doctor (Ph.D.) in the subject of \expandafter\expandafter{\@programme}}}}
	   		\gdef\accord{}
   		}
	}{
    \ifthenelse{\equal{\@uqacsujthese}{true}}{%
      \ifthenelse{\equal{\@uqacfrench}{true}}{%
          \gdef\thesetype{\textbf{\MakeUppercase{sujet de th\`ese}}}
          \gdef\thesegrade{\textbf{\MakeUppercase{philosophi\ae{} doctor (Ph.D.) en \expandafter\expandafter{\@programme}}}}
          \gdef\accord{}
        }{
          \gdef\thesetype{\textbf{\MakeUppercase{thesis subject}}}
          \gdef\thesegrade{\textbf{\MakeUppercase{philosophi\ae{} doctor (Ph.D.) in the subject of \expandafter\expandafter{\@programme}}}}
          \gdef\accord{}
        }
    }{
      \ifthenelse{\equal{\@uqacmemoire}{true}}{%
        \ifthenelse{\equal{\@uqacfrench}{true}}{%
            \gdef\thesetype{\textbf{\MakeUppercase{m\'emoire}}}
            \gdef\thesegrade{\textbf{\MakeUppercase{ma\^itre \`es sciences en \expandafter\expandafter{\@programme}}}}
          \gdef\accord{}
        }{
          \gdef\thesetype{\textbf{\MakeUppercase{master thesis}}}
            \gdef\thesegrade{\textbf{\MakeUppercase{master of science in the subject of \expandafter\expandafter{\@programme}}}}
          \gdef\accord{}
        }
      }{
        \ifthenelse{\equal{\@uqacessai}{true}}{%
          \ifthenelse{\equal{\@uqacfrench}{true}}{%
              \gdef\thesetype{\textbf{\MakeUppercase{essai}}}
              \gdef\thesegrade{\textbf{\MakeUppercase{ma\^itre \`es sciences en \expandafter\expandafter{\@programme}}}}
            \gdef\accord{}
          }{
            \gdef\thesetype{\textbf{\MakeUppercase{research essay}}}
              \gdef\thesegrade{\textbf{\MakeUppercase{master of science in the subject of \expandafter\expandafter{\@programme}}}}
            \gdef\accord{}
          }
        }{
          \ifthenelse{\equal{\@uqacrapport}{true}}{%
            \ifthenelse{\equal{\@uqacfrench}{true}}{%
                \gdef\thesetype{\textbf{\MakeUppercase{rapport de recherche}}}
                \gdef\thesegrade{\textbf{\MakeUppercase{ma\^itre \`es sciences en \expandafter\expandafter{\@programme}}}}
              \gdef\accord{}
            }{
              \gdef\thesetype{\textbf{\MakeUppercase{research report}}}
                \gdef\thesegrade{\textbf{\MakeUppercase{master of science in the subject of \expandafter\expandafter{\@programme}}}}
              \gdef\accord{}
            }
          }
        }
      }
    }
  }
}

%% ------------------------
%% Rendu de la page couverture
%% ------------------------
\renewcommand{\maketitle}{%
\begin{titlepage}
\begin{center}
\begin{spacing}{2}
\includegraphics[width=1.5in]{uqac-logo}

\vfill

\textbf{\MakeTextUppercase{\@title}}

\vfill

\textbf{\MakeUppercase{\expandafter{\@uqacauteurpar} \expandafter{\@author}}}

\vfill

\thesetype{}
\ifthenelse{\equal{\@uqacfrench}{true}}{%
	\textbf{\MakeUppercase{pr\'esent\'e\accord{} à l'Universit\'e du Qu\'ebec \`a Chicoutimi comme exigence partielle en vue de l'obtention du grade de}}
}{
	\textbf{\MakeUppercase{presented to Université du Qu\'ebec \`a Chicoutimi in partial fulfillment of the requierments for the degree of}}
}
\thesegrade{}
\ifx\@concentration\empty
\else
\textbf{\MakeUppercase{\@concentration}}
\fi
\vfill

\textbf{\MakeUppercase{Qu\'ebec, Canada}}
\vfill

\textbf{\MakeUppercase{\textcopyright{} \@author, \@degreeyear}}
\vfill
\end{spacing}
%% Rectangle rouge indiquant le mode brouillon le cas échéant
\ifthenelse{\equal{\@uqacpdcbrouillon}{true}}{%
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

%% Formatage des légendes pour les figures et les tableaux
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

%% Environnements verbatim à simple interligne par défaut
\BeforeBeginEnvironment{verbatim}{\def\baselinestretch{1}}

%% Codes pour jEdit
%% :mode=latex:wrap=none: