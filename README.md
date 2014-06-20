# Getting Data Project
This is a project of "Getting and Cleaning Data" on Coursera. The data set is UCI HAR Dataset, and the script is written in R language.

## What are in this repo?
In this repo, I included the following items:

* README.md: this document you are reading right now, describing the profile of this repo
* getdata-projectfiles-UCI HAR Dataset.zip: a compressed zip file of the data set
* UCI HAR Dataset: data set provided by this course
* run_analysis.R: the main script for all the procedures cleaning the data set

## What does the script do?
The main tasks of the script, run_analysis.R, are:

1. Take in the separated training and testing files in the provided data set and merge them into one data set.
2. Label the activity with names in strings instead of encoded numbers
3. Generate two more tidy data sets:
	* Means of all variables grouped by subjects
	* Means of all variables grouped by activities