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
    mat4 mm = modelMatrix;
    if (false) {
        mm = modelMatrix;
    } else {
        mm = modelMatrixInstance;
    }
    
    vec4 worldPosition = mm * vec4(position, 1.0);
    vec3 worldNormal = (mm * vec4(normal, 0.0)).xyz;
    
    gl_Position = projectionViewMatrix * worldPosition;
    
    vPosition = worldPosition.xyz;
    vNormal = worldNormal;
    
    vTexCoord = texCoord;
    
    if (useUniformColor == 2) {
        vColor = fillColor;
    } else if (useUniformColor == 1) {
        vColor = colorInstance; //uniformColor;
    } else {
        vColor = color;
    }
}
