相似度计算与排序介绍
================

-   [功能和使用场景](#功能和使用场景)
-   [参数分析](#参数分析)
-   [实例分析](#实例分析)
-   [相似度排序](#相似度排序)

功能和使用场景
==============

观测的相似度计算广泛应用于机器学习的各类算法中，例如分类（随即森林）、聚类（K-Means）等，用于比较不同观测间差异的大小。

相似度通过距离来量化，常用的距离有欧氏距离和曼哈顿距离等，欧氏距离是欧氏几何空间中两点间的直线距离：

![ d(p, q) = \\sqrt{\\sum^{n}\_{i = 1}(p\_i - q\_i) ^ 2} ](https://latex.codecogs.com/png.latex?%20d%28p%2C%20q%29%20%3D%20%5Csqrt%7B%5Csum%5E%7Bn%7D_%7Bi%20%3D%201%7D%28p_i%20-%20q_i%29%20%5E%202%7D%20 " d(p, q) = \sqrt{\sum^{n}_{i = 1}(p_i - q_i) ^ 2} ")

曼哈顿距离是两点间沿坐标轴方向距离绝对值的和：

![ d(p, q) = \\sum^n\_{i = 1} \\vert p\_i - q\_i \\vert ](https://latex.codecogs.com/png.latex?%20d%28p%2C%20q%29%20%3D%20%5Csum%5En_%7Bi%20%3D%201%7D%20%5Cvert%20p_i%20-%20q_i%20%5Cvert%20 " d(p, q) = \sum^n_{i = 1} \vert p_i - q_i \vert ")

参数分析
========

算子的 **参数** 是距离计算方法的名称（类型为字符串），例如 "euclidean", "manhattan" 等。

算子的 **输入** 是一个包含 ![n](https://latex.codecogs.com/png.latex?n "n") 行（![n](https://latex.codecogs.com/png.latex?n "n") 个观测）的 dataframe，相似度计算的目标是求出各个观测间的距离。

算子的 **输出** 是一个 ![n](https://latex.codecogs.com/png.latex?n "n") 阶方阵，其中第 ![i](https://latex.codecogs.com/png.latex?i "i") 行，第 ![j](https://latex.codecogs.com/png.latex?j "j") 列的元素是观测 ![i](https://latex.codecogs.com/png.latex?i "i") 和 ![j](https://latex.codecogs.com/png.latex?j "j") 间的距离。

实例分析
========

下面的代码演示了平面上4个点间的欧氏距离和曼哈顿距离。

``` r
inp <- matrix(c(2, 2, 4, 0, 1, 4, 3, 1), nrow = 4)
inp
```

    ##      [,1] [,2]
    ## [1,]    2    1
    ## [2,]    2    4
    ## [3,]    4    3
    ## [4,]    0    1

``` r
deu <- dist(inp, method = 'euclidean')
deu
```

    ##          1        2        3
    ## 2 3.000000                  
    ## 3 2.828427 2.236068         
    ## 4 2.000000 3.605551 4.472136

``` r
dman <- dist(inp, method = 'manhattan')
dman
```

    ##   1 2 3
    ## 2 3    
    ## 3 4 3  
    ## 4 2 5 6

Python实现：

``` python
import numpy as np
from scipy.spatial.distance import pdist
inp = np.array([[2,1],[2,4],[4,3],[0,1]])
deu = pdist(inp, 'euclidean')
print(deu)
```

    ## [3.         2.82842712 2.         2.23606798 3.60555128 4.47213595]

``` python
dman = pdist(inp, 'cityblock')
print(dman)
```

    ## [3. 4. 2. 3. 5. 6.]

可以看到 `pdist()` 的返回结果是一个一维数组，与上面 R 计算结果相比较不难发现， Python的计算结果与R计算结果在列方向上从左到右连在一起后的结果是一致的。

相似度排序
==========

相似度排序算子的 **输入** 包括两部分：

-   距离矩阵；

-   排序基准点的序号；

此算子没有参数。

算子 **输出** 是一个两列 dataframe，第一列是按距离从小到大排序后的序号，第二列是排序后的距离。

取上面4个点场景，以点3为基准，从小到大输出各个点的序号和到点3的距离。 首先输出距离矩阵：

``` r
d <- as.matrix(dman); d
```

    ##   1 2 3 4
    ## 1 0 3 4 2
    ## 2 3 0 3 5
    ## 3 4 3 0 6
    ## 4 2 5 6 0

指定基准点并排序，最后转换为按顺序排列的 dataframe:

``` r
target <- 3
ds <- sort(d[ ,target])  # 按基准点排序
# idx <- names(sort(ds))
# data.frame(index = idx, dist = ds)
data.frame(distance = ds)
```

    ##   distance
    ## 3        0
    ## 2        3
    ## 1        4
    ## 4        6

Python实现方法：确定基准观测后，使用循环依次组对，作为 `scipy.spatial.distance.cityblock` 或者 `scipy.spatial.distance.euclidean` 的参数计算出每个观测到基准点的距离，在输入 dataframe 新增“距离”列， 将距离计算结果保存在此列中，然后对此列排序。
