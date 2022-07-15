include("Lucas-Kanade .jl")
include("metrics.jl")

function makepairs(vector)
    pair_vector = Vector()
        for i in 1:lastindex(vector)-1
            temp_vector = vector[i],vector[i+1]
            pair_vector = vcat(pair_vector,temp_vector) 
        end
    return pair_vector
end

function studybatch(batch)
    pairs = makepairs(batch)
    studybatch = Vector()
        for i in 1:lastindex(pairs)
            lines = LucasKanadeLines(
            pairs[i][1], pairs[i][2]
            )
        tempbatch = mean_distance(lines)
        studybatch = vcat(studybatch,tempbatch)
        end
    return batch
end


