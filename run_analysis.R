features <- read.table('features.txt', colClasses=c('integer', 'character'))
names(features) <- c('id', 'name')

activities <- read.table('activity_labels.txt', colClasses=c('integer', 'character'))
names(activities) <- c('level', 'label')

# test dataset
test.data <- read.table('test//X_test.txt')
names(test.data) <- features$name

test.subjects <- read.table('test//subject_test.txt')
names(test.subjects) <- 'subject'
test.data$subject <- factor(test.subjects$subject, 1:30)
remove(test.subjects)

test.activities <- read.table('test//y_test.txt')
names(test.activities) <- 'activity'
test.data$activity <- factor(test.activities$activity, activities$level, activities$label)
remove(test.activities)

# train dataset
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

remove(activities, features)

# rbind
data <- rbind(test.data, train.data)

remove(test.data, train.data)

data <- data.table(data)

# remove extra cols, only keep mean() and std()
cols <- names(data)
cols <- cols[cols %in% grep('std\\(\\)|mean\\(\\)|meanFreq\\(\\)', cols, value=T)]
data <- data[,c(cols, 'activity', 'subject'), with=FALSE]

# mark column names with "Avg" to signify processing we've done.
cols <- c(vapply(cols, function(x) {paste('Avg', x, sep='-')}, character(1)), 'activity', 'subject')
setnames(data, cols)

#FINAL DF -> ONE ROW PER SUBJECT, PER ACTIVITY WITH ALL AVERAGE VALS
tidydata <- data[,lapply(.SD, mean), by=c('subject', 'activity')]
