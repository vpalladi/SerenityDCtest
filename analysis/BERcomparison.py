#!/usr/bin/python3

import csv 
import matplotlib.pyplot as plt
import math
import numpy as np
from scipy.optimize import curve_fit
from scipy.optimize import fsolve
from scipy.special import erfc
import re

csvFile_1em7_1em9 = open('1e-7_1e-9.csv')
csvFile_1em9_1em9 = open('1e-9_1e-9.csv')

csvReader_1em7_1em9 = csv.reader(csvFile_1em7_1em9)
csvReader_1em9_1em9 = csv.reader(csvFile_1em9_1em9)

csvReader_1em7_1em9_edges = []
for r in csvReader_1em7_1em9 :
    csvReader_1em7_1em9_edges.append( [float(r[0].split(',')[0].replace('(','')), float(r[1].split(',')[0].replace('(','')) ] )

csvReader_1em9_1em9_edges = []
for r in csvReader_1em9_1em9 :
    csvReader_1em9_1em9_edges.append( [float(r[0].split(',')[0].replace('(','')), float(r[1].split(',')[0].replace('(','')) ] )

diff = []
openings = []
for rm9,rm7 in zip(csvReader_1em9_1em9_edges, csvReader_1em7_1em9_edges) :
    diff.append( [ (rm9[0]-rm7[0])/abs(rm9[0]),(rm9[1]-rm7[1])/abs(rm9[1]) ] )
    openings.append( ( ( rm9[1]-rm9[0] ) - ( rm7[1]-rm7[0] ) ) / ( rm9[1]-rm9[0] ) )

#plt.hist( [d[0] for d in diff], color=(1,0,0,0.5) )
plt.hist( openings )
#plt.hist( [d[1] for d in diff], color=(0,1,0,0.5) )

plt.xlabel('1e-9_opening-1e-7_opening / 1e-9_opening')
plt.show()

