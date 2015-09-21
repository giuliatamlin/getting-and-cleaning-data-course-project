# getting-and-cleaning-data-course-project
the script run_analysis.R  processes the data contained
in the folder "UCI HAR dataset", available at
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+
Smartphones, and outputs a new, tidy, data set which is written
onto the file "new_data.txt".

The script starts by reading in the train and test data (i.e. the files
"test/X_test.txt" and "train/X_train.txt"). Descriptive column names
to be assigned to the dataframes are obtained by reading in 
the "features.txt" files.
Finally, the activities (and relative labels) and the subjects
are read in, respectively, from the "test(train)/y_test(train).txt" and 
"test(train)/subject_test(train).txt" files.

Once the two dataframes test_data and train_data are created, 
those dataframes which are no longer needed are deleted.

The script then merges the test and train dataset and
selects only the columns relative to the mean and the standard
deviation of each variable.

The new_data dataframe is then obtained by grouping the data according
to the activities and the subjects and by taking the mean of each columns.

The "new_data.txt" dataset contains 68 columns of which the first column
corresponds to the activity performed, the second to the subject who performed 
the activity, whereas the remaining 66 correspond to the mean value and standard
deviation, averaged over all the measurements, of the following signals
tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

where '-XYZ' is used to indicate 3-axial signals in each Cartesian direction.

 
