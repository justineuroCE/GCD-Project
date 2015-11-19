### README.md

#### Introduction

The files in this repository are for the analyses of data from the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).  The zipped data file for the aforementioned study can be downloaded from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).  The analyses are being conducted as part of the requirements of the Coursera Course: Getting and Cleaning Data by Jeff Leek, PhD, Roger D. Peng, PhD, Brian Caffo, PhD (https://class.coursera.org/getdata-034/human_grading/view/courses/975118/assessments/3/submissions).

#### List of files

The files in this directory are:  

* **README.md** --- this file
* **README.html** --- a *rmarkdown + markdown*-processed version of README.md in HTML format
* **LICENSE** --- license file for the contents of this folder
* **.gitignore**
* **r_analysis.R**  --- an R script used for the analyses that does the following:
    + Goal 1. Merges the training and the test sets to create one data set.
    + Goal 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    + Goal 3. Uses descriptive activity names to name the activities in the data set
    + Goal 4. Appropriately labels the data set with descriptive variable names. 
    + Goal 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* **r_analysis.html** --- an RStudio Notebook compile output of a run of r_analysis.R in HTML format
* **CodeBook.md** --- a codebook for the datasets produced by r_analysis.R
* **CodeBook.html** --- a *rmarkdown + markdown*-processed version of CodeBook.md in HTML format 
* **MarkdownHereGitHub.css** --- a stylesheet used for CodeBook.html; it is a modified version of that by [Vasily Polovnyov](mailto:vast@whiteants.net) (obtained from [Markdown Here v.2.6.3](https://github.com/adam-p/markdown-here) by Adam Pritchard); provisions that make the font-size 11 px for plain code blocks were added 
* **diagnostics.txt** --- a sink file; contains frequency tables for the number of observations by subject and some partial printouts of the required datasets
* **tableFreqSubjectByActivity.txt** --- frequency table for the number of observations by subject and activity

#### How to use run_analysis.R

To use **run_analysis.R**, which is a regular R-script:

* put it in the directory containing the data folder which should be named UCI_HAR_Dataset (modify the script, as appropriate, if you would rather name your data folder otherwise)
* source it at the command prompt of your RStudio console or at the R command line prompt with `source("run_analysis.R")`

Among other things, **run_analysis.R** creates the following data frames/data tables and external files:

* **diagnostics.txt** - a sink file containing some useful supplementary information and intermediate results (a copy is in this directory); the top part of this file contains frequency tables containing information of test/train status, and the number of observations (trials) obtained per subject while the bottom part contains a frequency distribution table on the number of observations obtained by subject and acitivty
* **dataAll** - contains the merged the train and test dataset (**dataAll** has 10299 rows and 4+9\*128 = 1156 columns); a partial printout can be found in the file **diagnostics.txt** located in this same directory
* **dataMeansSdsAll** - contains only the means and standard deviations (sds) of the nine variables that were experimentally measured (the x-, y-, z- components of  each of the following three: 1) body acceleration; 2) angular velocity; 3) total acceleration); the statistics (means and sds) were each based on a set of 128 measurements (**dataMeansSdsAll** has 10299 rows and 18 columns; this was saved to the external file *MeansandSdsMeasurements.txt*---10300 saved lines that included a first line header containing the 18 variable names---and uploaded to the course site)
* **dataMeansByActsAll** - contains the overall means, by subject and by activity, of each of the nine variables that were experimentally measured;  this data frame has 30\*6 = 180 rows and 3+9 = 12 columns (*ID*, *testOrTrain*, *activity*, and overall means of the nine variables); a partial printout can be found in the file **diagnostics.txt** located in this same directory


#### Acknowledgments

With special thanks to [R](http://www.R-project.org/) (R Core Team,2015), [RStudio](https://www.rstudio.com/products/rstudio/) (R Studio Team, 2012), [dplyr](URL: https://github.com/hadley/dplyr) (Wickham  and Francois, 2015), [data.table](https://github.com/Rdatatable/data.table/wiki) (Dowle et al., 2015), [markdown (in R)](URL: https://github.com/rstudio/markdown) (Allaire et al., 2015), [rmarkdown](http://rmarkdown.rstudio.com) (Allaire et al, 2015), [knitr](http://yihui.name/knitr/) (Xie et al., 2015), [pandoc](http://johnmacfarlane.net/pandoc) (MacFarlane, 2014), and [Markdown](http://daringfireball.net/projects/markdown/) (Gruber, 2004).

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/80x15.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">GCD-Project</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/justineuroCE/GCD-Project" property="cc:attributionName" rel="cc:attributionURL">Justine Leon A. Uro</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.<br />Based on a work at <a xmlns:dct="http://purl.org/dc/terms/" href="https://github.com/justineuroCE/GCD-Project" rel="dct:source">https://github.com/justineuroCE/GCD-Project</a>.