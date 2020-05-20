    void mafunction(int w, int h, unsigned char* pixels) {
        int i = 0;
        for(int x = 0; x < w; ++x) {
            for(int y = 0; y < h; ++y) {
               pixels[i++] = 128;
               pixels[i++] = 128;
               pixels[i++] = 0;
               pixels[i++] = 255;
            }
        }
    }
