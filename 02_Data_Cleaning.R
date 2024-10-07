### Data Set up ###
#### Preamble ####
# Purpose: Prepare and clean the Leadershipfull data downloaded from Qualtrics. 
# Author: Jaffa Romain
# Contact: jaffa.romain@mail.utoronto.ca
library(tidyverse)
# loading data sets 
lead <- read_csv("byRaterupdated.csv") # this is the data generated from 01_Data_Cleaning. It takes the Qualtrics data set and reformats to by rater
leadership <- read.csv("leadershipfull.csv")
SR=leadership
SR=SR %>% dplyr::rename(Ethnicity = "eth1") %>% mutate(Gender =ifelse(gender1 ==
   1, "Male", ifelse(gender1 == 2, "Female", NA))) %>%filter(!is.na(Gender)) %>% 
  mutate(`Student Status`= ifelse(is.na(`Years.in.Canada`),"Domestic", ifelse(`Years.in.Canada` < 5, "International", "Domestic")))
SR[SR == -16] <- 16 # fixing encoding error
SR <- SR %>% rename(Name="n1") %>%filter(Ethnicity == 2|
     Ethnicity == 3|Ethnicity==6|Ethnicity==5)  %>% mutate(Ethnicity = 
 case_when(Ethnicity == 2~"White/Caucasian/European-American",
           Ethnicity == 3~"Black/African-American/West Indian",
           Ethnicity==6~ "East-Asian (Chinese, Korean, Japanese)",
           Ethnicity==5~"South-East Asian (e.g., Indian, Malay, Pakistani)"))  %>% 
  distinct(Name, .keep_all = TRUE)  # keep only distinct names - removes multiple entries
SR=SR %>% select(c(Name,Q44_1,Q44_2,Q44_3,Q44_4,Q45_1,Q45_2,Q45_3,Q45_4,Q45_5,Q45_6,Q45_7))

lead <- lead  %>% mutate(Gender = 
ifelse(gender1 == 1, "Male", ifelse(gender1 == 2, "Female", NA)))

lead <- lead%>%filter(!is.na(Gender))
lead <- lead %>% mutate(`Student Status`= ifelse(is.na(`Years in Canada`),
  "Domestic", ifelse(`Years in Canada` < 5, "International", "Domestic"))) 
lead[lead == -16] <- 16 # fixing encoding error
lead=lead %>% rename(Ethnicity="eth1")
lead <- lead %>% unite("Name", Q3_1, Q3_2, sep = " ")
lead <- lead %>% filter(Ethnicity == 2|Ethnicity == 3|Ethnicity==6|Ethnicity==5) # filtering out ethnicity and keeping only white, black,, and asian students
lead <- lead %>% mutate(Ethnicity = case_when(
  Ethnicity == 2~"White/Caucasian/European-American", 
  Ethnicity == 3~"Black/African-American/West Indian",
  Ethnicity==6~ "East-Asian (Chinese, Korean, Japanese)",
  Ethnicity==5~"South-East Asian (e.g., Indian, Malay, Pakistani)")) # renaming
lead <- lead %>% distinct(Name, .keep_all = TRUE)  # keep only distinct names - removes multiple entries
lead=lead %>% dplyr::select(-c(
                               eth2,eth3,eth4,eth5,eth6,eth7,
                               id2,id3,id4,id5,id6,id7))

lead_students=leadership %>% dplyr::select(c(rater=n1,ratee1=n2,ratee2=n3,ratee3= n4,ratee4=n5,ratee5=n6))
lead_students <- lead_students %>% distinct(rater, .keep_all = TRUE)  # keep only distinct names - removes multiple entries

lead=lead %>% mutate(Name=tolower(Name))
reshaped_data <-lead_students %>%
  gather(key = "ratee_column", value = "ratee_name", -rater) %>%
  filter(!is.na(ratee_name))

