## Data Set up ###
#### Preamble ####
# Purpose: Fix manual entry errors from Qualtric submissions. These were records with issues such as 
# spelling errors, typos, incorrect name order, students with alternative first names, etc. 

# Author: Jaffa Romain
# Contact: jaffa.romain@mail.utoronto.ca
library(tidyverse)
library(readr)
leadership <- read_csv("leadership.csv")
leadership <- leadership[-c(1:4), ]
leadership$name = paste(leadership$Q3_2, leadership$Q3_1, sep = " ")
## First set of fixes
leadership[leadership == "brian -"] <- "brian do"
leadership[leadership == "accidentallyenteredtoomanyteammembers woops"] <- NA
leadership[leadership == "sara"] <- "sara al-marashdeh"
leadership[leadership == "TiffanyYuChing Lam"] <- "Tiffany Lam"
leadership[leadership == "LarsStadil Trier"] <- "Lars Trier"
leadership[leadership == "LauralLee CasimiriBenben"] <- "Laurel-Lee Casimiri-Benben"
leadership[leadership == "Saad S"] <- "Saad Siddiqui"
leadership[leadership == "Saad Siddiqqi"] <- "Saad Siddiqui"
leadership[leadership == "Rachel Sw"] <- "Rachel Swampillai"
leadership[leadership == "Kia G"] <- "Kia Gharibi"
leadership[leadership == "santhiyaa jeyamohan"] <- "santhiyaa jeyamohan"
leadership[leadership == "Laisha Sebastiampillai"] <- "Laisha Sebastian"
leadership[leadership == "Laisha"] <- "Laisha Sebastian"
leadership[leadership == "Fabiha"] <- "Fabiha Chowdhury"
leadership[leadership == "anshika"] <- "Anshika Narang"
leadership[leadership == "dorin"] <- "Dorian Russell"
leadership[leadership == "Thiviya Muthucumarasamy"] <- "Thiviya Muthugumarasamy"
leadership[leadership == "Bridy Krishnarajah"] <- "Bridy Krishnaraja"
leadership[leadership == "Arifa Chowdhury"] <- "Arifa Chowdhury"
leadership[leadership == "Yang Allysha"] <- "Allysha Yung"
leadership[leadership == "Carmen"] <- "Carmen Radoescu"
leadership[leadership == "Glenys  Tanesia"] <- "Glenys Tanesia"
leadership[leadership == "Glenys"] <- "Glenys Tanesia"
leadership[leadership == "Ivan Manusev"] <- "Ivan Manasuev"
leadership[leadership == "JasmineDeborah Shum"] <- "Jasmine Shum"
leadership[leadership == "AbbasTariq Khan"] <- "Abbas Tariq Khan"
leadership[leadership == "Abbas TariqKhan"] <- "Abbas Tariq Khan"
leadership[leadership == "Abbas Khan"] <- "Abbas Tariq Khan"
leadership[leadership == "OmerIftikhar Ahmed"] <- "Omer Iftikhar  Ahmed"
leadership[leadership == "Omer Iftikhar"] <- "Omer Iftikhar  Ahmed"
leadership[leadership == "Omer Iftekhar"] <- "Omer Iftikhar  Ahmed"
leadership[leadership == "juan -"] <- "Juan Guibert"
leadership[leadership == "Rania Asaad"] <- "Rania Assaad"
leadership[leadership == "Japdeep"] <- "Japdeep Gill"
leadership[leadership == "Tomas"] <- "Tomas quattrochi"
leadership[leadership == "vir(myself) Samra"] <- "Manvir Samra"
leadership[leadership == "Dakshin Soorya"] <- "Dakshin Sooryamoorthy"
leadership[leadership == "ChristopherKwanHo(thatsme) Luey"] <- "Christopher Luey"
leadership[leadership == "ChristopherKwanHo Luey"] <- "Christopher Luey"
leadership[leadership == "christopherkwanho luey"] <- "Christopher Luey"
leadership[leadership == "KwanHo Luey"] <- "Christopher Luey"
leadership[leadership == "Renzon Reyes"] <- "Renzo Reyes"
leadership[leadership == "Yili(Tina) Jiang"] <- "yili jiang"
leadership[leadership == "Tina Jiang"] <- "Yili Jiang"
leadership[leadership == "ike udonsi"] <- "IKECHUKWU UDONSI"
leadership[leadership == "alex harold"] <- "Alexander Harold"
leadership[leadership == "an chen"] <- "Ann Chen"
leadership[leadership == "Manvir(myself) Samra"] <- "manvir samra"
leadership[leadership == "Japdeep"] <- "Japdeep Gill"
leadership[leadership == "Tomas"] <- "Tomas quattrochi"
leadership[leadership == "Lin Melania"] <- "Marina Lin"
leadership[leadership == "Calvin Vaughn"] <- "Calvin Vaughan"
leadership[leadership == "Tao(Anthony) Yin"] <- "Anthony Yin"
leadership[leadership == "Me Me"] <- "Rami Ashtar"
leadership[leadership == "Honey HS"] <- "Honey Soe"
write_csv(leadership, "test.csv")

