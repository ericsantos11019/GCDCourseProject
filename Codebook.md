#Data Codebook
##Getting and Cleaning Data Course Project

The tidy data set returned from the “run_analisys()” R script (and saved as a TXT file named “tidy_dataset.txt”) is the result of a series of processing steps over the original raw data.

The processed data combines a set of TXT files as inputs, which contain the data itself (divided into training and test groups), the variable names (called “features” in the original data set), the list of 30 subjects (for both the training and test groups) and the activity performed by each subject.

For each subject and activity, the sensor data from accelerometer and gyroscope is read and stored as a floating point measurement for a extensive set of features.

The tidy data set contains the following variables:

1. **“activity”:** A character vector indicating the activity performed by the subject during this particular measurement. Can be one of the following:

		“WALKING”
		“WALKING_UPSTAIRS”
		“WALKING_DOWNSTAIRS”
		“SITTING”, “STANDING”
		“LAYING”.
		
2. **”subject”:** An integer from 1 to 30 indicating the subject ID for this particular row or measurement.
3. **Subsequent Variables:** The remaining columns in the data set indicate the signal acquired from the actual sensors and the estimated quantity calculated from these signals.

	Each variable represents the measurement on the body linear acceleration and angular velocity (“timeBodyAcc” or “timeBodyGyro”), which were then derived in time to obtain Jerk signals (“timeBodyAccJerk” and “timeBodyGyroJerk”). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (“timeBodyAccMag”, “timeGravityAccMag”, “timeBodyAccJerkMag”, “timeBodyGyroMag”, “timeBodyGyroJerkMag”).
	
	A Fast Fourier Transform (FFT) was applied to some of these signals producing frequency-domain equivalents (“frequencyBodyAcc”, “frequencyBodyAccJerk”, “frequencyBodyGyro”, “frequencyBodyAccJerkMag”, “frequencyBodyGyroMag”, “frequencyBodyGyroJerkMag”).
	
	Finally, each variable name is appended by two suffixes: (a) an indication of the estimated quantity for that particular measurement (“Mean” for average or “Std” for standard deviation) and (b) the axis along which the measurement was taken (“X”, “Y” or “Z”).
	