# Create new dataset
new_data <- reshaped_data %>%
  group_by(ratee_name) %>%
  summarize(rater1 = nth(rater, 1),rater2 = nth(rater, 2),
            rater3 = nth(rater, 3), rater4 = nth(rater, 4),rater5 = nth(rater, 5)
  ) %>% ungroup()
new_data=new_data %>% distinct(ratee_name,.keep_all = T)

demdata1=lead %>% dplyr::select(c(rater1=Name,rater1gen=Gender,
                                  rater1eth=Ethnicity))
new_data=new_data %>% left_join(demdata1,by="rater1")
new_data=new_data %>% distinct(ratee_name,.keep_all = T)

demdata2=lead %>% dplyr::select(c(rater2=Name,rater2gen=Gender,
                                  rater2eth=Ethnicity))

new_data=new_data %>% left_join(demdata2,by="rater2")
new_data=new_data %>% distinct(ratee_name,.keep_all = T)

demdata3=lead %>% dplyr::select(c(rater3=Name,rater3gen=Gender,rater3eth=Ethnicity))
new_data=new_data %>% left_join(demdata3,by="rater3")
new_data=new_data %>% distinct(ratee_name,.keep_all = T)

demdata4=lead %>% dplyr::select(c(rater4=Name,rater4gen=Gender,rater4eth=Ethnicity))
new_data=new_data %>% left_join(demdata4,by="rater4")
new_data=new_data %>% distinct(ratee_name,.keep_all = T)

demdata5=lead %>% dplyr::select(c(rater5=Name,rater5gender=Gender,rater5eth=Ethnicity))
new_data=new_data %>% left_join(demdata5,by="rater5")
new_data=new_data %>% distinct(ratee_name,.keep_all = T)
new_data=new_data %>% rename(Name="ratee_name")
lead=lead %>% left_join(new_data,by="Name")

# average BFI questions for each team member being rated
# Question 1
lead$Q25_1_mean <- rowMeans(subset(lead, select = c(`1_Q25_rater_1_1`, 
                  `2_Q25_rater_1_1`, `3_Q25_rater_1_1`, `4_Q25_rater_1_1`,
                  `5_Q25_rater_1_1`)), na.rm = TRUE)
# Question 2
lead$Q25_2_mean <- rowMeans(subset(lead, select = c(`1_Q25_rater_1_2`, 
                  `2_Q25_rater_1_2`, `3_Q25_rater_1_2`, `4_Q25_rater_1_2`,
                  `5_Q25_rater_1_2`)), na.rm = TRUE)
# Question 3
lead$Q25_3_mean <- rowMeans(subset(lead, select = c(`1_Q25_rater_1_3`, 
                     `2_Q25_rater_1_3`, `3_Q25_rater_1_3`, `4_Q25_rater_1_3`, 
                     `5_Q25_rater_1_3`)), na.rm = TRUE)
# Question 4
lead$Q25_4_mean <- rowMeans(subset(lead, select = c(`1_Q25_rater_1_4`,
                  `2_Q25_rater_1_4`, `3_Q25_rater_1_4`, `4_Q25_rater_1_4`, 
                `5_Q25_rater_1_4`)), na.rm = TRUE)
# Question 5
lead$Q25_5_mean <- rowMeans(subset(lead, select = c(`1_Q25_rater_1_5`, 
                  `2_Q25_rater_1_5`, `3_Q25_rater_1_5`, `4_Q25_rater_1_5`, 
                  `5_Q25_rater_1_5`)), na.rm = TRUE)
# Question 6
lead$Q25_6_mean <- rowMeans(subset(lead, select = c(`1_Q25_rater_1_6`, 
      `2_Q25_rater_1_6`, `3_Q25_rater_1_6`, `4_Q25_rater_1_6`,
      `5_Q25_rater_1_6`)), na.rm = TRUE) 
# Question 7
lead$Q25_7_mean <- rowMeans(subset(lead, select = c(`1_Q25_rater_1_7`, 
        `2_Q25_rater_1_7`, `3_Q25_rater_1_7`, `4_Q25_rater_1_7`,
        `5_Q25_rater_1_7`)), na.rm = TRUE)
