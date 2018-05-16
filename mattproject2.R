#Working Script for Project 2
#Matt Hannula

#Set working directory
setwd("/Documents/GitHub/ECON386REPO/project2")

#Install Packages
install.packages("lattice")
install.packages("ggplot2")
install.packages("plyr")
install.packages("dplyr")
install.packages("caret")

#Load Libraries
library(lattice)
library(ggplot2)
library(plyr)
library(dplyr)
library(caret)

#Data Cleaning and Preprocessing
#Bring in the training (larger) file
proj2trainfull <- read.csv("training.csv", header = TRUE)

#View the dataset if desired.
View(proj2trainfull)
head(proj2trainfull)

#Remove unnecessary rows and columns.
proj2cleanstep1 <- filter(proj2trainfull, new_window == "no")
proj2cleanstep2 <- proj2cleanstep1[, colSums(is.na(proj2cleanstep1)) == 0] 

#View the CSV to determine unnecessary columns. Drop empty columns.
proj2cleanstep3 <- proj2cleanstep2[, -c(1:7, 12:20, 43:48, 52:60, 74:82)]

#Partition the cleaned dataset into 70:15:15 ratio for training:tuning:testing.
set.seed(0386)
trainingRowIndexProj2 <-sample(1:nrow(proj2cleanstep3), size = .7*nrow(proj2cleanstep3))
trainFinal <-proj2cleanstep3[trainingRowIndexProj2, ]
testTune <-proj2cleanstep3[-trainingRowIndexProj2, ]

#Take the remaining 30% of the data, and split into 15/15 ratio for tuning/testing.
testTuneIndexProj2 <- sample(1:nrow(testTune), size = .5*nrow(testTune))
tuneFinal <-testTune[testTuneIndexProj2, ]
testFinal <-testTune[-testTuneIndexProj2, ]
#We now have a 70/15/15 split with trainFinal, tuneFinal, and testFinal, respectively.
