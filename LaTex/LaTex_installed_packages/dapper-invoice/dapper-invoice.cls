% dapper-invoice.cls -- a billable-hours invoice featuring style over substance

\ProvidesClass{dapper-invoice}[2015/04/12]
\NeedsTeXFormat{LaTeX2e}
\LoadClass[11pt]{article}

% For page number calculations
\RequirePackage{ifthen}

% To handle key=value options in class definition
\RequirePackage{kvoptions}
\SetupKeyvalOptions{%
    prefix=dapper@
}
% Default currency option is "dollar"
\DeclareStringOption[dollar]{currency}[dollar]
\ProcessKeyvalOptions*

\RequirePackage{eurosym}

\ifthenelse{\equal{\dapper@currency}{dollar}}{\newcommand{\currencysym}{\$}}{}
\ifthenelse{\equal{\dapper@currency}{euro}}{\newcommand{\currencysym}{\euro}}{}
\ifthenelse{\equal{\dapper@currency}{pound}}{\newcommand{\currencysym}{\textsterling}}{}

% Set the standard geometry
\RequirePackage[hmargin=.75in,vmargin=1in]{geometry}

% For links and metadata
\RequirePackage[hidelinks]{hyperref}

% For adjusting letter spacing
\RequirePackage{soul}

% For "At*" hooks
\RequirePackage{etoolbox}

% For adjusting footer
\RequirePackage{fancyhdr}

% For tables
\RequirePackage{longtable}

% Caluclating due date
\RequirePackage{datenumber}

% Drawing the arrow
\RequirePackage{tikz}
\usetikzlibrary{calc}
\usetikzlibrary{fpu}

% For invoice math
\RequirePackage{fp}

% Customizing lists
\RequirePackage{enumitem}

% Formatting numbers
\RequirePackage{siunitx}
\sisetup{round-integer-to-decimal, group-separator={,}}

\RequirePackage{fontspec}

\defaultfontfeatures{
    Ligatures = TeX,
    Path      = ./Fonts/ }

\IfFileExists{./Fonts/OpenSans-Regular.ttf}{
    \setmainfont[ BoldFont = OpenSans-Bold, ItalicFont = OpenSans-Italic ]{OpenSans-Regular}
    \setsansfont[ BoldFont = OpenSans-Bold, ItalicFont = OpenSans-Italic ]{OpenSans-Regular}
}{}

%quality graphic import
\RequirePackage{epsfig}




%%%%% Styles %%%%%

\RequirePackage{xcolor}
\definecolor{highlightColor}{rgb}{0.22,0.45,0.70}% light blue
\definecolor{subduedColor}{rgb}{0.45,0.45,0.45}% dark grey
\definecolor{color1}{HTML}{000060}
\definecolor{color2}{HTML}{333333}
\definecolor{ocre}{RGB}{51,102,0} 
\definecolor{lightgray}{RGB}{229,229,229}
%\definecolor{color1}{HTML}{8C260F}
%\definecolor{darkgreen}{rgb}{0.0, 0.2, 0.13}
%\definecolor{darkgreen}{rgb}{0,0.15,0}
%\definecolor{calpolypomonagreen}{rgb}{0.12, 0.3, 0.17}
%\definecolor{chromeyellow}{rgb}{1.0, 0.65, 0.0}
%\definecolor{osuorange}{cmyk}{.1197,.9474,1,0.0309}

\def\headerStyle{\Huge}
\def\titleStyle{\color{color1}}

% Add page numbers
\fancypagestyle{plain}{
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  \fancyhf{}}
% page numbers in footer if more than 1 page
% Copied from moderncv
\AtEndPreamble{%
    \AtBeginDocument{%
        \@ifundefined{r@lastpage}{}{%
            \ifthenelse{\pageref{lastpage}>1}{%
                \newlength{\pagenumberwidth}%
                \settowidth{\pagenumberwidth}{\thepage/\pageref{lastpage}}%
                \fancypagestyle{plain}{%
                    \fancyfoot[r]{\parbox[b]{\pagenumberwidth}{\thepage/\pageref{lastpage}}}%
                }%
                \pagestyle{plain}%
            }{}%
        }%
        \AtEndDocument{\label{lastpage}}%
    }%
}
\pagestyle{plain}

