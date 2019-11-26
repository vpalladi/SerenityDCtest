
import csv

# import os
import math
import re
import json

# matplotlib
import matplotlib.pyplot as plt
import matplotlib.collections as mc
import matplotlib.lines as mlines
# from matplotlib.gridspec import GridSpec

# numpy
import numpy as np

import run
import databasing as db

# colours
red = (0.75, 0, 0, 1)
redAlpha = (0.75, 0, 0, 0.5)
green = (0, 0.75, 0, 1)
greenAlpha = (0, 0.75, 0, 0.5)



# scanId: is the timestamp in case you want to read for DB and the path of the scan if you want to read from a folder
class scan():
    def __init__(self, scanId, site, description='BER Scan', sort='rx', fromJSON=False):

        # info
        self.scanId = scanId
        self.description = description
        self.site = 'site' + site
        self.scans = []

        # get the scans from JSON
        if fromJSON :
            self.scans = self.loadScan( self.scanId, self.site )
        else :
            self.scans = db.query( {'timestamp' : self.scanId, 'site' : self.site} )

        # sort the scans
        if sort == 'rx':
            self.scans.sort( key=lambda s: int( re.findall( 'Y[0-9+]', s.dict['rxpin'] )[0].replace('Y', '') ) )
            self.scans.sort( key=lambda s: s.dict['rxquad'] )
        elif sort == 'tx':
            self.scans.sort( key=lambda s: int( re.findall( 'Y[0-9+]', s.dict['txpin'] )[0].replace('Y', '') ) )
            self.scans.sort( key=lambda s: s.dict['txquad'] )
        else:
            print('Error: sorting for scans not suppoerted.')
            exit()

        # get the openings
        self.openingAtDwell = self.getOpening(self.getDwell())
        self.openingAt1em12 = self.getOpening(
            [1.e-12 for i in range(0, len(self.scans))])
        
    def loadScan(self, path, site, comment="" ):
        scans = []
        with open( path + '/config.json' ) as cfg_file:
                cfg = json.load( cfg_file )
                for item in cfg.items():
                    print (item[0])
                    if item[1]['site'].replace('site', '') == site.replace('site', ''):
                        scans.append( run.Run.fromJSON( item, path, comment='' ) )
        return scans
                    
    def getDwell(self):
        return [ scan.dict['Dwell BER'] for scan in self.scans ]

    def getOpening(self, precision):
        return [scan.getOpening(prec) for scan, prec in zip(self.scans, precision)]

    def getNlinks(self):
        return len(self.scans)

    def getBERplot(self, linkId, ax):

        if linkId < 0 or linkId >= len(self.scans):
            print(' Error: linkId out of bounds')
            return None

        # only the BER
        df = self.scans[linkId].getDataFrame(purge=True)
        ax.plot( df['time'], 
                 df['BER'], 
                 'o', markersize=3, color='c')
        ax.set_yscale('log')
        ax.set_ylabel('BER')
        ax.set_xlabel('a.u.')

   
    def getBERfitPlot(self, linkId, ax):

        if linkId < 0 or linkId >= len(self.scans):
            print(' Error: linkId out of bounds')
            return None

        # only the BER
        df = self.scans[linkId].getDataFrame(purge=True)
        ax.plot( df['time'], 
                 df['BER'], 
                 'o', markersize=3)
        self.scans[linkId].plotFitCurve(ax, fontsize=10)
        ax.set_yscale('log')
        ax.set_ylabel('BER')
        ax.set_xlabel('a.u.')

        if not(self.scans[linkId].isAccepted()):
            ax.set_facecolor(redAlpha)

    def getAllOpeningsPlot(self, ax):

        # plot all the openings
        openings12 = [[(o12[2][0], i), (o12[2][1], i)]
                      for i, o12 in enumerate(self.openingAt1em12)]
        colours = [green if s.isAccepted() else red for s in self.scans]

        lines = mc.LineCollection(openings12, colors=colours)
        ax.add_collection(lines)
        ax.set_ylim([-1, self.getNlinks()])
        ax.set_xlim([-32, 32])
        ax.set_ylabel('linkId')
        ax.set_xlabel('a.u.')

    def getAllOpeningsPlotDiff(self, ax):

        # plot all the openings
        openings12 = [(o12[2][1] - o12[2][0])
                      for i, o12 in enumerate(self.openingAt1em12)]
        link = [i for i, o12 in enumerate(self.openingAt1em12)]
        colours = [green if s.isAccepted() else red for s in self.scans]

        ax.scatter(openings12, link, c=colours)
        ax.set_ylim([-1, self.getNlinks()])
        ax.set_xlim([0, 64])
        ax.set_ylabel('linkId')
        ax.set_xlabel('a.u.')

    def compare(self, scan):

        if len(scan.scans) != len(self.scans):
            print('Error:'
                  + 'trying to compare scans with different number of links')
            return None

        firstOpeningAtSecondDwell = self.getOpening(scan.getDwell())
        secondOpeningAtFirstDwell = scan.getOpening(self.getDwell())

        # plot all the openings
        openings12first = [[(o12[2][0], i), (o12[2][1], i)]
                           for i, o12 in enumerate(self.openingAt1em12)]
        coloursFirst = [green if s.isAccepted() else red for s in self.scans]

        openings12second = [[(o12[2][0], i + 0.25), (o12[2][1], i + 0.25)]
                            for i, o12 in enumerate(scan.openingAt1em12)]
        coloursSecond = [green if s.isAccepted() else red for s in scan.scans]

        # openings comparison
        linesFirst = mc.LineCollection(openings12first, colors=coloursFirst)
        linesSecond = mc.LineCollection(openings12second, colors=coloursSecond)

        fig, ax = plt.subplots(figsize=(16, 9))
        fig.canvas.set_window_title(
            '(compare) Openings @' + str(scan.getDwell()[0]))

        ax.add_collection(linesFirst)
        ax.add_collection(linesSecond)
        ax.set_ylim([-1, self.getNlinks()])
        ax.set_xlim([-32, 32])
        ax.set_ylabel('linkId')
        ax.set_xlabel('a.u.')

        fig.savefig('(compare) Openings @' + str(scan.getDwell()[0]) + '.png')

        # get all openings for the compare
        nRows = int(math.sqrt(scan.getNlinks()))
        nCols = int(scan.getNlinks() / nRows)

        figAll, axAll = plt.subplots(nRows, nCols, figsize=(24, 13.5))
        figAll.subplots_adjust(left=0.03, right=0.98, top=0.98, bottom=0.05)
        figAll.canvas.set_window_title(
            '(compare) All scans @' + str(scan.getDwell()[0]))

        for r in range(0, nRows):
            for c in range(0, nCols):
                ich = r * (nCols) + c
                scan.getBERplot(ich, axAll[r, c])
                scan.getBERfitPlot(ich, axAll[r, c])
                if c != 0:
                    axAll[r, c].yaxis.set_ticks([])
                    axAll[r, c].set_ylabel('')
                if r != (nRows - 1):
                    axAll[r, c].xaxis.set_ticks([])
                    axAll[r, c].set_xlabel('')

                if r == 0 and c == 2:
                    fitTmp, axAllTmp = plt.subplots()
                    scan.getBERfitPlot(ich, axAllTmp)

        figAll.savefig('(compare) All scans @' +
                       str(scan.getDwell()[0]) + '.png')

        # histos of relative differences in openings
        openingDiffAtFirstDwell = [(f[-1] - s[-1]) / f[-1]
                                   for f, s in zip(self.openingAtDwell, secondOpeningAtFirstDwell)]
        openingDiffAtSecondDwell = [
            (f[-1] - s[-1]) / f[-1] for f, s in zip(scan.openingAtDwell, firstOpeningAtSecondDwell)]
        openingDiffAt1em12 = [(f[-1] - s[-1]) / f[-1]
                              for f, s in zip(self.openingAt1em12, scan.openingAt1em12)]

        fig2, ax2 = plt.subplots(2, 1, figsize=(16, 16))
        fig2.canvas.set_window_title('Relative normilized openings')

        nbins = 40
        ax2[0].hist(openingDiffAtFirstDwell,  range=(-1, 1), bins=nbins)
        ax2[0].set_title('opening diff at (' + str(self.getDwell()[0]) + ')')
        ax2[0].text(0.1, 0.8, 'rms  ' + str(format(np.std(openingDiffAtFirstDwell), '.3f')),
                    transform=ax2[0].transAxes, size=16)
        ax2[0].text(0.1, 0.7, 'mean ' + str(format(np.mean(openingDiffAtFirstDwell), '.3f')),
                    transform=ax2[0].transAxes, size=16)
        ax2[0].tick_params(size=12)

        ax2[1].hist(openingDiffAt1em12, range=(-1, 1), bins=nbins)
        ax2[1].set_title('opening diff at 1.e-12')
        ax2[1].text(0.1, 0.8, 'rms  ' + str(format(np.std(openingDiffAt1em12), '.3f')),
                    transform=ax2[1].transAxes, size=16)
        ax2[1].text(0.1, 0.7, 'mean ' + str(format(np.mean(openingDiffAt1em12), '.3f')),
                    transform=ax2[1].transAxes, size=16)
        ax2[1].tick_params(size=12)

        fig2.savefig('Relative normilized openings.png')

        # scatter plots openings
        openingDiffAtFirstDwell = [(f[-1] - s[-1]) / f[-1]
                                   for f, s in zip(self.openingAtDwell, secondOpeningAtFirstDwell)]
        # openingDiffAtSecondDwell = [
        #     (f[-1] - s[-1]) / f[-1] for f, s in zip(scan.openingAtDwell, firstOpeningAtSecondDwell)]
        openingDiffAt1em12 = [(f[-1] - s[-1]) / f[-1]
                              for f, s in zip(self.openingAt1em12, scan.openingAt1em12)]

        fig3, ax3 = plt.subplots(2, 1, figsize=(16, 16))
        fig3.canvas.set_window_title('Correlations')

        thr = 0.3

        ax3[0].scatter([f[-1] for f in self.openingAtDwell], [f[-1]
                                                              for f in secondOpeningAtFirstDwell])
        ax3[0].set_title('openings at (' + str(self.getDwell()[0]) + ')')
        ax3[0].set_ylabel(scan.description, size=14)
        ax3[0].set_xlabel(self.description, size=14)
        ax3[0].set_ylim(0, 1)
        ax3[0].set_xlim(0, 1)
        ax3[0].tick_params(size=12)
        vLine0 = mlines.Line2D([thr, thr], [0, 1], color=(1, 0, 0, 0.5))
        hLine0 = mlines.Line2D([0, 1], [thr, thr], color=(1, 0, 0, 0.5))
        ax3[0].add_line(vLine0)
        ax3[0].add_line(hLine0)

        ax3[1].scatter([f[-1] for f in self.openingAt1em12], [f[-1]
                                                              for f in scan.openingAt1em12])
        ax3[1].set_title('openings at 1e-12')
        ax3[1].set_ylabel('extrapolated from ' + scan.description, fontsize=14)
        ax3[1].set_xlabel('extrapolated from ' + self.description, fontsize=14)
        ax3[1].set_ylim(0, 1)
        ax3[1].set_xlim(0, 1)
        ax3[1].tick_params(size=12)
        vLine2 = mlines.Line2D([thr, thr], [0, 1], color=(1, 0, 0, 0.5))
        hLine2 = mlines.Line2D([0, 1], [thr, thr], color=(1, 0, 0, 0.5))
        ax3[1].add_line(vLine2)
        ax3[1].add_line(hLine2)

        fig3.savefig('Correlations.png')

        return 0
