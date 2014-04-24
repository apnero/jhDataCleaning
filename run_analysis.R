##This script will process accelerometer data that originally came from participants smartphones.

##Initially there are two data sets: a training dataset and a test dataset
##The script merges the datasets

##It is assumed the the working directory is root of the download data directory
##ie 'train//x_train.txt' and 'test//x_test.txt' are valid paths from the working directory

############################################################

##x_train contains the accelerometer data, extract and label first 6 columns
##the first 6 columns have all the required mean and std data
x_train <- read.table("train//x_train.txt", 
                      col.names= c('meanX', 'meanY', 'meanZ', 'stdX', 'stdY', 'stdZ', rep("NULL",555)),
                      colClasses = c(rep("numeric", 6), rep("NULL", 555) ) )

##y_train contains activity data, adds labels
y_train <- read.table("train//y_train.txt", col.names='Activity')
y_train$Activity <- factor(y_train$Activity, levels=c('1','2','3','4','5','6'), 
            labels=c('WALKING','WALKING_UPSTAIRS','WALKING_DOWNSTAIRS',
                     'SITTING','STANDING','LAYING') )

##subject_train connects participants to the above accelerometer and activity data
subject_train <- read.table("train//subject_train.txt", col.names='Participant')

##this is the full labeled training dataset
full_train <- cbind (subject_train, y_train, x_train)

#############################################################

##x_test contains the accelerometer data, extract and label first 6 columns
##the first 6 columns have all the required mean and std data
x_test <- read.table("test//x_test.txt", 
                      col.names= c('meanX', 'meanY', 'meanZ', 'stdX', 'stdY', 'stdZ', rep("NULL",555)),
                      colClasses = c(rep("numeric", 6), rep("NULL", 555) ) )

##y_test contains activity data, adds labels
y_test <- read.table("test//y_test.txt", col.names='Activity')
y_test$Activity <- factor(y_test$Activity, levels=c('1','2','3','4','5','6'), 
                           labels=c('WALKING','WALKING_UPSTAIRS','WALKING_DOWNSTAIRS',
                                    'SITTING','STANDING','LAYING') )

##subject_test connects participants to the above accelerometer and activity data
subject_test <- read.table("test//subject_test.txt", col.names='Participant')

##this is the full labeled test dataset
full_test <- cbind (subject_test, y_test, x_test)

##############################################################

##this is the full combined  test and training dataset
full_dataset <- rbind(full_train, full_test)

##############################################################


##this sql call on the full dataset will select the 8 rows that will be displayed in 
##the final tidy dataset.  It calculates the averages, and groups the data by participant 
##and activity
##So each one of the thirty participants will have 6 rows (one for each activity)
ans<- sqldf("select Participant, Activity, 
      avg(meanX) as AverageMeanX, 
      avg(meanY) as AverageMeanY, 
      avg(meanZ) as AverageMeanZ,
      avg(stdX) as AverageStdX, 
      avg(stdY) as AverageStdY, 
      avg(stdZ) as AverageStdZ from full_dataset group by Participant, Activity")

##############################################################

##write final table to the file system
write.table(ans, file="final_analysis.csv", row.names=FALSE)


