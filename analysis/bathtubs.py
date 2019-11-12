#!/usr/bin/python3

import csv 
import os
import math
import re
import json

import matplotlib.pyplot as plt
import matplotlib.collections as mc
import matplotlib.lines as mlines
from matplotlib.gridspec import GridSpec

import numpy as np

from scipy.optimize import curve_fit
from scipy.optimize import fsolve
from scipy.special import erfc
from scipy.stats import norm

debug = False
red = (0.75,0,0,1)
redAlpha = (0.75,0,0,0.5)
green = (0,0.75,0,1)
greenAlpha = (0,0.75,0,0.5)

def BERr(x, rho, muR, sigma) :
    R = erfc( (- x + muR) / ( sigma*math.sqrt(2) ) )
    result =  rho * R
    return result

def BERl(x, rho, muL, sigma) :
    L = erfc( (x - muL) / ( sigma*math.sqrt(2) ) )
    result =  rho * L
    return result

def BER(x, rho, muL, muR, sigma) :
    return ( BERr(x, rho, muR, sigma) + BERl(x, rho, muL, sigma) )

def BERlog(x, rho, muL, muR, sigma) :
    return (np.log( BERr(x, rho, muR, sigma) + BERl(x, rho, muL, sigma) ) )

def BERlogShift(x, rho, muL, muR, sigma, yshift) :
    return ( BERlog(x, rho, muL, muR, sigma)+yshift  )

class bathtub() :

    def __init__(self, fileName='', tx='', rx='', x=[], y=[]) :
        self.tx = tx
        self.rx = rx
        self.txQuad = re.findall('Quad_+[0-9]*', self.tx)[0].replace('Quad_','')
        self.rxQuad = re.findall('Quad_+[0-9]*', self.rx)[0].replace('Quad_','')
        self.txQuadPin = re.findall('X+[0-9]Y+[0-9]*', self.tx)[0].replace('Quad_','')
        self.rxQuadPin = re.findall('X+[0-9]Y+[0-9]*', self.rx)[0].replace('Quad_','')
        self.x = np.array(x)
        self.y = np.array(y)
        self.fileName = fileName

        if self.fileName != '' :
            self.readScan( self.fileName )

    def readScan(self, fileName) :
        self.fileName = fileName
        csvFile = open( self.fileName )

        csvReader = csv.reader(csvFile)

        rows = [r for r in csvReader]

        for r in rows :

            if r[0]=='Scan Name' :            
                #self.title = r[-1].replace( re.findall('Link_+[0-9]*', r[-1] )[0], '' )
                self.title = self.txQuad+'_'+self.txQuadPin+'->'+self.rxQuad+'_'+self.rxQuadPin
                self.txConnectorId = int( re.findall('Tx+[0-9]*', r[-1])[0].replace('Tx', '') )
                self.rxConnectorId = int( re.findall('Rx+[0-9]*', r[-1])[0].replace('Rx', '') )
                self.txId = int( re.findall('tx+[0-9]*', r[-1])[0].replace('tx', '') )
                self.rxId = int( re.findall('rx+[0-9]*', r[-1])[0].replace('rx', '') )
                self.dcId = int( re.findall('DC+[0-9]*', r[-1])[0].replace('DC', '').split(' ')[0] )

            if r[0]=='Dwell BER' :
                self.dwellBER = float(r[-1])
            if r[0]=='Horizontal Percentage' :
                self.horizontalPercentage = float(r[-1])
            if r[0]=='Horizontal Opening' :
                self.horizontalOpening = float(r[-1])
        
        tmp = [ [float(x),float(y)] for x,y in zip(rows[19][1:],rows[20][1:]) ] 
        self.x    = np.array( [ i[0] for i in tmp] )
        self.y    = np.array( [ i[1] for i in tmp] )
        self.ylog = np.array( [ np.log(i[1] ) for i in tmp] )

        minY = min(self.y)

        
        self.xpurge    = np.array( [ i[0] for i in tmp if i[1]>minY ] )
        self.ypurge    = np.array( [ i[1] for i in tmp if i[1]>minY ] )
        self.ylogpurge = np.array( [ np.log( y ) for y in self.ypurge ] )

        if debug :
            print('self.filename',self.fileName)
            print('len(self.x   )',len(self.x   ) )
            print('len(self.y   )',len(self.y   ) )
            print('len(self.ylog)',len(self.ylog) )
            print('len(self.xpurge   )',len(self.xpurge   ) )
            print('len(self.ypurge   )',len(self.ypurge   ) )
            print('len(self.ylogpurge)',len(self.ylogpurge) )

    def getPrecision() :
        return self.dwellBER

    def fit( self, start=() ) :
        if start: 
            popt, pcov = curve_fit( BER, self.x, self.y, p0=start )
            return popt, pcov
        else :
            popt, pcov = curve_fit( BER, self.x, self.y )
            return popt, pcov

    def fitPurge( self ) :
        popt, pcov = curve_fit( BER, self.xpurge, self.ypurge )
        return popt, pcov

    def fitPurgeLog( self ) :
        start = (1, -27, 25, 1.2)
        popt, pcov = curve_fit( BERlog, self.xpurge, self.ylogpurge, p0=start )
        return popt, pcov

    def fitR( self, start=() ) :
        popt, pcov = curve_fit( BERr, self.x, self.y )
        return popt, pcov

    def fitL(self) :
        start = (0.2, -25, 3 )
        popt, pcov = curve_fit( BERl, self.x, self.y )
        return popt, pcov

    def getOpening(self, BERvalue) :
        popt,pcov = self.fitPurgeLog()
        popt = np.append(popt, -np.log(BERvalue) )
        edges = fsolve( BERlogShift, [-20, 20], args=tuple(popt), factor=0.1 )
        opening = edges[1]-edges[0]
        openingPC = abs(opening)/(self.x[-1]-self.x[0])
        return popt,pcov,edges,opening,openingPC

    def plotFitCurve(self, ax, fontsize=6) :
        opt8,cor8,o8,o8opening,o8openingPC = self.getOpening(1e-8)
        opt12,cor12,o12,o12opening,o12openingPC = self.getOpening(1e-12)

        # fit and plot the fit_curve
        poptpl, pcovpl  = self.fitPurgeLog()
        ax.plot( self.x, BER(self.x, *poptpl), '--', color=green )

        # text lables        
        ax.set_title( self.title, fontdict={'fontsize':fontsize } )

