# Getting-and-Cleaning-Data-Course-Project
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 

The first step is to download the zip files in the data file.  This step is conducted by using the download file command.  From there since it is a zip file the command unzip is used to extract the files for further transformations. 

Each specified txt.file that is required is that read into the enviroment and assigned an apporpriate variable name.  These txt files are read in using the read.table command with columnn names included to easily merge these datasets in upcoming script. 

The x test and x train files are then merged using the row bind (rbind) command.  Then the subject train and test files are merged using the same row bind command.  Then the merged data tables are column binded based on the observation structure within the files.  

The tidy_data is an output of the merged data based on the pipe operator with the selected columns.  This is done to extracts only the measurements on the mean and standard deviation for each measurement

With the mean and standard deviations identifed the descriptive names for the activities are added to the tidy data. 

The next step is to apply the more descriptive appropriate lables for the data set for example "Acc" is transformed into "Accelerometer"

