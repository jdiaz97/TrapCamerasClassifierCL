using RCall
using Plots
using DataFrames

filenames = readdir("Classification/Layer one/demodata/fantasma1")

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

function shortyear(year)
    parse.(Int64,chop.(string.(year), head = 2, tail = 0))
end

function totalseconds(df)
    return df.second+(df.minute*60)+(df.hour*60*60)+(df.day*60*60*24)+(df.month*60*60*24*30)+shortyear(df.year)*(365*24*60*60)
end

function dfDate(vector)
    a = DataFrame()
        for i in 1:lastindex(vector)
            a = vcat(a,parseDate(vector[i]))
        end
    return a
end

function defineBatch(filenames)
    df = DataFrame(
            seconds = totalseconds(dfDate(filenames)) ,
            filenames = filenames,
            batch = 0, ## just to initialize
         )

    minutesspan = 2
    batchindex = 1

    for i in 1:nrow(df)-1
         if abs(df[i,:].seconds - df[i+1,:].seconds) < minutesspan*60
             df[i,:].batch = batchindex
             df[i+1,:].batch = batchindex
         else
             batchindex = batchindex + 1 
         end
    end
    return DataFrame(
        filenames = df.filenames,
        batch = df.batch
    )
end


defineBatch(filenames)