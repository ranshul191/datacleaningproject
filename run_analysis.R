library(dplyr)
library(tidyr)

features <- read.table("UCI HAR Dataset/features.txt", header=FALSE)
features<-as.character(features[,2])
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt", header=FALSE)
activitylabels<- as.character(activitylabels[,2])

#read train data
dataTrainX <- read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE)
dataTrainY <- read.table("UCI HAR Dataset/train/y_train.txt", header=FALSE)
dataTrainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE)

##read test data
dataTestX <- read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE)
dataTestY <- read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE)
dataTestSubject <- read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE)

##create dataframe for training data
dataTrain <- data.frame(dataTrainSubject,dataTrainY, dataTrainX)

##create dataframe for test data
dataTest <- data.frame(dataTestSubject, dataTestY, dataTestX)

##rename the columns 
names(dataTrain)<-c(c("subject", "activity"), features)
names(dataTest)<-c(c("subject", "activity"), features)

##main script for the project starts here 
##1. Merge the training and the test sets to create one data set
data<- rbind(dataTrain, dataTest)

##2. Extract only the measurements on the mean and standard deviation for each measurement
dataExtracted<-data[,which(colnames(data) %in% c("subject", "activity", grep("mean()|std()", colnames(data), value=TRUE)))]
##look at the extracted data
##str(dataExtracted)

##3.Use descriptive activity names to name the activities in the data set
dataExtracted$activity <- activitylabels[dataExtracted$activity]