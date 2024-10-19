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

leadership =  pd.read_csv("leadership1.csv",dtype='unicode')

for i in leadership.columns:
    print("'" + i + "',")

cols = ["Q3_1", "Q3_2", "name",
        "Ethnicity","Gender"]

raters = leadership[cols]

raters.loc[:,"names"] = raters["Q3_1"].str.strip().str.lower() + " " + raters["Q3_2"].str.strip().str.lower()

raters.tail(20)

raters = raters.drop_duplicates(subset="names")

ratee1_cols = ['Q23_1', 'Q23_2', 'Q24_1_1','Q24_1_2',	'Q24_1_3',	'Q24_1_4',	'Q24_1_5',
               'Q24_1_6','Q24_1_7', 'Q24_1_8',	'Q24_1_9',	'Q24_1_10',	
               'Q24_1_11','Q24_1_12','Q24_1_13','Q24_1_14',	'Q24_1_15',
               'Q24_1_16','Q24_1_17',	'Q24_1_18',	'Q24_1_19',	'Q24_1_20',	
                'Q25_1',	'Q25_2', 'Q25_3', 'Q25_4'	, 'Q25_5'	,'Q25_6',	'Q25_7',
                'Q25_8',	'Q25_9' ,'Q25_10']

ratee1 = leadership[ratee1_cols]

ratee1.loc[:,"names"] = ratee1["Q23_2"].str.strip().str.lower() + " " + ratee1["Q23_1"].str.strip().str.lower()
ratee1.shape

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
'Q24_2_19', 'Q24_2_20','Q29_1','Q29_2','Q29_3','Q29_4','Q29_5',
'Q29_6','Q29_7','Q29_8','Q29_9','Q29_10']

ratee2 = leadership[ratee2_cols]
ratee2.shape
ratee2 = ratee2[~ratee2.isnull().all(1)]
ratee2.loc[:,"names"] = ratee2["Q26_2"].str.strip().str.lower() + " " + ratee2["Q26_1"].str.strip().str.lower()

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
'Q24_3_19', 'Q24_3_20',

'Q32_1','Q32_2','Q32_3'	,'Q32_4',	'Q32_5',
'Q32_6',	'Q32_7',	'Q32_8',	'Q32_9',	'Q32_10'
]

ratee3 = leadership[ratee3_cols]
ratee3 = ratee3[~ratee3.isnull().all(1)]
ratee3.loc[:,"names"] = ratee3["Q30_2"].str.strip().str.lower() + " " + ratee3["Q30_1"].str.strip().str.lower()
ratee3.shape

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
'Q24_4_19', 'Q24_4_20',
'Q35_1','Q35_2','Q35_3'	,'Q35_4',	'Q35_5',
'Q35_6',	'Q35_7',	'Q35_8',	'Q35_9',	'Q35_10']

ratee4 = leadership[ratee4_cols]
ratee4 = ratee4[~ratee4.isnull().all(1)]
ratee4.loc[:,"names"] = ratee4["Q33_2"].str.strip().str.lower() + " " + ratee4["Q33_1"].str.strip().str.lower()
ratee4.shape

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
'Q24_5_19', 'Q24_5_20',

'Q38_1','Q38_2','Q38_3'	,'Q38_4',	'Q38_5',
'Q38_6',	'Q38_7',	'Q38_8',	'Q38_9',	'Q38_10'
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
test2 = test.merge(ratees[ratees["rating_number"]==2], how="left", on="names", suffixes=("_1","_2"))
test3 = test2.merge(ratees[ratees["rating_number"]==3], how="left", on="names")
test4 = test3.merge(ratees[ratees["rating_number"]==4], how="left", on="names", suffixes=("_3","_4"))
test5 = test4.merge(ratees[ratees["rating_number"]==5], how="left", on="names")
test6 = test5.merge(ratees[ratees["rating_number"]==5], how="left", on="names",suffixes=("_5","_6"))

final = test6.drop(columns=['Q23_1_6',
'Q23_2_6',
'Q24_1_1_6',
'Q24_1_2_6',
'Q24_1_3_6',
'Q24_1_4_6',
'Q24_1_5_6',
'Q24_1_6_6',
'Q24_1_7_6',
'Q24_1_8_6',
'Q24_1_9_6',
'Q24_1_10_6',
'Q24_1_11_6',
'Q24_1_12_6',
'Q24_1_13_6',
'Q24_1_14_6',
'Q24_1_15_6',
'Q24_1_16_6',
'Q24_1_17_6',
'Q24_1_18_6',
'Q24_1_19_6',
'Q24_1_20_6',
'Q25_1_6',
'Q25_2_6',
'Q25_3_6',
'Q25_4_6',
'Q25_5_6',
'Q25_6_6',
'Q25_7_6',
'Q25_8_6',
'Q25_9_6',
'Q25_10_6',
'rating_number_6'])


len(final_cols)
final.columns = final.columns.str.replace('Q24_1_', 'Q24_')

for i in final.columns:
    print("'" + i + "',")
final.to_csv(r'byRater2024.csv')



    
    

