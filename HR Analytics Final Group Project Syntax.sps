* Encoding: UTF-8.

FREQUENCIES VARIABLES=Gender TechTrainingPriorYear Country CurrentYearPerformanceRating 
    PriorYearPerformanceRating Tenure VoluntaryTurnover Engagement Leadership PerformanceManagement 
    LearningDevelopment Culture ParticipatedLeadershipDevelopment PriorYearCompensation
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /ORDER=ANALYSIS.

FREQUENCIES VARIABLES=Engagement Leadership PerformanceManagement LearningDevelopment Culture
  /FORMAT=NOTABLE
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN MEDIAN MODE
  /ORDER=ANALYSIS.

RELIABILITY
  /VARIABLES=Engagement Leadership PerformanceManagement LearningDevelopment Culture
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE
  /SUMMARY=TOTAL MEANS.

EXAMINE VARIABLES=Engagement Leadership PerformanceManagement LearningDevelopment Culture
  /PLOT BOXPLOT STEMLEAF HISTOGRAM
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

CORRELATIONS
  /VARIABLES=Engagement Leadership PerformanceManagement LearningDevelopment Culture
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

CLUSTER   Engagement Leadership PerformanceManagement LearningDevelopment Culture
  /METHOD WARD
  /MEASURE=SEUCLID
  /PRINT SCHEDULE
  /PLOT VICICLE.

QUICK CLUSTER Engagement Leadership PerformanceManagement LearningDevelopment Culture
  /MISSING=LISTWISE
  /CRITERIA=CLUSTER(4) MXITER(10) CONVERGE(0)
  /METHOD=KMEANS(NOUPDATE)
  /SAVE CLUSTER
  /PRINT INITIAL.

FREQUENCIES VARIABLES=QCL_1
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /ORDER=ANALYSIS.

***************************************************
****ANCOVA

SORT CASES  BY ClusterProfiles.

SPLIT FILE LAYERED BY ClusterProfiles.

UNIANOVA CurrentYearPerformanceRating BY ParticipatedLeadershipDevelopment WITH 
    PriorYearPerformanceRating
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /EMMEANS=TABLES(ParticipatedLeadershipDevelopment) WITH(PriorYearPerformanceRating=MEAN) 
  /PRINT ETASQ
  /CRITERIA=ALPHA(.05)
  /DESIGN=PriorYearPerformanceRating ParticipatedLeadershipDevelopment.

UNIANOVA CurrentYearPerformanceRating BY ParticipatedLeadershipDevelopment WITH 
    PriorYearPerformanceRating
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /EMMEANS=TABLES(ParticipatedLeadershipDevelopment) WITH(PriorYearPerformanceRating=MEAN) COMPARE 
    ADJ(BONFERRONI)
  /PRINT ETASQ DESCRIPTIVE HOMOGENEITY
  /CRITERIA=ALPHA(.05)
  /DESIGN=PriorYearPerformanceRating ParticipatedLeadershipDevelopment.

***************************

CORRELATIONS
  /VARIABLES=Gender TechTrainingPriorYear Country CurrentYearPerformanceRating 
    PriorYearPerformanceRating Tenure VoluntaryTurnover Engagement Leadership PerformanceManagement 
    LearningDevelopment Culture ParticipatedLeadershipDevelopment PriorYearCompensation
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

LOGISTIC REGRESSION VARIABLES VoluntaryTurnover
  /METHOD=ENTER  Engagement Leadership PerformanceManagement LearningDevelopment Culture 
     Tenure CurrentYearPerformanceRating PriorYearPerformanceRating 
  /SAVE=PRED PGROUP COOK
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.20).

SPLIT FILE OFF.

**********************Regressions************************************
**********************Profile 1 Regression***************************

USE ALL.
COMPUTE filter_$=(ClusterProfiles = 1).
VARIABLE LABELS filter_$ 'ClusterProfiles = 1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

LOGISTIC REGRESSION VARIABLES VoluntaryTurnover
  /METHOD=ENTER Gender TechTrainingPriorYear Country CurrentYearPerformanceRating 
    PriorYearPerformanceRating Tenure Engagement Leadership PerformanceManagement LearningDevelopment 
    Culture ParticipatedLeadershipDevelopment PriorYearCompensation 
  /SAVE=COOK
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

Remove due to non significance: Prior Year Performance Rating, Leadership Score, Performance Management,
Participation in Leadership Development Program, Prior Year Comp.

LOGISTIC REGRESSION VARIABLES VoluntaryTurnover
  /METHOD=ENTER Gender TechTrainingPriorYear Country CurrentYearPerformanceRating 
    Tenure Engagement LearningDevelopment Culture
  /SAVE=COOK
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

Remove Engagement due to sign in wrong direction

LOGISTIC REGRESSION VARIABLES VoluntaryTurnover
  /METHOD=ENTER Gender TechTrainingPriorYear Country CurrentYearPerformanceRating 
    Tenure LearningDevelopment Culture
  /SAVE=COOK
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

