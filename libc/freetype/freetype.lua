if os.name == 'osx' then

    local path = Path.libraryPath..'/FreeType'

    Library.load('freetype')

    ft = Library.compileFile('libc/freetype/freetype.c',
        'ft',
        '-I '..path..'/FreeType.Framework/Headers',
        path..'/FreeType.Framework/FreeType')

else

    ft = Library.compileFile('libc/freetype/freetype.c',
        'ft',
        '-I "'..Path.libraryPath..'/FreeType/include"',
        '-L"'..Path.libraryPath..'/FreeType/win32" -lFreeType')

end

local code, defs = Library.precompile(io.read('./libc/freetype/freetype.h'))
ffi.cdef(code)

class 'FreeType' : extends(Component) : meta(ft)

function FreeType:initialize()
    self.hLib = self.initModule(sdl.hdpi)
    self.hFont = false

    self.hFonts = Table()

    self:setFont()
end

function FreeType:release()
    print('release '..self.hFonts:getnKeys()..' fonts')

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

    self.fontPath = Path.sourcePath..'/res/fonts/'..self.fontName..'.ttf'

    if not self.hFonts[self.fontRef] then
        self.hFonts[self.fontRef] = self.loadFont(self.hLib, self.fontPath, self.fontSize)

        if self.hFonts[self.fontRef] == ffi.NULL then
            return self:setFontName()
        end
    end

    self.hFont = self.hFonts[self.fontRef]
end

class 'Text'

local maxStrLen = 64

function Text:init(str)
    if str:len() > maxStrLen then
        str = str:left(maxStrLen)
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
