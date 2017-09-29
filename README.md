### run\_analysis.R performs the following steps.

#### 1. Download the raw data.

#### 2. Load text files into R.

#### 3. Extract features including the mean and standard deviation only.

#### 4. Subset the train\_set based on the features selected in step 3. Add subject and activity columns.

#### 5. Subset the test\_set based on the features selected in step 3. Add subject and activity columns.

#### 6. Merge the training and the test sets to create full\_set.

#### 7. Use descriptive activity names to name the activities. Pull the activity names from activity\_labels.

#### 8. Using gsub(), appropriately label the full\_set with descriptive variable names.

#### 9. Use melt() on the full\_set to convert to the long-format data. Use dcast() to get the average of each variable for each activity and each subject.

#### 10. Write out the output to tidy.txt.
