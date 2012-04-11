% v1.22 by Erich L Foster 10 April 2012
%%% IDENTIFICATION --------------------------------------------------------
%\NeedsTeXFormat{LaTeX2e}[01/01/10]
\ProvidesClass{VTthesis}[11/04/2012 v2.0 Virginia Tech Thesis Proposal and Thesis Class]
\RequirePackage{etoolbox}
%Declaration of options
\newbool{@sig} 
\boolfalse{@sig}
\newbool{@proposal} 
\boolfalse{@proposal}

\DeclareOption{sig}{\booltrue{@sig}}
\DeclareOption{nosig}{\boolfalse{@sig}}
\DeclareOption{proposal}{\booltrue{@proposal}}
%%% EXECUTION OF OPTIONS --------------------------------------------------
%% default to:
\ExecuteOptions{nosig}

\ProcessOptions

%%% PACKAGE LOADING -------------------------------------------------------
%% based on std report class
\LoadClass[11pt,letterpaper]{report}%book}

%% AMSLaTeX math environments and symbols
\RequirePackage{amsmath, amsthm, amssymb}
\RequirePackage[normalem]{ulem}
\RequirePackage[hmargin=1in,vmargin=1in,footskip=.25in,headsep=.25in,nomarginpar]{geometry}
\RequirePackage{enumerate}
\RequirePackage{paralist}
\RequirePackage[page]{appendix}
\RequirePackage{hyperref}

%For including pdf images
\RequirePackage{graphicx}
\RequirePackage{float}

%MATLAB Code formatting
\RequirePackage{listings}
\RequirePackage{verbatim}

\lstset{% command to set programming language parameter(s)
frame=single,
	showstringspaces=false,
	showlines=false, %get rid of trailing white lines
	emptylines=1, %allow blank line 
	breaklines=true, %get rid of overflow lines and enter \n
	numbers=left, %line number
	numberstyle=\scriptsize, %make line numbers small
	stepnumber=1, %line number every line
	numbersep=5pt,
	tabsize=2, %set tabs to two spaces
	basicstyle=\small, % print whole listing small
	keywordstyle=\bfseries,% green keywords
	stringstyle=\ttfamily % typewriter type for strings
}

% \author, \title are defined in book; here are the rest of the
% front matter defining macros
\def\@title{}
\def\@author{}
\def\@degree{Doctor of Philosophy}
\def\@program{Mathematics}
\def\@submitdate{\the\day \space \ifcase\the\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space \number\the\year}

\def\type#1{\gdef\@type{#1}}
\def\degree#1{\gdef\@degree{#1}}
\def\program#1{\gdef\@program{#1}}
\def\submitdate#1{\gdef\@submitdate{#1}}

\ifnum\month>9
    \@tempcnta=\year \advance\@tempcnta by 1
    \edef\@copyrightyear{\number\the\@tempcnta}
\else
    \def\@copyrightyear{\number\the\year}
\fi

%committee information
\newbool{@1st} 
\boolfalse{@1st}
\newbool{@2nd} 
\boolfalse{@2nd}
\newbool{@3rd} 
\boolfalse{@3rd}
\newbool{@4th} 
\boolfalse{@4th}
\newbool{@5th} 
\boolfalse{@5th}
\def\@principaladvisor{}
\def\@firstreader{}
\def\@secondreader{}
\def\@thirdreader{}
\def\@fourthreader{}
\def\@fifthreader{}
\def\principaladvisor#1{\gdef\@principaladvisor{#1}}
\def\firstreader#1{\booltrue{@1st} \gdef\@firstreader{#1}}
\def\secondreader#1{\booltrue{@2nd} \gdef\@secondreader{#1}}
\def\thirdreader#1{\booltrue{@3rd} \gdef\@thirdreader{#1}}
\def\fourthreader#1{\booltrue{@4th} \gdef\@fourthreader{#1}}
\def\fifthreader#1{\booltrue{@5th} \gdef\@fifthreader{#1}}

