t检验方法介绍
================

# 功能和使用场景

使用场景：

  - 需要比较样本和总体，或者两个样本之间的数值型量是否有差异；

  - 总体方差未知；

  - 样本容量较小（\< 30）；

假设检验的原理和流程：

1.  定义零假设和备择假设；

2.  基于零假设确定 [抽样分布](https://en.wikipedia.org/wiki/Sampling_distribution)
    类型：例如正态分布、t分布、卡方分布；

3.  基于抽样值计算这个抽样出现的概率；

4.  比较上面得到的概率与事先指定的显著水平，如果前者小于后者，则拒绝零假设，否则无法拒绝零假设。

## 检验统计量

检验统计量（[test
statistic](https://en.wikipedia.org/wiki/Test_statistic)）是根据样本数据
(sample data) 计算得到的随机变量 (random variable)，它用在假设检验 (hypothesis test)
中。可以使用检验统计量来确定是否能否定零假设 (null hypothesis)。检验统计量可用于计算 p
值(p-value)。

## 判定方法

假设检验分为基于关键值的假设检验方法和基于p-value的假设检验方法，这两种方法得到的结果是一致的，区别在于采用哪个量作为判断依据。由于p-value在不同的分布下值的含义一致，所以使用更为普遍。

关键值（[critical
value](https://support.minitab.com/en-us/minitab/18/help-and-how-to/statistics/basic-statistics/supporting-topics/basics/what-is-a-critical-value/)）是检验统计量的边界，检验统计量超过这个边界则进入拒绝区（rejection
region），也就是否定零假设的区域。显著水平（significance level，一般用
![\\alpha](https://latex.codecogs.com/png.latex?%5Calpha "\\alpha")
表示）则是 p-value 的边界，如果 p-value 小于显著水平则拒绝零假设。

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

## 计算公式

单样本t检验计算公式：   
![
t = \\frac{\\bar x - \\mu\_0}{\\frac{s}{\\sqrt n}}
](https://latex.codecogs.com/png.latex?%0At%20%3D%20%5Cfrac%7B%5Cbar%20x%20-%20%5Cmu_0%7D%7B%5Cfrac%7Bs%7D%7B%5Csqrt%20n%7D%7D%0A
"
t = \\frac{\\bar x - \\mu_0}{\\frac{s}{\\sqrt n}}
")  

其中，![\\bar x](https://latex.codecogs.com/png.latex?%5Cbar%20x "\\bar x")
是样本均值，![\\mu\_0](https://latex.codecogs.com/png.latex?%5Cmu_0 "\\mu_0")
是总体均值，![s](https://latex.codecogs.com/png.latex?s "s") 是样本方差，
![n](https://latex.codecogs.com/png.latex?n "n") 是样本容量。

双样本t检验计算公式：   
![
t = \\frac{\\bar X\_1 - \\bar X\_2}{s\_p \\sqrt \\frac 2n}
](https://latex.codecogs.com/png.latex?%0At%20%3D%20%5Cfrac%7B%5Cbar%20X_1%20-%20%5Cbar%20X_2%7D%7Bs_p%20%5Csqrt%20%5Cfrac%202n%7D%0A
"
t = \\frac{\\bar X_1 - \\bar X_2}{s_p \\sqrt \\frac 2n}
")  

其中：   
![
s\_p = \\sqrt \\frac{s\_1^2 + s\_2^2}2
](https://latex.codecogs.com/png.latex?%0As_p%20%3D%20%5Csqrt%20%5Cfrac%7Bs_1%5E2%20%2B%20s_2%5E2%7D2%0A
"
s_p = \\sqrt \\frac{s_1^2 + s_2^2}2
")  

以上 ![\\bar X\_1, \\; \\bar
X\_2](https://latex.codecogs.com/png.latex?%5Cbar%20X_1%2C%20%5C%3B%20%5Cbar%20X_2
"\\bar X_1, \\; \\bar X_2") 是两个样本均值，![s\_1, \\;
s\_2](https://latex.codecogs.com/png.latex?s_1%2C%20%5C%3B%20s_2
"s_1, \\; s_2") 是两个样本方差，![n](https://latex.codecogs.com/png.latex?n "n")
是样本容量。

# 实例分析

## 单样本t检验

假设某学校一次数学考试中，全校平均分为75分，某班有30名学生，随机抽取10名学生分数如下： 65, 78, 88, 55, 48, 95,
66, 57, 79, 81，请问该班平均分是否与全校平均分存在显著差异？

![H\_0](https://latex.codecogs.com/png.latex?H_0 "H_0"): 与校平均分不存在显著差异；
![H\_1](https://latex.codecogs.com/png.latex?H_1 "H_1"): 与校平均分存在显著差异；

``` r
val <- c(65, 78, 88, 55, 48, 95, 66, 57, 79, 81)
t.test(val, mu = 75)
```

    ## 
    ##  One Sample t-test
    ## 
    ## data:  val
    ## t = -0.78303, df = 9, p-value = 0.4537
    ## alternative hypothesis: true mean is not equal to 75
    ## 95 percent confidence interval:
    ##  60.22187 82.17813
    ## sample estimates:
    ## mean of x 
    ##      71.2

t检验的计算结果有两种解读方法，效果是一致的： 比较 t 值或者比较 p-value。

由于本例是双侧检验，异常区域总和5%，单侧2.5%，p值为 ![1 - 0.025
= 0.975](https://latex.codecogs.com/png.latex?1%20-%200.025%20%3D%200.975
"1 - 0.025 = 0.975")，所以t值为：

``` r
qt(0.975, 9)
```

    ## [1] 2.262157

这里 `qt` 第2个参数是自由度 ![n
- 1](https://latex.codecogs.com/png.latex?n%20-%201 "n - 1")。 由于 ![t =
-0.783](https://latex.codecogs.com/png.latex?t%20%3D%20-0.783
"t = -0.783")，小于 2.262，所以不能否定原假设。

p-value = 0.437 \> 0.05，也验证了上述论断，即该班的平均分与校平均分不存在显著差异。

## 双样本t检验

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
y2 <- rnorm(10, mean = 2)
t.test(x, y2)
```

    ## 
    ##  Welch Two Sample t-test
    ## 
    ## data:  x and y2
    ## t = -4.4443, df = 17.31, p-value = 0.0003416
    ## alternative hypothesis: true difference in means is not equal to 0
    ## 95 percent confidence interval:
    ##  -2.5562346 -0.9120134
    ## sample estimates:
    ## mean of x mean of y 
    ## 0.1322028 1.8663268

p-value 小于 0.05，所以拒绝零假设，两个总体均值不相等。

# 参数分析

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

# 参考文献

  - <https://stats.stackexchange.com/questions/45889/confused-about-region-of-rejection-vs-p-value>

  - <https://support.minitab.com/zh-cn/minitab/18/help-and-how-to/statistics/basic-statistics/supporting-topics/basics/what-is-a-test-statistic/>

  - <https://support.minitab.com/en-us/minitab-express/1/help-and-how-to/basic-statistics/inference/supporting-topics/basics/what-is-a-test-statistic/>

  - <https://statistics.berkeley.edu/computing/r-t-tests>

  - <https://support.minitab.com/en-us/minitab/18/help-and-how-to/statistics/basic-statistics/supporting-topics/basics/what-is-a-critical-value/>
