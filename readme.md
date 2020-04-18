---
title: "readme"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```


##Data set information

The dataset was downloaded from [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

It is part of a larger data 

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

###Description of the data set

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix ‘t’ to denote time) were captured at a constant rate of 50 Hz. and the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) – both using a low pass Butterworth filter. The body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). A Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the ‘f’ to indicate frequency domain signals).

#### Description of abbreviations of measurements :

leading t or f is based on time or frequency measurements
Body = related to body movement
Gravity = acceleration of gravity
Acc = accelerometer measurement
Gyro = gyroscopic measurements
Jerk = sudden movement acceleration
Mag = magnitude of movement
mean and standard deviation are calculated for each subject for each activity : mean() , std()
 
The units given are g’s for the accelerometer and rad/sec for the gyro and g/sec and rad/sec/sec for the corresponding jerks.

These signals were used to estimate variables of the feature vector for each pattern: ‘-XYZ’ is used to denote 3-axial signals in the X, Y and Z directions. They total 33 measurements including the 3 dimensions – the X,Y, and Z axes.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag
Application

##Project Code and Details

First of all we need to collect the data. In order to do this, download the file:
```{r}
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, "data.zip")




To view the files nameand path contained in the archive we use unzip() :

 

unzip(temp, list=T)

UCI HAR Dataset/activity_labels.txt
UCI HAR Dataset/features.txt
UCI HAR Dataset/train/X_train.txt
UCI HAR Dataset/train/y_train.txt
UCI HAR Dataset/train/subject_train.txt
UCI HAR Dataset/test/X_test.txt
UCI HAR Dataset/test/y_test.txt
UCI HAR Dataset/test/subject_test.txt
 

 

 

 

 

 

 

Now that we know which files are contained into the archive, we decide which files we need to read and convert in order to make our analysis :

 

features<-read.table(unz(temp, « UCI HAR Dataset/features.txt »), header=F)

features<-as.character(features[,2])

activityLabels<-read.table(unz(temp, « UCI HAR Dataset/activity_labels.txt »), header=F)

activityLabels<-as.character(activityLabels[,2])

dataTrainX<-read.table(unz(temp, « UCI HAR Dataset/train/X_train.txt »), header=F)

dataTrainY<-read.table(unz(temp, « UCI HAR Dataset/train/y_train.txt »), header=F)

dataTrainSubject<-read.table(unz(temp, « UCI HAR Dataset/train/subject_train.txt »), header=F)

dataTestX<-read.table(unz(temp, « UCI HAR Dataset/test/X_test.txt »), header=F)

dataTestY<-read.table(unz(temp, « UCI HAR Dataset/test/y_test.txt »), header=F)

dataTestSubject<-read.table(unz(temp, « UCI HAR Dataset/test/subject_test.txt »), header=F)

Since we have finished to import in our workspace all data we need, we can remove the temp file via unlink() :

 

unlink(temp)

Thanks to str() funtion we take a look at the properties of the above varibles :

 

str(features)

str(activityLabels)

str(dataTrainX)

str(dataTrainY)

str(dataTrainSubject)

str(dataTestX)

str(dataTestY)

str(dataTestSubject)

Next step will be to combine X_train, y_train and subject_train in a « train » data frame, and X_test, y_test and subject_test in a « test » data frame :

 

dataTrain<-data.frame(dataTrainSubject, dataTrainY, dataTrainX)

dataTest<-data.frame(dataTestSubject, dataTestY, dataTestX)

Now we correctly rename the columns name of new data frames using the « features » data set we have previously imported :

 

names(dataTrain)<-c(c(‘subject’, ‘activity’), features)

names(dataTest)<-c(c(‘subject’, ‘activity’), features)

1. Merge the training and the test sets to create one data set

data<-rbind(dataTrain, dataTest)

 

2. Extract only the measurements on the mean and standard deviation for each measurement

dataExtr<-data[,which(colnames(data) %in% c(« subject », « activity », grep(« mean()|std() », colnames(data), value=TRUE)))]

