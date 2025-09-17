patches-own [
  state
  next-state
]

globals [
  colors
  stateLabels
  constSList constKList
  support-factor parasite-state
  decay-rate                      ;; the probability a state will be converted to state 0
  ticks
  cnt-parasites
  movie-dir movie
]




;; for internal testing purposes
;; you can ignore this procedure.
to test
    locals [
      p
    ]
    
    if false [
      ask patches [set next-state 0]
      ask patches [set-patchs-next-state]
    
      set p patch 0 0
    
      ask p [ set state 0]
      ask p [ ask patch-at  0  0 [set next-state 1] ]
      ask p [ ask patch-at  1  0 [set next-state 2] ]
      ask p [ ask patch-at  0  1 [set next-state 3] ]
      ask p [ ask patch-at  1  1 [set next-state 4] ]
      ask patches [set-patchs-next-state]    
      show p
      show "-------"

      turn 0 0
      
      ask p [ ask patch-at  0  0 [set pcolor item state colors] ]
      ask p [ ask patch-at  1  0 [set pcolor item state colors] ]
      ask p [ ask patch-at  0  1 [set pcolor item state colors] ]
      ask p [ ask patch-at  1  1 [set pcolor item state colors] ]
      display
    ]

    if true [
      ask patches [set next-state 0]
      ask patches [set-patchs-next-state]
    
      set p patch 0 0
    
      ask p [ set state 0]
      ask p [ ask patch-at  0  1 [set next-state 1] ]
      ask p [ ask patch-at  1  1 [set next-state 0] ]
      ask p [ ask patch-at  1  0 [set next-state 3] ]
      ask p [ ask patch-at  1 -1 [set next-state 4] ]
      ask p [ ask patch-at  0 -1 [set next-state 5] ]
      ask p [ ask patch-at -1 -1 [set next-state 6] ]
      ask p [ ask patch-at -1  0 [set next-state 7] ]
      ask p [ ask patch-at -1  1 [set next-state 8] ]
      ask patches [set-patchs-next-state]    
      display
      ask p [compute-patchs-next-state]
      ask patches [set-patchs-next-state]    
      show "-----"
      
      repeat 100 [
        ask patches [set next-state state]
        patch-diffuse
        ask patches [set-patchs-next-state]
        ;ask patches [set pcolor item state colors]    
      ]
    ]


    if false [
      ask patches [set next-state 0]
      ask patches [set-patchs-next-state]
    
      set p patch 0 0
    
      ask p [ set state 0]
      ask p [ ask patch-at -1  0 [set next-state 1] ]
      ask p [ ask patch-at  1  0 [set next-state 2] ]
      ask p [ ask patch-at  0 -1 [set next-state 3] ]
      ask p [ ask patch-at  0  1 [set next-state 4] ]
      ask patches [set-patchs-next-state]    
      show p
      show "-------"

      ;;ask p [compute-patchs-next-state]
    ]
    
    if false [
      repeat 1000 [
        ask random-one-of patches [ set pcolor white
        ]
      ]
    ]
end


