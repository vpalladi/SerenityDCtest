import re
from datetime import datetime
import pandas as pd
import numpy as np
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
        self.short_filename = self.filename[
            self.filename.rfind('/')+1:self.filename.rfind('.')].strip()
        reg = re.search('(?<=Scan )[A-Za-z0-9]*', self.short_filename)
        if reg:
            self.dict['daughter_card'] = reg.group()
        reg = re.search('(?<=Tx)[0-9]*', self.short_filename)
        if reg:
            self.dict['tx'] = int(reg.group())
        reg = re.search('(?<=Rx)[0-9]*', self.short_filename)
        if reg:
            self.dict['rx'] = int(reg.group())
        reg = re.search('[0-9]*$', self.short_filename)
        if reg:
            self.dict['fibre_channel'] = int(reg.group())

        lines = [line.strip() for line in open(self.filename)]
        scan = False
        for i in range(len(lines)):
            if scan is True:
                self.dict['data'] = {
                    'time': [int(j) for j in lines[i].split(',')[1:]],
                    'BER': [float(j) for j in lines[i+1].split(',')[1:]]
                }
                break
            if lines[i] == "Scan Start":
                scan = True
            else:
                line = lines[i].split(',')
                try:
                    self.dict[line[0]] = int(line[1], 10)
                except ValueError:
                    try:
                        self.dict[line[0]] = float(line[1])
                    except ValueError:
                        self.dict[line[0]] = line[1]
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
                        return
        return collection.insert_one(self.dict)

    def getDataFrame(self, purge=False):
        self.df = pd.DataFrame(self.dict['data'])
        if purge:
            self.purgedf = self.df[
                self.df['BER'] > self.df['BER'].min()].copy()
            self.purgedf['logBER'] = np.log(self.purgedf['BER'])
            return self.purgedf
        return self.df

    def getPrecision(self):
        return self.dict['Dwell BER']

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
        df = self.getDataFrame(purge=True)
        start = (1, -27, 25, 1.2)
        popt, pcov = curve_fit(BERlog, df['time'], df['logBER'], p0=start)
        return popt, pcov

    def getOpening(self, BERvalue):
        popt, pcov = self.fitPurgeLog()
        popt = np.append(popt, -np.log(BERvalue))
        edges = fsolve(BERlogShift, [-20, 20], args=tuple(popt), factor=0.1)
        opening = edges[1] - edges[0]
        openingPC = abs(opening) / \
            (self.df['time'].iloc[-1] - self.df['time'].iloc[0])
        return popt, pcov, edges, opening, openingPC