We can check the structures of the data frame « dataExtr » :

str(dataExtr)

 

3. Use descriptive activity names to name the activities in the data set

dataExtr$activity<-activityLabels[dataExtr$activity]

head(dataExtr$activity,50)

 

4. Appropriately label the data set with descriptive variable names

Here are the names of the variables in « dataExtr » :

names(dataExtr)

We look now for the parts of labels we need to change :

unique(gsub(« -(mean|std)().* », «  », names(dataExtr)[-c(1:2)]))

In order to label the data set with descriptive names, we are going to make the following changes (code is just after) :

prefix t is replaced by time
Acc is replaced by Accelerometer
Gyro is replaced by Gyroscope
prefix f is replaced by frequency
Mag is replaced by Magnitude
BodyBody is replaced by Body
 

 

 

 

 

 

names(dataExtr)[-c(1:2)]<-gsub(« ^t », « time », names(dataExtr)[-c(1:2)])

names(dataExtr)[-c(1:2)]<-gsub(« ^f », « frequency », names(dataExtr)[-c(1:2)])

names(dataExtr)[-c(1:2)]<-gsub(« Acc », « Accelerometer », names(dataExtr)[-c(1:2)])

names(dataExtr)[-c(1:2)]<-gsub(« Gyro », « Gyroscope », names(dataExtr)[-c(1:2)])

names(dataExtr)[-c(1:2)]<-gsub(« Mag », « Magnitude », names(dataExtr)[-c(1:2)])

names(dataExtr)[-c(1:2)]<-gsub(« BodyBody », « Body », names(dataExtr)[-c(1:2)])

 

We can check the new properties of the data frame « dataExtr » :

names(dataExtr)

str(dataExtr)

 

5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject

tidyData<-aggregate(. ~ subject + activity, dataExtr, mean)

tidyData<-tidyData[order(tidyData$subject,tidyData$activity),]

 

The « tidyData » dataset includes the average of each variable for each activity and each subject. 10299 instances are split into 180 groups (30 subjects and 6 activities) and 66 mean and standard deviation features are averaged for each group. The resulting data table has 180 rows and 68 columns – 33 Mean variables + 33 Standard deviation variables + 1 Subject( 1 of of the 30 test subjects) + ActivityName. The tidy data set’s first row is the header containing the names for each column.

 

Thanks to str() function we can list and describe all the variables of our « tidyData » dataset :

 


str(tidyData)

