--- image

Image = Class('image')

function Image.setup()
    ffi.cdef[[
        typedef struct color {
                GLubyte r;
                GLubyte g;
                GLubyte b;
                GLubyte a;
            } color;
        ]]

    image.tmp_color = color()
end

function Image:init(w, h)
    self.ids = {
        tex = 0
    }

    local typ = type(w)
    if typ == 'string' then
        self:load(w)

    elseif typ == 'number' then
        self:create(w, h)

    else
        self.width = 0
        self.height = 0
    end
end

function Image:create(w, h)
    self.width = tointeger(w)
    self.height = tointeger(h)

    self:genTexture()

    return self:loadPixels()
end

function Image:getWidth()
    return self.width
end

function Image:getHeight()
    return self.height
end

function Image:load(imageFile)
    local surface = sdl.image.IMG_Load(getImagePath(imageFile))
    assert(surface ~= NULL, imageFile)

    self:loadSurface(surface)
    self:freeSurface(surface)
end

function Image:save(imageFile)
    functionNotImplemented('saveImage')
end

function Image:loadSurface(surface, reverse)
    if reverse == nil then
        reverse = true
    end

    self.width = surface.w
    self.height = surface.h

    self:genTexture()

    local formatAlpha = 0
    local formatRGB = 0

    if surface.format.BytesPerPixel == 1 then
        formatAlpha = gl.GL_ALPHA
        formatRGB = gl.GL_ALPHA

    elseif surface.format.BytesPerPixel == 3 then
        formatAlpha = gl.GL_RGB
        if surface.format.Rmask == 0xff then
            formatRGB = gl.GL_RGB
        else
            formatRGB = gl.GL_BGR
        end

    elseif surface.format.BytesPerPixel == 4 then
        formatAlpha = gl.GL_RGBA
        if surface.format.Rmask == 0xff then
            formatRGB = gl.GL_RGBA
        else
            formatRGB = gl.GL_BGRA
        end

    else
        self:freeSurface(surface)
        error('unknown format')
        return false

    end

    if reverse then
        self:reverseSurface(surface, surface.format.BytesPerPixel)
    end

    return self:loadPixels(surface.pixels, formatAlpha, formatRGB)
end

function Image:reverseSurface(surface, bytesPerPixel)
    sdl.SDL_LockSurface(surface)
    do
        self:reversePixels(surface.pixels, surface.w, surface.h, bytesPerPixel)
    end
    sdl.SDL_UnlockSurface(surface)
end

function Image:reversePixels(pixels, w, h, bytesPerPixel)
    debug.pause()
    
    if bytesPerPixel == 4 then
        local p = ffi.cast('color*', pixels)

        local i, j
        for y = 1, h/2 do
            for x = 1, w do
                i = (w * (y-1) + (x-1))
                j = (w * (h-y) + (x-1))

                p[i].r, p[j].r = p[j].r, p[i].r
                p[i].g, p[j].g = p[j].g, p[i].g
                p[i].b, p[j].b = p[j].b, p[i].b
                p[i].a, p[j].a = p[j].a, p[i].a
            end
        end
    else
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
    end
    
    debug.on()
end

function Image:loadPixels(pixels, internalFormat, formatRGB)
    self:use()
    do
        internalFormat = internalFormat or gl.GL_RGBA
        formatRGB = formatRGB or gl.GL_RGBA

        gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MIN_FILTER, gl.GL_NEAREST)
        gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MAG_FILTER, gl.GL_NEAREST)

        if pixels == nil then
            self:createPixels()
            pixels = self.pixelsArray
        end

        gl.glTexImage2D(gl.GL_TEXTURE_2D,
            0, -- level
            internalFormat,
            self.width, self.height,
            0, -- border
            formatRGB, gl.GL_UNSIGNED_BYTE,
            pixels or self.pixels)
    end
    self:unuse()

    return true
end

function Image:loadSubPixels(pixels, formatRGB, x, y, w, h)
    self:use()
    do
        formatRGB = formatRGB or gl.GL_RGBA

        gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MIN_FILTER, gl.GL_NEAREST)
        gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MAG_FILTER, gl.GL_NEAREST)

        gl.glTexSubImage2D(gl.GL_TEXTURE_2D,
            0, -- level
            x, y,
            w, h,
            formatRGB, gl.GL_UNSIGNED_BYTE,
            pixels)
    end
    self:unuse()

    return true
end

function Image:freeSurface(surface)
    sdl.SDL_FreeSurface(surface)
end

function Image:genTexture()
    self:freeTexture()
    self.ids.tex = gl.glGenTexture()
end

