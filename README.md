# Upgrad_Cricket_Challenge
Upgrad Cricket Challenge - Analysis of Cricket data for India and Australia series Feb - March 2019

# Problem Statement - 
Analyse the ODI match data to predict
1. Winner of the series
2. Series Output
3. Highest Run Scorer
4. Maximum Fours 
5. Maximum Sixes
6. Highest Wicket Taker

# Dataset Used/ Database Creation -
Kaggle ODI Cricket Dataset - https://www.kaggle.com/jaykay12/odi-cricket-matches-19712017
Statsguru - http://stats.espncricinfo.com/ci/engine/stats/index.html

We use a R script to extract data from statsguru and write it to CSV.
Script name - **download_batting_bowling.R**

CSV is generated for top 50 batsman for India and Australia to **"OverallBatting.csv"**.
CSV is generated for top 50 bowlers for India and Australia to **"OverallBowling.csv"**.
CSV is generated for match data analysis for all the teams (**"originalDataset.csv"**).

# Solution and Observations -
# 1. Winner of the series - 

**Predicted Winner - India**

Data Analysis is performed for 
i. India win percentage against all countries at all venues from 2010 - 61.62%
ii. India win percentage against Australia at all venues - 44%
iii. India win percentage against Australia in Home Series (Venue - India Grounds) - 60%
iv. Australia win percentage against all countries at all venues from 2010 -59.44%
v. Australia win percentage against India at all venues - 48%
vi. Australia win percentage against India in India - 33%

Data cleaning and selection is performed on originalDataset.csv
Data is selected for India matches, Australia matches, Home matches.

India win percentage drops down to 44% against Australia from 60% but India's winning percentage reaches to 60% in the home series.
Australia win percentage in India is very low i.e. 33%.
So we can predict the winner of the series as India.

# 2. Series Output -
**Predicted Series Output - 3-2 (India - Australia)**

**Logistic regression model** is developed to predict the result of matches for 5 ODI. 
Factors considered for the development of model are -
Team1, Team2 - Team Names
Winner - Winner team name of match
Ground - Venue Name

**Steps followed -** 
i. Data Validation
ii. Data Slicing
iii. Dummy Variable Creation
iv. Target Variable Creation
v. Logistic regression model building
vi. Prediction

Dummy variables are generated for the categorical variables Team1, Team2 and Ground.
IsWon target variable generated based on winner column.

**Accuracy of model is 57%**.
**Predictiion from model is India will win all the matches. But we have analysed the win percentage of India in home series against Australia is 60% and win percentage of Australia is 33 %.
So combinely we can predict series result as 3-2.** 

# 3. Highest Run Scorer -
**Predicted Highest Run Scorer - Virat Kohali**

**Steps Followed -** 
i. Dataset selection
ii. Data Slicing for current players from India and Australia
iii. Analysis as per Average of Batsman 

** Highest Avg for current players from team**
1. Virat Kohli
2. MS Dhoni
3. Rohit Sharma
4. Ambati Rayadu
5. Shikhar Dhawan

![alt text](https://raw.githubusercontent.com/username/projectname/branch/path/to/img.png)
