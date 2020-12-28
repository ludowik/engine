#version 410 core

uniform float light_ambient_intensity;

uniform vec3 light_direction;
uniform vec3 light_ambient_color;

in vec4 vColor;
in vec3 vNormal;

out vec4 out_Color;

void main() {
    if ( light_ambient_intensity != 0.0 ) {
        float light_diffuse_intensity = max(0.0, dot(vNormal, light_direction));
        out_Color = vColor *
            vec4(light_ambient_color * ( light_ambient_intensity + light_diffuse_intensity ), 1.0);
    } else {
        out_Color = vColor;
    }
}
