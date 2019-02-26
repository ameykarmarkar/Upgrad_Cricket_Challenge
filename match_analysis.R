#--------Loading the data set --------#
match_data <- read.csv("originalDataset.csv", header=TRUE, stringsAsFactors=FALSE)
View(match_data)
str(match_data)

#Loading necessary packages
library(stringr)
#library(forecast)

#extracting year information of match
year<- strsplit(as.character(match_data$Match.Date),',')

do.call(rbind, year)
match_data <- data.frame(match_data, do.call(rbind, year))

#separate data of only India matches
match_data_India <- match_data[which(match_data$Team.1 == 'India' | match_data$Team.2 == 'India' ) ,]

#check India win percentage overall
match_data_India$IsWon <- ifelse(match_data_India$Winner == 'India',1,0)


#match_data_India <- match_data_India[which(match_data_India$X2 > "2005")]
match_data_India$X2 <- as.numeric(as.character(match_data_India$X2))
str(match_data_India)
View(match_data_India)

#extract data of India matches after 2010
match_data_India <- match_data_India[which(match_data_India$X2 >= 2000) ,]


india_grounds <- c("Visakhapatnam","Ahmedabad","Pune","Jaipur","Mohali","Ranchi","Nagpur","Bengaluru",
                   "Chennai","Kolkata","Indore")

match_data_India_home_series<- match_data_India[which(is.element(match_data_India$Ground,india_grounds)),]
View(match_data_India_home_series)


############################## Model to predict match result ############################################
#convert categorial variable to factor
match_data_India_home_series$X2 <- factor(match_data_India_home_series$X2)

# creating a dataframe of categorical features
match_data_India_home_series_chr<- match_data_India_home_series[,c(3,6)]
View(match_data_India_home_series_chr)
# converting categorical attributes to factor
match_data_fact<- data.frame(sapply(match_data_India_home_series_chr, function(x) factor(x)))
str(match_data_fact)

# creating dummy variables for factor attributes
dummies<- data.frame(sapply(match_data_fact, 
                            function(x) data.frame(model.matrix(~x-1,data =match_data_fact))))


# Final dataset
match_data_final<- cbind(match_data_India_home_series[,c(9,10)],dummies) 
View(match_data_final) 


# splitting the data between train and test
library(caTools)


set.seed(100)

indices = sample.split(match_data_final$IsWon, SplitRatio = 0.7)

train = match_data_final[indices,]

test = match_data_final[!(indices),]



#Initial model
model_1 = glm(IsWon ~ ., data = train, family = "binomial")
summary(model_1) 

# Stepwise selection
library("MASS")
model_2<- stepAIC(model_1, direction="both")

summary(model_2)

model_2

#removing Team South Africa has high p-Value
model_3 <- glm(formula = IsWon ~ Team.2.xAustralia + Team.2.xPakistan + Ground.xIndore + Ground.xJaipur, family = "binomial", 
    data = train)

summary(model_3)

#removing Ground Indore
model_4 <- glm(formula = IsWon ~ Team.2.xAustralia + Team.2.xPakistan + Ground.xJaipur, family = "binomial", 
               data = train)

summary(model_4)


final_model <- model_4

# Removing multicollinearity through VIF check
library(car)
vif(model_2)

#VIF is low for all factors

### Model Evaluation

### Test Data ####

#predicted probabilities of Churn 1 for test data

test_pred = predict(final_model, type = "response", 
                    newdata = test[,-2])


# Let's see the summary 

summary(test_pred)

test$prob <- test_pred
#View(test)
# Let's use the probability cutoff of 50%.

test_pred_win <- factor(ifelse(test_pred >= 0.50, "Win", "Loss"))
test_actual_win <- factor(ifelse(test$IsWon==1,"Win","Loss"))


table(test_actual_win,test_pred_win)


#######################################################################
test_pred_win <- factor(ifelse(test_pred >= 0.40, "Win", "Loss"))

#install.packages("e1071")
library(e1071)
library(caret)
test_conf <- confusionMatrix(test_pred_win, test_actual_win, positive = "Win")
test_conf
#######################################################################

#########################################################################################
# Let's Choose the cutoff value. 
# 

# Let's find out the optimal probalility cutoff 

perform_fn <- function(cutoff) 
{
  predicted_win <- factor(ifelse(test_pred >= cutoff, "Win", "Loss"))
  conf <- confusionMatrix(predicted_win, test_actual_win, positive = "Win")
  acc <- conf$overall[1]
  sens <- conf$byClass[1]
  spec <- conf$byClass[2]
  out <- t(as.matrix(c(sens, spec, acc))) 
  colnames(out) <- c("sensitivity", "specificity", "accuracy")
  return(out)
}