to setup
  locals [
    x y
    p00 p01 p10 p11
    temp index
    cnt
  ]
  
  
  ca
  set decay-rate decay
  set support-factor 100
  set parasite-state 1
  set stateLabels ["0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "10"]
  set colors [black red green blue yellow turquoise 6 violet magenta 62 brown]
  set constSList [0 1 1 1 1 1 1 1 1 1 1]
  
    ;; this initialization is for demonstration purposes. This table will be computed by the settings
    ;; of the sliders. This initialization demonstrates how the table will be setup for hc-states = 0
    ;; and no parasites.
  set constKList [
      [0 0 0 0 0 0 0 0 0 0 0]      ;; state 0 (black) will be supported by noone
      [0 0 0 0 0 0 0 0 0 0 100]    ;; state 1 will be supported by state 10 with factor 100
      [0 100 0 0 0 0 0 0 0 0 0]    ;; state 2 will be supported by state 1 with factor 100
      [0 0 100 0 0 0 0 0 0 0 0]    ;; state 3 will be supported by state 2 with factor 100
      [0 0 0 100 0 0 0 0 0 0 0]    ;; state 4 will be supported by state 3 with factor 100
      [0 0 0 0 100 0 0 0 0 0 0]    ;; state 5 will be supported by state 4 with factor 100
      [0 0 0 0 0 100 0 0 0 0 0]    ;; state 6 will be supported by state 5 with factor 100
      [0 0 0 0 0 0 100 0 0 0 0]    ;; state 7 will be supported by state 6 with factor 100
      [0 0 0 0 0 0 0 100 0 0 0]    ;; state 8 will be supported by state 7 with factor 100
      [0 0 0 0 0 0 0 0 100 0 0]    ;; state 9 will be supported by state 8 with factor 100
      [0 0 0 0 0 0 0 0 0 100 0]    ;; state 10 will be supported by state 9 with factor 100
  ]

    ;; this initialization is for demonstration purposes. This table will be computed by the settings
    ;; of the sliders. This initialization demonstrates how the table will be setup for hc-states = 0
    ;; parasites and the support-factor-parasite of 2.0.
  set constKList [
      [0 0 0 0 0 0 0 0 0 0 0]      ;; state 0 (black) will be supported by noone
      [0 0 0 0 0 0 0 0 0 0 200]    ;; state 1 (parasite) will be supported by state 10 with factor 200
      [0 0 0 0 0 0 0 0 0 0 100]    ;; state 2 will be supported by state 10 with factor 100
      [0 0 100 0 0 0 0 0 0 0 0]    ;; state 3 will be supported by state 2 with factor 100
      [0 0 0 100 0 0 0 0 0 0 0]    ;; state 4 will be supported by state 3 with factor 100
      [0 0 0 0 100 0 0 0 0 0 0]    ;; state 5 will be supported by state 4 with factor 100
      [0 0 0 0 0 100 0 0 0 0 0]    ;; state 6 will be supported by state 5 with factor 100
      [0 0 0 0 0 0 100 0 0 0 0]    ;; state 7 will be supported by state 6 with factor 100
      [0 0 0 0 0 0 0 100 0 0 0]    ;; state 8 will be supported by state 7 with factor 100
      [0 0 0 0 0 0 0 0 100 0 0]    ;; state 9 will be supported by state 8 with factor 100
      [0 0 0 0 0 0 0 0 0 100 0]    ;; state 10 will be supported by state 9 with factor 100
  ]
  
  ;; recompute constKList due to settings of hc-state
  
  ;; first building a list of needed length and filled with 0
  set temp []
  repeat hc-states + 1 [
    set temp fput 0 temp
  ]
  
  
  set constKList []
  set constKList lput temp constKList                    ;; state 0, will not be supported by anyone
  
  ;; set the support factor for the first state.
  ;; if it is a parasite choose the appropiate factor
  ;; state 1 will always be supported by the last state
  set temp replace-item hc-states temp support-factor    ;; set the usual support factor
  if Parasites [                                         ;; replace it if a parasite is in the hypercycle
    set temp replace-item hc-states temp (support-factor-parasite * support-factor)
  ]
  set constKList lput temp constKList                    ;; state 1 will be supported by the last state
  set index 0                                            ;; set index for computing state 2 
  
  set cnt hc-states - 1                                  ;; the next states will be constructed hc-states-1 times using the loop
  if Parasites [                                         ;; but if we have a parasite in the hypercycle
    set temp replace-item hc-states temp support-factor  ;; state 2 will be supported by the last state
    set constKList lput temp constKList                  ;; add the support for state 2
    set cnt cnt - 1                                      ;; one loop less because we have computed state 2
    set index index + 1                                  ;; we have already computed a state so inkrement the index
  ]

  set temp replace-item hc-states temp 0                 ;; set the support factor of the last state to 0
  
  ;; compute state 2 (state 3 if parasite present) and following
  repeat cnt [
    set temp replace-item index temp 0
    set index index + 1
    set temp replace-item index temp support-factor
    set constKList lput temp constKList
  ]
  
  show constKList
  
  set ticks 0
  set movie false
  movie-end
  display
  
    
  ;; setting up the patches according to the sliders and
  ;; switches
  ask patches [
    set next-state 0
    if (random 2) > 0 [
      ifelse Parasites [
        set next-state (random (hc-states - 1)) + parasite-state + 1
      ][
        set next-state (random hc-states) + 1
      ]
    ]
  ]

  ;; ask the patches to accept the new state
  ;; values
  ask patches [
    set-patchs-next-state
  ]
  
  do-plot
end


  ;; plotting the diagram
to do-plot
  locals [
    index
    cnt
  ]
  
  ;; choose the diagram
  set-current-plot "count states"
  set-current-plot-pen item 0 stateLabels
  set-plot-pen-color item 0 colors
  
  ;; Plot the black patches (state 0). Because the state 0 (unused patches) is the dominant
  ;; state the plotting will be adjusted to the number of used hc-states in this model.
  plot round (count patches with [state = index] / hc-states)
  
  ;; Plot the rest of the states.
  set index 1
  repeat hc-states [
    set-current-plot-pen item index stateLabels
    set-plot-pen-color item index colors
    set cnt count patches with [state = index]
    plot cnt
    
    ;; Update the parasite count.
    if Parasites [
      if index = parasite-state [
        set cnt-parasites cnt
      ]
    ]
    
    set index index + 1
  ]
end





  ;; set the current state
to set-patchs-next-state
  set state next-state
  set pcolor item state colors
end



  ;; compute the next state of all patches
to compute-patchs-next-state
  locals [
    p
    s state-list temp-states choose-state
    support support-list
    kvalues
    index si i
    sumValues prob-list prob-interval prob
    r l
  ]

  ;; if this patch is empty (state 0) compute the probability of the next state. The probability is
  ;; given by the surrounding patches and their states.
  ifelse state = 0 [
    ;; setup list with the 8 neighbours states
    set state-list []
    set support-list []

    
    ;; patch North
    set p patch-at  0  1
    set state-list lput state-of p state-list

    ;; patch North/West
    set p patch-at  1  1
    set state-list lput state-of p state-list
    
    ;; patch West
    set p patch-at  1  0
    set state-list lput state-of p state-list   

    ;; patch West/South -> South/West
    set p patch-at  1  -1
    set state-list lput state-of p state-list   

    ;; patch South
    set p patch-at  0 -1
    set state-list lput state-of p state-list

    ;; patch South/East
    set p patch-at  -1 -1
    set state-list lput state-of p state-list
        
    ;; patch East
    set p patch-at -1  0
    set state-list lput state-of p state-list
        
    ;; patch East/North -> North/East
    set p patch-at -1  1
    set state-list lput state-of p state-list
    
    ;; now the states of all surrounding neigbours are stored in a state-list. The neighbours states
    ;; 8 1 2
    ;; 7 x 3
    ;; 6 5 4
    ;; will result in a list [1 2 3 4 5 6 7 8]
    
    ;; extend the list on both sides by two elements
    ;; to make this list quasi-cyclic
    set temp-states state-list
    set state-list fput (item 7 temp-states) state-list 
    set state-list fput (item 6 temp-states) state-list
    set state-list lput (item 0 temp-states) state-list
    set state-list lput (item 1 temp-states) state-list
    
    ;; now the list contains the states (referring to the example)
    ;; [7 8 1 2 3 4 5 6 7 8 1 2]
    
        
        
;    show plist
;    show state-list
    
    
    ;; state-list:    List of all states of the neighbours (excluding myself) in the order
    ;;                East NorthEast  North NorthWest West SouthWest South SouthEast East NorthEast  North NorthWest
    ;;
    ;; support-list:  List with the computed abilities for each neighbour to reproduce into
    ;;                an empty patch (state 0)
    ;;
    ;; p:             temporary patch variable
    ;;
    ;; s:             temporary state variable of p
    ;;
    ;; temp-states:   Temporary list with states. In this list every loop one of the neighbours (the
    ;;                current one) will be removed.
    ;;
    ;; kvalues:       Support values for the current neighbour
    ;;
    ;; support:       The abilities of a neighbour to fill an empty patch (state 0)
    ;;

    
    
    set support-list []
    set choose-state []
    set si 2                                      ;; Access index for states. Starts with 2 due to quasi cyclic list to start north
    repeat 4 [                                    ;; four neighbours (north, west, south, east)      
      set s item si state-list                    ;; get the state of the current neighbour
      
      ;; the current state has a certain probability to reproduce itself. The probability
      ;; is computed by the reproduction rate, stored in constSList, and the support of the
      ;; surrounding states. Which state supports the current state by which value is stored
      ;; in constKList
  
      set choose-state lput s choose-state        ;; add the state for the list of chooseable states for the current patch
      set support item s constSList               ;; get the support factor for reproducing itself
      set s item (item si state-list) constKList  ;; get the support activity by other states for the current state
      
      ;; Now compute the support of the neighbours for this state.
      set i -2
      repeat 5 [
        set support (support + item (item (si + i) state-list) s)
        set i (i + 1)
      ]
      
      
      ;; Append computed value to the end of the list of all support values.
      set support-list lput support support-list
      
      set si (si + 2)
    ]
    
    
    ;; set the state-list to the chooseable states
    set state-list choose-state
    
    ;; now all abilities for every neighbour to fill an empty patch are computed
    ;; compute now the probabilities for all neighbours to be choosen to fill an
    ;; empty patch or the patch stayes empty
    
    set support-list fput 11 support-list    ;; the support value an empty patch remains empty
    set state-list fput 0 state-list         ;; store the empty state (=0) in the list of possible states
    
    set sumValues sum support-list           ;; summarize all support values
    
    ;; compute the probability a state in this prob-list is choosen
    set prob-list []
    set index 0
    foreach support-list [
      set prob-list lput ((item index support-list) / sumValues) prob-list
      set index index + 1
    ]
;  show prob-list
    
    ;; compute the probability interval
    set prob-interval []                          ;; empty list
    set prob 0
    foreach prob-list [
      set prob prob + ?
      set prob-interval lput prob prob-interval
    ]
    set prob-interval but-last prob-interval      ;; remove the last entry (should be 1.0) but due to
                                                  ;; floating point arithmetik you can't be sure
    set prob-interval lput 1.0 prob-interval      ;; add 1.0 as the upper limit
  
    set r random-float 1                          ;; choose a random number [0..1[
    
    ;; find the probability intervall this random number fits in
    ;; the interval correponds to the probability a state is chosen
    set index 0
    set  l item index prob-interval
    while [r > l] [
      set index index + 1
      set  l item index prob-interval
    ]
    
    
    set next-state item index state-list
  ]
  [
    ;; This patch is not empty. Compute the probability the patch will be empty.
    if (random-float 1) < decay-rate [
      set next-state 0
    ]
  ]
end

  ;; randomly add parasites
to do-add-parasites
  ifelse Parasites [
    repeat add-parasites [
      ask random-one-of patches [
        set next-state parasite-state
        set-patchs-next-state  
      ]
    ]
    
    do-plot
  ] [
    user-message "Please turn on the parasites feature first."
  ]
  
end


to go
  ;; run the model      
  one-cycle
end


to movie-setup
  set movie false
  movie-end

  ;; prompt user for movie location
  set movie-dir user-choose-directory  
  if not is-string? movie-dir [ stop ]  ;; stop if user canceled
  set-current-directory movie-dir
  

  movie-start "capture.mov"
  no-display
  set movie true
end

to movie-end
  ifelse movie [
    ifelse movie-status != "No movie." [
    ;; export the movie
    movie-close
    print "Exported movie to " + movie-dir
    ][
      user-message "Movie contained no frames and will not be saved."
    ]
    set movie false
  ] [
    if movie-status != "No movie." [
      show "movie-status: " + movie-status
      user-message "After releasing this dialog the current movie will be saved as 'capture.mov' and will overwrite any existing file."
      movie-close 
    ]
  ]
end


to go-for
  repeat cycles [
    go
  ]
end


to one-cycle  
  without-interruption [    
    ask patches [
      compute-patchs-next-state
    ]

    patch-diffuse

    ask patches [
      set-patchs-next-state
    ]
  ]
  
  set ticks ticks + 1
  
  do-plot
  if movie [
    movie-grab-graphics  
  ]
  
  ifelse frame-skip > 0 [
    if ticks mod frame-skip = 0 [
      display
    ]
    no-display
  ][
    display
  ]
end







  ;; diffuse a 2x2 block clockwise or counter-clockwise
  ;;
  ;; The block  12  will be to 41    and the block 12  will be to  23
  ;;            43             32                  43              14
  ;; this a procedure published by Toffoli and Margolus to simulate the diffusion in
  ;; a gas. The 2x2 blocks will be turned by random in one direction. Usually a second
  ;; run will be done but this time with a offet of one to the previous run so a 2x2 block
  ;; shifted by one in each direction patch will be choosen.
  
to turn [x y]
  locals [
    p00 p01 p10 p11
    h-state
  ]
  ;;show "turn: " + x + " " + y
  set p00 patch-at x y
  set p01 patch-at (x + 1) y
  set p10 patch-at x (y + 1)
  set p11 patch-at (x + 1) (y + 1)
  
  ifelse (random 2) > 0 [
    ;; turn patches clockwise
    ;; show "clockwise"
    
    set h-state next-state-of p00
    set next-state-of p00 next-state-of p01
    set next-state-of p01 next-state-of p11
    set next-state-of p11 next-state-of p10
    set next-state-of p10 h-state
  ] [
    ;; turn patches counter clockwise
    ;; show "counter clockwise"
    
    set h-state next-state-of p00
    set next-state-of p00 next-state-of p10
    set next-state-of p10 next-state-of p11
    set next-state-of p11 next-state-of p01
    set next-state-of p01 h-state
  ]
end


 ;; diffuse the patches by a double run (Toffoli and Margolus)
to patch-diffuse
  locals [
    x0 y0
    x y
    run-x run-y
  ]
  
  set x0 0 - screen-edge-x
  set y0 0 - screen-edge-y
  set run-x (screen-edge-x + 1)
  set run-y (screen-edge-y + 1)
  
  set y y0
  repeat run-y [
    set x y0
    repeat run-x [
      turn x y
      set x x + 2
    ]
    set y y + 2
  ]
  
  set y0 y0 + 1
  set x0 x0 + 1
  set y y0
  repeat run-y [
    set x y0
    repeat run-x [
      turn x y
      set x x + 2
    ]
    set y y + 2
  ]
end

@#$#@#$#@
GRAPHICS-WINDOW
596
10
1007
442
200
200
1.0
1
10
1
1
1
0


BUTTON
140
10
234
43
NIL
setup\n
NIL
1
T
OBSERVER
T
NIL

BUTTON
140
45
234
78
NIL
1
T
OBSERVER
NIL
NIL

PLOT
1
172
591
442
count states
ticks
count
0.0
10.0
0.0
10.0
true
true
PENS
"0" 1.0 0 -16777216 true
"1" 1.0 0 -16777216 true
"2" 1.0 0 -16777216 true
"3" 1.0 0 -16777216 true
"4" 1.0 0 -16777216 true
"5" 1.0 0 -16777216 true
"6" 1.0 0 -16777216 true
"7" 1.0 0 -16777216 true
"8" 1.0 0 -16777216 true
"9" 1.0 0 -16777216 true
"10" 1.0 0 -16777216 true

MONITOR
533
119
590
168
NIL
ticks
5
1

SLIDER
3
10
115
43
hc-states
hc-states
1
10
9
1
1
NIL

SWITCH
3
45
115
78
Parasites
Parasites
0
1
-1000




BUTTON
140
115
234
148
add parasites
do-add-parasites
NIL
1
T
OBSERVER
T
NIL

BUTTON
237
45
330
78
NIL
go-for
NIL
1
T
OBSERVER
T
NIL

CHOOSER
332
45
424
90
cycles
cycles
1 2 5 10 20 50 100 200 500 1000 2000 5000 10000 20000 50000
6

MONITOR
460
119
529
168
Parasites
cnt-parasites
5
1

SLIDER
3
80
115
113
support-factor-parasite
support-factor-parasite
0.1
5
2.0
0.1
1
NIL

CHOOSER
237
116
330
161
add-parasites
add-parasites
1 2 5 10 20 50 100 200 500 1000 2000 5000 10000 20000 50000
9

BUTTON
237
80
330
113
NIL
go
T
1
T
OBSERVER
T
NIL

SLIDER
432
10
544
43
frame-skip
frame-skip
0
100
5
1
1
NIL

SLIDER
3
116
115
149
decay
decay
0
1
0.2
0.01
1
NIL

@#$#@#$#@
WHAT IS IT?
-----------
This model simulates a hypercycle described by Eigen and Schuster 1979. A hypercycle is a prebiotic model which shows how stable structures (e.g. life forms) can or will emerge because of cyclic support of self replicating molecules to other self replicating molecules. This model can simulate up to 10 different molecule types.
The original concept of a hypercycle was critized by John Maynard Smith because a parasite molecule will destroy a hypercycle. Hogeweg and Boerlijst showed 1990 by using a cellular automata a hypercycle will be stable despite by an 'infection' of a parasite because of the spatial structures a hypercycle will emerge.

Rules:
a) A cell (patch) filled with a molecule (state > 0) has in every cycle a certain chance to become empty (denoted by state 0). This probability is given by the global constant decay (slider).

b) Every empty cell (patch) can be filled by a molecule of the surrounding neighbours (north, west, south, east) or remains empty.

c) Every molecule has in a cycle of a run a certain chance to reproduce itself. This is defined by the constant s[i] where [i] denotes the i_th entry for the corresponding molecule i. The value for every s[i] is 1.

