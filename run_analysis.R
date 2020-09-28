##Course Project

library(dplyr)
features <- read.table("UCI HAR Dataset/features.txt")
features <- select(features,V2)

activity <- read.table("UCI HAR Dataset/activity_labels.txt") 

##reading train dataset
train <- read.table("UCI HAR Dataset/train/X_train.txt")
names(train) <- features$V2 
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
train$activity <- y_train$V1
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
train$subject <- factor(subject_train$V1)

##reading test dataset
test <- read.table("UCI HAR Dataset/test/X_test.txt")
names(test) <- features$V2 
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
test$activity <- y_test$V1
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
test$subject <- factor(subject_test$V1)

## STEP 1: merge both datasets

data <- rbind(train, test)

## STEP 2: select data 
#getting only columns for mean and std, also activity and subject
col.names <- grep("std\\(\\)|mean\\(\\)|activity|subject", names(data), value=TRUE)
data.select <- data[, col.names]

## STEP 3: naming activities in dataset

data.select$activitylabel <- factor(data.select$activity, 
                                    levels = activity$V1,
                                    labels = activity$V2)

## STEP 4: naming variables in appropriately way 
names(data.select) <- gsub("-","_", names(data.select))
names(data.select) <- gsub("\\()", "", names(data.select))

## STEP 5: generate a tidy dataset
library(reshape)
meltdata <- melt(data.select, id = c("subject", "activity"))
meltdata$value <- as.numeric(meltdata$value)

library(reshape2)
tidydata <- dcast(meltdata, subject + activity ~ variable, mean, na.rm = TRUE)

##export tidy data as a txt file
write.table(tidydata, "tidydata.txt", row.names = FALSE, quote = FALSE)

