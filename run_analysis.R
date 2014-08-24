# Gather Features labels from the correct file
features <- read.table('features.txt', colClasses=c('integer', 'character'))
names(features) <- c('id', 'name')

# Gather Activites labels from the correct file
activities <- read.table('activity_labels.txt', colClasses=c('integer', 'character'))
names(activities) <- c('level', 'label')

# test dataset
test.data <- read.table('test//X_test.txt')
# Name the columns after the Features
names(test.data) <- features$name

# Pull subject labels for each row out of the corresponding file
test.subjects <- read.table('test//subject_test.txt')
names(test.subjects) <- 'subject'
# Attach subjects to dataset from test data as a factor
test.data$subject <- factor(test.subjects$subject, 1:30)
remove(test.subjects)

# Pull the activites for each row out of the file
test.activities <- read.table('test//y_test.txt')
names(test.activities) <- 'activity'
# As we did with the subjects, attach activity data to dataset as a factor
test.data$activity <- factor(test.activities$activity, activities$level, activities$label)
remove(test.activities)

# train dataset Follows the same process as above.
train.data <- read.table('train//X_train.txt')
names(train.data) <- features$name

train.subjects <- read.table('train//subject_train.txt')
names(train.subjects) <- 'subject'
train.data$subject <- factor(train.subjects$subject, 1:30)
remove(train.subjects)

train.activities <- read.table('train//y_train.txt')
names(train.activities) <- 'activity'
train.data$activity <- factor(train.activities$activity, activities$level, activities$label)
remove(train.activities)

# I keep removing unnecessary tables for memory management's sake.
remove(activities, features)

# use rbind to combine the testing and training datasets
data <- rbind(test.data, train.data)

#now that we have one dataset, remove the other two
remove(test.data, train.data)

# Convert to data.table - this is mostly for speed
data <- data.table(data)

# remove extra cols, only keep mean(), meanfreq(), and std() columns
cols <- names(data)
cols <- cols[cols %in% grep('std\\(\\)|mean\\(\\)|meanFreq\\(\\)', cols, value=T)]
# make sure we have activity and subject still!
data <- data[,c(cols, 'activity', 'subject'), with=FALSE]

# mark feature column names with "Avg" to signify processing we've done.
cols <- c(vapply(cols, function(x) {paste('Avg', x, sep='-')}, character(1)),
          'activity', 'subject') # keep activity and subject columns
setnames(data, cols)

# Final dataframe has one row per subject, per activity, with
# 1 column each for those variables and 81 total for averaged feature data
tidydata <- data[,lapply(.SD, mean), by=c('subject', 'activity')]