# Question 8
lead$Q25_8_mean <- rowMeans(subset(lead, select = c(`1_Q25_rater_1_8`, 
              `2_Q25_rater_1_8`, `3_Q25_rater_1_8`,
              `4_Q25_rater_1_8`, `5_Q25_rater_1_8`)), na.rm = TRUE)
# Question 9
lead$Q25_9_mean <- rowMeans(subset(lead, select = c(`1_Q25_rater_1_9`, 
    `2_Q25_rater_1_9`, `3_Q25_rater_1_9`, `4_Q25_rater_1_9`,
    `5_Q25_rater_1_9`)), na.rm = TRUE)
# Question 10
lead$Q25_10_mean <- rowMeans(subset(lead, select = c(`1_Q25_rater_1_10`, 
        `2_Q25_rater_1_10`, `3_Q25_rater_1_10`, `4_Q25_rater_1_10`,
        `5_Q25_rater_1_10`)), na.rm = TRUE)
lead <- lead %>% 
dplyr::rename(Q24_rater_1_1 =
  `1_Q24_rater_1_1`, Q24_rater_2_1 = `2_Q24_rater_1_1`,
  Q24_rater_3_1 = `3_Q24_rater_1_1`, Q24_rater_4_1 = `4_Q24_rater_1_1`,
    Q24_rater_5_1 = `5_Q24_rater_1_1`,  Q24_rater_1_2 = `1_Q24_rater_1_2`,
   Q24_rater_2_2 = `2_Q24_rater_1_2`,Q24_rater_3_2 = `3_Q24_rater_1_2`,
  Q24_rater_4_2 = `4_Q24_rater_1_2`, Q24_rater_5_2 = `5_Q24_rater_1_2`,
  Q24_rater_1_3 = `1_Q24_rater_1_3`, Q24_rater_2_3 = `2_Q24_rater_1_3`, 
  Q24_rater_3_3 = `3_Q24_rater_1_3`, Q24_rater_4_3 = `4_Q24_rater_1_3`,
  Q24_rater_5_3 = `5_Q24_rater_1_3`,Q24_rater_1_4 = `1_Q24_rater_1_4`, 
  Q24_rater_2_4 = `2_Q24_rater_1_4`, Q24_rater_3_4 = `3_Q24_rater_1_4`, 
  Q24_rater_4_4 = `4_Q24_rater_1_4`, Q24_rater_5_4 = `5_Q24_rater_1_4`,
  Q24_rater_1_5 = `1_Q24_rater_1_5`, Q24_rater_2_5 = `2_Q24_rater_1_5`, 
  Q24_rater_3_5 =  `3_Q24_rater_1_5`, Q24_rater_4_5 = `4_Q24_rater_1_5`, 
  Q24_rater_5_5 = `5_Q24_rater_1_5`, Q24_rater_1_6 = `1_Q24_rater_1_6`, 
  Q24_rater_2_6 = `2_Q24_rater_1_6`, Q24_rater_3_6 = `3_Q24_rater_1_6`, 
  Q24_rater_4_6  = `4_Q24_rater_1_6` , Q24_rater_5_6 = `5_Q24_rater_1_6`,
  Q24_rater_1_7 = `1_Q24_rater_1_7`, Q24_rater_2_7 = `2_Q24_rater_1_7`,
  Q24_rater_3_7 = `3_Q24_rater_1_7`, Q24_rater_4_7 = `4_Q24_rater_1_7`,
  Q24_rater_5_7  = `5_Q24_rater_1_7`, Q24_rater_1_8 = `1_Q24_rater_1_8`, 
  Q24_rater_2_8 = `2_Q24_rater_1_8`, Q24_rater_3_8 = `3_Q24_rater_1_8`, 
  Q24_rater_4_8 = `4_Q24_rater_1_8`, Q24_rater_5_8 = `5_Q24_rater_1_8`,
  Q24_rater_1_9 = `1_Q24_rater_1_9`, Q24_rater_2_9 = `2_Q24_rater_1_9`, 
  Q24_rater_3_9 = `3_Q24_rater_1_9`, Q24_rater_4_9 = `4_Q24_rater_1_9`, 
  Q24_rater_5_9 = `5_Q24_rater_1_9`, Q24_rater_1_10 = `1_Q24_rater_1_10`,
  Q24_rater_2_10 = `2_Q24_rater_1_10`, Q24_rater_3_10 = `3_Q24_rater_1_10`,
  Q24_rater_4_10 = `4_Q24_rater_1_10`, Q24_rater_5_10 = `5_Q24_rater_1_10`,
  Q24_rater_1_11 = `1_Q24_rater_1_11`, Q24_rater_2_11 = `2_Q24_rater_1_11`, 
  Q24_rater_3_11 = `3_Q24_rater_1_11`, Q24_rater_4_11 = `4_Q24_rater_1_11`,
  Q24_rater_5_11 = `5_Q24_rater_1_11`, Q24_rater_1_12 = `1_Q24_rater_1_12`, 
  Q24_rater_2_12 = `2_Q24_rater_1_12`, Q24_rater_3_12 = `3_Q24_rater_1_12`,
  Q24_rater_4_12 = `4_Q24_rater_1_12`, Q24_rater_5_12 = `5_Q24_rater_1_12`,
  Q24_rater_1_13 = `1_Q24_rater_1_13`, Q24_rater_2_13 = `2_Q24_rater_1_13`,
  Q24_rater_3_13 = `3_Q24_rater_1_13`, Q24_rater_4_13 = `4_Q24_rater_1_13`, 
  Q24_rater_5_13 = `5_Q24_rater_1_13`, Q24_rater_1_14 = `1_Q24_rater_1_14`, 
  Q24_rater_2_14 = `2_Q24_rater_1_14`, Q24_rater_3_14 = `3_Q24_rater_1_14`, 
  Q24_rater_4_14 = `4_Q24_rater_1_14`, Q24_rater_5_14 = `5_Q24_rater_1_14`,
  Q24_rater_1_15 = `1_Q24_rater_1_15`, Q24_rater_2_15 = `2_Q24_rater_1_15`,
  Q24_rater_3_15 = `3_Q24_rater_1_15`, Q24_rater_4_15 = `4_Q24_rater_1_15`,
  Q24_rater_5_15 = `5_Q24_rater_1_15`,Q24_rater_1_16 = `1_Q24_rater_1_16`,
  Q24_rater_2_16 = `2_Q24_rater_1_16`, Q24_rater_3_16 = `3_Q24_rater_1_16`, 
  Q24_rater_4_16 = `4_Q24_rater_1_16`, Q24_rater_5_16 = `5_Q24_rater_1_16`,
  Q24_rater_1_17 = `1_Q24_rater_1_17`, Q24_rater_2_17 = `2_Q24_rater_1_17`, 
  Q24_rater_3_17 = `3_Q24_rater_1_17`, Q24_rater_4_17 = `4_Q24_rater_1_17`, 
  Q24_rater_5_17 = `5_Q24_rater_1_17`, Q24_rater_1_18 = `1_Q24_rater_1_18`,
  Q24_rater_2_18 = `2_Q24_rater_1_18`, Q24_rater_3_18 = `3_Q24_rater_1_18`, 
  Q24_rater_4_18 = `4_Q24_rater_1_18`, Q24_rater_5_18 = `5_Q24_rater_1_18`,
  Q24_rater_1_19 = `1_Q24_rater_1_19`, Q24_rater_2_19 = `2_Q24_rater_1_19`,
  Q24_rater_3_19 = `3_Q24_rater_1_19`, Q24_rater_4_19 = `4_Q24_rater_1_19`,
  Q24_rater_5_19 = `5_Q24_rater_1_19`,Q24_rater_1_20 = `1_Q24_rater_1_20`,
  Q24_rater_2_20 = `2_Q24_rater_1_20`, Q24_rater_3_20 = `3_Q24_rater_1_20`, 
  Q24_rater_4_20 = `4_Q24_rater_1_20`, Q24_rater_5_20 = `5_Q24_rater_1_20`) %>% 
  mutate(team = 1:length(lead$id1))
