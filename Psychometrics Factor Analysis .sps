* Encoding: UTF-8.
﻿* Encoding: UTF-8.

DATASET ACTIVATE DataSet1.

*Q1. The item level frequencies indicate to what degree does a person agree with the question on extroversion (extroversion factor from the five factor model of personality.)*
*Q2. Missing data is not a substantial problem in this data set, the amount of missing dtat makes up less than 2% of each item. Though towards the end 
such as questions Q290-299 more 20 or more responses were missing which can indicate that the number of questions were skipped or something about the item itself
made particpants not respond* 
   

FREQUENCIES VARIABLES=q1 q7 q22 q33 q34 q45 q46 q47 q50 q56 q57 q59 q96 q97 q101 q102 q106 q108 
    q116 q128 q139 q151 q157 q158 q159 q163 q176 q177 q186 q204 q210 q213 q219 q231 q234 q256 q274 q290 
    q295 q296 q299
  /STATISTICS=STDDEV VARIANCE MINIMUM MAXIMUM MEAN MEDIAN MODE
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.

*Q3. There are no abbarent erros in the data, but Q47 and q97 has 1 data entry error that will be recoded as missing. Also missing data was coded as 9 and will be recoded to reflect 
    just as system missing for all items.*

RECODE q1 q7 q22 q33 q34 q45 q46 q47 q50 q56 q57 q59 q96 q97 q101 q102 q106 q108 
    q116 q128 q139 q151 q157 q158 q159 q163 q176 q177 q186 q204 q210 q213 q219 q231 q234 q256 q274 q290 
    q295 q296 q299 (1=1) (2=2) (3=3) (4=4) (5=5) (ELSE=SYSMIS) INTO q1r q7r q22r q33r q34r q45r q46r q47r q50r q56r q57r q59r q96r q97r q101r q102r q106r q108r 
    q116r q128r q139r q151r q157r q158r q159r q163r q176r q177r q186r q204r q210r q213r q219r q231r q234r q256r q274r q290r 
    q295r q296r q299r.
EXECUTE. 

*Re-ran frequencies*
    

FREQUENCIES VARIABLES=q1r q7r q22r q33r q34r q45r q46r q47r q50r q56r q57r q59r q96r q97r q101r q102r q106r q108r 
    q116r q128r q139r q151r q157r q158r q159r q163r q176r q177r q186r q204r q210r q213r q219r q231r q234r q256r q274r q290r 
    q295r q296r q299r
  /STATISTICS=STDDEV VARIANCE MINIMUM MAXIMUM MEAN MEDIAN MODE
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.

*Q4. The shape of the distribution for the composite scores are is normal. There a couple of extreme ouitliers in this data set which can indicate that 
    the answer was not answered with honest intentions or can signal extreme extroversion or introversion depending on how the scale
    was labeled* 

COMPUTE Extroversion=MEAN(q1r,q7r,q22r,q33r,q34r,q45r,q46r, q47r, q50r, q56r, q57r, q59r, q96r, q97r, q101r, q102r, q106r, q108r, 
    q116r, q128r, q139r, q151r, q157r, q158r, q159r, q163r, q176r, q177r, q186r, q204r, q210r, q213r, q219r, q231r, q234r, q256r, q274r, q290r, 
    q295r, q296r, q299r).
VARIABLE LABELS  Extroversion 'Extroversion Score'.
EXECUTE.

EXAMINE VARIABLES=Extroversion
  /PLOT BOXPLOT STEMLEAF HISTOGRAM
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.


*Q5.With a normal distribution for the total score this test would be considered neither hard nor easy. The easiest question would be considered item q47r considered 
the most easeist item with a mean  = 4.31 and more han 80% of particpants choses either 4 or 5 as an asnwer to the item.*
*Respectively q290r would be considered the most difficult with a mean =2.87 and with 46% of respondents scoring betweeen 1 or 2 on the item.*    


*Q6. The least discriminiating item is q33r at 17.6% corrected item - total correlation and q102r is the most discriminating at 67.6% correctected item - toal correlation.*

RELIABILITY
  /VARIABLES=q1r q7r q22r q33r q34r q45r q46r q47r q50r q56r q57r q59r q96r q97r q101r q102r q106r 
    q108r q116r q128r q139r q151r q157r q158r q159r q163r q176r q177r q186r q204r q210r q213r q219r 
    q231r q234r q256r q274r q290r q295r q296r q299r
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE
  /SUMMARY=TOTAL CORR.

*Q7. Almost all items are correlated with each other at either the >.001 or >.005 significant level, with few exceptions such as q33r having no significant correlation to q236r and q177r.*
    
