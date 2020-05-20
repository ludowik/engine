require 'engine'

function setup()
    image = Image(W, H)

    vertices = {}
    for i=1,2 do
        local v = vec2(
            random.range(W),
            random.range(H)
        )

        table.insert(vertices, v)
    end

    compile(code, 'surface')
    
    ffi.cdef("void mafunction(int w, int h, unsigned char* pixels);")
    libSurface = ffi.load('bin/surface.dll')
end

function compile(code, libName)
    os.execute('gcc.exe -shared -o bin/'..libName..'.dll bin/code.c')
    os.execute('gcc.exe -dM -E -o bin/code.h bin/code.c')
end

code = [[
    void mafunction(int w, int h, unsigned char* pixels) {
        int i = 0;
        for(int x = 0; x < w; ++x) {
            for(int y = 0; y < h; ++y) {
               pixels[i++] = 128;
               pixels[i++] = 128;
               pixels[i++] = 0;
               pixels[i++] = 255;
            }
        }
    }
]]

function draw()
    background(black)

    if not debugging then
        local vertex

        local pixels = image.surface.pixels

        local minDistance
        local maxDistance = W^2 / 4

        local maxInteger = math.maxinteger

        local n = #vertices

        libSurface.mafunction(image.surface.w, image.surface.h, image.surface.pixels)
        
--        local i = 0
--        for y=1,image.surface.h do
--            for x=1,image.surface.w do

--                minDistance = maxInteger

--                for j=1,n do
--                    vertex = vertices[j]
--                    minDistance = math.min(minDistance,
--                        (x-vertex.x)^2+
--                        (y-vertex.y)^2)
--                end

--                minDistance = map(minDistance, 0, maxDistance, 255, 0)

--                pixels[i  ] = minDistance
--                pixels[i+1] = minDistance
--                pixels[i+2] = minDistance

--                pixels[i+3] = 255

--                i = i + 4

--            end
--        end

        image:makeTexture()

        sprite(image, 0, 0)
    end

    stroke(red)

    for j=1,#vertices do
        vertex = vertices[j]
        circle(vertex.x, vertex.y, 5)
        vertex:add(vec2(
                random.random(-2, 2),
                random.random(-2, 2)))
    end
end