# Questions to be recoded 
# 16, 19, 20
# team member 1 
lead$Q24_rater_1_16r = recode(lead$Q24_rater_1_16, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)
lead$Q24_rater_1_19r = recode(lead$Q24_rater_1_19, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)
lead$Q24_rater_1_20r = recode(lead$Q24_rater_1_20, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)

lead$Q24_rater_2_16r = recode(lead$Q24_rater_2_16, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)
lead$Q24_rater_2_19r = recode(lead$Q24_rater_2_19, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)
lead$Q24_rater_2_20r = recode(lead$Q24_rater_2_20, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)

lead$Q24_rater_3_16r = recode(lead$Q24_rater_3_16, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)
lead$Q24_rater_3_19r = recode(lead$Q24_rater_3_19, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)
lead$Q24_rater_3_20r = recode(lead$Q24_rater_3_20, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)

lead$Q24_rater_4_16r = recode(lead$Q24_rater_4_16, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)
lead$Q24_rater_4_19r = recode(lead$Q24_rater_4_19, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)
lead$Q24_rater_4_20r = recode(lead$Q24_rater_4_20, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)

lead$Q24_rater_5_16r = recode(lead$Q24_rater_5_16, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)
lead$Q24_rater_5_19r = recode(lead$Q24_rater_5_19, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)
lead$Q24_rater_5_20r = recode(lead$Q24_rater_5_20, `1`=5, `2`=4, `3`=3, `4`=2, `5`=1)

