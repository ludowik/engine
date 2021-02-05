image = class 'Image'

function Image.getPath(imageName, ext)
    local path = getImagePath()
    path = path..'/'..imageName:replace(':', '/')..'.'..(ext or 'png')
    return path -- getFullPath(path)
end

readImage = image

function Image:init(w, h)
    if type(w) == 'number' then
        self:create(w, h or w)

    elseif type(w) == 'string' then
        local path = self.getPath(w)
        if getInfo(path) == nil then
            path = self.getPath(w, 'jpg')
            if getInfo(path) == nil then
                warning("image doesn't exists", 3)
                return self:init(100, 100)
            end
        end

        self.surface = sdl:loadImage(path)

        if self.surface == ffi.NULL then
            warning("image doesn't exists", 3)
            self:create(100, 100)
            return
        end

        self.width = self.surface.w
        self.height = self.surface.h

        self:reversePixels()

        self:makeTexture()

    elseif typeof(w) == 'image' then
        self:create(w.width, w.height)
        self:loadSubPixels(w.surface.pixels, w.formatRGB, 0, 0, w.width, w.height)

    else
        self:create(100, 100)
    end

    self.wh = self.width * self.height
    self.pixels = ffi.cast('GLubyte*', self.surface.pixels)
end

function Image:copy(x, y, w, h)
    assert(x == nil)
    
    local copy = Image(self.width, self.height)
    copy:makeTexture(self.surface)
    return copy
end

function Image:getPixels()
    return self.pixels
end

function Image:setPixels(pixels)
    self.needUpdate = true
    self.pixels = pixels
end

function Image:create(w, h)
    local surface = {
        w = max(1, w),
        h = max(1, h),

        format = {
            BytesPerPixel = 4,
            Rmask = 0xff
        }
    }

    surface.size = surface.w * surface.h * 4

    surface.pixels = ffi.new('GLubyte[?]', surface.size, 0)

    self.width = w
    self.height = h
    
    self.wh = self.width * self.height

    self:makeTexture(surface)
end

function Image:makeTexture(surface)
    if surface then
        self.surface = surface
    end
    
    return self
end

function Image:loadSubPixels(pixels, formatRGB, x, y, w, h, texParam, texClamp)
end

function Image:readPixels(formatAlpha, formatRGB)
end

function Image:reversePixels(pixels, w, h, bytesPerPixel)
    debugger.off()

    if pixels == nil then
        pixels = self.surface.pixels

        w = self.surface.w
        h = self.surface.h

        bytesPerPixel = self.surface.format.BytesPerPixel
    end

    local p = ffi.cast('GLubyte*', pixels)

    local i, j
    for y = 1, h/2 do
        for x = 1, w do
            i = (w * (y-1) + (x-1)) * bytesPerPixel
            j = (w * (h-y) + (x-1)) * bytesPerPixel

            if bytesPerPixel == 1 then
                p[i+0], p[j+0] = p[j+0], p[i+0]

            elseif bytesPerPixel == 3 then
                p[i+0], p[j+0] = p[j+0], p[i+0]
                p[i+1], p[j+1] = p[j+1], p[i+1]
                p[i+2], p[j+2] = p[j+2], p[i+2]

            elseif bytesPerPixel == 4 then
                p[i+0], p[j+0] = p[j+0], p[i+0]
                p[i+1], p[j+1] = p[j+1], p[i+1]
                p[i+2], p[j+2] = p[j+2], p[i+2]
                p[i+3], p[j+3] = p[j+3], p[i+3]
            end
        end
    end

    debugger.on()
end

function Image:reverseSurface(surface, bytesPerPixel)
    if sdl.SDL_LockSurface(surface) == 0 then
        self:reversePixels(surface.pixels, surface.w, surface.h, bytesPerPixel)
        sdl.SDL_UnlockSurface(surface)
    end
end

function Image:use(index)
end

function Image:unuse()
end

function Image:background(...)
    setContext(self)
    background(...)
    setContext()    
end

function Image:draw(x, y, w, h)
    sprite(self, x, y, w or self.width, h or self.height, CORNER)
end