LOGISTIC REGRESSION VARIABLES VoluntaryTurnover
  /METHOD=ENTER Gender TechTrainingPriorYear Country CurrentYearPerformanceRating 
    Tenure LearningDevelopment Culture
  /SAVE=COOK
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.2).

LOGISTIC REGRESSION VARIABLES VoluntaryTurnover
  /METHOD=ENTER Gender TechTrainingPriorYear Country CurrentYearPerformanceRating 
    Tenure LearningDevelopment Culture
  /SAVE=COOK
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.25).

LOGISTIC REGRESSION VARIABLES VoluntaryTurnover
  /METHOD=ENTER TechTrainingPriorYear Country CurrentYearPerformanceRating 
    Tenure LearningDevelopment Culture
  /SAVE=COOK
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.27).

FILTER OFF.
USE ALL.
EXECUTE.

**********************Profile 2 Regression***************************

USE ALL.
COMPUTE filter_$=(ClusterProfiles = 2).
VARIABLE LABELS filter_$ 'ClusterProfiles = 2 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

LOGISTIC REGRESSION VARIABLES VoluntaryTurnover
  /METHOD=ENTER Gender TechTrainingPriorYear Country CurrentYearPerformanceRating 
    PriorYearPerformanceRating Tenure Engagement Leadership PerformanceManagement LearningDevelopment 
    Culture ParticipatedLeadershipDevelopment PriorYearCompensation 
  /SAVE=COOK
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

**Removed due to non significance: Tech Training Prior Year, Prior Year Performance, Engagement,
Leadership, Performance Management, Learning and Development, Participated in Program, Prior Year Comp.**

LOGISTIC REGRESSION VARIABLES VoluntaryTurnover
  /METHOD=ENTER Gender Country CurrentYearPerformanceRating 
    Tenure Culture 
  /SAVE=COOK
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

LOGISTIC REGRESSION VARIABLES VoluntaryTurnover
  /METHOD=ENTER Gender Country CurrentYearPerformanceRating 
    Tenure Culture 
  /SAVE=COOK
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.29).

FILTER OFF.
USE ALL.
EXECUTE.

**********************Profile 3 Regression***************************

USE ALL.
COMPUTE filter_$=(ClusterProfiles = 3).
VARIABLE LABELS filter_$ 'ClusterProfiles = 3 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

LOGISTIC REGRESSION VARIABLES VoluntaryTurnover
  /METHOD=ENTER Gender TechTrainingPriorYear Country CurrentYearPerformanceRating 
    PriorYearPerformanceRating Tenure Engagement Leadership PerformanceManagement LearningDevelopment 
    Culture ParticipatedLeadershipDevelopment PriorYearCompensation 
  /SAVE=COOK
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

***Removed due to non significance: Tech Training, Prior Year Performance, Engagement,
Participated in Program, Prior Year Comp.***

LOGISTIC REGRESSION VARIABLES VoluntaryTurnover
  /METHOD=ENTER Gender Country CurrentYearPerformanceRating 
    Tenure Leadership PerformanceManagement LearningDevelopment 
    Culture 
  /SAVE=COOK
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

**Removed due to non significance: Leadership, Performance Management**

LOGISTIC REGRESSION VARIABLES VoluntaryTurnover
  /METHOD=ENTER Gender Country CurrentYearPerformanceRating 
    Tenure LearningDevelopment Culture 
  /SAVE=COOK
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

LOGISTIC REGRESSION VARIABLES VoluntaryTurnover
  /METHOD=ENTER Gender Country CurrentYearPerformanceRating 
    Tenure LearningDevelopment Culture 
  /SAVE=COOK
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.30).

FILTER OFF.
USE ALL.
EXECUTE.

**********************Profile 4 Regression***************************

USE ALL.
COMPUTE filter_$=(ClusterProfiles = 4).
VARIABLE LABELS filter_$ 'ClusterProfiles = 4 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

LOGISTIC REGRESSION VARIABLES VoluntaryTurnover
  /METHOD=ENTER Gender TechTrainingPriorYear Country CurrentYearPerformanceRating 
    PriorYearPerformanceRating Tenure Engagement Leadership PerformanceManagement LearningDevelopment 
    Culture ParticipatedLeadershipDevelopment PriorYearCompensation 
  /SAVE=COOK
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

**Removed due to non significance: Prior Year Performance, Engagement, Performance Management,
Participated in Program, Prior Year Comp.**

LOGISTIC REGRESSION VARIABLES VoluntaryTurnover
  /METHOD=ENTER Gender TechTrainingPriorYear Country CurrentYearPerformanceRating 
    Tenure Leadership LearningDevelopment Culture 
  /SAVE=COOK
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

**Removed due to non significance: Hours in Training, Leadership, Learning and Development**

LOGISTIC REGRESSION VARIABLES VoluntaryTurnover
  /METHOD=ENTER Gender Country CurrentYearPerformanceRating 
    Tenure Culture 
  /SAVE=COOK
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.30).

FILTER OFF.
USE ALL.
EXECUTE.

*****************************Extra Analysis***************************************

CROSSTABS
  /TABLES=VoluntaryTurnover BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT EXPECTED COLUMN 
  /COUNT ROUND CELL.
