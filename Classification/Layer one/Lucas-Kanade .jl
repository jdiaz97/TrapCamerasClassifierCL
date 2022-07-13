using ImageTracking
using Images, ImageView, ImageTransformations
using CoordinateTransformations, StaticArrays
using LinearAlgebra
using JpegTurbo

function LucasKanadeLines(pathimg1,pathimg2)
    img1 = imresize(load(pathimg1),ratio=1/2)
    img2 = imresize(load(pathimg2),ratio=1/2)
    corners = imcorner(img1, method=shi_tomasi)
    I = findall(!iszero, corners)
    r, c = (getindex.(I, 1), getindex.(I, 2))
    points = map((ri, ci) -> SVector{2}(Float64(ri), Float64(ci)), r, c)


    algorithm = LucasKanade(20, window_size = 11,
                            pyramid_levels = 4,
                            eigenvalue_threshold = 0.000001)
    flow, indicator = optical_flow(Gray{Float32}.(img1), Gray{Float32}.(img2),points, algorithm)

    # Keep the subset of points that were succesfully tracked and determine
    # correspondences.
    valid_points = points[indicator]
    valid_flow = flow[indicator]
    valid_correspondence = map((x,Δx)-> x+Δx, valid_points, valid_flow)

    # Convert (row,columns) to (x,y) convention and round to nearest integer.
    pts1 = map(x-> round.(Int,(last(x),first(x))), valid_points)
    pts2 = map(x-> round.(Int,(last(x),first(x))), valid_correspondence)
    lines = map((p1, p2) -> (p1,p2), pts1, pts2)
    return lines
end

