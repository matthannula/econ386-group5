#Working Script for Project 2
#Matt Hannula

#Set working directory
setwd(insert yours here)

#Load libraries
library(plyr)
library(dplyr)

#Dataset Cleaning
#The goal here is to create a usable dataset for our respective training 
#so we can test and validate models individually.

#Bring in the training (larger) file
proj2training <- read.csv("training.csv")
View(proj2training)


#Set the seed (used class number), and partition the larger training CSV
#into a training and a testing set at a 70/30 ratio.
set.seed(0386)
trainingRowIndexProj2<-sample(1:nrow(proj2training), size = .7*nrow(proj2training))
trainingDataProj2<-proj2training[trainingRowIndexProj2, ]
testDataProj2 <-proj2training[-trainingRowIndexProj2, ]

#Now we have data to create our own models and test them.