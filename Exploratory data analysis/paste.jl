function paste(a...;sep::String="")
    a = string.(a)
    final::String = ""
    for i in eachindex(a)
        final = final*a[i]*sep
    end
    if sep == ""
        return final
    else 
        return chop(final)
    end
end 

using DataFrames

function pastedf(df;sep::String="",chopper::Int64=0)
    finalvector = ""
    for i in 1:ncol(df)-chopper
        finalvector = finalvector.*string.(df[:,i]).*sep
    end
    if sep == ""
        return finalvector
    else 
        return chop.(finalvector)
    end
end