#        ax.text(0.1, 0.8, 'delta@1e-8 '+str(format( o8[0]-o8[1], '.2f')), 
#                     fontsize=fontsize, transform=ax.transAxes)
#        ax.text(0.1, 0.7, 'pc@1e-8 '+str(format( np.abs(o8[0]-o8[1])/64, '.2f')), 
#                     fontsize=fontsize, transform=ax.transAxes)
        ax.text(0.1, 0.8, 'delta@1e-12 '+str(format( o12[0]-o12[1], '.2f')), 
                     fontsize=fontsize, transform=ax.transAxes)
        ax.text(0.1, 0.9, 'pc@1e-12 '+str(format( np.abs(o12[0]-o12[1])/64, '.2f')), 
                     fontsize=fontsize, transform=ax.transAxes)

        ax.set_yscale('log')
        ax.set_ylim([10e-13,1])
        ax.tick_params( labelsize=10 )
        
        return poptpl, pcovpl

    def isAccepted( self, thr=0.30, precision=1e-12 ) : # 30% opening comes from sfp+, sff specs
        opt,cor,oedges,opening,openingPC = self.getOpening( precision )
        
        if openingPC < thr :
            return False
        return True

# scan class 
class scan() :
    
    def __init__(self, scanPath, DC, description='BER Scan', sort='rx') :
        
        # info
        self.scanPath = scanPath
        self.description = description
        self.DC = 'DC'+DC.replace('DC','')
        self.scans = []

        # get the scans
        with open( scanPath+'/config.json' ) as json_file :
            data  = json.load( json_file )
            for key,val in data.items() :
                if val['DC'].replace('DC','') == DC.replace('DC','') :
                    fileName = scanPath+'/'+self.DC+'/'+key+'.csv'
                    print(fileName)
                    self.scans.append( bathtub( fileName=fileName, tx=val['tx'], rx=val['rx'] ) )
                    
        # sort the scans
        if sort=='rx' :
            self.scans.sort( key=lambda s: s.rxQuad )
