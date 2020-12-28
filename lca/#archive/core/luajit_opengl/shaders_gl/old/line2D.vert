#version 410 core

uniform mat4 modelViewProjection;
uniform mat4 model;

uniform int useUniformColor;
uniform vec4 uniformColor;

uniform float strokeWidth;

in vec3 position;
in vec4 color;
in vec3 normal;

out vec4 vColorG;
out vec3 vNormalG;

out float strokeWidthG;

void main() {
    gl_Position = model * vec4(position, 1.0);

    if (useUniformColor == 1) {
        vColorG = uniformColor;
    } else {
        vColorG = color;
    }
    
    vNormalG = normal;
    
    strokeWidthG = strokeWidth;
}