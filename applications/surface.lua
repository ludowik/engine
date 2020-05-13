require 'engine'

function setup()
    image = Image(W, H)

    vertices = {}
    for i=1,30 do
        local v = vec2(
            random.range(W),
            random.range(H)
        )

        table.insert(vertices, v)
    end
end

function draw()
    background(black)

    local vertex

    local pixels = image.surface.pixels

    local i = 0
    for y=1,image.surface.h do
        for x=1,image.surface.w do

            local minDistance = math.maxinteger

            for j=1,#vertices do
                vertex = vertices[j]
                minDistance = math.min(minDistance,
                    (x-vertex.x)^2+
                    (y-vertex.y)^2)
            end

            minDistance = map(math.sqrt(minDistance), 0, W/4, 255, 0)

            pixels[i  ] = minDistance
            pixels[i+1] = minDistance
            pixels[i+2] = minDistance

            i = i + 4

        end
    end

    image:makeTexture()

    sprite(image, 0, 0)

    stroke(red)

    for j=1,#vertices do
        vertex = vertices[j]
        circle(vertex.x, vertex.y, 5)
        vertex:add(vec2(
                random.random(-2, 2),
                random.random(-2, 2)))
    end
end
