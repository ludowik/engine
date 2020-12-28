#version 410 core

uniform sampler2D tex;

in vec4 color;
in vec2 coordTexture;

out vec4 out_Color;

void main() {
    out_Color = texture(tex, coordTexture) * color;
}