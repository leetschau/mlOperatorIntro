import pandas as pd
import numpy as np
from itertools import combinations
import statsmodels.api as sm
from statsmodels.stats.outliers_influence import OLSInfluence

n = 200
x1 = np.random.uniform(-10, 10, n)
x2 = np.random.uniform(-4, 4, n)
x3 = np.random.uniform(-2, 8, n)
y = 2.89 * x1 ** 2 + 4.33 * x2 ** 2 + 6.1 * x1 * x2 + 5.9 * x2 * x3 + np.random.normal(size=n)

data = pd.DataFrame(data=[x1, x2, y]).T

def build_formula(label: str, features: str) -> str:
    featlist = features.split(',')
    quads = ' + '.join(map(lambda feat: 'I(' + feat + ' ** 2)', featlist))
    ints = ' + '.join(
        map(lambda feat_pair: 'I(%s * %s)' % (feat_pair[0], feat_pair[1]),
                 combinations(featlist, 2)))
    return "%s ~ %s + %s" % (label, quads, ints)

label = 'y'
features = 'x1,x2,x3'

formula = build_formula(label, features)

res = sm.OLS.from_formula(formula, data=data).fit()
print(res.params)
rst = OLSInfluence(res).summary_frame().student_resid
