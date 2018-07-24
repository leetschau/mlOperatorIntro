状态转移矩阵
================

-   [功能和使用场景](#功能和使用场景)
-   [实例分析](#实例分析)
    -   [状态预测](#状态预测)
    -   [稳态向量](#稳态向量)

功能和使用场景
==============

状态转移矩阵，又称 [stochastic matrix](https://en.wikipedia.org/wiki/Stochastic_matrix), Markov matrix，是用于表示马尔可夫链（[Markov chain](https://en.wikipedia.org/wiki/Markov_chain)）状态转移的概率方阵，矩阵的每个元素是一个非负实数。按照在状态转移方程中出现的位置划分，可分为：

-   左随机矩阵：每列是一个概率向量（和为1）；

-   右随机矩阵：每行是一个概率向量（和为1）；

-   双随机矩阵：每行、每列和都是1；

马尔可夫链是当前状态仅依赖于上一时间点状态（无记忆，[Markov property](https://en.wikipedia.org/wiki/Markov_property)）的随机过程，由一组概率向量（状态向量）序列和一个随机矩阵组成，使得：

![
x\_1 = Px\_0, \\; x\_2 = Px\_1, \\; x\_3 = Px\_2, \\dots
](https://latex.codecogs.com/png.latex?%0Ax_1%20%3D%20Px_0%2C%20%5C%3B%20x_2%20%3D%20Px_1%2C%20%5C%3B%20x_3%20%3D%20Px_2%2C%20%5Cdots%0A "
x_1 = Px_0, \; x_2 = Px_1, \; x_3 = Px_2, \dots
")

用一阶差分方程描述上式：

![
x\_{k+1} = Px\_k, \\; k = 0,1,2,\\dots
](https://latex.codecogs.com/png.latex?%0Ax_%7Bk%2B1%7D%20%3D%20Px_k%2C%20%5C%3B%20k%20%3D%200%2C1%2C2%2C%5Cdots%0A "
x_{k+1} = Px_k, \; k = 0,1,2,\dots
")

![x](https://latex.codecogs.com/png.latex?x "x") 中的数值分别列出系统在 ![n](https://latex.codecogs.com/png.latex?n "n") 个可能状态中的概率，所以也叫状态向量。

任何具有无记忆特点的随机过程，都可以使用马尔可夫链建模，所以它在科学、商业和工业领域有着广泛的应用。

实例分析
========

状态预测
--------

某地区每年人口在城市和郊区间移动的转移矩阵 ![M](https://latex.codecogs.com/png.latex?M "M") 是：

![ M = \\left\[ \\begin{array} 00.95 && 0.03 \\\\ 0.05 && 0.97 \\end{array} \\right\] ](https://latex.codecogs.com/png.latex?%20M%20%3D%20%5Cleft%5B%20%5Cbegin%7Barray%7D%2000.95%20%26%26%200.03%20%5C%5C%200.05%20%26%26%200.97%20%5Cend%7Barray%7D%20%5Cright%5D%20 " M = \left[ \begin{array} 00.95 && 0.03 \\ 0.05 && 0.97 \end{array} \right] ")

即每年有5%的城市人口流动到郊区，有3%的郊区人口流动到城市。假设2018年此地区有城市人口60万，郊区人口40万，则2019年城市和郊区人口为：

``` r
M <- matrix(data = c(0.95, 0.05, 0.03, 0.97), nrow = 2)
p2018 <- c(600000, 400000)
M %*% p2018
```

    ##        [,1]
    ## [1,] 582000
    ## [2,] 418000

2020年城市和郊区人口是在2019年基础上再左乘迁移矩阵 ![M](https://latex.codecogs.com/png.latex?M "M")：

``` r
M %*% M %*% p2018
```

    ##        [,1]
    ## [1,] 565440
    ## [2,] 434560

稳态向量
--------

如果在一段时间内，多次迭代后，状态向量不再发生变化，则这时的状态向量叫做稳态向量，即：

![
Pq = q
](https://latex.codecogs.com/png.latex?%0APq%20%3D%20q%0A "
Pq = q
")

这里 ![q](https://latex.codecogs.com/png.latex?q "q") 就是状态转移矩阵 ![P](https://latex.codecogs.com/png.latex?P "P") 对应的稳态向量。

q的计算方法如下：

![
Px = x \\\\
\\to Px - x = 0 \\\\
\\to Px - Ix = 0 \\\\
\\to (P - I) x = 0
](https://latex.codecogs.com/png.latex?%0APx%20%3D%20x%20%5C%5C%0A%5Cto%20Px%20-%20x%20%3D%200%20%5C%5C%0A%5Cto%20Px%20-%20Ix%20%3D%200%20%5C%5C%0A%5Cto%20%28P%20-%20I%29%20x%20%3D%200%0A "
Px = x \\
\to Px - x = 0 \\
\to Px - Ix = 0 \\
\to (P - I) x = 0
")

这里 ![I](https://latex.codecogs.com/png.latex?I "I") 是与 ![P](https://latex.codecogs.com/png.latex?P "P") 相同行列数的单位矩阵。

由于 ![x](https://latex.codecogs.com/png.latex?x "x") 是概率向量，各个分量和为1，即 ![\\sum\_{i=1}^n x\_i = 1](https://latex.codecogs.com/png.latex?%5Csum_%7Bi%3D1%7D%5En%20x_i%20%3D%201 "\sum_{i=1}^n x_i = 1")，增加这一约束的方法是在矩阵 ![P-I](https://latex.codecogs.com/png.latex?P-I "P-I") 下加一行 ![1, \\dots, 1](https://latex.codecogs.com/png.latex?1%2C%20%5Cdots%2C%201 "1, \dots, 1")，同时在右侧0向量下面加值1。

以上面人口迁移为例，在迁移矩阵 ![M](https://latex.codecogs.com/png.latex?M "M") 不变的情况下，很多年以后城市和郊区的人口将趋于稳定，这时的人口比例是：

``` r
library(limSolve)
lsm <- rbind(M - diag(nrow(M)), rep(1, nrow(M)))
rsv <- c(rep(0, nrow(M)), 1)
q <- Solve(lsm, rsv)
q
```

    ## [1] 0.375 0.625

即 37.5% 的人在城市，62.5% 的人在郊区。

验证稳态向量：

``` r
M %*% q
```

    ##       [,1]
    ## [1,] 0.375
    ## [2,] 0.625

一次状态转换后状态向量的值不变，表明系统已进入稳态。
