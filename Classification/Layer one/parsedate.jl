using RCall
using Plots
using DataFrames

filanames = readdir("Classification/Layer one/demodata/fantasma1")

function parseDate(string)
    DataFrame(
        year = parse(Int64,chop(string, head = 0, tail = 19)),
        month = parse(Int64,chop(string, head = 5, tail = 16)),
        day = parse(Int64,chop(string, head = 8, tail = 13)),

        hour = parse(Int64,chop(string, head = 11, tail = 10)),
        minute = parse(Int64,chop(string, head = 14, tail = 7)),
        second = parse(Int64,chop(string, head = 17, tail = 4)), 
    )
end

function totalseconds(df)
    return df.second+(df.minute*60)+(df.hour*60*60)+(df.day*60*60*24)
end

function dfDate(vector)
    a = DataFrame()
        for i in 1:lastindex(vector)
            print(i, "\n")
            a = vcat(a,parseDate(vector[i]))
        end
    return a
end

dfdate = dfDate(filanames)
totalseconds(dfdate) 





