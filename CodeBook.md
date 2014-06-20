# Code Book
In this document, I will explain how the script, run_analysis.R, works with the snippets of the codes.

Note that for this project, we have 5 tasks to complete, which are also the steps taken in the script:

1. Merges the training and the test sets to create one data set
2. Extracts only the measurements on the mean and standard deviation for each measurement
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject

In the following I'll explain each steps in detail.

## 1. Merges the training and the test sets to create one data set
In order to handle the data, the first thing to do must be reading in the data sets. Therefore, I used:

```
X_train <- as.matrix(read.table("UCI HAR Dataset/train/X_train.txt"))
y_train <- as.matrix(read.table("UCI HAR Dataset/train/y_train.txt"))

X_test <- as.matrix(read.table("UCI HAR Dataset/test/X_test.txt"))
y_test <- as.matrix(read.table("UCI HAR Dataset/test/y_test.txt"))

subject_train <- as.matrix(read.table("UCI HAR Dataset/train/subject_train.txt"))
subject_test <- as.matrix(read.table("UCI HAR Dataset/test/subject_test.txt"))
```