lead$Q24_1_mean <- rowMeans(subset(lead, select = c(Q24_rater_1_1, Q24_rater_2_1, 
Q24_rater_3_1, Q24_rater_4_1, Q24_rater_5_1)), na.rm = TRUE)
lead$Q24_2_mean <- rowMeans(subset(lead, select = c(Q24_rater_1_2, Q24_rater_2_2,
  Q24_rater_3_2, Q24_rater_4_2, Q24_rater_5_2)), na.rm = TRUE)
lead$Q24_3_mean <- rowMeans(subset(lead, select = c(Q24_rater_1_3, Q24_rater_2_3,
Q24_rater_3_3, Q24_rater_4_3, Q24_rater_5_3)), na.rm = TRUE)
lead$Q24_4_mean <- rowMeans(subset(lead, select = c(Q24_rater_1_4, Q24_rater_2_4, 
Q24_rater_3_4, Q24_rater_4_4, Q24_rater_5_4)), na.rm = TRUE)
lead$Q24_5_mean <- rowMeans(subset(lead, select = c(Q24_rater_1_5, Q24_rater_2_5,
Q24_rater_3_5, Q24_rater_4_5, Q24_rater_5_5)), na.rm = TRUE)
lead$Q24_6_mean <- rowMeans(subset(lead, select = c(Q24_rater_1_6, Q24_rater_2_6,
Q24_rater_3_6, Q24_rater_4_6, Q24_rater_5_6)), na.rm = TRUE)
lead$Q24_7_mean <- rowMeans(subset(lead, select = c(Q24_rater_1_7, Q24_rater_2_7,
Q24_rater_3_7, Q24_rater_4_7, Q24_rater_5_7)), na.rm = TRUE)
lead$Q24_8_mean <- rowMeans(subset(lead, select = c(Q24_rater_1_8, Q24_rater_2_8,
Q24_rater_3_8, Q24_rater_4_8, Q24_rater_5_8)), na.rm = TRUE)
lead$Q24_9_mean <- rowMeans(subset(lead, select = c(Q24_rater_1_9, Q24_rater_2_9,
Q24_rater_3_9, Q24_rater_4_9, Q24_rater_5_9)), na.rm = TRUE)
lead$Q24_10_mean <- rowMeans(subset(lead, select = c(Q24_rater_1_10, Q24_rater_2_10, 
Q24_rater_3_10, Q24_rater_4_10, Q24_rater_5_10)), na.rm = TRUE)

