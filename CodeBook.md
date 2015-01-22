#CodeBook
##Summary#
####(A reminder of Readme.md)####

* **Data source**

>Human Activity Recognition Using Smartphones Data Set ([url] [1])

[1]: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

* **Data**

>Measurements on human activity 

>* 6 different activities

>* 30 test persons


* **Definition of the features/measurements in the original dataset**

>*(comes from the original 'readme' file and 'features' file)*

>The features selected for the original database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).


##Target Dataset##

 * Average values of the mean and standard deviation on measurements through all subjects (30 pcs) and activities (6 pcs).

 * 2 x 33 = **66 features**/measurements + **Activity labels** + **Subject ID-s**

 * Dimensions: **180 rows** (=30x6)  **68 columns** (= 66+2)


##Feature (Measurement) Selection##

###Main principle:###

 * As the task determines: mean and st dev of measurements

###Other principles and modifications:###
 * angle-variables are excluded
 * mean frequency variables are excluded
 * anyway - only those variables included which have both means and st dev
 * duplication in variable names are removed for avoiding misunderstandings 
(e.g.fBodyBodyGyroJerkMag-mean() -> fBodyGyroJerkMagMean)



These principles are followed and reflected in the script (called run_analysis.R)


###Result of the feature/measurement selection:##

In the target dataset the below listed signals (exactly their means and st 
deviations) are kept:
(*'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.*)


![FeatureNames-Table](https://github.com/kandris16/getcleandata/raw/master/FeaturesTable.png "FeatureNames-Table")


##Additional comments##

* All additional (derived) vectors from the original dataset are excluded.

* All features/measurement are normalized and bounded within [-1,1] in the original and the target datasets as well.

