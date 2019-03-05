from sklearn.preprocessing import PolynomialFeatures
from sklearn.linear_model import LinearRegression
from sklearn.pipeline import Pipeline
import pandas as pd
import numpy as np
import statsmodels.api as sm
from statsmodels.stats.outliers_influence import OLSInfluence
import matplotlib.pyplot as plt
import seaborn as sns
sns.set(style="darkgrid")

n = 200
x1 = np.random.uniform(-10, 10, n)
x2 = np.random.uniform(-4, 4, n)
y = 2.89 * x1 ** 2 + 4.33 * x2 ** 2 + 6.1 * x1 * x2 + np.random.normal(size=n)

X = pd.DataFrame(data=[x1, x2]).T
data = pd.DataFrame(data=[x1, x2, y]).T

pl = Pipeline([('poly', PolynomialFeatures(degree=2)),
                  ('linear', LinearRegression(fit_intercept=True, normalize=True, copy_X=True))])

model = pl.fit(X, y)
print(model.named_steps['linear'].coef_)


res = sm.OLS(y, X).fit()
print(res.summary())

res = sm.OLS.from_formula('y ~ I(x1 ** 2) + I(x1 * x2) + I(x2 ** 2)', data=data).fit()
rst = OLSInfluence(res).summary_frame().student_resid

#%%

from itertools import combinations
from typing import List
def build_formula(label: str, features: List[str]) -> List[str]:
    quads = ' + '.join(map(lambda feat: 'I(' + feat + ' ** 2)', features))
    ints = ' + '.join(
        map(lambda feat_pair: 'I(%s * %s)' % (feat_pair[0], feat_pair[1]),
                 combinations(features, 2)))
    return "%s ~ %s + %s" % (label, quads, ints)

label = 'y'
features = 'x1,x2'

formula = build_formula(label, features.split(','))

res = sm.OLS.from_formula(formula, data=data).fit()
print(res.params)
rst = OLSInfluence(res).summary_frame().student_resid
