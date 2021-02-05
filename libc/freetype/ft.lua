require 'libc.freetype.verra'

class('libFreeType')

function libFreeType.initModule(dpi)
    local library = ffi.new('FT_Library[1]')

    local error = ftLib.FT_Init_FreeType(library)
    if error == 1 then
        return nil
    end
    libFreeType.dpi = dpi

    return library[0]
end

function libFreeType.releaseModule(library)
    ftLib.FT_Done_FreeType(library)
end

local char_ratio = 64

function libFreeType.loadFont(library, font_name, font_size)
    local face = ffi.new('FT_Face[1]')
    
    local error = ftLib.FT_New_Face(library, ffi.string(font_name), 0 , face)

    if error == 1 then
        print('Unknown font '..font_name..' : use vera font')
        local addr = ffi.cast('const FT_Byte*', Vera_ttf:tobytes())
        error = ftLib.FT_New_Memory_Face(library,
            addr, -- first byte in memory
            #Vera_ttf,          -- size in bytes
            0,                  -- face_index
            face)

        if error == 1 then
            return nil
        end
    end

    ftLib.FT_Set_Char_Size(
        face[0],                -- handle to face object
        0,                      -- char_width in 1/64th of points
        font_size * char_ratio, -- char_height in 1/64th of points
        libFreeType.dpi,           -- horizontal device resolution
        0)                      -- vertical device resolution

    return face[0]
end

function libFreeType.releaseFont(face)
    ftLib.FT_Done_Face(face)
end

local BytesPerPixel = 4

function libFreeType.loadText(face, text)
    local glyph = {
        w = 0,
        h = 0,

        size = 0,

        pixels = nil,

        format = {
            BytesPerPixel = 0,
            rmask = 0
        }
    }

    if face == nil or text == nil then
        return glyph
    end

    local metrics = face.size.metrics
    local slot = face.glyph    
    
    local H = floor(tonumber(metrics.ascender - metrics.descender) / char_ratio)

    local x, w, h, top, bottom, dy = 0, 0, 0, 0, 0, 0

    local space_width = 8

    for char in utf8.gensub(text) do
        local error = ftLib.FT_Load_Char(face, utf8.byte(char), ftLib.FT_LOAD_RENDER)
        if error == 0 then
            w = w + max(0, slot.bitmap_left)
            if char == ' ' then
                w = w + space_width
            else
                w = w + slot.bitmap.width
            end

            top = max(top, slot.bitmap_top)
            bottom = max(bottom, slot.bitmap.rows - slot.bitmap_top)
        else
            error()
        end
    end

    top = floor(max(top, abs(tonumber(metrics.ascender)) / char_ratio))
    bottom = floor(max(bottom, abs(tonumber(metrics.descender)) / char_ratio))

    h = max(top + bottom, H)

    dy = floor(max(0, H - (top + bottom) - 2) / 2)

    local size = w * h * ffi.sizeof('GLubyte') * BytesPerPixel

    local pixels = ffi.new('GLubyte[?]', size)

    for char in utf8.gensub(text) do
        local error = ftLib.FT_Load_Char(face, utf8.byte(char), ftLib.FT_LOAD_RENDER)
        if error == 0 then
            local index_bitmap = 0
            for j=0,slot.bitmap.rows-1 do
                local index = (h-1 - (j + top - slot.bitmap_top + dy)) * w + x + max(0, slot.bitmap_left)

                if index >= 0 and index < size then
                    if BytesPerPixel == 4 then
                        for i=0,slot.bitmap.width-1 do
                            pixels[(index+i)*BytesPerPixel+3] = slot.bitmap.buffer[index_bitmap+i]
                        end
                    else
                        ffi.C.memcpy(pixels+index, slot.bitmap.buffer+index_bitmap, slot.bitmap.width)
                    end
                else
                    print("car = %c, %d, %d, %d, %d, %d, %d, %d, %d, %d\n", char, index, x, w, h, j, top, slot.bitmap_top, max(0, slot.bitmap_left), size)
                    error()
                end

                index_bitmap = index_bitmap + slot.bitmap.width
            end
        end

        x = x + max(0, slot.bitmap_left)
        if char == ' ' then
            x = x + space_width
        else
            x = x + slot.bitmap.width
        end
    end

    glyph.w = w
    glyph.h = h

    glyph.size = size

    glyph.pixels = pixels

    glyph.format.BytesPerPixel = BytesPerPixel
    glyph.format.Rmask = 0xff

    return glyph
end

function libFreeType.releaseText(glyph)
    if glyph.pixels then
        glyph.pixels = nil
    end
end

return libFreeType
