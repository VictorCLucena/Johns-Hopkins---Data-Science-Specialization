library(dplyr)

featnames <- read.table("./UCI HAR Dataset/features.txt")
featnames <- as.vector(featnames$V2)

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = featnames)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "Y")

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = featnames)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "Y")

train_df <- cbind(subject_train, y_train, X_train)
test_df <- cbind(subject_test, y_test, X_test)
df <- rbind(train_df, test_df)

