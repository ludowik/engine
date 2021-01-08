precision highp int;
precision highp float;

#if VERSION >= 300
    #define attribute in

    #define texture2D texture

    #define gl_FragColor fragColor
    out vec4 fragColor;
#else
    #define in  varying
    #define out varying

    #define texture texture2D

    #define fragColor gl_FragColor
#endif

vec4 white = vec4(1.0, 1.0, 1.0, 1.0);
vec4 black = vec4(0.0, 0.0, 0.0, 1.0);

vec4 red   = vec4(1.0, 0.0, 0.0, 1.0);
vec4 green = vec4(0.0, 1.0, 0.0, 1.0);
vec4 blue  = vec4(0.0, 0.0, 1.0, 1.0);

vec4 transparent = vec4(0.0, 0.0, 0.0, 0.0);

vec4 brown = vec4(165./255., 42./255., 42./255., 1.0);

const float PI = 3.1415922;
const float TAU = PI * 2.;