d) Due to the hypercycle a molecule gets some support to reproduce itself if its predecessor is in the neighbourhood. This support value is 100 which raises the probability a molecule will reproduce itself into an empty cell.

e) Using a parasite molecule will give more support of one state to the parasite state as any other state will receive.


HOW IT WORKS
------------
This model uses no turtles. The patches are the cells of the cellular automata. The models runs through every patch for which the next state will be computed. After all some sort of diffusion to simulate the molecule drift is computed by exchanging the next states of neigbour patches. After all next states have been computed als patches set these as the current state.

The state 0 (displayed black) denotes an empty patch. The state 1 (red) will denote a parasite molecule if the parasite option is activated.

The parasite will be simulated by changing the support values. Usually the support for 5 states is:

1 supports 2.
2 supports 3.
3 supports 4.
4 supports 5.  
5 supports 1.  

Introducing a parasite will change these rules to
1 supports none.
2 supports 3.
3 supports 4.
4 supports 5.  
5 supports 1 and 2.  
The support of 5 for 1 is higher than the support of 5 for 2.


For the general idea how this model works please refer to
Spiral wave structure in pre-biotic evolution: Hypercycles stable  against parasites. 
Physica D, 48: 17-28.
You'll find a link to a pdf document containing this artice at the end of this page.



