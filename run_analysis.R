## 0. Download and unzip the data file
## URL of source data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

## Download data (zip file).
fileName <- "UCIdata.zip"   ## name of destination file
if (!file.exists(fileName)) {
    download.file(fileUrl, fileName, method = "curl")
}

## Unzip the file.
unzip(fileName, files = NULL, exdir = ".")

## 1. Merge the training and the test sets to create one data set
## Read text files from "test" folder
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")

## Read text files from "train" folder
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")

## Add column name for subject files
names(subject_train) <- "SubjectID"
names(subject_test) <- "SubjectID"

## Add column names for measurement files
features <- read.table("UCI HAR Dataset/features.txt")
names(X_train) <- features$V2
names(X_test) <- features$V2

## Add column name for label files
names(Y_train) <- "Activity"
names(Y_test) <- "Activity"

## Combine files into a single dataset
train <- cbind(subject_train, Y_train, X_train)
test <- cbind(subject_test, Y_test, X_test)
merged_data <- rbind(train, test)

## 2. Extract only the measurements on the mean and standard deviation
## for each measurement

## Find columns that contain "mean()" and "std()"
mean_and_std_measurements <- grepl("mean\\(\\)", names(merged_data)) |
    grepl("std\\(\\)", names(merged_data))

## Keep also the subjectID and activity columns
mean_and_std_measurements[1:2] <- TRUE

## Remove unnecessary columns
merged_data <- merged_data[, mean_and_std_measurements]

## 3. Use descriptive activity names to name the activities in the data set

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
activity <- activity_labels$V2
merged_data$Activity <- factor(merged_data$Activity, labels = activity)

## 4. Label the data set with descriptive variable names
names(merged_data) <- gsub("^t", "Time", names(merged_data))
names(merged_data) <- gsub("^f", "Frequency", names(merged_data))
names(merged_data) <- gsub("-mean\\(\\)", "Mean", names(merged_data))
names(merged_data) <- gsub("-std\\(\\)", "StdDev", names(merged_data))
names(merged_data) <- gsub("BodyBody", "Body", names(merged_data))

## 5. From the data set in step 4, create a second, independent tidy data set 
## with the average of each variable for each activity and each subject.    

## Load reshape2 package.
library(reshape2)

## Melt and cast.
melted_data <- melt(merged_data, id = c("SubjectID", "Activity"))
tidy_data <- dcast(melted_data, SubjectID+Activity ~ variable, mean)

## Write to file.
write.table(tidy_data, "tidy_data.txt", row.names=FALSE)