lead$Q24_11_mean <- rowMeans(subset(lead, select = c(Q24_rater_1_11, Q24_rater_2_11, 
Q24_rater_3_11, Q24_rater_4_11, Q24_rater_5_11)), na.rm = TRUE)
lead$Q24_12_mean <- rowMeans(subset(lead, select = c(Q24_rater_1_12, Q24_rater_2_12,
Q24_rater_3_12, Q24_rater_4_12, Q24_rater_5_12)), na.rm = TRUE)
lead$Q24_13_mean <- rowMeans(subset(lead, select = c(Q24_rater_1_13, Q24_rater_2_13, 
Q24_rater_3_13, Q24_rater_4_13, Q24_rater_5_13)), na.rm = TRUE)
lead$Q24_14_mean <- rowMeans(subset(lead, select = c(Q24_rater_1_14, Q24_rater_2_14, 
Q24_rater_3_14, Q24_rater_4_14, Q24_rater_5_14)), na.rm = TRUE)
lead$Q24_15_mean <- rowMeans(subset(lead, select = c(Q24_rater_1_15, Q24_rater_2_15,
Q24_rater_3_15, Q24_rater_4_15, Q24_rater_5_15)), na.rm = TRUE)
lead$Q24_16r_mean <- rowMeans(subset(lead, select = c(Q24_rater_1_16r, 
Q24_rater_2_16r, Q24_rater_3_16r, Q24_rater_4_16r, Q24_rater_5_16r)), na.rm = TRUE)
lead$Q24_17_mean <- rowMeans(subset(lead, select = c(Q24_rater_1_17, Q24_rater_2_17,
Q24_rater_3_17, Q24_rater_4_17, Q24_rater_5_17)), na.rm = TRUE)
lead$Q24_18_mean <- rowMeans(subset(lead, select = c(Q24_rater_1_8, Q24_rater_2_18,
Q24_rater_3_18, Q24_rater_4_18, Q24_rater_5_18)), na.rm = TRUE)
lead$Q24_19r_mean <- rowMeans(subset(lead, select = c(Q24_rater_1_19r, Q24_rater_2_19r,
Q24_rater_3_19r, Q24_rater_4_19r, Q24_rater_5_19r)), na.rm = TRUE)
lead$Q24_20r_mean <- rowMeans(subset(lead, select = c(Q24_rater_1_20r, 
Q24_rater_2_20r, Q24_rater_3_20r, Q24_rater_4_20r, Q24_rater_5_20r)), na.rm = TRUE)

# getting average scores for LBDQ scores (initiating structure and consideration)
lead$initiating_structure <- rowMeans(subset(lead, select = c(Q24_1_mean, Q24_2_mean, 
Q24_3_mean, Q24_4_mean, Q24_5_mean, Q24_6_mean, Q24_7_mean, Q24_8_mean, 
Q24_9_mean, Q24_10_mean), na.rm=T))
lead$consideration <- rowMeans(subset(lead, select = c(Q24_11_mean, Q24_12_mean, 
Q24_13_mean, Q24_14_mean, Q24_15_mean, Q24_16r_mean, Q24_17_mean, Q24_18_mean,
Q24_19r_mean, Q24_20r_mean), na.rm=T))

