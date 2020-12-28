#version 410 core

uniform mat4 model;


in vec3 position;

in vec2 texCoord;

out vec2 coordTexture;

void main() {
    gl_Position = model * vec4(position.xy, 0.0, 1.0);
    coordTexture = texCoord;
}