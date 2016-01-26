run_analysis <- function()
{
  # PREPARATION STEP 1: LOADING OF COMMON DATA
  dataFolder <- "UCI HAR Dataset"
  activityLabelsFile <- "activity_labels.txt"
  featuresFile <- "features.txt"
  
  # Loading of the features index table.
  featuresIndex <- read.table(file.path(dataFolder, featuresFile), 
                              col.names = c("id", "features"))
  
  # Loading of the activity label index table.
  activityIndex <- read.table(file.path(dataFolder, activityLabelsFile), 
                              col.names = c("id", "labels"))
  #-----------------------------------------------------------------------------
  # PREPARATION STEP 2: LOADING OF TEST DATA
  testSubjectsFile <- "subject_test.txt"
  testDataFile <- "X_test.txt"
  yTestFile <- "y_test.txt"
  testFolder <- file.path(dataFolder, "test")
  
  # Loading of the list of subjects for test data. One subject per row.
  testSubjectIDs <- read.table(file.path(testFolder, testSubjectsFile), 
                               col.names = "subject")
  
  # Loading of the test activity IDs. One activity ID per row.
  testActivityIDs <- read.table(file.path(testFolder, yTestFile), 
                                col.names = "id")
  
  # Merging of the test activity IDs vector with the activity index. We use
  # 'join()' instead of 'merge()' in this case because we want to preserve the
  # order of the 'testActivityIDs' rows.
  testActivitiesMap <- join(testActivityIDs, activityIndex, by = "id")
  #-----------------------------------------------------------------------------
  # PREPARATION STEP 3: LOADING OF TRAIN DATA
  trainSubjectsFile <- "subject_train.txt"
  trainDataFile <- "X_train.txt"
  yTrainFile <- "y_train.txt"
  trainFolder <- file.path(dataFolder, "train")
  
  # Loading of the list of subjects for train data. One subject per row.
  trainSubjectIDs <- read.table(file.path(trainFolder, trainSubjectsFile), 
                                col.names = "subject")
  
  # Loading of the train activity IDs. One activity ID per row.
  trainActivityIDs <- read.table(file.path(trainFolder, yTrainFile), 
                                 col.names = "id")
  
  # Merging of the test activity IDs vector with the activity index. We use
  # 'join()' instead of 'merge()' in this case because we want to preserve the
  # order of the 'testActivityIDs' rows.
  trainActivitiesMap <- join(trainActivityIDs, activityIndex, by = "id")
}