include_dirs = '/Library/Frameworks/FreeType.framework/Headers'

if os.name == 'osx' then

    ft = Library.compileFile('lib/freetype.c',
        'ft',
        '-I /Library/Frameworks/FreeType.framework/Headers',
        '/Library/Frameworks/FreeType.framework/FreeType')

else

    ft = Library.compileFile('lib/freetype.c',
        'ft',
        '-I "'..Path.libraryPath..'/Libraries/freetype/include"',
        '-L"'..Path.libraryPath..'/Libraries/freetype/win32" -lfreetype')

end

local code, defs = precompile(io.read('./lib/freetype.h'))
ffi.cdef(code)

if os.name == 'windows' then
    ffi.load(Path.libraryPath..'/Libraries/freetype/win32/freetype.dll')
end

class 'FreeType' : meta(ft)

function FreeType:setup()
    self.hLib = self.init_module()
    self.hFont = false

    self.hFonts = Table()

    self:setFont()
end

function FreeType:setFontName(fontName)
    self:setFont(fontName, self.fontSize)
end

function FreeType:setFontSize(fontSize)
    self:setFont(self.fontName, fontSize)
end

function FreeType:setFont(fontName, fontSize)
    self.fontName = fontName or 'JetBrainsMono-Regular'
    self.fontSize = fontSize or 12
    
    self.fontRef = self.fontName..'.'..self.fontSize

    self.fontPath = Path.sourcePath..'/res/fonts/'..self.fontName..'.ttf'

    if not self.hFonts[self.fontRef] then

        self.hFonts[self.fontRef] = self.load_font(self.hLib, self.fontPath, self.fontSize)
    end

    self.hFont = self.hFonts[self.fontRef]
end

function FreeType:release()
    log('release '..self.hFonts:getnKeys()..' fonts')
    
    for k,hFont in pairs(self.hFonts) do
        self.release_font(hFont)
    end
    self.release_module(self.hLib)
end

function FreeType:update(dt)
end

function FreeType:draw()
end

ft = FreeType()
