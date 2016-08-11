## Data Wrangling Exercise 2: Dealing with missing values

#Download and save the *titanic* dataset
titanic_original=read.csv("titanic3.csv")
library(tidyr)
library(plyr)
library(dplyr)

#Port of embarkation
titanic_original$embarked[titanic_original$embarked == ''] <- "S"

#missing age
titanic_original$age = titanic_original %>% select(age)%>%replace_na(list(age=mean(titanic_original$age, na.rm=TRUE)))

#Lifeboat
titanic_original$boat[titanic_original$boat == ''] <- NA

#Cabin

titanic_original$has_cabin_number <- ifelse(titanic_original$cabin=="", 0, 1)
#Save data
titanic_clean <- titanic_original
write.csv(titanic_clean, "titanic_clean.csv")
