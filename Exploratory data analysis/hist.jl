using Plots
using CSV
using DataFrames

df = DataFrame(CSV.File("data/filesizes.csv", header=false))

df.Column1 = df.Column1 / 1000 # transform to kilobytes
df = subset(df, :Column1 => ByRow(<(4000)))

hist = histogram(df.Column1, foreground_color="hotpink1",
annotations = (2800, 3*10^5, Plots.text("Total = ~4.3 terabytes", :hotpink1,:left,8)),
     leg=false, xlabel="Kilobytes", size=(600, 450),
    ylabel="Frequency", title="File sizes in the database")

savefig(hist, "plots/hist.png")

