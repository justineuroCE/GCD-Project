###
## run_analysis.R - R script for carrying out data analysis for data from the
## Human Activity Recognition Using Smartphones Data Set 
## (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
## The following are accomplished by the script:
## Goal 1. Merges the training and the test sets to create one data set.
## Goal 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## Goal 3. Uses descriptive activity names to name the activities in the data set
## Goal 4. Appropriately labels the data set with descriptive variable names. 
## Goal 5. From the data set in step 4, creates a second, independent tidy data set with the 
##          average of each variable for each activity and each subject.
## 
## Author: Justine Leon A. Uro (justineuro.moin@gmail.com)
## Date: 16 November 2015
## For: Coursera Course --- Getting and Cleaning Data
## by Jeff Leek, PhD, Roger D. Peng, PhD, Brian Caffo, PhD
## (https://class.coursera.org/getdata-034/human_grading/view/courses/975118/assessments/3/submissions)
###

# save console output to diagnostics.txt
sink("diagnostics.txt")

# set the working directory (uncomment the setwd() line and set appropriate path) to that containing  # the data folder: UCI_HAR_Dataset
#setwd("/use/correct/path/to/UCI_HAR_Dataset") 

# load libary dplyr, data.table
library("data.table")
library("dplyr")

#####
#### Preliminary steps for Goal 1 and Goal 5.
#### Goal 4 (descriptive naming of variables) is being implemented as each data file is loaded.
#####

# read activity labels from acticvity_labels.txt; 
# assign columnm names "actCodes" and "acts"
activities<-fread("UCI_HAR_Dataset/activity_labels.txt")
colnames(activities)<-c("actCodes","acts")

# function to transform ordinal activity codes (actCd; column name "acts") into
# descriptive values (helps fulfill Goal 4.)
actConv<-function(x){paste(x,"-",activities[x][[2]],sep="")}  


###
## create function constructData for building each of train/test dataset (for Goal 1.)
###
constructData <- function(x) {# x is either "train" or "test"
  # load the id numbers
  idNum <- fread(paste("UCI_HAR_Dataset/",x,"/subject_",x,".txt",sep=""),col.names=c("ID"))
  
  # obtain frequency distribution for number of trials by subject (diagnostic purposes)
  idNumTab<-table(idNum)  
  
  # load the activity codes
  actCd <- fread(paste("UCI_HAR_Dataset/",x,"/y_",x,".txt",sep=""),col.names=c("acts"))
  
  # load the Inertial Signal measurements; nine files; (colnames for Goal 4.)
  # 128 readings per subject 
  bodyAccX<-fread(paste("UCI_HAR_Dataset/",x,"/Inertial Signals/body_acc_x_",x,".txt",sep=""),col.names=paste(rep("bodyAccX",128),1:128,sep=""))
  bodyAccY<-fread(paste("UCI_HAR_Dataset/",x,"/Inertial Signals/body_acc_y_",x,".txt",sep=""),col.names=paste(rep("bodyAccY",128),1:128,sep=""))
  bodyAccZ<-fread(paste("UCI_HAR_Dataset/",x,"/Inertial Signals/body_acc_z_",x,".txt",sep=""),col.names=paste(rep("bodyAccZ",128),1:128,sep=""))
  bodyGyroX<-fread(paste("UCI_HAR_Dataset/",x,"/Inertial Signals/body_gyro_x_",x,".txt",sep=""),col.names=paste(rep("bodyGyroX",128),1:128,sep=""))
  bodyGyroY<-fread(paste("UCI_HAR_Dataset/",x,"/Inertial Signals/body_gyro_y_",x,".txt",sep=""),col.names=paste(rep("bodyGyroY",128),1:128,sep=""))
  bodyGyroZ<-fread(paste("UCI_HAR_Dataset/",x,"/Inertial Signals/body_gyro_z_",x,".txt",sep=""),col.names=paste(rep("bodyGyroZ",128),1:128,sep=""))
  totAccX<-fread(paste("UCI_HAR_Dataset/",x,"/Inertial Signals/total_acc_x_",x,".txt",sep=""),col.names=paste(rep("totAccX",128),1:128,sep=""))
  totAccY<-fread(paste("UCI_HAR_Dataset/",x,"/Inertial Signals/total_acc_y_",x,".txt",sep=""),col.names=paste(rep("totAccY",128),1:128,sep=""))
  totAccZ<-fread(paste("UCI_HAR_Dataset/",x,"/Inertial Signals/total_acc_z_",x,".txt",sep=""),col.names=paste(rep("totAccZ",128),1:128,sep=""))
  
  # create the indicator variable on whether observation is for test or train (for Goal 4.)
  code<-"TRAIN"
  if (x == "test") code<-"TEST"
  testOrTrain<-rep(code,dim(idNum)[1])
  
  # bind the data columns; to be returned later in a list
  dataPart0<-cbind(idNum,testOrTrain,actCd,bodyAccX,bodyAccY,bodyAccZ,bodyGyroX,bodyGyroY,bodyGyroZ,totAccX,totAccY,totAccZ)
  
  # create a descriptive activity variable (column name "acivity"; for Goals 3 and 4.)
  dataPart<-mutate(dataPart0, activity = actConv(acts))
  
  
  # bind only the measurements then calculate mean and sd (for Goal 2.);
  # attach meaningful column names (for Goal 4.)
  dataRaw<-list(bodyAccX,bodyAccY,bodyAccZ,bodyGyroX,bodyGyroY,bodyGyroZ,totAccX,totAccY,totAccZ)
  dataMeans<-sapply(dataRaw,function(x) apply(x,1,mean))
  colnames(dataMeans)<-c("bodyAccXMn","bodyAccYMn","bodyAccZMn","bodyGyroXMn","bodyGyroYMn","bodyGyroZMn","totAccXMn","totAccYMn","totAccZMn")
  dataSds<-sapply(dataRaw,function(x) apply(x,1,sd))
  colnames(dataSds)<-c("bodyAccXSd","bodyAccYSd","bodyAccZSd","bodyGyroXSd","bodyGyroYSd","bodyGyroZSd","totAccXSd","totAccYSd","totAccZSd")
  
  # return dataPart (contains all the raw data); dataMeans (contains only the measurment means);
  # dataSds (contains only the measurement sds);
  # matrix (idNum,testOrTrain) (ID and code for test/train);
  # a frquency table for number of trials per subject (idNumTab) 
  list(dataPart,dataMeans,dataSds,idNumTab)
}


