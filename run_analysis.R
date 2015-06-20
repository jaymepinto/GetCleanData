# STEP 1: Merges the training and the test sets to create one data set.

# 1.1 Downloading the zip file and unziping it
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./data/dataset.zip")
unzip("./data/dataset.zip", files = NULL, list = FALSE, overwrite = TRUE,junkpaths = FALSE, exdir = "./data", unzip = "internal",setTimes = FALSE)

# 1.2 Constructing the test table
total_acc_x_test <- read.table("./data/UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt", header = FALSE, sep = "")
total_acc_y_test <- read.table("./data/UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt", header = FALSE, sep = "")
total_acc_z_test <- read.table("./data/UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt", header = FALSE, sep = "")
body_acc_x_test <- read.table("./data/UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt", header = FALSE, sep = "")
body_acc_y_test <- read.table("./data/UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt", header = FALSE, sep = "")
body_acc_z_test <- read.table("./data/UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt", header = FALSE, sep = "")
body_gyro_x_test <- read.table("./data/UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt", header = FALSE, sep = "")
body_gyro_y_test <- read.table("./data/UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt", header = FALSE, sep = "")
body_gyro_z_test <- read.table("./data/UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt", header = FALSE, sep = "")
testData <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "")
ytest <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header = FALSE, sep = "")
subjectTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = "")

# 1.3 Merging the tables to create the test table
test <- cbind(subjectTest, ytest, total_acc_x_test,total_acc_y_test, total_acc_z_test, body_acc_x_test, body_acc_y_test, body_acc_z_test, body_gyro_x_test, body_gyro_y_test, body_gyro_z_test, testData)


# 1.4 Constructing the train table
total_acc_x_train <- read.table("./data/UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt", header = FALSE, sep = "")
total_acc_y_train <- read.table("./data/UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt", header = FALSE, sep = "")
total_acc_z_train <- read.table("./data/UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt", header = FALSE, sep = "")
body_acc_x_train <- read.table("./data/UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt", header = FALSE, sep = "")
body_acc_y_train <- read.table("./data/UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt", header = FALSE, sep = "")
body_acc_z_train <- read.table("./data/UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt", header = FALSE, sep = "")
body_gyro_x_train <- read.table("./data/UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt", header = FALSE, sep = "")
body_gyro_y_train <- read.table("./data/UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt", header = FALSE, sep = "")
body_gyro_z_train <- read.table("./data/UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt", header = FALSE, sep = "")
trainData <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "")
ytrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = "")
subjectTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = "")

# 1.5 Merging the tables to create the test table
train <- cbind(subjectTrain, ytrain, total_acc_x_train,total_acc_y_train, total_acc_z_train, body_acc_x_train, body_acc_y_train, body_acc_z_train, body_gyro_x_train, body_gyro_y_train, body_gyro_z_train, trainData)

# 1.6 Merging the two tables to create TestTrain table, with 10299 obs of 1715 variables
TestTrain <- rbind(test, train) # This is the answer to Question 1


# STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement.

# 2.1 Reading the table features
features <- read.table("./data/UCI HAR Dataset/features.txt", header = FALSE, sep = "")

# 2.2 Finding the columns where the words mean or std appear (we are not considering columns where the word Mean appears)
features$order <- seq(along=features$V1) # Creates the order column
logic <- grepl('mean', features$V2) | grepl('std', features$V2)
ind <- as.vector(features[logic,3])

# 2.3 Creating a vector of indices for selecting columns at the complete dataset TestTrain
indfinal <- ind + 2 + 9*128

# 2.4 Selecting the columns of the complete dataset TestTrain which the words mean or std appear (79 columns)
TestTrainFinal <- TestTrain[, indfinal]

# 2.5 Adding two more columns to the dataset: activity and subject
TestTrainFinal <- cbind(TestTrain[c(1, 2)], TestTrainFinal)
# This is the answer to Question 2. TestTrainFinal contains 10299 obs of 81 variables.


# STEP 3: Uses descriptive activity names to name the activities in the data set

# 3.1 Reading the activities labels and describing the activities in the dataset TestTrainFinal
activities_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = "")
View(activities_labels)
TestTrainFinal[2] <- ifelse(TestTrainFinal[2]==1,c("Walking"),ifelse(TestTrainFinal[2]==2,c("Walking_Upstairs"),ifelse(TestTrainFinal[2]==3,c("Walking_Downstairs"), ifelse(TestTrainFinal[2]==4,c("Sitting"), ifelse(TestTrainFinal[2]==5,c("Standing"), c("Laying"))))))
# This is the answer to Question 3


# STEP 4: Appropriately labels the data set with descriptive variable names.

# 4.1 Labeling the columns of the dataset TestTrainFinal
ColNames <- as.vector(features[logic,2])
ColNames <- c("subject", "activity", ColNames)
colnames(TestTrainFinal) <- ColNames


# STEP 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# 5.1 Aggregating the data by subject and activity, taking means and saving in AvgData
AvgData <- aggregate(TestTrainFinal[c(-1,-2)], list(Subject=TestTrainFinal$subject, Activity=TestTrainFinal$activity), mean, na.rm=TRUE)

# 5.2 Writing the table AvgData to disk (file tidyData.txt)
write.table(AvgData, file="tidyData.txt", row.names=FALSE, sep = ",", col.names=TRUE)
# This is the answer to Question 5
