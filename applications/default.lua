require 'engine'

function setup()
    vertices = Buffer('float')
    for i=0,3 do
        vertices[i*2+1] = math.random(W)
        vertices[i*2+2] = math.random(H)
    end

    angle = 0

    img = Image(4*10, 3*10)
    img:fragment(function (x, y)
            if x % 2 == 0 then
                return red
            else
                return green
            end
        end)
    
    perf = Buffer()
end

function update(dt)
    angle = angle + 30 * dt
    
    perf[#perf+1] = engine.frame_time.nframes
    perf[#perf+1] = engine.frame_time.fps /10
    
    if #perf == 500 then
        ffi.C.memmove(perf.data, perf.data+2, (perf.n-2)*perf.sizeof_ctype)
        perf.n = perf.n - 2
    end
    
end

function draw()
    background(black)
    stroke(white)
    translate(0, H/2)
    
    translate(-perf[1], 0)
    polyline(perf)
end

function _draw()
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

    perspective()

    camera(vec3(2, -4, -5))

    rotate(angle)
    rotate(angle, 1)

    for i=1, 100 do
        box(img)
    end
end

