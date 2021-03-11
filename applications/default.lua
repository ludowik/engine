function setup()
    N = 128
    density = Buffer('float'):resize(N*N)
    density_new = Buffer('float'):resize(N*N)
    
    for i=0,N*N-1 do
        density[i] = 0
        density_new[i] = 0
    end

    img = image(N)
    pixelSize = 12

    config.interpolate = false
    parameter.boolean('config.interpolate')
    
    parameter.watch('total')
end

function index(x, y)
    return x + y * N
end

function touched(touch)
    local x, y = floor(touch.x/pixelSize), floor(touch.y/pixelSize)
    if x >= 0 and x < N and y >= 0 and y < N then
        density[index(x, y)] = 2^8
    end
end

function update(dt)
    local a = dt * N * N

    for x=1,20 do
        for y=1,N-2 do
            for x=1,N-2 do
                density_new[index(x, y)] = density[index(x, y)] + dt * (
                    density_new[index(x-1, y)] +
                    density_new[index(x+1, y)] +
                    density_new[index(x, y-1)] +
                    density_new[index(x, y+1)] - 4 * density_new[index(x, y)]
                )
            end
        end
    end

    density_new, density = density, density_new

    total = 0
    for i=0,N*N-1 do
        total = total + density[i]
    end
    
    total = floor(total)
end

function draw()
    local pixels = img:getPixels()

    local i = 0
    for y=0,N-1 do
        for x=0,N-1 do
            pixels[i] = min(255, density[index(x, y)])
            pixels[i+1] = pixels[i]
            pixels[i+2] = pixels[i]
            pixels[i+3] = 255

            i = i + 4
        end
    end

    img:update(true)

    scale(pixelSize)

    spriteMode(CORNER)
    sprite(img)
end
