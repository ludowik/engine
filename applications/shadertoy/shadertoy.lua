class('ShaderToy', Shader)

shaderChannel = {
    [0] = image(appPath..'/channel/cube00_0.jpg')
}

function ShaderToy:init(name, path)
    self.shaderFilePath = path..'/'..name
    self.nameVertex = '_shadertoy'

    self.path = appPath..'/shaders'

    Shader.init(self, name, appPath..'/shaders')
end

function ShaderToy:complete(shaderType, source)
    if shaderType == renderer.GL_FRAGMENT_SHADER then
        local defaultUniforms = [[
            uniform vec3      iResolution;           // viewport resolution (in pixels)
            uniform float     iTime;                 // shader playback time (in seconds)
            uniform float     iTimeDelta;            // render time (in seconds)
            uniform int       iFrame;                // shader playback frame
            uniform int       iFrameRate;            // frame rate
            uniform float     iChannelTime[4];       // channel playback time (in seconds)
            uniform vec3      iChannelResolution[4]; // channel resolution (in pixels)
            uniform vec4      iMouse;                // mouse pixel coords. xy: current (if MLB down), zw: click
            uniform sampler2D iChannel0;             // input channel. XX = 2D/Cube
            uniform sampler2D iChannel1;             // input channel. XX = 2D/Cube
            uniform sampler2D iChannel2;             // input channel. XX = 2D/Cube
            uniform sampler2D iChannel3;             // input channel. XX = 2D/Cube
            uniform vec4      iDate;                 // (year, month, day, time in seconds)
            uniform float     iSampleRate;           // sound sample rate (i.e., 44100)

            in vec3 vPosition;
            in vec2 vTexCoords;

            #define PI 3.14159265359
            
            #undef in
            #undef out
            
            #undef fragColor
            
            #line 1
        ]]

        local ender = [[
            vec4 effect(vec4 frag_color, sampler2D texture, vec2 texture_coords, vec2 pixel_coords) {
                vec2 frag_coord = texture_coords * iResolution.xy;
                mainImage(frag_color, frag_coord);
                return frag_color;
            }

            #if VERSION > 0
            void main() {
                gl_FragColor = effect(vec4(1.0), iChannel0, vTexCoords, vPosition.xy);
            }
            #endif
        ]]

        return defaultUniforms..source..ender
    end

    return source
end

function loadShaders(all)
    local directoryItems = getDirectoryItems(appPath..'/shaders')

    print(appPath)
    print(#directoryItems)

    for i,shaderFileName in ipairs(directoryItems) do
        local _,_,extension = splitFilePath(shaderFileName)
        if extension ~= 'vertex' then
            local shader = ShaderToy(shaderFileName, appPath..'/shaders')
            if shader and shader.error == nil then
                initShader(shader)
                shaders:add(shader)
            end

            if app.coroutine then
                if all then
                    coroutine.yield()
                else
                    loadNext = false
                    while loadNext == false do
                        coroutine.yield()
                    end
                end
            elseif not all then
                break
            end
        end
    end
end
