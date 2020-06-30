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
