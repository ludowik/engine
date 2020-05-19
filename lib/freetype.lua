include_dirs = '/Library/Frameworks/FreeType.framework/Headers'

if os.name == 'osx' then
    os.execute([[
        gcc -arch x86_64 -m64 -Wmissing-field-initializers -W -Wall -g -fPIC -shared\
            -I /Library/Frameworks/FreeType.framework/Headers\
            -o lib/freetype.so lib/freetype.c /Library/Frameworks/FreeType.framework/FreeType
    ]])
else
    io.write('compile.bat', [[
        set path=%path%;C:/Tools/MinGW/bin;
        gcc.exe -Wmissing-field-initializers -W -Wall -g -fPIC -shared -I "C:/Users/lmilhau/Documents/Persos/Mes Projets Persos/Libraries/freetype/include" -o lib/freetype.dll lib/freetype.c "C:/Users/lmilhau/Documents/Persos/Mes Projets Persos/Libraries/freetype/win32/freetype.dll"
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

class 'FreeType' : meta(ffi.load('./lib/freetype.dll'))

function FreeType:setup()
    self.hLib = self.init_module()
    self.hFont = self.load_font(self.hLib, '/Users/lca/Projets/Lua/engine/res/fonts/Arial.ttf', 8)
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
