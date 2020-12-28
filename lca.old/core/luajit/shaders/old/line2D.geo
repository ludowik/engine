#version 410 core

layout(lines) in;
layout(triangle_strip, max_vertices = 256) out;

uniform mat4 modelViewProjection;
uniform mat4 model;

in vec4 vColorG[];
in vec3 vNormalG[];

in float strokeWidthG[];

out vec4 vColor;
out vec3 vNormal;

float strokeWidth;

vec2 a,b,c,d;

void add(vec2 p0, vec2 p1, vec2 p2, int i, bool inner, bool start) {
    vec2 line = p1 - p0;
    vec2 perpendicular = vec2(-line.y, line.x);
    vec2 normal = normalize(perpendicular);
    vec2 n = strokeWidth * normal;

    a = p0 - n;
    b = p0 + n;

    if (inner) {
        vec2 tangent = normalize(normalize(p2-p1) + normalize(p1-p0));
        vec2 miter = vec2(-tangent.y, tangent.x);

        float len = strokeWidth / dot(miter, normal);
        
        c = p1 - len * miter;
        d = p1 + len * miter;
    } else {
        c = p1 - n;
        d = p1 + n;
    }
    
    vColor = vColorG[i];
    vNormal = vNormalG[i];
    
    if (start) {
        gl_Position = modelViewProjection * vec4(b, 0, 1);
        EmitVertex();
        gl_Position = modelViewProjection * vec4(a, 0, 1);
        EmitVertex();
    } else {
        gl_Position = modelViewProjection * vec4(d, 0, 1);
        EmitVertex();
        gl_Position = modelViewProjection * vec4(c, 0, 1);
        EmitVertex();
    }
}

void main() {
    strokeWidth = strokeWidthG[0] / 2.;
    
    add(gl_in[0].gl_Position.xy,
        gl_in[1].gl_Position.xy,
        gl_in[1].gl_Position.xy,
        0,
        false, true);
    
    for (int i = 1; i < gl_in.length()-1; i++) {
        add(gl_in[i-1].gl_Position.xy,
            gl_in[i  ].gl_Position.xy,
            gl_in[i+1].gl_Position.xy,
            i,
            true, false);
    }
    
    add(gl_in[gl_in.length()-2].gl_Position.xy,
        gl_in[gl_in.length()-1].gl_Position.xy,
        gl_in[gl_in.length()-1].gl_Position.xy,
        gl_in.length()-1,
        false, false);
    
    EndPrimitive();
}