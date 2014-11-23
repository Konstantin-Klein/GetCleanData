### Getting and Cleaning Data; Course Project ###
### Jason A. Harris, 11/23/2014 ###

### 1.Merges the training and the test sets to create one data set. ###
### read in data tables ###
activity.labels <- read.table("/Users/jharris1b/Desktop/R/R_Practice/Getdata_CourseProject/Datasets/activity_labels.txt")
features <- read.table("/Users/jharris1b/Desktop/R/R_Practice/Getdata_CourseProject/Datasets/features.txt")
subject.test <- read.table("/Users/jharris1b/Desktop/R/R_Practice/Getdata_CourseProject/Datasets/subject_test.txt")
subject.train <- read.table("/Users/jharris1b/Desktop/R/R_Practice/Getdata_CourseProject/Datasets/subject_train.txt")
x.test <- read.table("/Users/jharris1b/Desktop/R/R_Practice/Getdata_CourseProject/Datasets/X_test.txt")
x.train <- read.table("/Users/jharris1b/Desktop/R/R_Practice/Getdata_CourseProject/Datasets/X_train.txt")
y.test <- read.table("/Users/jharris1b/Desktop/R/R_Practice/Getdata_CourseProject/Datasets/y_test.txt")
y.train <- read.table("/Users/jharris1b/Desktop/R/R_Practice/Getdata_CourseProject/Datasets/y_train.txt")

### add test/train variable; so that each can be identified later ###
x.test$Set <- "Test"
x.train$Set <- "Train"

## combine all the measures from the test and train datasets ###
x.rbind <- rbind(x.test, x.train)

### add column names from the second column of the features file ###
colnames(x.rbind) <- features$V2

### set column name for test/train variable ###
colnames(x.rbind)[562] <- "Set"

### combine the test and train subject files and name column ###
sub.rbind <- rbind(subject.test, subject.train)
colnames(sub.rbind) <- "Subject"

### 3.Uses descriptive activity names to name the activities in the data set ###
### 4.Appropriately labels the data set with descriptive variable name ### 
### combine the test and train activity files and name columns ###
y.rbind <- rbind(y.test, y.train)
colnames(y.rbind) <- "Activity_Code"

### create new column with activity description, using the activity_labels file ###
y.rbind$Activity_Description <- activity.labels$V2[match(y.rbind$Activity, activity.labels$V1)]

### combine all data sets to one data table ###
dt <- cbind(y.rbind, sub.rbind, x.rbind)

### set column as factors ###
dt$Activity_Code <- as.factor(dt$Activity_Code)
dt$Subject <- as.factor(dt$Subject)

### melt data so that the "variable" column become rows; one measure per observation ###
library("reshape")
melt.dt <- melt(dt, id=c("Subject","Set", "Activity_Code", "Activity_Description"))

### filter out 'mean' and 'std' measure from 'variable column ###
library("dplyr")
melt.dt <- tbl_df(melt.dt)

### 2.Extracts only the measurements on the mean and standard deviation for each measurement. ### 
new.dt <- filter(melt.dt, grepl('mean()|std()', variable))

### prepare 'variable' column to be seperated ###
new.dt$variable <- as.character(new.dt$variable)
new.dt$variable <- gsub("\\()","98", new.dt$variable)

### separate 'variable' column into 3 new columns; 'Signal', 'Direction'and 'Measure' ###
### cleanup 'Direction' column; remove characters ###
### additional cleanup of dataset ###
library("tidyr")
final.dt <- separate(new.dt, variable, into = c("Signal","Direction"),sep="9")
final.dt$Direction <- gsub("8-","", final.dt$Direction)
final.dt$Direction <- gsub("8","NA", final.dt$Direction)
final.dt <- final.dt %>%
                separate(Signal, into = c("Signal","Measure"),sep="\\-") %>%
                filter(Measure != 'meanFreq')
               
### 'Signal', 'Direction','Measure' and 'Set' might be more useful as factors###
### convert columns to factors ###
final.dt$Set <- as.factor(final.dt$Set)
final.dt$Signal <- as.factor(final.dt$Signal)
final.dt$Direction <- as.factor(final.dt$Direction)
final.dt$Measure <- as.factor(final.dt$Measure)

### print final data set ###
final.dt <- tbl_df(final.dt)
final.dt

### 5.From the data set in step 4, creates a second, independent tidy data set with the average of each ###
### variable for each activity and each subject ###

tidy.dt <- final.dt %>%
                group_by(Subject, Activity_Description, Signal, Direction, Measure) %>%
                summarize(Average_Value = mean(value, na.rm=TRUE)) %>%
                cast(Subject + Activity_Description + Signal + Direction ~ Measure) %>%
                arrange(Subject, Activity_Description)

colnames(tidy.dt) <- c("Subject", "Activity_Description","Signal","Direction", "Average_mean", "Average_std")

tidy.dt <- tbl_df(tidy.dt)
tidy.dt

write.table(tidy.dt, file="D:\\R_WD\\R_Practice\\Getdata_CourseProject\\Datasets\\tidy_dataset.txt",row.names=FALSE)
