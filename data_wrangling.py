# ---
# jupyter:
#   jupytext:
#     text_representation:
#       extension: .py
#       format_name: light
#       format_version: '1.5'
#       jupytext_version: 1.16.1
#   kernelspec:
#     display_name: Python 3
#     language: python
#     name: python3
# ---

import numpy as np
import pandas as pd

leadership =  pd.read_csv("data - winter 2023/leadership.csv")

for i in leadership.columns:
    print("'" + i + "',")

cols = ["Q3_1", "Q3_2", "Name",
        "Ethnicity","Gender"]

raters = leadership[cols]

raters.loc[:,"names"] = raters["Q3_1"].str.strip().str.lower() + " " + raters["Q3_2"].str.strip().str.lower()

raters.tail(20)

raters = raters.drop_duplicates(subset="names")

ratee1_cols = [ 'Q23_1', 'Q23_2',
'Q24_1_1', 'Q24_1_2',
'Q24_1_3', 'Q24_1_4',
'Q24_1_5', 'Q24_1_6',
'Q24_1_7', 'Q24_1_8',
'Q24_1_9', 'Q24_1_10',
'Q24_1_11', 'Q24_1_12',
'Q24_1_13', 'Q24_1_14',
'Q24_1_15', 'Q24_1_16',
'Q24_1_17', 'Q24_1_18',
'Q24_1_19', 'Q24_1_20'
]

ratee1 = leadership[ratee1_cols]
ratee1.shape

ratee1.loc[:,"names"] = ratee1["Q23_2"].str.strip().str.lower() + " " + ratee1["Q23_1"].str.strip().str.lower()

ratee1.head()

ratee2_cols = [
'Q26_1', 'Q26_2',
'Q24_2_1', 'Q24_2_2',
'Q24_2_3', 'Q24_2_4',
'Q24_2_5', 'Q24_2_6',
'Q24_2_7', 'Q24_2_8',
'Q24_2_9', 'Q24_2_10',
'Q24_2_11', 'Q24_2_12',
'Q24_2_13', 'Q24_2_14',
'Q24_2_15', 'Q24_2_16',
'Q24_2_17', 'Q24_2_18',
'Q24_2_19', 'Q24_2_20'
]

ratee2 = leadership[ratee2_cols]
ratee2 = ratee2[~ratee2.isnull().all(1)]
ratee2.loc[:,"names"] = ratee2["Q26_2"].str.strip().str.lower() + " " + ratee2["Q26_1"].str.strip().str.lower()
ratee2.head(7)

ratee3_cols = [
'Q30_1', 'Q30_2',
'Q24_3_1', 'Q24_3_2',
'Q24_3_3', 'Q24_3_4',
'Q24_3_5', 'Q24_3_6',
'Q24_3_7', 'Q24_3_8',
'Q24_3_9', 'Q24_3_10',
'Q24_3_11', 'Q24_3_12',
'Q24_3_13', 'Q24_3_14',
'Q24_3_15', 'Q24_3_16',
'Q24_3_17', 'Q24_3_18',
'Q24_3_19', 'Q24_3_20']

ratee3 = leadership[ratee3_cols]
ratee3 = ratee3[~ratee3.isnull().all(1)]
ratee3.loc[:,"names"] = ratee3["Q30_2"].str.strip().str.lower() + " " + ratee3["Q30_1"].str.strip().str.lower()
ratee3.head(7)

ratee4_cols = [
'Q33_1', 'Q33_2', 
'Q24_4_1', 'Q24_4_2',
'Q24_4_3', 'Q24_4_4',
'Q24_4_5', 'Q24_4_6',
'Q24_4_7', 'Q24_4_8',
'Q24_4_9', 'Q24_4_10',
'Q24_4_11', 'Q24_4_12',
'Q24_4_13', 'Q24_4_14',
'Q24_4_15', 'Q24_4_16',
'Q24_4_17', 'Q24_4_18',
'Q24_4_19', 'Q24_4_20']

ratee4 = leadership[ratee4_cols]
ratee4 = ratee4[~ratee4.isnull().all(1)]
ratee4.loc[:,"names"] = ratee4["Q33_2"].str.strip().str.lower() + " " + ratee4["Q33_1"].str.strip().str.lower()
ratee4.head(7)

