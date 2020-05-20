class 'Image'

function Image:init(w, h)
    if w and h then
        self:create(w, h)
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

    self:makeTexture(surface)
end

function Image:makeTexture(surface)
    if surface then
        self.surface = surface
    end

    self.texture_id = self.texture_id or gl.glGenTexture()

    gl.glBindTexture(gl.GL_TEXTURE_2D, self.texture_id)

    local internalFormat = gl.GL_RGBA
    local formatRGB = gl.GL_RGBA

    if self.surface.format.BytesPerPixel == 1 then
        internalFormat = gl.GL_ALPHA
        formatRGB = gl.GL_ALPHA

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

function Image:fragment(f)
    local fragColor

    local fragIndex = 0

    for x=1,self.surface.w do
        for y=1,self.surface.h do

            fragColor = f(x, y)

            self.surface.pixels[fragIndex  ] = fragColor.r * 255
            self.surface.pixels[fragIndex+1] = fragColor.g * 255
            self.surface.pixels[fragIndex+2] = fragColor.b * 255
            self.surface.pixels[fragIndex+3] = fragColor.a * 255
            
            fragIndex = fragIndex + 4

        end
    end

    self:makeTexture()
end