lead_long <- lead %>% pivot_longer(c(Q25_1_mean, Q25_2_mean, Q25_3_mean, Q25_4_mean, 
Q25_5_mean, Q25_6_mean, Q25_7_mean, Q25_8_mean, Q25_9_mean, Q25_10_mean), 
names_to = "Question", values_to = "Average Score") %>% 
mutate(Question = case_when(Question == "Q25_1_mean" ~ "Question 1",
Question == "Q25_2_mean" ~ "Question 2",  Question == "Q25_3_mean" ~ "Question 3" ,
Question == "Q25_4_mean" ~ "Question 4",  Question == "Q25_5_mean" ~ "Question 5",
Question == "Q25_6_mean" ~ "Question 6", Question == "Q25_7_mean" ~ "Question 7",
Question == "Q25_8_mean" ~ "Question 8",Question == "Q25_9_mean" ~ "Question 9",
Question == "Q25_10_mean" ~ "Question 10"))

lead <- lead %>% dplyr::rename(Q25_rater_1_1 = `1_Q25_rater_1_1`, 
Q25_rater_2_1 = `2_Q25_rater_1_1`, Q25_rater_3_1 = `3_Q25_rater_1_1`, 
Q25_rater_4_1 = `4_Q25_rater_1_1`, Q25_rater_5_1 = `5_Q25_rater_1_1`, 
 Q25_rater_1_2 = `1_Q25_rater_1_2`, Q25_rater_2_2 = `2_Q25_rater_1_2`, 
Q25_rater_3_2 = `3_Q25_rater_1_2`, Q25_rater_4_2 = `4_Q25_rater_1_2`, 
Q25_rater_5_2 = `5_Q25_rater_1_2`,Q25_rater_1_3 = `1_Q25_rater_1_3`, 
Q25_rater_2_3 = `2_Q25_rater_1_3`, Q25_rater_3_3 = `3_Q25_rater_1_3`,
Q25_rater_4_3 = `4_Q25_rater_1_3`, Q25_rater_5_3 = `5_Q25_rater_1_3`, 
 Q25_rater_1_4 = `1_Q25_rater_1_4`, Q25_rater_2_4 = `2_Q25_rater_1_4`, 
Q25_rater_3_4 = `3_Q25_rater_1_4`, Q25_rater_4_4 = `4_Q25_rater_1_4`, 
Q25_rater_5_4 = `5_Q25_rater_1_4`,Q25_rater_1_5 = `1_Q25_rater_1_5`, 
Q25_rater_2_5 = `2_Q25_rater_1_5`, Q25_rater_3_5 =  `3_Q25_rater_1_5`, 
Q25_rater_4_5 = `4_Q25_rater_1_5`, Q25_rater_5_5 = `5_Q25_rater_1_5`,
Q25_rater_1_6 = `1_Q25_rater_1_6`, Q25_rater_2_6 = `2_Q25_rater_1_6`,
Q25_rater_3_6 = `3_Q25_rater_1_6`, Q25_rater_4_6  = `4_Q25_rater_1_6`,
Q25_rater_5_6 = `5_Q25_rater_1_6`, Q25_rater_1_7 = `1_Q25_rater_1_7`, 
Q25_rater_2_7 = `2_Q25_rater_1_7`, Q25_rater_3_7 = `3_Q25_rater_1_7`,
Q25_rater_4_7 = `4_Q25_rater_1_7`, Q25_rater_5_7  = `5_Q25_rater_1_7`,
Q25_rater_1_8 = `1_Q25_rater_1_8`, Q25_rater_2_8 = `2_Q25_rater_1_8`, 
Q25_rater_3_8 = `3_Q25_rater_1_8`, Q25_rater_4_8 = `4_Q25_rater_1_8`, 
Q25_rater_5_8 = `5_Q25_rater_1_8`, Q25_rater_1_9 = `1_Q25_rater_1_9`,
Q25_rater_2_9 = `2_Q25_rater_1_9`, Q25_rater_3_9 = `3_Q25_rater_1_9`,
Q25_rater_4_9 = `4_Q25_rater_1_9`, Q25_rater_5_9 = `5_Q25_rater_1_9`, 
Q25_rater_1_10 = `1_Q25_rater_1_10`, Q25_rater_2_10 = `2_Q25_rater_1_10`, 
Q25_rater_3_10 = `3_Q25_rater_1_10`, Q25_rater_4_10 = `4_Q25_rater_1_10`, 
Q25_rater_5_10 = `5_Q25_rater_1_10`) %>% mutate(team = 1:length(lead$id1))

