特征异常平滑
================

-   [功能和使用场景](#功能和使用场景)
    -   [特征异常因子](#特征异常因子)
    -   [特征异常的判定规则](#特征异常的判定规则)
-   [参数分析](#参数分析)
-   [实例分析](#实例分析)

功能和使用场景
==============

特征异常因子
------------

特征异常 (high leverage) 指特征变量（独立变量）由于某些原因，例如仪器输出异常、录入错误等，取到了不合理的值。 从数值计算的角度看，异常特征值就是与该特征的平均值的差距超出了合理范围的值，实践中以与特征平均值的距离作为特征异常的衡量指标，距离越远，属于异常值的可能性就越高（ISL，式(3.37)）：

![
h\_i = \\frac1n + \\frac{(x\_i - \\bar x) ^ 2}{\\sum\_{j=1}^n(x\_j - \\bar x) ^ 2}
](https://latex.codecogs.com/png.latex?%0Ah_i%20%3D%20%5Cfrac1n%20%2B%20%5Cfrac%7B%28x_i%20-%20%5Cbar%20x%29%20%5E%202%7D%7B%5Csum_%7Bj%3D1%7D%5En%28x_j%20-%20%5Cbar%20x%29%20%5E%202%7D%0A "
h_i = \frac1n + \frac{(x_i - \bar x) ^ 2}{\sum_{j=1}^n(x_j - \bar x) ^ 2}
")

当 ![x\_i \\to \\bar x](https://latex.codecogs.com/png.latex?x_i%20%5Cto%20%5Cbar%20x "x_i \to \bar x") 时，![h\_i \\to \\frac1n](https://latex.codecogs.com/png.latex?h_i%20%5Cto%20%5Cfrac1n "h_i \to \frac1n")；

当![x\_i](https://latex.codecogs.com/png.latex?x_i "x_i") 与 特征平均值 ![\\bar x](https://latex.codecogs.com/png.latex?%5Cbar%20x "\bar x") 的差距较大时，![x\_i](https://latex.codecogs.com/png.latex?x_i "x_i") 对应的误差，![(x\_i - \\bar x) ^ 2](https://latex.codecogs.com/png.latex?%28x_i%20-%20%5Cbar%20x%29%20%5E%202 "(x_i - \bar x) ^ 2")，在误差总和，![\\sum\_{j=1}^n(x\_j - \\bar x) ^ 2](https://latex.codecogs.com/png.latex?%5Csum_%7Bj%3D1%7D%5En%28x_j%20-%20%5Cbar%20x%29%20%5E%202 "\sum_{j=1}^n(x_j - \bar x) ^ 2") 所占比重很大，![h\_i \\to 1](https://latex.codecogs.com/png.latex?h_i%20%5Cto%201 "h_i \to 1")，证明过程如下： 假设特征 ![X](https://latex.codecogs.com/png.latex?X "X") 包含 ![n](https://latex.codecogs.com/png.latex?n "n") 个观测，其中 ![n - 1](https://latex.codecogs.com/png.latex?n%20-%201 "n - 1") 个正常值取值均为 ![x\_1](https://latex.codecogs.com/png.latex?x_1 "x_1")，另有一个异常值 ![x\_2](https://latex.codecogs.com/png.latex?x_2 "x_2")，也就是说 ![x\_2](https://latex.codecogs.com/png.latex?x_2 "x_2") 对应的观测贡献了所有的误差。这时特征均值为：

![
\\bar x = \\frac{(n - 1) x\_1 + x\_2}{n}
](https://latex.codecogs.com/png.latex?%0A%5Cbar%20x%20%3D%20%5Cfrac%7B%28n%20-%201%29%20x_1%20%2B%20x_2%7D%7Bn%7D%0A "
\bar x = \frac{(n - 1) x_1 + x_2}{n}
")

则正常项（共 ![n - 1](https://latex.codecogs.com/png.latex?n%20-%201 "n - 1") 个）与均值的方差为（令 ![S = (x\_2 - x\_1) ^ 2](https://latex.codecogs.com/png.latex?S%20%3D%20%28x_2%20-%20x_1%29%20%5E%202 "S = (x_2 - x_1) ^ 2")）：

![
\\sigma\_n = (x\_1 - \\bar x) ^ 2 = (\\frac{x\_1 - x\_2}{n}) ^ 2 = \\frac{1}{n ^ 2} S
](https://latex.codecogs.com/png.latex?%0A%5Csigma_n%20%3D%20%28x_1%20-%20%5Cbar%20x%29%20%5E%202%20%3D%20%28%5Cfrac%7Bx_1%20-%20x_2%7D%7Bn%7D%29%20%5E%202%20%3D%20%5Cfrac%7B1%7D%7Bn%20%5E%202%7D%20S%0A "
\sigma_n = (x_1 - \bar x) ^ 2 = (\frac{x_1 - x_2}{n}) ^ 2 = \frac{1}{n ^ 2} S
")

异常值与均值的方差为：

![
\\sigma\_a = (x\_2 - \\bar x) ^ 2 = (\\frac{n - 1}{n} (x\_2 - x\_1)) ^ 2 = \\frac{(n - 1) ^ 2}{n ^ 2} S
](https://latex.codecogs.com/png.latex?%0A%5Csigma_a%20%3D%20%28x_2%20-%20%5Cbar%20x%29%20%5E%202%20%3D%20%28%5Cfrac%7Bn%20-%201%7D%7Bn%7D%20%28x_2%20-%20x_1%29%29%20%5E%202%20%3D%20%5Cfrac%7B%28n%20-%201%29%20%5E%202%7D%7Bn%20%5E%202%7D%20S%0A "
\sigma_a = (x_2 - \bar x) ^ 2 = (\frac{n - 1}{n} (x_2 - x_1)) ^ 2 = \frac{(n - 1) ^ 2}{n ^ 2} S
")

异常观测的 ![h](https://latex.codecogs.com/png.latex?h "h") 值为：

![
h\_a = \\frac1n + \\frac{\\sigma\_a}{(n - 1) \\sigma\_n + \\sigma\_a} \\\\
= \\frac1n + \\frac{\\frac{(n - 1) ^ 2}{n ^ 2} S}{\\frac{n - 1}{n ^ 2} S + \\frac{(n - 1) ^ 2}{n ^ 2} S} \\\\
= \\frac1n + \\frac{(n - 1) ^ 2}{n - 1 + (n - 1) ^ 2} \\\\
= 1
](https://latex.codecogs.com/png.latex?%0Ah_a%20%3D%20%5Cfrac1n%20%2B%20%5Cfrac%7B%5Csigma_a%7D%7B%28n%20-%201%29%20%5Csigma_n%20%2B%20%5Csigma_a%7D%20%5C%5C%0A%3D%20%5Cfrac1n%20%2B%20%5Cfrac%7B%5Cfrac%7B%28n%20-%201%29%20%5E%202%7D%7Bn%20%5E%202%7D%20S%7D%7B%5Cfrac%7Bn%20-%201%7D%7Bn%20%5E%202%7D%20S%20%2B%20%5Cfrac%7B%28n%20-%201%29%20%5E%202%7D%7Bn%20%5E%202%7D%20S%7D%20%5C%5C%0A%3D%20%5Cfrac1n%20%2B%20%5Cfrac%7B%28n%20-%201%29%20%5E%202%7D%7Bn%20-%201%20%2B%20%28n%20-%201%29%20%5E%202%7D%20%5C%5C%0A%3D%201%0A "
h_a = \frac1n + \frac{\sigma_a}{(n - 1) \sigma_n + \sigma_a} \\
= \frac1n + \frac{\frac{(n - 1) ^ 2}{n ^ 2} S}{\frac{n - 1}{n ^ 2} S + \frac{(n - 1) ^ 2}{n ^ 2} S} \\
= \frac1n + \frac{(n - 1) ^ 2}{n - 1 + (n - 1) ^ 2} \\
= 1
")

正常观测的 ![h](https://latex.codecogs.com/png.latex?h "h") 值为：

![
h\_n = \\frac1n + \\frac{\\sigma\_n}{(n - 1) \\sigma\_n + \\sigma\_a} \\\\
= \\frac1n + \\frac{\\frac{1}{n ^ 2} S}{\\frac{n - 1}{n ^ 2} S + \\frac{(n - 1) ^ 2}{n ^ 2} S} \\\\
= \\frac1n + \\frac{1}{n - 1 + (n - 1) ^ 2} \\\\
= \\frac1{n - 1}
](https://latex.codecogs.com/png.latex?%0Ah_n%20%3D%20%5Cfrac1n%20%2B%20%5Cfrac%7B%5Csigma_n%7D%7B%28n%20-%201%29%20%5Csigma_n%20%2B%20%5Csigma_a%7D%20%5C%5C%0A%3D%20%5Cfrac1n%20%2B%20%5Cfrac%7B%5Cfrac%7B1%7D%7Bn%20%5E%202%7D%20S%7D%7B%5Cfrac%7Bn%20-%201%7D%7Bn%20%5E%202%7D%20S%20%2B%20%5Cfrac%7B%28n%20-%201%29%20%5E%202%7D%7Bn%20%5E%202%7D%20S%7D%20%5C%5C%0A%3D%20%5Cfrac1n%20%2B%20%5Cfrac%7B1%7D%7Bn%20-%201%20%2B%20%28n%20-%201%29%20%5E%202%7D%20%5C%5C%0A%3D%20%5Cfrac1%7Bn%20-%201%7D%0A "
h_n = \frac1n + \frac{\sigma_n}{(n - 1) \sigma_n + \sigma_a} \\
= \frac1n + \frac{\frac{1}{n ^ 2} S}{\frac{n - 1}{n ^ 2} S + \frac{(n - 1) ^ 2}{n ^ 2} S} \\
= \frac1n + \frac{1}{n - 1 + (n - 1) ^ 2} \\
= \frac1{n - 1}
")

故可知异常特征值的 ![h](https://latex.codecogs.com/png.latex?h "h") 值大于正常值的 ![h](https://latex.codecogs.com/png.latex?h "h") 值，且随着观测数量的增加，差异不断升高，当 ![n \\to \\infty](https://latex.codecogs.com/png.latex?n%20%5Cto%20%5Cinfty "n \to \infty") 时，二者之差 ![\\to 1](https://latex.codecogs.com/png.latex?%5Cto%201 "\to 1")。

特征异常的判定规则
------------------

由于所有观测点的 ![h](https://latex.codecogs.com/png.latex?h "h") 值的平均值为 ![(p + 1) / n](https://latex.codecogs.com/png.latex?%28p%20%2B%201%29%20%2F%20n "(p + 1) / n")（这里 ![p](https://latex.codecogs.com/png.latex?p "p") 为模型中特征的数量，参考 ISL p98），一般取 ![(p + 1) / n](https://latex.codecogs.com/png.latex?%28p%20%2B%201%29%20%2F%20n "(p + 1) / n") 的倍数作为判断特征异常的阈值，超过这个值视为特征异常值。

异常特征虽然往往是由于错误导致的，但并不必然导致拟合错误，以单变量拟合为例，假设有数据集 ![y = 3 x + 1, \\; x \\in \[1, 2\]](https://latex.codecogs.com/png.latex?y%20%3D%203%20x%20%2B%201%2C%20%5C%3B%20x%20%5Cin%20%5B1%2C%202%5D "y = 3 x + 1, \; x \in [1, 2]")，对于观测点 ![(3, 10)](https://latex.codecogs.com/png.latex?%283%2C%2010%29 "(3, 10)")，虽然特征 ![3 \\notin \[1,2\]](https://latex.codecogs.com/png.latex?3%20%5Cnotin%20%5B1%2C2%5D "3 \notin [1,2]")，属于异常点，但并不影响拟合函数（![\\because 10 = 3 \\times 3 + 1](https://latex.codecogs.com/png.latex?%5Cbecause%2010%20%3D%203%20%5Ctimes%203%20%2B%201 "\because 10 = 3 \times 3 + 1")）。

参数分析
========

异常系数 ![k](https://latex.codecogs.com/png.latex?k "k") 通常取2或者3（参考 [Using Leverages to Help Identify Extreme x Values](https://onlinecourses.science.psu.edu/stat501/node/338/)）。

算子的 **输入** 是一个 dataframe，**输出** 是去掉异常点后的dataframe.

实例分析
========

算子的 \*\* 输入\*\* 是1974年 "Moter Trend US" 杂志选取的32款车型11个方面的性能指标形成的 `mtcars` 数据集：

``` r
dim(mtcars)
```

    ## [1] 32 11

``` r
rownames(mtcars)
```

    ##  [1] "Mazda RX4"           "Mazda RX4 Wag"       "Datsun 710"         
    ##  [4] "Hornet 4 Drive"      "Hornet Sportabout"   "Valiant"            
    ##  [7] "Duster 360"          "Merc 240D"           "Merc 230"           
    ## [10] "Merc 280"            "Merc 280C"           "Merc 450SE"         
    ## [13] "Merc 450SL"          "Merc 450SLC"         "Cadillac Fleetwood" 
    ## [16] "Lincoln Continental" "Chrysler Imperial"   "Fiat 128"           
    ## [19] "Honda Civic"         "Toyota Corolla"      "Toyota Corona"      
    ## [22] "Dodge Challenger"    "AMC Javelin"         "Camaro Z28"         
    ## [25] "Pontiac Firebird"    "Fiat X1-9"           "Porsche 914-2"      
    ## [28] "Lotus Europa"        "Ford Pantera L"      "Ferrari Dino"       
    ## [31] "Maserati Bora"       "Volvo 142E"

下面选取其中 汽缸数 和 百英里油耗 两个特征，**参数** 取 ![k = 2](https://latex.codecogs.com/png.latex?k%20%3D%202 "k = 2")，通过 ![h](https://latex.codecogs.com/png.latex?h "h") 值分析其中的特征异常值：

``` r
mdl <- lm(hp ~ cyl + mpg, data = mtcars)
k <- 2
h.max <- k * (2 + 1) / nrow(mtcars)   # 2表示模型中包含2个特征变量: cyl 和 mpg
lev <- hatvalues(mdl)      # 计算数据集中每个观测的h值
plot(lev, type = 'h')
abline(h = h.max, col = 'red', lty = 2)
```

![](anomalyFeature_files/figure-markdown_github/unnamed-chunk-2-1.png)

筛选出 leverage 超出阈值的观测点：

``` r
rownames(mtcars[lev > h.max, ])
```

    ## [1] "Fiat 128"       "Toyota Corolla"

去掉 leverage 超出阈值的观测点，形成算子的 **输出**：

``` r
newcar <- mtcars[lev <= h.max, ]
dim(newcar)
```

    ## [1] 30 11

``` r
rownames(newcar)
```

    ##  [1] "Mazda RX4"           "Mazda RX4 Wag"       "Datsun 710"         
    ##  [4] "Hornet 4 Drive"      "Hornet Sportabout"   "Valiant"            
    ##  [7] "Duster 360"          "Merc 240D"           "Merc 230"           
    ## [10] "Merc 280"            "Merc 280C"           "Merc 450SE"         
    ## [13] "Merc 450SL"          "Merc 450SLC"         "Cadillac Fleetwood" 
    ## [16] "Lincoln Continental" "Chrysler Imperial"   "Honda Civic"        
    ## [19] "Toyota Corona"       "Dodge Challenger"    "AMC Javelin"        
    ## [22] "Camaro Z28"          "Pontiac Firebird"    "Fiat X1-9"          
    ## [25] "Porsche 914-2"       "Lotus Europa"        "Ford Pantera L"     
    ## [28] "Ferrari Dino"        "Maserati Bora"       "Volvo 142E"