# Creating cutoff values from 0.003575 to 0.812100 for plotting and initiallizing a matrix of 100 X 3.

# Summary of test probability

summary(test_pred)

s = seq(.12,.80,length=100)

OUT = matrix(0,100,3)


for(i in 1:100)
{
  OUT[i,] = perform_fn(s[i])
} 


plot(s, OUT[,1],xlab="Cutoff",ylab="Value",cex.lab=1.5,cex.axis=1.5,ylim=c(0,1),type="l",lwd=2,axes=FALSE,col=2)
axis(1,seq(0,1,length=5),seq(0,1,length=5),cex.lab=1.5)
axis(2,seq(0,1,length=5),seq(0,1,length=5),cex.lab=1.5)
lines(s,OUT[,2],col="darkgreen",lwd=2)
lines(s,OUT[,3],col=4,lwd=2)
box()
legend(0,.50,col=c(2,"darkgreen",4,"darkred"),lwd=c(2,2,2,2),c("Sensitivity","Specificity","Accuracy"))


cutoff <- s[which(abs(OUT[,1]-OUT[,2])<0.01)]

# Let's choose a cutoff value of 0.3132 for final model

test_cutoff_win <- factor(ifelse(test_pred >=0.4, "Win", "Loss"))

conf_final <- confusionMatrix(test_cutoff_win, test_actual_win, positive = "Win")

acc <- conf_final$overall[1]

sens <- conf_final$byClass[1]

spec <- conf_final$byClass[2]

acc

sens

spec

View(test)
##################################################################################################

#generate data frame for predicting results
test_data <- data.frame("X2" = c(2019,2019,2019,2019,2019), "Team.2.xAustralia" = c(1,1,1,1,1), 
                        "Team.2.xPakistan" = c(0,0,0,0,0), "Ground.xJaipur" = c(0,0,0,0,0))

test_pred = predict(final_model, type = "response", 
                    newdata = test_data[,])

test_pred

test_cutoff_win <- factor(ifelse(test_pred >=0.4, "Win", "Loss"))
test_cutoff_win

#all win is expected




############################## End of Model Building #####################################################

#check India win percentage overall
match_data_India$IsWon <- ifelse(match_data_India$Winner == 'India',1,0)
sum(match_data_India$IsWon)
per_win_India = sum(match_data_India$IsWon)/nrow(match_data_India)
per_win_India
# 61.62

#check India win percentage against Aus
match_data_India$IsWonAgainstAus <- ifelse((match_data_India$Team.2 == 'Australia' | match_data_India$Team.1 == 'Australia') & match_data_India$Winner == 'India',1,0)
match_data_India_Aus <- match_data_India[which((match_data_India$Team.1 == 'Australia' & match_data_India$Team.2 == 'India') | (match_data_India$Team.1 == 'India' & match_data_India$Team.2 == 'Australia')),]
per_win_India_againstAus <- sum(match_data_India_Aus$IsWonAgainstAus)/nrow(match_data_India_Aus) 
per_win_India_againstAus
# 44



india_matches_ground_list <- unique(match_data_India_Aus$Ground)
View(india_matches_ground_list)

india_grounds <- c("Visakhapatnam","Ahmedabad","Pune","Jaipur","Mohali","Ranchi","Nagpur","Bengaluru","Perth","Canberra",
                   "Chennai","Kolkata","Indore")
#View(india_grounds)

match_data_India_Aus_home_series<- match_data_India_Aus[which(is.element(match_data_India_Aus$Ground,india_grounds)),]
View(match_data_India_Aus_home_series)

per_win_India_againstAus_homeseries <- sum(match_data_India_Aus_home_series$IsWonAgainstAus)/nrow(match_data_India_Aus_home_series)
per_win_India_againstAus_homeseries
#60

match_data_India_homeseries <- match_data_India[which(is.element(match_data_India$Ground,india_grounds)),]
per_win_India_againstAll_homeseries <- sum(match_data_India_homeseries$IsWon)/nrow(match_data_India_homeseries)
per_win_India_againstAll_homeseries
#68

match_data_Australia <- match_data[which(match_data$Team.1 == 'Australia' | match_data$Team.2 == 'Australia' ) ,]