function Image:fragment(f)
    local fragColor

    local fragIndex = 0

    for y=1,self.surface.h do
        for x=1,self.surface.w do

            fragColor = f(x-1, y-1)

            self.surface.pixels[fragIndex  ] = fragColor.r * 255
            self.surface.pixels[fragIndex+1] = fragColor.g * 255
            self.surface.pixels[fragIndex+2] = fragColor.b * 255
            self.surface.pixels[fragIndex+3] = fragColor.a * 255

            fragIndex = fragIndex + 4

        end
    end

    self:makeTexture()
end

local floor = math.floor

function Image:offset(x, y)
    x = round(x-1)
    y = round(y-1)

    local offset = self.width * y + x
    if (offset >= 0 and
        offset < self.wh)
    then
        return offset * self.surface.format.BytesPerPixel
    end
end

function Image:set(x, y, color_r, g, b, a)
    a = a or 1

    if type(color_r) == 'cdata' then
        color_r, g, b, a = color_r.r, color_r.g, color_r.b, color_r.a
    end

    local offset = self:offset(x, y)
    if offset then
        local pixels = self.pixels -- self:getPixels()

        if self.surface.format.BytesPerPixel == 4 then
            pixels[offset  ] = color_r * 255
            pixels[offset+1] = g * 255
            pixels[offset+2] = b * 255
            pixels[offset+3] = a * 255

        elseif self.surface.format.BytesPerPixel == 3 then
            pixels[offset  ] = color_r * 255
            pixels[offset+1] = g * 255
            pixels[offset+2] = b * 255

        elseif self.surface.format.BytesPerPixel == 1 then
            pixels[offset  ] = color_r * 255

        else
            assert()
        end

        self.needUpdate = true
    end
end

function Image:get(x, y, clr)
    clr = clr or Color()

    local offset = self:offset(x, y)
    if offset then
        local pixels = self.pixels -- self:getPixels()

        local scale = 1 / 255

        if self.surface.format.BytesPerPixel == 4 then
            clr.r = pixels[offset  ] * scale
            clr.g = pixels[offset+1] * scale
            clr.b = pixels[offset+2] * scale
            clr.a = pixels[offset+3] * scale

        elseif self.surface.format.BytesPerPixel == 3 then
            clr.r = pixels[offset  ] * scale
            clr.g = pixels[offset+1] * scale
            clr.b = pixels[offset+2] * scale
            clr.a = 1

        elseif self.surface.format.BytesPerPixel == 1 then
            clr.r = pixels[offset  ] * scale
            clr.g = clr.r
            clr.b = clr.r
            clr.a = 1

        else
            assert()
        end

        return clr
    end

    return clr:set()
end

function Image:update(needUpdate)
    if self.needUpdate or needUpdate then
        self.needUpdate = false
        self:makeTexture()
    end
end

function Image:copy(x, y, w, h)
    x = x or 0
    y = y or 0

    w = w or self.width
    h = h or self.height

    local img = image(w, h)

    local from = self
    local to = img

    for i=1,w do
        for j=1,h do
            to:set(i, j, from:get(x+i, y+j))
        end
    end

    img:makeTexture()

    return img
end

function Image:createFramebuffer()
end

function Image:createColorBuffer(w, h)
end

function Image:createDepthBuffer(w, h)
end

function Image:attachTexture2D(renderedTexture)
end

function Image:release()
end

function Image:freeSurface(surface)
    sdl.SDL_FreeSurface(surface)
end

function Image:save(imageName, ext)
    if ios and love then return end

    local pixels = self:readPixels()

    local rmask = 0x000000ff
    local gmask = 0x0000ff00
    local bmask = 0x00ff0000
    local amask = 0xff000000

    local surface = sdl.SDL_CreateRGBSurfaceFrom(pixels, self.width, self.height, 32, 4*self.width, rmask, gmask, bmask, amask)
    if surface ~= NULL then
        self:reverseSurface(surface, 4)

        sdl.image.IMG_SaveJPG(surface, getFullPath(image.getPath(imageName, ext)), 1)
        self:freeSurface(surface)
    end
end
