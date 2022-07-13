include("Lucas-Kanade .jl")
include("metrics.jl")

cd("Classification/Layer one/demo")

lines = LucasKanadeLines(
    "guanaco1.jpg","guanaco2.jpg"
)

meandist = mean_distance(lines)