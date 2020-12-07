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

class('ShaderToy', Shader)

shaderChannel = {
    [0] = image(appPath..'/channel/cube00_0.jpg')
}

function ShaderToy:init(name, path, header, code, ender)
    self.shaderFilePath = path..'/'..name

    self.source = header..code..ender

    Shader.init(self, name, appPath..'/shaders')
end

function ShaderToy:create()
    self.program_id = gl.glCreateProgram()

    self.ids = {        
        vertex = self:compile(gl.GL_VERTEX_SHADER, [[
                attribute vec3 vertex;
                attribute vec2 texCoords;

                uniform mat4 matrixModel;
                uniform mat4 matrixPV;

                uniform vec3 pos;
                uniform vec3 size;

                out vec3 vPosition;
                out vec2 vTexCoords;

                void main() {
                    vec3 vertexPosition = vertex * size + pos;
                
                    gl_Position = matrixPV * matrixModel * vec4(vertexPosition.xyz, 1.);

                    vPosition = vertexPosition;
                    vTexCoords = texCoords;
                }
            ]]),
        fragment = self:compile(gl.GL_FRAGMENT_SHADER, self.source, self.shaderFilePath),
    }

    gl.glLinkProgram(self.program_id)

    local status = gl.glGetProgramiv(self.program_id, gl.GL_LINK_STATUS)
    if status == gl.GL_FALSE then
        print(gl.glGetProgramInfoLog(self.program_id))
    end

    self:initAttributes()

    self:initUniforms()
end

function loadShaders(all)
    local directoryItems = getDirectoryItems(appPath..'/shaders')

    print(appPath)
    print(#directoryItems)

    for i,shaderFileName in ipairs(directoryItems) do
        local shader = loadShader(shaderFileName, appPath..'/shaders')
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

function loadShader(shaderFileName, path)
    local shaderFilePath = path..'/'..shaderFileName
    print(shaderFilePath)

    local header = defaultUniforms

    local code = io.read(shaderFilePath)
    if code then

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

        return ShaderToy(shaderFileName, path, header, code, ender)
    end
end
