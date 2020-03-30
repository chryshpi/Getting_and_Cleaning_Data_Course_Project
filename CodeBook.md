# Code Book

***
## The Data
***

The data downloaded from <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip> was collected through an experiment involving participants requested to perform six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) while wearing a smartphone (Samsung Galaxy S II) on the waist.

Full description of the dataset is found in <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>.

Initially, the script checks if the data file is already present in the working directory. If not, it downloads the data from the given url and unzips the file in the working directory. It then reads the data from the different text files of the original data set.

* Test set ("UCI HAR Dataset/test")
    * subject_test : subject IDs for test 
    * X_test : measurements from test data 
    * Y_test : test labels 
    
* Training set ("UCI HAR Dataset/train")    
    * subject_train : subject IDs for train 
    * X_train : measurements from training data 
    * Y_train : training labels

* features : list/description of all variables
* activity_labels : links the class labels with their activity names

***
## Analysis
***

1. Training and test datasets are merged to create one data set. 
2. Mean and standard deviation for each measurement are extracted from the merged data.
3. Class labels for activity are replaced with activity names.
4. Column names are replaced with descriptive labels.
5. A second, independent tidy data set containing the average of each variable for each activity and subject is created.

**IMPORTANT!** run_analysis.R requires `reshape2` package. Be sure to install the package before running the script.
