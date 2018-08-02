卡方测试算法介绍
================

-   [功能和使用场景](#功能和使用场景)
-   [实例分析](#实例分析)
-   [与其他检验方法的关系](#与其他检验方法的关系)
-   [参考文献](#参考文献)

功能和使用场景
==============

卡方分布用来验证两个特征之间是否有关联。条件：各个特征需要是类型量。

![n](https://latex.codecogs.com/png.latex?n "n") 个彼此独立的正态总体的平方和服从自由度为 ![n](https://latex.codecogs.com/png.latex?n "n") 的卡方分布（证明过程：Modern Mathematical Statistics with Applications, 2nd edition, by Jay L. Devore, Section 6.4: Distributions based on a Normal Random Sample, The Chi-Squred Distribution 一节）。如果通过抽样检测发现样本在卡方分布下出现的概率小于显著水平，则可以证明前提不成立，即这些总体并不彼此独立，也就是说因素之间存在关联。

零假设：因素之间彼此独立；

备择假设：因素之间有关联；

实例分析
========

某制药公司研发了一款新药，并完成了临床双盲实验：参与测试的105人中，药物组50人，控制组55人，药物组中35人有效，15人无效，控制组26人有效，29人无效（完整测试结果保存在文件 *treatment.csv* 中）。问：此药物是否有效？

零假设：药物无效，即是否使用药物与是否康复之间没有关系；

备择假设：药物有效，即是否使用药物与是否康复之间有关系；

显著水平：这里取0.05；

计算当前样本在卡方分布下出现的概率：

``` r
inp <- read.csv2('treatment.csv', sep = ',')
chisq.test(inp$treatment, inp$improvement)
```

    ## 
    ##  Pearson's Chi-squared test with Yates' continuity correction
    ## 
    ## data:  inp$treatment and inp$improvement
    ## X-squared = 4.6626, df = 1, p-value = 0.03083

p-value 小于0.05，所以拒绝零假设，即药物对康复有效果。

与其他检验方法的关系
====================

场景1：需要比较两个样本的数值型量是否有差异：z检验或者t检验；

场景2：在场景1中，已知总体方差：使用z检验，否者使用t检验；

场景3：P判断两个因素之间是否存在关联使用卡方检验，处理的是类别型数据；

参考文献
========

-   <https://datascienceplus.com/chi-squared-test-in-r/>

-   <https://stats.stackexchange.com/questions/178854/a-b-tests-z-test-vs-t-test-vs-chi-square-vs-fisher-exact-test>
