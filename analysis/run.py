import re
from datetime import datetime
import pandas as pd


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
        reg = re.search('(?<=Scan\ )[A-Za-z0-9]*', self.short_filename)
        if reg:
            self.dict['daughter_card'] = reg.group()
        reg = re.search('(?<=Tx)[0-9]*', self.short_filename)
        if reg:
            self.dict['tx'] = int(reg.group())
        reg = re.search('(?<=Rx)[0-9]*', self.short_filename)
        if reg:
            self.dict['rx'] = int(reg.group())
        # reg = re.search('(?<=Link\_)[0-9]*', self.short_filename)
        # if reg:
        #     self.dict['site'] = int(reg.group())
        reg = re.search('[0-9]*$', self.short_filename)
        if reg:
            self.dict['fibre_channel'] = int(reg.group())

        lines = [line.strip() for line in open(self.filename)]
        scan = False
        for i in range(len(lines)):
            if scan == True:
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
        if len(self.dict) == 0:
            self.loadFile()
        # Check if run already exits in collection
        if check_exists:
            query = {}
            count = collection.count_documents(query)
            if count:
                cursor = collection.find(query)
                exists = False
                for i in cursor:
                    i.pop('_id')
                    if i == self.dict:
                        return
        return collection.insert_one(self.dict)

    def getDataFrame(self):
        return pd.DataFrame(self.dict['data'])
