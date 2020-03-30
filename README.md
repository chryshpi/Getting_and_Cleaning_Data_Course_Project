## Getting and Cleaning Data Course Project

This repository contains the following files:

* README.md - a file that lists and describes the contents of the repository

* CodeBook.md - a code book describing the data and the transformations/work done to clean up the data

* run_analysis.R - an R script for analyzing data from <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

    + run_analysis.R requires `reshape2` package. Be sure to install the package before running the script.
    + The script creates a tidy data set from the training and test data collected using accelerometers from a Samsung Galaxy S smartphone. 
    + The output is a text file that contains the average of each variable for each activity and subject.