ratee5_cols = [
'Q36_1', 'Q36_2',
'Q24_5_1', 'Q24_5_2',
'Q24_5_3', 'Q24_5_4',
'Q24_5_5', 'Q24_5_6',
'Q24_5_7', 'Q24_5_8',
'Q24_5_9', 'Q24_5_10',
'Q24_5_11', 'Q24_5_12',
'Q24_5_13', 'Q24_5_14',
'Q24_5_15', 'Q24_5_16',
'Q24_5_17', 'Q24_5_18',
'Q24_5_19', 'Q24_5_20'
]

ratee5 = leadership[ratee5_cols]
ratee5 = ratee5[~ratee5.isnull().all(1)]
ratee5.loc[:,"names"] = ratee5["Q36_2"].str.strip().str.lower() + " " + ratee5["Q36_1"].str.strip().str.lower()
ratee5.head(7)

frames = [ratee1,ratee2, ratee3, ratee4, ratee5]

for i in frames[1:]:
    i.columns = ratee1.columns

ratees = pd.concat(frames)

ratees['rating_number'] = ratees.groupby(['names']).cumcount()+1
ratees = ratees[~ratees["Q23_1"].isna() & ~ratees["Q23_2"].isna()]
ratees = ratees[ratees["rating_number"]<7]

test = raters.merge(ratees[ratees["rating_number"]==1], how="left", on="names")

test2 = test.merge(ratees[ratees["rating_number"]==2], how="left", on="names")

test3 = test2.merge(ratees[ratees["rating_number"]==3], how="left", on="names")
  suffixes = (f"_raters", f"_ratee_{5}")

test4 = test3.merge(ratees[ratees["rating_number"]==4], how="left", on="names",suffixes=suffixes)

final = raters
for i in range(3):
  suffixes = (f"_raters", f"_ratee_{i + 1}")
  final = final.merge(ratees[ratees["rating_number"] == i + 1], how="left", on="names", suffixes=suffixes)
    # final = final.merge(ratees[ratees["rating_number"]==i+1], how="left", on="names")


j = 0
for i in final.columns:
    j+=1
print(j)
# 
# final = final.drop(columns=['Q48', 'Q46_1', 'Q46_2','names', 'Q23_1_x', 
#                     'Q23_2_x', 'Q23_3_x', 'rating_number_x', 'Q23_1_y', 'Q23_2_y', 'Q23_3_y', 'rating_number_y'])

