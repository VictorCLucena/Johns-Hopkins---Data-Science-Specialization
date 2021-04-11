library(dplyr)

featnames <- read.table("./UCI HAR Dataset/features.txt")
featnames <- as.vector(featnames$V2)

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = featnames)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "Y")

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = featnames)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "Y")

#1. Merges the training and the test sets to create one data set

train_df <- cbind(subject_train, y_train, X_train)
test_df <- cbind(subject_test, y_test, X_test)
df <- rbind(train_df, test_df)

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 

mean_std_df <- select(df, subject, Y, contains("mean"), contains("std"))

#3. Uses descriptive activity names to name the activities in the data set

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("Y", "Description"))
mean_std_df$Y <- inner_join(mean_std_df, activity_labels, by = c("Y" = "Y"))[, "Description"]
names(mean_std_df)[2] <- "Activity"

#4. Appropriately label the data set with descriptive activity names

names(mean_std_df) <- make.names(names(mean_std_df))
names(mean_std_df) <- gsub('Acc',"Acceleration",names(mean_std_df))
names(mean_std_df) <- gsub('GyroJerk',"AngularAcceleration",names(mean_std_df))
names(mean_std_df) <- gsub('Gyro',"AngularSpeed",names(mean_std_df))
names(mean_std_df) <- gsub('Mag',"Magnitude",names(mean_std_df))
names(mean_std_df) <- gsub('^t',"TimeDomain.",names(mean_std_df))
names(mean_std_df) <- gsub('^f',"FrequencyDomain.",names(mean_std_df))
names(mean_std_df) <- gsub('\\.mean',".Mean",names(mean_std_df))
names(mean_std_df) <- gsub('\\.std',".StandardDeviation",names(mean_std_df))
names(mean_std_df) <- gsub('Freq\\.',"Frequency.",names(mean_std_df))
names(mean_std_df) <- gsub('Freq$',"Frequency",names(mean_std_df))

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

final_df <- group_by(mean_std_df, subject, Activity) %>%
  summarise_all(list(mean))
write.table(final_df, "Final_df.txt", row.name=FALSE))
