
# import os
import re
import time
from datetime import datetime
import csv

# pandas and numpy
import pandas as pd
import numpy as np

# sklearn
from scipy.optimize import curve_fit
from scipy.optimize import fsolve
from scipy.special import erfc

# colours
red = (0.75, 0, 0, 1)
redAlpha = (0.75, 0, 0, 0.5)
green = (0, 0.75, 0, 1)
greenAlpha = (0, 0.75, 0, 0.5)

def BERr(x, rho, muR, sigma):
    R = erfc((- x + muR) / (sigma * np.sqrt(2)))
    result = rho * R
    return result

def BERl(x, rho, muL, sigma):
    L = erfc((x - muL) / (sigma * np.sqrt(2)))
    result = rho * L
    return result

def BER(x, rho, muL, muR, sigma):
    return (BERr(x, rho, muR, sigma) + BERl(x, rho, muL, sigma))

def BERlog(x, rho, muL, muR, sigma):
    return (np.log(BERr(x, rho, muR, sigma) + BERl(x, rho, muL, sigma)))

def BERlogShift(x, rho, muL, muR, sigma, yshift):
    return (BERlog(x, rho, muL, muR, sigma) + yshift)

class Run:
    def __init__(self):
        self.dict = {}

    @classmethod
    def fromDict(cls, dictionary):
        r = cls()
        r.dict = dictionary
        return r

    @classmethod
    def fromJSON(cls, jsonEntry, path, comment=""):
        r = cls()

        filename = jsonEntry[0]
        config_entry = jsonEntry[1]
        r.dict = config_entry
        r.loadFile("%s/data/%s.csv" % (path, filename))
        r.dict['scanId'] = re.search("[0-9]*$", path).group()
        
        try:
            r.dict['txquad'] = int(re.search("Quad_([0-9]*)", config_entry['tx']).group(1))
        except AttributeError:
            pass
        try:
            r.dict['rxquad'] = int(re.search("Quad_([0-9]*)", config_entry['rx']).group(1))
        except AttributeError:
            pass
        try:
            r.dict['txpin'] = re.search("X[0-9]*Y[0-9]*", config_entry['tx']).group()
        except AttributeError:
            pass
        try:
            r.dict['rxpin'] = re.search("X[0-9]*Y[0-9]*", config_entry['rx']).group()
        except AttributeError:
            pass
        r.dict['comment'] = comment
        return r

    def loadFile(self, filename):
        self.filename = filename

        
        tx = self.filename.replace('.csv', '').split(' Link ')[1].split(':')[0].split('-')
        rx = self.filename.replace('.csv', '').split(' Link ')[1].split(':')[1].split('-')

        self.dict['baseBoard']      = re.findall( 'Serenity[-_][0-9]+',self.filename )[0] 
        self.dict['txSite']         = int( tx[0].replace('X','') )
        self.dict['rxSite']         = int( rx[0].replace('X','') )
        self.dict['txDC']           = tx[1]+'_'+tx[2]
        self.dict['rxDC']           = rx[1]+'_'+rx[2]
        self.dict['txConnector']    = tx[3]
        self.dict['rxConnector']    = rx[3]
        self.dict['txChId']         = tx[4]
        self.dict['rxChId']         = rx[4]
        self.dict['connectionType'] = self.filename.split(' Link ')[0].split(':')[0].split('-')[1]
        
        ### read the csv file
        csvFile = open(self.filename)
        csvReader = csv.reader(csvFile)
        rows_iter = iter( [r for r in csvReader] )

        for row in rows_iter :
            if row[0] == 'Scan Start':
                time = [int(j) for j in next(rows_iter)[1:] ]
                BER =  [float(j) for j in next(rows_iter)[1:]]
                self.dict['data'] = {'time': time,
                                     'BER': BER }
                
            else:
                if len(row)>1 :
                    try:
                        self.dict[ row[0] ] = int( row[1], 10 )
                    except ValueError:
                        try:
                            self.dict[ row[0] ] = float( row[1] )
                        except ValueError:
                            self.dict[ row[0] ] = row[1]
        
        self.dict['start'] = datetime.strptime( self.dict.pop('Date and Time Started'),
                                                '%Y-%b-%d %H:%M:%S'               )
        self.dict['end']   = datetime.strptime( self.dict.pop('Date and Time Ended'),
                                                '%Y-%b-%d %H:%M:%S'
                                            )
        
        return self.dict

    def addNote(self, note):
        self.dict['notes'] = note

    def insertIntoCollection(self, collection, check_exists=True):
        # Check if run already exits in collection
        if check_exists:
            query = {}
            count = collection.count_documents(query)
            if count:
                cursor = collection.find(query)
                for i in cursor:
                    i.pop('_id')
                    if i == self.dict:
                        return False
        return collection.insert_one(self.dict)

    def getPath(self) :
        string = 'X'+str(self.dict['txSite'])+'_'+self.dict['txConnector']+'_'+self.dict['txChId']+'->'+'X'+str(self.dict['rxSite'])+'_'+self.dict['rxConnector']+'_'+self.dict['rxChId']
        return string

    def getDataFrame(self, purge=False):
        value = []
        if purge:
            if hasattr(self, 'purgedf'):
                return( self.purgedf )
        else:
            if hasattr(self, 'df'):
                return( self.df )
        
        if not hasattr(self, 'df'):
            self.df = pd.DataFrame( self.dict['data'] )
            self.df.time = self.df.time/64. # time normalization
        if purge:
        
            self.purgedf = self.df[
                self.df['BER'] > self.df['BER'].min()].copy()
            self.purgedf['logBER'] = np.log(self.purgedf['BER'])
            return self.purgedf
        
        return self.df

    def getPrecision(self):
        return self.dict['dwellBER']

    def fit(self, start=()):
        df = self.getDataFrame()
        if start:
            popt, pcov = curve_fit(
                BER, df['time'], df['BER'], p0=start)
            return popt, pcov
        else:
            popt, pcov = curve_fit(BER, df['time'], df['BER'])
            return popt, pcov

    def fitPurge(self):
        df = self.getDataFrame(purge=True)
        popt, pcov = curve_fit(BER, df['time'], df['BER'])
        return popt, pcov

    def fitPurgeLog(self):
        if hasattr(self, 'popt') and hasattr(self, 'pcov'):
            return self.popt, self.pcov
        df = self.getDataFrame(purge=True)
        start = (1, -0.45, 0.45, 1.2/64)
        self.popt, self.pcov = curve_fit(BERlog, df['time'].values, df['logBER'].values, p0=start)
        return self.popt, self.pcov

    def getOpening(self, BERvalue):
        popt, pcov = self.fitPurgeLog()
        popt = np.append(popt, -np.log(BERvalue))
        edges = fsolve(BERlogShift, [-0.45, 0.45], args=tuple(popt), factor=0.1)
        opening = edges[1] - edges[0]
        df = self.getDataFrame(purge=False)
        openingPC = abs(opening) / \
            (df['time'].iloc[-1] - df['time'].iloc[0])
        return popt, pcov, edges, opening, openingPC

    def plotFitCurve(self, ax, fontsize=6):
        # get the opening at 1e-12
        opt12, cor12, o12, o12opening, o12openingPC = self.getOpening(1e-12)

        # fit and plot the fit_curve
        poptpl, pcovpl = self.fitPurgeLog()
        df = self.getDataFrame(purge=False)
        ax.plot(df['time'], BER(df['time'], *poptpl), '--', color=green)

        ax.text(
            0.1, 0.7,
            'delta@1e-12 ' + str(format(o12[0] - o12[1], '.2f')),
            fontsize=fontsize, transform=ax.transAxes)
        ax.text(
            0.1, 0.9,
            'pc@1e-12 ' + str(format(np.abs(o12[0] - o12[1]), '.2f')),
            fontsize=fontsize, transform=ax.transAxes)

        ax.set_yscale('log')
        ax.set_ylim([10e-13, 1])
        ax.tick_params(labelsize=10)

        return poptpl, pcovpl

    def isAccepted(self, thr=0.30, precision=1e-12):
        opt, cor, oedges, opening, openingPC = self.getOpening(precision)
        if openingPC < thr:
            return False
        else:
            return True
