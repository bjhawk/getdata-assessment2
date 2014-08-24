Getting and Cleaning Data - Assessment 2
=========================================
  
## run_analysis.R  
**NB** This script is to be run from a working directory of the 'UCI HAR Dataset' Folder! 
  
  
This file does exactly as it is titled: it takes the data from the UCI
dataset and translates it into a smaller, tidier dataset. The code is well documented
should there be any questions as to the specifics of how it works, but generally here
is a rundown of its functionality:  
    1. For each dataset (training and testing) the analysis code pulls the data from
      the text files and appends columns for the subject and activity of each row from
      the corresponding file for such data.  
    2. The script then combines the two into a single dataset.
    3. The script then drops all columns that are not a measurement of standard deviation
      or mean, leaving 81 feature columns.  
    4. The averages each of those features and ends up with one row per subject
      per activity, with the average of each feature, for a total of 14580 rows and 83 columns. This is
      then saved as our "tidy" dataset.  

##Structure of the data  
As Mentioned above, the tidy dataset produced by the analysis script as a very simple
structure. The features documentation below is directly from the features.txt file
included in the original dataset:

>The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

>Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

>Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

>These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

>* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

>The set of variables that were estimated from these signals are: 

>* mean(): Mean value
* std(): Standard deviation
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency  

You'll notice the tidy dataset has "Avg-" appended in front of all the above feature columns. This is to signify that we have taken the average of each of these per activity per subject, and included only one average value for each feature by these two factors.