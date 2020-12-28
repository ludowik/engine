in vec3 vPosition;
in vec3 vNormal;
in vec4 vColor;
in vec2 vTexCoord;

out vec4 glFragColor;

void main() {
    float a = texture(tex, vTexCoord).a;
    if (a > 0.0) {
        glFragColor = vec4(vColor.rgb, a);
    }
}