HOW TO USE IT
-------------
Use the control elements from top to down and left to right. But read the following information first!

Doing a run:
Press set-up. Press open-movie if you like to save a movie. Press go. Press go again. Press close-movie (if you have pressed open-movie before).


SLIDERS:

hc-states:
Number of hypercycle states which are used in the current settings. This slider is only effective pressing the setup button.

support-factor-parasite:
The support factor a parasite is given by the last state.

frame-skip:
To accelerate display frames can be skipped. n frames are skipped during display where n denotes the value of the slider. A value of 0 will skip no frame.


SWITCHES:

Parasites:
Only effective during pressing the setup button. If parasites are used in this model the state 1 will be the parasite state. The internal tables become different values according to run a parasite state in this model or not.


BUTTONS:

setup:
The setup button initialize the model. Some internal tables are computed according to the settings of some sliders and switches. The number of states, which can't be changed later on, in this model is set pressing the setup button; also the patches are randomly initialized with states.


open movie:
Rudimentary support for movies. Pressing this button a movie file will be created. You can only choose the path. Open a movie will only write the graphical output of the patches into the movie file.
IMPORTANT: Open a movie AFTER you have setup the simulation.

close movie:
Closes the movie and writes the movie with the name 'capture.mov' in the prior selected directory.


add parasites:
Adds the number of parasites defined by the choice add-parasites to the model. This button is only effective if the switch 'Parasites' has been turned on during pressing the setup button.
The patches are choosen randomly so there is no guarantee exactly 'add-parasites' number of patches will be 'converted' to a parasite.


