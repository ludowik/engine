#include <ft2build.h>
#include <freetype/freetype.h>

#ifndef min
#define min(a,b) (((a) < (b)) ? (a) : (b))
#define max(a,b) (((a) > (b)) ? (a) : (b))
#endif

FT_Error error;

typedef unsigned char GLubyte;

FT_Library init_module() {
    FT_Library library;
    
    error = FT_Init_FreeType(&library);
    if (error)
        return NULL;
        
    return (FT_Library)library;
}

void release_module(FT_Library library) {
    FT_Done_FreeType(library);
}

FT_Face load_font(FT_Library library, const char* font_name, int font_size) {
    FT_Face face;
    
    error = FT_New_Face(library, font_name, 0 , &face);
    
    if (error)
        return NULL;
        
    FT_Set_Char_Size(
      face,           /* handle to face object           */
      0,              /* char_width in 1/64th of points  */
      font_size * 64, /* char_height in 1/64th of points */
      132,             /* horizontal device resolution    */
      0);             /* vertical device resolution      */
      
    return (FT_Face)face;
}

void release_font(FT_Face face) {
    FT_Done_Face(face);
}

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

#define bitmap_left (max(0, (int)slot->bitmap_left))
#define bitmap_top  ((int)slot->bitmap_top)

#define bitmap_width ((int)slot->bitmap.width)
#define bitmap_rows  ((int)slot->bitmap.rows)

#define bitmap_buffer slot->bitmap.buffer

int BytesPerPixel = 4;

Glyph load_text(FT_Face face, const char* text) {
    Glyph glyph = {0, 0, 0, NULL, {0, 0}};
    if (face == NULL || text == NULL)
        return glyph;

    FT_GlyphSlot slot = face->glyph;
    
    int H = (face->ascender + face->descender) / 26;
    
    int x=0, w=0, h=0, top=0, bottom=0, dy=0;
    
    int space_width = 5;

    size_t len = strlen(text);
    for ( size_t n = 0; n < len; ++n ) {
        error = FT_Load_Char(face, text[n], FT_LOAD_RENDER);
        if (error)
            continue;

        w += bitmap_left;
        if (text[n] == ' ')
            w += space_width;
        else
            w += bitmap_width;

        top = max(top, bitmap_top);
        bottom = max(bottom, bitmap_rows - bitmap_top);
    }
    
    h = max(top + bottom, H);
    
    dy = max(0, H - (top + bottom) - 2) / 2;

    int size = w * h * sizeof(GLubyte) * BytesPerPixel;
    GLubyte* pixels = calloc(1, size);

    for ( size_t n = 0; n < len; ++n ) {
        error = FT_Load_Char(face, text[n], FT_LOAD_RENDER);
        if (error) {
            continue;
        }

        int index_bitmap = 0;
        for ( int j = 0; j < bitmap_rows; ++j ) {
            int index = (h-1 - (j + top - bitmap_top + dy)) * w + x + bitmap_left;

            if (index >= 0 && index < size) {
                if (BytesPerPixel == 4) {
                    for ( int i = 0; i < bitmap_width; ++i ) {
                        pixels[(index+i)*BytesPerPixel+3] = bitmap_buffer[index_bitmap+i];
                    }
                } else {
                    memcpy(&pixels[index], &bitmap_buffer[index_bitmap], bitmap_width);
                }
            } else {
                printf("car = %c, %d, %d, %d, %d, %d, %d, %d, %d, %d\n", text[n], index, x, w, h, j, top, bitmap_top, bitmap_left, size);
                exit(-1);
            }

            index_bitmap += bitmap_width;
        }

        x += bitmap_left;
        if (text[n] == ' ')
            x += space_width;
        else
            x += bitmap_width;
    }

    glyph.w = w;
    glyph.h = h;
    glyph.size = size;
    glyph.pixels = pixels;

    glyph.format.BytesPerPixel = BytesPerPixel;
    glyph.format.Rmask = 0xff;

    return glyph;
}

void release_text(Glyph glyph) {
    if (glyph.pixels)
        free(glyph.pixels);
}
