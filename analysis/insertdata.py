from glob import glob
import pymongo
import cProfile
import pstats
from run import Run


def main():
    client = pymongo.MongoClient('mongodb://tjames-pc:27017/')
    db = client['serenity_dc_testing']
    runs = db['runs']
    files = glob('data/20191106122731/DC0/*')
    print(len(files))
    for file in files:
        run = Run.fromFile(file)
        run.insertIntoCollection(runs)


def profile():
    cProfile.run('main()', 'restats')
    p = pstats.Stats('restats')
    print(p.strip_dirs().sort_stats(-1).print_stats())


if __name__ == '__main__':
    main()
