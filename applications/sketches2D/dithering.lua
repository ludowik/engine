local old, new, quantificationError, clr

function setup()
    source = image('documents:joconde')
    target = image(source.width, source.height)

    needUpdate = true
end

local grayScale = color.grayScaleAverage

local filters = {}

function filters.min(filter, source, target, x, y)
    return filters.minmax(filter, source, target, x, y, Color.min, white)
end

function filters.max(filter, source, target, x, y)
    return filters.minmax(filter, source, target, x, y, Color.max, black)
end

function filters.avg(filter, source, target, x, y)
    return filters.minmax(filter, source, target, x, y, Color.avg, gray)
end

function filters.minmax(filter, source, target, x, y, operation, clr)
    local n = filter.n or 3

    local i = floor((n-1)/2)

    for xi=x-i,x+i do
        for yi=y-i,y+i do
            clr = operation(clr, source:get(xi, yi) or clr)
        end
    end

    target:set(x, y, clr)
end

function filters.dithering(filter, source, target, x, y)
    -- old
    source:get(x, y, filter.old)

    -- new
    grayScale(filter.old, filter.new)

    local n = 4
    filter.new.r = round(filter.new.r * n) / n
    filter.new.g = round(filter.new.g * n) / n
    filter.new.b = round(filter.new.b * n) / n

    -- error
    filter.quantificationError.r = filter.old.r - filter.new.r
    filter.quantificationError.g = filter.old.g - filter.new.g
    filter.quantificationError.b = filter.old.b - filter.new.b

    -- set color
    target:set(x, y, filter.new)

    -- report error
    local function reportError(x, y, pct)
        target:get(x, y, filter.clr)

        filter.clr.r = filter.clr.r + filter.quantificationError.r * pct
        filter.clr.g = filter.clr.g + filter.quantificationError.g * pct
        filter.clr.b = filter.clr.b + filter.quantificationError.b * pct

        target:set(x, y, filter.clr)
    end

    reportError(x+1, y  , filter.pct7)
    reportError(x-1, y+1, filter.pct3)
    reportError(x  , y+1, filter.pct5)
    reportError(x+1, y+1, filter.pct1)
end

function update(dt)
    if needUpdate then
        filter = {
            f = filters.dithering,

            pct7 = 7 / 16,
            pct3 = 3 / 16,
            pct5 = 5 / 16,
            pct1 = 1 / 16,

            old = color(),
            new = color(),

            quantificationError = color(),

            clr = color()
        }

        filter = {
            f = filters.min,
            n = 5
        }

        for y=1,source.height do
            for x=1,source.width do
                filter.f(filter, source, target, x, y)
            end
        end

        needUpdate = false
    end
end

function draw()
    background(51)

    spriteMode(CORNER)

    if WIDTH > HEIGHT then
        sprite(source, 0, 0, WIDTH/2, HEIGHT)
        sprite(target, W/2, 0, W/2, H)
    else
        sprite(source, 0, 0, WIDTH, HEIGHT/2)
        sprite(target, 0, H/2, W, H/2)
    end
end
