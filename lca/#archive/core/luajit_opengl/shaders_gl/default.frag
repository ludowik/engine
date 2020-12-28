in vec3 vPosition;
in vec3 vNormal;
in vec4 vColor;
in vec2 vTexCoord;

out vec4 glFragColor;

float levels = 3;

void main() {
    vec4 objectColor;
    vec3 fragNormal = vNormal;

    objectColor = vColor;
    
    if (useTexture == 1) {
        objectColor = texture(tex, vTexCoord) * vColor;
    }
    
    if (useLight > 0) {
        vec4 finalColor = vec4(0.0, 0.0, 0.0, 0.0);
        for (int i=0; i<useLight; ++i) {
            Light light = lights[i];
            if (light.on == 0) {
                continue;
            }
            
            // ambient color
            vec3 ambient =
                (light.color.xyz * light.ambientStrength) *
                (objectColor.xyz * material.ambientStrength);
            
            // diffuse
            vec3 lightDirection;
            lightDirection = light.position - vPosition;
            
            vec3 unitNormal = normalize(fragNormal);
            vec3 unitLightDirection = normalize(lightDirection);
            
            float nDot = dot(unitNormal, unitLightDirection);
            float brightness = max(nDot, 0.0);
            
            if (useCelShading > 0) {
                float level = floor(brightness * levels);
                brightness = level / levels;
            }
            
            vec3 diffuse = 
                (light.color.xyz * light.diffuseStrength) *
                (objectColor.xyz * material.diffuseStrength) * brightness;
            
            // specular
            vec3 viewDir = normalize(cameraPosition - vPosition);
            vec3 reflectDir = reflect(-unitLightDirection, unitNormal);
            
            float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);
            
            vec3 specular = 
                (light.color.xyz * light.specularStrength) *
                (objectColor.xyz * material.specularStrength) * spec;
            
            // spotlight (soft edges)
            if (light.innerCutOff > 0) {
                float innerCutOff = min(light.innerCutOff, light.outerCutOff);
                float outerCutOff = max(light.innerCutOff, light.outerCutOff);
                
                float theta = dot(unitLightDirection, normalize(-light.direction));
                
                float epsilon = (innerCutOff - outerCutOff);
                float intensity = clamp((theta - outerCutOff) / epsilon, 0.0, 1.0);

                diffuse *= intensity;
                specular *= intensity;
            }
            
            // attenuation
            float distance = length(lightDirection);
            float attenuation = 1.0f / (light.constant +
                light.linear * distance +
                light.quadratic * (distance * distance));
        
            ambient *= attenuation;
            diffuse *= attenuation;
            specular *= attenuation;

            finalColor = finalColor + vec4(ambient + diffuse + specular, material.alpha);
        }
        glFragColor = finalColor / useLight;
    } else {
        glFragColor = objectColor;
    }
}
