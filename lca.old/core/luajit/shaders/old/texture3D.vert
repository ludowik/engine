#version 410 core

uniform mat4 modelMatrix;
uniform mat4 projectionViewMatrix;

uniform int useUniformColor;
uniform vec4 uniformColor;

in vec3 position;
in vec4 color;
in vec2 texCoord;

out vec4 vColor;
out vec2 vTexCoord;
        
void main() {
    gl_Position = projectionViewMatrix * modelMatrix * vec4(position, 1.0);
    
    if (useUniformColor == 1) {
        vColor = uniformColor;
    } else {
        vColor = color;
    }
    vTexCoord = texCoord;
}