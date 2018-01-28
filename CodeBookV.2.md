## The Code Book (V.2.)

The following transformations were applied:
1) Test and training sets were combined into a single dataset.
2) Extracted only the measurements on the mean and standard deviation for each measurement
3) Labels were replaced with the descriptive Names 
4) The dataset was summarized by the average per each subject and activity

The inputs are: 
Please see Readme.md for detailed description of the inputs. 
The input data collected from the accelerometers from the Samsung Galaxy S smartphone.

The outputs are:
The mean of mean and standard deviation of each measurement for each subject and each activity. 
First two columns represent subject and activity. Each row of first two columns represent an unique combination of a subject and activity. 
From the third column to the last column, each column contains the mean of numeric values for each measurement outputs per a given subject and activity combination. 
 
## Import files from the set working directory 

setwd("D:/CourseraGettingandCleaningdata/UCI_HAR_Dataset")

# Test data
subject_test <- read.table("./test/subject_test.txt")
x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")

# Train data
subject_train <- read.table("./train/subject_train.txt")
x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")

# features data
features <- read.table("./features.txt")

# Activities labels
activities <- read.table("./activity_labels.txt")

## Merges the training and the test sets to create one data set.

xtt <-rbind(x_test, x_train)
ytt<-rbind(y_test, y_train)
subject <- rbind(subject_test,subject_train)

## Extracts only the measurements on the mean and standard deviation for each measurement.

head(features,10)
i_meanstd <- grep ("mean\\(\\)|std\\(\\)", features$V2)
key <- paste("V",i_meanstd,sep="")
library(dplyr)
xtt <- tbl_df(xtt)

## data set with mean and std measurements only
xtt <- select(xtt,key) 

## Uses descriptive activity names to name the activities in the data set

head(ytt)
head(activities)
ytt[,1] <- activities[ytt[,1],2]

## Appropriately labels the data set with descriptive variable names.
names(subject) <- "Subject_ID"
names (ytt) <- "Activity"
names(xtt) <- features[i_meanstd,2]
Data <- cbind(subject,ytt, xtt)

## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidydata<- aggregate(Data[,3:ncol(Data)],by = list(SubjectID = Data$Subject_ID,Activity = Data$Activity), mean, simplify = T )
write.table(tidydata, "tidydata.txt", row.names = F)