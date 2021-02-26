--local Image = class 'Image.OpenGL'

function Image:makeTexture(surface)
    if surface then
        self.surface = surface
    end

    if self.texture_id == nil or gl.glIsTexture(self.texture_id) == gl.GL_FALSE then
        self.texture_id = gl.glGenTexture()
    end

    gl.glBindTexture(gl.GL_TEXTURE_2D, self.texture_id)

    self.internalFormat = gl.GL_RGBA
    self.formatRGB = gl.GL_RGBA

    if self.surface.format.BytesPerPixel == 1 then
        if config.glMajorVersion >= 4 then
            self.internalFormat = gl.GL_ALPHA
            self.formatRGB = gl.GL_ALPHA
        else
            self.internalFormat = gl.GL_ALPHA
            self.formatRGB = gl.GL_ALPHA
        end

    elseif self.surface.format.BytesPerPixel == 3 then
        self.internalFormat = gl.GL_RGB
        if self.surface.format.Rmask == 0xff then
            self.formatRGB = gl.GL_RGB
        else
            self.formatRGB = gl.GL_BGR
        end

    elseif self.surface.format.BytesPerPixel == 4 then
        self.internalFormat = gl.GL_RGBA
        if self.surface.format.Rmask == 0xff then
            self.formatRGB = gl.GL_RGBA
        else
            self.formatRGB = gl.GL_BGRA
        end
    end

    gl.glTexImage2D(gl.GL_TEXTURE_2D,
        0, -- level
        self.internalFormat,
        self.surface.w, self.surface.h,
        0, -- border
        self.formatRGB, gl.GL_UNSIGNED_BYTE,
        self.surface.pixels)

    gl.glPixelStorei(gl.GL_UNPACK_ALIGNMENT, 1)

    if config.interpolate then
        gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MIN_FILTER, gl.GL_LINEAR)
        gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MAG_FILTER, gl.GL_LINEAR)
    else
        gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MIN_FILTER, gl.GL_NEAREST)
        gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MAG_FILTER, gl.GL_NEAREST)

    end

    gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_WRAP_S, gl.GL_CLAMP_TO_EDGE)
    gl.glTexParameteri(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_WRAP_T, gl.GL_CLAMP_TO_EDGE)

    gl.glBindTexture(gl.GL_TEXTURE_2D, 0)

    return self
end

function Image:loadSubPixels(pixels, formatRGB, x, y, w, h, texParam, texClamp)
    texParam = texParam or gl.GL_LINEAR
    texClamp = texClamp or gl.GL_CLAMP_TO_EDGE

    self:use()
    do
        self.formatRGB = formatRGB or gl.GL_RGBA

        gl.glTexSubImage2D(gl.GL_TEXTURE_2D,
            0, -- level
            x, y,
            w, h,
            self.formatRGB, gl.GL_UNSIGNED_BYTE,
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

function Image:readPixels(formatAlpha, formatRGB)
    self.formatRGB = formatRGB or gl.GL_RGBA

    self:use()
    do
        gl.glGetTexImage(gl.GL_TEXTURE_2D,
            0,
            self.formatRGB, gl.GL_UNSIGNED_BYTE,
            self.surface.pixels)
    end
    self:unuse()
end

function Image:use(index)
    if gl.glIsTexture(self.texture_id) == gl.GL_TRUE then
        gl.glBindTexture(gl.GL_TEXTURE_2D, self.texture_id)
        gl.glActiveTexture(index or gl.GL_TEXTURE0)
    else
        error('no valid texture')
    end
end

function Image:unuse()
    gl.glBindTexture(gl.GL_TEXTURE_2D, 0)
end

function Image:createFramebuffer()
    -- The framebuffer, which regroups 0, 1, or more textures, and 0 or 1 depth buffer
    if self.framebufferName == nil then
        self.framebufferName = gl.glGenFramebuffer()
        gl.glBindFramebuffer(gl.GL_FRAMEBUFFER, self.framebufferName)
    end
    return self.framebufferName
end

function Image:createColorBuffer(w, h)
    -- The color buffer
    if self.colorRenderbuffer == nil then
        self.colorRenderbuffer = gl.glGenRenderbuffer()
        gl.glBindRenderbuffer(gl.GL_RENDERBUFFER, self.colorRenderbuffer)
        gl.glRenderbufferStorage(gl.GL_RENDERBUFFER, gl.GL_RGBA, w, h)
        gl.glBindRenderbuffer(gl.GL_RENDERBUFFER, engine.defaultRenderBuffer or 0)
        gl.glFramebufferRenderbuffer(gl.GL_FRAMEBUFFER, gl.GL_COLOR_ATTACHMENT0, gl.GL_RENDERBUFFER, self.colorRenderbuffer)
    end
    return self.colorRenderbuffer
end

function Image:createDepthBuffer(w, h)
    -- The depth buffer
    if self.depthRenderbuffer == nil then
        self.depthRenderbuffer = gl.glGenRenderbuffer()
        gl.glBindRenderbuffer(gl.GL_RENDERBUFFER, self.depthRenderbuffer)
        gl.glRenderbufferStorage(gl.GL_RENDERBUFFER, gl.GL_DEPTH_COMPONENT24, w, h)
        gl.glBindRenderbuffer(gl.GL_RENDERBUFFER, engine.defaultRenderBuffer or 0)
        gl.glFramebufferRenderbuffer(gl.GL_FRAMEBUFFER, gl.GL_DEPTH_ATTACHMENT, gl.GL_RENDERBUFFER, self.depthRenderbuffer)
    end
    return self.depthRenderbuffer
end

function Image:attachTexture2D(renderedTexture)
    -- Set "renderedTexture" as our colour attachement #0
    gl.glFramebufferTexture2D(gl.GL_FRAMEBUFFER, gl.GL_COLOR_ATTACHMENT0, gl.GL_TEXTURE_2D, renderedTexture, 0)

    -- Set the list of draw buffers
    gl.glDrawBuffer(gl.GL_COLOR_ATTACHMENT0)

    if gl.glCheckFramebufferStatus(gl.GL_FRAMEBUFFER) ~= gl.GL_FRAMEBUFFER_COMPLETE then
        error('glCheckFramebufferStatus')
    end
end

function Image:release()
    if gl.glIsTexture(self.texture_id) == gl.GL_TRUE then
        gl.glDeleteTexture(self.texture_id)
        self.texture_id = -1
        self.surface.pixels = nil
    end

    if self.framebufferName then
        gl.glDeleteFramebuffer(self.framebufferName)
        self.framebufferName = nil
    end

    if self.colorRenderbuffer then
        gl.glDeleteRenderbuffer(self.colorRenderbuffer)
        self.colorRenderbuffer = -1
    end

    if self.depthRenderbuffer then
        gl.glDeleteRenderbuffer(self.depthRenderbuffer)
        self.depthRenderbuffer = -1
    end
end
