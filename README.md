# Upgrad_Cricket_Challenge
Upgrad Cricket Challenge - Analysis of Cricket data for India and Australia series Feb - March 2019

### Problem Statement - 
Analyse the ODI match data to predict
- Winner of the series
- Series Output
- Highest Run Scorer
- Maximum Fours 
- Maximum Sixes
- Highest Wicket Taker

### Dataset Used/ Database Creation -
Kaggle ODI Cricket Dataset - https://www.kaggle.com/jaykay12/odi-cricket-matches-19712017<br/>
Statsguru - http://stats.espncricinfo.com/ci/engine/stats/index.html

We use a R script to extract data from statsguru and write it to CSV.<br>
Script name - **download_batting_bowling.R**

CSV is generated for top 50 batsman for India and Australia to **"OverallBatting.csv"**.<br/>
CSV is generated for top 50 bowlers for India and Australia to **"OverallBowling.csv"**.<br/>
CSV is generated for match data analysis for all the teams (**"originalDataset.csv"**).<br/>

### Solution and Observations -
### 1. Winner of the series - 

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

![IndiaRecords](https://github.com/ameykarmarkar/Upgrad_Cricket_Challenge/blob/master/IndiaRecords.PNG)
![IndiaRecords](https://github.com/ameykarmarkar/Upgrad_Cricket_Challenge/blob/master/IndiaWinPerYear.PNG)

### 2. Series Output -

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

### 3. Highest Run Scorer -
**Predicted Highest Run Scorer - Virat Kohli**

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

![Batsman Analysis as per Avergae](https://github.com/ameykarmarkar/Upgrad_Cricket_Challenge/blob/master/BatsmanAverageAnalysis.png)

### 4. Maximun 4s -
**Predicted Maximum Fours Scorer - Virat Kohli**

**Steps Followed -** 
- Dataset selection
- Data Slicing for current players from India and Australia
- Generating derived variable fours_per_match
- Analysis as per fours per match scored

**Highest Fours scored per match for current players from team**
- Shikhar Dhawan
- Virat Kohli
- Rohit Sharma
- Aron Finch
- Shaun Marsh
- Ambati Raydu

![Batsman Analysis as per 4s per match](https://github.com/ameykarmarkar/Upgrad_Cricket_Challenge/blob/master/FoursPerMatchAnalysis.png)

### 5. Maximun 6s -
**Predicted Maximum Sixes Scorer - Rohit Sharma**

**Steps Followed -** 
- Dataset selection
- Data Slicing for current players from India and Australia
- Generating derived variable sixes_per_match
- Analysis as per sixes per match scored

**Highest Fours scored per match for current players from team**
- MP Stoinis
- Rohit Sharma
- Hardik Pandya
- Glenn Maxwell
- Aron Finch
- MS Dhoni

![Batsman Analysis as per 6s per match](https://github.com/ameykarmarkar/Upgrad_Cricket_Challenge/blob/master/SixesPerMatchAnalysis.png)

### 6. Highest Wicket Taker -
**Predicted Highest Wicket Taker - Jasprit Bumrah**

**Steps Followed -** 
- Dataset selection
- Data Slicing for current players from India and Australia
- Generating derived variable four_five_wicket_haul
- Analysis as per average of bowlers
- Analysis as per strike rate of bowlers
- Analysis as per four_five_wicket_haul

**Lowest strike rate for current players from team**
- Kuldeep Yadav
- Mohammed Shami
- Jasprit Bumrah
- YS Chahal
- NM Coulter - Nile
- PJ Cummins

**Highest four and five wicket haul current players from team**
- Mohammed Shami
- Jasprit Bumrah
- Kuldeep Ydav
- Bhuvaneshwar Kumar
- PJ Cummins
- YS Chahal

![Bolwer Analysis Strike Rate](https://github.com/ameykarmarkar/Upgrad_Cricket_Challenge/blob/master/BowlersStrkeRateAnalysis.png)
![Bolwer Analysis Four Wicket Haul](https://github.com/ameykarmarkar/Upgrad_Cricket_Challenge/blob/master/FourAndFiveWicketAnalysis.png)



