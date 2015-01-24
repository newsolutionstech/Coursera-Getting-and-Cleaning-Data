Getting and Cleaning Data Course Project

I would like to acknowledge Mauro Taraborelli for inspiration in completing this assignment. His license to use his work as a guide to completing this assigment is included in the repo.

All project files are located under the folder peer_assesment.

run_analysis.R script description.

The R script begins by loading the plyr package.

The next step of the R script is to set the working directory. The working directory will be used as a launch point to access the project data and other project files.

The next step of the R script is to read in the training portion of the project data, the test portion of the project data, and then to merge the data files into a complete data set. Using a combination of cbind() and rbind() functions, the train and test project data files are merged together.

The next step of this R script extracts the mean and standard deviation measurements calculated for each activity using the grepl funtion.

The next step of the R script applies descriptive activity names to the mean and standard deviation data in the data set.

The next step of the R script is to rename the variable names to more readable names.

The next step of the R script is to produce a tidy data set using the last iteration of the steps that produced the file data. The tidy data set will contain the average of each variable for each activity and each subject.

The last step is to create a text file of the tidy data set that can be distributed to other researchers.