one cycle:
Running this model exactly one cycle.

go-for:
Running this model exactly for the number of cycles given in the choice 'cycles'.

go:
Running this model forever until this button is pressed again.


THINGS TO NOTICE
----------------
Wait for the emerging spirals. This model may run very slowly but structures will emerge only with screen-sizes greater 50.


THINGS TO TRY
-------------
This section could give some ideas of things for the user to try to do (move sliders, switches, etc.) with the model.


EXTENDING THE MODEL
-------------------
This section could give some ideas of things to add or change in the procedures tab to make the model more complicated, detailed, accurate, etc.


NETLOGO FEATURES
----------------
This section could point out any especially interesting or unusual features of NetLogo that the model makes use of, particularly in the Procedures tab.  It might also point out places where workarounds were needed because of missing features.


RELATED MODELS
--------------
This section could give the names of models in the NetLogo Models Library or elsewhere which are of related interest.


CREDITS AND REFERENCES
----------------------
This model was developed by Joerg Hoehne in September 2004 in the intention to learn the concepts and programming features of NetLogo.

email: hoehne@thinktel.de
Any suggestions, questions, bug reports, corrections (especially typos, grammar, unknown words etc.) and feedback are welcomed.


References:
[Book, out of print] Gerhard, Martin ; Schuster, Heike: Das digitale Universum. Vieweg Verlag, 1995

