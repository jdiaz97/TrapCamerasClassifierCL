using Plots
using CSV
using DataFrames

df = DataFrame(CSV.File("Exploratory data analysis/data/filesizes.csv", header=false))

df.Column1 = df.Column1 / 1000 # transform to kilobytes

total = string(round(sum(df.Column1 )/(1000*1000*1000), digits = 2)) ## Get teras
npictures = string(nrow(df))
df = subset(df, :Column1 => ByRow(<(4000))) # Get data of interest of plotting
hist = histogram(df.Column1, foreground_color="hotpink1",
annotations = 
[
    (2800, 2.5*10^5, Plots.text("Total = ~"*total*" terabytes", :hotpink1,:left,8)),
    (2800, 2.2*10^5, Plots.text(npictures*" pictures", :hotpink1,:left,8))
],
    leg=false, xlabel="Kilobytes", 
    ylabel="Frequency", title="File sizes in the database",
    size=(600, 450))

savefig(hist, "Exploratory data analysis/plots/hist.png")


