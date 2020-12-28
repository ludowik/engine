local grayScale = color.grayScaleIntensity

function setup()
    source = image('documents:joconde')
    target = image(source.width, source.height)

    parameter.action('Reset',
        function ()
            source = image('documents:joconde')
        end)

    parameter.action('Flip image',
        function ()
            source, target = target, source
        end)

    parameter.action('Iso', function () setFilter(Image.Filter) end)
    parameter.action('Min', function () setFilter(Image.Filter.Min) end)
    parameter.action('Max', function () setFilter(Image.Filter.Max) end)
    parameter.action('Average', function () setFilter(Image.Filter.Average) end)
    parameter.action('Grayscale', function () setFilter(Image.Filter.Grayscale) end)
    parameter.action('Sort', function () setFilter(Image.Filter.Sort) end)
    parameter.action('Hue', function () setFilter(Image.Filter.Hue) end)
    parameter.action('Dithering', function () setFilter(Image.Filter.Dithering) end)
    parameter.action('Edge', function () setFilter(Image.Filter.Edge) end)
    parameter.action('Shader', function () setFilter(Image.Filter.Shader) end)
    parameter.action('Compose', function () setFilter(Image.Filter.Compose) end)
    parameter.action('Copy', function () setFilter(Image.Filter.Copy) end)
    
    parameter.link('Url', 'https://medium.com/@aryamansharda/how-image-edge-detection-works-b759baac01e2')

    setFilter(Image.Filter.Shader)
end

class 'Image.Filter'

function Image.Filter:run(source, target)
    self.source = source
    self.target = target

    for y=1,source.height do
        for x=1,source.width do
            local res = self:fragment(x, y, self.source:get(x, y))
            if res then
                self.target:set(x, y, res)
            end
        end
        if y % 10 == 0 then
            coroutine.yield()
        end
    end
end

function Image.Filter:fragment(x, y, clr)
    return clr
end

class 'Image.Filter.MinMax' : extends(Image.Filter)

function Image.Filter.MinMax:init()
    Image.Filter.init(self)
    self.n = 5
end

function Image.Filter.MinMax:minmax(x, y, operation, ref)
    local n = self.n or 3

    local i = floor((n-1)/2)

    local clr = color(ref)
    for xi=x-i,x+i do
        for yi=y-i,y+i do
            clr = operation(clr, self.source:get(xi, yi) or ref)
        end
    end

    self.target:set(x, y, clr)
end

class 'Image.Filter.Min' : extends(Image.Filter.MinMax)

function Image.Filter.Min:init()
    Image.Filter.MinMax.init(self)
end

function Image.Filter.Min:fragment(x, y)
    self:minmax(x, y, Color.min, white)
end

class 'Image.Filter.Max' : extends(Image.Filter.MinMax)

function Image.Filter.Max:init()
    Image.Filter.MinMax.init(self)
end

function Image.Filter.Max:fragment(x, y)
    self:minmax(x, y, Color.max, black)
end

class 'Image.Filter.Average' : extends(Image.Filter.MinMax)

function Image.Filter.Average:init()
    Image.Filter.MinMax.init(self)
end

function Image.Filter.Average:fragment(x, y)
    self:minmax(x, y, Color.avg, white)
end

class 'Image.Filter.Dithering' : extends(Image.Filter)

function Image.Filter.Dithering:init()
    self.pct7 = 7 / 16
    self.pct3 = 3 / 16
    self.pct5 = 5 / 16
    self.pct1 = 1 / 16

    self.old = color()
    self.new = color()

    self.quantificationError = color()

    self.clr = color()
end

function Image.Filter.Dithering:fragment(x, y)
    -- old
    self.source:get(x, y, self.old)

    -- new
    grayScale(self.old, self.new)

    local n = 4
    self.new.r = round(self.new.r * n) / n
    self.new.g = round(self.new.g * n) / n
    self.new.b = round(self.new.b * n) / n

    -- error
    self.quantificationError.r = self.old.r - self.new.r
    self.quantificationError.g = self.old.g - self.new.g
    self.quantificationError.b = self.old.b - self.new.b

    -- set color
    self.target:set(x, y, self.new)

    -- report error
    local function reportError(x, y, pct)
        self.target:get(x, y, self.clr)

        self.clr.r = self.clr.r + self.quantificationError.r * pct
        self.clr.g = self.clr.g + self.quantificationError.g * pct
        self.clr.b = self.clr.b + self.quantificationError.b * pct

        self.target:set(x, y, self.clr)
    end

    reportError(x+1, y  , self.pct7)
    reportError(x-1, y+1, self.pct3)
    reportError(x  , y+1, self.pct5)
    reportError(x+1, y+1, self.pct1)
