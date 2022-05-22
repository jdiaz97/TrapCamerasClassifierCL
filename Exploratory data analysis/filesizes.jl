using CSV
using DataFrames
using Tables

df = DataFrame(CSV.File("directories.csv"))

a = Float32.(zeros(0))
for i in 1:nrow(df)
    b = filesize(df.newwf[i])
    percantage = round((i/nrow(df))*100, digits = 5)
    a = vcat(a,b)
    print(i, " out of ", nrow(df) ," images processed (" , percantage, " %). ",b, " bytes of Memory. \n",  )
end

CSV.write("filesizes.csv",  Tables.table(a), writeheader=false)