using Images
using IntervalSets
using LinearAlgebra

struct Canvas
    Ix :: ClosedInterval{Float64}
    Iy :: ClosedInterval{Float64}
    ppu :: Int
end

canvas = Canvas(-2..2, -2..2, 100)

function get_xy(canvas::Canvas)
    ax, bx = endpoints(canvas.Ix)
    ay, by = endpoints(canvas.Iy)
    lx = IntervalSets.width(canvas.Ix)
    ly = IntervalSets.width(canvas.Iy)
    nx = Int(round(lx*canvas.ppu))
    ny = Int(round(ly*canvas.ppu))
    startx = ax + lx/2nx
    starty = ay + ly/2ny
    endx = bx - lx/2nx
    endy = by - ly/2ny
    xs = range(startx, endx, length=nx)
    ys = range(endy, starty, length=ny)
    return xs, ys
end

xs, ys = get_xy(canvas)

@time ps = [[x, y] for y in ys, x in xs]
@time [RGB(p...,0) for p in ps]

@time [RGB(norm(p),0.5,norm(p) -1) for p in ps]
