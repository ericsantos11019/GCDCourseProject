## README
### Coursera Data Science Specialization
### Getting and Cleaning Data – Course Project

#### 1) Introduction

The “`run_analysis`” R script defines the “`run_analysis()`” function with no arguments.

The function automatically sets the current working directory to the folder containing the R script itself. It then ensures that the function will always run from the correct working directory and that the relative paths defined later on will work. This is accomplished by the following simple call:

	newWD <- getSrcDirectory(function(x) {x})
	
which defines a dummy function inside the same R script and gets its source directory.

The function also defines a set of helper variables that store all relevant folder and file names.

#### 2) Reading Data

The execution starts by reading all pertinent files and storing the loaded data in corresponding variables. The reading routine is divided into three parts: (I) reading the common data (“`activity_labels.txt`” and “`features.txt`”, which represent row and column names, respectively); (II) reading training data (“`X_train.txt`” and “`y_train.txt`” containing measurements and subject IDs); (III) reading test data (same as before, but for files “`X_test.txt`” and “`y_test.txt`”).

When reading the data itself (“`X_train.txt`” and “`X_test.txt`” files), the “`features.txt`” strings are used as column names. This will prove useful later on.

#### 3) Merging Data

The following step is to “assemble” the complete dataset through two “`cbind()`” calls, which merge the subject IDs (one per row), the activity IDs (also one per row) to the data values themselves (both for training and test data), followed by one “`rbind()`” call to merge both training and test data together (one on top of the other).

#### 4) Extracting Mean and Standard Deviation Measurements

Next, the mean and standard deviation measurements are extracted from the data by means of a sequence of “`grep()`” calls followed by a column selection through the “`select()`” function (from the “`dplyr`” package).

This task is further facilitated by the fact that we already used the data in the “`features.txt`” file as variable names when reading the actual data for both training and test groups.

#### 5) Relabelling Variables

The variable names are then replaced by more descriptive counterparts by a sequence of “`gsub()`” calls and by some use of regular expressions (*e.g.* to locate standalone “t”s and “f”s at the beginning of variable names. The revamped variable name vector is then assigned to the data by a simple call to “`colnames()`”.

At this step, the full dataset is exported to the “`processed_dataset.txt`” file, using the “`write.table()`” function.

#### 6) Creating a Second, Independent, Tidy Data Set

Finally, the second, independent, tidy data set, contains the averages of each variable for each activity and subject in the complete data set (as required by the project definition) is created first by grouping the data by activity (first) and subject ID (second), through a single call to “`group_by()`” (which can take multiple arguments for groups), and then through a call to “`summarize_each()`” using “`mean`” as the “`funs()`” argument. Both functions are also part of the “`dplyr`” package.

The summarized data is both exported to the “`tidy_dataset.txt`” file and returned from the function call encapsulated as a “`tbl_df`” object for better printing.

All processing steps are printed during execution through calls to the “`message()`” function to indicate progress.
