## README
### Coursera Data Science Specialization
### Getting and Cleaning Data – Course Project

#### Introduction

The “`run_analysis`” R script defines the “`run_analysis()`” function that require no input parameters.

The function automatically sets the current working directory to the folder containing the R script itself. It then ensures that the function will always run from the correct working directory and that the relative paths defined later on will work. This is accomplished by the following simple call:

	newWD <- getSrcDirectory(function(x) {x})
	
which defines a dummy function inside the same R script and gets its source directory.

The function also defines a set of helper variables that store all relevant folder and file names.

#### Reading Data

The execution starts by reading all pertinent files and storing the loaded data in corresponding variables. The reading routine is divided into three parts: (I) reading the common data (“`activity_labels.txt`” and “`features.txt`”, which represent row and column names, respectively); (II) reading training data (“`X_train`” and “`y_train`” containing measurements and subject IDs); (III) reading test data (same as before, but for files “`X_test`” and “`y_test`”).

#### Merging Data

The following step is to “assemble” the complete dataset through two “`cbind()`” calls, which merge the subject IDs (one per row), the activity IDs (also one per row) to the data values themselves (both for training and test data), followed by one “`rbind()`” call to merge both training and test data together (one on top of the other.

#### Extracting Mean and Standard Deviation Measurements

Next, the mean and standard deviation measurements are extracted from the data by means of a sequence of “`grep()`” calls followed by a column selection through the “`select()`” function (from the “`dplyr`” package).
