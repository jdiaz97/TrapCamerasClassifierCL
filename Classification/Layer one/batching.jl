using RCall
using Plots
using DataFrames
using Dates

filenames = readdir("Classification/Layer one/demodata/fantasma1")

function parseDate(string)
    DateTime(
        parse(Int64,chop(string, head = 0, tail = 19)), ## year
        parse(Int64,chop(string, head = 5, tail = 16)), ## month
        parse(Int64,chop(string, head = 8, tail = 13)), ## day

        parse(Int64,chop(string, head = 11, tail = 10)), ## hour
        parse(Int64,chop(string, head = 14, tail = 7)), ## minute 
        parse(Int64,chop(string, head = 17, tail = 4)),  ## second
    )
end

function defineBatch(filenames)
    df = DataFrame(
            date = parseDate.(filenames),
            filenames = filenames,
            batch = 0, ## just to initialize
         )

    minutesspan = 2 ## might change 
    batchindex = 1

    for i in 1:nrow(df)-1
         if Dates.value(abs(df[i,:].date - df[i+1,:].date))/1000 < minutesspan*60
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
