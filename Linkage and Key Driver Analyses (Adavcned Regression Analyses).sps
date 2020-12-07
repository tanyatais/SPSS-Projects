* Encoding: UTF-8.
*** Merged files***

DATASET ACTIVATE DataSet1.
SORT CASES BY StoreNumber.
DATASET ACTIVATE DataSet2.
SORT CASES BY StoreNumber.
DATASET ACTIVATE DataSet1.
MATCH FILES /FILE=*
  /FILE='DataSet2'
  /BY StoreNumber.
EXECUTE.

SORT CASES BY StoreNumber.
DATASET ACTIVATE DataSet3.
SORT CASES BY StoreNumber.
DATASET ACTIVATE DataSet1.
MATCH FILES /FILE=*
  /FILE='DataSet3'
  /BY StoreNumber.
EXECUTE.

*** Screened Data: Leadership judgement missing more than 25% of responses at n=30 May be due to the type of question being asked***


DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=Interview Biodata AbilityTest RiskTakingPropensity PerformanceRating judgementOverallTScore 
    mCompetency1 mCompetency2 mCompetency3 mCompetency4 mCompetency5 mCompetency6 mCompetency7 
    mCompetency8 dCompetency1 dCompetency2 dCompetency3 dCompetency4 dCompetency5 dCompetency6 
    dCompetency7 dCompetency8 
  /ORDER=ANALYSIS.

CORRELATIONS
  /VARIABLES=Interview AbilityTest RiskTakingPropensity PerformanceRating judgementOverallTScore mCompetency1 mCompetency2 mCompetency3 mCompetency4 mCompetency5 mCompetency6 mCompetency7 
    mCompetency8 dCompetency1 dCompetency2 dCompetency3 dCompetency4 dCompetency5 dCompetency6 
    dCompetency7 dCompetency8 
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.


***correlation ran with filters***

CORRELATIONS
  /VARIABLES=Interview AbilityTest RiskTakingPropensity PerformanceRating judgementOverallTScore 
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

***regression ran for making prediction, accuracy and r^2)***

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS CI(95) R ANOVA COLLIN TOL
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT PerformanceRating 
  /METHOD=ENTER Interview AbilityTest RiskTakingPropensity judgementOverallTScore
  /SAVE PRED COOK.

*** took out structured interview as it may have nothing to do with performance rating currenlty***

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS CI(95) R ANOVA COLLIN TOL
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT PerformanceRating 
  /METHOD=ENTER AbilityTest RiskTakingPropensity judgementOverallTScore
  /SAVE PRED COOK.






