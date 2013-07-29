% v2.0 by Erich L Foster 01 May 2013
%%% IDENTIFICATION --------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}[01/01/10]
\ProvidesClass{VTthesis}[24/07/2013 v3.0 Virginia Tech Thesis Proposal and Thesis Class]
\RequirePackage{etoolbox}
%Declaration of options
\def\@@ptsize{12pt}
\newbool{@sig}
\boolfalse{@sig}
\newbool{@proposal}
\boolfalse{@proposal}
\newbool{@dft}
\boolfalse{@dft}
\newbool{@dbl}
\boolfalse{@dbl}

\DeclareOption{10pt}{\def\@@ptsize{10pt}}
\DeclareOption{11pt}{\def\@@ptsize{11pt}}
\DeclareOption{12pt}{\def\@@ptsize{12pt}}
\DeclareOption{13pt}{\def\@@ptsize{13pt}}
\DeclareOption{sig}{\booltrue{@sig}}
\DeclareOption{nosig}{\boolfalse{@sig}}
\DeclareOption{proposal}{\booltrue{@proposal}}
\DeclareOption{draft}{\booltrue{@dft} \booltrue{@dbl}}
\DeclareOption{doublespace}{\booltrue{@dbl}}
%%% EXECUTION OF OPTIONS --------------------------------------------------
%% default to:
\ExecuteOptions{nosig}

\ProcessOptions

%%% PACKAGE LOADING -------------------------------------------------------
%% based on std report class
\LoadClass[\@@ptsize,letterpaper]{report}%book}
\RequirePackage{lmodern}

%used for List of Figures and table magic
\RequirePackage{etoolbox}

%% AMSLaTeX math environments and symbols
\RequirePackage{amsmath,amsthm,amssymb}
\RequirePackage[normalem]{ulem}
\RequirePackage[hmargin=1in,vmargin=1in,footskip=.25in,headsep=.25in,nomarginpar]{geometry}
\RequirePackage{enumerate}
\RequirePackage{paralist}
\RequirePackage[page]{appendix}

%double space option
\RequirePackage{setspace}
\ifbool{@dbl}{\doublespace}{}

%links for references
\RequirePackage[final]{hyperref}

%For including pdf images
\RequirePackage[final]{graphicx}
\RequirePackage{float}

%draft watermark
\ifbool{@dft}{
\PassOptionsToPackage{final}{hyperref}
\PassOptionsToPackage{final}{graphicx}
\usepackage[firstpage]{draftwatermark}}{}


%MATLAB Code formatting
\RequirePackage{listings}
\PassOptionsToPackage{final}{listings}
\RequirePackage{verbatim}

%define theorems and such
\newtheorem{proposition}{Proposition}[chapter]
\newtheorem{theorem}[proposition]{Theorem}
\newtheorem{lemma}[proposition]{Lemma}
\newtheorem{corollary}[proposition]{Corollary}
\newtheorem{conjecture}[proposition]{Conjecture}
\newtheorem{example}[proposition]{Example}
\newtheorem{definition}[proposition]{Definition}
\newtheorem{remark}[proposition]{Remark}

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
\def\@institute{Virginia Polytechnica Institute and State University}
\def\@location{Blacksburg, Virginia}
\def\@program{Mathematics}
\def\@submitdate{\the\day \space \ifcase\the\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space \number\the\year}

\def\type#1{\gdef\@type{#1}}
\def\degree#1{\gdef\@degree{#1}}
\def\institute#1{\gdef\@institute{#1}}
\def\location#1{\gdef\@location{#1}}
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
\long\def\abstract#1{\booltrue{@abs} \gdef\@abstract{#1}}
\long\def\acknowledge#1{
  \ifbool{@dft}{}
  {\booltrue{@ack} \gdef\@acknowledge{#1}}
}
\long\def\dedication#1{
  \ifbool{@dft}{}
  {\booltrue{@ded} \gdef\@dedication{#1}}
}
\def\keywords#1{\booltrue{@key} \gdef\@keywords{#1}}

\newcommand{\@vtcopyright}{Copyright \@copyrightyear, \@author}

% Setup the header and footer
\RequirePackage{fancyhdr}
\pagestyle{fancy}

%the following is a hack to deal with the possibility of having no figures
\AtEndEnvironment{figure}{\gdef\there@is@a@figure{}}
\AtEndDocument{\ifdefined\there@is@a@figure\label{fig:was:used:in:doc}\fi}
\newcommand{\conditionalLoF}{\@ifundefined{r@fig:was:used:in:doc}{}{\listoffigures}}%

%the following is a hack to deal with the possibility of having no tables
\AtEndEnvironment{table}{\gdef\there@is@a@table{}}
\AtEndDocument{\ifdefined\there@is@a@table\label{tab:was:used:in:doc}\fi}
\newcommand{\conditionalLoT}{\@ifundefined{r@tab:was:used:in:doc}{}{\listoftables}}%

%setup up frontmatter, mainmatter, backmatter
%the formatting for these sections will be different
\newcommand{\frontmatter}{
  \cleardoublepage
  \pagenumbering{roman}
  \fancyhead[L,R]{}
  \ifbool{@dft}{\fancyhead[C]{\textbf{DRAFT}}}{\fancyfoot[C]{\thepage}}{\fancyfoot[C]{\thepage}}
  \fancyfoot[L,R]{}
  \renewcommand\headrulewidth{0.0pt}
  \maketitle
  \tableofcontents
  \conditionalLoT
  \conditionalLoF
}
\newcommand{\mainmatter}{
  \cleardoublepage
  \pagenumbering{arabic}
  \fancyhead[L]{\@author}
  \fancyhead[C]{\chaptername\ \thechapter}
  \fancyhead[R]{\thepage}
  \ifbool{@dft}{\fancyfoot[C]{\textbf{DRAFT}}}{\fancyfoot[C]{}}
  \fancyfoot[L,R]{}
  \renewcommand\headrulewidth{0.0pt}}
\newcommand{\biblio}{
  \cleardoublepage
  \fancyhead[C]{\bibname}
}
\newcommand{\backmatter}{
  \cleardoublepage
  \fancyhead[C]{\appendixname\ \thechapter}
}
%redefine the appendix to show up as sections in the TOC with Appendices as the Chapter
\newcommand\appendix@chapter[1]{%
  \refstepcounter{chapter}%
  \orig@chapter*{{\huge Appendix \@Alph\c@chapter}\\[0.75em] #1}%
  \addcontentsline{toc}{section}{\@Alph\c@chapter\ \  #1}%
}
\let\orig@chapter\chapter
\g@addto@macro\appendix{\let\chapter\appendix@chapter}

%have the bibliography show in the TOC and make sure the header says bibliography
\pretocmd{\bibliography}{\biblio}{}{}
\apptocmd{\bibliography}{\addcontentsline{toc}{chapter}{\bibname}}{}{}
%add the appendices to the TOC
\apptocmd{\appendix}{
  \addcontentsline{toc}{chapter}{Appendices}
  \backmatter}{}{}

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
    \@institute \\
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
	\@location\\

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
  \@acknowledge
  \newpage
}

\def\dedpage{
  \vspace*{\fill}
  \begingroup
  \begin{center}
    \emph{\@dedication}
  \end{center}
  \endgroup
  \vspace*{\fill}
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
