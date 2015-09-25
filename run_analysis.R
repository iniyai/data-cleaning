library(dplyr)

# Get train and test data sets with subject and activity.

test <- read.table("./UCI HAR Dataset/test/X_test.txt")
train <- read.table("./UCI HAR Dataset/train/X_train.txt")

sub <- read.table("./UCI HAR Dataset/test/subject_test.txt")
sub1 <- read.table("./UCI HAR Dataset/train/subject_train.txt")

act <- read.table("./UCI HAR Dataset/test/y_test.txt")
act1 <- read.table("./UCI HAR Dataset/train/y_train.txt")

#Step1. merge the train and test datasets
t <- rbind(train,test)
sub <- rename(rbind(sub,sub1),SUBJECT = V1)
act <- rename(rbind(act,act1),ACTIVITY = V1)

#Step 3. appropriate names for activities
for (i in 1:nrow(act)){
  if(act[i,"ACTIVITY"] == 1) { act[i,"ACTIVITY"] = "WALKING"}
  if(act[i,"ACTIVITY"] == 2) { act[i,"ACTIVITY"] = "WALKING_UPSTAIRS"}
  if(act[i,"ACTIVITY"] == 3) { act[i,"ACTIVITY"] = "WALKING_DOWNSTAIRS"}
  if(act[i,"ACTIVITY"] == 4) { act[i,"ACTIVITY"] = "SITTING"}
  if(act[i,"ACTIVITY"] == 5) { act[i,"ACTIVITY"] = "STANDING"}
  if(act[i,"ACTIVITY"] == 6) { act[i,"ACTIVITY"] = "LAYING"}
}

#step 2. use only mean and std values
t1 <- select(t,1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,294:296,345:350,373:375,424:429,452:454,503:504,529:530,542:543)
t1 <- cbind(t1,sub,act) #merge the activites and subject along with the feature values.

#Step4. to improve usability, the columns of the data sets are changed
t1 <- rename(t1,
             tBodyAcMX = V1,
             tBodyAcMY = V2,
             tBodyAcMZ = V3,
             tBodyAcSX = V4,
             tBodyAcSY = V5,
             tBodyAcSZ = V6,
             tGravAcMX = V41,
             tGravAcMY = V42,
             tGravAcMZ = V43,
             tGravAcSX = V44,
             tGravAcSY = V45,
             tGravAcSZ = V46,
             tGravAcJerkMX = V81,
             tGravAcJerkMY = V82,
             tGravAcJerkMZ = V83,
             tGravAcJerkSX = V84,
             tGravAcJerkSY = V85,
             tGravAcJerkSZ = V86,
             tBodyGyroMX = V121,
             tBodyGyroMY = V122,
             tBodyGyroMZ = V123,
             tBodyGyroSX = V124,
             tBodyGyroSY = V125,
             tBodyGyroSZ = V126,
             tBodyGyroJerkMX = V161,
             tBodyGyroJerkMY = V162,
             tBodyGyroJerkMZ = V163,
             tBodyGyroJerkSX = V164,
             tBodyGyroJerkSY = V165,
             tBodyGyroJerkSZ = V166,
             tBodyAccMagM = V201,
             tBodyAccMagS = V202,
             tGravityAccMagM = V214,
             tGravityAccMagS = V215,
             tBodyGyroJerkSYM = V227,
             tBodyGyroJerkSYS = V228,
             tBodyGyroMagM = V240,
             tBodyGyroMagS = V241,
             tBodyGyroJerkMagM = V253,
             tBodyGyroJerkMagS = V254,
             fBodyAccMX = V266,
             fBodyAccMY = V267,
             fBodyAccMZ = V268,
             fBodyAccSX = V269,
             fBodyAccSY = V267,
             fBodyAccSZ = V268,
             fBodyAccmFX = V294,
             fBodyAccmFY = V295,
             fBodyAccmFZ = V296,
             fBodyAccJerkMX = V345,
             fBodyAccJerkMY = V346,
             fBodyAccJerkMZ = V347,
             fBodyAccJerkSX = V348,
             fBodyAccJerkSY = V349,
             fBodyAccJerkSZ = V350,
             fBodyAccJerkmFX = V373,
             fBodyAccJerkmFY = V374,
             fBodyAccJerkmFZ = V375,
             fBodyGyroMX = V424,
             fBodyGyroMY = V425,
             fBodyGyroMZ = V426,
             fBodyGyroSX = V427,
             fBodyGyroSY = V428,
             fBodyGyroSZ = V429,
             fBodyGyromFX = V452,
             fBodyGyromFY = V453,
             fBodyGyromFZ = V454,
             fBodyAccMagM = V503,
             fBodyAccMagS = V504,
             fBodyGyroMagM = V529,
             fBodyGyroMagS = V530,
             fBodyGyroJerkMagM = V542,
             fBodyGyroJerkMagS = V543
)
#Step5. The table is grouped by activity and subject & mean is found out.
final <- group_by(t1,ACTIVITY,SUBJECT)
fin <- final %>% summarise_each(funs(mean))
