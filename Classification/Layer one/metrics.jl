function distance(lines)
    x1 = lines[1][1]
    y1 = lines[1][2]
    x2 = lines[2][1]
    y2 = lines[2][2]
    distance = sqrt(((x2-x1)^2)+((y2-y1)^2))
    return distance
end

function mean_distance(lines)
    return sum(distance.(lines))/lastindex(lines)
end
