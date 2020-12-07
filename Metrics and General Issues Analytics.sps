* Encoding: UTF-8.
            ***Screened the data items from v4-v20, no problems were dtermined to arise. The amount of missing data was less then  
           3% in each item which in this screen I deem to be small variable factor compared to the amount of responses in the datatset fro v4-v20***
           
  ***Ran descriptive statistics to analyze variables individually as well***

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17 v18 v19 v20
   /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN MEDIAN MODE
  /ORDER=ANALYSIS.

COMPUTE Workcentarlity=MEAN(v13 to v20).
EXECUTE.

      ***Using the work centarlity variable mean, a descriptive statistics was ran to determine what the outliers were. As well as better analyze the frequency of such responses*** 
      The avg in terms of frequency of answers v13-v20 mean responses are around 2.00 with some answers showing a mean avg of 9 and 1 which are at the extreme ends of the scale which show our 
      outliers of those who chose one answer choice for a response to v13-v20*** 

FREQUENCIES VARIABLES=Workcentarlity
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN MEDIAN MODE
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.

            ***Analyzed Data based on segments by country***

SORT CASES  BY v3.
SPLIT FILE LAYERED BY v3.


              ***Ran segmented data descriptive statistics on variables v13-v20*** 

DESCRIPTIVES VARIABLES=v13 to v20
  /STATISTICS=MEAN STDDEV MIN MAX.

*** independent sample T-test was ran to find and differences between USA and Russia, and differences between Spain and Japan Respectively for v13-v20***

***USA and Russia***
   ***Results from 2579 particapants (N= 1698 - Russia, N= 1228 - Spain) showed that Russia (M=2.33, SD=1.35) had no significant difference for workcentarlity than USA (M=2.25, SD=1.52)***
   *** t (2924) = -1.593, p >.05 (two-tailed)***
   
T-TEST GROUPS=v3(6 18)
  /MISSING=ANALYSIS
  /VARIABLES=Workcentarlity
  /CRITERIA=CI(.95).

***Spain and Japan***
   ***Results from 2579 particapants (N= 1353 - Spain, N= 1226 - Japan) showed that Japan (M=2.55, SD=0.874) had significantly different workcentarlity than Spain (M=2.34, SD=1.19)***
   *** t (2577) = -5.117, p < .05 (two-tailed).***

T-TEST GROUPS=v3(13 24)
  /MISSING=ANALYSIS
  /VARIABLES=Workcentarlity
  /CRITERIA=CI(.95).

***Correlation was ran to detrmine correlation between importance score and "Time in paid job v4, the work centarlity variable only calculates importamce variables from v13-v20***
***Variables v21-v24 which also cover responses related to imporatance was not included in the correlation. ***

    *** The importance score, (workcentarlity) was signifcantly related to time in paid job, r = 0.223, p < .001.***

CORRELATIONS
  /VARIABLES=v4 Workcentarlity
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.
