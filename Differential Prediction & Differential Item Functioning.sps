* Encoding: UTF-8.

*Ran frequency to see if there was any impermissible values and to get a btter undrstanding of the state of the data. there is quite a few missing variables,
 but those missing items make are 13% or less for each item with an average of answered questions being above 85%.   

DATASET ACTIVATE DataSet3.
FREQUENCIES VARIABLES=sc_nat01 sc_nat02 sc_nat03 sc_nat04 sc_nat05 sc_nat06 sc_nat07 sc_nat08 
    sc_nat09 sc_nat10 sc_nat11 race2 Gender score Performance
  /STATISTICS=STDDEV VARIANCE MEAN MODE
  /ORDER=ANALYSIS.

** Recoded impermissable values in the data set**

RECODE sc_nat01 sc_nat02 sc_nat03 sc_nat04 sc_nat05 sc_nat06 sc_nat07 sc_nat08 sc_nat09 sc_nat10 sc_nat11 (0=0) (1=1) 
    (ELSE=SYSMIS) INTO sc_nat01R sc_nat02R sc_nat03R sc_nat04R sc_nat05R sc_nat06R sc_nat07R sc_nat08R sc_nat09R sc_nat10R 
    sc_nat11R.
EXECUTE.

**Re-ran frequencies on the dtata set**

FREQUENCIES VARIABLES=sc_nat01R sc_nat02R sc_nat03R 
    sc_nat04R sc_nat05R sc_nat06R sc_nat07R sc_nat08R sc_nat09R sc_nat11R sc_nat10R TotalScore race2 Gender score Performance
  /STATISTICS=STDDEV VARIANCE MEAN MODE
  /ORDER=ANALYSIS.

*1. computed total score for each indiviual by getting the mean average 
  2. The test at first glance when looking at the mean in the frequency table seemed close to 50/50 in terms of question difficulty,
  but upon looking at the composite score and having set the cut-off passing grade at .65 and above more than half of the test takers
  failed the test. Signaling that this may have been a difficult test.  

COMPUTE TotalScore=MEAN(sc_nat01R,sc_nat02R,sc_nat03R,sc_nat04R,sc_nat05R,sc_nat06R,sc_nat07R,
    sc_nat08R,sc_nat09R,sc_nat10R,sc_nat11R).
EXECUTE.

*3 & 4. The test is discriminating on average more blacks fail the test than whites.
*Also more white test takers than they are black test takers, but the mean of the scores for black test takers are still lower*

EXAMINE VARIABLES=score BY race2
  /PLOT BOXPLOT STEMLEAF
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

SORT CASES  BY race2.
SPLIT FILE LAYERED BY race2.

DESCRIPTIVES VARIABLES=sc_nat01R sc_nat02R sc_nat03R sc_nat04R sc_nat05R sc_nat06R sc_nat07R 
    sc_nat08R sc_nat09R sc_nat10R sc_nat11R
  /STATISTICS=MEAN STDDEV MIN MAX 
  /SORT=NAME (A).

SPLIT FILE OFF

*5. There are differences in means for black and white test takers with a small to effect size of cohen's d (standardized) .23*

T-TEST GROUPS=race2(0 1)
  /MISSING=ANALYSIS
  /VARIABLES=TotalScore
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).

SORT CASES by race2.
SPLIT FILE LAYERED by race2.

RELIABILITY  
  /VARIABLES=sc_nat01R sc_nat02R sc_nat03R sc_nat04R sc_nat05R sc_nat06R sc_nat07R 
    sc_nat08R sc_nat09R sc_nat10R sc_nat11R 
  /SCALE('ALL VARIABLES') ALL  
  /MODEL=ALPHA  
  /SUMMARY=TOTAL.

SPLIT FILE OFF

*6. There is differential prediction, correlations for white and black candidtes differed and is statistically significant at the <.001 level, but due 
    VIF being greater than 5 there is colleanerity and we cannot make any interpretations off of this significance*
    
COMPUTE RaceandScoreInteraction=totalscore * race2.
EXECUTE.
    
REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA COLLIN TOL CHANGE
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT Performance
  /METHOD=ENTER race2 RaceandScoreInteraction TotalScore
  /CASEWISE PLOT(ZRESID) OUTLIERS(3)
  /SAVE COOK.

*7.There is an intermideate to large DIF with questions 1, 3,4,7,9,10 that  favors the black popultion. There is race based DIF using this measure.*   

CROSSTABS
  /TABLES=race2 BY TotalScore
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ CMH(1)
  /CELLS=COUNT 
  /COUNT ROUND CELL.

RANK VARIABLES=Totalscore (D)
  /NTILES(10)
  /PRINT=YES
  /TIES=MEAN.

CROSSTABS
  /TABLES=NTotalSc BY race2
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT
  /COUNT ROUND CELL.

RANK VARIABLES=Totalscore (D)
  /NTILES(8)
  /PRINT=YES
  /TIES=MEAN.


CROSSTABS
  /TABLES=NTI001 BY race2
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=sc_nat01R sc_nat02R sc_nat03R sc_nat04R sc_nat05R sc_nat06R sc_nat07R 
    sc_nat08R sc_nat09R sc_nat10R sc_nat11R BY race2 BY NTI001
  /FORMAT=AVALUE TABLES
  /STATISTICS=CMH(1)
  /CELLS=COUNT
  /COUNT ROUND CELL.

8. My conclusion is not consistent with the M-H only items 1,5, and 10 were significant with no-non uniform DIF. 

LOGISTIC REGRESSION VARIABLES sc_nat01R
  /METHOD=ENTER race2 RaceandScoreInteraction TotalScore 
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

LOGISTIC REGRESSION VARIABLES sc_nat02R
  /METHOD=ENTER race2 RaceandScoreInteraction TotalScore 
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

LOGISTIC REGRESSION VARIABLES sc_nat03R
  /METHOD=ENTER race2 RaceandScoreInteraction TotalScore 
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

LOGISTIC REGRESSION VARIABLES sc_nat04R
  /METHOD=ENTER race2 RaceandScoreInteraction TotalScore 
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

LOGISTIC REGRESSION VARIABLES sc_nat05R
  /METHOD=ENTER race2 RaceandScoreInteraction TotalScore 
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

LOGISTIC REGRESSION VARIABLES sc_nat06R
  /METHOD=ENTER race2 RaceandScoreInteraction TotalScore 
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

LOGISTIC REGRESSION VARIABLES sc_nat07R
  /METHOD=ENTER race2 RaceandScoreInteraction TotalScore 
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

LOGISTIC REGRESSION VARIABLES sc_nat08R
  /METHOD=ENTER race2 RaceandScoreInteraction TotalScore 
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

LOGISTIC REGRESSION VARIABLES sc_nat09R
  /METHOD=ENTER race2 RaceandScoreInteraction TotalScore 
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

LOGISTIC REGRESSION VARIABLES sc_nat10R
  /METHOD=ENTER race2 RaceandScoreInteraction TotalScore 
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

LOGISTIC REGRESSION VARIABLES sc_nat11R
  /METHOD=ENTER race2 RaceandScoreInteraction TotalScore 
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).
_______________________________________________________________________________________________________________________________________

*GENDER*

