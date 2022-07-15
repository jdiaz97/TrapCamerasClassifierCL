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

using DataFrames

function pastedf(df;sep::String="")
    finalvector = ""
    for i in 1:ncol(df)
        finalvector = finalvector.*string.(df[:,i]).*sep
    end
    chop.(finalvector)
end
