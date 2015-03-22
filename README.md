## Introduction

This project uses data from
the <a href="http://archive.ics.uci.edu/ml/">UC Irvine Machine
Learning Repository</a>.  

The dataset being used is from the Human Activity Recognition using Smartphones
study.

* <b>Dataset</b>: <a href="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip">Human Activity Recognition</a> [60Mb]

* <b>Description</b>: Measurements of six activities for 30 subjects using the 
embedded accelerometer and gyroscope of a Samsung Galaxy S II.

Variables being used and how they were obtained are defined in the CodeBook.md.

## Loading the data

The run_analysis.R script will check your working directory for the existence of
the UCI HAR Dataset folder.  If this folder does not exist, it will download the
dataset referenced above and unzip the file.

Once the file is unzipped the script will proceed to take the following steps:

* The test and train datasets will be read into R data frames, as will the 
column and activity labels.

* Column names will be assigned to the new data frames, then the data frames
will be merged to form one overall dataset.

* Using the instructions from the project document, the overall dataset will be 
subsetted to include information on the subject, activity and averages of mean
and standard deviation values.


## License

As stated in the original UCI HAR Dataset README, I am acknowledging use by 
referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and 
Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a 
Multiclass Hardware-Friendly Support Vector Machine. International Workshop of 
Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can
be addressed to the authors or their institutions for its use or misuse. Any
commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.