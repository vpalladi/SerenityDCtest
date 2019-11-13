#!/usr/bin/python3

# import os
import math
from optparse import OptionParser

import matplotlib.pyplot as plt
# import matplotlib.collections as mc

from bathtubs import scan


# parser
def main():
    parser = OptionParser()
    parser.add_option(
        "-s", "--scanPath", dest="scanPath", help="The path to the scan.",
        type='string')
    parser.add_option(
        "-d", "--DC", dest="DC", help="The config file for the specific scan.",
        type='string', default='0')
    parser.add_option(
        "-a", "--description", dest="scanDescription",
        help="The description of the scan. Goes to the histo axis.", type='string',
        default='main')
    parser.add_option(
        "-q", "--scanPathCompare", dest="scanPathCompare",
        help="The config file for the copmare scan.", type='string', default='')
    parser.add_option(
        "-m", "--DCcompare", dest="DCcompare",
        help="The config file for the compare scan.", type='string', default='0')
    parser.add_option(
        "-b", "--descriptionCompare", dest="scanDescriptionCompare",
        help="The description of the coparison scan. Goes to the histo axis.",
        type='string', default='compare')
    parser.add_option(
        "-f", "--outFileName", dest="outFileName",
        help="The base file name used to save the plots.", type='string',
        default='')
    parser.add_option(
        "-p", "--plot", action='store_true', dest="genPlot",
        help="Genrates plots.", default=False)

    # read options
    options, args = parser.parse_args()

    # outFileName = options.outFileName

    scanSorting = 'tx'

    s = scan(options.scanPath, options.DC, options.scanDescription,
             sort=scanSorting)

    nRows = int(math.sqrt(s.getNlinks()))
    nCols = int(s.getNlinks() / nRows)

    fig, ax = plt.subplots(nRows, nCols, figsize=(24, 13.5))
    fig.subplots_adjust(left=0.03, right=0.98, top=0.98, bottom=0.05)
    fig.canvas.set_window_title('(main) All scans @' + str(s.getDwell()[0]))

    for r in range(0, nRows):
        for c in range(0, nCols):
            ich = r * (nCols) + c
            s.getBERplot(ich, ax[r, c])
            s.getBERfitPlot(ich, ax[r, c])
            if c != 0:
                ax[r, c].yaxis.set_ticks([])
                ax[r, c].set_ylabel('')
            if r != (nRows - 1):
                ax[r, c].xaxis.set_ticks([])
                ax[r, c].set_xlabel('')

            if r == 0 and c == 2:
                fitTmp, axTmp = plt.subplots()
                s.getBERfitPlot(ich, axTmp)

    fig1, ax1 = plt.subplots(
        1, 2, sharey=True, gridspec_kw={'wspace': 0}, figsize=(16, 9))
    s.getAllOpeningsPlot(ax1[0])
    s.getAllOpeningsPlotDiff(ax1[1])
    fig1.canvas.set_window_title('(main) Openings @' + str(s.getDwell()[0]))

    if options.scanPathCompare != '':
        sCompare = scan(options.scanPathCompare, options.DCcompare,
                        options.scanDescriptionCompare, sort=scanSorting)
        s.compare(sCompare)
        fig2, ax2 = plt.subplots(1, 2, sharey=True, gridspec_kw={
                                 'wspace': 0}, figsize=(16, 9))
        sCompare.getAllOpeningsPlot(ax2[0])
        sCompare.getAllOpeningsPlotDiff(ax2[1])
        fig1.canvas.set_window_title(
            '(compare) Openings @' + str(sCompare.getDwell()[0]))

    fig.savefig('(main) All scans @' + str(s.getDwell()[0]) + '.png')
    fig1.savefig('(main) Openings @' + str(s.getDwell()[0]) + '.png')

    if options.genPlot:
        plt.show()


if __name__ == '__main__':
    main()
