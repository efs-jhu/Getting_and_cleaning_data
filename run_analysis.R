## 1) Load libraries
library(tidyverse)
library(reshape2)
library(data.table)

## 2) 
setwd("C:/Users/BHPData/OneDrive - Johns Hopkins/Documents/TEMP/Getting and Cleaning Data/")

activity_labels <- fread("UCI HAR Dataset/activity_labels.txt",header=FALSE,
                              col.names = c("class_Labels","activity_name"))

features <- fread("UCI HAR Dataset/features.txt",header=FALSE,
                    col.names = c("index","feature_name"))

used_features <- grep("(mean|std)\\(\\)",features[,feature_name])

measurements <- features[used_features,feature_name]
measurements <- gsub('[()]','', measurements)

test_results <- fread("UCI HAR Dataset/test/X_test.txt",header=FALSE)[, used_features, with = FALSE]
data.table::setnames(test_results,colnames(test_results),measurements)
test_subjects <- fread("UCI HAR Dataset/test/subject_test.txt",header=FALSE,col.names=c("Subject_num"))
test_labels <- fread("UCI HAR Dataset/test/y_test.txt",header=FALSE,col.names = c("Activity"))
test_data <- cbind(test_subjects,test_labels,test_results)

train_results <- fread("UCI HAR Dataset/train/X_train.txt",header=FALSE)[, used_features, with = FALSE]
data.table::setnames(train_results,colnames(train_results),measurements)
train_subjects <- fread("UCI HAR Dataset/train/subject_train.txt",header=FALSE,col.names=c("Subject_num"))
train_labels <- fread("UCI HAR Dataset/train/y_train.txt",header=FALSE,col.names = c("Activity"))
train_data <- cbind(train_subjects,train_labels,train_results)


net_data <- rbind(test_data,train_data)

net_data[["Activity"]] <- factor(net_data[,Activity],
                                 levels = activity_labels[["class_Labels"]],
                                 labels = activity_labels[["activity_name"]])

net_data[["Subject_num"]] <- as.factor(net_data[,Subject_num])

net_data <- reshape2::melt(data = net_data, id = c("Subject_num","Activity"))
net_data <- reshape2::dcast(data = net_data, Subject_num + Activity ~ variable, fun.aggregate = mean)

tidy_data <- net_data

write.table(tidy_data,"efs_final_results_table",row.name = FALSE)