################## Pivot questionnaire questions
questionnaires <- lead
# Make sure you have tidyverse installed and loaded
install.packages("tidyverse")
library(tidyverse)

library(tidyverse)

data_long <-lead %>%
  pivot_longer(cols = Q24_rater_1_1:Q25_rater_5_10, names_to = "variable", values_to = "rating") %>%
  separate(variable, into = c("survey", ".", "rater","question_number"), 
           sep = "_", remove = TRUE)%>%mutate(rater=paste("rater",rater,sep="")) %>% filter(survey=="Q24"|survey=="Q25") %>% 
  mutate(rater_gender = ifelse(rater == "rater1", rater1gen,
                               ifelse(rater == "rater2", rater2gen,
                                      ifelse(rater == "rater3", rater3gen,
                                      ifelse(rater == "rater4", rater4gen,
                                             ifelse(rater == "rater5", rater5gender,NA 
                                                    )))))) %>%
           mutate(rater_ethnicity = ifelse(rater == "rater1", rater1eth,
                                           ifelse(rater == "rater2", rater2eth,
                                                  ifelse(rater == "rater3", rater2eth,
                                                         ifelse(rater == "rater4", rater2eth,
                                                                ifelse(rater == "rater5", rater2eth,NA
                                           ))))))%>%
dplyr::select(-c(`...1` ,id1,Q3_3,  Q3_4 ,Q3_6 , Q8   ,gender1,age, Q19_5,gender2,gender7,`6_Q24_rater_1_1`,
         `6_Q24_rater_1_2`,`6_Q24_rater_1_3`,`6_Q24_rater_1_4`,`6_Q24_rater_1_5`
         ,`6_Q24_rater_1_6`,`6_Q24_rater_1_7`, `6_Q24_rater_1_8`,`6_Q24_rater_1_9`, 
         `6_Q24_rater_1_10`,`6_Q24_rater_1_11`,`6_Q24_rater_1_12`,`6_Q24_rater_1_13`,      
`6_Q24_rater_1_14`,`6_Q24_rater_1_15`,`6_Q24_rater_1_1`,`6_Q24_rater_1_17`,      
`6_Q24_rater_1_18`,`6_Q24_rater_1_19`,`6_Q24_rater_1_20`,`6_Q25_rater_1_1` ,
`6_Q25_rater_1_2`,`6_Q25_rater_1_3`,`6_Q25_rater_1_4`,`6_Q25_rater_1_5` ,
`6_Q25_rater_1_6`,`6_Q25_rater_1_7`,`6_Q25_rater_1_8`,`6_Q25_rater_1_9` ,
`6_Q25_rater_1_10` ,rater1,rater2,rater3,rater4,rater5,rater1gen,rater1eth
,rater2gen ,rater2eth ,rater3gen,rater3eth,rater4gen ,rater4eth,rater5gender,
rater5eth,Q24_rater_1_16r ,Q24_rater_1_19r ,Q24_rater_1_20r,
 Q24_rater_2_16r ,Q24_rater_2_19r ,Q24_rater_2_20r ,Q24_rater_3_16r, Q24_rater_3_19r ,
Q24_rater_3_20r ,Q24_rater_4_16r ,Q24_rater_4_19r,Q24_rater_4_20r ,Q24_rater_5_16r ,
Q24_rater_5_19r ,Q24_rater_5_20r)) # remove the redundant columns
                  

saveRDS(data_long, file = "lead_longest.rds")
saveRDS(lead, file = "lead.rds")
saveRDS(lead_long, file = "lead_long.rds")
saveRDS(SR,file="self_leadership_ratings.rds")