[Book, out of print] Eigen, Manfred ; Schuster, Peter: The Hypercycle - A Principle of Natural Self-Organization. Springer, 1979

[link]: http://www-binf.bio.uu.nl/publications/1991.html
	where you find the following interesting link to 
	http://www-binf.bio.uu.nl/pdf/Boerlijst.pd91-48.pdf
Spiral wave structure in pre-biotic evolution: Hypercycles stable against parasites. 
Physica D, 48: 17-28.

@#$#@#$#@
default
true
0
Polygon -7566196 true true 150 5 40 250 150 205 260 250

ant
true
0
Polygon -7566196 true true 136 61 129 46 144 30 119 45 124 60 114 82 97 37 132 10 93 36 111 84 127 105 172 105 189 84 208 35 171 11 202 35 204 37 186 82 177 60 180 44 159 32 170 44 165 60
Polygon -7566196 true true 150 95 135 103 139 117 125 149 137 180 135 196 150 204 166 195 161 180 174 150 158 116 164 102
Polygon -7566196 true true 149 186 128 197 114 232 134 270 149 282 166 270 185 232 171 195 149 186
Polygon -7566196 true true 225 66 230 107 159 122 161 127 234 111 236 106
Polygon -7566196 true true 78 58 99 116 139 123 137 128 95 119
Polygon -7566196 true true 48 103 90 147 129 147 130 151 86 151
Polygon -7566196 true true 65 224 92 171 134 160 135 164 95 175
Polygon -7566196 true true 235 222 210 170 163 162 161 166 208 174
Polygon -7566196 true true 249 107 211 147 168 147 168 150 213 150

arrow
true
0
Polygon -7566196 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

