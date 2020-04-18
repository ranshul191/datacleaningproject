---
title: "readme"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```


## Data set information

The dataset was downloaded from [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

It is part of a larger data at [link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

For each record it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

### Description of the data set

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix ‘t’ to denote time) were captured at a constant rate of 50 Hz. and the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) – both using a low pass Butterworth filter. The body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). A Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the ‘f’ to indicate frequency domain signals).

#### Description of abbreviations of measurements:
leading t or f is based on time or frequency measurements

Body = related to body movement

Gravity = acceleration of gravity

Acc = accelerometer measurement

Gyro = gyroscopic measurements

Jerk = sudden movement acceleration

Mag = magnitude of movement

mean and standard deviation are calculated for each subject for each activity : 

mean() , std()
 
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

## Project Code and Details

First of all we need to collect the data. In order to do this, download the file:
```{r}
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, "data.zip")
```

To view the files nameand path contained in the archive we use unzip() :
```{r}
unzip("data.zip", list=T)
```
```{r}
 Name   Length
1                           UCI HAR Dataset/activity_labels.txt       80
2                                  UCI HAR Dataset/features.txt    15785
3                             UCI HAR Dataset/features_info.txt     2809
4                                    UCI HAR Dataset/README.txt     4453
5                                         UCI HAR Dataset/test/        0
6                        UCI HAR Dataset/test/Inertial Signals/        0
7     UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt  6041350
8     UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt  6041350
9     UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt  6041350
10   UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt  6041350
11   UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt  6041350
12   UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt  6041350
13   UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt  6041350
14   UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt  6041350
15   UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt  6041350
16                        UCI HAR Dataset/test/subject_test.txt     7934
17                              UCI HAR Dataset/test/X_test.txt 26458166
18                              UCI HAR Dataset/test/y_test.txt     5894
19                                       UCI HAR Dataset/train/        0
20                      UCI HAR Dataset/train/Inertial Signals/        0
21  UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt 15071600
22  UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt 15071600
23  UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt 15071600
24 UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt 15071600
25 UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt 15071600
26 UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt 15071600
27 UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt 15071600
28 UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt 15071600
29 UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt 15071600
30                      UCI HAR Dataset/train/subject_train.txt    20152
31                            UCI HAR Dataset/train/X_train.txt 66006256
32                            UCI HAR Dataset/train/y_train.txt    14704
                  Date
1  2012-10-10 15:55:00
2  2012-10-11 13:41:00
3  2012-10-15 15:44:00
4  2012-12-10 10:38:00
5  2012-11-29 17:01:00
6  2012-11-29 17:01:00
7  2012-11-29 15:08:00
8  2012-11-29 15:08:00
9  2012-11-29 15:08:00
10 2012-11-29 15:09:00
11 2012-11-29 15:09:00
12 2012-11-29 15:09:00
13 2012-11-29 15:08:00
14 2012-11-29 15:09:00
15 2012-11-29 15:09:00
16 2012-11-29 15:09:00
17 2012-11-29 15:25:00
18 2012-11-29 15:09:00
19 2012-11-29 17:01:00
20 2012-11-29 17:01:00
21 2012-11-29 15:08:00
22 2012-11-29 15:08:00
23 2012-11-29 15:08:00
24 2012-11-29 15:09:00
25 2012-11-29 15:09:00
26 2012-11-29 15:09:00
27 2012-11-29 15:08:00
28 2012-11-29 15:08:00
29 2012-11-29 15:08:00
30 2012-11-29 15:09:00
31 2012-11-29 15:25:00
32 2012-11-29 15:09:00
```

We go through the files in the unzipped archive and decide which files to read and read the test and train datasets:
```{r}
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
```

We use the str() funtion to satisfy that things are consistent and have a look at the variables:
```{r}
str(features)

str(activityLabels)

str(dataTrainX)

str(dataTrainY)

str(dataTrainSubject)

str(dataTestX)

str(dataTestY)

str(dataTestSubject)
```

We then combine X_train, y_train and subject_train in a train dataframe, and X_test, y_test and subject_test in a test data frame:

```{r}
dataTrain<-data.frame(dataTrainSubject, dataTrainY, dataTrainX)

