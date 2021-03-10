ft = require 'libc.freetype.ft'

class 'FreeType' : extends(Component) : meta(ft)

function FreeType.setup()
    local path = getLibPath('FreeType')

    if ft == nil then
        -- TOFIX
        assert()
        if osx then

            Library.load('freetype')

            ft = Library.compileFile('libc/freetype/freetype.cpp',
                'ft',
                '-I '..path..'/FreeType.Framework/Headers',
                path..'/FreeType.Framework/FreeType',
                '-shared')

        else

            ft = Library.compileFileCPP('libc/freetype/freetype.cpp',
                'ft',
                '-I "'..path..'/include"',
                '-L "'..path..'/win32" -l FreeType',
                '-shared')

        end

    else
        if not love then
            ftLib = Library.load('freetype')
        else
            ftLib = ffi.C
        end
    end

    local code, defs = Library.precompile(io.read('libc/freetype/freetype.h'))
    ffi.cdef(code)
end

function FreeType:initialize()
    self.hLib = self.initModule(sdl.hdpi)
    self.hFont = false

    self.hFonts = Table()

    self:setFont()
end

function FreeType:release()
    for k,hFont in pairs(self.hFonts) do
        self.releaseFont(hFont)
    end
    self.releaseModule(self.hLib)
end

function FreeType:setFontName(fontName)
    self:setFont(fontName, self.fontSize)
    return self.fontName
end

function FreeType:setFontSize(fontSize)
    self:setFont(self.fontName, fontSize)
    return self.fontSize
end

function FreeType:setFont(fontName, fontSize)
    self.fontName = fontName or DEFAULT_FONT_NAME
    self.fontSize = fontSize or DEFAULT_FONT_SIZE

    self.fontRef = self.fontName..'.'..self.fontSize

    self.fontPath = getFullPath(getFontPath(self.fontName))

    if not self.hFonts[self.fontRef] then
        self.hFonts[self.fontRef] = self.loadFont(self.hLib, self.fontPath, self.fontSize)

        if self.hFonts[self.fontRef] == ffi.NULL then
            print('Unknown font '..fontName..' : use default')
            return self:setFontName()
        end
    end

    self.hFont = self.hFonts[self.fontRef]
end

function FreeType:getFont()
    return self.hFont
end

class 'Text'

local maxStrLen = 64

function Text:init(str)
    if utf8.len(str) > maxStrLen then
        str = utf8.sub(str, maxStrLen)
    end
    local surface = ft.loadText(ft.hFont, str)
    self.img = Image():makeTexture(surface)
    ft.releaseText(surface)
end

function Text:get()
    return self.img
end

function Text:release()
    self.img:release()
end

function FreeType:getText(str)
    return resourceManager:get(self.fontRef, str, Text)
end
