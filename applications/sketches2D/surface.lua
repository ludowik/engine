function setup()
    image = Image(W, H)

    vertices = {}
    for i=1,10 do
        local v = vec2(
            randomInt(W),
            randomInt(H)
        )

        table.insert(vertices, v)
    end

    ffi.cdef([[
        void init(int w, int h);
        float get();
        void mafunction(int w, int h, unsigned char* pixels);
    ]])

    libSurface = Library.compileCode(code, 'surface', nil, nil, '-shared')

    libSurface.init(W, H)
end

code = [[
    #include <float.h>
    #include <math.h>
    #include <stdlib.h>

    float min(float a, float b) {
        if (a < b) return a;
        return b;
    }

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

    void init(int w, int h) {
        for(int j = 0; j < n; ++j) {
            vertices[j].x = rand() % w;
            vertices[j].y = rand() % h;
        }

        maxDistance = w * w / 4;
    }

    float get() {
        return vertices[0].x;
    }

    void mafunction(int w, int h, unsigned char* pixels) {

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
]]

function draw()
    background(black)

    if not debugging() then
        local vertex

        local pixels = image.surface.pixels

        local minDistance
        local maxDistance = (W/4)^2

        local maxInteger = math.maxinteger

        local n = #vertices

        local ratio = -255 / maxDistance
        if true then
            libSurface.mafunction(image.surface.w, image.surface.h, image.surface.pixels)
        else
            local i = 0

            local dx, dy

            for y=1,image.surface.h do
                for x=1,image.surface.w do

                    minDistance = maxInteger

                    for j=1,n do
                        vertex = vertices[j]

                        dx = x - vertex.x
                        dy = y - vertex.y

                        dist = dx*dx + dy*dy

                        if dist < minDistance then
                            minDistance = dist
                        end
                    end

                    minDistance = 255 + minDistance * ratio

                    pixels[i  ] = minDistance
                    pixels[i+1] = minDistance
                    pixels[i+2] = minDistance

                    pixels[i+3] = 255

                    i = i + 4

                end
            end
        end

        image:makeTexture()

        sprite(image, 0, 0)
    end

    stroke(red)

    for j=1,#vertices do
        vertex = vertices[j]
        circle(vertex.x, vertex.y, 5)
        vertex:add(vec2(
                random(-2, 2),
                random(-2, 2)))
    end
end
