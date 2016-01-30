## Data Codebook
### Coursera Data Science Specialization 
### Getting and Cleaning Data – Course Project

The tidy data set returned from the “`run_analisys()`” R script (and saved as a TXT file named “`tidy_dataset.txt`”) is the result of a series of processing steps over the original raw data.

The processed data combines the data in a set of TXT files (divided into training and test groups), the variable names (called “features” in the original data set), the list of 30 subject IDs (for both the training and test groups) and the activity IDs performed by each subject (which are then replaced by more descriptive activity names).

For each subject and activity, the sensor data from accelerometer and gyroscope is read and stored as a floating point measurement for an extensive set of features.

The tidy data set contains the following variables:

1. **Column 1 – “`activity`”:** A character vector indicating the activity performed by the subject during that particular measurement. Can be one of the following:

		“WALKING”
		“WALKING_UPSTAIRS”
		“WALKING_DOWNSTAIRS”
		“SITTING”
		“STANDING”
		“LAYING”
		
2. **Column 2 – ”`subject`”:** An integer from 1 to 30 indicating the subject ID for this particular row or measurement.
3. **Remaining Columns:** Each column indicate the signal acquired from the actual device sensors and the estimated quantity calculated from these signals.

	Each variable represents the measurement on the body linear acceleration and angular velocity in time-domain representation:
	
		“timeBodyAcceleration”
		“timeBodyGyro”
		
	which were then derived in time to obtain jerk signals: 
	
		“timeBodyAccelerationJerk”
		“timeBodyGyroJerk”
		
	Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm:  
	
		“timeBodyAccelerationMag”
		“timeGravityAccelerationMag”
		“timeBodyAccelerationJerkMag”
		“timeBodyGyroMag”
		“timeBodyGyroJerkMag”
	
	A Fast Fourier Transform (FFT) was applied to some of these signals producing frequency-domain equivalents:
	
		“frequencyBodyAcceleration”
		“frequencyBodyAccelerationJerk”
		“frequencyBodyGyro”
		“frequencyBodyAccelerationJerkMag”
		“frequencyBodyGyroMag”
		“frequencyBodyGyroJerkMag”
	
	Finally, each variable name is appended by two suffixes: (a) an indication of the estimated quantity for that particular measurement (“`Mean`” for average or “`Std`” for standard deviation) and (b) the axis along which the measurement was taken (“`X`”, “`Y`” or “`Z`”).
	