## Second set of fixes
leadership[leadership == "Chia Teo"] <- "ChiaYin Teo"
leadership[leadership == "Myself"] <- "Ozan Coskun"
leadership[leadership == "Ozan"] <- "Ozan Coskun"
leadership[leadership == "Heather"] <- "Heather Kelsall"
leadership[leadership == "Jordan"] <- "Jordan Lee"
leadership[leadership == "ChristinaEvelynSastro Wijoyo"] <- "ChristinaE.S. Wijoyo"
leadership[leadership == "Lee Benben"] <- "Laurel-Lee Casimiri-Benben"
leadership[leadership == "Shem Gunasekeran"] <- "Shem Gunasekaran"
leadership[leadership == "WingYuGloria Lo"] <- "Gloria Lo"
leadership[leadership == "omeriftikhar ahmed"] <-  "Omer Iftikhar  Ahmed"
leadership[leadership == "Glenys"] <- "Glenys Tanesia"
leadership[leadership == "Hu JunqI"] <- "Junqi Hu"
leadership[leadership == "Samantha Wang"] <- "samantha wong"
leadership[leadership == "Qianting"] <- "Qianting Yu"
leadership[leadership == "Omar Robbat"] <- "Omar Rabbat"
leadership[leadership == "Rob Kolaja"] <- "Robert Kolaja"
leadership[leadership == "james"] <- "James Macek"
leadership[leadership == "Lebiez Piranaj"] <- "Liebiez Piranaj"
leadership[leadership == "LEBEIZ"] <- "Liebiez Piranaj"
leadership[leadership == "BARAKAT"] <- "Bakarat Omotosho"
leadership[leadership == "Tao(Anthony) Yin"] <- "Anthony Yin"
leadership[leadership == "TeoChai Yin"] <- "Chia Teo"
leadership[leadership == "ChiaYin Teo"] <-  "Chia Teo"

leadership[leadership == "Heather"] <-  "Heather Kelsall"
leadership[leadership == "Jordan"] <-  "Jordan Lee"
leadership[leadership == "Elkebir"] <-  "Elkebir Lamrani"
leadership[leadership == "ravi"] <-  "Ravi Seegobin"
leadership[leadership == "jun"] <-  "Haijun Li"
leadership[leadership == "alan"] <-  "Xinqiang He"
leadership[leadership ==  "Xinqiang(Alan) He"] <-  "Xinqiang He"
leadership[leadership == "Qianting"] <-  "Qianting Yu"
leadership[leadership == "lily ling"] <-  "Lily Lin"
leadership[leadership == "Jun Jian"] <-  "junxian jian"
leadership[leadership == "GraceYC Liu"] <-  "Grace Liu"
leadership[leadership == "Amy Shen"] <-  "YiYun Shen(Amy)"
leadership[leadership == "Nam"] <-  "Nam Duong"
leadership[leadership == "FrancesMyla Dimagiba"] <-  "Myla Damigba"
leadership[leadership == "TszChingJessie Yu"] <-  "Jessie Yu"
leadership[leadership == "Cheng Chia"] <-  "ChiaAn Cheng"
leadership[leadership == "Li YuanYuan"] <-  "YuanYuan Li"
leadership[leadership == "Candace(Dahyun) Kim"] <-  "Candace Kim"
leadership[leadership == "EvonneJoseph"] <-  "Evonne Joseph"
leadership[leadership == "Haolong Fan(Felix)"] <-  "Haolong Fan"
leadership[leadership == "Lisa"] <-  "Lisa Derzhavina"
leadership[leadership == "Lisa D"] <- "Lisa Derzhavina"
leadership[leadership == "Tony HUi"] <-  "xuechao hui"
leadership[leadership == "Tony Hui"] <-   "xuechao hui"
leadership[leadership == "Nidusha Nithi"] <-  "Nidusha Nithiananthan"
leadership[leadership == "Nidusha Nithiananathan"] <-  "Nidusha Nithiananthan"
leadership[leadership == "Marina Ravi"] <-  "Marina Raji"
leadership[leadership == "Marina R"] <-  "Marina Raji"
leadership[leadership == "MohammadShaad Multani"] <-  "Shaad Multani"
leadership[leadership == "WEI LU"] <-  "WeiDe Lu"
leadership[leadership == "Didier Ramses"] <-  "Ramazani Didier"
leadership[leadership == "Kevin Shin"] <-  "Yongseung Shin"
leadership[leadership == "Paul Jin"] <-  "Shiyang Jin"

leadership <- leadership %>% filter(!Q23_1 == "1")

write_csv(leadership, "leadership1.csv")