% Disable paragraph indent
\setlength{\parindent}{0pt}



%%%%% Commands %%%%%

\newcommand*{\setmetadata}[4]{
    \hypersetup{
        bookmarksopen  = false,
        bookmarksdepth = 2,% to show sections and subsections
        pdfauthor      = {#1},
        pdftitle       = {#2 --- Invoice \##3 for #4},
        pdfsubject     = {Invoice \##3},
        pdfkeywords    = {invoice, #2, #4}
    }
}

\newcommand*{\twocolumnlayout}[2]{
    \begin{tabular}[t]{@{} p{.5\linewidth} @{} p{.5\linewidth} @{}} #1 & #2 \end{tabular}
}

\sodef\invoiceSpacing{}{.15em}{.4em}{.4em}
\newcommand*{\makeheader}[2]{
    \begin{minipage}[t]{.6\linewidth} {\headerStyle #1} \end{minipage}
    \hfill
    \begin{tabular}[t]{@{} c @{}}
        {\headerStyle \invoiceSpacing{INVOICE} \##2} \\
        {\color{ocre} \today}
    \end{tabular}

    \addvspace{8ex}
}

\newcommand*{\duedate}[1]{%
    \setdatetoday%
    \addtocounter{datenumber}{#1}%
    \setdatebynumber{\thedatenumber}%
    \datedate%
}

\newcommand*{\infoSectionStyle}{\hspace{2em}}
\newcommand*{\infoSubStyle}{\small\slshape}

\newenvironment{infoSection}{\infoSectionStyle \tabular[t]{@{} r @{\hspace{0.5em}} l}}{\endtabular}
\newcommand{\infoBox}[2]{
    {\titleStyle #1} & \begin{minipage}[t]{.35\textwidth} #2 \end{minipage} \\
    \noalign{\addvspace{2ex}}
}
\newcommand{\infoSub}[2]{
    \noalign{\vspace{-1.8ex}}
    {\color{ocre} #1} & \begin{minipage}[t]{.35\textwidth} \infoSubStyle #2 \end{minipage} \\
    \noalign{\addvspace{2ex}}
}

\newcommand{\emaillink}[1]{%
    \href{mailto:#1}{#1}%
}

\newcommand*{\itemizationRowStyle}[0]{\small}
\newcommand*{\itemizationHeaderStyle}[0]{\normalsize\color{color1}}

\newcounter{colskipcount}

% longtable 1
\newenvironment{hoursItemization}{
    \setcounter{colskipcount}{5}
    \setlength\LTleft{0pt}
    \setlength\LTright{0pt}
    \begin{longtable}{c @{\hspace{1.5em}} p{.6\textwidth} r @{} l r r}
    \hline
    \noalign{\smallskip}
    {\itemizationHeaderStyle Date} &
    {\itemizationHeaderStyle Description} &
    \multicolumn{2}{l}{\itemizationHeaderStyle Hours} &
    {\itemizationHeaderStyle Rate} &
    {\itemizationHeaderStyle Amount}
    \\
    \noalign{\smallskip}
    \hline
    \noalign{\bigskip}
    \endhead
    \noalign{\bigskip}
    \hline
    \endfoot
    \endlastfoot
}{
    \end{longtable}
}

% longtable 2
\newenvironment{hoursItemizationWithTask}{
    \setcounter{colskipcount}{6}
    \setlength\LTleft{0pt}
    \setlength\LTright{0pt}
    \begin{longtable}{l c @{\hspace{1.5em}} p{.45\textwidth} r l l l}
%    \begin{longtable}{l c r l l l}
    \hline
    \noalign{\smallskip}
    {\itemizationHeaderStyle Date} &
    {\itemizationHeaderStyle Task} &
    {\itemizationHeaderStyle Description} &
%   \multicolumn{2}{l}{\itemizationHeaderStyle Hours} &
    {\itemizationHeaderStyle Hours} &
    {\itemizationHeaderStyle Rate} &
    {\itemizationHeaderStyle Amount}
    \\
    \noalign{\smallskip}
    \hline
    \noalign{\bigskip}
    \endhead
    \noalign{\bigskip}
    \hline
    \endfoot
    \endlastfoot
}{
    \end{longtable}
}



\gdef\InvoiceTotal{0}

\newcommand*{\calcamount}[2]{%
    \FPmul\t{#1}{#2}%
    \formatcurrency{\t}%
%
    \FPadd\gt{\InvoiceTotal}{\t}%
    \global\let\InvoiceTotal\gt%
}

\newcommand{\lineitemp}[5]{
    {\itemizationRowStyle #1} &
    {\itemizationRowStyle #2} &
%    \begin{minipage}[t]{0.5\textwidth}
%        \begin{itemize}[leftmargin=0pt, labelsep=1pt, itemsep=0pt] \itemizationRowStyle #5 \end{itemize}
%    \end{minipage} &
%    {\itemizationRowStyle \@formatHoursLeft{#2}} &
%    {\itemizationRowStyle \@formatHoursRight{#2}} &
    {\itemizationRowStyle #5} &
    {\itemizationRowStyle #3} &
    {\itemizationRowStyle \currencysym #4} &
    {\itemizationRowStyle \currencysym\calcamount{#3}{#4}}
    \\
    \noalign{\medskip}
}

\newcommand{\beginsummary}{
    \noalign{\bigskip}
    \hline
    \noalign{\medskip}
}

\newcommand*{\summaryline}[2]{
    \multicolumn{\thecolskipcount}{r}{\itemizationHeaderStyle #1} & #2 \\
}



%\newcommand*\@formatFraction[1]{
%    \ifnum\Numerator=25 ¼\fi%
%    \ifnum\Numerator=50 ½\fi%
%    \ifnum\Numerator=75 ¾\fi%
%}

%\newcommand*\@formatHoursLeft[1]{
%    \pgfmathtruncatemacro{\WholePortion}{int(#1)}%
%   \pgfmathtruncatemacro{\Numerator}{100*(#1-\WholePortion)}%
%   \ifnum\WholePortion=0%
%       \@formatFraction{\Numerator}%
%   \else%
%       \WholePortion%
%   \fi%
%}

%\newcommand*\@formatHoursRight[1]{
%    \pgfmathtruncatemacro{\WholePortion}{int(#1)}%
%    \pgfmathtruncatemacro{\Numerator}{100*(#1-\WholePortion)}%
%    \ifnum\WholePortion=0%
%    \else%
%        \@formatFraction{\Numerator}%
%    \fi%
%}




%\newcommand{\lineitem}[4]{
%    {\itemizationRowStyle #1} &
%    \begin{minipage}[t]{.6\textwidth}
%        \begin{itemize}[leftmargin=0pt, labelsep=1pt, itemsep=0pt] \itemizationRowStyle #4 \end{itemize}
%    \end{minipage} &
%    {\itemizationRowStyle \@formatHoursLeft{#2}} &
%    {\itemizationRowStyle \@formatHoursRight{#2}} &
%    {\itemizationRowStyle \currencysym#3} &
%    {\itemizationRowStyle \currencysym\calcamount{#2}{#3}}
%    \\
%    \noalign{\medskip}
%}


\newcommand*{\tikzmark}[1]{\tikz[overlay,remember picture] \node ({#1}) {};}
\newcommand*{\arrowbase}{\tikzmark{@p1}}
\newcommand*{\arrowtarget}{\tikzmark{@p2}}
\newcommand*{\drawarrow}{
    \tikz[overlay,remember picture] {
        \draw[->,thick,color=ocre] ($(@p1)+(0.75em,1.5ex)$) -| ($(@p2)+(-2em,0.7ex)$) -- ($(@p2)+(-0.5em,0.7ex)$);
    }
}

\newcommand*{\formatcurrency}[1]{%
    \num[group-separator={,}, group-minimum-digits=3, round-mode=places, round-precision=2]{#1}%
}

% Implementation by Werner (http://tex.stackexchange.com/a/176815/35707)
\newcommand*{\dectofrac}[1]{\begingroup%
  \pgfkeys{/pgf/number format/frac}% Format as fraction
  \let\frac\sfrac% Let \frac act like \sfrac
  \pgfmathprintnumber{#1}\endgroup}

% Debugging
\newcommand{\showbb}[1]{{\color{red!50}\leavevmode\rlap{\fbox{\phantom{#1}}}}#1}


