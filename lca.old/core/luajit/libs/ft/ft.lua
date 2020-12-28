local ft = class()

function ft:init(defs)
    ft.defs = defs

    local pointer = ffi.new('FT_Library[1]')
    ft.defs.FT_Init_FreeType(pointer)
    ft.library = pointer[0]

    self.fontName = defaultFontName
    self.fontSize = defaultFontSize

    self:initFont(self.fontName, self.fontSize)
end

function ft:release()   
    ft.defs.FT_Done_FreeType(ft.library)
end

function ft:__tostring()
    if self.txt == nil then
        return self.fontName..'.'..self.fontSize
    end
    return self.fontName..'.'..self.fontSize..'.'..self.txt
end

function ft:initFont(fontName, fontSize)
    self.fontName = fontName or self.fontName
    self.fontSize = fontSize or self.fontSize

    self.txt = nil
    self.currentFont = resources.get('fontFT', 
        self,
        ft.createFont,
        ft.releaseFont,
        false)
end

local function adjust(v)
    return floor(tonumber(v) / 64)
end

function ft.createFont(self)
    local fontPath = getFontPath(self.fontName)
    if isFile(fontPath) == false then
        fontPath = getFontPath(defaultFontName)
    end

    local pointer = ffi.new('FT_Face[1]')
    ft.defs.FT_New_Face(ft.library, fontPath, 0, pointer)

    local resolution = 80
    local pixel_size = ceil(self.fontSize * resolution / 72)
    ft.defs.FT_Set_Pixel_Sizes(pointer[0], 0, pixel_size)

    local font = {}
    font.face = pointer[0]

    local wg, bg, up, down = 0, 0, 0, 0

    for i=1,256 do
        ft.defs.FT_Load_Char(font.face, i, ft.defs.FT_LOAD_RENDER)
        local g = font.face.glyph

        local w = g.bitmap.width
        local h = g.bitmap.rows -- adjust(g.metrics.height)

        local baseline = h - adjust(g.metrics.horiBearingY)
        bg = max(bg, baseline)

        wg = max(wg, adjust(g.metrics.horiAdvance))

        up = max(up, adjust(g.metrics.horiBearingY))
        down = max(down, h - adjust(g.metrics.horiBearingY))        
    end

    font.baseline = bg
    font.height = up + down
    font.width = wg

    return font
end

function ft.releaseFont(font)
    ft.defs.FT_Done_Face(font.face)
end

function ft:getWidth(str)
    local w, h = system.textSize(self, str)
    return w
end
function ft:getHeight(str)
    local w, h = system.textSize(self, str)
    return h
end

function ft.createImage(ref, computeSizeOnly)
    local wg, hg = 0, 0, 0, 0

    local font = ref.currentFont

    local face = font.face
    local g = face.glyph

    hg = font.height

    for i=1,#ref.txt do
        local char = string.byte(ref.txt, i)
        if char == string.byte(' ') then
            wg = wg + 2
        elseif char == string.byte('\n') then
            hg = hg + font.height
        else
            ft.defs.FT_Load_Char(face, char, ft.defs.FT_LOAD_RENDER)

            local w = g.bitmap.width
            local h = g.bitmap.rows -- adjust(g.metrics.height)

            wg = wg + w -- adjust(g.metrics.horiAdvance)
        end
    end

    local image = image(wg, hg)

    if not computeSizeOnly then
        local x, y = 0, 0
        for i=1,#ref.txt do
            local char = string.byte(ref.txt, i)
            if char == string.byte(' ') then
                x = x + 2
            elseif char == string.byte('\n') then
                x = 0
                y = y + font.height
            else
                ft.defs.FT_Load_Char(face, char, ft.defs.FT_LOAD_RENDER)

                local w = g.bitmap.width
                local h = g.bitmap.rows -- adjust(g.metrics.height)

                local baseline = h - adjust(g.metrics.horiBearingY)

                local pixels = ffi.new('GLubyte[?]', w*h*4)
                ffi.C.memset(pixels, 0, ffi.sizeof("GLubyte")*w*h*4)

                local index = 0
                for i=1,w do
                    for j=1,h do
                        if g.bitmap.buffer[index] > 0 then
                            pixels[index*4] = 255
                            pixels[index*4+1] = 255
                            pixels[index*4+2] = 255
                            pixels[index*4+3] = g.bitmap.buffer[index]
                        end
                        index = index + 1
                    end
                end

                gl.glPixelStorei(gl.GL_UNPACK_ALIGNMENT, 1)

                assert(x + w <= wg, 'width error', x + w, wg)
                assert(font.height - h - font.baseline + baseline + h <= font.height, 'height error')

                image:loadSubPixels(pixels, gl.GL_RGBA,
                    x,
                    y + font.height-h-font.baseline+baseline,
                    w, h)

                x = x + w -- adjust(g.advance.x)
                y = y + adjust(g.advance.y)
            end
        end
    end

    return image
end

function ft:style(font, style)
    -- TTF_STYLE_NORMAL : normal ;
    -- TTF_STYLE_BOLD : gras ;
    -- TTF_STYLE_ITALIC : italique ;
    -- TTF_STYLE_UNDERLINE
end

return ft