function Image:freeTexture()
    if gl.glIsTexture(self.ids.tex) == gl.GL_TRUE then
        gl.glDeleteTexture(self.ids.tex)
    end
end

function Image:use()
    assert(self.ids.tex > 0)

    gl.glBindTexture(gl.GL_TEXTURE_2D, self.ids.tex)
    gl.glActiveTexture(gl.GL_TEXTURE0)
end

function Image:unuse()
    gl.glBindTexture(gl.GL_TEXTURE_2D, 0)
end

function Image:createPixels()
    if self.pixelsArray == nil then
        local size = self.width * self.height * 4
        local sizePow2 = 2
        while sizePow2 < size do
            sizePow2 = sizePow2 * 2
        end

        self.pixelsArray = ffi.new('GLubyte[?]', sizePow2)
        self.pixelsArrayColor = ffi.cast('color*', self.pixelsArray)

        ffi.C.memset(self.pixelsArray, 0, ffi.sizeof(self.pixelsArray))
    end
end

function Image:readPixels(formatAlpha)
    if self.pixels == nil then
        self:createPixels()
        self.pixels = self.pixelsArray

        self:use()
        do
            formatAlpha = formatAlpha or gl.GL_RGB
            formatRGB = formatRGB or gl.GL_RGBA

            gl.glGetTexImage(gl.GL_TEXTURE_2D,
                0, formatRGB, gl.GL_UNSIGNED_BYTE,
                self.pixels)
        end
        self:unuse()
    end
    return self.pixels
end

function Image:offset(x, y)
    x = tointeger(x-1)
    y = tointeger(y-1)
    local offset = self.width * y + x
    if offset >= 0 and offset < self.width * self.height then
        return offset * 4
    end
end

local function tocolor(r, g, b, a)
    if type(r) == 'table' then
        return r
    else
        return color(r, g, b, a)
    end
end

function Image:set(x, y, color_r, g, b, a)
    local clr --= tocolor(...)
    if type(color_r) == 'table' then
        clr = color_r
    else
        clr = color(color_r, g, b, a)
    end

    local pixels = self:readPixels()

    local offset = self:offset(x, y)
    if offset then
        pixels[offset  ] = clr.r
        pixels[offset+1] = clr.g
        pixels[offset+2] = clr.b
        pixels[offset+3] = clr.a
    end
end

function Image:get(x, y, clr)
    clr = clr or image.tmp_color

    self:readPixels()

    local offset = self:offset(x, y)

    if offset then
        if true then
            local pixels = self.pixelsArrayColor

            offset = offset / 4

            clr.r = pixels[offset].r
            clr.g = pixels[offset].g
            clr.b = pixels[offset].b
            clr.a = pixels[offset].a
        else
            local pixels = self.pixelsArray

            clr.r = pixels[offset  ]
            clr.g = pixels[offset+1]
            clr.b = pixels[offset+2]
            clr.a = pixels[offset+3]
        end
        return clr
    end
end

function Image:needUpdate()
    if self.pixels ~= nil then
        self:loadPixels(self.pixels)
        self.pixels = nil
    end
end

function Image:draw(x, y)
    sprite(self, x, y, self.width, self.height)
end

function Image:createFramebuffer()
    -- The framebuffer, which regroups 0, 1, or more textures, and 0 or 1 depth buffer
    local framebufferName = gl.glGenFramebuffer()
    gl.glBindFramebuffer(gl.GL_FRAMEBUFFER, framebufferName)
    return framebufferName
end

function Image:attachRenderbuffer(w, h)
    -- The depth buffer
    local depthrenderbuffer = gl.glGenRenderbuffer()
    gl.glBindRenderbuffer(gl.GL_RENDERBUFFER, depthrenderbuffer)
    gl.glRenderbufferStorage(gl.GL_RENDERBUFFER, gl.GL_DEPTH_COMPONENT24, w, h)
    gl.glBindRenderbuffer(gl.GL_RENDERBUFFER, 0)
    gl.glFramebufferRenderbuffer(gl.GL_FRAMEBUFFER, gl.GL_DEPTH_ATTACHMENT, gl.GL_RENDERBUFFER, depthrenderbuffer)
    return depthrenderbuffer
end

function Image:attachTexture2D(renderedTexture)
    -- Set "renderedTexture" as our colour attachement #0
    gl.glFramebufferTexture(gl.GL_FRAMEBUFFER, gl.GL_COLOR_ATTACHMENT0, renderedTexture, 0)

    -- Set the list of draw buffers
    gl.glDrawBuffer(gl.GL_COLOR_ATTACHMENT0)
end
