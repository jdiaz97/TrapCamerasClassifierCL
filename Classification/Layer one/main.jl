include("batching.jl")

wd = "Classification/Layer one/demodata/fantasmatest"
df = defineBatch(readdir(wd))

df = AddMeanBatch(df,wd)
df = DefineClassification(df)

mkdir(wd*"/fantasma")
for i in 1:nrow(df)
    if df[i,:].type == "fantasma"
        origin = wd*"/"*df[i,:].filenames
        destiny = wd*"/fantasma/"*df[i,:].filenames
        mv(origin, destiny)
    end
end    

