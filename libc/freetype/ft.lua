require 'libc.freetype.verra'

local dpi

local ft = class('ft')

function ft.initModule(_dpi)
    local library = ffi.new('FT_Library[1]')

    local error = ftLib.FT_Init_FreeType(library)
    if error == 1 then
        return nil
    end
    dpi = _dpi

    return library[0]
end

function ft.releaseModule(library)
    ftLib.FT_Done_FreeType(library)
end

function ft.loadFont(library, font_name, font_size)
    local face = ffi.new('FT_Face[1]')
    
    local error = ftLib.FT_New_Face(library, ffi.string(font_name), 0 , face)

    if error == 1 then
        print('Unknown font : use vera font')
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

    local char_ratio = 64

    ftLib.FT_Set_Char_Size(
        face[0],                -- handle to face object
        0,                      -- char_width in 1/64th of points
        font_size * char_ratio, -- char_height in 1/64th of points
        dpi,                    -- horizontal device resolution
        0)                      -- vertical device resolution

    return face[0]
end

function ft.releaseFont(face)
    ftLib.FT_Done_Face(face)
end

local BytesPerPixel = 4

function ft.loadText(face, text)
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

    local slot = face.glyph

    local H = floor(tonumber(face.size.metrics.ascender - face.size.metrics.descender) / 64)

    local x, w, h, top, bottom, dy = 0, 0, 0, 0, 0, 0

    local space_width = 8

    local len = text:len()
    for n=1,len do
        local char = text:sub(n, n)
        local error = ftLib.FT_Load_Char(face, char:byte(1), ftLib.FT_LOAD_RENDER)
        slot = face.glyph
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

    top = floor(max(top, abs(face.ascender) / 64))
    bottom = floor(max(bottom, abs(face.descender) / 64))

    h = max(top + bottom, H)

    dy = floor(max(0, H - (top + bottom) - 2) / 2)

    local size = w * h * ffi.sizeof('GLubyte') * BytesPerPixel

    local pixels = ffi.new('GLubyte[?]', size)

    for n=1,len do
        local char = text:sub(n, n)
        local error = ftLib.FT_Load_Char(face, char:byte(1), ftLib.FT_LOAD_RENDER)
        slot = face.glyph
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

function ft.releaseText(glyph)
    if glyph.pixels then
--        ffi.C.free(glyph.pixels)
        glyph.pixels = nil
    end
end

return ft
