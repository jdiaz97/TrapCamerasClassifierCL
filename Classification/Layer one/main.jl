
include("batching.jl")

wd = "Classification/Layer one/demodata/animaltest"
df = defineBatch(readdir(wd))

df = DefineClassification(df,wd)


