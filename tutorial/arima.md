基于ARIMA的时间序列分析和预测
================

-   [稳态时间序列](#稳态时间序列)
-   [自回归](#自回归)
-   [移动平均](#移动平均)
-   [ARIMA](#arima)
-   [典型场景分析](#典型场景分析)
-   [参考文献](#参考文献)

稳态时间序列
============

一个时间序列是*稳态*的 (stationary)，需要满足如下条件：

-   序列平均值不随时间变化；

-   序列的方差 (variance) 不随时间变化；

-   序列上距离相等的两组时间点上值的协方差 (covariance) 不随点的移动而变化；

稳态是预测时间序列的前提条件。

自回归
======

如果时间序列变量 ![y](https://latex.codecogs.com/png.latex?y "y") 在 时间点 ![t](https://latex.codecogs.com/png.latex?t "t") 上的值是过去 ![p](https://latex.codecogs.com/png.latex?p "p") 个时间点上值的线性组合，则 ![y](https://latex.codecogs.com/png.latex?y "y") 是 ![p](https://latex.codecogs.com/png.latex?p "p") 阶自回归的：

![
y\_t = \\delta + \\phi\_1 y\_{t-1} + \\phi\_2 y\_{t-2} + \\dots + \\phi\_p y\_{t-p} + \\epsilon\_t
](https://latex.codecogs.com/png.latex?%0Ay_t%20%3D%20%5Cdelta%20%2B%20%5Cphi_1%20y_%7Bt-1%7D%20%2B%20%5Cphi_2%20y_%7Bt-2%7D%20%2B%20%5Cdots%20%2B%20%5Cphi_p%20y_%7Bt-p%7D%20%2B%20%5Cepsilon_t%0A "
y_t = \delta + \phi_1 y_{t-1} + \phi_2 y_{t-2} + \dots + \phi_p y_{t-p} + \epsilon_t
")

其中 ![\\delta](https://latex.codecogs.com/png.latex?%5Cdelta "\delta") 可以理解为线性回归中的截距（intercept），![\\epsilon\_t](https://latex.codecogs.com/png.latex?%5Cepsilon_t "\epsilon_t") 是随机扰动。

移动平均
========

如果时间序列变量 ![y](https://latex.codecogs.com/png.latex?y "y") 在 时间点 ![t](https://latex.codecogs.com/png.latex?t "t") 上的值是当前以及过去 ![q](https://latex.codecogs.com/png.latex?q "q") 个时间点上随即扰动项的线性组合，则此时间序列是 ![q](https://latex.codecogs.com/png.latex?q "q") 阶移动平均的：

![
y\_t = \\mu + \\theta\_1 \\epsilon\_{t-1} + \\theta\_2 \\epsilon\_{t-2} + \\dots + \\theta\_q \\epsilon\_{t-q} + \\epsilon\_t
](https://latex.codecogs.com/png.latex?%0Ay_t%20%3D%20%5Cmu%20%2B%20%5Ctheta_1%20%5Cepsilon_%7Bt-1%7D%20%2B%20%5Ctheta_2%20%5Cepsilon_%7Bt-2%7D%20%2B%20%5Cdots%20%2B%20%5Ctheta_q%20%5Cepsilon_%7Bt-q%7D%20%2B%20%5Cepsilon_t%0A "
y_t = \mu + \theta_1 \epsilon_{t-1} + \theta_2 \epsilon_{t-2} + \dots + \theta_q \epsilon_{t-q} + \epsilon_t
")

 \# ARMA

满足![p](https://latex.codecogs.com/png.latex?p "p")阶自回归和![q](https://latex.codecogs.com/png.latex?q "q")阶移动平均的稳态时间序列可以表示为：

![
y\_t = \\delta + \\sum\_{i=1}^p \\phi\_i y\_{t-i} + \\sum\_{j=1}^q \\theta\_j \\epsilon\_{t-j} + \\epsilon\_t \\tag{1} \\label{1}
](https://latex.codecogs.com/png.latex?%0Ay_t%20%3D%20%5Cdelta%20%2B%20%5Csum_%7Bi%3D1%7D%5Ep%20%5Cphi_i%20y_%7Bt-i%7D%20%2B%20%5Csum_%7Bj%3D1%7D%5Eq%20%5Ctheta_j%20%5Cepsilon_%7Bt-j%7D%20%2B%20%5Cepsilon_t%20%5Ctag%7B1%7D%20%5Clabel%7B1%7D%0A "
y_t = \delta + \sum_{i=1}^p \phi_i y_{t-i} + \sum_{j=1}^q \theta_j \epsilon_{t-j} + \epsilon_t \tag{1} \label{1}
")

记为：

![
ARMA(p, q)
](https://latex.codecogs.com/png.latex?%0AARMA%28p%2C%20q%29%0A "
ARMA(p, q)
")

ARIMA
=====

为了能够处理非稳态时间序列，采用差分 (difference) 处理非稳态序列，直到它符合稳态条件。 一个非稳态时间序列经过 ![d](https://latex.codecogs.com/png.latex?d "d") 次差分后变为 ![ARMA(p, q)](https://latex.codecogs.com/png.latex?ARMA%28p%2C%20q%29 "ARMA(p, q)")，则这个时间序列记为：

![
ARIMA(p, d, q)
](https://latex.codecogs.com/png.latex?%0AARIMA%28p%2C%20d%2C%20q%29%0A "
ARIMA(p, d, q)
")

当 ![p, d, q](https://latex.codecogs.com/png.latex?p%2C%20d%2C%20q "p, d, q") 确定后，将时间序列代入式![\\eqref{1}](https://latex.codecogs.com/png.latex?%5Ceqref%7B1%7D "\eqref{1}")可确定模型参数。

典型场景分析
============

这里采用1871 ~ 1970年尼罗河水量作为输入数据创建ARIMA模型：

``` r
library(forecast)
plot(Nile)
```

![](arima_files/figure-markdown_github/unnamed-chunk-1-1.png)

``` r
mdl <- auto.arima(Nile)
summary(mdl)
```

    ## Series: Nile 
    ## ARIMA(1,1,1) 
    ## 
    ## Coefficients:
    ##          ar1      ma1
    ##       0.2544  -0.8741
    ## s.e.  0.1194   0.0605
    ## 
    ## sigma^2 estimated as 20177:  log likelihood=-630.63
    ## AIC=1267.25   AICc=1267.51   BIC=1275.04
    ## 
    ## Training set error measures:
    ##                     ME     RMSE      MAE       MPE     MAPE     MASE
    ## Training set -16.06603 139.8986 109.9998 -4.005967 12.78745 0.825499
    ##                     ACF1
    ## Training set -0.03228482

可知这是一个 (1,1,1) 阶ARIMA模型，![\\phi\_1 = 0.2544](https://latex.codecogs.com/png.latex?%5Cphi_1%20%3D%200.2544 "\phi_1 = 0.2544")，![\\theta\_1 = -0.8741](https://latex.codecogs.com/png.latex?%5Ctheta_1%20%3D%20-0.8741 "\theta_1 = -0.8741")，模型残差：

``` r
tsdisplay(residuals(mdl), lag.max=45, main='(1,1,1) Model Residuals')
```

![](arima_files/figure-markdown_github/unnamed-chunk-2-1.png)

可以看到残差基本符合标准正态分布，满足式![\\eqref{1}](https://latex.codecogs.com/png.latex?%5Ceqref%7B1%7D "\eqref{1}")中![\\epsilon](https://latex.codecogs.com/png.latex?%5Cepsilon "\epsilon")的要求。

基于上述参数可以预测未来5年（1971 ~ 1975）的尼罗河水量：

``` r
predict(mdl, 5)
```

    ## $pred
    ## Time Series:
    ## Start = 1971 
    ## End = 1975 
    ## Frequency = 1 
    ## [1] 816.1813 835.5596 840.4889 841.7428 842.0617
    ## 
    ## $se
    ## Time Series:
    ## Start = 1971 
    ## End = 1975 
    ## Frequency = 1 
    ## [1] 142.0455 151.9673 155.2215 157.3709 159.2623

参考文献
========

-   <https://www.analyticsvidhya.com/blog/2015/12/complete-tutorial-time-series-modeling/>

-   <https://rstudio-pubs-static.s3.amazonaws.com/345790_3c1459661736433382863ed19c30ea55.html>

-
