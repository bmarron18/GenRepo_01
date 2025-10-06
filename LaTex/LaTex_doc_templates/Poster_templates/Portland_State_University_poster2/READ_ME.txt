
	---- the psuposter.cls file -----------


	# the original Cambridge University poster obtained from:

www.sharelatex.com/templates/presentations/cambridge-university-poster


	a.
	# Portland State poster uses: \documentclass[noback]{psuposter}
	# the set up for this documentclass is included in the psuposter.cls file
	# the psuposter.cls is placed where LaTex can find it:

$ sudo cp psuposter.cls /usr/local/share/texmf/tex/latex/


	b.
	# the original logo / icon
	# from cuposter.cls

Lines 320 - 329
  % EU shield
  \if@postershield
    \rput(\shieldoffset,-1.7in){
      %%SJE: add Cambridge Shield.
      %% \resizebox{5in}{!}{\includeshield}
      %% CUnibig downloaded from
      %% http://www.cam.ac.uk/localusersonly/cambuniv/docstyle/
      \includegraphics[width=20cm]{CUnibig.eps}
    }%
  \fi  


	c.
	# changing the logo / icon
	#went to www.pdx.edu/university-communications/download-psu-logo
	#color logo For Word Processing and Presentation Software
	# open in GIMP
	# export (no changes!) to .eps
	# place psulogo_horiz_msword.eps in same folder as psuposter.tex
	#change in psuposter.cls file
	

Lines 320 - 327
   % EU shield
  \if@postershield
    \rput(\shieldoffset,-1.7in){
    %% bmarron: change to PSU logo
     %% see READ_ME.txt for how to get this
      \includegraphics[width=20cm]{psulogo_horiz_msword.eps}
    }%
  \fi  
  



	d.
	# must run LaTex ==> DVI ==> pdf in LaTexilla



