require 'engine'

function setup()
    image = Image(W, H)

    vertices = {}
    for i=1,10 do
        table.insert(vertices, vec2(
                random.range(W),
                random.range(H)
            ))
    end
end

function draw()
    background(black)

    local i = 0
    
    for y=1,image.surface.h do
        for x=1,image.surface.w do
            
            i = 4 * ((y - 1) * image.surface.w + x - 1)
            
            image.surface.pixels[i  ] = 128
            image.surface.pixels[i+1] = 0
            image.surface.pixels[i+2] = 0
            image.surface.pixels[i+3] = 128

        end
    end

    image:makeTexture()

    sprite(image, 0, 0)
end
