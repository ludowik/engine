in vec3 vPosition;
in vec3 vNormal;
in vec4 vColor;
in vec2 vTexCoord;

out vec4 glFragColor;

void main() {
    glFragColor = vec4(vColor.rgb, texture(tex, vTexCoord).a);
}
