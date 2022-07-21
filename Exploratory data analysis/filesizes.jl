using CSV
using DataFrames
using Tables
using RCall
include("paste.jl")
## using XLSX - readxlsx won't read all rows for some reason, gotta wait until they patch it, instead we'll use RCall

function add0(n::String)
    if length(n) .== 1
        return "0"*n
    else 
        return n
    end
end

df = rcopy(R"library(rio) 
import('Exploratory data analysis/data/data.xlsx')") ## wwow this works perfectly!

df.years = string.(trunc.(Int, df.years))
df.pic_folder = add0.(string.(trunc.(Int, df.pic_folder)))

wd = "G:/.shortcut-targets-by-id/10VkK57jOtpT-sb2s1ZPO1UHGvs4yau86/1-Fotos"

a = Float64.(zeros(0))
directories = wd*"/".*pastedf(df, sep = "/")
total = lastindex(directories)

for i in 1:total
    b = filesize(directories[i])
    a = vcat(a,b)
    percantage = round((i/total)*100, digits = 5)
    if(b != 0)
        print(i, " out of ", total ," images processed (" , percantage, " %). ",b, " bytes of Memory. \n",  )
    else 
        print("fail at ",i,"\n")
    end
end

CSV.write("Exploratory data analysis/data/filesizes.csv",  Tables.table(a), writeheader=false)
