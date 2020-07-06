include_dirs = '/Library/Frameworks/FreeType.framework/Headers'

if os.name == 'osx' then

    ft = Library.compileFile('libc/freetype.c',
        'ft',
        '-I /Library/Frameworks/FreeType.framework/Headers',
        '/Library/Frameworks/FreeType.framework/FreeType')

else

    ft = Library.compileFile('libc/freetype.c',
        'ft',
        '-I "'..Path.libraryPath..'/Libraries/freetype/include"',
        '-L"'..Path.libraryPath..'/Libraries/freetype/win32" -lfreetype')

end

local code, defs = precompile(io.read('./libc/freetype.h'))
ffi.cdef(code)

if os.name == 'windows' then
    ffi.load(Path.libraryPath..'/Libraries/freetype/win32/freetype.dll')
end

class 'FreeType' : extends(Component) : meta(ft)

function FreeType:initialize()
    self.hLib = self.init_module()
    self.hFont = false

    self.hFonts = Table()
    
    self.frame = 0

    self:setFont()
end

function FreeType:release()
    print('release '..self.hFonts:getnKeys()..' fonts')

    for k,hFont in pairs(self.hFonts) do
        self.release_font(hFont)
    end
    self.release_module(self.hLib)
end

function FreeType:setFontName(fontName)
    self:setFont(fontName, self.fontSize)
end

function FreeType:setFontSize(fontSize)
    self:setFont(self.fontName, fontSize)
end

DEFAULT_FONT_NAME = 'JetBrainsMono-Regular'
DEFAULT_FONT_SIZE = 12

function FreeType:setFont(fontName, fontSize)
    self.fontName = fontName or DEFAULT_FONT_NAME
    self.fontSize = fontSize or DEFAULT_FONT_SIZE

    self.fontRef = self.fontName..'.'..self.fontSize

    self.fontPath = Path.sourcePath..'/res/fonts/'..self.fontName..'.ttf'

    if not self.hFonts[self.fontRef] then
        self.hFonts[self.fontRef] = self.load_font(self.hLib, self.fontPath, self.fontSize)

        if self.hFonts[self.fontRef] == ffi.NULL then
            return self:setFontName()
        end
    end

    self.hFont = self.hFonts[self.fontRef]
end

local images = {}

function FreeType:getText(str)
    local ref = self.fontRef..'.'..str

    if not images[ref] then
        local surface = self.load_text(self.hFont, str)
        images[ref] = {
            img = Image():makeTexture(surface),
            count = 1,
            frame = self.frame
        }
        ft.release_text(surface)
    else
        images[ref].count = images[ref].count + 1
        images[ref].frame = self.frame
    end

    return images[ref].img
end

function FreeType:releaseText(str)
--    local ref = self.fontRef..'.'..str
--    if  images[ref] then
--        images[ref].count = images[ref].count - 1
--    end
end

function FreeType:update(dt)
    for k,v in pairs(images) do
        if v.frame < self.frame - 60 then
            v.img:release()
            images[k] = nil
        end
    end
    self.frame = self.frame + 1
end
