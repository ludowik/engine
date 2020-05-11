require 'engine'

function setup()
    image = Image(W, H)

    vertices = {}
    for i=1,10 do
        local v = vec2(
                random.range(W),
                random.range(H)
            )
            
        table.insert(vertices, v)
        
        print(v.x, v.y)
    end
end

function draw()
    background(black)

    local i = 0

    local v = vec2()

    for y=1,image.surface.h do
        for x=1,image.surface.w do

            i = 4 * ((y - 1) * image.surface.w + x - 1)

            local minDistance = W

            for j,vertex in ipairs(vertices) do
                minDistance = math.min(minDistance, v:set(x, y):sub(vertex):len())
            end

            minDistance = map(minDistance, 0, W/2, 255, 0)
            
            image.surface.pixels[i  ] = minDistance
            image.surface.pixels[i+1] = minDistance
            image.surface.pixels[i+2] = minDistance

            image.surface.pixels[i+3] = 255

        end
    end

    image:makeTexture()

    sprite(image, 0, 0)

    stroke(red)

    for j,vertex in ipairs(vertices) do
        point(vertex.x, vertex.y)
    end
end