#match_data_India <- match_data_India[which(match_data_India$X2 > "2005")]
match_data_Australia$X2 <- as.numeric(as.character(match_data_Australia$X2))
#str(match_data_India)
View(match_data_Australia)
match_data_Australia <- match_data_Australia[which(match_data_Australia$X2 >= 2010) ,]

match_data_Australia$IsWon <- ifelse(match_data_Australia$Winner == 'Australia',1,0)
sum(match_data_Australia$IsWon)
per_win_Australia = sum(match_data_Australia$IsWon)/nrow(match_data_Australia)
per_win_Australia
#59.44

match_data_Australia$IsWonAgainstInd <- ifelse((match_data_Australia$Team.2 == 'India' | match_data_Australia$Team.1 == 'India') & match_data_Australia$Winner == 'Australia',1,0)
match_data_Aus_India <- match_data_Australia[which(match_data_Australia$Team.1 == 'India' | match_data_Australia$Team.2 == 'India'),]
per_win_Australia_againstInd <- sum(match_data_Aus_India$IsWonAgainstInd)/nrow(match_data_Aus_India) 
per_win_Australia_againstInd
#48

match_data_India_Aus_Away_series<- match_data_Aus_India[which(is.element(match_data_Aus_India$Ground,india_grounds)),]
View(match_data_India_Aus_Away_series)

per_win_Aus_againstInd_awayseries <- sum(match_data_India_Aus_Away_series$IsWonAgainstInd)/nrow(match_data_India_Aus_Away_series)
per_win_Aus_againstInd_awayseries
#33

#percentage home series win of India is 68 and against Australia is 60 so series winner expected India

#Now try to find the record of India based on Venue Hyderabad, Nagpur, Ranchi, Mohali, Delhi
match_data_India_Hyd <- match_data_India[which(match_data_India$Ground =='Hyderabad (Deccan)'),]
per_win_India_Hyd <- sum(match_data_India_Hyd$IsWon)/nrow(match_data_India_Hyd)
nrow(match_data_India_Hyd)
#2
per_win_India_Hyd
#100

match_data_India_Nag <- match_data_India[which(match_data_India$Ground =='Nagpur'),]
per_win_India_Nag <- sum(match_data_India_Nag$IsWon)/nrow(match_data_India_Nag)
nrow(match_data_India_Nag)
#3
per_win_India_Nag
#66

match_data_India_Ranchi <- match_data_India[which(match_data_India$Ground =='Ranchi'),]
per_win_India_Ranchi <- sum(match_data_India_Ranchi$IsWon)/nrow(match_data_India_Ranchi)
nrow(match_data_India_Ranchi)
#4
per_win_India_Ranchi
#50

match_data_India_Mohali <- match_data_India[which(match_data_India$Ground =='Mohali'),]
per_win_India_Mohali <- sum(match_data_India_Mohali$IsWon)/nrow(match_data_India_Mohali)
nrow(match_data_India_Mohali)
#5
per_win_India_Mohali
#80

match_data_India_Delhi <- match_data_India[which(match_data_India$Ground =='Delhi'),]
per_win_India_Delhi <- sum(match_data_India_Delhi$IsWon)/nrow(match_data_India_Delhi)
nrow(match_data_India_Delhi)
#5
per_win_India_Delhi
#80


#need some strong evidences to answer series status
#win percentage in Mohali and Delhi is good with 5 matches played at both venue so predicting matches at that locations India will win
#Performace of team India is average at Ranchi so predicting loss for Ranchi
#Predicting loss at Nagpur and Win at Hyderabad
library(dplyr)
by_year <- match_data_India %>% group_by(X2)

# grouping doesn't change how the data looks (apart from listing
# how it's grouped):
by_year

# It changes how it acts with the other dplyr verbs:
by_year_dataset <- by_year %>% summarise(IsWon = sum(IsWon),match_played = n())

View(by_year_dataset)

library(ggplot2)
ggplot(match_data_India, aes(x = X2, fill = factor(IsWon))) + geom_histogram(position = "stack") +  labs(title = "India Record Per Year", x = "Year", y = "No.of Matches Played", fill = "Win Status") 


by_year_dataset$win_per <- (by_year_dataset$IsWon/by_year_dataset$match_played)*100
ggplot(by_year_dataset, aes(x = by_year_dataset$X2, y = by_year_dataset$win_per)) + geom_line() +  labs(title = "India Record Per Year", x = "Year", y = "Win Percentage") 

#ggplot(by_year_dataset, aes(x=X2, y=match_played)) + geom_bar(stat = "identity")


