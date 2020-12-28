image = class('image')

function image.setup()
end

function image.getPath(imageName, ext)
    local path = getImagePath()
    path = path..'/'..imageName:replace(':', '/')..'.'..(ext or 'png')
    return getFullPath(path)
end

function image.getImage(imageName)
    return resources.get('image',
        imageName,
        image,
        image.release,
        true)
end

function image:init(...)
    self.ids = {
        tex = 0
    }

    local args = {...}

    local imageName, w, h = args[1]
    local path

    local imageNameType = typeof(imageName)

    if imageNameType == 'string' then
        path = self.getPath(imageName)
        if fs.getInfo(path) == nil then
            path = self.getPath(imageName, 'jpg')
            if fs.getInfo(path) == nil then
                path = nil
                w, h = args[2], args[3]
            end
        end
    elseif imageNameType == 'userdata' then
        path = imageName
    elseif imageNameType == 'image' then
        return imageName
    else
        w, h = args[1], args[2]
    end

    w = w or 32
    h = h or w

    if path then
        self:load(path)
    else
        self:create(w, h)
    end
end

function image:create(w, h)
    self.width  = tointeger(w or 32)
    self.height = tointeger(h or w or 32)

    self:genTexture()

    return self:loadPixels()
end

function image:copy(x, y, w, h)
    x = x or 0
    y = y or 0

    w = w or self.width
    h = h or self.height

    local img = image(w, h)

    local from = self
    local to = img

    for i=1,w do
        for j=1,h do
            to:set(i, j, from:get(x+i, y+j):unpack())
        end
    end

    img:update()

    return img
end

function image:release()
    if self.framebufferName then
        gl.glDeleteRenderbuffer(self.depthrenderbuffer)
        gl.glDeleteFramebuffer(self.framebufferName)

        self.depthrenderbuffer = nil
        self.framebufferName = nil
    end

    self.pixels = nil

    self:freeTexture()
end

function image:getWidth()
    return self.width
end

function image:getHeight()
    return self.height
end

function image:load(imageName, ext)
    assert(ext == nil)

    local surface = sdl.image.IMG_Load(imageName)
    if surface ~= NULL then
        assert(surface ~= NULL, imageName)

        self:loadSurface(surface)
        self:freeSurface(surface)
    else
        warning(false, imageName..' not found')
        self:create(32, 32)
    end
end

function image:save(imageName, ext)
    local pixels = self:readPixels()

    local rmask = 0x000000ff
    local gmask = 0x0000ff00
    local bmask = 0x00ff0000
    local amask = 0xff000000

    local surface = sdl.SDL_CreateRGBSurfaceFrom(pixels, self.width, self.height, 32, 4*self.width, rmask, gmask, bmask, amask)
    if surface ~= NULL then
        self:reverseSurface(surface, 4)

        sdl.image.IMG_SavePNG(surface, getFullPath(image.getPath(imageName, ext)))
        self:freeSurface(surface)
    end
end

function image:loadSurface(surface, reverse)
    if reverse == nil then
        reverse = true
    end

    self.width = surface.w
    self.height = surface.h

    self:genTexture()

    self.formatAlpha = 0
    self.formatRGB = 0

    if surface.format.BytesPerPixel == 1 then
        self.formatAlpha = gl.GL_ALPHA
        self.formatRGB = gl.GL_ALPHA

    elseif surface.format.BytesPerPixel == 3 then
        self.formatAlpha = gl.GL_RGB
        if surface.format.Rmask == 0xff then
            self.formatRGB = gl.GL_RGB
        else
            self.formatRGB = gl.GL_BGR
        end

    elseif surface.format.BytesPerPixel == 4 then
        self.formatAlpha = gl.GL_RGBA
        if surface.format.Rmask == 0xff then
            self.formatRGB = gl.GL_RGBA
        else
            self.formatRGB = gl.GL_BGRA
        end

    else
        self:freeSurface(surface)
        error('unknown format')
        return false

    end

    if reverse then
        self:reverseSurface(surface, surface.format.BytesPerPixel)
    end

    return self:loadPixels(surface.pixels,
        self.formatAlpha,
        self.formatRGB)
end

function image:reverseSurface(surface, bytesPerPixel)
    if sdl.SDL_LockSurface(surface) == 0 then
        self:reversePixels(surface.pixels, surface.w, surface.h, bytesPerPixel)
        sdl.SDL_UnlockSurface(surface)
    end    
end

function getTexParam()
    if isDown('a') then
        return gl.GL_LINEAR
    end
end

function getTexClamp()
    if isDown('a') then
        return gl.GL_CLAMP_TO_BORDER
    end
end

function image:reversePixels(pixels, w, h, bytesPerPixel)
    debugger.off()

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

function image:loadPixels(pixels, internalFormat, formatRGB, texParam, texClamp)
    texParam = texParam or getTexParam() or gl.GL_LINEAR
    texClamp = texClamp or getTexClamp() or gl.GL_CLAMP_TO_EDGE

    self:use()    
    do
        internalFormat = internalFormat or gl.GL_RGBA
        formatRGB = formatRGB or gl.GL_RGBA

        if pixels == nil then
            self:createPixels(formatRGB)
        end

        gl.glTexImage2D(gl.GL_TEXTURE_2D,
            0, -- level
            internalFormat,
            self.width, self.height,
            0, -- border
            formatRGB, gl.GL_UNSIGNED_BYTE,
            pixels or self.pixels)
        
        gl.glPixelStorei(gl.GL_UNPACK_ALIGNMENT, 1)

        gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MIN_FILTER, texParam)
        gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MAG_FILTER, texParam)

        gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_WRAP_S, texClamp)
        gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_WRAP_T, texClamp)
    end
    self:unuse()

    return true
