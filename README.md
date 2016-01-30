## README
### Coursera Data Science Specialization
### Getting and Cleaning Data – Course Project

#### 1) Introduction

The “`run_analysis`” R script defines the “`run_analysis()`” function with no arguments.

It automatically sets the working directory to the folder containing the R script itself. This ensures that the relative paths defined later on will work, even if the user didn’t set the working directory previously. The trick is accomplished with the following code:

	newWD <- getSrcDirectory(function(x) {x})
	
which defines an auxiliary dummy function inside the same R script and gets its source directory.

The function also defines a set of helper variables that store all relevant folder and file names that will be used in other parts of code, especially when reading data.

#### 2) Reading Data

The code reads all pertinent files from disk and stores the loaded data in corresponding variables. The reading routine is divided into three parts: (I) reading the data that is common to both training and test groups (“`activity_labels.txt`” and “`features.txt`”); (II) reading training group data (“`subject_train.txt`”, “`X_train.txt`” and “`y_train.txt`”); (III) reading test group data (“`subject_test.txt`”, “`X_test.txt`” and “`y_test.txt`”).

The “`subject_train.txt`” and “`subject_test.txt`” files contain the subject IDs for the training and test groups. The “`y_train.txt`” and “`y_test.txt`” contain the activity IDs for both groups. The “`X_train.txt`” and “`X_test.txt`”, on the other hand, contain the measurements themselves. When reading the data itself (“`X_train.txt`” and “`X_test.txt`” files), the string vector created from “`features.txt`” is used as column (variable) names. This will prove useful later on.

#### 3) Merging Data

The following step is to “assemble” the complete dataset using two “`cbind()`” calls, which merge the subject IDs (one per row), the activity IDs (also one per row, which will be mapped later to the actual activity names) and the measurement values. This is done separately for the training and test groups, followed by one “`rbind()`” call to stack the training and test data on top of one another.

#### 4) Extracting Mean and Standard Deviation Measurements

Next, the mean and standard deviation measurements are extracted from the data by means of a sequence of “`grep()`” calls along the variable names (to find out the column numbers containing “mean” and “std” suffixes), followed by a column selection along the full data set through the “`select()`” function (from the “`dplyr`” package).

This task is further facilitated by the fact that we already used the strings in the “`features.txt`” file as variable names when reading the data from disk.

#### 5) Using Descriptive Activity Names for Activities in the Data Set

This step consists on replacing the activity IDs (integers from 1 to 6) with the proper activity names. This is quite simples as we can use the column with the activity IDs to index the “`activityIndex`” variable created from the “`activity_labels.txt`” file and then replacing the original column with the generated string vector:

	meanStdDataset$activity <- activityIndex[meanStdDataset$activity, 1]

#### 6) Relabelling Variables

The variable names are then replaced by more descriptive counterparts by a sequence of “`gsub()`” calls and by some use of regular expressions (*e.g.* to locate standalone “t”s and “f”s at the beginning of variable names). The new variable name vector is then assigned to the data by calling “`colnames()`”.

At this point, the full dataset is exported to the “`processed_dataset.txt`” file, using the “`write.table()`” function.

#### 7) Creating a Second, Independent, Tidy Data Set

Finally, the second, independent, tidy data set, as required by the project definition, is created by grouping the data by activity (first) and subject ID (second), through a single call to “`group_by()`” (which can take multiple arguments for groups), and then through a call to “`summarize_each()`” using “`mean`” as the “`funs()`” argument. Both functions are also part of the “`dplyr`” package.

The summarized data is both exported to the “`tidy_dataset.txt`” file and returned from the function call encapsulated as a “`tbl_df`” object for better printing.

All processing steps are printed during execution through calls to the “`message()`” function to indicate progress.