#            self.scans.sort( key=lambda s: int( ( re.findall('Y+[0-9]', s.rxQuadPin )[0].replace('Y','')) ) )
        elif sort=='tx' :
            self.scans.sort( key=lambda s: s.txQuad )
#            self.scans.sort( key=lambda s: int( ( re.findall('Y+[0-9]', s.txQuadPin )[0].replace('Y','')) ) )
        else :
            print('Error: sorting for scans not suppoerted.')
            exit()
 
        # get the openings
        self.openingAtDwell = self.getOpening( self.getDwell() ) 
        self.openingAt1em12 = self.getOpening( [ 1.e-12 for i in range(0, len(self.scans) ) ] )

    def getDwell( self ) :
        return [ scan.dwellBER for scan in self.scans ] 

    def getOpening( self, precision ) :
        return [ scan.getOpening(prec) for scan,prec in zip(self.scans,precision) ] 
        
    def getNlinks ( self ) :
        return len( self.scans )

    def getBERplot( self, linkId, ax ) :
        
        if linkId<0 or linkId >= len( self.scans ) :
            print(' Error: linkId out of bounds')
            return None
            
        # only the BER
        ax.plot( self.scans[linkId].xpurge, self.scans[linkId].ypurge, 'o', markersize=3, color='c' )
        ax.set_yscale('log')
        ax.set_ylabel('BER')
        ax.set_xlabel('a.u.')

    def getBERfitPlot( self, linkId, ax ) :
        
        if linkId<0 or linkId >= len( self.scans ) :
            print(' Error: linkId out of bounds')
            return None
            
        # only the BER
        ax.plot( self.scans[linkId].xpurge, self.scans[linkId].ypurge, 'o', markersize=3 )
        self.scans[linkId].plotFitCurve( ax, fontsize=10 )
        ax.set_yscale('log')
        ax.set_ylabel('BER')
        ax.set_xlabel('a.u.')

        if not( self.scans[linkId].isAccepted() ) :
            ax.set_facecolor( redAlpha )

    def getAllOpeningsPlot( self, ax ) :

        # plot all the openings         
        openings12 = [ [(o12[2][0],i),(o12[2][1],i)] for i,o12 in enumerate(self.openingAt1em12) ]
        colours    = [ green if s.isAccepted() else red for s in self.scans ]

        lines = mc.LineCollection(openings12, colors=colours)
        ax.add_collection( lines )
        ax.set_ylim( [-1,self.getNlinks()] )
        ax.set_xlim( [-32,32] )
        ax.set_ylabel( 'linkId' )
        ax.set_xlabel( 'a.u.' )

    def getAllOpeningsPlotDiff( self, ax ) :

        # plot all the openings         
        openings12 = [ (o12[2][1]-o12[2][0]) for i,o12 in enumerate(self.openingAt1em12) ]
        link       = [ i for i,o12 in enumerate(self.openingAt1em12) ]
        colours    = [ green if s.isAccepted() else red for s in self.scans ]
        
        ax.scatter(openings12,link, c=colours)
        ax.set_ylim( [-1,self.getNlinks()] )
        ax.set_xlim( [0,64] )
        ax.set_ylabel( 'linkId' )
        ax.set_xlabel( 'a.u.' )

    def compare( self, scan ) :
                
        if len(scan.scans) != len(self.scans) :            
            print('Error: trying to compare scans with different number of links')
            return None
            
        firstOpeningAtSecondDwell = self.getOpening( scan.getDwell() ) 
        secondOpeningAtFirstDwell = scan.getOpening( self.getDwell() )

        # plot all the openings         
        openings12first = [ [(o12[2][0],i),(o12[2][1],i)] for i,o12 in enumerate(self.openingAt1em12) ]
        coloursFirst    = [ green if s.isAccepted() else red for s in self.scans ]

        openings12second = [ [(o12[2][0],i+0.25),(o12[2][1],i+0.25)] for i,o12 in enumerate(scan.openingAt1em12) ]
        coloursSecond    = [ green if s.isAccepted() else red for s in scan.scans ]

        # openings comparison
        linesFirst = mc.LineCollection(openings12first, colors=coloursFirst)
        linesSecond = mc.LineCollection(openings12second, colors=coloursSecond)

        fig,ax = plt.subplots( figsize=(16,9) )
        fig.canvas.set_window_title( '(compare) Openings @'+str(scan.getDwell()[0]) )

        ax.add_collection( linesFirst )
        ax.add_collection( linesSecond )
        ax.set_ylim( [-1,self.getNlinks()] )
        ax.set_xlim( [-32,32] )
        ax.set_ylabel( 'linkId' )
        ax.set_xlabel( 'a.u.' )

        fig.savefig( '(compare) Openings @'+str(scan.getDwell()[0])+'.png' )

        # get all openings for the compare
        nRows = int( math.sqrt(scan.getNlinks()) )
        nCols = int( scan.getNlinks()/nRows )
        
        figAll,axAll = plt.subplots( nRows, nCols, figsize=(24,13.5) )
        figAll.subplots_adjust(left=0.03, right=0.98, top=0.98, bottom=0.05)
        figAll.canvas.set_window_title( '(compare) All scans @'+str(scan.getDwell()[0]) )

        for r in range(0, nRows) :
            for c in range(0, nCols) :
                ich = r*(nCols) + c
                scan.getBERplot( ich, axAll[r,c] )
                scan.getBERfitPlot( ich, axAll[r,c] )
                if c != 0 :
                    axAll[r,c].yaxis.set_ticks([])        
                    axAll[r,c].set_ylabel('')        
                if r != (nRows-1) : 
                    axAll[r,c].xaxis.set_ticks([])   
                    axAll[r,c].set_xlabel('')        

                if r==0 and c==2 :
                    fitTmp,axAllTmp = plt.subplots()
                    scan.getBERfitPlot( ich, axAllTmp )

        figAll.savefig( '(compare) All scans @'+str(scan.getDwell()[0])+'.png' )

        # histos of relative differences in openings
        openingDiffAtFirstDwell  = [ (f[-1]-s[-1])/f[-1] for f,s in zip(self.openingAtDwell,secondOpeningAtFirstDwell) ] 
        openingDiffAtSecondDwell = [ (f[-1]-s[-1])/f[-1] for f,s in zip(scan.openingAtDwell,firstOpeningAtSecondDwell) ] 
        openingDiffAt1em12       = [ (f[-1]-s[-1])/f[-1] for f,s in zip(self.openingAt1em12,scan.openingAt1em12) ] 

        fig2,ax2 = plt.subplots( 2, 1, figsize=(16,16) )
        fig2.canvas.set_window_title( 'Relative normilized openings' )
        #gs = ax2[1,0].get_gridspec()
        #for a in ax2[1,:] :
        #    a.remove() 
        #ax2[1,0] = fig2.add_subplot(gs[1:, :])
        
        nbins = 40
        ax2[0].hist(openingDiffAtFirstDwell,  range=(-1,1), bins=nbins )
        ax2[0].set_title('opening diff at ('+str(self.getDwell()[0])+')' )
        ax2[0].text(0.1, 0.8, 'rms  '+str(format(np.std(openingDiffAtFirstDwell), '.3f')), 
                    transform=ax2[0].transAxes, size=16)
        #tmp = [ i for i in openingDiffAtFirstDwell if i< 0.5 ]
        #print ( '---- ',np.std(tmp), np.mean(tmp) ) 
        ax2[0].text(0.1, 0.7, 'mean '+str(format(np.mean(openingDiffAtFirstDwell), '.3f')), 
                      transform=ax2[0].transAxes, size=16)
        ax2[0].tick_params(size=12)
        
        #ax2[0,1].hist(openingDiffAtSecondDwell, range=(-1,1), bins=nbins )
        #
        #ax2[0,1].set_title('opening diff at ('+str(scan.getDwell()[0])+')')
        #ax2[0,1].text(0.1, 0.8, 'rms  '+str(format(np.std(openingDiffAtSecondDwell), '.3f')), 
        #              transform=ax2[0,1].transAxes)
        #ax2[0,1].text(0.1, 0.7, 'mean '+str(format(np.mean(openingDiffAtSecondDwell), '.3f')), 
        #              transform=ax2[0,1].transAxes)

        ax2[1].hist(openingDiffAt1em12, range=(-1,1), bins=nbins )
        ax2[1].set_title('opening diff at 1.e-12')
        ax2[1].text(0.1, 0.8, 'rms  '+str(format(np.std(openingDiffAt1em12), '.3f')), 
                    transform=ax2[1].transAxes, size=16)
        ax2[1].text(0.1, 0.7, 'mean '+str(format(np.mean(openingDiffAt1em12), '.3f')), 
                    transform=ax2[1].transAxes, size=16)
        ax2[1].tick_params(size=12)
        #tmp = [ i for i in openingDiffAt1em12 if i< 0.5 ]
        #print ( '------ ',np.std(tmp), np.mean(tmp) ) 
        

        fig2.savefig( 'Relative normilized openings.png' )

        # scatter plots openings
        openingDiffAtFirstDwell  = [ (f[-1]-s[-1]) / f[-1] for f,s in zip( self.openingAtDwell,secondOpeningAtFirstDwell ) ]
        openingDiffAtSecondDwell = [ (f[-1]-s[-1]) / f[-1] for f,s in zip( scan.openingAtDwell,firstOpeningAtSecondDwell ) ]
        openingDiffAt1em12       = [ (f[-1]-s[-1]) / f[-1] for f,s in zip( self.openingAt1em12,scan.openingAt1em12       ) ] 

        fig3,ax3 = plt.subplots( 2, 1, figsize=(16,16) )
        fig3.canvas.set_window_title( 'Correlations' )
        #gs = ax3[1,0].get_gridspec()
        #for a in ax3[1,:] :
        #    a.remove() 
        #ax3[1,0] = fig3.add_subplot(gs[1:, :])

        thr=0.3
        #x1,y1  = [thr,thr], [-1,-1]
        #x2,y2  = [-1,-1], [thr,thr]
        #vLine = mlines.Line2D([thr, thr], [0, 1], color=(1,0,0,0.5))
        #hLine = mlines.Line2D([0, 1], [thr, thr], color=(1,0,0,0.5))

        ax3[0].scatter( [ f[-1] for f in self.openingAtDwell ], [ f[-1] for f in secondOpeningAtFirstDwell ] )
        ax3[0].set_title('openings at ('+str(self.getDwell()[0])+')')
        ax3[0].set_ylabel( scan.description, size=14 )
        ax3[0].set_xlabel( self.description, size=14 )
        ax3[0].set_ylim(0,1)
        ax3[0].set_xlim(0,1)
        ax3[0].tick_params(size=12)
        vLine0 = mlines.Line2D([thr, thr], [0, 1], color=(1,0,0,0.5))
        hLine0 = mlines.Line2D([0, 1], [thr, thr], color=(1,0,0,0.5))
        ax3[0].add_line(vLine0)
        ax3[0].add_line(hLine0)
        
        #ax3[0,1].scatter( [ f[-1] for f in scan.openingAtDwell ], [ f[-1] for f in firstOpeningAtSecondDwell ] )
        ##ax3[0,1].add_collection(edgesColl)
        #ax3[0,1].set_title('openings at compDwell ('+str(scan.getDwell()[0])+')')
        #ax3[0,1].set_ylabel('main')
        #ax3[0,1].set_xlabel('compare')
        #ax3[0,1].set_ylim(0,1)
        #ax3[0,1].set_xlim(0,1)
        #vLine1 = mlines.Line2D([thr, thr], [0, 1], color=(1,0,0,0.5))
        #hLine1 = mlines.Line2D([0, 1], [thr, thr], color=(1,0,0,0.5))
        #ax3[0,1].add_line(vLine1)
        #ax3[0,1].add_line(hLine1)
        
        ax3[1].scatter( [ f[-1] for f in self.openingAt1em12 ], [ f[-1] for f in scan.openingAt1em12 ] )
        ax3[1].set_title( 'openings at 1e-12' )
        ax3[1].set_ylabel( 'extrapolated from '+scan.description, fontsize=14 )
        ax3[1].set_xlabel( 'extrapolated from '+self.description, fontsize=14 )
        ax3[1].set_ylim( 0, 1 )
        ax3[1].set_xlim( 0, 1 )
        ax3[1].tick_params(size=12)
        vLine2 = mlines.Line2D( [thr, thr], [0, 1], color=(1,0,0,0.5) )
        hLine2 = mlines.Line2D( [0, 1], [thr, thr], color=(1,0,0,0.5) )
        ax3[1].add_line( vLine2 )
        ax3[1].add_line( hLine2 )

        fig3.savefig('Correlations.png')
        
        return 0
        
