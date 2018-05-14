#Working Script for Project 2
#Matt Hannula

#Set working directory
setwd(insert yours here)

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
proj2trainfull <- read.csv("training.csv")

#View the dataset if desired.
View(proj2trainfull)
head(proj2trainfull)

#Remove unnecessary rows and columns.
proj2cleanstep1 <- filter(proj2trainfull, new_window == "no")
proj2cleanstep2 <- proj2cleanstep1[, colSums(is.na(proj2cleanstep1)) == 0] 

#Partition the training file provided into a training and testing subset.
#Set seed for reproducibility.
set.seed(0386)

trainingRowIndexProj2 <-sample(1:nrow(proj2cleanstep2), size = .7*nrow(proj2cleanstep2))
trainFinal <-proj2cleanstep2[trainingRowIndexProj2, ]
testFinal <-proj2cleanstep2[-trainingRowIndexProj2, ]

#We now have trainFinal and testFinal, to train and validate our models.
