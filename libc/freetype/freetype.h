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

Handle initModule(float dpi);
void releaseModule(Handle lib);

Handle loadFont(Handle lib, const unsigned char* font_name, int font_size);
void releaseFont(Handle face);

Glyph loadText(Handle face, const unsigned char* text);
void releaseText(Glyph glyph);
