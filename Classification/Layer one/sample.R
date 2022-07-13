library(rio)
library(dplyr)

df <- import("..//../Exploratory data analysis/data/data.xlsx")

df$filename <- NULL
