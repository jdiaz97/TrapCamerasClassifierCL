
using Plots

x = ["Filtración actual", "Filtración posible","Pendiente"]
y = [40,50,10]

theme(:default)
a = pie(x, y, l = 1, size=(600, 300), seriescolor = ["deepskyblue1","orchid3","coral"],
annotations = 
[
    (0, 0.5, Plots.text("40%")),
    (0, -0.5, Plots.text("50%")),
    (0.6, -0.15, Plots.text("10%")),
],)

savefig(a, "Classification/Layer One/temporary.png")