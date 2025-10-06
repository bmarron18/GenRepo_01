%
% OSUletter.cls -- a document class for writing letters with OSU letterhead 
%This class based on "brownletter.cls" Copyright 2003, Nesime Tatbul (tatbul@cs.brown.edu)
%
%This version modifications by Brian Wood
%(brian.wood@oregonstate.edu), 22 September 2017
%
% Notes:
%
% 1. This class can be used for creating letters with OSU logo at the
%    header and  department address at the footer 
% 2. It is based on the standard Latex document class, letter.cls.
% 3. Required packages are epsfig and ifthen.
% 4. If OSU logo is to be included in the head, then the file
%    OSUlogo.eps must be provided. Otherwise, the logo is omitted.
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Regenerarletter}
\RequirePackage{graphicx}
\RequirePackage{epstopdf}
\RequirePackage{epsfig}
\RequirePackage{ifthen}
\RequirePackage{xcolor}
\definecolor{slcolor}{HTML}{882B21}
%\RequirePackage{fontspec}
\DeclareGraphicsExtensions{.pdf}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}
\ProcessOptions
\LoadClass[letterpaper]{letter} % we always use letter paper


\newcommand{\subjectname}{\textbf{Subject}}
\newcommand{\@subject}{}
\newcommand{\subject}[1]{\renewcommand{\@subject}{\subjectname: #1}}


% check logo exists
\newboolean{logofound}
\IfFileExists{graphics/RegenerarLogo3.eps}
    {\setboolean{logofound}{true}}
    {\setboolean{logofound}{false}}


% margins
%\setlength{\textwidth}{6.875in}
%\setlength{\textheight}{7.25in}  % indirectly sets top/bottom margins
%\setlength{\topskip}{0.0in}
%\setlength{\footskip}{1.0in}
%\setlength{\oddsidemargin}{-0.25in}
%\setlength{\evensidemargin}{-0.25in}
%\setlength{\topmargin}{-0.875in}


% margins
\usepackage{geometry}
%\geometry{hmargin=20mm,vmargin=20mm,head=0ex,foot=3ex}
%\geometry{top=3cm,bottom=3cm,left=3.2cm,right=3.2cm,headsep=10pt}
%\geometry{scale=0.85}
\geometry{left=0.5in, right=0.5in, top=1in, bottom=2.0in}
%\geometry{margin=0.5in}



% font
\DeclareFixedFont{\xcmrbn}{OT1}{cmr}{b}{n}{10}
\DeclareFixedFont{\xcmrmn}{OT1}{cmr}{m}{n}{10}
\DeclareFixedFont{\ixcmrmn}{OT1}{cmr}{m}{n}{9}


% boxes
% ------------PARBOXES -----------------------------------------
%\parbox[position][height][inner-pos]{width}{text}

% The \parbox has two mandatory arguments:
%     width - specifies the width of the parbox, and
%     text - the text that goes inside the parbox. 
% LaTeX will position a parbox so its center lines up with the center of the text line. 
% optional position argument ==> allows you to line up either the top or bottom line in the parbox (default is top).
% optional height argument ==> if is not given, the box will have the natural height of the text.
% optional inner-pos argument ==> controls the placement of the text inside the box. If not specified, position is used.
%     t -- text is placed at the top of the box.
%     c -- text is centred in the box.
%     b -- text is placed at the bottom of the box.
%---------------------------------------------------------------


\newsavebox{\departmenthead}
\newsavebox{\emptyfoot}
%\newsavebox{\departmentfoot}


\savebox{\departmenthead}{
    \begin{tabular*}{\textwidth}
                    {@{}l@{\extracolsep{0.0in}}|@{\extracolsep{0.125in}}l@{}}           

% Logo (in header; left)
    \parbox{4.0in}{\raggedright
        \ifthenelse{\boolean{logofound}}
           {\epsfig{file=graphics/RegenerarLogo3.eps, width=4.0in}}
           {\parbox[t][1.0in][t]{2.0in}{\hfill} 
            \ClassWarning{Regenerarletter}{RegenerarLogo3.eps COULD NOT BE FOUND!}}
    } &
% Lema and address (in header; right of the logo)
    \parbox[t][1.4in][t]{2.125in}{{~}\\
}\\
    \end{tabular*}
}

\savebox{\emptyfoot}[\textwidth][c]{\ixcmrmn
    \hspace*{\textwidth}
}



% header; placed only on the first page (no footer)
\renewcommand{\ps@firstpage}{
    \setlength{\headheight}{1.375in}
    \setlength{\headsep}{1.0in}
    \renewcommand{\@oddhead}{\usebox{\departmenthead}}
    \renewcommand{\@oddfoot}{}
    %\renewcommand{\@oddfoot}{\usebox{\departmentfoot}}
    \renewcommand{\@evenhead}{}
    \renewcommand{\@evenfoot}{}
}

\renewcommand{\ps@empty}{
    \setlength{\headheight}{1.375in}
    \setlength{\headsep}{0.5in}
    \renewcommand{\@oddhead}{}
    \renewcommand{\@oddfoot}{\usebox{\emptyfoot}}
    \renewcommand{\@evenhead}{}
    \renewcommand{\@evenfoot}{\usebox{\emptyfoot}}
}

\providecommand{\@evenhead}{}
\providecommand{\@oddhead}{}
\providecommand{\@evenfoot}{}
\providecommand{\@oddfoot}{}

\pagestyle{empty}


% opening; add the subject command
\renewcommand{\opening}[1]{\thispagestyle{firstpage}%
    \ifx\@empty\fromaddress
        %{\raggedleft\@date\par}%
    \else  % home address
        {\raggedleft
            \begin{tabular}{l@{}}\ignorespaces
            \fromaddress \\ *[1\parskip]%
            %\@date
            \end{tabular}\par
        }%
     \fi
     \vspace{-6\parskip}
     \@date \vspace{2\parskip}\\
     {\raggedright \toname \\ \toaddress \par}%
     \vspace{1\parskip}%
     \ifthenelse{\equal{\@subject}{}}{}{\@subject\par}
     \vspace{1\parskip}%
     #1\par\nobreak
}

% closing; push to the right
\renewcommand{\closing}[1]{\par\nobreak\vspace{\parskip}%
    \stopbreaks
    \noindent
    \parbox{0.4\textwidth}{\raggedright
    %\hspace*{0.5\textwidth}\parbox{0.4\textwidth}{\raggedright
    \ignorespaces #1\\[4\medskipamount]%
    \ifx\@empty\fromsig
        \fromname
    \else \fromsig 
    \fi\strut}%
    \par
}
