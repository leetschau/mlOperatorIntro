---
title: "二次型系统的参数估计和异常检测"
output: html_notebook
---

二次型系统（[Quadratic form](https://en.wikipedia.org/wiki/Quadratic_form)）是只包含二次项，不包含常数和一次项的单变量或者多变量系统，例如下面分别是包含1, 2 和 3个特征变量的二次型系统：
$$
y = a x^2 \\
y = a x^2 + b xy + c y^2 \\
y = a x^2 + b y^2 + c z^2 + d xy + e xz + f yz
$$



# Python 实现

创建包含3个特征变量和一个响应变量的 **输入** dataframe:

```python
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

label = 'y'
features = 'x1,x2,x3'
data = pd.DataFrame(data=[x1, x2, x3, y]).T
```

实现公式生成函数，输入特征变量名称列表和向量变量名称，返回对应的二次型计算公式：

```python
def build_formula(label: str, features: str) -> str:
    featlist = features.split(',')
    quads = ' + '.join(map(lambda feat: 'I(' + feat + ' ** 2)', featlist))
    ints = ' + '.join(
        map(lambda feat_pair: 'I(%s * %s)' % (feat_pair[0], feat_pair[1]),
                 combinations(featlist, 2)))
    return "%s ~ %s + %s" % (label, quads, ints)

print(build_formula(label, features))
```

```
## y ~ I(x1 ** 2) + I(x2 ** 2) + I(x3 ** 2) + I(x1 * x2) + I(x1 * x3) + I(x2 * x3)
```

使用上面的测试数据，结合二次型生成函数，检验计算结果：

```python
res = sm.OLS.from_formula(build_formula(label, features), data=data).fit()
print(res.params)
```

```
## Intercept    -0.067936
## I(x1 ** 2)    2.889960
## I(x2 ** 2)    4.339385
## I(x3 ** 2)   -0.002966
## I(x1 * x2)    6.102414
## I(x1 * x3)    0.000976
## I(x2 * x3)    5.907165
## dtype: float64
```

```python
rst = OLSInfluence(res).summary_frame().student_resid
```

## Notes

本文档可通过在命令行中执行 `` 转换为 markdown 文档，尚不支持在 RStudio 环境中以交互方式执行。
