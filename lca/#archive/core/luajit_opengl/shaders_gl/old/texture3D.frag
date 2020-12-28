#version 410 core

uniform int useTexture;
uniform sampler2D tex;

in vec4 vColor;
in vec2 vTexCoord;

out vec4 out_Color;

void main() {
    if (useTexture == 1) {
        out_Color = texture(tex, vTexCoord) * vColor;
    }
}
