## What data we actually have? this code answers that
library(rio) ## export

wd <- "G:/.shortcut-targets-by-id/10VkK57jOtpT-sb2s1ZPO1UHGvs4yau86/1-Fotos"

get_folders <- function(list){
  list <- list.files(list)
  list <- list[!grepl(".exe", list)]
  list <- list[!grepl(".ini", list)]
  list <- list[!grepl(".dll", list)]
  list
}

paste1 <- function(...){
  paste(... , sep = "/")
}

years <- get_folders(wd)
df <- data.frame("year" = years)

df2 <- data.frame()
df$directory <- paste1(wd,years)
for (i in 1:nrow(df)){
  data <- get_folders(df$directory[i])
  if (length(data) > 0 ){
    tempdf <- data.frame("year" = df$year[i], "park" = data)
    df2 <- rbind(df2,tempdf)
  }
}
df <- df2
##

df2 <- data.frame()
df$directory <- paste1(wd,df$year,df$park)
for (i in 1:nrow(df)){
  data <- get_folders(df$directory[i])
  if (length(data) > 0 ){
    tempdf <- data.frame("year" = df$year[i], "park" = df$park[i], "unit" =  data)
    df2 <- rbind(df2,tempdf)
  }
}
df <- df2
##

df2 <- data.frame()
df$directory <- paste1(wd,df$year,df$park,df$unit)
for (i in 1:nrow(df)){
  data <- get_folders(df$directory[i])
  if (length(data) > 0 ){
    tempdf <- data.frame("year" = df$year[i], "park" = df$park[i], "unit" =  df$unit[i], "animal" = data)
    df2 <- rbind(df2,tempdf)
  }
}
df <- df2
##

df2 <- data.frame()
df$directory <- paste1(wd,df$year,df$park,df$unit,df$animal)
for (i in 1:nrow(df)){
  data <- get_folders(df$directory[i])
  if (length(data) > 0 ){
    tempdf <- data.frame("year" = df$year[i], "park" = df$park[i], "unit" =  df$unit[i], "animal" = df$animal[i],
                         "pic_folder" = data)
    df2 <- rbind(df2,tempdf)
  }
}
df <- df2
##

df2 <- data.frame()
df$directory <- paste1(wd,df$year,df$park,df$unit,df$animal, df$pic_folder)
for (i in 1:nrow(df)){
  data <- get_folders(df$directory[i])
  if (length(data) > 0 ){
    tempdf <- data.frame("year" = df$year[i], "park" = df$park[i], "unit" =  df$unit[i], "animal" = df$animal[i],
                         "pic_folder" = df$pic_folder[i], "filename" = data)
    df2 <- rbind(df2,tempdf)
  }
}
df <- df2
##

export(df, "data/data_mining.xlsx")
