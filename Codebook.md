#Data Codebook
##Getting and Cleaning Data Course Project

The tidy data set returned from the “run_analisys()” R script (and saved as a TXT file named “tidy_dataset.txt”) is the result of a series of processing steps over the original raw data.

The processed data combines a set of TXT files as inputs, which contain the data itself (divided into training and test groups), the variable names (called “features” in the original data set), the list of 30 subjects (for both the training and test groups) and the activity performed by each subject.

For each subject and activity, the sensor data from accelerometer and gyroscope is read and stored as a floating point measurement for a extensive set of features.

The tidy data set contains the following variables:

1. **“activity”:** the activity performed by the subject during this particular measurement. Can be one of the following: 
		WALKING
		WALKING_UPSTAIRS
		WALKING_DOWNSTAIRS
		SITTING
		STANDING
		LAYING
2. **”subject”:** the subject ID for this particular row or measurement. An integer number from 1 to 30.