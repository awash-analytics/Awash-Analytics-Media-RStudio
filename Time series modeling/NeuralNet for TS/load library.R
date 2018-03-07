
## load supportive library
library(tidyverse)
library(devtools)
library(lubridate)

## load main library
# install.packages("tscount", dependencies = TRUE)
library(tscount)

# install.packages("forecast", dependencies = TRUE)
library(forecast)
library(tseries)

# library(zoo)         # needed for deriving lag variables
library(quantmod)    # needed for deriving lag variables

## IMPORTANT: I moved from MxNet to NNET in CARET
## -- source: https://stackoverflow.com/questions/14139418/example-of-time-series-prediction-using-neural-networks-in-r
library(nnet)
library(neuralnet)
library(caret)

# install.packages("MxNet", dependencies = TRUE)   ## not working

## -- source: https://stackoverflow.com/questions/43872455/mxnet-package-installation-in-r
# cran <- getOption("repos")
# cran["dmlc"] <- "https://s3.amazonaws.com/mxnet-r/"
# options(repos = cran)
# install.packages("mxnet", dependencies = TRUE)

## -- source: Dr. N. D. Lewis
# install.packages("drat", repos = "https://cran.rstudio.com")
# drat::addRepo("dmlc")
# install.packages("mxnet")

## -- source: https://github.com/apache/incubator-mxnet/issues/5796
# install.packages("viridisLite")    ## needed for pkg::viridis
# install.packages("viridis")        ## needed for pkg::mxnet
# install.packages("DiagrammeR")     ## needed for pkg::mxnet

# cran <- getOption("repos")
# cran["dmlc"] <- "https://s3-us-west-2.amazonaws.com/apache-mxnet/R/CRAN/"
# options(repos = cran)
# install.packages("mxnet", dependencies = TRUE)

# library(viridis)
# library(DiagrammeR)
# library(mxnet)
