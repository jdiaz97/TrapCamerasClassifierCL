using DataFrames
using CSV
using XLSX
using Tables

function get_folders(vector)
    vector = readdir(vector)
    vector = vector[@. !occursin.(".exe",vector)]
    vector = vector[@. !occursin.(".ini",vector)]
    vector = vector[@. !occursin.(".dll",vector)]
    vector = vector[@. !occursin.(".txt",vector)]
    vector
end

wd = "G:/.shortcut-targets-by-id/10VkK57jOtpT-sb2s1ZPO1UHGvs4yau86/1-Fotos"

years = readdir(wd)

df = DataFrame()
for year in years 
    tempdir = wd*"/"*year
    park = get_folders(tempdir)
    tempdf = DataFrame(years = year, parks = park)
    df = vcat(df,tempdf)
end

df2 = DataFrame()
for i in 1:nrow(df)
    directory = wd*"/"*df[i,: ].years*"/"*df[i,: ].parks
    data = get_folders(directory)
    tempdf = DataFrame(years = df[i,: ].years, parks = df[i,: ].parks, units = data)
    df2 = vcat(df2,tempdf)
end
df = df2

df2 = DataFrame()
for i in 1:nrow(df)
    directory = wd*"/"*df[i,: ].years*"/"*df[i,: ].parks*"/"*df[i,: ].units
    data = get_folders(directory)
    tempdf = DataFrame(years = df[i,: ].years, parks = df[i,: ].parks, units = df[i,: ].units, animal = data)
    df2 = vcat(df2,tempdf)
end
df = df2

df2 = DataFrame()
for i in 1:nrow(df)
    directory = wd*"/"*df[i,: ].years*"/"*df[i,: ].parks*"/"*df[i,: ].units*"/"*df[i,: ].animal
    data = get_folders(directory)
    tempdf = DataFrame(years = df[i,: ].years, parks = df[i,: ].parks, units = df[i,: ].units, animal = df[i,: ].animal, pic_folder = data)
    df2 = vcat(df2,tempdf)
end
df = df2

df2 = DataFrame()
for i in 1:nrow(df)
    directory = wd*"/"*df[i,: ].years*"/"*df[i,: ].parks*"/"*df[i,: ].units*"/"*df[i,: ].animal*"/"*df[i,: ].pic_folder
    data = get_folders(directory)
    tempdf = DataFrame(years = df[i,: ].years, parks = df[i,: ].parks, units = df[i,: ].units, animal = df[i,: ].animal, pic_folder = df[i,: ].pic_folder, filename = data)
    df2 = vcat(df2,tempdf)
    print(i,"\n")
end
df = df2
df2 = DataFrame() ## just to free memory hehe 

CSV.write("data.csv",df)
