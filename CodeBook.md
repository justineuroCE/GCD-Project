---
author: "J.L.A. Uro"
output:
  html_document:
    css: MakrDownHereGitHub.css
    keep_md: yes
  pdf_document: default
---
# **CODE BOOK**

The data for this project are from the publication:  

> Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L.
> Reyes-Ortiz. Human Activity Recognition on Smartphones using a 
> Multiclass Hardware-Friendly Support Vector Machine. International 
> Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz,  
> Spain. Dec 2012

#### **Experimental Design**

The description of the experiments conducted for the purpose of obtaining the data is given below and are excerpts from the README.txt that comes with the zipped data folder.

> The experiments have been carried out with a group of 30 volunteers within an 
> age bracket of 19-48 years. Each person performed six activities (WALKING, 
> WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a 
> smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer 
> and gyroscope, we captured 3-axial linear acceleration and 3-axial angular 
> velocity at a constant rate of 50Hz. The experiments have been video-recorded 
> to label the data manually. The obtained dataset has been randomly partitioned 
> into two sets, where 70% of the volunteers was selected for generating the 
> training data and 30% the test data. 

> The sensor signals (accelerometer and gyroscope) were pre-processed by applying 
> noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 
> 50% overlap (128 readings/window). The sensor acceleration signal, which has 
> gravitational and body motion components, was separated using a Butterworth 
> low-pass filter into body acceleration and gravity. The gravitational force is 
> assumed to have only low frequency components, therefore a filter with 0.3 Hz 
> cutoff frequency was used. From each window, a vector of features was obtained 
> by calculating variables from the time and frequency domain. See 
> 'features\_info.txt' for more details. 

#### **Datasets**

The project required us to write R codes for creating three (3) datasets: 1) raw data by merging the train and test datasets; 2) tidy data (TIDY DATA 1)containing only the means and standard deviations (sds); 3) tidy data (TIDY DATA 2) containing the average of each variable by subject (30 subjects) and activity (6 activities).


#### **Raw Data (Goal 1)**

The raw data included the variables for: 1) subject number (**ID**); 2) test/train data indicator variable (**testOrTrain**); 3) activity (**acts**); 4) 384 (3 x 128) variables for the three components (x,y, and z) of the triaxial acceleration (**bodyAccX1** to **bodyAccX128**, **bodyAccY1** to **bodyAccY128**, and **bodyAccZ1** to **bodyAccZ128**); 5) 384 variables for the three components (x,y, and z) of the triaxial angular velocity (**bodyGyroX1** to **bodyGyroX128**, **bodyGyroY1** to **bodyGyroY128**, and **bodyGyroZ1** to **bodyGyroZ128**); 6) 384 variables of the three components of the total acceleration (**totAccX1**  to **totAccX128**, **totAccY1** to **totAccY128**, and **totAccZ1** to **totAccZ128**).  This gave a total of **1155** raw dataset variables (3 non-experimentally-measured variables and 1152 experimentally-measured variables).  Strictly speaking, the raw data contained only 9 experimentally-measured variables (*bodyAccX*, *bodyAccY*, *bodyAccZ*, *bodyGyroX*, *bodyGyroY*, *bodyGyroZ*, *totAccX*, *totAccY*, and *totAccZ*) with 128 measurements for each variable (per variable, a window contained 128 measured values per observation  and 9 x 128 = 1152).  

The **features** statistics (561 per subject per trial) in the file X\_train.txt\/X\_test.txt (from either the train or test sub-folder of the main data folder) were not included in the raw dataset.

The values of the variables (except testOrTrain) were either read from the following files of the main data folder: 

