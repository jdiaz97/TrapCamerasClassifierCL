using DataFrames
using CSV
using Tables
include("paste.jl")

function get_data(vector)
    data = readdir(vector)
    data = data[@. !occursin.(".exe",data)]
    data = data[@. !occursin.(".ini",data)]
    data = data[@. !occursin.(".dll",data)]
    data = data[@. !occursin.(".txt",data)]
    data = data[@. !occursin.(".gsheet",data)]
    return data
end

wd = "G:/.shortcut-targets-by-id/10VkK57jOtpT-sb2s1ZPO1UHGvs4yau86/1-Fotos"

years = readdir(wd)

df = DataFrame()
for year in years 
    tempdir = paste(wd,year,sep="/")
    park = get_data(tempdir)
    tempdf = DataFrame(years = year, parks = park)
    df = vcat(df,tempdf)
end

directories = wd*"/".*pastedf(df,sep="/")
df2 = DataFrame()
for i in 1:nrow(df)
    data = get_data(directories[i])
    tempdf = DataFrame(years = df[i,: ].years, parks = df[i,: ].parks, units = data)
    df2 = vcat(df2,tempdf)
end
df = df2

directories = wd*"/".*pastedf(df,sep="/")
df2 = DataFrame()
for i in 1:nrow(df)
    data = get_data(directories[i])
    tempdf = DataFrame(years = df[i,: ].years, parks = df[i,: ].parks, units = df[i,: ].units, animal = data)
    df2 = vcat(df2,tempdf)
end
df = df2

directories = wd*"/".*pastedf(df,sep="/")
df2 = DataFrame()
for i in 1:nrow(df)
    data = get_data(directories[i])
    tempdf = DataFrame(years = df[i,: ].years, parks = df[i,: ].parks, units = df[i,: ].units, animal = df[i,: ].animal, pic_folder = data)
    df2 = vcat(df2,tempdf)
end
df = df2

directories = wd*"/".*pastedf(df,sep="/")
df2 = DataFrame()
for i in 1:nrow(df)
    data = get_data(directories[i])
    tempdf = DataFrame(years = df[i,: ].years, parks = df[i,: ].parks, units = df[i,: ].units, animal = df[i,: ].animal, pic_folder = df[i,: ].pic_folder, filename = data)
    df2 = vcat(df2,tempdf)
    percantage = round((i/nrow(df))*100, digits = 5)
    print(i," out of ", nrow(df), " (",percantage,"%) \n")
end
df = df2
df2 = DataFrame() ## just to free memory hehe 

CSV.write("data.csv",df)

using RCall

R"source('Exploratory data analysis/csv_to_xlsx.R')"