library(rio) ## import and export

df <- import("data.csv")

export(df, "Exploratory data analysis/data/data.xlsx")
unlink("data.csv")
