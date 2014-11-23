## Getting and Cleaning Data Course Project, Jason A. Harris, 11/23/2014

## Codebook

Here is a description of each variable found in both the tidy dataset and the final dataset that was used to create the tidy dataset.

Details on the raw data variables that created these variables can be found here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

### Tidy Dataset (tidy.dt)

* Subject:  Identifier (1-30) indicating the subject being observed.
* Activity_Description:  A description for one of six activities the subject performed.
* Signal: A descriiton of one of seventeen signals being measured.
* Direction:  An indicator for the direction of the singal.  3 direstions (x,y,z).'NA' indicates                      no direction was used.
* Average_mean:  The average of the mean for that set of variables.
* Average_std: The average of the standard deviation for that set of variables.

### Final Dataset (final.dt)

* Subject:  Identifier (1-30) indicating the subject being observed.
* Set:  Identifies the set as either 'test' or 'train'.
* Activity_Code:  Code indicating the activity performed (1-6).
* Activity_Description: A description for one of six activities the subject performed.
* Signal: A descriiton of one of seventeen signals being measured.
* Measure: An indicator of the measure (either 'mean' or 'std').
* Direction: An indicator for the direction of the singal.  3 direstions (x,y,z).'NA' indicates                      no direction was used.
* vaule: The vaule of the measure.

