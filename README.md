#Human Activity Recognition Using Smartphones Dataset
##Mean of Measurements by Activity and Subject

###The Experiment (taken from initial readme documentation)
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

###The Project Requirements (taken from the course assignment description)
Create one R script called run_analysis.R that does the following:

*Merges the training and the test sets to create one data set.
*Extracts only the measurements on the mean and standard deviation for each measurement.
*Uses descriptive activity names to name the activities in the data set
*Appropriately labels the data set with descriptive variable names.
*From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

In the script run_analysis.R, the provided input files (see separate section below for more detail) were massaged and processed to create a tidy data set of the mean of each measurement for any column of means or standard deviations across a subject/activity pairing  

The first step was to download the zip file of all of the provided input files, download it, unzip it and gain access to all provided data.  This data included the following files"
	*subject_test.txt
	*X_test.txt
	*y_test.txt
	*subject_train.txt
	*X_train.txt
	*y_train.txt
	*features.txt: a list of the column names and row numbers
	*activity_labels.txt: a list of activity id's and labels

The next step was to clean the list of column names found in the features.txt file.  To make the column names tidy, I removed the special chars and capitalized M of mean, S of std and G of gravity for readability.  

X_test and X_train were labeled with the new tidy variable names which SATISFIES STEP 4 of the assignment:  Appropriately labels the data set with descriptive variable names.

The subject_test and y_test files were combined with the X_test file.  Column names 1 and 2 were named "activity" and "subject". 

The subject_train and y_train files were combined with the X_train file.  Column names 1 and 2 were named "activity" and "subject". 
	
X_test and X_train files were combined into xCombo.  SATISFIES STEP 1 of the assignment:  Merges the training and the test sets to create one data set.

All of the column names in the features.txt file that calculated a mean or standard deviation were listed.  This included column names that had "mean" anywhere in their name.  "Activity" and "subject" were added to the list of important columns.  xCombo, the combination of all of the test and training data was then whittled down to only the important columns (i.e. those that included mean or standard deviation in their names).  SATISFIES STEP 2 of the assignment:  Extracts only the measurements on the mean and standard deviation for each measurement.

Then, to further tidy the column values, the activity id's were converted to activity names.  SATISFIES STEP 3 of the assignment:  Uses descriptive activity names to name the activities in the data set.

From this data set, a second, independent tidy data set with the avg of each variable for each activity and each subject was calculated.  The data set was grouped by activity_name and subject and then used the summarize_each() to get the means of all non-grouped columns.  This SATISFIES STEP 5 of the assignment:  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The output was written to "./hwclass3week4/run_analysis_output.txt" with row.names set to FALSE. The file has column headers.  	

Read file into a variable called 'data' by typing: data<-read.table(file=\"./hwclass3week4/run_analysis_output.txt\", header=TRUE)

In RStudio, the contents can be easily viewed by typing View(data).


###Input Data (taken from initial readme documentation)
For each record it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 





Why is the data tidy? 
Why are the names descriptive?
*Does it have headings so I know which columns are which.
*Are the variables in different columns (depending on the wide/long form)
*Are there no duplicate columns

Take it step by step, get each step sorted before moving on.

The explanation is as important as the script, so make sure you make a ReadMe
Some people have lost marks in previous courses for not making it easy for their reviewers to give them marks. Don’t just make a tidy data set, make it clear to people reviewing it why it is tidy. When you given the variables descriptive names, explain why the names are descriptive. Don’t give your reviewers the opportunity to be confused about your work, spell it out to them.

subjects, activities, and readings and we are trying to get tidy data that represents a summary value (mean) for the intersection of each set.

In the submission box, as well as the link, put some accompanying text on another line something like “tidy data as per the ReadMe that can be read into R with read.table(header=TRUE) {listing any settings you have changed from the default}” This is just to make it really easy for your reviewer.
In the readMe in explaining what the script does put “and then generates a tidy data text file that meets the principles of …etc”
the truly cunning may want to put in a citation to this discussion and/or Hadley’s paper
The codebook still has the specific description of the tidy data file contents (and you mention that it exists and it’s role in the ReadMe)


For this assignment we are only using the features involving the standard deviation and the mean as a subset of all the available features.

what columns are measurements on the mean and standard deviation
Based on interpreting column names in the features is an open question as to is the the entries that include mean() and std() at the end, or does it include entries with mean in an earlier part of the name as well. There are no specific marking criteria on the number of columns. It is up to you to make a decision and explain what you did to the data. Make it easy for people to give you marks by explaining your reasoning.

The purest tidy for is a little difficult to say, since we don’t have a specific problem to apply it to, but it hinges a little on what a “variable” is- are the variables independent measurements of activity/subject actions (the form the data comes in), or are they members of a set of measurements variables (in a similar way that each activity is a member of the set of activities, as in the diagram, upthread)

Depending on the interpretation, this could support either data in the wide (first) or the long form (second) being in tidy format, and the marking rubric specifically accepts wide or long.

A person wanting to make life easy for their marker would give the code for reading the file back into R in the readMe. 

you want a run_analysis R script, a ReadMe markdown document, a Codebook markdown document, and a tidy data text file (this last goes on Coursera).




