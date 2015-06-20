# GetCleanData
Coursera - Getting and Cleaning Data

This README explains the scripts used to solve Getting and Cleaning Data Course Project

QUESTION 1: Merges the training and the test sets to create one data set.

Six steps were necessary to conclude Question 1. The result is the TestTrain table.
- 1.1 Downloading the zip file and unziping it: this zip file contains all necessary files to perform the Course Project
- 1.2 Constructing the test table: we read several tables in order to build an unique table containing all test records
- 1.3 Merging the tables to create the test table: previously read tables were merged (side by side) in order to obtain the test table

Two steps, similar to 1.2 and 1.3, were necessary to build the train table. 

- 1.4 Constructing the train table: we read several tables in order to build an unique table containing all train records
- 1.5 Merging the tables to create the train table: previously read tables were merged (side by side) in order to obtain the train table

As a final step, test and train tables were merged. Differently from steps 1.3 and 1.5 (merging by columns), now the two tables are merged by rows.
- 1.6 Merging the two tables: we created the TestTrain table, with 10299 obs of 1715 variables


QUESTION 2: Extracts only the measurements on the mean and standard deviation for each measurement.
 
Five steps were necessary to conclude Question 2. The result is the TestTrainFinal table.
- 2.1 Reading the table features.txt: this table contains 561 column names used in TestTrain table
- 2.2 Finding feature elements where the words mean or std appear: in this step we did not consider elements where the word Mean appears as part of the name, such as angle(tBodyAccJerkMean) or gravityMean.
- 2.3 Creating a vector of indices for selecting columns at the complete dataset TestTrain: from the elements selected in previous step, we created a vector of indices to be used in Step 2.4 to extract columns in TrainTest table (obtained in Question 1) whose names contain mean or std.
- 2.4 Selecting the columns of the complete dataset TestTrain which the words mean or std appear: using the vector of indices obtained in Step 2.3 we selected 79 columns from TestTrain table.
- 2.5 Adding two more columns to the dataset: we added activity and subject (the columns selected in previous step did not include activity and subject, both added in this step). The obtained table was named TestTrainFinal and has 10299 obs of 81 variables.

QUESTION 3: Uses descriptive activity names to name the activities in the data set

One step was necessary to conclude Question 3. The result is the TestTrainFinal table (now with descriptive activity names).
- 3.1 Reading the activity labels and describing the activities in the dataset TestTrainFinal: we read the file activity_labels.txt and used the descriptive activity names found to name the activities in the data set TestTrainFinal, i.e., replaced their codes for the respective names.

QUESTION 4: Appropriately labels the data set with descriptive variable names

One step was necessary to conclude Question 4. The result is the TestTrainFinal table (now all columns are labeled).
- 4.1 Labeling the columns of the dataset TestTrainFinal: we labeled the 79 columns extracted in step 2.4 (up to this point
they had no label). We considered the elements extracted in step 2.2.

QUESTION 5: From the data set in QUESTION 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Two steps were necessary to conclude Question 5. The result is a file named tidyData.txt.
- 5.1 Aggregating the lines of table TestTrainFinal (by subject and activity) and calculating the mean for the remaining 79 columns of the table. The result was stored in table AvgData
- 5.2 The table AvgData was written to a txt file named tidyData.txt.
