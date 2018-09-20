# 基于 Python 的算子实现情况

## 聚类分离孤立点

核心算法 LOF 和 DBSCAN 有 sklearn 包实现。

包级别：核心。

参考文献：

* [LOF example](http://scikit-learn.org/stable/auto_examples/neighbors/plot_lof.html)

* [sklearn.neighbors.LocalOutlierFactor](http://scikit-learn.org/stable/modules/generated/sklearn.neighbors.LocalOutlierFactor.html#sklearn.neighbors.LocalOutlierFactor)

* [sklearn.cluster.DBSCAN](http://scikit-learn.org/stable/modules/generated/sklearn.cluster.DBSCAN.html)

## 拟合分离孤立点

有 statsmodels 包实现。

包级别：核心。

参考文献：

* student_resid in [statsmodels.stats.outliers_influence.OLSInfluence.summary_frame](http://www.statsmodels.org/dev/generated/statsmodels.stats.outliers_influence.OLSInfluence.summary_frame.html)

* [Access standardized residuals, cook's values, hatvalues (leverage) etc. easily in Python?](https://stackoverflow.com/questions/46304514/access-standardized-residuals-cooks-values-hatvalues-leverage-etc-easily-i)

* [Raw residuals versus standardised residuals versus studentised residuals - what to use when?](https://stats.stackexchange.com/questions/22653/raw-residuals-versus-standardised-residuals-versus-studentised-residuals-what)

## 特征异常平滑

有 statsmodels 核心包实现。

包级别：核心。

参考文献：

* `hat_diag` in [statsmodels.stats.outliers_influence.OLSInfluence.summary_frame](http://www.statsmodels.org/dev/generated/statsmodels.stats.outliers_influence.OLSInfluence.summary_frame.html)

* [example in statsmodels](https://www.statsmodels.org/dev/examples/notebooks/generated/regression_plots.html)

## 相似度计算和排序

有 scipy 包实现。

包级别：核心。

参考文献：

[scipy.spatial.distance](https://docs.scipy.org/doc/scipy/reference/spatial.distance.html)

## 随机插补

有 numpy 包实现。

包级别：核心。

参考文献：

`random.standard_normal()`, `random.uniform()`.
See [NumPy for R users](http://mathesaurus.sourceforge.net/r-numpy.html) for details.

## 频谱分析和功率谱分析

有 SPECTRUM 包实现。

包级别：社区，目前维护状态良好，有文档和实例。

参考文献：

* [SPECTRUM : Spectral Analysis in Python](https://pypi.org/project/spectrum/)

* [numpy.fft.fft](https://docs.scipy.org/doc/numpy/reference/generated/numpy.fft.fft.html)

## 小波分析

有 PyWavelets 包实现。

包级别：社区，目前维护状态良好，文档和实例丰富。

参考文献：

[PyWavelets](https://pywavelets.readthedocs.io/en/latest/index.html)

## 二次型参数和系统分析

核心算法都有 sklearn 和 numpy 包实现。

包级别：核心。

参考文献：

* [Polynomial regression: extending linear models with basis functions](http://scikit-learn.org/stable/modules/linear_model.html#polynomial-regression-extending-linear-models-with-basis-functions)

* [numpy.polyfit](https://docs.scipy.org/doc/numpy/reference/generated/numpy.polyfit.html)

* [polynomial regression using python](https://stackoverflow.com/questions/31406975/polynomial-regression-using-python)
