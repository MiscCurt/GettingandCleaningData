##check to see if UCI HAR Dataset directory exists
if (!file.exists("UCI HAR Dataset")){
    ##if not, download the zip file
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, destfile = "HAR.zip")
    ##extract data, UCI HAR Dataset directory will automatically be created
    unzip("HAR.zip")
}
##load required packages (plyr, dplyr, data.table)
library(dplyr)
library(data.table)
library(tidyr)
##Read data into R
X_test <-read.table ("./UCI HAR Dataset/test/X_test.txt")
Y_test <-read.table ("./UCI HAR Dataset/test/Y_test.txt")
X_train <-read.table ("./UCI HAR Dataset/train/X_train.txt")
Y_train <-read.table ("./UCI HAR Dataset/train/Y_train.txt")
subject_test <-read.table ("./UCI HAR Dataset/test/subject_test.txt")
subject_train <-read.table ("./UCI HAR Dataset/train/subject_train.txt")
column_labels <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
##Add column names
colnames(X_test) <- column_labels$V2
colnames(X_train) <- column_labels$V2
colnames(Y_test) <- "activity"
colnames(Y_train) <- "activity"
colnames(subject_test) <- "subject"
colnames(subject_train) <- "subject"
colnames(activity_labels) <- c("activity", "activityName")
##Combine datasets
    ##Combine subject, activity & measurement data
    test_data <- cbind(c(Y_test, X_test), subject_test)
    train_data <- cbind(c(Y_train, X_train), subject_train)
    ##Combine test & train datasets
    combined_data <-rbind(test_data, train_data)
    ##Join combined dataset with activity label
    full_data <- left_join(combined_data, activity_labels)
##Extract subject, activity, & measurement data containing mean & std
##Props to Nick Duckstein for the clue on extract columns used below
extracted_data <- full_data[,c(grep("mean|std|activityname|subject",tolower(names(full_data))))]
##Extract columns of mean and standard deviation data
final_data <- extracted_data %>%
    select(-contains("meanFreq"))%>%
    select(-contains("angle"))
ColNames<-c("time_BodyAccelerationXaxis_Mean",
            "time_BodyAccelerationYaxis_Mean",
            "time_BodyAccelerationZaxis_Mean",
            "time_BodyAccelerationXaxis_sd",
            "time_BodyAccelerationYaxis_sd",
            "time_BodyAccelerationZaxis_sd",
            "time_GravityAccelerationXaxis_Mean",
            "time_GravityAccelerationYaxis_Mean",
            "time_GravityAccelerationZaxis_Mean",
            "time_GravityAccelerationXaxis_sd",
            "time_GravityAccelerationYaxis_sd",
            "time_GravityAccelerationZaxis_sd",
            "time_BodyLinearAccelerationJerkXaxis_Mean",
            "time_BodyLinearAccelerationJerkYaxis_Mean",
            "time_BodyLinearAccelerationJerkZaxis_Mean",
            "time_BodyLinearAccelerationJerkXaxis_sd",
            "time_BodyLinearAccelerationJerkYaxis_sd",
            "time_BodyLinearAccelerationJerkZaxis_sd",
            "time_GyroscopeAngularVelocityXaxis_Mean",
            "time_GyroscopeAngularVelocityYaxis_Mean",
            "time_GyroscopeAngularVelocityZaxis_Mean",
            "time_GyroscopeAngularVelocityXaxis_sd",
            "time_GyroscopeAngularVelocityYaxis_sd",
            "time_GyroscopeAngularVelocityZaxis_sd",
            "time_GyroscopeAngularVelocityJerkXaxis_Mean",
            "time_GyroscopeAngularVelocityJerkYaxis_Mean",
            "time_GyroscopeAngularVelocityJerkZaxis_Mean",
            "time_GyroscopeAngularVelocityJerkXaxis_sd",
            "time_GyroscopeAngularVelocityJerkYaxis_sd",
            "time_GyroscopeAngularVelocityJerkZaxis_sd",
            "time_BodyLinearAccelerationMagnitude_Mean",
            "time_BodyLinearAccelerationMagnitude_sd",
            "time_GravityAccelerationMagnitude_Mean",
            "time_GravityAccelerationMagnitude_sd",
            "time_BodyLinearAccelerationJerkMagnitude_Mean",
            "time_BodyLinearAccelerationJerkMagnitude_sd",
            "time_GyroscopeAngularVelocityMagnitude_Mean",
            "time_GyroscopeAngularVelocityMagnitude_sd",
            "time_GyroscopeAngularVelocityJerkMagnitude_Mean",
            "time_GyroscopeAngularVelocityJerkMagnitude_sd",
            "frequency_BodyAccelerationXaxis_Mean",
            "frequency_BodyAccelerationYaxis_Mean",
            "frequency_BodyAccelerationZaxis_Mean",
            "frequency_BodyAccelerationXaxis_sd",
            "frequency_BodyAccelerationYaxis_sd",
            "frequency_BodyAccelerationZaxis_sd",
            "frequency_BodyLinearAccelerationJerkXaxis_Mean",
            "frequency_BodyLinearAccelerationJerkYaxis_Mean",
            "frequency_BodyLinearAccelerationJerkZaxis_Mean",
            "frequency_BodyLinearAccelerationJerkXaxis_sd",
            "frequency_BodyLinearAccelerationJerkYaxis_sd",
            "frequency_BodyLinearAccelerationJerkZaxis_sd",
            "frequency_GyroscopeAngularVelocityXaxis_Mean",
            "frequency_GyroscopeAngularVelocityYaxis_Mean",
            "frequency_GyroscopeAngularVelocityZaxis_Mean",
            "frequency_GyroscopeAngularVelocityXaxis_sd",
            "frequency_GyroscopeAngularVelocityYaxis_sd",
            "frequency_GyroscopeAngularVelocityZaxis_sd",
            "frequency_BodyLinearAccelerationMagnitude_Mean",
            "frequency_BodyLinearAccelerationMagnitude_sd",
            "frequency_BodyLinearAccelerationJerkMagnitude_Mean",
            "frequency_BodyLinearAccelerationJerkMagnitude_sd",
            "frequency_GyroscopeAngularVelocityMagnitude_Mean",
            "frequency_GyroscopeAngularVelocityMagnitude_sd",
            "frequency_GyroscopeAngularVelocityJerkMagnitude_Mean",
            "frequency_GyroscopeAngularVelocityJerkMagnitude_sd",
            "subject", "activityName")
names(final_data) <- ColNames
##create tidy dataset of subject, activity, & average of mean/std variables
tidy_data <- final_data %>%
    group_by(subject, activityName)%>%
    summarise_each(funs(mean))%>%
    gather(domain_feature_type, data, -c(subject, activityName))%>%
    separate(domain_feature_type, c("domain", "feature", "type")) %>%
    spread(type, data)
##write to txt file
write.table(tidy_data, file="tidy_data.txt", row.names = FALSE)