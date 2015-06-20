This code book describes the data and variables as well as the transformations performed to clean up the data.

1) THE DATA AND VARIABLES

The dataset was obtained from experiments that have been carried out with a group of 30 volunteers within an
age bracket of 19-48 years and represents data collected from accelerometers installed in their smartphone Samsung Galaxy S II, see [1]. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING). Using the smartphone embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz were captured.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled
in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration (768 columns).
- Triaxial Angular velocity from the gyroscope (384 columns). 
- A 561-feature vector with time and frequency domain variables (561 columns). 
- Its activity label (1 columns comprising 6 different coded activities). 
- An identifier of the subject who carried out the experiment (1 columns comprising 30 different subjects).

Since 70% of the volunteers was selected for generating the training data and 30% the test data, the whole data obtained was split in two parts (train and test data).

A thorough description of the data and experiment is available at:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

Reference:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.
Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine.
International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

2) CLEANING UP THE DATA

Since the data collected from the volunteers was split in two similar groups of files, one corresponding to test and other
to training data, we merged all files and created one dataset containing all observations (named TestTrain).

In the first step, starting with the test group, we merged all information collected from those subjects (12 tables).
It was only necessary to merge tables "side by side", since each row in any of the 12 tables corresponded to
a set of measures from an specific volunteer. The same procedure was applied to the train table.
Merging these two tables (one on top of the other) we obtained the TestTrain table (one table containing all observations, with dimension 10299 x 1715).

As a second step, we selected from the TestTrain table only the columns (measurements) which contained
mean and standard deviation statistics. That was done by selecting the words mean and std in the row names of the
measurements. The result was the table TestTrainFinal (with dimension 10299 x 81).

The next step was to use descriptive activity names to name the six activities in the data set (WALKING, WALKING_UPSTAIRS,
WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING) and to label the data set with descriptive variable names. These two tasks
were performed in the previously obtained table named TestTrainFinal.

The final step was to create a second, independent tidy data set with the average of each variable for each activity
and each subject. Therefore, the data was initially grouped by subject and activity and then the function mean was
applied. The result was stored in the table named AvgData and it was saved to disk as tidyData.txt.
