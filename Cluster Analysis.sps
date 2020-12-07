* Encoding: UTF-8.
*** Screened Data missing more than 50% of all the data in each item, which will skew the data, also calls us to think on why mor ethan half of the managers have not filled out the survey items***
    
FREQUENCIES VARIABLES=Task1 Task2 Task3 Task4 Task5 Task6 Task7 Task8 Task9 Task10 Task11 Task12 Task13 Task14 Task15 Task16 Task17 Task18 
    Task19 Task20 Task21 Task22 Task23 Task24 TeamServiceBehavior1 TeamServiceBehavior2 TeamServiceBehavior3 TeamServiceBehavior4 
    TeamServiceBehavior5 TeamServiceBehavior6 CustomerSatisfaction
  /STATISTICS=MAXIMUM
  /ORDER=ANALYSIS.

***Looking at any outliers and extreme numbers in the data***

EXAMINE VARIABLES=TeamServiceBehavior1 TeamServiceBehavior2 TeamServiceBehavior3 TeamServiceBehavior4 
    TeamServiceBehavior5 TeamServiceBehavior6 CustomerSatisfaction
  /PLOT BOXPLOT HISTOGRAM
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

*** Ran Heirachical Cluster analysis first in order to identify all cluster possibilities affter looking at the 
agglomeration schedule in excel and the difference between 44 and 43 cluster was -8. There were few numbers of large difference as well. I will run with 16 clusters than narrow down with K-custer means.
***From looking at the table I believe we can narrow down to around 6-7 clusters ***

CLUSTER   Task1 Task2 Task3 Task4 Task5 Task6 Task7 Task8 Task9 Task10 Task11 Task12 Task13 Task14 
    Task15 Task16 Task17 Task18 Task19 Task20 Task21 Task22 Task23 Task24
  /METHOD WARD
  /MEASURE=SEUCLID
  /PRINT SCHEDULE
  /PRINT DISTANCE
  /PLOT DENDROGRAM VICICLE.

*** Ran with 16 clusters***

QUICK CLUSTER Task1 Task2 Task3 Task4 Task5 Task6 Task7 Task8 Task9 Task10 Task11 Task12 Task13 
    Task14 Task15 Task16 Task17 Task18 Task19 Task20 Task21 Task22 Task23 Task24
  /MISSING=LISTWISE
  /CRITERIA=CLUSTER(16) MXITER(10) CONVERGE(0)
  /METHOD=KMEANS(NOUPDATE)
  /SAVE CLUSTER
  /PRINT INITIAL ANOVA CLUSTER DISTAN.

*** Ran with 10 clusters, will rduce cluster to 7 as three of the clusters have less than 3 cases***

QUICK CLUSTER Task1 Task2 Task3 Task4 Task5 Task6 Task7 Task8 Task9 Task10 Task11 Task12 Task13 
    Task14 Task15 Task16 Task17 Task18 Task19 Task20 Task21 Task22 Task23 Task24
  /MISSING=LISTWISE
  /CRITERIA=CLUSTER(10) MXITER(10) CONVERGE(0)
  /METHOD=KMEANS(NOUPDATE)
  /SAVE CLUSTER
  /PRINT INITIAL ANOVA CLUSTER DISTAN.

***Ran with 9 clusters, two clusters were similar in their response***

QUICK CLUSTER Task1 Task2 Task3 Task4 Task5 Task6 Task7 Task8 Task9 Task10 Task11 Task12 Task13 
    Task14 Task15 Task16 Task17 Task18 Task19 Task20 Task21 Task22 Task23 Task24
  /MISSING=LISTWISE
  /CRITERIA=CLUSTER(9) MXITER(10) CONVERGE(0)
  /METHOD=KMEANS(NOUPDATE)
  /SAVE CLUSTER
  /PRINT INITIAL ANOVA CLUSTER DISTAN.

***Ran with 8 clusters as the variables had less than 3 participants in it***

QUICK CLUSTER Task1 Task2 Task3 Task4 Task5 Task6 Task7 Task8 Task9 Task10 Task11 Task12 Task13 
    Task14 Task15 Task16 Task17 Task18 Task19 Task20 Task21 Task22 Task23 Task24
  /MISSING=LISTWISE
  /CRITERIA=CLUSTER(8) MXITER(10) CONVERGE(0)
  /METHOD=KMEANS(NOUPDATE)
  /SAVE CLUSTER
  /PRINT INITIAL ANOVA CLUSTER DISTAN.

***Ran with 5 clusters***

QUICK CLUSTER Task1 Task2 Task3 Task4 Task5 Task6 Task7 Task8 Task9 Task10 Task11 Task12 Task13 
    Task14 Task15 Task16 Task17 Task18 Task19 Task20 Task21 Task22 Task23 Task24
  /MISSING=LISTWISE
  /CRITERIA=CLUSTER(5) MXITER(10) CONVERGE(0)
  /METHOD=KMEANS(NOUPDATE)
  /SAVE CLUSTER DISTANCE
  /PRINT INITIAL ANOVA CLUSTER DISTAN.

*** Ran a boxplot to figure out differences between the clusters and view outliers in this group***

EXAMINE VARIABLES=QCL_8 BY QCL_7
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL.

***Ran with 4 clusters***

QUICK CLUSTER Task1 Task2 Task3 Task4 Task5 Task6 Task7 Task8 Task9 Task10 Task11 Task12 Task13 
    Task14 Task15 Task16 Task17 Task18 Task19 Task20 Task21 Task22 Task23 Task24
  /MISSING=LISTWISE
  /CRITERIA=CLUSTER(4) MXITER(10) CONVERGE(0)
  /METHOD=KMEANS(NOUPDATE)
 /SAVE CLUSTER DISTANCE
  /PRINT INITIAL ANOVA CLUSTER DISTAN.


*** Ran a boxplot to figure out differences between the clusters and view outliers in this group, these 4 clusters have significant difference from each other that I  stop here
as the 5 clusters also had differences in variables as well but do to the amount of missing data one cluster only had 3 cases in which I thought it would be best to go down to 4 clusters***

EXAMINE VARIABLES=QCL_10 BY QCL_9
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL.

***Ran crosstab to understand the relationship beteween the clusters and the customer service behaviors and customer staisfaction 

CROSSTABS
  /TABLES=QCL_9 BY TeamServiceBehavior1 TeamServiceBehavior2 TeamServiceBehavior3 
    TeamServiceBehavior4 TeamServiceBehavior5 TeamServiceBehavior6 CustomerSatisfaction
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT ROW 
  /COUNT ROUND CELL.