#'data.frame':   180 obs. of  68 variables:
# $ subject                                       : int  1 1 1 1 1 1 2 2 2 2 ...
# $ activity                                      : chr  "LAYING" "SITTING" "STANDING" "WALKING" ...
# $ timeBodyAccelerometer-mean()-X                : num  0.222 0.261 0.279 0.277 0.289 ...
# $ timeBodyAccelerometer-mean()-Y                : num  -0.04051 -0.00131 -0.01614 -0.01738 -0.00992 ...
# $ timeBodyAccelerometer-mean()-Z                : num  -0.113 -0.105 -0.111 -0.111 -0.108 ...
# $ timeBodyAccelerometer-std()-X                 : num  -0.928 -0.977 -0.996 -0.284 0.03 ...
# $ timeBodyAccelerometer-std()-Y                 : num  -0.8368 -0.9226 -0.9732 0.1145 -0.0319 ...
# $ timeBodyAccelerometer-std()-Z                 : num  -0.826 -0.94 -0.98 -0.26 -0.23 ...
# $ timeGravityAccelerometer-mean()-X             : num  -0.249 0.832 0.943 0.935 0.932 ...
# $ timeGravityAccelerometer-mean()-Y             : num  0.706 0.204 -0.273 -0.282 -0.267 ...
# $ timeGravityAccelerometer-mean()-Z             : num  0.4458 0.332 0.0135 -0.0681 -0.0621 ...
# $ timeGravityAccelerometer-std()-X              : num  -0.897 -0.968 -0.994 -0.977 -0.951 ...
# $ timeGravityAccelerometer-std()-Y              : num  -0.908 -0.936 -0.981 -0.971 -0.937 ...
# $ timeGravityAccelerometer-std()-Z              : num  -0.852 -0.949 -0.976 -0.948 -0.896 ...
# $ timeBodyAccelerometerJerk-mean()-X            : num  0.0811 0.0775 0.0754 0.074 0.0542 ...
# $ timeBodyAccelerometerJerk-mean()-Y            : num  0.003838 -0.000619 0.007976 0.028272 0.02965 ...
# $ timeBodyAccelerometerJerk-mean()-Z            : num  0.01083 -0.00337 -0.00369 -0.00417 -0.01097 ...
# $ timeBodyAccelerometerJerk-std()-X             : num  -0.9585 -0.9864 -0.9946 -0.1136 -0.0123 ...
# $ timeBodyAccelerometerJerk-std()-Y             : num  -0.924 -0.981 -0.986 0.067 -0.102 ...
# $ timeBodyAccelerometerJerk-std()-Z             : num  -0.955 -0.988 -0.992 -0.503 -0.346 ...
# $ timeBodyGyroscope-mean()-X                    : num  -0.0166 -0.0454 -0.024 -0.0418 -0.0351 ...
# $ timeBodyGyroscope-mean()-Y                    : num  -0.0645 -0.0919 -0.0594 -0.0695 -0.0909 ...
# $ timeBodyGyroscope-mean()-Z                    : num  0.1487 0.0629 0.0748 0.0849 0.0901 ...
# $ timeBodyGyroscope-std()-X                     : num  -0.874 -0.977 -0.987 -0.474 -0.458 ...
# $ timeBodyGyroscope-std()-Y                     : num  -0.9511 -0.9665 -0.9877 -0.0546 -0.1263 ...
# $ timeBodyGyroscope-std()-Z                     : num  -0.908 -0.941 -0.981 -0.344 -0.125 ...
# $ timeBodyGyroscopeJerk-mean()-X                : num  -0.1073 -0.0937 -0.0996 -0.09 -0.074 ...
# $ timeBodyGyroscopeJerk-mean()-Y                : num  -0.0415 -0.0402 -0.0441 -0.0398 -0.044 ...
# $ timeBodyGyroscopeJerk-mean()-Z                : num  -0.0741 -0.0467 -0.049 -0.0461 -0.027 ...
# $ timeBodyGyroscopeJerk-std()-X                 : num  -0.919 -0.992 -0.993 -0.207 -0.487 ...
# $ timeBodyGyroscopeJerk-std()-Y                 : num  -0.968 -0.99 -0.995 -0.304 -0.239 ...
# $ timeBodyGyroscopeJerk-std()-Z                 : num  -0.958 -0.988 -0.992 -0.404 -0.269 ...
# $ timeBodyAccelerometerMagnitude-mean()         : num  -0.8419 -0.9485 -0.9843 -0.137 0.0272 ...
# $ timeBodyAccelerometerMagnitude-std()          : num  -0.7951 -0.9271 -0.9819 -0.2197 0.0199 ...
# $ timeGravityAccelerometerMagnitude-mean()      : num  -0.8419 -0.9485 -0.9843 -0.137 0.0272 ...
# $ timeGravityAccelerometerMagnitude-std()       : num  -0.7951 -0.9271 -0.9819 -0.2197 0.0199 ...
# $ timeBodyAccelerometerJerkMagnitude-mean()     : num  -0.9544 -0.9874 -0.9924 -0.1414 -0.0894 ...
# $ timeBodyAccelerometerJerkMagnitude-std()      : num  -0.9282 -0.9841 -0.9931 -0.0745 -0.0258 ...
# $ timeBodyGyroscopeMagnitude-mean()             : num  -0.8748 -0.9309 -0.9765 -0.161 -0.0757 ...
# $ timeBodyGyroscopeMagnitude-std()              : num  -0.819 -0.935 -0.979 -0.187 -0.226 ...
# $ timeBodyGyroscopeJerkMagnitude-mean()         : num  -0.963 -0.992 -0.995 -0.299 -0.295 ...
# $ timeBodyGyroscopeJerkMagnitude-std()          : num  -0.936 -0.988 -0.995 -0.325 -0.307 ...
# $ frequencyBodyAccelerometer-mean()-X           : num  -0.9391 -0.9796 -0.9952 -0.2028 0.0382 ...
# $ frequencyBodyAccelerometer-mean()-Y           : num  -0.86707 -0.94408 -0.97707 0.08971 0.00155 ...
# $ frequencyBodyAccelerometer-mean()-Z           : num  -0.883 -0.959 -0.985 -0.332 -0.226 ...
# $ frequencyBodyAccelerometer-std()-X            : num  -0.9244 -0.9764 -0.996 -0.3191 0.0243 ...
# $ frequencyBodyAccelerometer-std()-Y            : num  -0.834 -0.917 -0.972 0.056 -0.113 ...
# $ frequencyBodyAccelerometer-std()-Z            : num  -0.813 -0.934 -0.978 -0.28 -0.298 ...
# $ frequencyBodyAccelerometerJerk-mean()-X       : num  -0.9571 -0.9866 -0.9946 -0.1705 -0.0277 ...
# $ frequencyBodyAccelerometerJerk-mean()-Y       : num  -0.9225 -0.9816 -0.9854 -0.0352 -0.1287 ...
# $ frequencyBodyAccelerometerJerk-mean()-Z       : num  -0.948 -0.986 -0.991 -0.469 -0.288 ...
# $ frequencyBodyAccelerometerJerk-std()-X        : num  -0.9642 -0.9875 -0.9951 -0.1336 -0.0863 ...
# $ frequencyBodyAccelerometerJerk-std()-Y        : num  -0.932 -0.983 -0.987 0.107 -0.135 ...
# $ frequencyBodyAccelerometerJerk-std()-Z        : num  -0.961 -0.988 -0.992 -0.535 -0.402 ...
# $ frequencyBodyGyroscope-mean()-X               : num  -0.85 -0.976 -0.986 -0.339 -0.352 ...
# $ frequencyBodyGyroscope-mean()-Y               : num  -0.9522 -0.9758 -0.989 -0.1031 -0.0557 ...
# $ frequencyBodyGyroscope-mean()-Z               : num  -0.9093 -0.9513 -0.9808 -0.2559 -0.0319 ...
# $ frequencyBodyGyroscope-std()-X                : num  -0.882 -0.978 -0.987 -0.517 -0.495 ...
# $ frequencyBodyGyroscope-std()-Y                : num  -0.9512 -0.9623 -0.9871 -0.0335 -0.1814 ...
# $ frequencyBodyGyroscope-std()-Z                : num  -0.917 -0.944 -0.982 -0.437 -0.238 ...
# $ frequencyBodyAccelerometerMagnitude-mean()    : num  -0.8618 -0.9478 -0.9854 -0.1286 0.0966 ...
# $ frequencyBodyAccelerometerMagnitude-std()     : num  -0.798 -0.928 -0.982 -0.398 -0.187 ...
# $ frequencyBodyAccelerometerJerkMagnitude-mean(): num  -0.9333 -0.9853 -0.9925 -0.0571 0.0262 ...
# $ frequencyBodyAccelerometerJerkMagnitude-std() : num  -0.922 -0.982 -0.993 -0.103 -0.104 ...
# $ frequencyBodyGyroscopeMagnitude-mean()        : num  -0.862 -0.958 -0.985 -0.199 -0.186 ...
# $ frequencyBodyGyroscopeMagnitude-std()         : num  -0.824 -0.932 -0.978 -0.321 -0.398 ...
# $ frequencyBodyGyroscopeJerkMagnitude-mean()    : num  -0.942 -0.99 -0.995 -0.319 -0.282 ...
# $ frequencyBodyGyroscopeJerkMagnitude-std()     : num  -0.933 -0.987 -0.995 -0.382 -0.392 ...
```