dataTest<-data.frame(dataTestSubject, dataTestY, dataTestX)
```
Now we assign proper names for the columns using the features dataset:
```{r}
names(dataTrain)<-c(c("subject", "activity"), features)
names(dataTest)<-c(c("subject", "activity"), features)
```


### 1. Merge the training and the test sets to create one data set

```{r}
data<-rbind(dataTrain, dataTest)
```
 

### 2. Extract only the measurements on the mean and standard deviation for each measurement

```{r}
##check for column names which have any form of mean or std in them
dataExtracted<-data[,which(colnames(data) %in% c("subject", "activity", grep("mean()|std()", colnames(data), value=TRUE)))]
##look at the extracted data
##str(dataExtracted)
```
 
### 3. Use descriptive activity names to name the activities in the data set
```{r}
##using the activity labels list we give descriptive activity names to the activities
dataExtracted$activity <- activitylabels[dataExtracted$activity]
```

### 4. Appropriately label the data set with descriptive variable names

We make appropriate changes to names to identify the variables properly as below
```{r}
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
```

We can check the new properties of the data frame :
```{r}
names(dataExtracted)
```

### 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject

```{r}
## we first group by  subject and then activity, then summarize all the columns for their mean and sort and then convert it back to dataframe
dataTidy <- dataExtracted %>%group_by( subject,activity)%>%summarize_all(mean)%>%arrange(subject,activity)%>%ungroup%>%as.data.frame()
```
The dataTidy dataset includes the average of each variable for each activity and each subject. 10299 instances are split into 180 groups (30 subjects and 6 activities) and 66 mean and standard deviation features are averaged for each group. The resulting data table has 180 rows and 68 columns – 33 Mean variables + 33 Standard deviation variables + 1 Subject( 1 of of the 30 test subjects) + ActivityName. The tidy data set’s first row is the header containing the names for each column.

```{r}
##create the tidy data set file
write.table(dataTidy, "Tidydata.txt", row.name=FALSE)
```
We look at the final output dataTidy dataframe

```{r}
> str(dataTidy)
'data.frame':	180 obs. of  81 variables:
 $ activity                                          : chr  "LAYING" "LAYING" "LAYING" "LAYING" ...
 $ subject                                           : int  1 2 3 4 5 6 7 8 9 10 ...
 $ timeBodyAccelerometer-mean()-X                    : num  0.222 0.281 0.276 0.264 0.278 ...
 $ timeBodyAccelerometer-mean()-Y                    : num  -0.0405 -0.0182 -0.019 -0.015 -0.0183 ...
 $ timeBodyAccelerometer-mean()-Z                    : num  -0.113 -0.107 -0.101 -0.111 -0.108 ...
 $ timeBodyAccelerometer-std()-X                     : num  -0.928 -0.974 -0.983 -0.954 -0.966 ...
 $ timeBodyAccelerometer-std()-Y                     : num  -0.837 -0.98 -0.962 -0.942 -0.969 ...
 $ timeBodyAccelerometer-std()-Z                     : num  -0.826 -0.984 -0.964 -0.963 -0.969 ...
 $ timeGravityAccelerometer-mean()-X                 : num  -0.249 -0.51 -0.242 -0.421 -0.483 ...
 $ timeGravityAccelerometer-mean()-Y                 : num  0.706 0.753 0.837 0.915 0.955 ...
 $ timeGravityAccelerometer-mean()-Z                 : num  0.446 0.647 0.489 0.342 0.264 ...
 $ timeGravityAccelerometer-std()-X                  : num  -0.897 -0.959 -0.983 -0.921 -0.946 ...
 $ timeGravityAccelerometer-std()-Y                  : num  -0.908 -0.988 -0.981 -0.97 -0.986 ...
 $ timeGravityAccelerometer-std()-Z                  : num  -0.852 -0.984 -0.965 -0.976 -0.977 ...
 $ timeBodyAccelerometerJerk-mean()-X                : num  0.0811 0.0826 0.077 0.0934 0.0848 ...
 $ timeBodyAccelerometerJerk-mean()-Y                : num  0.00384 0.01225 0.0138 0.00693 0.00747 ...
 $ timeBodyAccelerometerJerk-mean()-Z                : num  0.01083 -0.0018 -0.00436 -0.00641 -0.00304 ...
 $ timeBodyAccelerometerJerk-std()-X                 : num  -0.958 -0.986 -0.981 -0.978 -0.983 ...
 $ timeBodyAccelerometerJerk-std()-Y                 : num  -0.924 -0.983 -0.969 -0.942 -0.965 ...
 $ timeBodyAccelerometerJerk-std()-Z                 : num  -0.955 -0.988 -0.982 -0.979 -0.985 ...
 $ timeBodyGyroscope-mean()-X                        : num  -0.01655 -0.01848 -0.02082 -0.00923 -0.02189 ...
 $ timeBodyGyroscope-mean()-Y                        : num  -0.0645 -0.1118 -0.0719 -0.093 -0.0799 ...
 $ timeBodyGyroscope-mean()-Z                        : num  0.149 0.145 0.138 0.17 0.16 ...
 $ timeBodyGyroscope-std()-X                         : num  -0.874 -0.988 -0.975 -0.973 -0.979 ...
 $ timeBodyGyroscope-std()-Y                         : num  -0.951 -0.982 -0.977 -0.961 -0.977 ...
 $ timeBodyGyroscope-std()-Z                         : num  -0.908 -0.96 -0.964 -0.962 -0.961 ...
 $ timeBodyGyroscopeJerk-mean()-X                    : num  -0.107 -0.102 -0.1 -0.105 -0.102 ...
 $ timeBodyGyroscopeJerk-mean()-Y                    : num  -0.0415 -0.0359 -0.039 -0.0381 -0.0404 ...
 $ timeBodyGyroscopeJerk-mean()-Z                    : num  -0.0741 -0.0702 -0.0687 -0.0712 -0.0708 ...
 $ timeBodyGyroscopeJerk-std()-X                     : num  -0.919 -0.993 -0.98 -0.975 -0.983 ...
 $ timeBodyGyroscopeJerk-std()-Y                     : num  -0.968 -0.99 -0.987 -0.987 -0.984 ...
 $ timeBodyGyroscopeJerk-std()-Z                     : num  -0.958 -0.988 -0.983 -0.984 -0.99 ...
 $ timeBodyAccelerometerMagnitude-mean()             : num  -0.842 -0.977 -0.973 -0.955 -0.967 ...
 $ timeBodyAccelerometerMagnitude-std()              : num  -0.795 -0.973 -0.964 -0.931 -0.959 ...
 $ timeGravityAccelerometerMagnitude-mean()          : num  -0.842 -0.977 -0.973 -0.955 -0.967 ...
 $ timeGravityAccelerometerMagnitude-std()           : num  -0.795 -0.973 -0.964 -0.931 -0.959 ...
 $ timeBodyAccelerometerJerkMagnitude-mean()         : num  -0.954 -0.988 -0.979 -0.97 -0.98 ...
 $ timeBodyAccelerometerJerkMagnitude-std()          : num  -0.928 -0.986 -0.976 -0.961 -0.977 ...
 $ timeBodyGyroscopeMagnitude-mean()                 : num  -0.875 -0.95 -0.952 -0.93 -0.947 ...
 $ timeBodyGyroscopeMagnitude-std()                  : num  -0.819 -0.961 -0.954 -0.947 -0.958 ...
 $ timeBodyGyroscopeJerkMagnitude-mean()             : num  -0.963 -0.992 -0.987 -0.985 -0.986 ...
 $ timeBodyGyroscopeJerkMagnitude-std()              : num  -0.936 -0.99 -0.983 -0.983 -0.984 ...
 $ frequencyBodyAccelerometer-mean()-X               : num  -0.939 -0.977 -0.981 -0.959 -0.969 ...
 $ frequencyBodyAccelerometer-mean()-Y               : num  -0.867 -0.98 -0.961 -0.939 -0.965 ...
 $ frequencyBodyAccelerometer-mean()-Z               : num  -0.883 -0.984 -0.968 -0.968 -0.977 ...
 $ frequencyBodyAccelerometer-std()-X                : num  -0.924 -0.973 -0.984 -0.952 -0.965 ...
 $ frequencyBodyAccelerometer-std()-Y                : num  -0.834 -0.981 -0.964 -0.946 -0.973 ...
 $ frequencyBodyAccelerometer-std()-Z                : num  -0.813 -0.985 -0.963 -0.962 -0.966 ...
 $ frequencyBodyAccelerometer-meanFreq()-X           : num  -0.159 -0.146 -0.074 -0.274 -0.136 ...
 $ frequencyBodyAccelerometer-meanFreq()-Y           : num  0.0975 0.2573 0.2385 0.3662 0.4665 ...
 $ frequencyBodyAccelerometer-meanFreq()-Z           : num  0.0894 0.4025 0.217 0.2013 0.1323 ...
 $ frequencyBodyAccelerometerJerk-mean()-X           : num  -0.957 -0.986 -0.981 -0.979 -0.983 ...
 $ frequencyBodyAccelerometerJerk-mean()-Y           : num  -0.922 -0.983 -0.969 -0.944 -0.965 ...
 $ frequencyBodyAccelerometerJerk-mean()-Z           : num  -0.948 -0.986 -0.979 -0.975 -0.983 ...
 $ frequencyBodyAccelerometerJerk-std()-X            : num  -0.964 -0.987 -0.983 -0.98 -0.986 ...
 $ frequencyBodyAccelerometerJerk-std()-Y            : num  -0.932 -0.985 -0.971 -0.944 -0.966 ...
 $ frequencyBodyAccelerometerJerk-std()-Z            : num  -0.961 -0.989 -0.984 -0.98 -0.986 ...
 $ frequencyBodyAccelerometerJerk-meanFreq()-X       : num  0.132 0.16 0.176 0.182 0.24 ...
 $ frequencyBodyAccelerometerJerk-meanFreq()-Y       : num  0.0245 0.1212 -0.0132 0.0987 0.1957 ...
 $ frequencyBodyAccelerometerJerk-meanFreq()-Z       : num  0.0244 0.1906 0.0448 0.077 0.0917 ...
 $ frequencyBodyGyroscope-mean()-X                   : num  -0.85 -0.986 -0.97 -0.967 -0.976 ...
 $ frequencyBodyGyroscope-mean()-Y                   : num  -0.952 -0.983 -0.978 -0.972 -0.978 ...
 $ frequencyBodyGyroscope-mean()-Z                   : num  -0.909 -0.963 -0.962 -0.961 -0.963 ...
 $ frequencyBodyGyroscope-std()-X                    : num  -0.882 -0.989 -0.976 -0.975 -0.981 ...
 $ frequencyBodyGyroscope-std()-Y                    : num  -0.951 -0.982 -0.977 -0.956 -0.977 ...
 $ frequencyBodyGyroscope-std()-Z                    : num  -0.917 -0.963 -0.967 -0.966 -0.963 ...
 $ frequencyBodyGyroscope-meanFreq()-X               : num  -0.00355 0.10261 -0.08222 -0.06609 -0.02272 ...
 $ frequencyBodyGyroscope-meanFreq()-Y               : num  -0.0915 0.0423 -0.0267 -0.5269 0.0681 ...
 $ frequencyBodyGyroscope-meanFreq()-Z               : num  0.0105 0.0553 0.1477 0.1529 0.0414 ...
 $ frequencyBodyAccelerometerMagnitude-mean()        : num  -0.862 -0.975 -0.966 -0.939 -0.962 ...
 $ frequencyBodyAccelerometerMagnitude-std()         : num  -0.798 -0.975 -0.968 -0.937 -0.963 ...
 $ frequencyBodyAccelerometerMagnitude-meanFreq()    : num  0.0864 0.2663 0.237 0.2417 0.292 ...
 $ frequencyBodyAccelerometerJerkMagnitude-mean()    : num  -0.933 -0.985 -0.976 -0.962 -0.977 ...
 $ frequencyBodyAccelerometerJerkMagnitude-std()     : num  -0.922 -0.985 -0.975 -0.958 -0.976 ...
 $ frequencyBodyAccelerometerJerkMagnitude-meanFreq(): num  0.266 0.342 0.239 0.274 0.197 ...
 $ frequencyBodyGyroscopeMagnitude-mean()            : num  -0.862 -0.972 -0.965 -0.962 -0.968 ...
 $ frequencyBodyGyroscopeMagnitude-std()             : num  -0.824 -0.961 -0.955 -0.947 -0.959 ...
 $ frequencyBodyGyroscopeMagnitude-meanFreq()        : num  -0.1398 0.0186 -0.0229 -0.2599 0.1024 ...
 $ frequencyBodyGyroscopeJerkMagnitude-mean()        : num  -0.942 -0.99 -0.984 -0.984 -0.985 ...
 $ frequencyBodyGyroscopeJerkMagnitude-std()         : num  -0.933 -0.989 -0.983 -0.983 -0.983 ...
 $ frequencyBodyGyroscopeJerkMagnitude-meanFreq()    : num  0.1765 0.2648 0.1107 0.2029 0.0247 ...
 ```


