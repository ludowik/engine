in vec3 position;
in vec3 normal;
in vec4 color;
in vec2 texCoord;

in mat4 modelMatrixInstance;
in vec4 colorInstance;
in float widthInstance;

out vec3 vPositionG;
out vec3 vNormalG;
out vec4 vColorG;
out vec2 vTexCoordG;

out float strokeWidthG;

void process(vec3 position, vec3 normal) {
    mat4 mm = modelMatrix;
    if (false) {
        mm = modelMatrix;
    } else {
        mm = modelMatrixInstance;
    }
    
    vec4 worldPosition = mm * vec4(position, 1.0);
    vec3 worldNormal = (mm * vec4(normal, 0.0)).xyz;
    
    gl_Position = worldPosition;
    
    vPositionG = worldPosition.xyz;
    vNormalG = worldNormal;
    
    vTexCoordG = texCoord;
    
    if (useUniformColor == 2) {
        vColorG = fillColor;
    } else if (useUniformColor == 1) {
        vColorG = colorInstance; //uniformColor;
    } else {
        vColorG = color;
    }
    
    strokeWidthG = widthInstance;
}

void main() {
    process(position, normal);
}
