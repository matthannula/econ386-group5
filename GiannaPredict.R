##Gianna Project 2 R Code

#Set woking directory 
setwd(/Users/giannarusca/Desktop)

##Install and load packages
install.packages("lattice")
install.packages("ggplot2")
install.packages("plyr")
install.packages("dplyr")
install.packages("caret")
library(lattice)
library(ggplot2)
library(plyr)
library(dplyr)
library(caret)

#In excel created a numeric "move" variable to train data prior to uploading (A=1, B=2, C=3, D=4, E=5)

#Data Cleaning and Preprocessing
#Bring in the training file
proj2trainfull <- read.csv("training.csv", header = TRUE)

proj2test<- read.csv("testing.csv", header = TRUE)

#Clean up rows and columns.
proj2cleanstep1 <- filter(proj2trainfull, new_window == "no")
proj2cleanstep2 <- proj2cleanstep1[, colSums(is.na(proj2cleanstep1)) == 0] 

#Clean columns 
proj2cleanstep3 <- proj2cleanstep2[, -c(1:7, 12:20, 43:48, 52:60, 74:82)]

#Partition  cleaned dataset into 70:15:15 ratio for training:tuning:testing.
set.seed(0386)
trainingRowIndexProj2 <-sample(1:nrow(proj2cleanstep3), size = .7*nrow(proj2cleanstep3))
trainFinal <-proj2cleanstep3[trainingRowIndexProj2, ]
testTune <-proj2cleanstep3[-trainingRowIndexProj2, ]


#Take the remaining 30% of the data, and split into 15/15 ratio for tuning/testing.
testTuneIndexProj2 <- sample(1:nrow(testTune), size = .5*nrow(testTune))
tuneFinal <-testTune[testTuneIndexProj2, ]
testFinal <-testTune[-testTuneIndexProj2, ]

output<-lm(move~yaw_belt+total_accel_belt+accel_belt_x+accel_belt_y+accel_belt_z+magnet_belt_x+magnet_belt_y+magnet_belt_z+roll_arm+pitch_arm+yaw_arm+total_accel_arm+gyros_arm_x+gyros_arm_y+gyros_arm_z+accel_forearm_x+accel_forearm_y+accel_forearm_z+magnet_forearm_x+magnet_forearm_y+magnet_forearm_z+gyros_forearm_x+gyros_forearm_y+gyros_forearm_z, data=trainFinal)

summary(output)

model_predict<- predict(output,testTune)

summary(model_predict)

View(model_predict)


library("nnet")

output2<- multinom(move~roll_belt+pitch_belt+yaw_belt+total_accel_belt+accel_belt_x+accel_belt_y+accel_belt_z+magnet_belt_x+magnet_belt_y+magnet_belt_z+roll_arm+pitch_arm+yaw_arm+total_accel_arm+gyros_arm_x+gyros_arm_y+gyros_arm_z+accel_forearm_x+accel_forearm_y+accel_forearm_z+magnet_forearm_x+magnet_forearm_y+magnet_forearm_z+gyros_forearm_x+gyros_forearm_y+gyros_forearm_z+accel_dumbbell_x+accel_dumbbell_y+accel_dumbbell_z+magnet_dumbbell_x+magnet_dumbbell_y+magnet_dumbbell_z+roll_forearm+pitch_forearm+yaw_forearm+total_accel_forearm, data=trainFinal)

summary(output2)

model_predict2<- predict(output2,testTune)
summary(model_predict2)
model_predict2_final <-predict(output2,testFinal)

View(model_predict2_final)
summary(model_predict2_final)

model_predict3_final<-predict(output2,proj2test)
View(model_predict3_final)

summary(output2)