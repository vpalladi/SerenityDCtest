from analysis import databasing as db
from analysis import run
import pandas as pd
from matplotlib import pyplot as plt


def test_precision():
    r = db.query({})[0]
    prec = r.getPrecision()
    print(prec)
    assert type(prec) == float, "Precision is not a float."


def test_dataframe():
    r = db.query({})[0]
    df = r.getDataFrame().copy()
    print(df)
    assert type(df) == pd.DataFrame, \
        "No dataframe is being generated"


def test_fit():
    r = db.query({})[0]
    popt, pcov = r.fit()
    print(popt)
    print(pcov)
    assert popt.shape == (4,), "Output of fit is incorrect shape"


def test_fitPurge():
    r = db.query({})[0]
    popt, pcov = r.fitPurge()
    print(popt)
    print(pcov)
    assert popt.shape == (4,), "Output of fit is incorrect shape"


def test_fitPurgeLog():
    r = db.query({})[0]
    popt, pcov = r.fitPurgeLog()
    print(popt)
    print(pcov)
    assert popt.shape == (4,), "Output of fit is incorrect shape"
