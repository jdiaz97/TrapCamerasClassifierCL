using CSV
using DataFrames
using Tables
using RCall
## using XLSX - readxlsx won't read all rows for some reason, gotta wait until the patch it, instead we'll use RCall

function add0(n::String)
    if length(n) .== 1
        return "0"*n
    else 
        return n
    end
end

df = rcopy(R"library(rio)
import('data/data.xlsx')") ## wwow this works perfectly!

df.years = string.(trunc.(Int, df.years))
df.pic_folder = add0.(string.(trunc.(Int, df.pic_folder)))


wd = "G:/.shortcut-targets-by-id/10VkK57jOtpT-sb2s1ZPO1UHGvs4yau86/1-Fotos"

a = Float32.(zeros(0))
for i in 1:nrow(df)
    directory = wd*"/"*df[i,: ].years*"/"*df[i,: ].parks*"/"*df[i,: ].units*"/"*df[i,: ].animal*"/"*df[i,: ].pic_folder*"/"*df[i,: ].filename
    b = filesize(directory)
    a = vcat(a,b)
    percantage = round((i/nrow(df))*100, digits = 5)
    print(i, " out of ", nrow(df) ," images processed (" , percantage, " %). ",b, " bytes of Memory. \n",  )
end

CSV.write("data/filesizes.csv",  Tables.table(a), writeheader=false)


