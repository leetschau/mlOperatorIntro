z检验方法介绍
================

-   [功能和使用场景](#功能和使用场景)
    -   [使用场景：](#使用场景)
    -   [计算流程](#计算流程)
    -   [单边检验和双边检验](#单边检验和双边检验)
    -   [为什么零假设多采用等于的形式？](#为什么零假设多采用等于的形式)
-   [实例分析](#实例分析)
    -   [单样本单侧z检验](#单样本单侧z检验)
    -   [双样本单侧z检验](#双样本单侧z检验)
    -   [双样本双侧z检验](#双样本双侧z检验)
-   [参考文献](#参考文献)

功能和使用场景
==============

z检验是假设检验的一种，用于验证样本均值是否与总体的平均水平存在显著差异， 或者两个总体之间是否存在显著差异。

使用场景：
----------

-   样本容量应不小于30，否则使用t检验；

-   需要比较样本和总体，或者两个样本之间的数值型量是否有差异；

-   观测点彼此独立；

-   已知总体方差；

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

单边检验和双边检验
------------------

根据业务场景的具体需求确定使用单边还是双边检验，如果备择假设是“大于”或者“小于”，是单边检验，如果是“不等于”，属于双边检验。

备择假设的“方向性”决定了统计量的计算方法：对于相同的显著水平 ![alpha](https://latex.codecogs.com/png.latex?alpha "alpha")，取左侧、右侧还是双侧概率对应的统计量，与样本的计算结果对比。 在R中，左侧或者右侧是由 `lower.tail` 参数确定的，见下面的实例。

为什么零假设多采用等于的形式？
------------------------------

单边检验时，即使备择假设是 ![A &gt; B](https://latex.codecogs.com/png.latex?A%20%3E%20B "A > B")，基于最保守估计（*most conservative configuration*），零假设一般写为 ![A = B](https://latex.codecogs.com/png.latex?A%20%3D%20B "A = B")，而非 ![A \\le B](https://latex.codecogs.com/png.latex?A%20%5Cle%20B "A \le B")。

假设需要验证随机变量A是否大于随机变量B，单边检验场景下，将零假设写为 ![A = B](https://latex.codecogs.com/png.latex?A%20%3D%20B "A = B")，而不是![A \\le B](https://latex.codecogs.com/png.latex?A%20%5Cle%20B "A \le B") 的原因是，如果在 ![A = B](https://latex.codecogs.com/png.latex?A%20%3D%20B "A = B") 的假设下，抽样结果都显示为极小概率，则 ![A &lt; B](https://latex.codecogs.com/png.latex?A%20%3C%20B "A < B") 出现的概率只会更小，也就是说，对 ![A = B](https://latex.codecogs.com/png.latex?A%20%3D%20B "A = B") 的验证，已经包含了对 ![A \\lt B](https://latex.codecogs.com/png.latex?A%20%5Clt%20B "A \lt B") 的验证。

实例分析
========

单样本单侧z检验
---------------

某地区学生IQ测试平均成绩为100分，方差15。其中一所学校称本校学生平均IQ成绩高于地区平均水平，为了证明这一点，随机抽取了30个学生参加IQ测试，平均成绩112分。问：测试结果是否表明该校学生平均成绩高于地区平均水平？

1.  定义零假设：![H\_0: \\; \\mu = 100](https://latex.codecogs.com/png.latex?H_0%3A%20%5C%3B%20%5Cmu%20%3D%20100 "H_0: \; \mu = 100")

2.  定义备择假设：![H\_1: \\; \\mu \\gt 100](https://latex.codecogs.com/png.latex?H_1%3A%20%5C%3B%20%5Cmu%20%5Cgt%20100 "H_1: \; \mu \gt 100")

3.  定义 ![\\alpha](https://latex.codecogs.com/png.latex?%5Calpha "\alpha") 值：这里取 0.05；

4.  确定 ![\\alpha](https://latex.codecogs.com/png.latex?%5Calpha "\alpha") 值对应的 z-score：`qnorm(0.5, lower.tail = FALSE) = 1.645`（这里 `, lower.tail = FALSE` 表示取右侧概率值）；

5.  计算样本的 z-score：

``` r
z <- (112 - 100) / (15 / sqrt(30)); z
```

    ## [1] 4.38178

1.  ![z \\gt z\_0](https://latex.codecogs.com/png.latex?z%20%5Cgt%20z_0 "z \gt z_0")，表明在一次实验中出现了小概率事件（概率小于 ![\\alpha](https://latex.codecogs.com/png.latex?%5Calpha "\alpha")），表明零假设不合理。 所以此学校学生测试成绩确实高于地区平均成绩。

双样本单侧z检验
---------------

一种新镇静剂宣称可以降低病人的妄想倾向，其双盲对比实验结果如下： 药物组包含900个病人，妄想测试得分平均9.78，方差4.05，对照组包含1000个病人，测试得分平均15.10,方差4.28。问：从双盲对照测试结果，是否可以证明该镇静剂能够降低病人的妄想倾向？

1.  定义零假设：![H\_0: \\; \\mu\_1 = \\mu\_2](https://latex.codecogs.com/png.latex?H_0%3A%20%5C%3B%20%5Cmu_1%20%3D%20%5Cmu_2 "H_0: \; \mu_1 = \mu_2")

2.  定义备择假设：![H\_1: \\; \\mu\_1 \\lt \\mu\_2](https://latex.codecogs.com/png.latex?H_1%3A%20%5C%3B%20%5Cmu_1%20%5Clt%20%5Cmu_2 "H_1: \; \mu_1 \lt \mu_2")

3.  定义 ![\\alpha](https://latex.codecogs.com/png.latex?%5Calpha "\alpha") 值：这里取 0.05；

4.  确定 ![\\alpha](https://latex.codecogs.com/png.latex?%5Calpha "\alpha") 值对应的 z-score：`qnorm(0.5, lower.tail = TRUE) = -1.645`（这里 `, lower.tail = TRUE` 表示取左侧概率值）；

5.  计算样本的 z-score：

``` r
z <- (9.78 - 15.10 - 0) / sqrt(4.05 ^ 2 / 900 + 4.28 ^ 2 / 1000); z
```

    ## [1] -27.82961

1.  ![z \\lt z\_0](https://latex.codecogs.com/png.latex?z%20%5Clt%20z_0 "z \lt z_0")，表明基于零假设 ![\\mu\_1 = \\mu\_2](https://latex.codecogs.com/png.latex?%5Cmu_1%20%3D%20%5Cmu_2 "\mu_1 = \mu_2") 出现了小概率事件，即该药物确实降低了病人的妄想倾向（这里 ![z](https://latex.codecogs.com/png.latex?z "z") 的负值表示药物组的测试结果低于对照组的测试结果）。

双样本双侧z检验
---------------

上面的场景中，如果需要验证的是该镇静剂是否对妄想倾向产生影响（改善或者加重），则是一个双侧检验问题。

1.  定义零假设：![H\_0: \\; \\mu\_1 = \\mu\_2](https://latex.codecogs.com/png.latex?H_0%3A%20%5C%3B%20%5Cmu_1%20%3D%20%5Cmu_2 "H_0: \; \mu_1 = \mu_2")

2.  定义备择假设：![H\_1: \\; \\mu\_1 \\ne \\mu\_2](https://latex.codecogs.com/png.latex?H_1%3A%20%5C%3B%20%5Cmu_1%20%5Cne%20%5Cmu_2 "H_1: \; \mu_1 \ne \mu_2")

3.  定义 ![\\alpha](https://latex.codecogs.com/png.latex?%5Calpha "\alpha") 值：这里取 0.05；

4.  确定 ![\\alpha](https://latex.codecogs.com/png.latex?%5Calpha "\alpha") 值对应的 z-score：左边界![z\_1](https://latex.codecogs.com/png.latex?z_1 "z_1")：`qnorm(0.05/2, lower.tail = TRUE) = -1.96`，右边界![z\_2](https://latex.codecogs.com/png.latex?z_2 "z_2")：`qnorm(0.05/2, lower.tail = FALSE) = 1.96`；

5.  ![z = -27.83](https://latex.codecogs.com/png.latex?z%20%3D%20-27.83 "z = -27.83") 不变，有 ![z \\notin \[z\_1, z\_2\]](https://latex.codecogs.com/png.latex?z%20%5Cnotin%20%5Bz_1%2C%20z_2%5D "z \notin [z_1, z_2]")，零假设不成立，即药物对病人产生了效果。

参考文献
========

-   [Why does the Null Hypothesis have to be “equals to” and not “greater than or equal to”?](https://stats.stackexchange.com/questions/243212/why-does-the-null-hypothesis-have-to-be-equals-to-and-not-greater-than-or-equ)

-   [Stats: Hypothesis Testing](https://people.richland.edu/james/lecture/m170/ch09-def.html)

-   [WHAT ARE THE DIFFERENCES BETWEEN ONE-TAILED AND TWO-TAILED TESTS?](https://stats.idre.ucla.edu/other/mult-pkg/faq/general/faq-what-are-the-differences-between-one-tailed-and-two-tailed-tests/)
