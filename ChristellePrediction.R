
filepath<-"/Users/Christelle/Desktop/Prediction Project"  ##here is a variable I've created that stores a string for my computer's desktop filepath
setwd(filepath)
#Load libraries
library(plyr)
library(caret)
library(nnet)
library(brew)
library(sos)
library(MASS)
require(dplyr)
library(tree)

# Import Data
#Bring in the training (larger) file
proj2training <- read.csv("training.csv")
## Final Testing Set For Output
finaltest <- read.csv("testing.csv")



relevantvar <- c("user_name","num_window","roll_belt","pitch_belt",	"yaw_belt",	"total_accel_belt",
                 "gyros_belt_x",	"gyros_belt_y",	"gyros_belt_z",	"accel_belt_x","accel_belt_y","accel_belt_z",
                 "magnet_belt_x",	"magnet_belt_y", "magnet_belt_z",	
                 "roll_arm","pitch_arm", "yaw_arm",	"total_accel_arm",
                 "gyros_arm_x",	"gyros_arm_y",	"gyros_arm_z",	
                 "accel_arm_x",	"accel_arm_y","accel_arm_z",
                 "magnet_arm_x",	"magnet_arm_y", "magnet_arm_z",
                 "roll_dumbbell", "pitch_dumbbell",	"yaw_dumbbell",
                 "total_accel_dumbbell",
                 "gyros_dumbbell_x",	"gyros_dumbbell_y",	"gyros_dumbbell_z",	
                 "accel_dumbbell_x",	"accel_dumbbell_y","accel_dumbbell_z",
                 "magnet_dumbbell_x",	"magnet_dumbbell_y",	"magnet_dumbbell_z",	
                 "roll_forearm",	"pitch_forearm",	"yaw_forearm",
                 "total_accel_forearm",
                 "gyros_forearm_x",	"gyros_forearm_y",	"gyros_forearm_z",
                 "accel_forearm_x",	"accel_forearm_y",	"accel_forearm_z",
                 "magnet_forearm_x",	"magnet_forearm_y",	"magnet_forearm_z",
                 "classe")
relevantvar2 <- c("user_name","num_window","roll_belt","pitch_belt",	"yaw_belt",	"total_accel_belt",
                 "gyros_belt_x",	"gyros_belt_y",	"gyros_belt_z",	"accel_belt_x","accel_belt_y","accel_belt_z",
                 "magnet_belt_x",	"magnet_belt_y", "magnet_belt_z",	
                 "roll_arm","pitch_arm", "yaw_arm",	"total_accel_arm",
                 "gyros_arm_x",	"gyros_arm_y",	"gyros_arm_z",	
                 "accel_arm_x",	"accel_arm_y","accel_arm_z",
                 "magnet_arm_x",	"magnet_arm_y", "magnet_arm_z",
                 "roll_dumbbell", "pitch_dumbbell",	"yaw_dumbbell",
                 "total_accel_dumbbell",
                 "gyros_dumbbell_x",	"gyros_dumbbell_y",	"gyros_dumbbell_z",	
                 "accel_dumbbell_x",	"accel_dumbbell_y","accel_dumbbell_z",
                 "magnet_dumbbell_x",	"magnet_dumbbell_y",	"magnet_dumbbell_z",	
                 "roll_forearm",	"pitch_forearm",	"yaw_forearm",
                 "total_accel_forearm",
                 "gyros_forearm_x",	"gyros_forearm_y",	"gyros_forearm_z",
                 "accel_forearm_x",	"accel_forearm_y",	"accel_forearm_z",
                 "magnet_forearm_x",	"magnet_forearm_y",	"magnet_forearm_z")
proj2training <- select(proj2training,relevantvar)
proj2training <- read.csv("training.csv")
# Partition Data
set.seed(0386)
trainingRowIndexProj2<-sample(1:nrow(proj2training), size = .7*nrow(proj2training))
#Training Dataset
training<-proj2training[trainingRowIndexProj2, ]
training<- data.frame(training)
#Testing Dataset
testing<-proj2training[-trainingRowIndexProj2, ]
testing <- data.frame(testing)
## Final Test
finaltest <- data.frame(finaltest)
finaltest <- select(finaltest,relevantvar2)



model <- train(classe~., data = training, method = "rf",
               trControl = trainControl(method = "cv", number = 5, verboseIter = TRUE)
)

tree_predict <- predict(model,testing)

## Checking accuracy
total <- 0
count <- 0
for(k in 1:length(tree_predict))
{
  total <- total +1
  if (testing$classe[k]==tree_predict[k])
  {
    count <- count + 1
  }
}
percent<- count/total
percent

final_predictions <- predict(model,finaltest)
View(final_predictions)

