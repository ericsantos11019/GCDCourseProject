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
  
  featuresIndex <- read.table(file.path(dataFolder, featuresFile), 
                              col.names = c("id", "features"))
  activityIndex <- read.table(file.path(dataFolder, activityLabelsFile), 
                              col.names = c("id", "labels"))
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
                                 col.names = "id")
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
                                col.names = "id")
  
  # Test measurements (the 'core' of the test data).
  testData <- read.table(file.path(testFolder, testDataFile), 
                         col.names = featuresIndex$features)
  
  ##############################################################################
  # STEP 1) MERGE THE TRAINING AND TEST SETS TO CREATE ONE DATA SET.
  ##############################################################################
  # Creation of the activities map. This data frame maps the vector of the
  # activity IDs for the training and test data to their respective activity
  # label, using the 'activityIndex' data frame. We use 'join()' instead of 
  # 'merge()' in this case because we want to preserve the order of the 
  # 'xxxActivityIDs' rows. We'll use the map later on to replace the activityIDs
  # with the corresponding activity labels.
  trainActivitiesMap <- join(trainActivityIDs, activityIndex, by = "id")
  testActivitiesMap <- join(testActivityIDs, activityIndex, by = "id")
  
  # Construction of the full data sets for the training and the test data. The
  # data set has the following format:
  # |---------------------------------------------------------------------|
  # | subjectID | ActivityLabel | Feature 1 | Feature 2 | ... | Feature n |
  # |---------------------------------------------------------------------|
  trainActivityLabels <- data.frame(activity = 
                                      as.character(trainActivitiesMap$labels))
  testActivityLabels <- data.frame(activity = 
                                     as.character(testActivitiesMap$labels))
  
  trainDataset <- cbind(trainSubjectIDs, trainActivityLabels, trainData)
  testDataset <- cbind(testSubjectIDs, testActivityLabels, testData)
  
  fullDataset <- rbind(trainDataset, testDataset)
#}