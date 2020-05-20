include_dirs = '/Library/Frameworks/FreeType.framework/Headers'

if os.name == 'osx' then
    os.execute([[
        gcc -m64 -shared \
            -I /Library/Frameworks/FreeType.framework/Headers \
            -o bin/freetype.so lib/freetype.c /Library/Frameworks/FreeType.framework/FreeType
    ]])
else
     os.execute([[
        gcc.exe -shared -I "C:/Users/lmilhau/Documents/Persos/Mes Projets Persos/Libraries/freetype/include" -o bin/ft.dll lib/freetype.c -L"C:/Users/lmilhau/Documents/Persos/Mes Projets Persos/Libraries/freetype/win32" -lfreetype
    ]])
    
end

ffi.cdef([[
    typedef void* Handle;
    typedef unsigned char GLubyte;

    typedef struct {
        int w;
        int h;
        int size;
        GLubyte* pixels;
        struct {
            int BytesPerPixel;
            unsigned int Rmask;
            } format;
        } Glyph;

    Handle init_module();
    void release_module(Handle lib);

    Handle load_font(Handle lib, const char* font_name, int font_size);
    void release_font(Handle face);

    Glyph load_text(Handle face, const char* text);
    void release_text(Glyph glyph);
]])

ffi.load('C:/Users/lmilhau/Documents/Persos/Mes Projets Persos/Libraries/freetype/win32/freetype.dll')

class 'FreeType' : meta(ffi.load('./bin/ft.dll'))

function FreeType:setup()
    self.hLib = self.init_module()
    if os.name == 'osx' then
        self.hFont = self.load_font(self.hLib, '/Users/lca/Projets/Lua/engine/res/fonts/Arial.ttf', 8)
    else
        self.hFont = self.load_font(self.hLib, 'C:/Users/lmilhau/Documents/Persos/Mes Projets Persos/Lua/engine/res/fonts/Arial.ttf', 8)
    end
end

function FreeType:release()
    self.release_font(self.hFont)
    self.release_module(self.hLib)
end

function FreeType:update(dt)
end

function FreeType:draw()
end

ft = FreeType()
