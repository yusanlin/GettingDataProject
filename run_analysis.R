# ------------------------------------------------------------------------------------------
# 1. Merges the training and the test sets to create one data set.
# ------------------------------------------------------------------------------------------
# read in both files
X_train <- as.matrix(read.table("UCI HAR Dataset/train/X_train.txt"))
y_train <- as.matrix(read.table("UCI HAR Dataset/train/y_train.txt"))

X_test <- as.matrix(read.table("UCI HAR Dataset/test/X_test.txt"))
y_test <- as.matrix(read.table("UCI HAR Dataset/test/y_test.txt"))

subject_train <- as.matrix(read.table("UCI HAR Dataset/train/subject_train.txt"))
subject_test <- as.matrix(read.table("UCI HAR Dataset/test/subject_test.txt"))

# merge train and test
merge_train <- cbind(subject_train, y_train, X_train)
merge_test <- cbind(subject_test, y_test, X_test)
data <- rbind(merge_train, merge_test)

# transform back to data.frame
data <- data.frame(data)

# ------------------------------------------------------------------------------------------
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# ------------------------------------------------------------------------------------------
# mean for each measurement
colMeans(data, na.rm = TRUE)

# standard deviation for each measurement
apply(data, 2, sd)

# ------------------------------------------------------------------------------------------
# 3. Uses descriptive activity names to name the activities in the data set
# ------------------------------------------------------------------------------------------
for (i in 1:nrow(data)) {
  if(data[i, 2] == 1){
    data[i, 2] <- "WALKING"
  }
  else if(data[i, 2] == 2){
    data[i, 2] <- "WALKING_UPSTAIRS"
  }
  else if(data[i, 2] == 3){
    data[i, 2] <- "WALKING_DOWNSTAIRS"
  }
  else if(data[i, 2] == 4){
    data[i, 2] <- "SITTING"
  }
  else if(data[i, 2] == 5){
    data[i, 2] <- "STANDING"
  }
  else if(data[i, 2] == 6){
    data[i, 2] <- "LAYING"
  }
}

# ------------------------------------------------------------------------------------------
# 4. Appropriately labels the data set with descriptive variable names.
# ------------------------------------------------------------------------------------------
# read in the feature name file
names_file <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
names(data) <- c("subject", "activity", names_file[,2])

# ------------------------------------------------------------------------------------------
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
# ------------------------------------------------------------------------------------------
# based on each subject
DT1 <- tapply(data[,3], data$subject, mean)
for (i in 4:ncol(data)){
  DT2 <- tapply(data[,i], data$subject, mean)
  DT1 <- cbind(DT1, DT2)
}
DT1 <- data.frame(DT1)
names(DT1) <- names_file[,2]
data_subject <- DT1

# based on each activity
DT1 <- tapply(data[,3], data$activity, mean)
for (i in 4:ncol(data)){
  DT2 <- tapply(data[,i], data$activity, mean)
  DT1 <- cbind(DT1, DT2)
}
DT1 <- data.frame(DT1)
names(DT1) <- names_file[,2]
data_activity <- DT1

# write out the two new tidy data set to files
library(gdata)
write.fwf(data_subject, "data_subject.txt", rownames = TRUE)
write.fwf(data_activity, "data_activity.txt", rownames = TRUE)