# +
final_cols = ['id1', 'Q3_1', 'Q3_2', 'Q3_3', 'Q3_4', 'Q3_6', 'semester', 'eth1', 'Q8', 'gender1', 'age', 
'english_primary_language', 'birthcountry', 'canadian_born', 'Years in Canada', 'Year Came to Canada', 'Q19_5',  
'1_Q24_1_1', 
'1_Q24_1_2', 
'1_Q24_1_3', 
'1_Q24_1_4', 
'1_Q24_1_5', 
'1_Q24_1_6', 
'1_Q24_1_7', 
'1_Q24_1_8', 
'1_Q24_1_9', 
'1_Q24_1_10', 
'1_Q24_1_11', 
'1_Q24_1_12', 
'1_Q24_1_13', 
'1_Q24_1_14', 
'1_Q24_1_15', 
'1_Q24_1_16', 
'1_Q24_1_17', 
'1_Q24_1_18', 
'1_Q24_1_19', 
'1_Q24_1_20', 
'1_Q25_1_1', 
'1_Q25_1_2', 
'1_Q25_1_3', 
'1_Q25_1_4', 
'1_Q25_1_5', 
'1_Q25_1_6', 
'1_Q25_1_7', 
'1_Q25_1_8', 
'1_Q25_1_9', 
'1_Q25_1_10', 
              
'2_Q24_1_1', 
'2_Q24_1_2', 
'2_Q24_1_3', 
'2_Q24_1_4', 
'2_Q24_1_5', 
'2_Q24_1_6', 
'2_Q24_1_7', 
'2_Q24_1_8', 
'2_Q24_1_9', 
'2_Q24_1_10', 
'2_Q24_1_11', 
'2_Q24_1_12', 
'2_Q24_1_13', 
'2_Q24_1_14', 
'2_Q24_1_15', 
'2_Q24_1_16', 
'2_Q24_1_17', 
'2_Q24_1_18', 
'2_Q24_1_19', 
'2_Q24_1_20', 
'2_Q25_1_1', 
'2_Q25_1_2', 
'2_Q25_1_3', 
'2_Q25_1_4', 
'2_Q25_1_5', 
'2_Q25_1_6', 
'2_Q25_1_7', 
'2_Q25_1_8', 
'2_Q25_1_9', 
'2_Q25_1_10', 

'3_Q24_1_1', 
'3_Q24_1_2', 
'3_Q24_1_3', 
'3_Q24_1_4', 
'3_Q24_1_5', 
'3_Q24_1_6', 
'3_Q24_1_7', 
'3_Q24_1_8', 
'3_Q24_1_9', 
'3_Q24_1_10', 
'3_Q24_1_11', 
'3_Q24_1_12', 
'3_Q24_1_13', 
'3_Q24_1_14', 
'3_Q24_1_15', 
'3_Q24_1_16', 
'3_Q24_1_17', 
'3_Q24_1_18', 
'3_Q24_1_19', 
'3_Q24_1_20', 
'3_Q25_1_1', 
'3_Q25_1_2', 
'3_Q25_1_3', 
'3_Q25_1_4', 
'3_Q25_1_5', 
'3_Q25_1_6', 
'3_Q25_1_7', 
'3_Q25_1_8', 
'3_Q25_1_9', 
'3_Q25_1_10', 
 
'4_Q24_1_1', 
'4_Q24_1_2', 
'4_Q24_1_3', 
'4_Q24_1_4', 
'4_Q24_1_5', 
'4_Q24_1_6', 
'4_Q24_1_7', 
'4_Q24_1_8', 
'4_Q24_1_9', 
'4_Q24_1_10', 
'4_Q24_1_11', 
'4_Q24_1_12', 
'4_Q24_1_13', 
'4_Q24_1_14', 
'4_Q24_1_15', 
'4_Q24_1_16', 
'4_Q24_1_17', 
'4_Q24_1_18', 
'4_Q24_1_19', 
'4_Q24_1_20', 
'4_Q25_1_1', 
'4_Q25_1_2', 
'4_Q25_1_3', 
'4_Q25_1_4', 
'4_Q25_1_5', 
'4_Q25_1_6', 
'4_Q25_1_7', 
'4_Q25_1_8', 
'4_Q25_1_9', 
'4_Q25_1_10', 

'5_Q24_1_1', 
'5_Q24_1_2', 
'5_Q24_1_3', 
'5_Q24_1_4', 
'5_Q24_1_5', 
'5_Q24_1_6', 
'5_Q24_1_7', 
'5_Q24_1_8', 
'5_Q24_1_9', 
'5_Q24_1_10', 
'5_Q24_1_11', 
'5_Q24_1_12', 
'5_Q24_1_13', 
'5_Q24_1_14', 
'5_Q24_1_15', 
'5_Q24_1_16', 
'5_Q24_1_17', 
'5_Q24_1_18', 
'5_Q24_1_19', 
'5_Q24_1_20', 
'5_Q25_1_1', 
'5_Q25_1_2', 
'5_Q25_1_3', 
'5_Q25_1_4', 
'5_Q25_1_5', 
'5_Q25_1_6', 
'5_Q25_1_7', 
'5_Q25_1_8', 
'5_Q25_1_9', 
'5_Q25_1_10', 

'6_Q24_1_1', 
'6_Q24_1_2', 
'6_Q24_1_3', 
'6_Q24_1_4', 
'6_Q24_1_5', 
'6_Q24_1_6', 
'6_Q24_1_7', 
'6_Q24_1_8', 
'6_Q24_1_9', 
'6_Q24_1_10', 
'6_Q24_1_11', 
'6_Q24_1_12', 
'6_Q24_1_13', 
'6_Q24_1_14', 
'6_Q24_1_15', 
'6_Q24_1_16', 
'6_Q24_1_17', 
'6_Q24_1_18', 
'6_Q24_1_19', 
'6_Q24_1_20', 
'6_Q25_1_1', 
'6_Q25_1_2', 
'6_Q25_1_3', 
'6_Q25_1_4', 
'6_Q25_1_5', 
'6_Q25_1_6', 
'6_Q25_1_7', 
'6_Q25_1_8', 
'6_Q25_1_9', 
'6_Q25_1_10']
# -

len(final_cols)

# final.columns = final_cols

final.to_csv(r'byRater2023.csv')


