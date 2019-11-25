import pymongo
import json
from run import Run


config = { "hostname": "tjames-pc",
           "port": 27017,
           "database": "serenity_dc_testing",
           "collection": "runs"
       }


def init():
    client = pymongo.MongoClient(
        'mongodb://%s:%d/' % (config['hostname'], config['port']))
    db = client[config['database']]
    collection = db[config['collection']]
    return client, db, collection


def insertData(filename):
    client, db, runs = init()
    run = Run.fromFile(filename)
    return run.insertIntoCollection(runs)


def query(query_dict):
    client, db, runs = init()
    # Run a find command to select a subset of documents
    count = runs.count_documents(query_dict)
    if count:
        return [Run.fromDict(i) for i in runs.find(query_dict)]
