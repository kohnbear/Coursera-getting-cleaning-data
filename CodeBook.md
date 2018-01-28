## The Code Book

The following transformations were applied:
1) Test and training sets were combined into a single dataset.
2) Extracted only the measurements on the mean and standard deviation for each measurement
3) Labels were replaced with the descriptive Names 
4) The dataset was summarized by the average per each subject and activity

The inputs are: 
Please see Readme.md for detailed description of the inputs. 
The input data collected from the accelerometers from the Samsung Galaxy S smartphone.

The outputs are:
The mean of mean and standard deviation of each measurement for each subject and each activity. 
First two columns represent subject and activity. Each row of first two columns represent an unique combination of a subject and activity. 
From the third column to the last column, each column contains the mean of numeric values for each measurement outputs per a given subject and activity combination. 
 