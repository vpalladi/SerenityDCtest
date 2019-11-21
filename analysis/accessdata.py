import pymongo
from run import Run
from matplotlib import pyplot as plt
import seaborn as sns
# import plotly.express as px


def main():
    # Setup client to access database
    client = pymongo.MongoClient('mongodb://tjames-pc:27017/')
    # Select database
    db = client['test_db']
    # Select collection within database
    runs = db['runs']

    print("Number of documents: %d" % runs.estimated_document_count())
    # Run a find command to select a subset of documents
    query = {
        # 'daughter_card': 'DC0',
        # 'rx': 4
        'notes': {'$exists': True}
    }
    count = runs.count_documents(query)
    print("Number of documents in query: %d" % count)
    if count:
        cursor = runs.find(query)
        run = Run.fromDict(cursor[0])
        df = run.getDataFrame()
        sns.scatterplot(x='time', y='BER', data=df)
        plt.yscale('log')
        plt.ylim(1e-8, 1)
        plt.show()

        # fig = px.scatterplot(x=df.time, y=df.BER)
        # fig.update_layout(yaxis_type="log")
        # fig.show()
        # Print out the data within the first document
        # for i in cursor[0]:
        #     print(i, cursor[0][i])


if __name__ == '__main__':
    main()