###
## construct the datasets (raw, means sds) using the function constructData defined above
###

# construct the train and test data
dataTrain<-constructData("train") # this contains a list with four elements
dataTest<-constructData("test")   #        "

# print frequency distribution of number of trials (observations) per subject for each 
# of train and test data and write data into file: diagnostics.txt
cat("\n Number of trials (observations) per subject (including all 6 activities): train data \n")
print(dataTrain[[4]])
cat("Total train observations: ", sum(dataTrain[[4]]),"\n")
cat("\n Number of trials (observations) per subject (including all  activities): test data\n")
print(dataTest[[4]])
cat("Total test observations: ", sum(dataTest[[4]]),"\n")


#####
#### Goal 1. Merge training and test datasets. Merging proper.
#####

# raw data
dataTrainAll<-dataTrain[[1]]# this is the train data
dataTestAll<-dataTest[[1]]  # this it the test data

# merge the  train and test data; make data table
dataAll<-tbl_df(rbind(dataTrainAll,dataTestAll))

# print out the first few lines of dataAll
cat("\n\n===============\n")
cat(" A printout of the first 10 lines of dataMeansByActsAll:\n\n")
print(dataAll)
cat("\n=====End of partial printout: dataAll \n")

#####
#### Goal 2. Means and SDs.
#####

# means
dataTrainMeans<-dataTrain[[2]]          # this contains only the means of the 128 train measurements 
dataTestMeans<-dataTest[[2]]            # this contains only the means of the 128 test measurements
dataMeansAll<-rbind(dataTrainMeans,dataTestMeans) # combined means data

# sds
dataTrainSds<-dataTrain[[3]] 
dataTestSds<-dataTest[[3]]
dataSdsAll<-rbind(dataTrainSds,dataTestSds)

