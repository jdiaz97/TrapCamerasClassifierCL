using DataFrames
using Dates
using Statistics
include("Lucas-Kanade .jl")
include("metrics.jl")

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

## simply create a column that adds the Batch column, based one the time pictures were taken
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

## Lucas-Kanade requires a pair, this will create it 
function makepairs(vector)
    pair_vector = Vector()
        for i in 1:lastindex(vector)-1
            temp_vector = vector[i],vector[i+1]
            pair_vector = vcat(pair_vector,temp_vector) 
        end
    return pair_vector
end

## Run Lucas Kanade in a batch
function studybatch(batchpath)
    pairs = makepairs(batchpath)
    studybatch = Vector()
        for i in 1:lastindex(pairs)
            lines = LucasKanadeLines(
            pairs[i][1], pairs[i][2]
            )
        tempbatch = mean_distance(lines)
        studybatch = vcat(studybatch,tempbatch)
        end
    return studybatch
end

## Add the mean of each batch as a column
function AddMeanBatch(df::DataFrame,wd::String)
    colindex = ncol(df)+1

    insertcols!(df, colindex, :meanbatch => 0.0::Float64)

    finaldf = DataFrame()
        for i in 1:maximum(df.batch)
            tempdf = subset(df, :batch => ByRow(==(i))) 
            if (nrow(tempdf) > 1)
                paths = wd.*"/".*tempdf.filenames 
                tempdf[!,colindex] .= mean(studybatch(paths))
            end
         finaldf = vcat(finaldf,tempdf)
    end
    return finaldf
end

## Define classification based on meanbatch
function DefineClassification(df::DataFrame)
    threeshold = 0.8 ## Important number, it will have to be defined based on statistics
    colindex = ncol(df)+1
    insertcols!(df, colindex, :type => "0")

    finaldf = DataFrame()
        for i in 1:maximum(df.batch)
            tempdf = subset(df, :batch => ByRow(==(i))) 
            if  tempdf.meanbatch[1]> threeshold
                tempdf[!,colindex] .= "animal"
            else 
                tempdf[!,colindex] .= "fantasma"
            end   
         finaldf = vcat(finaldf,tempdf)
    end
    return finaldf
end