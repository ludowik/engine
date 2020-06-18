class 'Image'

function Image:init(w, h)
    if type(w) == 'number' and h then
        self:create(w, h)
    elseif type(w) == 'string' then
        local surface = sdl.image.IMG_Load(imageName)
        surface.pixels = ffi.new('GLubyte[?]', surface.size, 0)
        self.width = w
        self.height = h

        self:makeTexture(surface)
    end
end

function Image:create(w, h)
    local surface = {
        w = w,
        h = h,

        size = w * h * 4,

        format = {
            BytesPerPixel = 4,
            Rmask = 0xff
        }
    }

    surface.pixels = ffi.new('GLubyte[?]', surface.size, 0)

    self.width = w
    self.height = h

    self:makeTexture(surface)
end

function Image:makeTexture(surface)
    if surface then
        self.surface = surface
    end

    if self.texture_id == nil or gl.glIsTexture(self.texture_id) == gl.GL_FALSE then
        self.texture_id = gl.glGenTexture()
    end

    gl.glBindTexture(gl.GL_TEXTURE_2D, self.texture_id)

    local internalFormat = gl.GL_RGBA
    local formatRGB = gl.GL_RGBA

    if self.surface.format.BytesPerPixel == 1 then
        if gl.majorVersion == 4 then
            internalFormat = gl.GL_ALPHA
            formatRGB = gl.GL_ALPHA
        else
            internalFormat = gl.GL_ALPHA
            formatRGB = gl.GL_ALPHA
        end

    elseif self.surface.format.BytesPerPixel == 3 then
        internalFormat = gl.GL_RGB
        if self.surface.format.Rmask == 0xff then
            formatRGB = gl.GL_RGB
        else
            formatRGB = gl.GL_BGR
        end

    elseif self.surface.format.BytesPerPixel == 4 then
        internalFormat = gl.GL_RGBA
        if self.surface.format.Rmask == 0xff then
            formatRGB = gl.GL_RGBA
        else
            formatRGB = gl.GL_BGRA
        end
    end

    gl.glTexImage2D(gl.GL_TEXTURE_2D,
        0, -- level
        internalFormat,
        self.surface.w, self.surface.h,
        0, -- border
        formatRGB, gl.GL_UNSIGNED_BYTE,
        self.surface.pixels)

    gl.glPixelStorei(gl.GL_UNPACK_ALIGNMENT, 1)

    gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MIN_FILTER, gl.GL_LINEAR)
    gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MAG_FILTER, gl.GL_LINEAR)

    gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_WRAP_S, gl.GL_CLAMP_TO_EDGE)
    gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_WRAP_T, gl.GL_CLAMP_TO_EDGE)

    gl.glBindTexture(gl.GL_TEXTURE_2D, 0)

    return self
end

function Image:readPixels(formatAlpha, formatRGB)
    formatRGB = formatRGB or gl.GL_RGBA

    self:use()
    do
        gl.glGetTexImage(gl.GL_TEXTURE_2D,
            0,
            formatRGB,
            gl.GL_UNSIGNED_BYTE,
            self.surface.pixels)
    end
    self:unuse()
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

function Image:release()
    gl.glDeleteTexture(self.texture_id)
    self.surface.pixels = nil
end

function Image:use(index)
    assert(self.texture_id > 0)

    gl.glBindTexture(gl.GL_TEXTURE_2D, self.texture_id)
    gl.glActiveTexture(index or gl.GL_TEXTURE0)
end

function Image:unuse()
    gl.glBindTexture(gl.GL_TEXTURE_2D, 0)
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

function Image.createFramebuffer()
    -- The framebuffer, which regroups 0, 1, or more textures, and 0 or 1 depth buffer
    local framebufferName = gl.glGenFramebuffer()
    gl.glBindFramebuffer(gl.GL_FRAMEBUFFER, framebufferName)
    return framebufferName
end

function Image.attachRenderbuffer(w, h)
    -- The depth buffer
    local depthrenderbuffer = gl.glGenRenderbuffer()
    gl.glBindRenderbuffer(gl.GL_RENDERBUFFER, depthrenderbuffer)
    gl.glRenderbufferStorage(gl.GL_RENDERBUFFER, gl.GL_DEPTH_COMPONENT24, w, h)
    gl.glBindRenderbuffer(gl.GL_RENDERBUFFER, 0)
    gl.glFramebufferRenderbuffer(gl.GL_FRAMEBUFFER, gl.GL_DEPTH_ATTACHMENT, gl.GL_RENDERBUFFER, depthrenderbuffer)
    return depthrenderbuffer
end

function Image.attachTexture2D(renderedTexture)
    -- Set "renderedTexture" as our colour attachement #0
    gl.glFramebufferTexture(gl.GL_FRAMEBUFFER, gl.GL_COLOR_ATTACHMENT0, renderedTexture, 0)

    -- Set the list of draw buffers
    gl.glDrawBuffer(gl.GL_COLOR_ATTACHMENT0)
end
