#!/usr/bin/python3

import os
import math 
from optparse import OptionParser

import matplotlib.pyplot as plt
import matplotlib.collections as mc

from bathtubs import *

# parser
parser = OptionParser()
parser.add_option("-d", "--dir", dest="dirName",
                  help="The directory where the scans are located.", type='string')
parser.add_option("-a", "--description", dest="scanDescription",
                  help="The description of the scan. Goes to the histo axis.", type='string', default='main')
parser.add_option("-g", "--generate", action='store_false', dest="genOutput",
                  help="Generates output.", default=True)
parser.add_option("-p", "--plot", action='store_true', dest="genPlot",
                  help="Genrates plots.", default=False)
parser.add_option("-f", "--baseFileName", dest="baseFileName",
                  help="The base file name used to save the plots.", type='string', default='')
parser.add_option("-c", "--compareBaseDir", dest="compareBaseDir",
                  help="The base file name used to compare the current scan.", type='string', default='')
parser.add_option("-b", "--descriptionCompare", dest="scanDescriptionCompare",
                  help="The description of the coparison scan. Goes to the histo axis.", type='string', default='compare')


# read options
options, args = parser.parse_args()
dirName = options.dirName
scanDescription = options.scanDescription
genOutput = options.genOutput
genPlot = options.genPlot
baseFileName = options.baseFileName
compareBaseDir = options.compareBaseDir
scanDescriptionCompare = options.scanDescriptionCompare

s = scan( dirName, scanDescription )

nRows = int( math.sqrt(s.getNlinks()) )
nCols = int( s.getNlinks()/nRows )

fig,ax = plt.subplots( nRows, nCols, figsize=(24,13.5)  )
fig.subplots_adjust(left=0.03, right=0.98, top=0.98, bottom=0.05)
fig.canvas.set_window_title( '(main) All scans @'+str(s.getDwell()[0]) )

for r in range(0, nRows) :
    for c in range(0, nCols) :
        ich = r*(nCols) + c
        s.getBERplot( ich, ax[r,c] )
        s.getBERfitPlot( ich, ax[r,c] )
        if c != 0 :
            ax[r,c].yaxis.set_ticks([])        
            ax[r,c].set_ylabel('')        
        if r != (nRows-1) : 
            ax[r,c].xaxis.set_ticks([])        
            ax[r,c].set_xlabel('')        

        if r==0 and c==2 :
            fitTmp,axTmp = plt.subplots()
            s.getBERfitPlot( ich, axTmp )

fig1,ax1 = plt.subplots( figsize=(16,9) )
s.getAllOpeningsPlot( ax1 )
fig1.canvas.set_window_title( '(main) Openings @'+str(s.getDwell()[0]) )

if compareBaseDir != '' :
    sCompare = scan( compareBaseDir, scanDescriptionCompare )
    s.compare( sCompare )

fig.savefig('(main) All scans @'+str(s.getDwell()[0])+'.png')
fig1.savefig('(main) Openings @'+str(s.getDwell()[0])+'.png')

if genPlot :
    plt.show()