# combine means and sds data then write-out using write.table() for uploading
dataMeansSdsAll<-cbind(dataMeansAll,dataSdsAll)
write.table(dataMeansSdsAll,file="MeansAndSdsMeasurements.txt",row.names=FALSE,col.names=TRUE,quote=FALSE)


###
## Goal 5. Create data that contains ID, testOrTrain, and the mean of the nine experimentally-measured 
## variables for each activity and subject (the number of observations to be averaged depends 
## on the particular subject and activity)
###

# create full data containing ID, testOrTrain, acts, and the mean (based on 128 measurement per variable)
# of each of the nine experimentally-measured variables (in dataMeansAll)
dataAll2<-cbind(select(dataAll,ID,testOrTrain,activity),dataMeansAll)

# use by_group to group by ID and by activity; summarize by getting means of nine varibles
# this gives a data table of dimensions 30 x 12; 
#rows: 30 IDs, columns: ID, testOrTrain, activity and the overall means of the nine variables 
ggDataAll2<-group_by(dataAll2,ID,testOrTrain,activity)
dataMeansByActsAll<-summarize(ggDataAll2,
                              bodyAccXMnAct=mean(bodyAccXMn),
                              bodyAccYMnAct=mean(bodyAccYMn),
                              bodyAccZMnAct=mean(bodyAccZMn),
                              bodyGyroXMnAct=mean(bodyGyroXMn),
                              bodyGyroYMnAct=mean(bodyGyroYMn),
                              bodyGyroZMnAct=mean(bodyGyroZMn),
                              totAccXMnAct=mean(totAccXMn),
                              totAccYMnAct=mean(totAccYMn),
                              totAccZMnAct=mean(totAccZMn)
)

# get a view of the first few lines (right-truncated) of dataMeansByActsAll
cat("\n\n===============\n")
cat(" A printout of the first 10 lines of dataMeansByActsAll:\n\n")
print(dataMeansByActsAll)
cat("\n=====End of partial printout: dataMeansByactsAll \n\n")

###
##
# create table containing information regarding the number of observations
# (each with 128 measurements) by subject and activity;  each count is also the 
# number of means that was averaged to get the overall mean variable measurement
# by subject and activity
##
###

# obtain the train/test IDs and testOrTrains
idTrain<-dimnames(table(select(dataTrainAll,ID,testOrTrain)))$ID
idTest<-dimnames(table(select(dataTestAll,ID,testOrTrain)))$ID
ID<-as.numeric(c(idTrain,idTest))
testOrTrain<-c(rep("TRAIN",length(idTrain)),rep("TEST",length(idTest)))
# bind the ID and tesCd then sort by ID
IDtestOrTrain<- cbind(ID,testOrTrain)[order(ID),]


# create table containing information regarding the number of observations
# (each with 128 measurements) by subject and activity;  each count is also the 
# number of means that was averaged to get the overall mean variable measurement
# by subject and activity
tableTrainActs<-table(select(dataTrainAll,ID,activity))
tableTestActs<-table(select(dataTestAll,ID,activity))
dt1<-data.table(cbind(IDtestOrTrain,rbind(tableTrainActs,tableTestActs)[order(ID),]))
colnames(dt1)[3:8]<-paste(1:6,rep("-",6),activities[[2]],sep="")
### verify total obs
##
#sum(sapply(select(dt1,-c(ID,testOrTrain)),sum))  # totals 10299 obs
testOrTrain0<-c(rep(0,length(idTrain)),rep(1,length(idTest)))
IDtestOrTrain0<- cbind(ID,testOrTrain0)[order(ID),]
#dt10<-mutate(dt1,testOrTrain = (testOrTrain == "TEST")*TRUE)
dt10<-data.table(cbind(IDtestOrTrain0,rbind(tableTrainActs,tableTestActs)[order(ID),]))
colnames(dt10)[3:8]<-paste(1:6,rep("-",6),activities[[2]],sep="")
sum(sapply(select(dt10,-c(ID,testOrTrain0)),sum))  # totals 10299 obs
##
###
write.table(dt1,file="tableFreqSubjectByActivity.txt",row.name=FALSE,quote=FALSE)
cat("\n Frequency table: Number of Observations, Subject by Activity\n")
write.table(dt1,row.name=FALSE,quote=FALSE)

# close diagnostics.txt
sink()
