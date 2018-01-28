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

##Merges the training and the test sets to create one data set.

xtt <-rbind(x_test, x_train)
ytt<-rbind(y_test, y_train)
subject <- rbind(subject_test,subject_train)
##Extracts only the measurements on the mean and standard deviation for each measurement.

head(features,10)
i_meanstd <- grep ("mean\\(\\)|std\\(\\)", features$V2)
key <- paste("V",i_meanstd,sep="")
library(dplyr)
xtt <- tbl_df(xtt)

# data set with mean and std measurements only
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