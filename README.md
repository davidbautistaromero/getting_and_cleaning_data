# Getting and Cleaning Data Course Project

This is the course project for Getting and Cleaning Data from Data Science specialized program.

The R Script, run_analysis.R, includes the following developed steps:

- Read the both train and test data sets, create an organized data sets using x files (measurements), y files (activity), subject files (id), and features file to name the colunms.

- Merge organized train and test data sets.

- Select only the columns that include the mean or std in the measures.

- Change some aspects in the names of the variables: Remove the parenthesis and replace "-" for "_".

- Create a txt file with a tidy data with the mean of the variables for each subject and each activity.
