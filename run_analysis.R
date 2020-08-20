# Getting and Cleaning Data Project



#Load Packages
library(data.table)
library(tidyverse)
library(dplyr)



# Check if directory exists if not create data directory and download file
if (!file.exists("./data")){dir.create("./data")
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
  }


# Unzip folder
unzip(zipfile = "./data/UCI HAR Dataset")
list.files("UCI HAR Dataset")



# Read in all the data sets into environment

# read in features txt.file
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))

#read in activities txt.file
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

#read in test txt.files
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

#read in train txt.files
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

#1: Merges the training and the test sets to create one data set.
x_merge <- rbind(x_train, x_test)
y_merge <- rbind(y_train, y_test)
subject_merge <- rbind(subject_train, subject_test)
merge_data  <- cbind(subject_merge, y_merge, x_merge)

#2: Extracts only the measurements on the mean and standard deviation for each measurement.
tidy_data <- merge_data %>% select(subject, code, contains("mean"), contains("std"))

#step3: Uses descriptive activity names to name the activities in the data set.
tidy_data$code <- activities[tidy_data$code, 2]

#step4: Appropriately labels the data set with descriptive variable names.

names(tidy_data)[2] = "activity"
names(tidy_data)<-gsub("Acc", " Accelerometer", names(tidy_data))
names(tidy_data)<-gsub("Gyro", " Gyroscope", names(tidy_data))
names(tidy_data)<-gsub("BodyBody", " Body", names(tidy_data))
names(tidy_data)<-gsub("Mag", " Magnitude", names(tidy_data))
names(tidy_data)<-gsub("^t", " Time", names(tidy_data))
names(tidy_data)<-gsub("^f", " Frequency", names(tidy_data))
names(tidy_data)<-gsub("tBody", " TimeBody", names(tidy_data))
names(tidy_data)<-gsub("-mean()", " Mean", names(tidy_data), ignore.case = TRUE)
names(tidy_data)<-gsub("-std()", " STD", names(tidy_data), ignore.case = TRUE)
names(tidy_data)<-gsub("-freq()", " Frequency", names(tidy_data), ignore.case = TRUE)
names(tidy_data)<-gsub("angle", " Angle", names(tidy_data))
names(tidy_data)<-gsub("gravity", " Gravity", names(tidy_data))

#step5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

summary_data <- tidy_data %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(summary_data, "summary_data.txt", row.name=FALSE)

summary_data


