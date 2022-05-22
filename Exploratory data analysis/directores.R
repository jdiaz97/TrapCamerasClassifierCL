library(rio)

df <- import("data_mining.xlsx")

wd <- "G:/.shortcut-targets-by-id/10VkK57jOtpT-sb2s1ZPO1UHGvs4yau86/1-Fotos"

newwf <- paste0(wd,"/",df$year,"/",df$park,"/",df$unit,"/",df$animal,"/",df$pic_folder,"/",df$filename)
newdf <- as.data.frame(newwf)

export(newdf,"directories.csv")

# filesizes <- file.size(newdf[1:nrow(newdf),])

## this will take forever in R, it's better to do it in Julia
# filesizes <- data.frame()
# for(i in 1:nrow(newdf)){
#   a <- file.size(newdf[i,])
#   percentage <- round((i/nrow(newdf))*100,2)
#   filesizes <- rbind(filesizes,a)
#   print(paste0(i," out of ",nrow(newdf)," images processed ","(",percentage,"%)"))
# }
# 