end

class 'Image.Filter.Hue' : extends(Image.Filter)

function Image.Filter.Hue:fragment(x, y)
    local clr = self.source:get(x, y)

    self.target:set(x, y, hsl(rgb2hsl(clr), 0.5, 0.25))
end

class 'Image.Filter.Grayscale' : extends(Image.Filter)

function Image.Filter.Grayscale:fragment(x, y, clr)
    return grayScale(clr)
end

class 'Image.Filter.Edge' : extends(Image.Filter)

local function clr2vec(clr)
    return vec3(clr.r, clr.g, clr.b)
end

local function vec2clr(vec)
    return color(vec.x, vec.y, vec.z)
end

function Image.Filter.Edge:fragment(x, y)
    local v = (
        clr2vec(self.source:get(x-1, y+1))*(-1) +
        clr2vec(self.source:get(x  , y+1))*( 0) + 
        clr2vec(self.source:get(x+1, y+1))*( 1) + 
        clr2vec(self.source:get(x-1, y  ))*(-1) +
        clr2vec(self.source:get(x  , y  ))*( 0) + 
        clr2vec(self.source:get(x+1, y  ))*( 1) + 
        clr2vec(self.source:get(x-1, y-1))*(-1) +
        clr2vec(self.source:get(x  , y-1))*( 0) + 
        clr2vec(self.source:get(x+1, y-1))*( 1))

    self.target:set(x, y,  vec2clr(v))
end

class 'Image.Filter.Sort' : extends(Image.Filter)

function Image.Filter.Sort:init()
    Image.Filter.init(self)

    self.paletteByColor = Table()
    self.paletteByIndex = Table()
end

function Image.Filter.Sort:run(source, target)
    for y=1,source.height do
        for x=1,source.width do
            local clr = source:get(x, y)
            local clrKey = tostring(clr)

            if self.paletteByColor[clrKey] == nil then
                self.paletteByColor[clrKey] = {
                    clr = clr,
                    clrKey = clrKey,
                    n = 0}
            end

            self.paletteByColor[clrKey].n = self.paletteByColor[clrKey].n + 1
        end
    end

    for k,v in pairs(self.paletteByColor) do
        self.paletteByIndex:add(v)
    end
    self.paletteByIndex:sort(
        function (a, b)
            local ha, sa, la = rgb2hsl(a.clr)
            local hb, sb, lb = rgb2hsl(b.clr)

            if round(ha) == round(hb) then
                if round(sa) == round(sb) then
                    return la < lb
                else
                    return sa < sb
                end
            else
                return ha < hb
            end
        end)

    Image.Filter.run(self, source, target)
end

function Image.Filter.Sort:fragment(x, y)
    local clrRef = self.paletteByIndex[1]

    self.target:set(x, y, hsl(rgb2hsl(clrRef.clr), 1, 0.5))

    clrRef.n = clrRef.n - 1
    if clrRef.n == 0 then
        self.paletteByIndex:remove(1)
    end
end

class 'Image.Filter.Shader' : extends(Image.Filter)

function Image.Filter.Shader:init(name)
    self.shader = Shader(name or 'filter')
    self.mesh = Model.rect()
end

function Image.Filter.Shader:run(source, target)
    setContext(target)
    self.mesh:render(self.shader, renderer.GL_TRIANGLES, source, 0, 0, 0, source.width, source.height, 1)
end

class 'Image.Filter.Compose' : extends(Image.Filter)

function Image.Filter.Compose:init()
    self.filters = {
        Image.Filter.Grayscale,
        Image.Filter.Dithering,
        Image.Filter.Average
    }
end

function Image.Filter.Compose:run(source, target)
    for i,filter in ipairs(self.filters) do
        filter():run(source, target)
        source = target:copy()
    end
end

class 'Image.Filter.Copy' : extends(Image.Filter)

function Image.Filter.Copy:init()
end

function Image.Filter.Copy:run(source, _)
    target = Image(source)
end

function setFilter(filter)
    app.coroutine = coroutine.create(
        function ()
            filter():run(source, target)
        end)
end

function update(dt)
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
