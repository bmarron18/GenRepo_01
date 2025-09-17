%-----------------------------------------------------------------------------
% Beginning of README-QAM-L.TXT
%-----------------------------------------------------------------------------

                    AMERICAN MATHEMATICAL SOCIETY
                          201 Charles Street
                   Providence, RI  02904-2294  USA


JOURNAL STYLE PACKAGE FOR QAM
-----------------------------

This package contains files to help authors use AMS-LaTeX to prepare a
journal article for publication in the Quarterly of Applied Mathematics
(QAM).  We assume that the following software is installed on your system.

    LaTeX           version 2e, December 1995 or later
    AMS-LaTeX       version 2.20, August 2004 or later
    AMSFonts        version 2.0, January 1995 or later

If you have an older version of LaTeX or AMS-LaTeX, please upgrade,  You
can retrieve the current version of AMS-LaTeX from the AMS web server at

    http://www.ams.org/tex/amslatex.html

We also assume that you are familiar with LaTeX and AMS-LaTeX document
structuring commands such as \section, \footnote, \newtheorem, etc., and
with the techniques for inputting math expressions.

1) This package contains the following files.

general files

    README-QAM-L.TXT       overview of journal package (this file)
    instr-l.pdf            Instructions
    handbk.pdf             AMS Author Handbook
    creating-graphics.pdf  Creating graphics for use in books and journals

QAM-specific files

    qam-l.cls           document class file
    qam-l-template.tex  journal article template

sample article file

    journal.tex         journal sample article

2) Start your article by making a copy of the template to <uniquename>.tex,
using a distinct name (perhaps your last name) in place of <uniquename>.
Fill in the top matter (title, author(s), etc.) following the instructions
that appear as comments in the file.  Input the text of the article
between \begin{document} and \end{document}.

3) More detailed instructions are given in the files instr-l.pdf and
handbk.pdf.  These manuals are also available via the web from
     ftp://ftp.ams.org/pub/author-info/documentation/amslatex/instr-l.pdf
and  ftp://ftp.ams.org/pub/author-info/documentation/handbk.pdf
respectively.  The handbook includes a checklist to be consulted, before
keyboarding your manuscript, in order to avoid the most common problems,
and detailed instructions for submitting your files to the AMS.

4) If your article will contain graphics, print out, or view on screen,
the file creating-graphics.pdf and read it.  This file contains general
and specific guidelines for preparation of graphics (line art,
photographs, and other forms of illustrations) in a manner that will
ensure their accurate reproduction in print and on-line.

5) By default, the "sample article file" listed above uses the basic AMS
journal article style, amsart.cls.

Replace the \documentclass{amsart} line in the sample article file by
\documentclass{qam-l} and then LaTeX the file, in order to view the
printed style for QAM.

Do NOT use the sample article as a "starter" for your article.  Use
the template file instead.  The sample article should be used only for
your reference.

6) Various technical and administrative information can be found in the
AMS Author FAQ:
    http://www.ams.org/authors/author-faq.html
This document contains information on various topics that have been the
subject of questions to our Technical Support Group, as well as links
to other useful web pages, including the page with instructions for
submitting files when your article is ready.


Should you have any technical questions that aren't answered by the FAQ,
please contact our Technical Support Group.  The most effective method
is to send electronic mail to tech-support@ams.org, including a concise
statement of the problem, along with (if appropriate) a brief file that
illustrates the problem and the log of your attempt to LaTeX the file.
If e-mail is not an option, you can call 800-321-4AMS (800-321-4267,
in the U.S. or Canada) or 401-455-4080, or write to Technical Support,
Publications Technical Group, AMS, 201 Charles Street, Providence,
RI 02904-2294.

[2011/07/05, readme-qam-l.txt]
%-----------------------------------------------------------------------
% End of README-QAM-L.TXT
%-----------------------------------------------------------------------
