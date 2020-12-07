* Encoding: UTF-8.

* white compared to black*
***IR= (.462/.776)= .595 which is a violation of the 80% rule due to being belowed the .8 threshold*** ***these numbers are pulled from the percent withen coloumn***
***2SD test = sqrt(16.212) =4.02 which is statistically signifacnt, since it is above the value of z=1.96***

DATASET ACTIVATE DataSet1.
RECODE Race (1=1) (2=0) (ELSE=SYSMIS) INTO WBComparison.
VARIABLE LABELS  WBComparison 'WBComparison'.
EXECUTE.

*White compared to hispanics*
***IR= (.603/.776)= .777 which is a violation of the 80% rule*** 
***2SD test = sqrt(8.54) =2.922 which is statistically signifacnt, since it is above the value of z=1.96***

DATASET ACTIVATE DataSet1.
RECODE Race (1=1) (3=0) (ELSE=SYSMIS) INTO WHComparison.
VARIABLE LABELS  WHComparison 'WHComparison'.
EXECUTE.

*White compared to asian*
***IR= (.795/.776)= 1.02 which is not a violation of the 80% rule and is below the 0.80 thereshold***
***2SD test = sqrt(0.153) =0.391 which is not statistically signifacnt, since it is below the value of  z=1.96***

DATASET ACTIVATE DataSet1.
RECODE Race (1=1) (4=0) (ELSE=SYSMIS) INTO WAComparison.
VARIABLE LABELS  WAComparison 'WAComparison'.
EXECUTE.

*--------------------------------------Analysis used to answer H.W Assignemnet and the in-class assignment--------------------------------------------*

*** Adverse impact detected at stage 1 decision for Black and Hispanic canidates, but not for and Asian candidates when compared to White candidates***

CROSSTABS
  /TABLES=Stage1Decision BY WBComparison WHComparison WAComparison
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT EXPECTED COLUMN
  /COUNT ROUND CELL
  /METHOD=EXACT TIMER(5).

*** Adverse impact detected at stage 2 decision for Black candidates, but not for and Asian and Hispanic candidates when compared to White candidates***

CROSSTABS
  /TABLES=Stage2Decision BY WBComparison WHComparison WAComparison
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT EXPECTED COLUMN
  /COUNT ROUND CELL
  /METHOD=EXACT TIMER(5).

***Adverse impact detected at the hiring decision for Asian candidates, but not for Black, and Hispanic candidates when compared to white candidates*** 

CROSSTABS
  /TABLES=Hired BY WBComparison WHComparison WAComparison
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT EXPECTED COLUMN
  /COUNT ROUND CELL
  /METHOD=EXACT TIMER(5).

*--------------------------------------------- Analysis used to answer H.W Assignment-------------------------------------------------------------*

*** No "Adverse Impact" based on gender at stage 1 decision*** 

CROSSTABS
  /TABLES=Stage1Decision BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT EXPECTED COLUMN 
  /COUNT ROUND CELL
  /METHOD=EXACT TIMER(5).

*** No "Adverse Impact" based on gender at stage 2 decision*** 

CROSSTABS
  /TABLES=Stage2Decision BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT EXPECTED COLUMN 
  /COUNT ROUND CELL
  /METHOD=EXACT TIMER(5).

*** "Adverse Impact"  detected based on gender at the Hirring Decision for Female candidates*** 

CROSSTABS
  /TABLES=Hired BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT EXPECTED COLUMN 
  /COUNT ROUND CELL
  /METHOD=EXACT TIMER(5).

*** No "Adverse Impact at stage 1 decision in Houston ------------ Adverse impact at stage 1 decision in New york For Females***

CROSSTABS
  /TABLES=Stage1Decision BY Gender BY Site
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT EXPECTED COLUMN 
  /COUNT ROUND CELL
  /METHOD=EXACT TIMER(5).

*** No "Adverse Impact at stage 2 decision in Houston ------------ Adverse impact at stage 2 decision in New york for Females***

CROSSTABS
  /TABLES=Stage2Decision BY Gender BY Site
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT EXPECTED COLUMN 
  /COUNT ROUND CELL
  /METHOD=EXACT TIMER(5).

*** No "Adverse Impact at hiring stage decision in Houston ------------ Adverse impact at hiring stage decision in New york for Females***

CROSSTABS
  /TABLES=Hired BY Gender BY Site
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT EXPECTED COLUMN 
  /COUNT ROUND CELL
  /METHOD=EXACT TIMER(5).
