### Data Set up ###
#### Preamble ####
# Purpose: Prepare and clean the Leadershipfull data downloaded from Qualtrics. 
# Author: Jaffa Romain
# Contact: jaffa.romain@mail.utoronto.ca
library(tidyverse)
# loading data sets 
lead <- read_csv("byRater2024.csv") # this is the data generated from 01_Data_Cleaning. It takes the Qualtrics data set and reformats to by rater

lead <- lead  %>% mutate(Gender2 = 
ifelse(Gender == 1, "Male", ifelse(Gender == 2, "Female", NA)))

lead[lead == -16] <- 16 # fixing encoding error
lead <- lead %>% unite("Name", Q3_1, Q3_2, sep = " ")
lead <- lead %>% select(-c(name, names))
lead <- lead %>% unite("ratee1", Q23_1_1, Q23_2_1 , sep = " ")
lead <- lead %>% unite("ratee2", Q23_1_2 ,Q23_2_2, sep = " ")
lead <- lead %>% unite("ratee3",Q23_1_3 ,Q23_2_3, sep = " ")
lead <- lead %>% unite("ratee4",Q23_1_4 ,Q23_2_4, sep = " ")
lead <- lead %>% unite("ratee5", Q23_1_5 ,Q23_2_5, sep = " ")
lead <- lead %>% distinct(Name, .keep_all = TRUE)  # keep only distinct names - removes multiple entries

lead=lead %>% mutate(Name=tolower(Name))
reshaped_data <-lead %>%
  gather(key = "ratee_column", value = "ratee_name", -Name) %>%
  filter(!is.na(ratee_name))
# average BFI questions for each team member being rated
# Question 1
lead$Q25_1_mean <- rowMeans(subset(lead, select = c(Q25_1_1, 
                  Q25_1_2, Q25_1_3, Q25_1_4,
                  Q25_1_5)), na.rm = TRUE)
# Question 2
lead$Q25_2_mean <- rowMeans(subset(lead, select = c(Q25_2_1, 
                  Q25_2_2, Q25_2_3,Q25_2_4,
                  Q25_2_5)), na.rm = TRUE)
# Question 3
lead$Q25_3_mean <- rowMeans(subset(lead, select = c(Q25_3_1, 
                                                    Q25_3_2, Q25_3_3,Q25_3_4,
                                                    Q25_3_5)), na.rm = TRUE)
# Question 4
lead$Q25_4_mean <- rowMeans(subset(lead, select = c(Q25_4_1, 
                                                    Q25_4_2, Q25_4_3,Q25_4_4,
                                                    Q25_4_5)), na.rm = TRUE)
# Question 5
lead$Q25_5_mean <- rowMeans(subset(lead, select = c(Q25_5_1, 
                                                    Q25_5_2, Q25_5_3,Q25_5_4,
                                                    Q25_5_5)), na.rm = TRUE)
# Question 6
lead$Q25_6_mean <- rowMeans(subset(lead, select = c(Q25_6_1, 
                                                    Q25_6_2, Q25_6_3,Q25_6_4,
                                                    Q25_6_5)), na.rm = TRUE) 
# Question 7
lead$Q25_7_mean <- rowMeans(subset(lead, select = c(Q25_7_1, 
                                                    Q25_7_2, Q25_7_3,Q25_7_4,
                                                    Q25_7_5)), na.rm = TRUE)
# Question 8
lead$Q25_8_mean <- rowMeans(subset(lead, select = c(Q25_8_1, 
                                                    Q25_8_2, Q25_8_3,Q25_8_4,
                                                    Q25_8_5)), na.rm = TRUE)
# Question 9
lead$Q25_9_mean <- rowMeans(subset(lead, select = c(Q25_9_1, 
                                                     Q25_9_2, Q25_9_3,Q25_9_4,
                                                     Q25_9_5)), na.rm = TRUE)
# Question 10
lead$Q25_10_mean <- rowMeans(subset(lead, select = c(Q25_10_1, 
                                                      Q25_10_2, Q25_3_3,Q25_3_4,
                                                      Q25_10_5)), na.rm = TRUE)
lead <- lead %>% 
  mutate(team = 1:length(lead$Name))
# Questions to be recoded 
# 16, 19, 20
lead$Q24_16r_1 = recode(lead$Q24_16_1, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)
lead$Q24_19r_1 = recode(lead$Q24_19_1, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)
lead$Q24_20r_1 = recode(lead$Q24_20_1, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)

lead$Q24_16r_2 = recode(lead$Q24_16_2, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)
lead$Q24_19r_2= recode(lead$Q24_19_2, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)
lead$Q24_20r_2 = recode(lead$Q24_20_3, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)

lead$Q24_16r_3 = recode(lead$Q24_16_3, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)
lead$Q24_19r_3 = recode(lead$Q24_19_3, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)
lead$Q24_20r_3 = recode(lead$Q24_20_3, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)

lead$Q24_16r_4 = recode(lead$Q24_16_4, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)
lead$Q24_19r_4 = recode(lead$Q24_19_4, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)
lead$Q24_20r_4 = recode(lead$Q24_20_4, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)

lead$Q24_16r_5 = recode(lead$Q24_16_5, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)
lead$Q24_19r_5 = recode(lead$Q24_19_5, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)
lead$Q24_20r_5 = recode(lead$Q24_20_5, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)

lead$Q24_1_mean <- rowMeans(subset(lead, select = c(Q24_1_1, Q24_1_2, 
Q24_1_3, Q24_1_4, Q24_1_5)), na.rm = TRUE)
lead$Q24_2_mean <- rowMeans(subset(lead, select = c(Q24_2_1, Q24_2_2,
  Q24_2_3, Q24_2_4, Q24_2_5)), na.rm = TRUE)
