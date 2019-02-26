# Upgrad_Cricket_Challenge
Upgrad Cricket Challenge - Analysis of Cricket data for India and Australia series Feb - March 2019

# Problem Statement - 
Analyse the ODI match data to predict
- Winner of the series
- Series Output
- Highest Run Scorer
- Maximum Fours 
- Maximum Sixes
- Highest Wicket Taker

# Dataset Used/ Database Creation -
Kaggle ODI Cricket Dataset - https://www.kaggle.com/jaykay12/odi-cricket-matches-19712017<br/>
Statsguru - http://stats.espncricinfo.com/ci/engine/stats/index.html

We use a R script to extract data from statsguru and write it to CSV.<br>
Script name - **download_batting_bowling.R**

CSV is generated for top 50 batsman for India and Australia to **"OverallBatting.csv"**.<br/>
CSV is generated for top 50 bowlers for India and Australia to **"OverallBowling.csv"**.<br/>
CSV is generated for match data analysis for all the teams (**"originalDataset.csv"**).<br/>

# Solution and Observations -
## 1. Winner of the series - 

**Predicted Winner - India**

Data Analysis is performed for 
- India win percentage against all countries at all venues from 2010 - 61.62%
- India win percentage against Australia at all venues - 44%
- India win percentage against Australia in Home Series (Venue - India Grounds) - 60%
- Australia win percentage against all countries at all venues from 2010 -59.44%
- Australia win percentage against India at all venues - 48%
- Australia win percentage against India in India - 33%

Data cleaning and selection is performed on originalDataset.csv<br/>
Data is selected for India matches, Australia matches, Home matches.<br/>

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
- Data Validation
- Data Slicing
- Dummy Variable Creation
- Target Variable Creation
- Logistic regression model building
- Prediction

Dummy variables are generated for the categorical variables Team1, Team2 and Ground.<br/>
IsWon target variable generated based on winner column.

**Accuracy of model is 57%**.<br/>
**Predictiion from model is India will win all the matches. But we have analysed the win percentage of India in home series against Australia is 60% and win percentage of Australia is 33 %.<br/>
So combinely we can predict series result as 3-2.** 

# 3. Highest Run Scorer -
**Predicted Highest Run Scorer - Virat Kohali**

**Steps Followed -** 
- Dataset selection
- Data Slicing for current players from India and Australia
- Analysis as per Average of Batsman 

**Highest Avg for current players from team**
- Virat Kohli
- MS Dhoni
- Rohit Sharma
- Ambati Rayadu
- Shikhar Dhawan

![alt text](https://raw.githubusercontent.com/username/projectname/branch/path/to/img.png)
