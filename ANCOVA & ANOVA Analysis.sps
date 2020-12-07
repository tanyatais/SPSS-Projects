* Encoding: UTF-8.

*** Screened Data***

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=Condition PreProductivity PostProductivity PostUpSell PreUpSell 
    CustomerCommentsPost CustomerCommentsPre
  /ORDER=ANALYSIS.

*** Ran a t-test to compare training groups, there was only one factor and two groups, therefore an ANOVA was not ran as it is typically used for two of more factors 
and/or two are more groups that are being manipulated 
simultaneously***

T-TEST GROUPS=Condition(1 0)
  /MISSING=ANALYSIS
  /VARIABLES=CustomerCommentsPre CustomerCommentsPost PreProductivity PostProductivity PostUpSell 
    PreUpSell
  /CRITERIA=CI(.95). 

***Ran a univariate analysis to see the impact of training on productivity, selling and customer feedback seperately, this will allow the analyzation of the training worked by comparing 
the mans of preactivity and post activity***

***Ran an ANCOVA for post productivity after training of managers controlling for pre-productivity activity***

UNIANOVA PostProductivity BY Condition WITH PreProductivity
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /SAVE=COOK
  /EMMEANS=TABLES(Condition) WITH(PreProductivity=MEAN) COMPARE ADJ(LSD)
  /PRINT ETASQ DESCRIPTIVE HOMOGENEITY
  /CRITERIA=ALPHA(.05)
  /DESIGN=PreProductivity Condition.

***Ran an ANCOVA for post curstomer comments after training of managers by controlling for pre customer comments activity ***

UNIANOVA CustomerCommentsPost BY Condition WITH CustomerCommentsPre
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /SAVE=COOK
  /EMMEANS=TABLES(Condition) WITH(CustomerCommentsPre=MEAN) COMPARE ADJ(LSD)
  /PRINT ETASQ DESCRIPTIVE HOMOGENEITY
  /CRITERIA=ALPHA(.05)
  /DESIGN=CustomerCommentsPre Condition.

***Ran an ANCOVA for upsell opprotunties created after training of managers controlling for pre-upsell activities***

UNIANOVA PostUpSell BY Condition WITH PreUpSell
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /SAVE=COOK
  /EMMEANS=TABLES(Condition) WITH(PreUpSell=MEAN) COMPARE ADJ(LSD)
  /PRINT ETASQ DESCRIPTIVE HOMOGENEITY
  /CRITERIA=ALPHA(.05)
  /DESIGN=PreUpSell Condition.