%abstract, acknowledgements, dedication, and keywords setup
\def\@abstract{}
\def\@acknowledge{}
\def\@dedication{}
\def\@keywords{}
\newbool{@key}
\boolfalse{@key}
\newbool{@abs}
\boolfalse{@abs}
\newbool{@ack}
\boolfalse{@ack}
\newbool{@ded}
\boolfalse{@ded}
\def\abstract#1{\booltrue{@abs} \gdef\@abstract{#1}}
\def\acknowledge#1{\booltrue{@ack} \gdef\@acknowledge{#1}}
\def\dedication#1{\booltrue{@ded} \gdef\@dedication{#1}}
\def\keywords#1{\booltrue{@key} \gdef\@keywords{#1}}

\newcommand{\@vtcopyright}{Copyright \@copyrightyear, \@author}

% Setup the header and footer
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhead[L]{\@author}
\fancyhead[C]{\chaptername\ \thechapter}
\fancyhead[R]{\thepage}
\fancyfoot[L,C,R]{}
\renewcommand\headrulewidth{0.0pt}

%setup up frontmatter, mainmatter, backmatter
%the formatting for these sections will be different
\newcommand{\frontmatter}{
  \cleardoublepage
  \pagenumbering{roman}}
\newcommand{\mainmatter}{
  \cleardoublepage
  \pagenumbering{arabic}}
\newcommand{\biblio}{
  \cleardoublepage
  \addcontentsline{toc}{chapter}{\bibname}
  \fancyhead[C]{\bibname}}
\newcommand{\backmatter}{
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \fancyhead[C]{\appendixname\ \thechapter}
  }

%setup title page, abstract page, dedication page, and acknowledgement page
\def\titlepage{%
  \thispagestyle{empty}
	\begin{center}
  {\Large \@title}\\
	\vfill
	\rm \@author\\
	\vfill
	
  \ifbool{@proposal}{
    \noindent Thesis proposal for}
    {\noindent Dissertation submitted to the Faculty of the \\
    Virginia Polytechnic Institute and State University \\
    in partial fulfillment of the requirements for the degree of \\} 

  \vfill 
  \@degree \\
  in \\
  \@program \\
  \vfill

  \noindent \@principaladvisor, Chair \\
  \ifbool{@1st}{\@firstreader\\}{}
  \ifbool{@2nd}{\@secondreader\\}{}
  \ifbool{@3rd}{\@thirdreader\\}{}
  \ifbool{@4th}{\@fourthreader\\}{}
  \ifbool{@5th}{\@fifthreader\\}{}
  \vfill

	\@submitdate\\
	Blacksburg, Virginia\\

  \ifbool{@key}{\vfill 
    Keywords: \@keywords\\}{}

  \vfill
	\@vtcopyright \\

	\end{center}
  \newpage
  \addtocounter{page}{1}
}

\def\abspage{
  \thispagestyle{empty}
  \begin{center}
  \noindent {\Large \@title} \\ 

  \vfill
  \noindent  \@author \\ 
  \vfill

  (ABSTRACT)
  \end{center}
  \vfill

  \@abstract
  \newpage
}

\def\ackpage{
  \chapter*{Acknowledgments}
  %\pdfbookmark[1]{Acknowledgments}{acknowledgments}
  \@acknowledge
  \newpage
}

\def\dedpage{
  \chapter*{Dedication}
  %\pdfbookmark[1]{Dedication}{dedication}
  \@dedication
  \newpage
}

%This is where the main magic happens
\renewcommand\maketitle{
  %\ifbool{@sig}{
  %  \pdfbookmark[1]{Signature Page}{sigpage}
  %  \sigpage}{}

  \setcounter{page}{0}
  \pdfbookmark[1]{Titlepage}{titlepage}
  \titlepage
  \ifbool{@abs}{
    \pdfbookmark[1]{Abstract}{abstract}
    \abspage}{}
  \ifbool{@ded}{
    \pdfbookmark[1]{Dedication}{dedication}
    \dedpage}{}
  \ifbool{@ack}{
    \pdfbookmark[1]{Acknowledgements}{acknowledgements}
    \ackpage}{}
}
