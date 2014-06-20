# Code Book
In this document, I will explain how the script, run_analysis.R, works with the snippets of the codes.

Note that for this project, we have 5 tasks to complete, which are also the steps taken in the script:

1. Merges the training and the test sets to create one data set
2. Extracts only the measurements on the mean and standard deviation for each measurement
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject

In the following I'll explain each steps in detail.

### 1. Merges the training and the test sets to create one data set
In order to handle the data, the first thing to do must be reading in the data sets. Therefore, I used:

```
X_train <- as.matrix(read.table("UCI HAR Dataset/train/X_train.txt"))
y_train <- as.matrix(read.table("UCI HAR Dataset/train/y_train.txt"))

X_test <- as.matrix(read.table("UCI HAR Dataset/test/X_test.txt"))
y_test <- as.matrix(read.table("UCI HAR Dataset/test/y_test.txt"))

subject_train <- as.matrix(read.table("UCI HAR Dataset/train/subject_train.txt"))
subject_test <- as.matrix(read.table("UCI HAR Dataset/test/subject_test.txt"))
```
Note that the read in tables are converted to matrix to avoid the values read in as types other than numeric (we only want numeric in this case.)

And the merging steps are done with the help of a combination of `cbind` and `rbind`:

```
merge_train <- cbind(subject_train, y_train, X_train)
merge_test <- cbind(subject_test, y_test, X_test)
data <- rbind(merge_train, merge_test)
```

After the merging, don't forget to transform the matrices back to data.frame in order for the later operations:

```
data <- data.frame(data)
```

### 2. Extracts only the measurements on the mean and standard deviation for each measurement
This task is simple. For the mean of each measurements (variables), we do the following:
```
colMeans(data, na.rm = TRUE)
```
I take care of the NA values to avoid any missing values will result in means as NA.

And for the standard deviation, we do the following:
```
apply(data, 2, sd)
```

### 3. Uses descriptive activity names to name the activities in the data set
Here I use a for loop to loop through all of the values in column 2, which is the column storing the encoded activity information. And I replaced the encoded activity with their activity names in strings.
```
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
```

### 4. Appropriately labels the data set with descriptive variable names.
Instead of putting all of the descriptive variable names into the code, I read in the activity names from the file and store them into the variable `names_file`, then assign this to `names(data)` concatenated with variable names `subject` and `activity` (since when merging them earlier, I put them in the columns in the front.)

```
names_file <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
names(data) <- c("subject", "activity", names_file[,2])
```

### 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject
I use two separate for loops to compute the means of variables column by column. At the end of each iteration, `cbind` is used to append the newly calculated back to the data frame. Following is the code for variable means grouped by subject. The variable means grouped by activity is the same, just replacing `data$subject` to `data$activity` and store to a different data frame.
```
DT1 <- tapply(data[,3], data$subject, mean)
for (i in 4:ncol(data)){
  DT2 <- tapply(data[,i], data$subject, mean)
  DT1 <- cbind(DT1, DT2)
}
DT1 <- data.frame(DT1)
names(DT1) <- names_file[,2]
data_subject <- DT1
```

After both the data set grouped by subject and activity are done, I use `write.fwf` to write out the processed tidy data sets into fixed-width format. Don't forget to include `library(gdata)` so that the function `write.fwf()` will work.
```
library(gdata)
write.fwf(data_subject, "data_subject.txt", rownames = TRUE)
write.fwf(data_activity, "data_activity.txt", rownames = TRUE)
```