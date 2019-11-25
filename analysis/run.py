
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

class Pin():
    def __init__(self, x, y):
        self.x = x
        self.y = y

class Link():

    def __init__(self, txQuad, rxQuad, txPin, rxPin, x=(np.array([])), y=(np.array([]))):
        self.txQuad = txQuad
        self.rxQuad = rxQuad
        self.txPin = Pin(int(re.sub(
            'Y[0-9]*', '', txPin).replace('X', '')), int(re.sub('X[0-9]*Y', '', txPin)))
        self.rxPin = Pin(int(re.sub(
            'Y[0-9]*', '', rxPin).replace('X', '')), int(re.sub('X[0-9]*Y', '', rxPin)))
        self.setXY(x, y)

    def setXY(self, x, y):
        self.x = x.copy()
        self.y = y.copy()
        self.yLog = np.array([np.log(y) for y in self.y])

        if(len(self.y) > 0):
            minY = min(self.y)

        self.xpurge = np.array([x for x, y in zip(self.x, self.y) if y > minY])
        self.ypurge = np.array([y for y in self.y if y > minY])
        self.ylogpurge = np.array([np.log(y) for y in self.ypurge])


#class BathTub():
#    def __init__(self, fileName, txPath, rxPath):
#
#        self.fileName = fileName
#        self.txPath = txPath
#        self.rxPath = rxPath
#
#        # get quads
#        txQuad = int(re.findall(
#            'Quad_[0-9]*', self.txPath)[0].replace('Quad_', ''))
#        rxQuad = int(re.findall(
#            'Quad_[0-9]*', self.rxPath)[0].replace('Quad_', ''))
#        txQuadPin = re.findall(
#            'X[0-9]*Y[0-9]*', self.txPath)[0].replace('Quad_', '')
#        rxQuadPin = re.findall(
#            'X[0-9]*Y[0-9]*', self.rxPath)[0].replace('Quad_', '')
#
#        # get the data
#        self.data = Link(
#            txQuad,
#            rxQuad,
#            txQuadPin,
#            rxQua`dPin
#        )
#
#        # read the csv file
#        csvFile = open(self.fileName)
#        csvReader = csv.reader(csvFile)
#
#        rows = [r for r in csvReader]
#
#        # DC = 0/1
#        self.dcId = int(re.findall(
#            'DC[0-9]*', self.fileName)[0].replace('DC', '').split(' ')[0])
#        # Connector ID = Rx0/Tx0 Rx1/Tx1....
#        self.txConnectorId = int(re.findall(
#            'Tx[0-9]*', self.fileName)[0].replace('Tx', ''))
#        self.rxConnectorId = int(re.findall(
#            'Rx[0-9]*', self.fileName)[0].replace('Rx', ''))
#        # fiber channel ID = 0-11
#        # print(self.fileName)
#        self.txFiberId = int(re.findall(
#            'tx[0-9]*', self.fileName)[0].replace('tx', ''))
#        self.rxFiberId = int(re.findall(
#            'rx[0-9]*', self.fileName)[0].replace('rx', ''))
#
#        for r in rows:
#
#            if r[0] == 'Scan Name':
#                self.title = str(self.data.txQuad) + '_X' + \
#                             str(self.data.txPin.x) + 'Y' + \
#                             str(self.data.txPin.y) + '->X' + \
#                             str(self.data.rxPin.x) + 'Y' + \
#                             str(self.data.rxPin.y)
#
#            if r[0] == 'Dwell BER':
#                self.dwellBER = float(r[-1])
#            if r[0] == 'Horizontal Percentage':
#                self.horizontalPercentage = float(r[-1])
#            if r[0] == 'Horizontal Opening':
#                self.horizontalOpening = float(r[-1])
#
#        tmp = np.array([[float(x), float(y)]
#                        for x, y in zip(rows[19][1:], rows[20][1:])])
#
#        self.data.setXY(tmp[:, 0], tmp[:, 1])
#
#        if debug:
#            print('self.filename', self.fileName)
#            print('len(self.x   )', len(self.x))
#            print('len(self.y   )', len(self.y))
#            print('len(self.ylog)', len(self.ylog))
#            print('len(self.xpurge   )', len(self.xpurge))
#            print('len(self.ypurge   )', len(self.ypurge))
#            print('len(self.ylogpurge)', len(self.ylogpurge))


