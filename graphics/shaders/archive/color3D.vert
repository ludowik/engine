#version 410 core

uniform mat4 modelMatrix;
uniform mat4 projectionViewMatrix;

uniform int useUniformColor;
uniform vec4 uniformColor;

in vec3 position;
in vec3 normal;
in vec4 color;
in vec2 texCoord;

out vec3 vPosition;
out vec3 vNormal;
out vec4 vColor;
out vec2 vTexCoord;

void main() {
    vec4 worldPosition = modelMatrix * vec4(position, 1.0);
    vec4 worldNormal = modelMatrix * vec4(normal, 0.0);
    
    gl_Position = projectionViewMatrix * worldPosition;
    
    vPosition = worldPosition.xyz;
    vNormal = worldNormal.xyz;
    
    vTexCoord = texCoord;
    
    if (useUniformColor == 1) {
        vColor = uniformColor;
    } else {
        vColor = color;
    }
}
