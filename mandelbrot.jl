using Images
using IntervalSets
using LinearAlgebra

struct Canvas
    Ix :: ClosedInterval{Float64}
    Iy :: ClosedInterval{Float64}
    ppu :: Int
end

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

canvas = Canvas(-2..2, -2..2, 2000)

xs, ys = get_xy(canvas)
zs = [x+y*im for y in ys, x in xs]
[RGB(norm(z),0,0) for z in zs]
function isconv(c)
    z = 0
    for i in 1:100
        z = z^2 + c
    end
    return norm(z)<2
end

col(z) = RGB(1,1,1) - isconv(z)*RGB(1,1,0)
img = [col(z) for z in zs]
save("mandelbrot.png", img)
