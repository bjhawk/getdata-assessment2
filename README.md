Getting and Cleaning Data - Assessment 2
=========================================
  
** run_analysis.R  
This file does exactly as it is titled: it takes the data from the UCI
dataset and translates it into a smaller, tidier dataset. The code is well documented
should there be any questions as to the specifics of how it works, but generally here
is a rundown of its functionality:  
  1.For each dataset (training and testing) the analysis code pulls the data from
    the text files and appends columns for the subject and activity of each row from
    the corresponding file for such data.  
  2.The script then combines the two into a single dataset.
  3.The script then drops all columns that are not a measurement of standard deviation
    or mean, leaving 81 feature columns.  
  4.The averages each of those features and ends up with one row per subject per activity,
    with the average of each feature, for a total of 14580 rows and 83 columns. This is
    then saved as our "tidy" dataset.  

**Structure of the data