library(rio) # import()
library(ggplot2) ## ggplot()
library(dplyr) ## summary() + group_By()
library(stringr) # str_to_title()

df <- import("data/data.xlsx")
names(df) <- c("year","park","unit","animal","pic_folder","filename")

# eliminate plurals strings 
nchar_to_cut <- nchar(df[str_sub(df$animal,-1) == "s",]$animal)
no_plural <- str_sub(df[str_sub(df$animal,-1) == "s",]$animal,1,(nchar_to_cut-1))
df[str_sub(df$animal,-1) == "s",]$animal <- no_plural

## standarize names
df$animal <- str_to_title(df$animal)
df$park <- gsub(".*-", "", df$park)

## delete unwanted cases
unwantedcases <- c("No Identificado","Noidentificada","Noclasificada",
                    "Nada", "Error", "Sin Clasificar","Noidentificado","Sin_clasificar")
df <- df[!df$animal %in% unwantedcases,]

## important possible subset
# df <- df[df$animal != "Fantasma",] ## CHECK THIS 

## regroup data data mean the same things
df$animal[df$animal == "Hued_hued"] <- "Hued Hued"
df$animal[df$animal == "Huedhued"] <- "Hued Hued"
df$animal[df$animal == "Caballos Conaf"] <- "Caballo"
df$animal[df$animal == "Zorro_chilla"] <- "Chilla"
df$animal[df$animal == "Zorroculpeo"] <- "Culpeo"
df$animal[df$animal == "Guarda"] <- "Guardaparque"
df$animal[df$animal == "Persona"] <- "Humano"
df$animal[df$animal == "Guardaparque"] <- "Humano" ## Xd!

## SUBSET FOR PATAGONIA
df <- df[grepl("Castillo",df$park) | grepl("Patagonia",df$park)  ,]

## summarize

df <- as.data.frame(table(df$animal))
names(df) <- c("animal","n")

## make the plot by right order
df <- df[order(df$n),]
df$animal <- factor(df$animal, levels = df$animal)
df <- df[complete.cases(df),]

## plot
a <- ggplot(df[df$n > 1000,]) + aes(x=animal, y = n, fill = animal) +
  geom_text(aes(label=n), vjust=0.4, hjust = -0.1) +
  geom_bar(position="stack", stat="identity") +
  theme_bw() +
  coord_flip() +
  xlab("") +
  ylab("Ocurrencias") +
  ggtitle("Datos de camaras trampas CONAF 2017-2021 \n Parque Nacional Patagonia y Cerro Castillo") +
  theme(legend.position="none",
        plot.title = element_text(hjust = 0.6),
        axis.text.y	 = element_text(size = 12)) +
  scale_y_continuous(expand = expansion(mult = 0, add = 10),limits = c(0,max(df$n)*1.171))

ggsave("plots/summary1_plot.jpg", plot = a, width = 6.37, height = 4.61) 

## Calculations
toautomate <- sum(df$n[df$n > 9000])
total <- sum(df$n) 

fantasma <- sum(df$n[df$animal == "Fantasma"])

paste("To automate:",as.character((toautomate*100)/total),"%")
paste("Fantasma:",as.character((fantasma*100)/total),"%")