bee
true
0
Polygon -256 true false 152 149 77 163 67 195 67 211 74 234 85 252 100 264 116 276 134 286 151 300 167 285 182 278 206 260 220 242 226 218 226 195 222 166
Polygon -16777216 true false 150 149 128 151 114 151 98 145 80 122 80 103 81 83 95 67 117 58 141 54 151 53 177 55 195 66 207 82 211 94 211 116 204 139 189 149 171 152
Polygon -7566196 true true 151 54 119 59 96 60 81 50 78 39 87 25 103 18 115 23 121 13 150 1 180 14 189 23 197 17 210 19 222 30 222 44 212 57 192 58
Polygon -16777216 true false 70 185 74 171 223 172 224 186
Polygon -16777216 true false 67 211 71 226 224 226 225 211 67 211
Polygon -16777216 true false 91 257 106 269 195 269 211 255
Line -1 false 144 100 70 87
Line -1 false 70 87 45 87
Line -1 false 45 86 26 97
Line -1 false 26 96 22 115
Line -1 false 22 115 25 130
Line -1 false 26 131 37 141
Line -1 false 37 141 55 144
Line -1 false 55 143 143 101
Line -1 false 141 100 227 138
Line -1 false 227 138 241 137
Line -1 false 241 137 249 129
Line -1 false 249 129 254 110
Line -1 false 253 108 248 97
Line -1 false 249 95 235 82
Line -1 false 235 82 144 100

bird1
false
0
Polygon -7566196 true true 2 6 2 39 270 298 297 298 299 271 187 160 279 75 276 22 100 67 31 0

bird2
false
0
Polygon -7566196 true true 2 4 33 4 298 270 298 298 272 298 155 184 117 289 61 295 61 105 0 43

boat1
false
0
Polygon -1 true false 63 162 90 207 223 207 290 162
Rectangle -6524078 true false 150 32 157 162
Polygon -16776961 true false 150 34 131 49 145 47 147 48 149 49
Polygon -7566196 true true 158 33 230 157 182 150 169 151 157 156
Polygon -7566196 true true 149 55 88 143 103 139 111 136 117 139 126 145 130 147 139 147 146 146 149 55

boat2
false
0
Polygon -1 true false 63 162 90 207 223 207 290 162
Rectangle -6524078 true false 150 32 157 162
Polygon -16776961 true false 150 34 131 49 145 47 147 48 149 49
Polygon -7566196 true true 157 54 175 79 174 96 185 102 178 112 194 124 196 131 190 139 192 146 211 151 216 154 157 154
Polygon -7566196 true true 150 74 146 91 139 99 143 114 141 123 137 126 131 129 132 139 142 136 126 142 119 147 148 147

boat3
false
0
Polygon -1 true false 63 162 90 207 223 207 290 162
Rectangle -6524078 true false 150 32 157 162
Polygon -16776961 true false 150 34 131 49 145 47 147 48 149 49
Polygon -7566196 true true 158 37 172 45 188 59 202 79 217 109 220 130 218 147 204 156 158 156 161 142 170 123 170 102 169 88 165 62
Polygon -7566196 true true 149 66 142 78 139 96 141 111 146 139 148 147 110 147 113 131 118 106 126 71

box
true
0
Polygon -7566196 true true 45 255 255 255 255 45 45 45

butterfly1
true
0
Polygon -16777216 true false 151 76 138 91 138 284 150 296 162 286 162 91
Polygon -7566196 true true 164 106 184 79 205 61 236 48 259 53 279 86 287 119 289 158 278 177 256 182 164 181
Polygon -7566196 true true 136 110 119 82 110 71 85 61 59 48 36 56 17 88 6 115 2 147 15 178 134 178
Polygon -7566196 true true 46 181 28 227 50 255 77 273 112 283 135 274 135 180
Polygon -7566196 true true 165 185 254 184 272 224 255 251 236 267 191 283 164 276
Line -7566196 true 167 47 159 82
Line -7566196 true 136 47 145 81
Circle -7566196 true true 165 45 8
Circle -7566196 true true 134 45 6
Circle -7566196 true true 133 44 7
Circle -7566196 true true 133 43 8

circle
false
0
Circle -7566196 true true 35 35 230

line
true
0
Line -7566196 true 150 0 150 300

person
false
0
Circle -7566196 true true 155 20 63
Rectangle -7566196 true true 158 79 217 164
Polygon -7566196 true true 158 81 110 129 131 143 158 109 165 110
Polygon -7566196 true true 216 83 267 123 248 143 215 107
Polygon -7566196 true true 167 163 145 234 183 234 183 163
Polygon -7566196 true true 195 163 195 233 227 233 206 159

sheep
false
15
Rectangle -1 true true 90 75 270 225
Circle -1 true true 15 75 150
Rectangle -16777216 true false 81 225 134 286
Rectangle -16777216 true false 180 225 238 285
Circle -16777216 true false 1 88 92

spacecraft
true
0
Polygon -7566196 true true 150 0 180 135 255 255 225 240 150 180 75 240 45 255 120 135

thin-arrow
true
0
Polygon -7566196 true true 150 0 0 150 120 150 120 293 180 293 180 150 300 150

truck-down
false
0
Polygon -7566196 true true 225 30 225 270 120 270 105 210 60 180 45 30 105 60 105 30
Polygon -8716033 true false 195 75 195 120 240 120 240 75
Polygon -8716033 true false 195 225 195 180 240 180 240 225

