#version 410 core

layout(points) in;
layout(triangle_strip, max_vertices = 512) out;

uniform float size[1];
uniform int str[64];

in vec4 geoColor[];

out vec4 color;
out vec2 coordTexture;

const vec2 vertices[] = vec2[](
    vec2(0., 1.),
    vec2(0., 0.),
    vec2(1., 1.),
    vec2(1., 0.)
);

const vec2 texCoords[] = vec2[](
    vec2(0., 0.),
    vec2(0., 1.),
    vec2(1., 0.),
    vec2(1., 1.)
);

float x = 0;
float y = 0;

void draw(int car) {
    float xCoords = 0.;
    float yCoords = 0.;
    
    int r = (car) / 16;
    int c = (car) % 16;
    
    float fontSize = size[0] * 2.;
    
    for (int i = 0 ; i < 4 ; ++i) {
        gl_Position = vec4(
            gl_in[0].gl_Position.x + vertices[i].x * fontSize + x,
            gl_in[0].gl_Position.y + vertices[i].y * fontSize + y,
            gl_in[0].gl_Position.z,
            gl_in[0].gl_Position.a);
        
        color = geoColor[0];
        
        xCoords = texCoords[i].x;
        if ( xCoords == 0 )
            xCoords += 0.3;
        else
            xCoords -= 0.3;

        yCoords = texCoords[i].y;
        if ( yCoords == 0 )
            yCoords += 0.2;
/*        else
            yCoords -= 0.2;
*/
        coordTexture = vec2(
            c / 16. + xCoords / 16.,
            r / 16. + yCoords / 16.);
        
        EmitVertex();
    }
    
    x += fontSize;
    
    EndPrimitive();
}

void main() {
    int i = 0;

    while ( str[i] != 0 ) {
        draw(str[i]);
        i++;
    }
}