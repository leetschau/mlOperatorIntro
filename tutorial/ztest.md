z检验方法介绍
================

-   [功能和使用场景](#功能和使用场景)
    -   [使用场景：](#使用场景)
    -   [计算流程](#计算流程)
-   [实例分析](#实例分析)
    -   [单样本z检验](#单样本z检验)
    -   [双样本z检验](#双样本z检验)

功能和使用场景
==============

z检验是假设检验的一种，用于验证样本均值是否与总体的平均水平存在显著性差异。

使用场景：
----------

-   样本容量应不小于30，否则使用t检验；

-   观测点彼此独立；

-   样本的抽取方式是平均分布的，即总体中的每个观测被抽取的概率是相等的；

-   不同样本组间的样本数量基本一致；

计算流程
--------

1.  定义零假设 ![H\_0](https://latex.codecogs.com/png.latex?H_0 "H_0")；

2.  定义备择假设 ![H\_1](https://latex.codecogs.com/png.latex?H_1 "H_1")；

3.  定义 ![\\alpha](https://latex.codecogs.com/png.latex?%5Calpha "\alpha") 值：默认值为0.05；

4.  确定 ![\\alpha](https://latex.codecogs.com/png.latex?%5Calpha "\alpha") 值对应的 z-score：![z\_0](https://latex.codecogs.com/png.latex?z_0 "z_0")；

5.  计算样本的 z-score：见式(1)；

6.  得到结论：若 ![|z| \\gt z\_0](https://latex.codecogs.com/png.latex?%7Cz%7C%20%5Cgt%20z_0 "|z| \gt z_0")，证明基于零假设出现了小概率事件，即零假设不成立，备择假设成立，否则表明现有样本数据无法证明零假设不成立。

单样本 z-score 计算公式：

![ z = \\frac{\\bar x - \\mu\_0}{\\sigma / \\sqrt n} \\tag{1}](https://latex.codecogs.com/png.latex?%20z%20%3D%20%5Cfrac%7B%5Cbar%20x%20-%20%5Cmu_0%7D%7B%5Csigma%20%2F%20%5Csqrt%20n%7D%20%5Ctag%7B1%7D " z = \frac{\bar x - \mu_0}{\sigma / \sqrt n} \tag{1}")

其中 ![\\bar x](https://latex.codecogs.com/png.latex?%5Cbar%20x "\bar x") 是样本均值，![\\mu\_0](https://latex.codecogs.com/png.latex?%5Cmu_0 "\mu_0") 是总体均值，![\\sigma](https://latex.codecogs.com/png.latex?%5Csigma "\sigma") 是总体方差，![n](https://latex.codecogs.com/png.latex?n "n") 是样本容量。

双样本 z-score 计算公式：

![
z = \\frac{(\\bar X\_1 - \\bar X\_2) - (\\mu\_1-\\mu\_2)}{\\sqrt{\\frac{\\sigma\_1^2}{n\_1} + \\frac{\\sigma\_2^2}{n\_2}}}
](https://latex.codecogs.com/png.latex?%0Az%20%3D%20%5Cfrac%7B%28%5Cbar%20X_1%20-%20%5Cbar%20X_2%29%20-%20%28%5Cmu_1-%5Cmu_2%29%7D%7B%5Csqrt%7B%5Cfrac%7B%5Csigma_1%5E2%7D%7Bn_1%7D%20%2B%20%5Cfrac%7B%5Csigma_2%5E2%7D%7Bn_2%7D%7D%7D%0A "
z = \frac{(\bar X_1 - \bar X_2) - (\mu_1-\mu_2)}{\sqrt{\frac{\sigma_1^2}{n_1} + \frac{\sigma_2^2}{n_2}}}
")

实例分析
========

单样本z检验
-----------

某地区学生IQ测试平均成绩为100分，方差15。其中一所学校称本校学生平均IQ成绩高于地区平均水平，为了证明这一点，随机抽取了30个学生参加IQ测试，平均成绩112分。问：测试结果是否表明该校学生平均成绩高于地区平均水平？

1.  定义零假设：![H\_0: \\; \\mu = 100](https://latex.codecogs.com/png.latex?H_0%3A%20%5C%3B%20%5Cmu%20%3D%20100 "H_0: \; \mu = 100")

2.  定义备择假设：![H\_1: \\; \\mu \\gt 100](https://latex.codecogs.com/png.latex?H_1%3A%20%5C%3B%20%5Cmu%20%5Cgt%20100 "H_1: \; \mu \gt 100")

3.  定义 ![\\alpha](https://latex.codecogs.com/png.latex?%5Calpha "\alpha") 值：这里取 0.05；

4.  确定 ![\\alpha](https://latex.codecogs.com/png.latex?%5Calpha "\alpha") 值对应的 z-score：![z\_0 = 1.645](https://latex.codecogs.com/png.latex?z_0%20%3D%201.645 "z_0 = 1.645")；

5.  计算样本的 z-score：

``` r
z <- (112 - 100) / (15 / sqrt(30)); z
```

    ## [1] 4.38178

1.  ![|z| \\gt z\_0](https://latex.codecogs.com/png.latex?%7Cz%7C%20%5Cgt%20z_0 "|z| \gt z_0")，表明在一次实验中出现了小概率事件（概率小于 ![\\alpha](https://latex.codecogs.com/png.latex?%5Calpha "\alpha")），表明零假设不合理。 所以此学校学生测试成绩确实高于地区平均成绩。

双样本z检验
-----------

一种新镇静剂宣称可以降低病人的妄想倾向，其双盲对比实验结果如下： 药物组包含900个病人，妄想测试得分平均9.78，方差4.05，对照组包含1000个病人，测试得分平均15.10,方差4.28。问：从双盲对照测试结果，是否可以证明该镇静剂能够降低病人的妄想倾向？

1.  定义零假设：![H\_0: \\; \\mu\_1 = \\mu\_2](https://latex.codecogs.com/png.latex?H_0%3A%20%5C%3B%20%5Cmu_1%20%3D%20%5Cmu_2 "H_0: \; \mu_1 = \mu_2")

2.  定义备择假设：![H\_1: \\; \\mu\_1 \\ne \\mu\_2](https://latex.codecogs.com/png.latex?H_1%3A%20%5C%3B%20%5Cmu_1%20%5Cne%20%5Cmu_2 "H_1: \; \mu_1 \ne \mu_2")

3.  定义 ![\\alpha](https://latex.codecogs.com/png.latex?%5Calpha "\alpha") 值：这里取 0.05；

4.  确定 ![\\alpha](https://latex.codecogs.com/png.latex?%5Calpha "\alpha") 值对应的 z-score：![z\_0 = 1.645](https://latex.codecogs.com/png.latex?z_0%20%3D%201.645 "z_0 = 1.645")；

5.  计算样本的 z-score：

``` r
z <- (9.78 - 15.10 - 0) / sqrt(4.05 ^ 2 / 900 + 4.28 ^ 2 / 1000); z
```

    ## [1] -27.82961

1.  ![|z| \\gt z\_0](https://latex.codecogs.com/png.latex?%7Cz%7C%20%5Cgt%20z_0 "|z| \gt z_0")，表明基于零假设 ![\\mu\_1 = \\mu\_2](https://latex.codecogs.com/png.latex?%5Cmu_1%20%3D%20%5Cmu_2 "\mu_1 = \mu_2") 出现了小概率事件，即该药物确实降低了病人的妄想倾向（这里 ![z](https://latex.codecogs.com/png.latex?z "z") 的负值表示药物组的测试结果低于对照组的测试结果）。
