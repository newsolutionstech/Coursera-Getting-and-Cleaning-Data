# load plyr package

require(plyr)

#Set working directory for subsequent read.table commands
#folder locations ahave beed adjusted from original zip file

setwd("D:/Users/Steve/Desktop/Coursera-Getting-and-Cleaning-Data/peer_assessment")

# Read in the training and the test data sets in preparation of creating one data set.

x_train_Data <- read.table("./data/train/X_train.txt")
y_train_Data <- read.table("./data/train/y_train.txt")
subject_train <- read.table("./data/train/subject_train.txt")

x_test_Data <- read.table("./data/test/X_test.txt")
y_test_Data <- read.table("./data/test/y_test.txt")
subject_test <- read.table("./data/test/subject_test.txt")

features <- read.table("./data/UCI HAR Dataset/features.txt", colClasses = c("character"))
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", col.names = c("ActivityId", "Activity"))

# Step 1. Merge the train and test tables to create one complete data set using a combination of cbind and rbind

training_sensor_data <- cbind(cbind(x_train_Data, subject_train), y_train_Data)
test_sensor_data <- cbind(cbind(x_test_Data, subject_test), y_test_Data)
all_sensor_data <- rbind(training_sensor_data, test_sensor_data)

all_sensor_labels <- rbind(rbind(features, c(562, "Subject")), c(563, "ActivityId"))[,2]

names(all_sensor_data) <- all_sensor_labels

# Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.

all_sensor_data_mean_std <- all_sensor_data[,grepl("mean|std|Subject|ActivityId", names(all_sensor_data))]

# Step 3. Use descriptive activity names to name the activities in the data set

all_sensor_data_mean_std <- join(all_sensor_data_mean_std, activity_labels, by = "ActivityId", match = "first")
all_sensor_data_mean_std <- all_sensor_data_mean_std[,-1]

# Remove parentheses
names(all_sensor_data_mean_std) <- gsub('\\(|\\)',"",names(all_sensor_data_mean_std), perl = TRUE)

# Make names valid 
names(all_sensor_data_mean_std) <- make.names(names(all_sensor_data_mean_std))

# Make clear names
names(all_sensor_data_mean_std) <- gsub('Acc',"Acceleration",names(all_sensor_data_mean_std))
names(all_sensor_data_mean_std) <- gsub('GyroJerk',"AngularAcceleration",names(all_sensor_data_mean_std))
names(all_sensor_data_mean_std) <- gsub('Gyro',"AngularSpeed",names(all_sensor_data_mean_std))
names(all_sensor_data_mean_std) <- gsub('Mag',"Magnitude",names(all_sensor_data_mean_std))
names(all_sensor_data_mean_std) <- gsub('^t',"TimeDomain.",names(all_sensor_data_mean_std))
names(all_sensor_data_mean_std) <- gsub('^f',"FrequencyDomain.",names(all_sensor_data_mean_std))
names(all_sensor_data_mean_std) <- gsub('\\.mean',".Mean",names(all_sensor_data_mean_std))
names(all_sensor_data_mean_std) <- gsub('\\.std',".StandardDeviation",names(all_sensor_data_mean_std))
names(all_sensor_data_mean_std) <- gsub('Freq\\.',"Frequency.",names(all_sensor_data_mean_std))
names(all_sensor_data_mean_std) <- gsub('Freq$',"Frequency",names(all_sensor_data_mean_std))

# Create a second, independent tidy data set with the average of each variable for each activity
# and each subject

all_sensor_average_by_activity_subject = ddply(all_sensor_data_mean_std, c("Subject","Activity"), numcolwise(mean))

write.table(all_sensor_average_by_activity_subject, file = "all_sensor_average_by_activity_subject.txt", row.name=FALSE)
