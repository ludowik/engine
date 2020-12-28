local FreeType = class('FreeType')
require 'libc.ft.freetype'

local srcPath, lib = ...
if osx then
    lib = 'FreeType.framework/FreeType'
else
    lib = '../../Libraries/bin/freetype'
end

function FreeType.setup()
    ft = FreeType()
end

function FreeType:init()
    self.defs = Lib(srcPath, 'ft', lib, FreeType.defsContent(), nil, false, true, false)
    self.defs:loadLib()

    local pointer = ffi.new('FT_Library[1]')
    self.defs.FT_Init_FreeType(pointer)
    self.library = pointer[0]

    self.CurrentFont = nil
end

function FreeType:release()
    self.defs.FT_Done_FreeType(self.library)
end

function FreeType:setFont(name, size)
    name = name or graphics.style.fontName -- font()
    size = size or graphics.style.fontSize -- fontSize()

    local ref = name..'.'..size
    self.CurrentFont = resources.get('font',
        ref,
        FreeType.createFont,
        FreeType.releaseFont,
        false)
end

function FreeType:getFont()
    return self.CurrentFont
end

function FreeType.createFont()
    return FontRenderer()
end

function FreeType.releaseFont(fontRenderer)
    fontRenderer:release()
end

FontRenderer = class('FontRenderer')

function FontRenderer.setup()
    FontRenderer.reverseFactor = 1 / 64
    FontRenderer.ratio = 1

    function adjust(v)
        return tonumber(v) * FontRenderer.reverseFactor
    end
end

function FontRenderer:init(name, size)
    self.fontName = name or font()
    self.fontSize = size or fontSize()

    local fontPath = getFontPath(self.fontName)
    if isFile(fontPath) == false then
        fontPath = getFontPath(DEFAULT_FONT_NAME)
    end

    local pointer = ffi.new('FT_Face[1]')
    assert(ft.defs.FT_New_Face(ft.library, getFullPath(fontPath), 0, pointer) == 0)
    self.face = pointer[0]

    local resolution = FontRenderer.ratio / adjust(1)
--    if config.highDPI then
--        resolution = resolution * 2
--    end

    local pixel_size = math.ceil(self.fontSize * adjust(resolution))
    ft.defs.FT_Set_Pixel_Sizes(pointer[0], 0, pixel_size)

--    ft.defs.FT_Set_Char_Size(
--      self.face,       -- handle to face object
--      0,               -- char_width in 1/64th of points
--      pixel_size * 72 / 64, -- char_height in 1/64th of points
--      800,             -- horizontal device resolution
--      600);

    self.glyphs = {}

    local marge = 2
    local wg, hg, baseline = 0, 0, 0, 0

    for i=0,255 do
        local glyph = self:getGlyph(i)

        wg = max(wg, glyph.dx)
        hg = max(hg, 2 * glyph.y + glyph.by1 + glyph.by2)

        baseline = max(baseline, glyph.y + glyph.by1)
    end

    self.width = wg
    self.height = hg

    self.baseline = baseline
end

function FontRenderer:getGlyph(i)
    if self.glyphs[i] then
        return self.glyphs[i]
    end

    ft.defs.FT_Load_Char(self.face, i, ft.defs.FT_LOAD_RENDER)
    local g = self.face.glyph

    self.glyphs[i] = {
        x = max(0, adjust(g.metrics.horiBearingX)),
        y = max(0, adjust(g.metrics.vertBearingY)),

        dx = adjust(g.metrics.horiAdvance),
        dy = adjust(g.metrics.vertAdvance),

        by1 = max(0, adjust(g.metrics.horiBearingY)),
        by2 = max(0, adjust(g.metrics.height) - max(0, adjust(g.metrics.horiBearingY))),

        buffer = g.bitmap.buffer,

        w = g.bitmap.width,
        h = g.bitmap.rows
    }

    local w = g.bitmap.width
    local h = g.bitmap.rows

    local size = w * h * 4

    local pixels = ffi.new('GLubyte[?]', size)
    ffi.C.memset(pixels, 0, ffi.sizeof('GLubyte') * size)

    local index = 0
    for i=1,w do
        for j=1,h do
            if g.bitmap.buffer[index] > 0 then
                pixels[index*4  ] = 255
                pixels[index*4+1] = 255
                pixels[index*4+2] = 255
                pixels[index*4+3] = g.bitmap.buffer[index]
            else
                pixels[index*4  ] = 255
                pixels[index*4+1] = 255
                pixels[index*4+2] = 255
                pixels[index*4+3] = 0
            end
            index = index + 1
        end
    end

    self.glyphs[i].pixels = pixels

    return self.glyphs[i]
end

function FontRenderer:release()
    -- TODO : supprimer les glyph et les bitmaps
    ft.defs.FT_Done_Face(self.face)
end

function FontRenderer:getImage(txt)
    local ref = self.fontName..'.'..self.fontSize..'.'..txt
    return resources.get('font.text',
        ref,
        function (...) return self:createImage(txt) end,
        FontRenderer.releaseImage,
        true)
end

function FontRenderer:createImage(txt)
    txt = txt:left(1024)

    local marge = 2
    local wg, hg = 2 * marge, 0

    local height = self.height
    local rows = height

    local face = self.face
    local glyph

    for i=1,utf8.len(txt) do            
        local char = utf8.unicode(txt, i)
        glyph = self:getGlyph(char)

        if char == string.byte(' ') then
            wg = wg + 2
        elseif char == string.byte('\n') then
            hg = hg + rows
            rows = height
        else
            wg = wg + glyph.dx
        end

        glyph.min_by1 = glyph.min_by1 or min(0, self.baseline - glyph.by1)
        glyph.max_by1 = glyph.max_by1 or max(0, self.baseline - glyph.by1)

        rows = max(rows, glyph.max_by1 + glyph.h)
        height = max(height, rows)
    end

    hg = hg + rows

    local image = image(wg, hg)

    local x, y = marge, 0
    for i=1,utf8.len(txt) do
        local char = utf8.unicode(txt, i)
        glyph = self:getGlyph(char)

        if char == string.byte(' ') then
            x = x + 2
        elseif char == string.byte('\n') then
            x = 0
            y = y + height
        else
--            print(wg, hg, txt, i, char,
--                x + g.x,
--                y + g.baseline_by1,
--                g.w, g.h + g.min_by1)

            image:loadSubPixels(glyph.pixels,
                gl.GL_RGBA,
                x + glyph.x,
                y + glyph.max_by1,
                glyph.w, glyph.h + glyph.min_by1,
                gl.GL_LINEAR,
                gl.GL_CLAMP_TO_BORDER)

            x = x + glyph.dx
        end
    end

    return image
end

function FontRenderer.releaseImage(image)
    image:release()
end

function FontRenderer:getTextSize(txt)
    local image = self:getImage(txt)
    return image.width / FontRenderer.ratio, image.height / FontRenderer.ratio
end

function FontRenderer:getText(txt)
    local image = self:getImage(txt)
    return image, image.width / FontRenderer.ratio, image.height / FontRenderer.ratio
end
