### Code Book ###

Run_analysis.R executes the following sections of code to merge files and generate a tidy table with the averages of all numeric variables in the table for each activity and each subject. 

1. Read data into the following dataframes
  - featnames
  - activity_label
  - subject_test
  - X_test 
  - y_test 
  - subject_train
  - X_train 
  - y_train 

2. Merges the training and the test sets to create one data set
  - Combine columns for train data
  > train_df <- cbind(subject_train, y_train, X_train)
  - Combine columns for test data
  > test_df <- cbind(subject_test, y_test, X_test)
  - Combine rows into one dataset
  > df <- rbind(train_df, test_df)

3. Extracts only the measurements on the mean and standard deviation for each measurement and store them into a new dataframe (mean_std) 
  > mean_std_df <- select(df, subject, Y, contains("mean"), contains("std"))

4. Use descriptive activity names to name the activities in the data set
  > activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("Y", "Description"))
  > mean_std_df$Y <- inner_join(mean_std_df, activity_labels, by = c("Y" = "Y"))[, "Description"]
  > names(mean_std_df)[2] <- "Activity"

5. Appropriately label the data set with descriptive activity names
  > names(mean_std_df) <- make.names(names(mean_std_df))
  > names(mean_std_df) <- gsub('Acc',"Acceleration",names(mean_std_df))
  > names(mean_std_df) <- gsub('GyroJerk',"AngularAcceleration",names(mean_std_df))
  > names(mean_std_df) <- gsub('Gyro',"AngularSpeed",names(mean_std_df))
  > names(mean_std_df) <- gsub('Mag',"Magnitude",names(mean_std_df))
  > names(mean_std_df) <- gsub('^t',"TimeDomain.",names(mean_std_df))
  > names(mean_std_df) <- gsub('^f',"FrequencyDomain.",names(mean_std_df))
  > names(mean_std_df) <- gsub('\\.mean',".Mean",names(mean_std_df))
  > names(mean_std_df) <- gsub('\\.std',".StandardDeviation",names(mean_std_df))
  > names(mean_std_df) <- gsub('Freq\\.',"Frequency.",names(mean_std_df))
  > names(mean_std_df) <- gsub('Freq$',"Frequency",names(mean_std_df))

6. Group data by subject and activity and get the average of each variable for each activity and each subject
  > final_df <- group_by(mean_std_df, subject, Activity) %>%
      summarise_all(list(mean))
      
7. Write the tidy data to a text file named as "Final_df.txt"
  > write.table(final_df, "Final_df.txt", row.name=FALSE)
  > write.table(new_data,filename, row.name = FALSE)