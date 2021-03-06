\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{thesis}[2017/11/09 Thesis]

\LoadClass[a4paper,showtrims]{memoir}

\usepackage{geometry}

\usepackage[no-math]{fontspec}
\usepackage{color}
\usepackage{graphicx}
\usepackage{ifthen}
\usepackage{microtype}
\usepackage{polyglossia}

\usepackage{hyperref}
\usepackage[all]{hypcap}

%
% Variables
%

\def\createvariable#1{
  \expandafter\def\csname #1\endcsname{\expandafter\gdef\csname @#1\endcsname}
  \csname #1\endcsname{\texttt{\textbackslash #1}}
}

\createvariable{department}
\createvariable{divanumber}
\createvariable{isbn}
\createvariable{issn}
\createvariable{publicationnumber}
\createvariable{publicationseries}
\createvariable{publicationyear}

\gdef\@abstractenglish{\input{include/abstract/english}}
\gdef\@abstractswedish{\input{include/abstract/swedish}}
\gdef\@acknowledgments{\input{include/acknowledgments}}
\gdef\@dedication{\input{include/dedication}}
\gdef\@logoenglish{include/assets/layout/logo-english}

%
% Typography
%

\settrimmedsize{240mm}{165mm}{*}
\settypeblocksize{*}{28pc}{1.618}

\newcommand{\adjustlayout}{
  \setlength{\trimtop}{\stockheight}
  \addtolength{\trimtop}{-\paperheight}
  \setlength{\trimedge}{\stockwidth}
  \addtolength{\trimedge}{-\paperwidth}
  \settrims{0.5\trimtop}{0.5\trimedge}
  \setlrmargins{*}{*}{1.5}
  \setulmargins{2cm}{*}{*}
}

\setmainlanguage{english}
\setotherlanguages{swedish}

\newfontfamily{\headingfont}[]{KorolevLiU Medium}

\setmainfont{MillerText}[
  BoldFont="MillerText-Bold",
  ItalicFont="MillerText-Italic",
  SmallCapsFont="MillerText-RomanSC",
]

\setmonofont{InputMonoNarrow}[
  Scale=MatchLowercase,
]

\linespread{1.05}

\clubpenalty=10000
\widowpenalty=10000
\raggedbottom
\midsloppy

%
% Title
%

\renewcommand{\maketitle}{
  \center
  {
    \@publicationseries, No.~\@publicationnumber
  }\\[10em]
  {
    \headingfont
    \Huge
    \@title
  }\\[4em]
  {
    \headingfont
    \huge
    \@author
  }
  \vfill
  \includegraphics[height=5.5em]{\@logoenglish}\\[2em]
  {
    \@department\\
    Linköping University\\
    SE-581\,83 Linköping, Sweden\\[2em]
    Linköping \@publicationyear
  }
}

%
% Permissions
%

\newcommand{\makepermission}{
  \mbox{}
  \vfill
  \begin{flushleft}
    \copyright\ \@publicationyear\ \@author\\[2em]
    \setlength\tabcolsep{0em}%
    \begin{tabular}{p{3em}b{\textwidth-3em}}
      ISBN & \texttt{\@isbn} \\
      ISSN & \texttt{\@issn} \\
      URL  & \texttt{https://urn.kb.se/resolve?urn=urn:nbn:se:liu:diva-\@divanumber} \\
    \end{tabular}\\[2em]
    Printed by LiU-Tryck, Linköping \@publicationyear
  \end{flushleft}
}

%
% Dedication
%

\newcommand{\makededication}{
  \mbox{}
  \vfill
  \begin{center}
    \Large
    \@dedication\\
  \end{center}
  \vfill
}

%
% Abstract
%

\newcommand{\makeabstractenglish}{
  \begin{english}
    \centerline{\Large\textsc{Abstract}}
    \phantomsection
    \addcontentsline{toc}{chapter}{Abstract}
    \vspace{1em}
    \noindent
    \@abstractenglish
  \end{english}
}

\newcommand{\makeabstractswedish}{
  \begin{swedish}
    \centerline{\Large\textsc{Sammanfattning}}
    \vspace{1em}
    \noindent
    \@abstractswedish
  \end{swedish}
}

%
% Acknowledgments
%

\newcommand{\makeacknowledgments}{
  \chapter*{Acknowledgments}
  \phantomsection
  \addcontentsline{toc}{chapter}{Acknowledgments}
  \@acknowledgments
}

%
% Algorithms
%

\newfloat{algorithm}{loa}{Algorithm}
\newlistof{listofalgorithms}{loa}{List of Algorithms}
\newlistentry[chapter]{algorithm}{loa}{0}

\renewcommand{\insertchapterspace}{%
  \addtocontents{loa}{\protect\addvspace{1em}}%
  \addtocontents{lof}{\protect\addvspace{1em}}%
  \addtocontents{lot}{\protect\addvspace{1em}}%
}

%
% Chapters
%

\makepagestyle{simple}
\makeoddfoot{simple}{}{}{\thepage}
\makeevenfoot{simple}{\thepage}{}{}

\newif\ifNoChapterNumber

\makechapterstyle{blackbox}{
  \renewcommand{\printchaptername}{}
  \renewcommand{\printchapternum}{}
  \renewcommand{\afterchapternum}{}
  \renewcommand{\printchapternonum}{\NoChapterNumbertrue}
  \renewcommand{\printchaptertitle}[1]{%
    \setlength\fboxsep{0em}%
    \setlength\tabcolsep{0em}%
    \begin{tabular}{p{5em}b{\textwidth-5em}}
      \colorbox{black}{%
        \begin{minipage}[c][10em][t]{2.5em}
          \ifNoChapterNumber
            \strut
          \else
            \headingfont
            \Huge
            \color{white}
            \vspace{0.4em}
            \centering
            \thechapter
          \fi
        \end{minipage}%
      } & \colorbox{white}{%
        \begin{minipage}[c][10em][c]{\textwidth-5em}
          \headingfont
          \Huge
          \raggedright
          ##1
        \end{minipage}
      }
    \end{tabular}
    \NoChapterNumberfalse
  }
}

%
% Document
%

\AtBeginDocument{
  \chapterstyle{blackbox}
  \adjustlayout
  \checkandfixthelayout
  \pagestyle{empty}
  \pagenumbering{roman}
  {
    \maketitle
    \clearpage
  }
  {
    \makepermission
    \clearpage
  }
  {
    \makededication
    \cleardoublepage
  }
  \pagestyle{plain}
  {
    \makeabstractenglish
    \cleardoublepage
  }
  {
    \makeabstractswedish
    \cleardoublepage
  }
  {
    \makeacknowledgments
    \cleardoublepage
  }
  {
    \renewcommand{\contentsname}{Table of Contents}
    \tableofcontents
    \cleardoublepage
  }
  {
    \listofalgorithms
    \cleardoublepage
  }
  {
    \listoffigures
    \cleardoublepage
  }
  {
    \listoftables
    \cleardoublepage
  }
  \cleardoublepage
  \pagenumbering{arabic}
  \pagestyle{ruled}
  \aliaspagestyle{chapter}{simple}
}

% vim: set ft=tex:
