* Encoding: UTF-8.


*** Screened Data, some data was missing but not more than 5% for each variable. There was some items on the scale that were not correct
    such as numbers that not match the scale.***

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=id race sex age born lang ascs1 ascs2 ascs3 ascs4 ascs5 ascs6 ascs7 ascs8 
    ascs9 ascs10 ascs11 ascs12 ascs13 ascs14 ascs15 ascs16 ascs17 ascs18 ascs19 ascs20 ascs21 ascs22 
    ascs23 ascs24 ascs25 ascs26 ascs27 ascs28 ascs29 ascs30 ascs31 ascs32 ascs33 ascs34 ascs35 ascs36 
    ascs37 ascs38 ascs39 ascs40 tca1 tca2 tca3 tca4 tca5 tca6 tca7 tca8 tca9 tca10 tca11 tca12 tca13 
    tca14 tca15 tca16 tca17 tca18 tca19 tca20 tca21 tca22 tca23 tca24 tca25 ci1 ci2 ci3 ci4 ci5 ci6 ci7 
    ci8 ci9 ci10 ci11 ci12 ci13 ci14 ci15 ci16 ci17 ci18 ci19 ci20 ci21 ci22 VITQ1 VITQ2 VITQ3 VITQ4 
    VITQ5 VITQ6 VITQ7 VITQ8 VITQ9 VITQ10 VITQ11 VITQ12 VITQ13 VITQ14 VITQ15 VITQ16 VITQ17 VITQ18 VITQ19 
    VITQ20 VITQ21 VITQ22 VITQ23 VITQ24 VITQ25 VITQ26 VITQ27 VITQ28 VITQ29 VITQ30 VITQ31 VITQ32 VITQ33 
    VITQ34 VITQ35 VITQ36 VITQ37 VITQ38 VITQ39 VITQ40
  /ORDER=ANALYSIS.

***Recoded: Academic Self-Concept, Cognitive Inference, and Thought Control Ability (question 5) 
    to account for missing data and elimnate any variables that was not on the given scale.***

RECODE ascs1 ascs2 ascs3 ascs4 ascs5 ascs6 ascs7 ascs8 ascs9 ascs10 ascs11 ascs12 ascs13 ascs14 
    ascs15 ascs16 ascs17 ascs18 ascs19 ascs20 ascs21 ascs22 ascs23 ascs24 ascs25 ascs26 ascs27 ascs28 
    ascs29 ascs30 ascs31 ascs32 ascs33 ascs34 ascs35 ascs36 ascs37 ascs38 ascs39 ascs40 (1=1) (2=2) 
    (3=3) (4=4) (ELSE=SYSMIS) INTO ascs1R ascs2R ascs3R ascs4R ascs5R ascs6R ascs7R ascs8R ascs9R 
    ascs10R ascs11R ascs12R ascs13R ascs14R ascs15R ascs16R ascs17R ascs18R ascs19R ascs20R ascs21R 
    ascs22R ascs23R ascs24R ascs25R ascs26R ascs27R ascs28R ascs29R ascs30R ascs31R ascs32R ascs33R 
    ascs34R ascs35R ascs36R ascs37R ascs38R ascs39R ascs40R.
VARIABLE LABELS  ascs40R 'ASCS.'.
EXECUTE.

RECODE tca1 tca2 tca3 tca4 tca5 tca6 tca7 tca8 tca9 tca10 tca11 tca12 tca13 tca14 tca15 tca16 tca17 
    tca18 tca19 tca20 tca21 tca22 tca23 tca24 tca25 (1=1) (2=2) (3=3) (4=4) (5=5) (ELSE=SYSMIS) INTO 
    tca1R tca2R tca3R tca4R tca5R tca6R tca7R tca8R tca9R tca10R tca11R tca12R tca13R tca14R tca15R 
    tca16R tca17R tca18R tca19R tca20R tca21R tca22R tca23R tca24R tca25R.
EXECUTE.

RECODE ci1 ci2 ci3 ci4 ci5 ci6 ci7 ci8 ci9 ci10 ci11 ci12 ci13 ci14 ci15 ci16 ci17 ci18 ci19 ci20 
    ci21 ci22 (2=2) (3=3) (4=4) (0=0) (1=1) (ELSE=SYSMIS) INTO ci1R ci2R ci3R ci4R ci5R ci6R ci7R ci8R 
    ci9R ci10R ci11R ci12R ci13R ci14R ci15R ci16R ci17R ci18R ci19R ci20R ci21R ci22R.
EXECUTE.

RECODE VITQ5 (0=0) (1=1) (ELSE=SYSMIS) INTO VITQ5R.
EXECUTE.

***Created Composite scores for each item with the recoded variables***

COMPUTE AcademicSelfConceptCompositeScore=MEAN(ascs1R,ascs2R,ascs3R,ascs4R,ascs5R,ascs6R,ascs7R,
    ascs8R,ascs9R,ascs10R,ascs11R,ascs12R,ascs13R,ascs14R,ascs15R,ascs16R,ascs17R,ascs18R,ascs19R,
    ascs20R,ascs21R,ascs22R,ascs23R,ascs24R,ascs25R,ascs26R,ascs27R,ascs28R,ascs29R,ascs30R,ascs31R,
    ascs32R,ascs33R,ascs34R,ascs35R,ascs36R,ascs37R,ascs38R,ascs39R,ascs40R).
EXECUTE.

COMPUTE ThoughtControlAbilityCompositeScore=MEAN(tca1R,tca2R,tca3R,tca4R,tca5R,tca6R,tca7R,tca8R,
    tca9R,tca10R,tca11R,tca12R,tca13R,tca14R,tca15R,tca16R,tca17R,tca18R,tca19R,tca20R,tca21R,tca22R,
    tca23R,tca24R,tca25R).
EXECUTE.

COMPUTE CognitiveInterferenceCompositeScore=MEAN(ci1R,ci2R,ci3R,ci4R,ci5R,ci6R,ci7R,ci8R,ci9R,ci10R,
    ci11R,ci12R,ci13R,ci14R,ci15R,ci16R,ci17R,ci18R,ci19R,ci20R,ci21R,ci22R).
EXECUTE.

COMPUTE VerbalIntelligenceTestCompositeScore=MEAN(VITQ1,VITQ2,VITQ3,VITQ4,VITQ5R,VITQ6,VITQ7,VITQ8,
    VITQ9,VITQ10,VITQ11,VITQ12,VITQ13,VITQ14,VITQ15,VITQ16,VITQ17,VITQ18,VITQ19,VITQ20,VITQ21,VITQ22,
    VITQ23,VITQ24,VITQ25,VITQ26,VITQ27,VITQ28,VITQ29,VITQ30,VITQ31,VITQ32,VITQ33,VITQ34,VITQ35,VITQ36,
    VITQ37,VITQ38,VITQ39,VITQ40).
EXECUTE.
____________________________________________________________________________________________________________________________

***Data above from a previous analysis was used to run further analyisis on the data which can be found below***

____________________________________________________________________________________________________________________________

*** Scatter plot of relationship between composite scores***

GRAPH
  /SCATTERPLOT(BIVAR)=ThoughtControlAbilityCompositeScore WITH AcademicSelfConceptCompositeScore
  /MISSING=LISTWISE.

GRAPH
  /SCATTERPLOT(BIVAR)=CognitiveInterferenceCompositeScore WITH AcademicSelfConceptCompositeScore
  /MISSING=LISTWISE.

GRAPH
  /SCATTERPLOT(BIVAR)=VerbalIntelligenceTestCompositeScore WITH AcademicSelfConceptCompositeScore
  /MISSING=LISTWISE.

GRAPH
  /SCATTERPLOT(BIVAR)=CognitiveInterferenceCompositeScore WITH ThoughtControlAbilityCompositeScore
  /MISSING=LISTWISE.

GRAPH
  /SCATTERPLOT(BIVAR)=VerbalIntelligenceTestCompositeScore WITH ThoughtControlAbilityCompositeScore
  /MISSING=LISTWISE.

GRAPH
  /SCATTERPLOT(BIVAR)=VerbalIntelligenceTestCompositeScore WITH CognitiveInterferenceCompositeScore
  /MISSING=LISTWISE.

*** Ran an explore command to determine the outliers of each composite***

EXAMINE VARIABLES=AcademicSelfConceptCompositeScore ThoughtControlAbilityCompositeScore 
    CognitiveInterferenceCompositeScore VerbalIntelligenceTestCompositeScore
  /PLOT BOXPLOT STEMLEAF HISTOGRAM
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES EXTREME
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

***Operationalized Knowledge of IO: Knowledge of I/O is the composite scores for Though Control Ability, Cognitive Interference,
    Verbal Intelligenc, and Academic Self Concept***    
    
 ***Test plan for assessing this knowledge of IO***
