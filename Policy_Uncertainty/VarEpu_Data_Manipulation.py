# -*- coding: utf-8 -*-
"""
Created on Mon Feb 12 13:34:36 2018

@author: Student
"""

import numpy as np
import pandas as pd


adr = pd.read_csv("ADR_97_17.csv")
adr_cmpstat = pd.read_csv("ADR_Compustat.csv")

trans_cost = adr['ASK'] - adr['BID'] / ((adr['ASK'] + adr['BID']) / 2)
volatility = np.log(adr['ASKHI']) - np.log(adr['BIDLO'])
adr['PRC'] = np.abs(adr['PRC'])
illiquidity = ( np.abs(adr['vwretd']) / adr['PRC'] * adr['VOL'])
size = adr['PRC'] * adr['SHROUT'] * 1000


adr['trans_cost'] = trans_cost
adr['volatility'] = volatility
adr['illiquidity'] = illiquidity
adr['size'] = size

# 0 = Monday... 6 = Sunday
adr['day'] = pd.DatetimeIndex(adr['date']).weekday
adr = adr.drop(['SHRCLS'], axis=1)

adr.head(10)



weekly_adr = pd.DataFrame(adr[0:1])

weekly_adr.append(adr[1:2])



temp = adr.head(35)
summer = np.zeros((1,23))

for i in range(len(temp)):
    if temp.iloc[i,23] == 2:
        j=0
        while temp.iloc[i+j,23] != 2:
           summer += temp.iloc[i+j]
           j += 1
        weekly_adr.append(pd.DataFrame(summer / j))
        

















