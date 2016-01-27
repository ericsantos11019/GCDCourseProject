#run_analysis <- function()
#{
  library(plyr)
  library(dplyr)
  
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
                                col.names = "subject")
  
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
                               col.names = "subject")
  
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
  meanIndex <- grep("mean", featuresIndex$features, ignore.case = TRUE) + 2
  stdIndex <- grep("std", featuresIndex$features, ignore.case = TRUE) + 2
  indexes <- sort(c(1:2, meanIndex, stdIndex))
  meanStdDataset <- select(fullDataset, indexes)
  
  ##############################################################################
  # STEP 3) USE DESCRIPTIVE ACTIVITY NAMES THE ACTIVITIES IN THE DATA SET
  ##############################################################################
  meanStdDataset$activity <- activityIndex[meanStdDataset$activity, 1]
#}