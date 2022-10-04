# Codebook for run_analysis.R file

activity_labels: names of the various activities

features: all feature names collected from smartwatch

used_features: features containing mean and standard deviation

measurements: neatend version of used_features with the feature names

test_results: unlabelled test result with smartwatch features 

test_subjects: ordered list of subject number performing the test

test_labels: ordered list of activity being performed

test_data: combined data frame of test_results, test_subjects and test_labels

the 3 variables above are repeated for the training data

net_data: combined list of test and training data

tidy_data: formatted version of net_data demonstrating the values for each participant for each activity

