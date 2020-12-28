local old, new, quantificationError = color(), color(), color()

function setup()
    source = image('documents:joconde')
    target = image(source.width, source.height)

    old, new, quantificationError = color(), color(), color()
end

local grayScale = color.grayScaleAverage

function draw()
    background(51)

    spriteMode(CORNER)

    if WIDTH > HEIGHT then
        sprite(source, 0, 0, WIDTH/2, HEIGHT)
    else
        sprite(source, 0, 0, WIDTH, HEIGHT/2)
    end

    local pct7 = 7 / 16
    local pct3 = 3 / 16
    local pct5 = 5 / 16
    local pct1 = 1 / 16

    for y=2,source.height-1 do
        for x=2,source.width-1 do
            -- old
            source:get(x, y, old)

            -- new
            grayScale(old, new)            

            local n = 4
            new.r = round(new.r * n) / n
            new.g = round(new.g * n) / n
            new.b = round(new.b * n) / n

            -- error 
            quantificationError.r = old.r - new.r
            quantificationError.g = old.g - new.g
            quantificationError.b = old.b - new.b

            -- set color
            target:set(x, y, new)

            -- report error
            local function reportError(x, y, pct)
                local clr = target:get(x, y)

                clr.r = clr.r + quantificationError.r * pct
                clr.g = clr.g + quantificationError.g * pct
                clr.b = clr.b + quantificationError.b * pct

                target:set(x, y, clr)
            end

            reportError(x+1, y  , pct7)
            reportError(x-1, y+1, pct3)
            reportError(x  , y+1, pct5)
            reportError(x+1, y+1, pct1)
        end
    end

    if WIDTH > HEIGHT then
        sprite(target, WIDTH/2, 0, WIDTH/2, HEIGHT)
    else
        sprite(target, 0, HEIGHT/2, WIDTH, HEIGHT/2)
    end
end