end

function image:loadSubPixels(pixels, formatRGB, x, y, w, h, texParam, texClamp)
    texParam = texParam or getTexParam() or gl.GL_LINEAR
    texClamp = texClamp or getTexClamp() or gl.GL_CLAMP_TO_EDGE

    self:use()
    do
        formatRGB = formatRGB or gl.GL_RGBA

        gl.glTexSubImage2D(gl.GL_TEXTURE_2D,
            0, -- level
            x, y,
            w, h,
            formatRGB, gl.GL_UNSIGNED_BYTE,
            pixels)
        
        gl.glPixelStorei(gl.GL_UNPACK_ALIGNMENT, 1)

        gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MIN_FILTER, texParam)
        gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MAG_FILTER, texParam)

        gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_WRAP_S, texClamp)
        gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_WRAP_T, texClamp)
    end
    self:unuse()

    return true
end

function image:freeSurface(surface)
    sdl.SDL_FreeSurface(surface)
end

function image:genTexture()
    self:freeTexture()
    self.ids.tex = gl.glGenTexture()
end

function image:freeTexture()
    if gl.glIsTexture(self.ids.tex) == gl.GL_TRUE then
        gl.glDeleteTexture(self.ids.tex)
    end
end

function image:use(index)
    assert(self.ids.tex > 0)

    gl.glBindTexture(gl.GL_TEXTURE_2D, self.ids.tex)
    gl.glActiveTexture(index or gl.GL_TEXTURE0)
end

function image:unuse()
    gl.glBindTexture(gl.GL_TEXTURE_2D, 0)
end

function image:createPixels(formatRGB)
    if self.pixels == nil then
        local size = self.width * self.height

        if formatRGB == gl.GL_RGBA then
            size = size * 4

        elseif formatRGB == gl.GL_RGB then
            size = size * 3

        elseif formatRGB == gl.GL_ALPHA then
            size = size

        else
            assert()
        end

        self.formatRGB = formatRGB

        self.pixels = ffi.new('GLubyte[?]', size)
    end
end

function image:readPixels(formatAlpha, formatRGB)
    if self.pixels == nil then
        formatAlpha = formatAlpha or gl.GL_RGB
        formatRGB = formatRGB or gl.GL_RGBA

        self:createPixels(formatRGB)

        self:use()
        do
            gl.glGetTexImage(gl.GL_TEXTURE_2D,
                0,
                formatRGB,
                gl.GL_UNSIGNED_BYTE,
                self.pixels)
        end
        self:unuse()
    end
    return self.pixels
end

function image:offset(x, y)
    x = tointeger(x-1)
    y = tointeger(y-1)

    local offset = self.width * y + x
    if offset >= 0 and offset < self.width * self.height then
        return offset
    end
end

local function tocolor(r, g, b, a)
    if type(r) == 'table' then
        return r
    else
        return color(r, g, b, a)
    end
end

function image:set(x, y, color_r, g, b, a)
    a = a or 1

    if type(color_r) == 'table' then
        color_r, g, b, a = color_r.r, color_r.g, color_r.b, color_r.a
    end

    local pixels = self:readPixels()

    local offset = self:offset(x, y)
    if offset then
        pixels[offset  ] = color_r * 255
        pixels[offset+1] = g * 255
        pixels[offset+2] = b * 255
        pixels[offset+3] = a * 255

        self.needUpdate = true
    end
end

function image:get(x, y, clr)
    clr = clr or Color()

    self:readPixels()

    local offset = self:offset(x, y)

    if offset then
        local pixels = self.pixels

        clr.r = pixels[offset  ] / 255
        clr.g = pixels[offset+1] / 255
        clr.b = pixels[offset+2] / 255
        clr.a = pixels[offset+3] / 255

        return clr
    end

    clr:set()
    return clr
end

function image:update()
    if self.needUpdate then
        self.needUpdate = false
        self:loadPixels(self.pixels)
    end
end

function image:draw(x, y, w, h)
    sprite(self, x, y, w or self.width, h or self.height, CORNER)
end

function image.createFramebuffer()
    -- The framebuffer, which regroups 0, 1, or more textures, and 0 or 1 depth buffer
    local framebufferName = gl.glGenFramebuffer()
    gl.glBindFramebuffer(gl.GL_FRAMEBUFFER, framebufferName)
    return framebufferName
end

function image.attachRenderbuffer(w, h)
    -- The depth buffer
    local depthrenderbuffer = gl.glGenRenderbuffer()
    gl.glBindRenderbuffer(gl.GL_RENDERBUFFER, depthrenderbuffer)
    gl.glRenderbufferStorage(gl.GL_RENDERBUFFER, gl.GL_DEPTH_COMPONENT24, w, h)
    gl.glBindRenderbuffer(gl.GL_RENDERBUFFER, 0)
    gl.glFramebufferRenderbuffer(gl.GL_FRAMEBUFFER, gl.GL_DEPTH_ATTACHMENT, gl.GL_RENDERBUFFER, depthrenderbuffer)
    return depthrenderbuffer
end

function image.attachTexture2D(renderedTexture)
    -- Set "renderedTexture" as our colour attachement #0
    gl.glFramebufferTexture(gl.GL_FRAMEBUFFER, gl.GL_COLOR_ATTACHMENT0, renderedTexture, 0)

    -- Set the list of draw buffers
    gl.glDrawBuffer(gl.GL_COLOR_ATTACHMENT0)
end
