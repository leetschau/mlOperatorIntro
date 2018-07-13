贝叶斯估计
================

-   [功能和使用场景](#功能和使用场景)
-   [参数分析](#参数分析)
-   [实例分析](#实例分析)
-   [算法总结](#算法总结)
-   [参考文献](#参考文献)

功能和使用场景
==============

贝叶斯估计基于贝叶斯定义（[Bayes' theorem](https://en.wikipedia.org/wiki/Bayes%27_theorem)）先验概率（prior probability）计算出后验概率（posterior probability），在类别型特征彼此独立，或者数值型特征符合正态分布的条件下，贝叶斯估计可以得到理论上的最佳估计。

参数分析
========

贝叶斯估计只要指定特征列和响应值，没有其他参赛需要指定。

实例分析
========

下面是泰坦尼克号幸存者特征分析。

导入数据：

``` r
library(e1071)
Titanic_df <- as.data.frame(Titanic)
#Creating data from table
repeating_sequence <- rep.int(seq_len(nrow(Titanic_df)), Titanic_df$Freq) #This will repeat each combination equal to the frequency of each combination
#Create the dataset by row repetition created
Titanic_dataset <- Titanic_df[repeating_sequence,]
#We no longer need the frequency, drop the feature
Titanic_dataset$Freq <- NULL
```

使用贝叶斯估计拟合：

``` r
#Fitting the Naive Bayes model
Naive_Bayes_Model <- naiveBayes(Survived ~., data = Titanic_dataset)
Naive_Bayes_Model
```

    ## 
    ## Naive Bayes Classifier for Discrete Predictors
    ## 
    ## Call:
    ## naiveBayes.default(x = X, y = Y, laplace = laplace)
    ## 
    ## A-priori probabilities:
    ## Y
    ##       No      Yes 
    ## 0.676965 0.323035 
    ## 
    ## Conditional probabilities:
    ##      Class
    ## Y            1st        2nd        3rd       Crew
    ##   No  0.08187919 0.11208054 0.35436242 0.45167785
    ##   Yes 0.28551336 0.16596343 0.25035162 0.29817159
    ## 
    ##      Sex
    ## Y           Male     Female
    ##   No  0.91543624 0.08456376
    ##   Yes 0.51617440 0.48382560
    ## 
    ##      Age
    ## Y          Child      Adult
    ##   No  0.03489933 0.96510067
    ##   Yes 0.08016878 0.91983122

预测：

``` r
#Prediction on the dataset
NB_Predictions <- predict(Naive_Bayes_Model, Titanic_dataset)
#Confusion matrix to check accuracy
table(NB_Predictions, Titanic_dataset$Survived)
```

    ##               
    ## NB_Predictions   No  Yes
    ##            No  1364  362
    ##            Yes  126  349

算法总结
========

参考文献
========

-   [Understanding Naïve Bayes Classifier Using R](https://www.r-bloggers.com/understanding-naive-bayes-classifier-using-r/)

-   [Bayesian Estimation](https://onlinecourses.science.psu.edu/stat414/node/241/)
