## Getting and Cleaning Data Course Project, Jason A. Harris, 11/23/2014

### Explanaiton of run_analysis.R file

This file stores all the commands necessary to get and clean the data as described in the course project (see description below).

The Approach:

Read in each file and store into separate data frames.  Add a variable to identify either a 'test' or 'train' data set.  Although not a requirement, I felt this important for any future analysis.  Combine all files and rename columns appropriately, using the correct descriptions.

Melt the data set to allow for one variable per observation, and filter out all measures except 'mean' and 'standard deviation'.

Each measure contained 3 pieces of information.  I wanted to seperate these pieces out into their own columns.  To allow for better analysis later.  In order to separate the measure names into 3 different parts, characters were changed to allow for separtaion using the 'separate' command from 'tidyr' package.  Additional clean up of characters around those names were needed (removing unwanted "-" and numbers where appropriate).  The result being 3 columns; 'Signal', 'Measure' and 'Direction'.

Once completed, the new columns were set to factors, and the the final data set was created (final.dt).  More information on the variables in the  final dataset can be found in the Codebook.

From this dataset a new tidy data set (tidy.dt) was created by grouping each factor, summarizing the average mean and average standard deviation and then casting the new variables into their own columns.  Finally, ensuring the names of each column by renaming them all to appropriate descriptions.  More information on the final set of variables for this data set can be found in the Codebook.

### Project Description

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. 

You will be required to submit: 
*1) a tidy data set as described below, 
*2) a link to a Github repository with your script for performing the analysis, and 
*3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 

You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

You should create one R script called run_analysis.R that does the following. 
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
