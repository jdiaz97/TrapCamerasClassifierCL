using RCall

include("data_mining.jl")

R"source('csv_to_xlsx.R')"

include("filesizes.jl")