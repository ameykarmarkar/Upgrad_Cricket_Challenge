#--------Loading the data set --------#
batting_data <- read.csv("OverallBatting.csv", header=TRUE, stringsAsFactors=FALSE)
View(batting_data)

playing_batsman_list <- c("V Kohli","RG Sharma","S Dhawan","AT Rayudu","KM Jadhav","MS Dhoni",
                          "HH Pandya","RR Pant","AJ Finch","AT Carey","UT Khawaja","SE Marsh",
                          "DJM Short", "PSP Handscomb", "MP Stoinis", "GJ Maxwell","PJ Cummins",
                          "KW Richardson", "KL Rahul")

#selecting playing batsman 
batting_data_playing_batsman <- batting_data[which(is.element(batting_data$Player,playing_batsman_list)),]
View(batting_data_playing_batsman)

batting_data_playing_batsman <- batting_data_playing_batsman[,c(2,4:16)]
View(batting_data_playing_batsman)

#finding players having best average
batting_data_sort_Avg <- batting_data_playing_batsman[order(batting_data_playing_batsman$Ave, decreasing = TRUE),] 
head(batting_data_sort_Avg)
# 1. Virat Kohli
# 2. MS Dhoni
# 3. Rohit Sharma
# 4. Ambati Rayadu
# 5. Shikhar Dhawan

#deriving fours per match and sixes per match parameter to find player who can hit max number of fours and max number of sixes
batting_data_playing_batsman$fours_per_match <- batting_data_playing_batsman$X4s/batting_data_playing_batsman$Inns

batting_data_playing_batsman$sixes_per_match <- batting_data_playing_batsman$X6s/batting_data_playing_batsman$Inns

# finding top players for fours per match
batting_data_sort_forus <- batting_data_playing_batsman[order(batting_data_playing_batsman$fours_per_match, decreasing = TRUE),] 
head(batting_data_sort_forus)
# 1. Shikhar Dhawan
# 2. Virat Kohali
# 3. Rohit Sharma
# 4. Aron Finch
# 5. Shaun Marsh
# 6. Ambati Raydu

# finding top players for six per match
batting_data_sort_sixes <- batting_data_playing_batsman[order(batting_data_playing_batsman$sixes_per_match, decreasing = TRUE),]
head(batting_data_sort_sixes)
# 1. MP Stoinis
# 2. Rohit Sharma
# 3. Hardik Pandya
# 4. Glenn Maxwell
# 5. Aron Finch
# 6. MS Dhoni

#sort data based on strike rate
batting_data_sort_sr <- batting_data_playing_batsman[order(batting_data_playing_batsman$SR,decreasing = TRUE),]
head(batting_data_sort_sr)
# 1. Rishabh Pant 
# 2. Glenn Maxwell
# 3. Hardik Pandya
# 4. Kedar Jadhav
# 5. Peter Handscomb
# 6 . MP Stoinis

### Conclusions - 
# 1. Highest Run Scorer - Virat Kohali (batting position is also higher)
# 2. Player for max no. of fours - Virat Kohali (long innings)
# 3. Player for max no.of sixes - MP Stoinis/ Rohit Sharma


################################## Bowling Data Analysis#########################################
bowling_data <- read.csv("OverallBowling.csv", header=TRUE, stringsAsFactors=FALSE)
View(bowling_data)

playing_bowlers_list <- c("JJ Bumrah","Mohammed Shami", "YS Chahal", "Kuldeep Yadav","B Kumar",
                          "PJ Cummins","GJ Maxwell", "A Zampa", "NM Lyon", "NM Coulter-Nile","JP Behrendorff")

#selecting playing bowlers 
bowling_data_playing_bowlers <- bowling_data[which(is.element(bowling_data$Player,playing_bowlers_list)),]
View(bowling_data_playing_bowlers)

bowling_data_playing_bowlers <- bowling_data_playing_bowlers[,c(2,4:15)]

# for highest wicket taking bowler deciding factors will be low average higher no.of 4 wicket haul and 5 wicket haul(x4 + x5) 

# best bowler as per avg
bowling_data_sort_avg <- bowling_data_playing_bowlers[order(bowling_data_playing_bowlers$Ave),]
head(bowling_data_sort_avg)
# 1. Kuldeep Yadav
# 2. Jasprit Bumrah
# 3. YS Chahal
# 4. Mohammed Shami
# 5. NM Coulter - Nile
# 6. PJ Cummins

#best bolwers consdering 4 wicket and 5 wicket haul
bowling_data_playing_bowlers$four_w_five_w <- bowling_data_playing_bowlers$X4 + bowling_data_playing_bowlers$X5
View(bowling_data_playing_bowlers)

bowling_data_sort_fourwkt_haul <- bowling_data_playing_bowlers[order(bowling_data_playing_bowlers$four_w_five_w, decreasing = TRUE),]
head(bowling_data_sort_fourwkt_haul)

# 1. Mohammed Shami
# 2. Jasprit Bumrah
# 3. Kuldeep Ydav
# 4. Bhuvaneshwar Kumar
# 5. PJ Cummins
# 6. YS Chahal

# best bowlers considering SR
bowling_data_sort_SR <- bowling_data_playing_bowlers[order(bowling_data_playing_bowlers$SR),]
head(bowling_data_sort_SR)
# 1. Kuldeep Yadav
# 2. Mohammed Shami
# 3. Jasprit Bumrah
# 4. YS Chahal
# 5. NM Coulter - Nile
# 6. PJ Cummins

# Highest wicket taking bowler - Jasprit Bumrah

#extracting data to csv to plot graphs in Tableau
write.csv(batting_data_playing_batsman,file="F:\\Upgrad\\circketChallenge\\Code\\BattingDataPlayers.csv")
write.csv(bowling_data_playing_bowlers,file="F:\\Upgrad\\circketChallenge\\Code\\BowlingDataPlayers.csv")
