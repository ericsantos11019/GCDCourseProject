run_analysis <- function()
{
  library(plyr)
  library(dplyr)
  library(stringi)
  
  ##############################################################################
  # STEP 0) READING DATA
  ##############################################################################
  # PART I - READING COMMON DATA (index files for features and activity labels)
  dataFolder <- "UCI HAR Dataset"
  activityLabelsFile <- "activity_labels.txt"
  featuresFile <- "features.txt"
  
  # Index vectors for both features (column names for measurements) and
  # activities (row names for activity IDs). In both cases, we discard the
  # first column (the numbers) and keep only the second (the labels themselves).
  featuresIndex <- read.table(file.path(dataFolder, featuresFile), 
                              col.names = c("id", "features"),
                              stringsAsFactors = FALSE)[2]
  activityIndex <- read.table(file.path(dataFolder, activityLabelsFile), 
                              col.names = c("id", "labels"),
                              stringsAsFactors = FALSE)[2]
  #-----------------------------------------------------------------------------
  # PART II - READING TRAINING DATA (subject IDs, activity IDs and measurements)
  trainSubjectsFile <- "subject_train.txt"
  trainDataFile <- "X_train.txt"
  yTrainFile <- "y_train.txt"
  trainFolder <- file.path(dataFolder, "train")
  
  # List of subject IDs for training data. One subject ID per row.
  trainSubjectIDs <- read.table(file.path(trainFolder, trainSubjectsFile), 
                                col.names = "subjectID")
  
  # List of activity IDs for training data. One activity ID per row.
  trainActivityIDs <- read.table(file.path(trainFolder, yTrainFile), 
                                 col.names = "activity")
  # Training measurements (the 'core' of the training data).
  trainData <- read.table(file.path(trainFolder, trainDataFile), 
                          col.names = featuresIndex$features)
  #-----------------------------------------------------------------------------
  # PART III - READING TEST DATA (subject IDs, activity IDs and measurements)
  testSubjectsFile <- "subject_test.txt"
  testDataFile <- "X_test.txt"
  yTestFile <- "y_test.txt"
  testFolder <- file.path(dataFolder, "test")
  
  # List of subject IDs for test data. One subject ID per row.
  testSubjectIDs <- read.table(file.path(testFolder, testSubjectsFile), 
                               col.names = "subjectID")
  
  # List of activity IDs for test data. One activity ID per row.
  testActivityIDs <- read.table(file.path(testFolder, yTestFile), 
                                col.names = "activity")
  
  # Test measurements (the 'core' of the test data).
  testData <- read.table(file.path(testFolder, testDataFile), 
                         col.names = featuresIndex$features)
  
  ##############################################################################
  # STEP 1) MERGE THE TRAINING AND TEST SETS TO CREATE ONE DATA SET.
  ##############################################################################
  # We don't need to use 'merge()' at all here. A simple 'cbind()' should do the
  # trick, since we are only assembling tables.
  trainDataset <- cbind(trainSubjectIDs, trainActivityIDs, trainData)
  testDataset <- cbind(testSubjectIDs, testActivityIDs, testData)
  
  fullDataset <- rbind(trainDataset, testDataset)
  
  ##############################################################################
  # STEP 2) EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION
  #         FOR EACH MEASUREMENT
  ##############################################################################
  # This could be solved with a single command:
  #     'select(fullDataSet, 1:2, contains("mean"), contains("std"))'
  # but we want to select the columns in the same order as they appear in the
  # 'fullDataset' variable. So, instead, we first search the occurrences of 
  # 'mean' and 'std' in the features index, add the first two columns and sort
  # the resulting vestor, before passing it to the 'select()' call.
  columnNames <- colnames(fullDataset)
  meanIndex <- grep("mean...", columnNames, fixed = TRUE)
  stdIndex <- grep("std...", columnNames, fixed = TRUE)
  indexes <- sort(c(1:2, meanIndex, stdIndex))
  meanStdDataset <- select(fullDataset, indexes)
  
  ##############################################################################
  # STEP 3) USE DESCRIPTIVE ACTIVITY NAMES THE ACTIVITIES IN THE DATA SET
  ##############################################################################
  meanStdDataset$activity <- activityIndex[meanStdDataset$activity, 1]
  
  ##############################################################################
  # STEP 4) APPROPRIATELY LABEL THE DATASET WITH DESCRIPTIVE VARIABLE NAMES
  ##############################################################################
  # The thing to have in mind here is that we already set the variable names
  # for the dataset using the 'featuresIndex' variable in Step 0, parts II and
  # III. By default R will automatically replace any non-alphanumeric character 
  # or period in a data set header (the variable names) with a period. That
  # means all the parenthesis ('(' and ')'), dashes ('-') and commas from the 
  # variable names have already been stripped by R standard behavior. We only
  # need to worry about the dots now.
  
  # First, we read the current variable names.
  newColumnNames <- colnames(meanStdDataset)
  
  # Next, we want to find out those variables whose names START with 'f' or 't'
  # to change them to more meaningful terms. For that, we use the 'stringi'
  # package functions, which facilitate string manipulation in R.
  f <- stri_startswith_fixed(newColumnNames, "f")
  t <- stri_startswith_fixed(newColumnNames, "t")
  
  # Then we replace those initial 'f's and 't's with 'frequency' and 'time',
  # respectively.
  newColumnNames[f] <- sub("f", "frequency", newColumnNames[f], fixed = TRUE)
  newColumnNames[t] <- sub("t", "time", newColumnNames[t], fixed = TRUE)
  
  # Finally, we finish the cleanup by adjusting capitalization and removing
  # dots.
  newColumnNames <- gsub("mean", "Mean", newColumnNames, fixed = TRUE)
  newColumnNames <- gsub("std", "Std", newColumnNames, fixed = TRUE)
  newColumnNames <- gsub(".", "", newColumnNames, fixed = TRUE)
  colnames(meanStdDataset) <- newColumnNames
  
  ##############################################################################
  # STEP 5) CREATE A SECOND, INDEPENDENT TIDY DATA SET WITH THE AVERAGE OF EACH 
  #         VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT
  ##############################################################################
  # In order to follow the definition above, we group by activity FIRST, and
  # then by subject.
  groupedDataset <- group_by(meanStdDataset, activity, subjectID)
  
  # Now we use 'summarize_each()' to calculate the mean for each group.
  tidyDataset <- summarize_each(groupedDataset, funs(mean))
  
  # Finally, we return the tidy dataset calculated above, converted to tbl_df
  # for nicer printing.
  tbl_df(tidyDataset)
}