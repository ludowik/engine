function setup()
    vertices = Buffer('float')
    for i=0,3 do
        vertices[i*2+1] = math.random(W)
        vertices[i*2+2] = math.random(H)
    end

    angle = 0

    img = Image(4*100, 3*100)
    img:fragment(function (x, y)
            local ix = math.floor(x/100)
            local iy = math.floor(y/100)
            
            local colors = {
                c01 = red,
                c11 = green,
                c21 = blue,
                c31 = gray,
                c12 = white,
                c10 = yellow,
            }
            return colors['c'..ix..iy] or transparent
        end)

    perf = Buffer()
end

function update(dt)
    angle = angle + 30 * dt

    perf[#perf+1] = engine.frame_time.nframes
    perf[#perf+1] = engine.frame_time.fps

    if #perf == 2000 then
        ffi.C.memmove(perf.data, perf.data+2, (perf.n-2)*perf.sizeof_ctype)
        perf.n = perf.n - 2
    end
end

function _draw()
    background(black)

    stroke(white)
    strokeWidth(5)

    translate(0, 0)

    translate(-perf[1], 0)

    polyline(perf)
end

function draw()
    background(black)

    stroke(green)
    polygon(vertices)

    stroke(blue)
    rect(W/2, H/2, 100, 100)

    stroke(green)
    circle(W/2, H/2, 50)

    stroke(red)
    lines(vertices)

    sprite(img, 200, 200)

    resetMatrix()

    depthMode(true)

    perspective()

    camera(vec3(-2, -2, -5))

    translate(0, 0, 10)

--    rotate(angle)
--    rotate(angle, 1)

    for i=1, 100 do
        box(img)
    end
end

