function paste(a...;sep::String="")
    a = string.(a)
    final::String = ""
    for i in 1:length(a)
        final = final*a[i]*sep
    end
    return final
end 

paste(1,"ccc","hi","c")
