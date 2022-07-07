library(rio) ## import and export

df <- import("data.csv")

export(df, "data/data.xlsx")
unlink("data.csv")
