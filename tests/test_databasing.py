from analysis import databasing as db
from analysis import run as r


def test_connectivity():
    db.init()


def test_query():
    q = db.query({})
    if len(q) > 0:
        assert type(q[0]) == r.Run, "Query is not returning Run objects"
