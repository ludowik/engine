in vec3 position;
in vec3 normal;
in vec4 color;
in vec2 texCoord;

in mat4 modelMatrixInstance;
in vec4 colorInstance;
in float widthInstance;

out vec3 vPosition;
out vec3 vNormal;
out vec4 vColor;
out vec2 vTexCoord;

void main() {
    gl_Position = vec4(position, 1.0);
    
    vPosition = position;
    vTexCoord = texCoord;
    vColor = color;
}
