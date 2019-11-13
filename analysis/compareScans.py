#!/usr/bin/python3

from optparse import OptionParser
import os
import matplotlib.pyplot as plt
# from matplotlib import collections as mc

from bathtubs import bathtub

# parser
parser = OptionParser()
parser.add_option("-f", "--first", dest="firstDir",
                  help="The FIRST directory where the scans are located.",
                  type='string')
parser.add_option("-s", "--second", dest="secondDir",
                  help="The SECOND directory where the scans are located.",
                  type='string')

# read options
options, args = parser.parse_args()
firstDirName = options.firstDir
secondDirName = options.secondDir

# get the scans
filesFD = os.listdir(firstDirName)
scansFD = [bathtub(fileName=(firstDirName + '/' + f)) for f in filesFD]
filesSD = os.listdir(secondDirName)
scansSD = [bathtub(fileName=(secondDirName + '/' + f)) for f in filesSD]

openings_1em12_FD = []
openings_1em12_SD = []

# the Loop
for scanFD, scanSD in zip(scansFD, scansSD):

    optFD_1em12 = scanFD.getOpening(1e-12)
    optSD_1em12 = scanSD.getOpening(1e-12)
    openings_1em12_FD.append(optFD_1em12[3])
    openings_1em12_SD.append(optSD_1em12[3])
    print(optSD_1em12[3])

plt.subplots(1, 1)
plt.scatter(openings_1em12_FD, openings_1em12_SD)
plt.subplots(1, 1)
plt.hist([(f - d) / f for f, d in zip(openings_1em12_FD, openings_1em12_SD)],
         range=(-0.1, 0.1), bins=20)
plt.show()
