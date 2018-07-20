自回归算法介绍
================

-   [功能和使用场景](#功能和使用场景)
-   [参数分析](#参数分析)
    -   [与 ARIMA 模型的比较](#与-arima-模型的比较)

功能和使用场景
==============

如果时间序列变量 ![y](https://latex.codecogs.com/png.latex?y "y") 在 时间点 ![t](https://latex.codecogs.com/png.latex?t "t") 上的值是过去 ![p](https://latex.codecogs.com/png.latex?p "p") 个时间点上值的线性组合，则 ![y](https://latex.codecogs.com/png.latex?y "y") 是 ![p](https://latex.codecogs.com/png.latex?p "p") 阶自回归（AR, [autoregression](https://en.wikipedia.org/wiki/Autoregressive_model)）的：

![
y\_t = \\delta + \\phi\_1 y\_{t-1} + \\phi\_2 y\_{t-2} + \\dots + \\phi\_p y\_{t-p} + \\epsilon\_t \\tag{1}
](https://latex.codecogs.com/png.latex?%0Ay_t%20%3D%20%5Cdelta%20%2B%20%5Cphi_1%20y_%7Bt-1%7D%20%2B%20%5Cphi_2%20y_%7Bt-2%7D%20%2B%20%5Cdots%20%2B%20%5Cphi_p%20y_%7Bt-p%7D%20%2B%20%5Cepsilon_t%20%5Ctag%7B1%7D%0A "
y_t = \delta + \phi_1 y_{t-1} + \phi_2 y_{t-2} + \dots + \phi_p y_{t-p} + \epsilon_t \tag{1}
")

其中 ![\\delta](https://latex.codecogs.com/png.latex?%5Cdelta "\delta") 可以理解为线性回归中的截距（intercept），![\\epsilon\_t](https://latex.codecogs.com/png.latex?%5Cepsilon_t "\epsilon_t") 是随机扰动。

使用AR预测时间序列时，要求该时间序列满足**稳态** (stationary) 条件，即：

-   序列平均值不随时间变化；

-   序列的方差 (variance) 不随时间变化；

-   序列上距离相等的两组时间点上值的协方差 (covariance) 不随点的移动而变化；

如果时间序列不满足稳态条件，可以使用（多次）差分的方法去掉序列中的低次项，再拟合AR模型。

参数分析
========

以1749年 ~ 1983年太阳黑子月度平均值为例，比较不同计算方法的预测精度。 首先以1982年12月为界切分训练和测试集：

``` r
dat.train <- window(sunspots, end = c(1982, 12))
dat.test <- window(sunspots, start = c(1983, 1))
head(dat.train)
```

    ## [1] 58.0 62.6 70.0 55.7 85.0 83.5

可以看到本算法的 <u>**输入**</u> 是一个从1749年1月开始的时间序列。

基于OLS（普通最小二乘法）方法拟合AR模型：

``` r
arols <- ar(dat.train, method = 'ols', aic = TRUE)  # 使用 ar 函数拟合自回归模型
arols$order
```

    ## [1] 27

``` r
arols$ar
```

    ## , , 1
    ## 
    ##                [,1]
    ##  [1,]  0.5414378229
    ##  [2,]  0.0965564823
    ##  [3,]  0.0799829199
    ##  [4,]  0.0857420314
    ##  [5,]  0.0418729244
    ##  [6,]  0.0475851983
    ##  [7,]  0.0118134900
    ##  [8,]  0.0097518708
    ##  [9,]  0.1041318686
    ## [10,]  0.0217767349
    ## [11,]  0.0189167132
    ## [12,]  0.0295782406
    ## [13,] -0.0204785213
    ## [14,]  0.0020156890
    ## [15,]  0.0487945288
    ## [16,] -0.0359099917
    ## [17,]  0.0001777813
    ## [18,] -0.0607147502
    ## [19,] -0.0016550797
    ## [20,] -0.0229896513
    ## [21,] -0.0410169973
    ## [22,] -0.0145181072
    ## [23,]  0.0566376808
    ## [24,] -0.0868409790
    ## [25,]  0.0685827766
    ## [26,] -0.0053030416
    ## [27,] -0.0542121149

这里 `arols$ar` 就是公式(1)中的系数向量 ![\\phi\_1 \\dots \\phi\_p](https://latex.codecogs.com/png.latex?%5Cphi_1%20%5Cdots%20%5Cphi_p "\phi_1 \dots \phi_p")。

在测试集上预测：

``` r
pred.ols <- predict(arols, n.ahead = 12)   # 预测1983年（即1982年未来12个月）的月度太阳黑子数
head(pred.ols$pred)
```

    ## [1] 113.39050  98.77344  95.80021  87.29361  85.56728  86.61145

可以看到算法的 <u>**输出**</u> 也是一个时间序列。

计算预测的平均绝对误差（MAE）：

``` r
mean(abs(pred.ols$pred - dat.test))
```

    ## [1] 20.48398

用 yule-walker 方法拟合模型：

``` r
aryule <- ar(dat.train, method = 'yule-walker', aic = TRUE)  # 使用 ar 函数拟合自回归模型
aryule$order
```

    ## [1] 28

``` r
aryule$ar
```

    ##  [1]  0.538194484  0.100464853  0.080441538  0.089843210  0.041546343
    ##  [6]  0.048549632  0.006811648  0.013561060  0.104697025  0.017755576
    ## [11]  0.009708008  0.031045754 -0.019368283  0.003185118  0.040478152
    ## [16] -0.036899151 -0.001175658 -0.061395821  0.005513374 -0.021050203
    ## [21] -0.041944661 -0.009183103  0.055462930 -0.075984579  0.066008508
    ## [26]  0.001198977 -0.038112179 -0.029596874

``` r
pred.yule <- predict(aryule, n.ahead = 12)   # 预测1983年（即1982年未来12个月）的月度太阳黑子数
```

计算预测的平均绝对误差（MAE）：

``` r
mean(abs(pred.yule$pred - dat.test))
```

    ## [1] 20.33955

这是一个28阶自回归模型，预测精度略好于 OLS 方法。

用 MLE 方法拟合模型并计算MAE：

``` r
armle <- ar(dat.train, method = 'mle', aic = TRUE)
armle$order
```

    ## [1] 12

``` r
armle$ar
```

    ##  [1]  0.5758343189  0.1194666720  0.0939762626  0.0912789440  0.0370708735
    ##  [6]  0.0501530192 -0.0080990234  0.0001348819  0.0811673768 -0.0040916511
    ## [11] -0.0188636112 -0.0569487048

``` r
pred.mle <- predict(armle, n.ahead = 12)
mean(abs(pred.mle$pred - dat.test))
```

    ## [1] 35.76016

这里 MLE 指 max likelihood estimation，即 [最大似然估计](https://zh.wikipedia.org/wiki/%E6%9C%80%E5%A4%A7%E4%BC%BC%E7%84%B6%E4%BC%B0%E8%AE%A1)，是一种参数估计方法，基于已有的样本，将产生这个样本概率最大的参数作为估计值。

基于 MLE 的模型阶数降为12，但 MAE 也出现了显著的升高（20.34 vs 35.76），在复杂度和精度间如何取舍，要根据业务需求以及计算资源限制来决定。

与 ARIMA 模型的比较
-------------------

``` r
library(forecast)
arm.mdl <- auto.arima(dat.train)   # 使用自动确定系数的 arima 方法构建 ARIMA 模型
summary(arm.mdl)
```

    ## Series: dat.train 
    ## ARIMA(2,1,2) 
    ## 
    ## Coefficients:
    ##          ar1      ar2      ma1     ma2
    ##       1.3432  -0.3937  -1.7688  0.8082
    ## s.e.  0.0309   0.0292   0.0211  0.0200
    ## 
    ## sigma^2 estimated as 243.3:  log likelihood=-11692.44
    ## AIC=23394.88   AICc=23394.9   BIC=23424.58
    ## 
    ## Training set error measures:
    ##                      ME     RMSE      MAE MPE MAPE      MASE        ACF1
    ## Training set 0.01325995 15.58358 11.01217 NaN  Inf 0.4795732 -0.01121674

``` r
pred.arm <- predict(arm.mdl, n.ahead = 12)
```

计算此模型的MAE:

``` r
mean(abs(pred.arm$pred - dat.test))
```

    ## [1] 36.25613

以 MAE 为评价指标，基于 OLS 的 AR 模型的预测精度高于 ARIMA模型（20.48 vs 36.26），但前者的模型复杂度显著高于后者（27 vs 2），也要通过业务需求和计算资源在复杂度和精度间做取舍。
