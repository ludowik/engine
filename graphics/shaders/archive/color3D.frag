#version 410 core

vec4 red   = vec4(1.0, 0.0, 0.0, 1.0);
vec4 green = vec4(0.0, 1.0, 0.0, 1.0);
vec4 blue  = vec4(0.0, 0.0, 1.0, 1.0);

// material settings
uniform sampler2D materialTex;
uniform float materialShininess = 80.0f;
uniform vec3 materialSpecularColor = vec3(1.0f, 1.0f, 1.0f);

uniform mat4 modelMatrix;
uniform mat4 projectionViewMatrix;

uniform vec3 cameraPosition;

uniform int useLight;
struct light {
    vec3 position;
    vec4 ambientColor;
    vec3 coneDirection;
    float ambientCoefficient;
    float attenuation;
    float coneAngle;
    float directionalLight;
};

uniform light ambientLight[10];

in vec3 vPosition;
in vec3 vNormal;
in vec4 vColor;

out vec4 finalColor;

void main() {
    if (useLight > 0) {
        finalColor = vec4(0);
        
        vec3 normal = normalize(transpose(inverse(mat3(modelMatrix))) * vNormal);
        
        vec3 surfacePos = vec3(modelMatrix * vec4(vPosition, 1));
        vec4 surfaceColor = vColor; // texture(materialTex, fragTexCoord);
        vec3 surfaceToCamera = normalize(cameraPosition - surfacePos);
        
        for (int i=0; i<useLight ; ++i) {
            vec3 ambientColor = ambientLight[i].ambientColor.rgb;

            vec3 surfaceToLight;
            float attenuation = 1.0;
            
            if (ambientLight[i].directionalLight == 1.0f) {
                // directional light
                surfaceToLight = normalize(ambientLight[i].position.xyz);
                attenuation = 1.0; //no attenuation for directional lights
            } else {
                // point light
                surfaceToLight = normalize(ambientLight[i].position.xyz - surfacePos);
                float distanceToLight = length(ambientLight[i].position.xyz - surfacePos);
                attenuation = 1.0 / (1.0 + ambientLight[i].attenuation * pow(distanceToLight, 2));

                // cone restrictions (affects attenuation)
                float lightToSurfaceAngle = degrees(acos(dot(-surfaceToLight, normalize(ambientLight[i].coneDirection))));
                if (lightToSurfaceAngle > ambientLight[i].coneAngle) {
                    attenuation = 0.0;
                }
            }

            // ambient
            vec3 ambient = ambientLight[i].ambientCoefficient * surfaceColor.rgb * ambientColor;

            // diffuse
            float diffuseCoefficient = max(0.0, dot(normal, surfaceToLight));
            vec3 diffuse = diffuseCoefficient * surfaceColor.rgb * ambientColor;
            
            // specular
            float specularCoefficient = 0.0;
            if (diffuseCoefficient > 0.0) {
                specularCoefficient = pow(max(0.0, dot(surfaceToCamera, reflect(-surfaceToLight, normal))), materialShininess);
            } 
            vec3 specular = specularCoefficient * materialSpecularColor * ambientColor;
            
            // linear color (color before gamma correction)
            vec3 linearColor = ambient + attenuation * (diffuse + specular);
            
            // final color (after gamma correction)
            vec3 gamma = vec3(1.0/2.2);
            finalColor = finalColor + vec4(pow(linearColor, gamma), surfaceColor.a);
        }
    }
    else {
        finalColor = vColor;
    }
}
