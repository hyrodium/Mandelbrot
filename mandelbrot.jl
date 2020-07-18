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

function isconv_pow2(c,n)
    z = 0
    for i in 1:n
        z = z^2 + c
    end
    return norm(z)<2
end

function isconv_pow3(c,n)
    z = 0
    for i in 1:n
        z = z^3 + c
    end
    return norm(z)<2
end

function isconv_cos(c,n)
    z = 0
    for i in 1:n
        z = cos(z) + c
    end
    return norm(z)<10
end

# Export images for gif animation
canvas = Canvas(-2..2, -2..2, 500)
xs, ys = get_xy(canvas)
zs = [x+y*im for y in ys, x in xs]
for i in 1:50
    col(z) = RGB(1,1,1) - isconv_pow2(z,i)*RGB(1,1,1)
    img = [col(z) for z in zs]
    img = imresize(img, (500,500))
    save("gif/mandelbrot_pow2_"*string(lpad(i,2,"0"))*".png", img)
end

# Export high resolution iamge
canvas = Canvas(-2..2, -2..2, 2000)
xs, ys = get_xy(canvas)
zs = [x+y*im for y in ys, x in xs]
col(z) = RGB(1,1,1) - isconv_pow2(z,500)*RGB(1,1,1)
img = [col(z) for z in zs]
save("high-resolution/mandelbrot_pow2.png", img)

# Export images for gif animation
canvas = Canvas(-2..2, -2..2, 500)
xs, ys = get_xy(canvas)
zs = [x+y*im for y in ys, x in xs]
for i in 1:50
    col(z) = RGB(1,1,1) - isconv_pow3(z,i)*RGB(1,1,1)
    img = [col(z) for z in zs]
    img = imresize(img, (500,500))
    save("gif/mandelbrot_pow3_"*string(lpad(i,2,"0"))*".png", img)
end

# Export high resolution iamge
canvas = Canvas(-2..2, -2..2, 2000)
xs, ys = get_xy(canvas)
zs = [x+y*im for y in ys, x in xs]
col(z) = RGB(1,1,1) - isconv_pow3(z,500)*RGB(1,1,1)
img = [col(z) for z in zs]
save("high-resolution/mandelbrot_pow3.png", img)

# Export images for gif animation
canvas = Canvas(-5..6, -2..2, 300)
xs, ys = get_xy(canvas)
zs = [x+y*im for y in ys, x in xs]
col(z) = RGB(1,1,1) - isconv_cos(z,300)*RGB(1,1,1)
img = [col(z) for z in zs]
save("mandelbrot_cos.png", img)
