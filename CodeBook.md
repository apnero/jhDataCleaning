The data for this script can be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

Unzip this archive and assign its root directory as the working directory in R.


3 files from this archive are used to assemble the test data and 3 other files are used to assemble the training data for a total of 6 files.

Files with training data:
- train//x_train.txt (contains accelerometer info)
- train//y_train.txt (contains activity info)
- train//subject_train.txt (contains columns to matches participant to the above accelerometer and activity info)

Files with test data:
- test//x_test.txt
- test//y_test.txt
- test//subject_test.txt

All other files are ignored.


In the R script "run_analysis.R", the x_train.txt data is load into a R dataframe called x_train.
Only the first 6 columns with the mean and standard deviation are loaded into the dataframe.
The y_train.txt data is loaded into y_train.
The subject_train.txt data is loaded into subject_train.
The columns from the 3 files are merged into a data frame called full_train.

The test data is loaded following the same format of the training data and merged into full_test.

full_train and full_test is merged into a dataframe called full_dataset that contains all the required data used for analysis.

To do the analysis an sql command in run utilizing the sqldf library.
This sql call on the full dataset will select the 8 rows that will be displayed in the final tidy dataset.  It calculates the averages, and groups the data by participant and activity.
So each one of the thirty participants will have 6 rows (one for each activity).

The final tidy dataset output is written to final_analysis.csv in the working directory.




