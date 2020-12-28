#version 410 core

uniform mat4 model;
uniform vec4 color2D;

in vec3 position;
in vec4 color;


out vec4 vColor;

void main() {
    gl_Position = model * vec4(position.xy, 0.0, 1.0);    
    vColor = color2D; // color;
}