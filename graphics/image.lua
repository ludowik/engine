class 'Image'

function Image:init()
end

function Image:makeTexture(surface)
    self.surface = surface
    
    self.texture_id = gl.glGenTexture()
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
end

function Image:use(index)
    assert(self.texture_id > 0)

    gl.glBindTexture(gl.GL_TEXTURE_2D, self.texture_id)
    gl.glActiveTexture(index or gl.GL_TEXTURE0)
end

function Image:unuse()
    gl.glBindTexture(gl.GL_TEXTURE_2D, 0)
end
