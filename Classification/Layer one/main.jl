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

function studybatch(directory)
    firstcd = pwd()
    cd(directory)
    files_vector = readdir()
    pairs = makepairs(files_vector)
    pairs[2][2]
    batch = Vector()
        for i in 1:lastindex(pairs)
            lines = LucasKanadeLines(
            pairs[i][1], pairs[i][2]
            )
        batchdist = mean_distance(lines)
        batch = vcat(batch,batchdist)
        end
    cd(firstcd)
    return batch
end

maxbatch = maximum(studybatch("guanaco"))

