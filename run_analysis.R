# tidy data
# 1) Each variable forms a column
# 2) Each observation forms a row
# 3) Each type of observational unit forms a table

library(tidyverse)

# download data
if(!file.exists("data")) {dir.create("data")}
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile = "./data/dataset.zip",mode="wb")
file.name <- unzip("./data/dataset.zip")
dateDownloaded <- date()

# load into R
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
features <- read.table("./UCI HAR Dataset/features.txt",stringsAsFactors = FALSE)
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt",stringsAsFactors = FALSE)

# extract only the mean and standard deviation
index <- grep("mean|std",features[,2])
feature_set <- features[index,2]

# subset features in the train_set with subject and activity
x_train_set <- x_train[,index]
x_train_set$subject <- subject_train[,1]
x_train_set$activity <- y_train[,1]

# subset features in the test_set with subject and activity
x_test_set <- x_test[,index]
x_test_set$subject <- subject_test[,1]
x_test_set$activity <- y_test[,1]

# merge the training and the test sets to create one data set
full_set <- rbind(x_train_set,x_test_set)

# use descriptive activity names to name the activities
for (i in 1:nrow(activity_labels)) {
    full_set$activity[full_set$activity==i] <- activity_labels[i,2]
}

# appropriately label the data set with descriptive variable names
colnames(full_set) <- c(feature_set,"subject","activity")
colnames(full_set) <- gsub("mean","Mean",colnames(full_set))
colnames(full_set) <- gsub("std","Std",colnames(full_set))
colnames(full_set) <- gsub("^t","Time",colnames(full_set))
colnames(full_set) <- gsub("^f","Frequency",colnames(full_set))
colnames(full_set) <- gsub("Freq","Frequency",colnames(full_set))
colnames(full_set) <- gsub("Acc","Accelerometer",colnames(full_set))
colnames(full_set) <- gsub("Gyro","Gyroscope",colnames(full_set))
colnames(full_set) <- gsub("Mag","Magnitude",colnames(full_set))
colnames(full_set) <- gsub("[()]","",colnames(full_set))

# create a tidy data set with the average of each variable for each activity and each subject
library(reshape2)
full_set_long <- melt(full_set,id=c("subject","activity"))
tidy_set <- dcast(full_set_long,subject+activity~variable,mean)

# write out to tidy.txt
write.table(tidy_set,"tidy.txt",row.name = FALSE,quote = FALSE)
