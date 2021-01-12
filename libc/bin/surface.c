    #include <float.h>
    #include <math.h>
    #include <stdlib.h>
    
    #ifdef _WIN32
        #define EXPORT __declspec(dllexport)
    #else
        #define EXPORT
    #endif

    #ifndef min
    float min(float a, float b) {
        if (a < b) return a;
        return b;
    }
    #endif
    
    #define n 10

    typedef struct vec2 {
        float x;
        float y;
    } vec2;

    vec2 vertices[n];

    float map(float value, float min1, float max1, float min2, float max2) {
        return min2 + (value - min1) * (max2 - min2) / (max1 - min1);
    }

    float minDistance = 0;
    float maxDistance = 0;

    EXPORT void init(int w, int h) {
        for(int j = 0; j < n; ++j) {
            vertices[j].x = rand() % w;
            vertices[j].y = rand() % h;
        }

        maxDistance = w * w / 4;
    }

    float get() {
        return vertices[0].x;
    }

    EXPORT void mafunction(int w, int h, unsigned char* pixels) {

        int i = 0;

        float dx, dy, dist;

        for(int y = 0; y < h; ++y) {

            for(int x = 0; x < w; ++x) {

                minDistance = FLT_MAX;

                for(int j = 0; j < n; ++j) {

                    dx = x-vertices[j].x;
                    dy = y-vertices[j].y;

                    dist = dx*dx + dy*dy;

                    if (dist < minDistance)
                        minDistance = dist;

                }

                minDistance = map(minDistance, 0, maxDistance, 255, 0);

                pixels[i++] = minDistance;
                pixels[i++] = minDistance;
                pixels[i++] = minDistance;

                pixels[i++] = 255;

            }
        }
    }
