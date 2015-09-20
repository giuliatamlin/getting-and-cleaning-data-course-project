library("dplyr")
library("plyr")
library("Hmisc")
library("data.table")
library("stringi")
library("knitr")
#get names and paths of files to read

directory <- "./UCI HAR Dataset"
test_file <- "test/X_test.txt"
test_activities <- "test/y_test.txt"
subject_test <- "test/subject_test.txt"
train_file <- "train/X_train.txt"
train_activities <- "train/y_train.txt"
subject_train <- "train/subject_train.txt"
activity_labels <- "activity_labels.txt"
col_names_file <- "features.txt" 

test_f <- paste(directory,test_file,sep = "/")
test_af <- paste(directory, test_activities,sep = "/")
test_sf <- paste(directory,subject_test, sep = "/")
train_f <- paste(directory,train_file, sep = "/")
train_af <- paste(directory, train_activities,sep = "/")
train_sf <- paste(directory,subject_train, sep = "/")
activity_f <- paste(directory, activity_labels,sep = "/")
col_names_f <- paste(directory,col_names_file, sep = "/")


# read in data
test_data <- read.table(test_f)
train_data <- read.table(train_f)

# extract column names from feature files and use it to assign descriptive names
# for the variables  in the data sets 

col_names <- read.table(col_names_f)
col_names <- as.character(col_names[,"V2"])
names(test_data) <- col_names
names(train_data) <- col_names

# read in labels and activities

act_labels <- read.table(activity_f)
test_act <- read.table(test_af)
train_act <- read.table(train_af)

# read in subjects
subj_test <- read.table(test_sf)
subj_train <- read.table(train_sf)

# add activities and subjects columns to both data sets,
# assign them descriptive names and make them categorical variables

test_data$activity <- test_act[,"V1"]
train_data$activity <- train_act[,"V1"]
test_data$activity <- factor(test_data$activity, levels = act_labels$V1,
                        labels = act_labels$V2)
train_data$activity <- factor(train_data$activity, levels = act_labels$V1,
                        labels = act_labels$V2)
test_data$subject <- subj_test[,"V1"]
train_data$subject <- subj_train[,"V1"]
test_data$subject <- factor(test_data$subject, levels = c(1:30))
train_data$subject <- factor(train_data$subject, levels = c(1:30))

# clear workspace of no longer needed dataframes
rm(list = c("test_act","train_act","act_labels","subj_test","subj_train"))

# merge data (using join as in this case both data sets have the same columns)

merged_data <- rbind(test_data,train_data)

# row of columns to be kept

vars <- which(stri_detect_fixed(names(test_data),"mean()") |
            stri_detect_fixed(names(test_data),"std()")|
            names(test_data)=="subject"|names(test_data)=="activity")

# keep only the chosen columns in merged data

merged_data <- merged_data[,vars]

# create new data frame with the mean with respect to activity and subject

new_data <- aggregate(. ~ activity + subject, merged_data, mean)

# write new dataframe to file

write.table(new_data,"./new_data.txt",row.names = FALSE)

# produce documentation

knitr2html("codebook.Rmd")


