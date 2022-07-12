function paste(a...;sep::String="")
    a = string.(a)
    final::String = ""
    for i in 1:length(a)
        final = final*a[i]*sep
    end
    if sep == ""
        return final
    else 
        return chop(final)
    end
end 