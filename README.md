# Intro

机器学习常用算法实现介绍，基于R and Python 语言。


# Install

For Ubuntu 18.04 or Linux Mint 19:
```
$ sudo apt install r-base r-base-dev libc6-dev build-essential libcurl4-openssl-dev libxml2-dev
$ R
> install.packages('xml2', dependencies=TRUE, INSTALL_opts = c('--no-lock'))
> install.packages(c('forecast', 'fpc', 'e1071', 'dbscan', 'limSolve', 'reticulate', 'gapminder', 'nycflights13', 'tidyverse'))
```