class Run:
    def __init__(self):
        self.dict = {}

    @classmethod
    def fromFile(cls, filename):
        r = cls()
        r.loadFile(filename)
        return r

    @classmethod
    def fromDict(cls, dictionary):
        r = cls()
        r.dict = dictionary
        return r

    def loadFile(self, filename):

        self.filename = filename

        self.dict['baseBoard']      = re.findall( 'Serenity-[0-9]+',self.filename )[0] 
        self.dict['site']           = int( re.findall( 'site[0-9]+',self.filename )[0].replace('site','') )
        self.dict['DC']             = re.findall( 'DC[0-9]+',self.filename )[0]
        self.dict['TXconnector']    = re.findall( 'Tx[0-9]+',self.filename )[0]
        self.dict['RXconnector']    = re.findall( 'Rx[0-9]+',self.filename )[0]
        self.dict['connectionType'] = re.findall( '_[a-z]+:',self.filename )[0].replace(':','').replace('_','')
        self.dict['txChId']         = re.findall( 'tx[0-9]+',self.filename )[0]
        self.dict['rxChId']         = re.findall( 'rx[0-9]+',self.filename )[0]

        ### read the csv file
        csvFile = open(self.filename)
        csvReader = csv.reader(csvFile)
        rows_iter = iter( [r for r in csvReader] )

        for row in rows_iter :
            if row[0] == 'Scan Start':
                next(rows_iter)
                time = [int(j) for j in row[1:] ]
                next(rows_iter)
                BER =  [float(j) for j in row[1:]]
                self.dict['data'] = {
                    'time': time,
                    'BER': BER
                }
                break
            else:
                try:
                    self.dict[ row[0] ] = int( row[1], 10 )
                except ValueError:
                    try:
                        self.dict[ row[0] ] = float( row[1] )
                    except ValueError:
                        self.dict[ row[0] ] = row[1]
        
        self.dict['start'] = datetime.strptime(
            self.dict.pop('Date and Time Started'),
            '%Y-%b-%d %H:%M:%S'
        )
        self.dict['end'] = datetime.strptime(
            self.dict.pop('Date and Time Ended'),
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

    def getDataFrame(self, purge=False):
        if purge:
            if hasattr(self, 'purgedf'):
                return self.purgedf
        else:
            if hasattr(self, 'df'):
                return self.df
        if not hasattr(self, 'df'):
            self.df = pd.DataFrame(self.dict['data'])
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
        start = (1, -27, 25, 1.2)
        self.popt, self.pcov = curve_fit(BERlog, df['time'].values, df['logBER'].values, p0=start)
        return self.popt, self.pcov

    def getOpening(self, BERvalue):
        popt, pcov = self.fitPurgeLog()
        popt = np.append(popt, -np.log(BERvalue))
        edges = fsolve(BERlogShift, [-20, 20], args=tuple(popt), factor=0.1)
        opening = edges[1] - edges[0]
        df = self.getDataFrame(purge=False)
        openingPC = abs(opening) / \
            (df['time'].iloc[-1] - df['time'].iloc[0])
        return popt, pcov, edges, opening, openingPC

    def plotFitCurve(self, ax, fontsize=6):
        # opt8, cor8, o8, o8opening, o8openingPC = self.getOpening(1e-8)
        opt12, cor12, o12, o12opening, o12openingPC = self.getOpening(1e-12)

        # fit and plot the fit_curve
        poptpl, pcovpl = self.fitPurgeLog()
        df = self.getDataFrame(purge=False)
        ax.plot(df['time'], BER(df['time'], *poptpl), '--', color=green)

        # text lables
        # ax.set_title(self.title, pad=-2, fontdict={'fontsize': fontsize})

        ax.text(
            0.1, 0.7,
            'delta@1e-12 ' + str(format(o12[0] - o12[1], '.2f')),
            fontsize=fontsize, transform=ax.transAxes)
        ax.text(
            0.1, 0.9,
            'pc@1e-12 ' + str(format(np.abs(o12[0] - o12[1])/64, '.2f')),
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