lead$Q24_3_mean <- rowMeans(subset(lead, select = c(Q24_3_1, Q24_3_2,
Q24_3_3, Q24_3_4, Q24_3_5)), na.rm = TRUE)
lead$Q24_4_mean <- rowMeans(subset(lead, select = c(Q24_4_1, Q24_4_2, 
Q24_4_3, Q24_4_4, Q24_4_5)), na.rm = TRUE)
lead$Q24_5_mean <- rowMeans(subset(lead, select = c(Q24_5_1, Q24_5_2,
Q24_5_3, Q24_5_4, Q24_5_5)), na.rm = TRUE)
lead$Q24_6_mean <- rowMeans(subset(lead, select = c(Q24_6_1, Q24_6_2,
Q24_6_3, Q24_6_4, Q24_6_5)), na.rm = TRUE)
lead$Q24_7_mean <- rowMeans(subset(lead, select = c(Q24_7_1, Q24_7_2,
Q24_7_3, Q24_7_4, Q24_7_5)), na.rm = TRUE)
lead$Q24_8_mean <- rowMeans(subset(lead, select = c(Q24_8_1, Q24_8_2,
Q24_8_3, Q24_8_4, Q24_8_5)), na.rm = TRUE)
lead$Q24_9_mean <- rowMeans(subset(lead, select = c(Q24_9_1, Q24_9_2,
Q24_9_3, Q24_9_4, Q24_9_5)), na.rm = TRUE)
lead$Q24_10_mean <- rowMeans(subset(lead, select = c(Q24_10_1 ,Q24_10_2, 
Q24_10_3, Q24_10_4, Q24_10_5)), na.rm = TRUE)

lead$Q24_11_mean <- rowMeans(subset(lead, select = c(Q24_11_1, Q24_11_2, 
Q24_11_3, Q24_11_4, Q24_11_5)), na.rm = TRUE)
lead$Q24_12_mean <- rowMeans(subset(lead, select = c(Q24_12_1, Q24_12_2,
Q24_12_3, Q24_12_4, Q24_12_5)), na.rm = TRUE)
lead$Q24_13_mean <- rowMeans(subset(lead, select = c(Q24_13_1, Q24_13_2, 
Q24_13_3, Q24_13_4, Q24_13_5)), na.rm = TRUE)
lead$Q24_14_mean <- rowMeans(subset(lead, select = c(Q24_14_1, Q24_14_2, 
Q24_14_3, Q24_14_4, Q24_14_5)), na.rm = TRUE)
lead$Q24_15_mean <- rowMeans(subset(lead, select = c(Q24_15_1, Q24_15_2,
Q24_15_3, Q24_15_4, Q24_15_5)), na.rm = TRUE)
lead$Q24_16r_mean <- rowMeans(subset(lead, select = c(Q24_16r_1, Q24_16r_2,
Q24_16r_3, Q24_16r_4, Q24_16r_5)), na.rm = TRUE)
lead$Q24_17_mean <- rowMeans(subset(lead, select = c(Q24_17_1, Q24_17_2,
Q24_17_3, Q24_17_4, Q24_17_5)), na.rm = TRUE)
lead$Q24_18_mean <- rowMeans(subset(lead, select = c(Q24_8_1, Q24_18_2,
Q24_18_3, Q24_18_4, Q24_18_5)), na.rm = TRUE)
lead$Q24_19r_mean <- rowMeans(subset(lead, select = c(Q24_19r_1, Q24_19r_2,
Q24_19r_3, Q24_19r_4, Q24_19r_5)), na.rm = TRUE)
lead$Q24_20r_mean <- rowMeans(subset(lead, select = c(Q24_20r_1, 
Q24_20r_2, Q24_20r_3, Q24_20r_4, Q24_20r_5)), na.rm = TRUE)

# getting average scores for LBDQ scores (initiating structure and consideration)
lead$initiating_structure <- rowMeans(subset(lead, select = c(Q24_1_mean, Q24_2_mean, 
Q24_3_mean, Q24_4_mean, Q24_5_mean, Q24_6_mean, Q24_7_mean, Q24_8_mean, 
Q24_9_mean, Q24_10_mean)))
lead$consideration <- rowMeans(subset(lead, select = c(Q24_11_mean, Q24_12_mean, 
Q24_13_mean, Q24_14_mean, Q24_15_mean, Q24_16r_mean, Q24_17_mean, Q24_18_mean,
Q24_19r_mean, Q24_20r_mean)))

# lead_long <- lead %>% pivot_longer(c(Q25_1_mean, Q25_2_mean, Q25_3_mean, Q25_4_mean, 
# Q25_5_mean, Q25_6_mean, Q25_7_mean, Q25_8_mean, Q25_9_mean, Q25_10_mean), 
# names_to = "Question", values_to = "Average Score") %>% 
# mutate(Question = case_when(Question == "Q25_1_mean" ~ "Question 1",
# Question == "Q25_2_mean" ~ "Question 2",  Question == "Q25_3_mean" ~ "Question 3" ,
# Question == "Q25_4_mean" ~ "Question 4",  Question == "Q25_5_mean" ~ "Question 5",
# Question == "Q25_6_mean" ~ "Question 6", Question == "Q25_7_mean" ~ "Question 7",
# Question == "Q25_8_mean" ~ "Question 8",Question == "Q25_9_mean" ~ "Question 9",
# Question == "Q25_10_mean" ~ "Question 10"))
