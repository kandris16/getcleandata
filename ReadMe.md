#Creation of a Tidy Dataset in R#

Course project for the "Getting and Cleaning data" course in the Data Science specialization offered by Johns Hopkins University. 


##The Raw Data##

The features (561 of them) are unlabeled and can be found in the X test.txt. The activity labels are in the y_test.txt file. The test subjects are in the subject_test.txt file.
The same holds for the training set.


##The Script##

 * **Name**:run_analysis.R 
 * **Task**: merges the test and training sets together, creates a new, tidy dataset by the steps explained in the CodeBook.md file. 
 * **Prerequisites**:The working directory has to be the (unzipped) 'UCI HAR Dataset' folder

####What the script does - in short###
* After merging the teste and train datasets, modifications (cleaning, labeling, etc.) explained in the CodeBook.md file are made on the raw dataset.
* **Output**: creation of a tidy dataset called 'finalDataSet' containing the means of all the columns per test subject and per activity. 
The tidy dataset is available as a tab-delimited file called final.txt in this repository.


####What the script contains and does - in long###

> First few lines contain the preliminary settings (reading in files, requiring packages).*
	
1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement.

3. Uses descriptive activity names to name the activities in the data set.

4. Appropriately labels the data set with descriptive variable names.

5. From the data set in step 4, creates a second, independent tidy data set (called finalDataSet) with the average of each variable for each activity and each subject.

In the script (run.analysis.R) one can find further comments explaining each part of the code.

##The Codebook

The CodeBook.md file explains the transformations performed along with the resulting data and variables.