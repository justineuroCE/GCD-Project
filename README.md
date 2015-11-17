### README.md

The files in this repository are for the analyses of data from the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).  The zipped data file for the aforementioned study can be downloaded from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).  The analyses are being conducted as part of the requirements of the Coursera Course: Getting and Cleaning Data by Jeff Leek, PhD, Roger D. Peng, PhD, Brian Caffo, PhD (https://class.coursera.org/getdata-034/human_grading/view/courses/975118/assessments/3/submissions).

The files in this directory are:  

* README.md --- this file
* README.html --- a *knitr*-processed version of README.md
* LICENSE --- license file for the contents of this folder
* .gitignore
* r_analysis.R  --- an R script used for the analyses that does the following:
    + Goal 1. Merges the training and the test sets to create one data set.
    + Goal 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    + Goal 3. Uses descriptive activity names to name the activities in the data set
    + Goal 4. Appropriately labels the data set with descriptive variable names. 
    + Goal 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* r_analysis.html --- an RStudio Notebook output of a run of r_analysis.R in HTML format
* CodeBook.md --- a codebook for the datasets produced by r_analysis.R
* CodeBook.html --- a *knitr*-processed version of CodeBook.md in HTML format 
* MarkdownHereGitHub.css --- a stylesheet for CodeBook.html by [Vasily Polovnyov](vast@whiteants.net) (obtained from [Markdown Here v.2.6.3](https://github.com/adam-p/markdown-here) by Adam Pritchard) 
* diagnostics.txt --- a sink file; contains frequency tables for the number of observations by subject 
* tableFreqSubjectByActivity.txt --- frequency table for the number of observations by subject and activity