#' ---
#' title: "基于学生成绩表的 LR 系数解析"
#' author: "大数据-李超"
#' date: "2021-05-02"
#' output:
#'   html_document:
#'     fig_caption: yes
#'     highlight: haddock
#'     number_sections: yes
#'     theme: united
#'     toc: yes
#'     toc_depth: 6
#'     toc_float:
#'       collapsed: true
#'       smooth_scroll: false
#' ---

#' 本文是 UCLA 文章 [HOW DO I INTERPRET ODDS RATIOS IN LOGISTIC REGRESSION?][1] 的解读，
#' 对 Logistic Regression 进行了精彩的分析。
#'
#'
#' 一个年级 200 名学生，151 人在普通班，49 人在提高班 (honors class)：

library(tidyverse)
library(glue)
inp <- read_delim('students-sample.csv', delim =',', col_types = "fiiifi")
inp %>% filter(hon == 1) %>% glimpse
inp %>% filter(hon == 0) %>% glimpse

#' 业务场景：
#' 某个学生的各项特征是如何影响他在不在提高班里的？
#'
#' # Logit Function

#' $$ logit(p) = \log\left(\frac{p}{1 - p} \right) $$

#' 其中 $p$ 是一个学生在提高班（响应变量 *hon* 取 1）的概率，它们的值域为：

#' $$ p \in 0, 1 \\
#' \text{odds} = \frac{p}{1 - p} \in 0, +\infty \\
#' logit(p) \in -\infty, +\infty $$

#' 用 logit 代替概率的好处是：
#'
#' * 取值范围从 (0, 1) 变为 $(-\infty, +\infty)$，更方便数据处理
#' * logit 与 概率变化方向相同，便于理解其含义
#'
#' # Logistic Regression without Predictor Variables
#'
#' 不考虑任何影响因素的情况下，一个学生在提高班的概率是：
#'
#' $$ p = \frac{49}{200} = 0.245 \\
#' logit(p) = \log\left( \frac p {1 - p}\right) = -1.12546 $$
#'
#' 这里的 -1.12546 正是 LR 给出的 intercept 值：

mod_nopred <- glm(hon ~ 1, data = inp, family = "binomial")
coef(mod_nopred)

#' # Logistic Regression with a Single Dichotomous Predictor Variables
#'
#' 问题：性别对进入提高班的影响有多大？
#'
#' 创建特征 female，取 1 表示为女性，取 0 表示为男性。
#'
#' 汇总男性在提高班里有多少人，非提高班里多少人，
#' 女性在提高班里有多少人，非提高班里多少人：
#'

tab <- addmargins(table(inp$hon, inp$female))
row.names(tab) <- c('hon:0', 'hon:1', 'Sum')
colnames(tab) <- c('male', 'female', 'Sum')
tab

#' 可以算出女性进入提高班的 odds $$ \frac{\frac{32}{109}}{\frac{109 - 32}{109}} $$
#' 是男性 odds $$ \frac{\frac{17}{91}}{\frac{91 - 17}{91}} $$ 的

{{ (32/109 / ((109 - 32)/109)) / (17/91 / ((91-17)/91)) }}

#' 倍，取自然对数正是 LR 模型中 female 特征的系数：

female_hon_odds <- 32/109 / ((109 - 32)/109)
male_hon_odds <- 17/91 / ((91-17)/91)
glue('Odds of male in honor classes: {male_hon_odds}. Log of this odds: {log(male_hon_odds)}')
log(female_hon_odds / male_hon_odds)

mod_dicho <- glm(hon ~ female, data = inp, family = "binomial")
coef(mod_dicho)

#' 可以看到这两个系数和上面手工计算结果是吻合的。
#'
#' 注意 LR 模型 mod_dicho 中 female 的名字是 female1，而非 female，
#' 说明 `inp` 的 `female` 特征（读入时通过 `col_types` 参数指定为 factor）被转换成了
#' dummy variable `female1`，它只有两个取值：0 和 1，
#' 当 female1 == 0 时，模型 $$logit(hon) = \beta_0 + \beta_1 female1 $$
#' 变成 $$logit(hon|student = male) = \beta_0 $$ 也就是男性（即参考组，reference group）
#' 进入提高班 odds 的对数，

#' 当 female1 == 1 时，模型变成 $$logit(hon|student = female) = \beta_0 + \beta_1 $$
#' 即女性（对照组，comparison group）进入提高班 odds 的对数，
#' 二者相减，可知 $\beta_1$ 的含义是女性进提高班与男性进提高班的 odds 之差，
#' 这个值的业务含义不明显，但其指数函数

exp(coef(mod_dicho)[2])

#' 则很有意义，它告诉我们性别差异对进入提高班的影响到底有多大：
#' 女性进入提高班的 odds 是男性的 1.81 倍。
#'
#' 关于参考组和对照组详见
#' [An Introduction to Logistic Regression for Categorical Data Analysis][2]

#'
#' # Logistic regression with a single continuous predictor variable
#'
mod_cont <- glm(hon ~ math, data = inp, family = "binomial")
coef(mod_cont)
exp(coef(mod_cont)[2])

#' 表示不论学生数学成绩绝对值为多少，只要增加一分，进入提高班的 odds 增加 16.9%。
#' 
#' # Logistic regression with multiple predictor variables and no interaction terms
#'
mod_multi <- glm(hon ~ math + female + read, data = inp, family = "binomial")
coef(mod_multi)
exp(coef(mod_multi)[3])

#' 当两个学生数学与阅读成绩相同时，女性进入提高班的 odds 是男性的 2.66 倍（是否说明存在性别歧视？），
#' 这与上面单变量分析时的结论（1.81 倍）不同，原因在于单变量模型假设只有性别导致进入提高班的概率不同，
#' 而这里的模型则认为 数学、性别、阅读 都对能否进入提高班有影响。

#' 
#' # Logistic regression with an interaction term of two predictor variables
#'
#‘ To be continued.
#'
#' [1]: https://stats.idre.ucla.edu/other/mult-pkg/faq/general/faq-how-do-i-interpret-odds-ratios-in-logistic-regression/
#' [2]: https://towardsdatascience.com/an-introduction-to-logistic-regression-for-categorical-data-analysis-7cabc551546c

# /*
rmarkdown::render('student-analysis.R')
system('firefox student-analysis.html')
# */
