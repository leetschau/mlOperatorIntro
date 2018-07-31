t检验方法介绍
================

-   [功能和使用场景](#功能和使用场景)
    -   [检验统计量](#检验统计量)
    -   [判定方法](#判定方法)
-   [实例分析](#实例分析)
-   [参数分析](#参数分析)
-   [参考文献](#参考文献)

功能和使用场景
==============

假设检验的原理和流程：

1.  定义零假设和备择假设；

2.  基于零假设确定 [抽样分布](https://en.wikipedia.org/wiki/Sampling_distribution) 类型：例如正态分布、t分布、卡方分布；

3.  基于抽样值计算这个抽样出现的概率；

4.  比较上面得到的概率与事先指定的显著水平，如果前者小于后者，则拒绝零假设，否则无法拒绝零假设。

检验统计量
----------

检验统计量（[test statistic](https://en.wikipedia.org/wiki/Test_statistic)）是根据样本数据 (sample data) 计算得到的随机变量 (random variable)，它用在假设检验 (hypothesis test) 中。可以使用检验统计量来确定是否能否定零假设 (null hypothesis)。检验统计量可用于计算 p 值(p-value)。

判定方法
--------

假设检验分为基于关键值的假设检验方法和基于p-value的假设检验方法，这两种方法得到的结果是一致的，区别在于采用哪个量作为判断依据。由于p-value在不同的分布下值的含义一致，所以使用更为普遍。

关键值（[critical value](https://support.minitab.com/en-us/minitab/18/help-and-how-to/statistics/basic-statistics/supporting-topics/basics/what-is-a-critical-value/)）是检验统计量的边界，检验统计量超过这个边界则进入拒绝区（rejection region），也就是否定零假设的区域。显著水平（significance level，一般用 ![\\alpha](https://latex.codecogs.com/png.latex?%5Calpha "\alpha") 表示）则是 p-value 的边界，如果 p-value 小于显著水平则拒绝零假设。

检验统计量和p-value的具体值根据不同的抽样发生变化，关键值和显著水平则是在测试前规定好的，不随抽样的变化而变化。

在 R 语言中，正态分布使用 `pnorm()` 实现从关键值到显著水平的转换，使用 `qnorm()` 实现从显著水平到关键值的转换：

``` r
qnorm(0.95)
```

    ## [1] 1.644854

``` r
pnorm(1.645)
```

    ## [1] 0.9500151

``` r
pnorm(qnorm(0.95))
```

    ## [1] 0.95

t分布使用`pt()`, `qt()` 实现相应的转换（假设使用抽样容量为20的双样本测试）：

``` r
qt(0.95, df = 18)
```

    ## [1] 1.734064

``` r
pt(1.734, df = 18)
```

    ## [1] 0.9499942

这里 `df` 指自由度，对双样本测试，自由度的值是样本容量2倍减2。

随着样本容量的增加，t分布越来越趋近于正态分布，所以t统计量与z统计量的值越来越接近：

``` r
qt(0.95, df = 50)
```

    ## [1] 1.675905

``` r
pt(1.676, df = 50)
```

    ## [1] 0.9500094

实例分析
========

假设总体A和B都是标准正态分布，样本容量为10时，比较两个总体的均值是否一致。

由于样本容量小于30，用t检验比较：

``` r
set.seed(1)
x <- rnorm(10)
y <- rnorm(10)
t.test(x, y)
```

    ## 
    ##  Welch Two Sample t-test
    ## 
    ## data:  x and y
    ## t = -0.27858, df = 16.469, p-value = 0.784
    ## alternative hypothesis: true difference in means is not equal to 0
    ## 95 percent confidence interval:
    ##  -1.0022169  0.7689325
    ## sample estimates:
    ## mean of x mean of y 
    ## 0.1322028 0.2488450

p-value 大于 0.05，所以无法拒绝零假设（两个总体均值相等）。

将B总体改为均值为1，方差为1的正态分布，样本空间不变，再次比较两个总体均值是否相等。

``` r
y2 <- rnorm(10, mean = 1)
t.test(x, y2)
```

    ## 
    ##  Welch Two Sample t-test
    ## 
    ## data:  x and y2
    ## t = -1.8814, df = 17.31, p-value = 0.07684
    ## alternative hypothesis: true difference in means is not equal to 0
    ## 95 percent confidence interval:
    ##  -1.55623458  0.08798663
    ## sample estimates:
    ## mean of x mean of y 
    ## 0.1322028 0.8663268

p-value 小于 0.05，所以拒绝零假设，两个总体均值不相等。

参数分析
========

两个总体均值一致时，重复1000次抽样，每次抽样容量为10，错误预测的比率：

``` r
set.seed(1)
n <- 1000
sc <- 10
pa <- replicate(n, t.test(rnorm(sc), rnorm(sc))$p.value)
sum(pa < 0.05) / n
```

    ## [1] 0.05

两个总体均值不同时，重复上述过程，预测正确率：

``` r
pa <- replicate(n, t.test(rnorm(sc), rnorm(sc, mean = 1))$p.value)
sum(pa < 0.05) / n
```

    ## [1] 0.569

由于样本容量仅为10，这个结果是可以接受的。

要提高预测正确率，就要增加样本容量：

``` r
sc2 <- 40
pa <- replicate(n, t.test(rnorm(sc2), rnorm(sc2, mean = 1))$p.value)
sum(pa < 0.05) / n
```

    ## [1] 0.997

或者总体均值的差足够大：

``` r
pa <- replicate(n, t.test(rnorm(sc), rnorm(sc, mean = 2))$p.value)
sum(pa < 0.05) / n
```

    ## [1] 0.984

参考文献
========

-   <https://stats.stackexchange.com/questions/45889/confused-about-region-of-rejection-vs-p-value>

-   <https://support.minitab.com/zh-cn/minitab/18/help-and-how-to/statistics/basic-statistics/supporting-topics/basics/what-is-a-test-statistic/>

-   <https://support.minitab.com/en-us/minitab-express/1/help-and-how-to/basic-statistics/inference/supporting-topics/basics/what-is-a-test-statistic/>