truck-left
false
0
Polygon -7566196 true true 120 135 225 135 225 210 75 210 75 165 105 165
Polygon -8716033 true false 90 210 105 225 120 210
Polygon -8716033 true false 180 210 195 225 210 210

truck-right
false
0
Polygon -7566196 true true 180 135 75 135 75 210 225 210 225 165 195 165
Polygon -8716033 true false 210 210 195 225 180 210
Polygon -8716033 true false 120 210 105 225 90 210

turtle
true
0
Polygon -7566196 true true 138 75 162 75 165 105 225 105 225 142 195 135 195 187 225 195 225 225 195 217 195 202 105 202 105 217 75 225 75 195 105 187 105 135 75 142 75 105 135 105

wolf
false
0
Rectangle -7566196 true true 15 105 105 165
Rectangle -7566196 true true 45 90 105 105
Polygon -7566196 true true 60 90 83 44 104 90
Polygon -16777216 true false 67 90 82 59 97 89
Rectangle -1 true false 48 93 59 105
Rectangle -16777216 true false 51 96 55 101
Rectangle -16777216 true false 0 121 15 135
Rectangle -16777216 true false 15 136 60 151
Polygon -1 true false 15 136 23 149 31 136
Polygon -1 true false 30 151 37 136 43 151
Rectangle -7566196 true true 105 120 263 195
Rectangle -7566196 true true 108 195 259 201
Rectangle -7566196 true true 114 201 252 210
Rectangle -7566196 true true 120 210 243 214
Rectangle -7566196 true true 115 114 255 120
Rectangle -7566196 true true 128 108 248 114
Rectangle -7566196 true true 150 105 225 108
Rectangle -7566196 true true 132 214 155 270
Rectangle -7566196 true true 110 260 132 270
Rectangle -7566196 true true 210 214 232 270
Rectangle -7566196 true true 189 260 210 270
Line -7566196 true 263 127 281 155
Line -7566196 true 281 155 281 192

wolf-left
false
3
Polygon -6524078 true true 117 97 91 74 66 74 60 85 36 85 38 92 44 97 62 97 81 117 84 134 92 147 109 152 136 144 174 144 174 103 143 103 134 97
Polygon -6524078 true true 87 80 79 55 76 79
Polygon -6524078 true true 81 75 70 58 73 82
Polygon -6524078 true true 99 131 76 152 76 163 96 182 104 182 109 173 102 167 99 173 87 159 104 140
Polygon -6524078 true true 107 138 107 186 98 190 99 196 112 196 115 190
Polygon -6524078 true true 116 140 114 189 105 137
Rectangle -6524078 true true 109 150 114 192
Rectangle -6524078 true true 111 143 116 191
Polygon -6524078 true true 168 106 184 98 205 98 218 115 218 137 186 164 196 176 195 194 178 195 178 183 188 183 169 164 173 144
Polygon -6524078 true true 207 140 200 163 206 175 207 192 193 189 192 177 198 176 185 150
Polygon -6524078 true true 214 134 203 168 192 148
Polygon -6524078 true true 204 151 203 176 193 148
Polygon -6524078 true true 207 103 221 98 236 101 243 115 243 128 256 142 239 143 233 133 225 115 214 114

wolf-right
false
3
Polygon -6524078 true true 170 127 200 93 231 93 237 103 262 103 261 113 253 119 231 119 215 143 213 160 208 173 189 187 169 190 154 190 126 180 106 171 72 171 73 126 122 126 144 123 159 123
Polygon -6524078 true true 201 99 214 69 215 99
Polygon -6524078 true true 207 98 223 71 220 101
Polygon -6524078 true true 184 172 189 234 203 238 203 246 187 247 180 239 171 180
Polygon -6524078 true true 197 174 204 220 218 224 219 234 201 232 195 225 179 179
Polygon -6524078 true true 78 167 95 187 95 208 79 220 92 234 98 235 100 249 81 246 76 241 61 212 65 195 52 170 45 150 44 128 55 121 69 121 81 135
Polygon -6524078 true true 48 143 58 141
Polygon -6524078 true true 46 136 68 137
Polygon -6524078 true true 45 129 35 142 37 159 53 192 47 210 62 238 80 237
Line -16777216 false 74 237 59 213
Line -16777216 false 59 213 59 212
Line -16777216 false 58 211 67 192
Polygon -6524078 true true 38 138 66 149
Polygon -6524078 true true 46 128 33 120 21 118 11 123 3 138 5 160 13 178 9 192 0 199 20 196 25 179 24 161 25 148 45 140
Polygon -6524078 true true 67 122 96 126 63 144

@#$#@#$#@
NetLogo 2.1.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