CORRELATIONS
  /VARIABLES=q1r q7r q22r q33r q34r q45r q46r q47r q50r q56r q57r q59r q96r q97r q101r q102r q106r 
    q108r q116r q128r q139r q151r q157r q158r q159r q163r q176r q177r q186r q204r q210r q213r q219r 
    q231r q234r q256r q274r q290r q295r q296r q299r
  /PRINT=TWOTAIL NOSIG FULL
  /MISSING=PAIRWISE.

*Q8.According to Kaisers Criterion there are  for 5 factors with Eigan values greater than point 1. The first factor accounting for around 28% 
    of variance. Looking at Katel Scree Plot the elbo seems to begin at 5 indicating there are 4 factors a case can be made for 5 but starting at factor 5,6, and 7 all 
    are close on the plot so once can make a case for a 5th factor. I attempted to run a parallel analysis but encountered some erros, on my Mac with the program and 
    the website I used did not help narrow down the factors. I will go with Scree plot and say there are 4 factors* 


FACTOR
  /VARIABLES q1r q7r q22r q33r q34r q45r q46r q47r q50r q56r q57r q59r q96r q97r q101r q102r q106r 
    q108r q116r q128r q139r q151r q157r q158r q159r q163r q176r q177r q186r q204r q210r q213r q219r 
    q231r q234r q256r q274r q290r q295r q296r q299r
  /MISSING LISTWISE 
  /ANALYSIS q1r q7r q22r q33r q34r q45r q46r q47r q50r q56r q57r q59r q96r q97r q101r q102r q106r 
    q108r q116r q128r q139r q151r q157r q158r q159r q163r q176r q177r q186r q204r q210r q213r q219r 
    q231r q234r q256r q274r q290r q295r q296r q299r
  /PRINT UNIVARIATE INITIAL KMO EXTRACTION ROTATION
  /FORMAT BLANK(.10)
  /PLOT EIGEN
  /CRITERIA MINEIGEN(1) ITERATE(25)
  /EXTRACTION PAF
  /CRITERIA ITERATE(25)
  /ROTATION PROMAX(4)
  /SAVE REG(ALL)
  /METHOD=CORRELATION.

FACTOR
  /VARIABLES q1r q7r q22r q33r q34r q45r q46r q47r q50r q56r q57r q59r q96r q97r q101r q102r q106r 
    q108r q116r q128r q139r q151r q157r q158r q159r q163r q176r q177r q186r q204r q210r q213r q219r 
    q231r q234r q256r q274r q290r q295r q296r q299r
  /MISSING LISTWISE 
  /ANALYSIS q1r q7r q22r q33r q34r q45r q46r q47r q50r q56r q57r q59r q96r q97r q101r q102r q106r 
    q108r q116r q128r q139r q151r q157r q158r q159r q163r q176r q177r q186r q204r q210r q213r q219r 
    q231r q234r q256r q274r q290r q295r q296r q299r
  /PRINT UNIVARIATE INITIAL KMO EXTRACTION ROTATION
  /FORMAT BLANK(.15)
  /PLOT EIGEN
  /CRITERIA MINEIGEN(1) ITERATE(25)
  /EXTRACTION PAF
  /CRITERIA ITERATE(25)
  /ROTATION PROMAX(4)
  /SAVE REG(ALL)
  /METHOD=CORRELATION.

FACTOR
  /VARIABLES q1r q7r q22r q33r q34r q45r q46r q47r q50r q56r q57r q59r q96r q97r q101r q102r q106r 
    q108r q116r q128r q139r q151r q157r q158r q159r q163r q176r q177r q186r q204r q210r q213r q219r 
    q231r q234r q256r q274r q290r q295r q296r q299r
  /MISSING LISTWISE 
  /ANALYSIS q1r q7r q22r q33r q34r q45r q46r q47r q50r q56r q57r q59r q96r q97r q101r q102r q106r 
    q108r q116r q128r q139r q151r q157r q158r q159r q163r q176r q177r q186r q204r q210r q213r q219r 
    q231r q234r q256r q274r q290r q295r q296r q299r
  /PRINT UNIVARIATE INITIAL KMO EXTRACTION ROTATION
  /FORMAT BLANK(.2)
  /PLOT EIGEN
  /CRITERIA MINEIGEN(1) ITERATE(25)
  /EXTRACTION PAF
  /CRITERIA ITERATE(25)
  /ROTATION PROMAX(4)
  /SAVE REG(ALL)
  /METHOD=CORRELATION.

*Q9. The theoretical structure is replicated. 
