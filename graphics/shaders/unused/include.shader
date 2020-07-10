// colors
vec4 white = vec4(1.0, 1.0, 1.0, 1.0);

vec4 red   = vec4(1.0, 0.0, 0.0, 1.0);
vec4 green = vec4(0.0, 1.0, 0.0, 1.0);
vec4 blue  = vec4(0.0, 0.0, 1.0, 1.0);

vec4 transparent = vec4(0.0, 0.0, 0.0, 0.0);

// math
#define PI 3.14159265359

// pvm matrix
uniform mat4 modelMatrix;
uniform mat4 projectionViewMatrix;

// camera
uniform vec3 cameraPosition;

// uniform color
uniform int useUniformColor = 0;
uniform vec4 uniformColor;

uniform vec4 fillColor;
uniform vec4 strokeColor;

// texture
uniform int useTexture = 0;
uniform sampler2D tex;

// cel shading
uniform int useCelShading = 0;

// lights
uniform int useLight = 0;
struct Light {
    int on;
    
    vec3 position;
    vec4 color;
    vec3 direction;
    
    float ambientStrength;
    float diffuseStrength;
    float specularStrength;
    
    float constant;
    float linear;
    float quadratic;
    
    float innerCutOff;
    float outerCutOff;
};
uniform Light lights[10];

// material
struct Material {
    float ambientStrength;
    float diffuseStrength;
    float specularStrength;
    
    float shininess;
    
    float alpha;
};
uniform Material material;

// time
uniform float time;