* ID - train/subject\_train.txt or test/subject\_test.txt
* (testOrTrain - created based on folder name and ID information)
* acts - train/y\_train.txt or test/y\_test.txt
* bodyAccX# - train\/Inertial Signals\/body_acc\_x\_train.txt or test\/Inertial Signals\/body_acc\_x\_test.txt
* bodyAccY# - train\/Inertial Signals\/body_acc\_y\_train.txt or test\/Inertial Signals\/body_acc\_y\_test.txt
* bodyAccZ# - train\/Inertial Signals\/body_acc\_z\_train.txt or test\/Inertial Signals\/body_acc\_z\_test.txt
* bodyGyroX# - train\/Inertial Signals\/body_gyro\_x\_train.txt or test\/Inertial Signals\/body_gyro\_x\_test.txt
* bodyGyroY# - train\/Inertial Signals\/body_gyro\_y\_train.txt or test\/Inertial Signals\/body_gyro\_y\_test.txt
* bodyGyroZ# - train\/Inertial Signals\/body_gyro\_z\_train.txt or test\/Inertial Signals\/body_acc\_z\_test.txt
* totAccX# - train\/Inertial Signals\/tot_acc\_x\_train.txt or test\/Inertial Signals\/tot_acc\_x\_test.txt
* totAccY# - train\/Inertial Signals\/tot_acc\_y\_train.txt or test\/Inertial Signals\/tot_acc\_y\_test.txt
* totAccZ# - train\/Inertial Signals\/tot_acc\_z\_train.txt or test\/Inertial Signals\/tot_acc\_z\_test.txt  
(*for the latter nine (9) variables, the \#  is an integer from 1 to 128*)

There were no missing values in the datasets for train and test.  The train dataset contained 7352 lines (all observations; no header) based on 21 subjects (ID: 1, 3, 5, 6, 7, 8, 11,14, 15, 16, 17, 19, 21, 22, 23, 25, 26, 27, 28, 29, and 30) while the test dataset contained 2947 lines (all observations; no header) based on 9 subjects (ID: 2, 4, 9, 10, 12, 13, 18, 20, 24).  See discussion after Table 4  below for the R codes used for obtaining these.

Below is a table that contains further information regarding these 1155 variables.  After Table 1, I give an explanation regarding the relevant portions of the R script **run_ananlysis.R** that deal with the creation of this raw merged dataset.


##### **Table 1: Information regarding 1155 variables in merged (train+test) dataset** 

Variable|Description|Type|Values|Add'l Info
--------|-----------|----|------|-----------
ID|Subject ID|integer|1 to 30|21 train IDs, 9 test IDs
testOrTrain|Indicates train or test data|categorical|TRAIN|train data
 \ |||TEST|test data
acts|Type of activity|ordinal|1|“WALKING”
 \ |||2|“WALKING_UPSTAIRS”
 \ |||3|“WALKING_DOWNSTAIRS”
 \ |||4|“SITTING”
 \ |||5|“STANDING”
 \ |||6|“LAYING”
bodyAccX1 to bodyAccX128|Triaxial acceleration – x component; 128 measurements in standard gravity units 'g'|continuous|real| [-1,1]
bodyAccY1 to bodyAccY128|Triaxial acceleration – y component; 128 measurements in standard gravity units 'g'|continuous|real| [-1,1]
bodyAccZ1 to bodyAccZ128|Triaxial acceleration – z component; 128 measurements in standard gravity units 'g'|continuous|real| [-1,1]
bodyGyroX1 to bodyGyroX128|Triaxial angular velocity – x component; 128 measurements in radians/second|continuous|real| [-1,1]
bodyGyroY1 to bodyGyroY128|Triaxial angular velocity – y component; 128 measurements in radians/second|continuous|real| [-1,1]
bodyGyroZ1 to bodyGyroZ128|Triaxial angular velocity – z component; 128 measurements in radians/second|continuous|real| [-1,1]
totAccX1 to totAccX128|Total acceleration – x component; 128 measurements in standard gravity units 'g'|continuous|real| [-1,1]
totAccY1 to totAccY128|Total acceleration – y component; 128 measurements in standard gravity units 'g'|continuous|real| [-1,1]
totAccZ1 to bodyAccZ128|Total acceleration – z component; 128 measurements in standard gravity units 'g'|continuous|real| [-1,1]
 \ |||| \ |

To create the merged raw dataset:

* Step 1 --- Preliminary steps.
    + a sink file (*diagnostics.txt*) was opened to contain the R output meant for the console (lines 20-21); this was closed in line 252
    + libraries: *dplyr* and *data.table* were loaded (lines 26-28)
    + activity labels were loaded into the data frame *activities*; then a function, *actConv*, for transforming the activity codes (1 to 6) to meaningful labels was created  (lines 35-42) 
* Step 2 --- I created the R function, **constructData**, that, among other things, constructed the train/test datasets from the nine (9) train/test measurement files (containing 128 measurements per observation; one (1) file for a variable) for either the **train** or **test** dataset.  These are in lines 45-95 of **run\_analysis.R**.  The first part of this function and its last command (line 45-79, 94):
    + loads data to construct a column of subject IDs called *idNum* (data frame) and tabulates the IDs  (lines 49-53)
    + loads the activity codes into the data frame *actCd* (lines 55-56)
    + loads the numerical measurements from the nine files in the Inertial Signals folder and attaches an appropriate variable label for the column label (lines 58-68)
    + creates the train/test indicator variable *testOrTrain* 
    + binds together *idNum*, *testOrTrain*, *actCd*, *bodyAccX*, *bodyAccY*, *bodyAccZ*, *bodyGyroX*, *bodyGyroY*, *bodyGyroZ*, *totAccX*, *totAccY*, and *totAccZ* (lines 75-76); the variables after *actCd* are each of dimensions 10299 x 128
    + uses the function *actConv* to create an *activity* column containing the descriptive labels WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, or LAYING in lieu of the actCd values of 1 to 6, respectively
    + returns a list containing four elements; the first element is a data frame called *dataPart* and contains the raw data for either *train* or *test* dataset depending on which was specified  
* Step 3 --- I constructed the *train* and *test* dataset using *constructData("train")* and  *constructData("test")*; see lines 102-104.  
* Step 4 --- Finally, I merged the *train* and *test* raw data into the data frame *dataAll* (see lines 120-123) that contained all the variables listed in Table 1.

     
    
#### **TIDY DATA 1: Means and Sds (Goal 2)**

TIDY DATA 1 (dimensions 10299 x 18) contains the means and sds of each experimentally-measured variable for each of the 10299 observation. The means and sds of the nine (9) experimentally-measured variables  (the latter 9 variables from Table 1) were calculated based on the 128 window measurements per variable per observation.  These means and sds were extracted and saved to the file: **MeansAndSdsMeasurements.txt** and was uploaded into the course site as requested.  See the discussion after Table 2 for the R codes.

The data file has 10300 lines (1 header and 10299 lines of observations).  Each line of observation had the means and sds of each of the nine experimentally-measured variables (18 columns).  The header contains the 18 variable names given in Table 2.

##### **Table 2: TIDY DATA 1 --- Means and SDs** 

Variable|Description|Type|Values|Add'l Info
--------|-----------|----|------|-----------
bodyAccXMn|Mean triaxial acceleration – x component based on 128 measurements in standard gravity units 'g'|continuous|real| [-1,1]
bodyAccYMn|Mean triaxial acceleration – y component based on 128 measurements in standard gravity units 'g'|continuous|real| [-1,1]
bodyAccZMn|Mean triaxial acceleration – z component based on 128 measurements in standard gravity units 'g'|continuous|real| [-1,1]
bodyGyroXMn|Mean triaxial angular velocity – x component based on 128 measurements in radians/second|continuous|real| [-1,1]
bodyGyroYMn|Mean triaxial angular velocity – y component based on 128 measurements in radians/second|continuous|real| [-1,1]
bodyGyroZMn|Mean triaxial angular velocity – z component based on 128 measurements in radians/second|continuous|real| [-1,1]
totAccXMn|Mean total acceleration – x component based on 128 measurements in standard gravity units 'g'|continuous|real| [-1,1]
totAccYMn|Mean total acceleration – y component based on 128 measurements in standard gravity units 'g'|continuous|real| [-1,1]
totAccZMn|Mean total acceleration – z component based on 128 measurements in standard gravity units 'g'|continuous|real| [-1,1]
bodyAccXSd|SD triaxial acceleration – x component based on 128 measurements in standard gravity units 'g'|continuous|positive| [0,128/127]
bodyAccYSd|SD triaxial acceleration – y component based on 128 measurements in standard gravity units 'g'|continuous|positive| [0,128/127]
bodyAccZSd|SD triaxial acceleration – z component based on 128 measurements in standard gravity units 'g'|continuous|positive| [0,128/127]
bodyGyroXSd|SD triaxial angular velocity – x component based on 128 measurements in radians/second|continuous|positive| [0,128/127]
bodyGyroYSd|SD triaxial angular velocity – y component based on 128 measurements in radians/second|continuous|positive| [0,128/127]
bodyGyroZSd|SD triaxial angular velocity – z component based on 128 measurements in radians/second|continuous|positive| [0,128/127]
totAccXSd|SD total acceleration – x component based on 128 measurements in standard gravity units 'g'|continuous|positive| [0,128/127]
totAccYSd|SD total acceleration – y component based on 128 measurements in standard gravity units 'g'|continuous|positive| [0,128/127]
totAccZSd|SD total acceleration – z component based on 128 measurements in standard gravity units 'g'|continuous|positive| [0,128/127]
 \ |  |  |  | \ |  

To create a dataset for the means and standard deviations of the nine variables (**Goal 2**), I continued off from Step 4 for creating the raw dataset but included the additional steps that are in the second part of the **constructData** function (lines 82-88, 94).

* Step 2 (continued) --- The second part of the **constructData** function:  
    + creates a list containing the nine 10299 x 128 data frames for the variables in the study (line 84)
    + uses *sapply* to apply to each of the nine elements of the list a function that uses *apply* to get the row means of each of these nine list elements (see lines 85); data frame dataMeans that contains all the variable means (10299 x 9) is created in this step
    + attaches appropriate column names (line 86) 
    + similar steps for the standard deviations (sds); see lines 86-88; the data frame dataSds that contains all the variable sds (10299 x 9) is created
    + includes *dataMeans* and *dataSds* as elements (2nd and 3rd) of a list that the function **constructData** returns (line 94)
* Step 5 --- From the 2nd and 3rd list elements of the *train* and *test* datasets obtained in Step 3 for creating the merged raw dataset, I constructed a dataset that contained only the means and sds of the nine variables; the means and sds datasets for each of *train* and *test* were bound by columns (2nd and 3rd elements of the list), then these two column-bound datasets that resulted were bound by rows (see lines 125-140).
* Step 6 --- Finally, **write.table** was used to create the dataset for uploading (line 141).


#### **TIDY DATA 2: Overall Means of the Varaibles by Subject and Activity (Goal 5)**

TIDY DATA 2 contains the means of the nine variables in the study by subject (30 IDs) and activity (six activities).  TIDY DATA 2 (dimensions: 30 x 8) reduces the number of rows of TIDY DATA 1 from 10299 to 30 as there are only 30 subjects (21 for train and 9 for test).  However, the columns in TIDY DATA 2 includes *ID*, *testOrTrain*, and six times more experimentally-measured variables (as there are 6 activities) than TIDY DATA 1.  See Table 3 below for a listing of the variables.

##### **Table 3: TIDY DATA 2 --- Mean of the Mean Variable Measurements (from TIDY DATA 1) by Subject and Activity**
Variable|Description|Type|Values|Add'l Info
--------|-----------|----|------|-----------
ID|Subject ID|integer|1 to 30|21 train IDs, 9 test IDs
testOrTrain|Indicates train or test data|categorical|TRAIN|train data
\  |                        |   |TEST|test data
bodyAccXMnActs1 to bodyAccXMnActs6|Mean triaxial acceleration – x component; six activities;  in standard gravity units 'g'|continuous|real|1 “WALKING”, 2 “WALKING\_UPSTAIRS”, 3 “WALKING\_DOWNSTAIRS”, 4 “SITTING”, 5 “STANDING”, 6 “LAYING”
bodyAccYMnActs1 to  bodyAccYMnActs6|Mean triaxial acceleration – y component; six activities; in standard gravity units 'g'|continuous|real| "
BodyAccZMnActs1 to bodyAccZMnActs6|Mean triaxial acceleration – z component; six activities; in standard gravity units 'g'|continuous|real|  "
bodyGyroXMnActs1 to bodyGyroXMnActs6|Mean triaxial angular velocity – x component; six activities; in radians/second|continuous|real|  "
bodyGyroYMnActs1 to bodyGyroYMnActs6|Mean triaxial angular velocity – y component; six activities; in radians/second|continuous|real|  "
bodyGyroZMnActs1 to bodyGyroZMnActs6|Mean triaxial angular velocity – z component; six activities| in radians/secondcontinuous|real|  "
totAccXMnActs1 to totAccXMnActs6|Mean total acceleration – x component; six activities; in standard gravity units 'g'|continuous|real|  "
totAccYMnActs1 to totAccYMnActs6|Mean total acceleration – y component; six activities; in standard gravity units 'g'|continuous|real|  "
totAccZMnActs1 to totAccZMnActs6|Mean total acceleration – z component; six activities; in standard gravity units 'g'|continuous|real|  "
\ |||| \ |

For Goal 5, to get the overall means (means of means) of the nine variables in the study: 

* Step 7 --- I created the R function **createMeanVar** that takes a data frame (10299 x 9) containing the means of one of the nine variables then calculates the mean of the means (row means), an activity at a time, by subject ID.  The image of **createMeanVar** is a data frame of dimension 30 x 1 (30 subjects as rows, mean of means of the variable specified as column).  See lines 150-205.
* Step 8 --- I then used **createMeanVar** to process the nine data frames of variable means to get nine 30 x 1 data frames of overall means.  The ID, testOrTrain, and these nine data frames were bounded column-wise to produce a data frame with dimensions 30 x 11.  See lines 212-226. 


#### **Supplementary Information**

As supplementary information, I also constructed a frequency table that contained information on the number of observations that were eventually used for the calculation of the means and sds per subject and activity.  These were written out into the file **tableFreqSubjectByActivity.txt**.

##### **Table 4: Supplementary Information --- Subject by Activity Frequency (Info on number of measurements on which overall variable means were based)**
Variable|Description|Type|Values|Add'l Info
--------|-----------|----|------|-----------
ID|Subject ID|integer|1 to 30|21 train IDs, 9 test IDs
testOrTrain|Indicates train or test data|categorical|TRAIN|train data
\ |||TEST|test data
WALKING|number of observations by subject obtained for activity: WALKING|integer|| \ |
WALKING\_UPSTAIRS|number of observations by subject obtained for activity: WALKING\_UPSTAIRS|integer|| \ |
WALKING\_DOWNSTAIRS|number of observations by subject obtained for activity: WALKING\_DOWNSTAIRS|integer|| \ |
SITTING|number of observations by subject obtained for activity: SITTING|integer|| \ |
STANDING|number of observations by subject obtained for activity: STANDING|integer|| \ |
LAYING|number of observations by subject obtained for activity: LAYING|integer|| \ |
\ |||| \ |

Using the R commands like the ones below (see lines 98-113), I got the number of observations obtained per subject in the study for both the *train* and *test* datasets (these were printed out in the file diagnostics.txt).  
```
dataTrain<-constructData("train") # these contains a list with four elements
cat("\n Number of trials (observations) per subject (including all 6 activities): train data \n")
print(dataTrain[[4]])
cat("Total train observations: ", sum(dataTrain[[4]]),"\n")
```

     Number of trials (observations) per subject (including all 6 activities): train data 
    idNum
      1   3   5   6   7   8  11  14  15  16  17  19  21  22  23  25  26  27  28  29  30 
    347 341 302 325 308 281 316 323 328 366 368 360 408 321 372 409 392 376 382 344 383 
    Total train observations:  7352 

A similar set of R commands gave the following frequency table for the *test* dataset:

     Number of trials (observations) per subject (including all 6 activities): test data
    idNum
      2   4   9  10  12  13  18  20  24 
    302 317 288 294 320 327 364 354 381 
    Total test observations:  2947 


These together with the dataset in **tableFreqSubjectByActivity.txt** give information as to how many observations contribute information to each overall mean calculated in Goal 5.  For example, subject with ID=1 is in the train dataset and had 347 observations of which 50 were for activity 1-WALKING,  47 for 2-WALKING\_UPSTAIRS,  53 for 3-WALKING\_DOWNSTAIRS, 95 for 4-SITTING, 95 for 5-STANDING, and 49 for 6-LAYING.

Lastly, the following **sessionInfo** details may come in handy for those who want to replicate the results obtained here.
```
> sessionInfo()
R version 3.2.1 (2015-06-18)
Platform: i686-pc-linux-gnu (32-bit)

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_US.UTF-8       
 [4] LC_COLLATE=en_US.UTF-8     LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
 [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C              
[10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] dplyr_0.4.3      data.table_1.9.6

loaded via a namespace (and not attached):
 [1] lazyeval_0.1.10 magrittr_1.5    R6_2.1.1        assertthat_0.1  parallel_3.2.1  DBI_0.3.1      
 [7] htmltools_0.2.6 tools_3.2.1     yaml_2.1.13     Rcpp_0.12.1     rmarkdown_0.8.1 digest_0.6.8   
[13] chron_2.3-47   
```


#### **Acknowledgments**

With special thanks to [R](http://www.R-project.org/) (R Core Team,2015), [RStudio](https://www.rstudio.com/products/rstudio/) (R Studio Team, 2012), [dplyr](URL: https://github.com/hadley/dplyr) (Wickham  and Francois, 2015), [data.table](https://github.com/Rdatatable/data.table/wiki) (Dowle et al., 2015), [markdown (in R)](URL: https://github.com/rstudio/markdown) (Allaire et al., 2015), [rmarkdown](http://rmarkdown.rstudio.com) (Allaire et al, 2015), [knitr](http://yihui.name/knitr/) (Xie et al., 2015), [pandoc](http://johnmacfarlane.net/pandoc) (MacFarlane, 2014), and [Markdown](http://daringfireball.net/projects/markdown/) (Gruber, 2004).

#### **References**

* Allaire, J.J., Horner, J., Marti, V. and N. Porte. (2015).  markdown: 'Markdown' Rendering for R (v. 0.7.7).  URL: https://github.com/rstudio/markdown
* Allaire, J.J., Cheng,J., Xie, Y., McPherson, J., Chang, W., Allen, J., Wickham, H., Atkins, A., and H. Hyndman. (2015). Dynamic Documents for R (v. 0.8.1).  URL: http://rmarkdown.rstudio.com
* Dowle,M., Srinivasan, A., Short, T., and S. Lianoglou.(2015).  data.table: Extension of Data.frame (v. 1.9.6) (with contributions from R. Saporta and E. Antonyan) URL: https://github.com/Rdatatable/data.table/wiki
* Gruber, John. (2004). Markdown (v. 1.0.1).  URL: http://daringfireball.net/projects/markdown/
* MacFarlane, John. (2014). Pandoc: a universal documenter (v. 1.12.3). URL: http://pandoc.org/
* R Core Team. (2015).  R: A Language and Environment for Statisitical Computing. URL: http://www.R-project.org/
* R Studio Team 2012. (2012).  RStudio version 0.98.953.  URL: https://www.rstudio.com/products/rstudio/ 
* Wickham, H. and R. Francois. (2015). dplyr: A Grammar of Data Manipulation (v. 0.4.3).  URL: https://github.com/hadley/dplyr
* Xie, Y., Vogt, A., Andrew, A., Zvoleff, A., Simon, A., Atkins, A., Manton, A., and 59 others. (2015).  knitr: A General-Purpose Package for Dynamic Report Generation in R (v. 1.11).  URL: http://yihui.name/knitr/  

