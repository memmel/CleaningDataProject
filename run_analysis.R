run_analysis <- function(){
	#call libraries needed for functions that will be used
	library("dplyr")
	
	#Read all the files in
	myURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	download.file(myURL, "./hwclass3week4.zip", method="curl")
	unzip("./hwclass3week4.zip", overwrite=TRUE, exdir="./hwclass3week4/")
	myPath<-"./hwclass3week4/UCI HAR Dataset/"
	subjectTest<-read.table(paste0(myPath, "/test/subject_test.txt"), as.is=TRUE)
	xTest<-read.table(paste0(myPath, "/test/X_test.txt"), as.is=TRUE)
	yTest<-read.table(paste0(myPath, "test/y_test.txt"), as.is=TRUE)
	subjectTrain<-read.table(paste0(myPath, "train/subject_train.txt"), as.is=TRUE)
	xTrain<-read.table(paste0(myPath, "train/X_train.txt"), as.is=TRUE)
	yTrain<-read.table(paste0(myPath, "train/y_train.txt"), as.is=TRUE)
	columnNames<-read.table(paste0(myPath, "features.txt"), as.is=TRUE)
	activityNames<-read.table(paste0(myPath, "activity_labels.txt"), col.names=c("activity", "activityName"), as.is=TRUE)
	
	#Clean up the column names found in the features.txt file.  To make data tidy, Remove special chars
	#and capitalize M of mean, S of std and G of gravity for readability.  
	colnames(columnNames)<-c("colNum", "colName")
	columnNames$colName<-gsub("\\(|\\)|\\-|,", "", columnNames$colName)
	columnNames$colName<-gsub("mean", "Mean", columnNames$colName)
	columnNames$colName<-gsub("std", "Std", columnNames$colName)
	columnNames$colName<-gsub("gravity", "Gravity", columnNames$colName)
	
	#Set the column names in xTest and xTrain to the "tidy" values
	#SATISFIES STEP 4 of the assignment:  Appropriately labels the data set with descriptive variable names.
	colnames(xTest)<-columnNames$colName
	colnames(xTrain)<-columnNames$colName
	
	#Add the subject id and activity codes to the xTest file
	xTest<-cbind(subjectTest, xTest)
	xTest<-cbind(yTest, xTest)
	colnames(xTest)[1]<-"activity"
	colnames(xTest)[2]<-"subject"
	
	#Add the subject id and activity codes to the xTrain file
	xTrain<-cbind(subjectTrain, xTrain)
	xTrain<-cbind(yTrain, xTrain)
	colnames(xTrain)[1]<-"activity"
	colnames(xTrain)[2]<-"subject"	
	
	#Merge the xTest and xTrain files into xCombo and clean up variables
	#SATISFIES STEP 1 of the assignment:  Merges the training and the test sets to create one data set.
	xCombo<-rbind(xTest, xTrain)
	rm(xTest, xTrain)
	
	#grepl all mean or std columns from features.txt 
	imptColNames<-columnNames[grepl("[Mm]ean|[Ss]td", columnNames$colName), ]
	#Shift the existing column numbers and add the two additional 
	#columns to our data set (activity and subject)
	imptColNames$colNum<-imptColNames$colNum+2
	addlCols<-data.frame(row=c(1,2), title=c("activity", "subject"))
	colnames(addlCols)<-c("colNum", "colName")
	imptColNames<-rbind(addlCols, imptColNames)
	#Whittle xCombo down to only the important columns.
	#SATISFIES STEP 2 of the assignment:  Extracts only the measurements on the mean and 
	#standard deviation for each measurement.
	xCombo<-xCombo[ ,imptColNames$colNum]
	
	#Name the activity ids
	#SATISFIES STEP 3 of the assignment:  Uses descriptive activity names to name the 
	#activities in the data set.
	xCombo<-merge(activityNames, xCombo, by="activity", all.x=TRUE)
	#Remove the id from the data set
	xCombo$activity<-NULL
	
	#From the data set, create a second, independent tidy data set with the avg of each 
	#variable for each activity and each subject.  
	#First, group the data by activity_name and subject:
	xComboGrouped<-group_by(xCombo, activityName, subject)
	rm(xCombo)
	#Then, create a table with the means of all non-grouped columns 
	#SATISFIES STEP 5 of the assignment:  From the data set in step 4, creates a second, 
	#independent tidy data set with the average of each variable for each activity and each subject.
	xComboGrouped<-summarise_each(xComboGrouped, funs(mean))	
	write.table(xComboGrouped, file = "./hwclass3week4/run_analysis_output.csv", col.names=TRUE)
	#Give user information on how to read the file from R
	cat("File saved as ./hwclass3week4/run_analysis_output.csv and has column headers.", "\n")
	cat("Read file into test by typing: test<-read.table(file=\"./hwclass3week4/run_analysis_output.csv\", header=TRUE)", "\n")
	return(cat("Then, in RStudio, easily view the contents by then typing: View(test)", "\n"))
}