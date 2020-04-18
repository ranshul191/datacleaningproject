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
##check for column names which have any form of mean or std in them
dataExtracted<-data[,which(colnames(data) %in% c("subject", "activity", grep("mean()|std()", colnames(data), value=TRUE)))]
##look at the extracted data
##str(dataExtracted)

##3.Use descriptive activity names to name the activities in the data set
##using the activity labels list we give descriptive activity names to the activities
dataExtracted$activity <- activitylabels[dataExtracted$activity]

##4.Appropriately labels the data set with descriptive variable names.
# prefix t is replaced by time
# Acc is replaced by Accelerometer
# Gyro is replaced by Gyroscope
# prefix f is replaced by frequency
# Mag is replaced by Magnitude
# BodyBody is replaced by Body
names(dataExtracted)[-c(1:2)] <-gsub("^t","time", names(dataExtracted)[-c(1:2)])
names(dataExtracted)[-c(1:2)] <-gsub("^f","frequency", names(dataExtracted)[-c(1:2)])
names(dataExtracted)[-c(1:2)] <-gsub("Acc","Accelerometer", names(dataExtracted)[-c(1:2)])
names(dataExtracted)[-c(1:2)] <-gsub("Gyro","Gyroscope", names(dataExtracted)[-c(1:2)])
names(dataExtracted)[-c(1:2)] <-gsub("Mag","Magnitude", names(dataExtracted)[-c(1:2)])
names(dataExtracted)[-c(1:2)] <-gsub("BodyBody","Body", names(dataExtracted)[-c(1:2)])

##view names 
##str(names(dataExtracted))

##5.From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject
## we first group by activity and subject, then summarize all the columns for their mean and sort and then convert it back to dataframe
dataTidy <- dataExtracted %>%group_by(activity, subject)%>%summarize_all(mean)%>%arrange(activity, subject)%>%ungroup%>%as.data.frame()

##create the tidy data set
write.table(dataTidy, "Tidydata.txt", row.name=FALSE)