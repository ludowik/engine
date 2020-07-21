local shaders, mesh, resolution

class('ShaderToy', Shader)

function ShaderToy:init(name, path, header, code, ender)
    self.shaderFilePath = path..'/'..name

    self.source = header..code..ender

    Shader.init(self, name, 'applications/shadertoy/shaders',
        {'include.vertex', 'default.vertex'},
        {'include.fragment', header, self.shaderFilePath, ender}
    )

    self.uniforms = {}

    self.uniforms.iTime = 0
    self.uniforms.iMouse = vec4()
end

function ShaderToy:create()
    self.program_id = gl.glCreateProgram()

    self.ids = {
        vertex = self:compile(gl.GL_VERTEX_SHADER, [[
                attribute vec3 vertex;
                attribute vec2 texCoords;

                uniform mat4 matrixModel;
                uniform mat4 matrixPV;

                out vec3 vPosition;
                out vec2 vTexCoords;

                void main() {
                    gl_Position = matrixPV * matrixModel * vec4(vertex.xyz, 1.);
                    
                    vPosition = vertex;
                    vTexCoords = texCoords;
                }
            ]], 'vertex'),
        fragment = self:compile(gl.GL_FRAGMENT_SHADER, self.source, self.shaderFilePath),
    }

--    if config.glMajorVersion >= 4 then
--        self.ids.geometry = self:build(gl.GL_GEOMETRY_SHADER, self.name, 'geometry')
--    end

    gl.glLinkProgram(self.program_id)

    local status = gl.glGetProgramiv(self.program_id, gl.GL_LINK_STATUS)
    if status == gl.GL_FALSE then
        print(gl.glGetProgramInfoLog(self.program_id))
    end

    self:initAttributes()

    self:initUniforms()
end

function setup()
    supportedOrientations(LANDSCAPE_ANY)

    shaders = Table()

    minSize = vec2(16, 9):normalizeInPlace( 100)
    maxSize = vec2(16, 9):normalizeInPlace(1280)

    mesh = Mesh(Model.rect(maxSize.x, maxSize.y))

    app.coroutine = coroutine.create(
        function (dt)
            loadShaders(true)
        end)
end

function suspend()
    for i,shader in ipairs(shaders) do
        shader:release()
end
end

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
]]

local appPath = ...
local shaderChannel = {
    [0] = image(appPath..'/channel/cube00_0.jpg')
}

function loadShaders(all)
    local directoryItems = fs.getDirectoryItems(appPath..'/shaders')

    for i,shaderFileName in ipairs(directoryItems) do
        local shader = loadShader(shaderFileName, appPath..'/shaders')
        if shader.error == nil then
            initShader(shader, shaderFileName == 'sandbox.fragment')
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

    local header = defaultUniforms;

    local code = load(shaderFilePath)

    local ender = [[
        vec4 effect(vec4 fragColor, sampler2D texture, vec2 texture_coords, vec2 pixel_coords) {
            vec2 fragCoord = texture_coords * iResolution.xy;
            mainImage(fragColor, fragCoord);
            return fragColor;
        }

        #if VERSION > 0
        void main() {
            fragColor = effect(vec4(1.0), iChannel0, vTexCoords, vPosition.xy);
        }
        #endif
    ]]

    return ShaderToy(shaderFileName, path, header, code, ender)
end

function initUI(zoom)
    local ui = UI()

    if zoom then
        ui.size = maxSize
    else
        ui.size = minSize
    end

    ui.canvas = image(ui.size.x, ui.size.y)

    ui.position = vec2()
    ui.absolutePosition = ui.position

    return ui
end

function initShader(shader, active)
    shader.active = active

    shader.ui = initUI(false)
    shader.zoom = initUI(true)

    drawShader(shader, shader.ui)
    drawShader(shader, shader.zoom)
end

function drawShader(shader, ui)
    setContext(ui.canvas)
    do
        translate(ui.size.x/2, ui.size.y/2)

        mesh.shader = shader

        shader.uniforms.iResolution = vec3(
            ui.size.x,
            ui.size.y,
            1)

        shader.uniforms.iTime = shader.uniforms.iTime + DeltaTime
        shader.uniforms.iTimeDelta = DeltaTime

        if false and Rect.contains(ui, mouse) then
            local x, y = mouse:unpack()

            x = x - shader.ui.absolutePosition.x
            y = y - shader.ui.absolutePosition.y

            shader.uniforms.iMouse.x, shader.uniforms.iMouse.y = x, y

            if isButtonDown(1) then
                shader.uniforms.iMouse.z, shader.uniforms.iMouse.w = x, y
            else
                shader.uniforms.iMouse.z, shader.uniforms.iMouse.w = -1, -1
            end
        end

        shader.uniforms.iFrameRate = 60

        for k,v in pairs(shaderChannel) do
            shader.texture = shaderChannel[0]
            shader.uniforms.iChannel0 = 0
        end

        mesh:draw()
    end
    setContext()
end

function update(dt)
    for i,shader in ipairs(shaders) do
        if shader.active then
            shader:update()
        end    
    end
end

function draw()
    background(51)

    for i,shader in ipairs(shaders) do
        if shader.active then
            drawShader(shader, shader.ui)
            drawShader(shader, shader.zoom)
        end
    end

    local currentActiveShader, nextActiveShader

    local x, y = 0, HEIGHT
    for i,shader in ipairs(shaders) do
        if shader.active then
            currentActiveShader = shader
        end

        local size = shader.ui.size

        shader.ui.canvas:draw(x, y - size.y, size.x, size.y)

        if shader.active then
            stroke(red)
        else
            stroke(white)
        end
        noFill()

        rectMode(CORNER)
        rect(x, y - size.y, size.x, size.y)

        if not shader.active then
            textMode(CENTER)
            text(shader.name, x+size.x/2, y-size.y/2)
        end

        shader.ui.position = vec2(x, y - size.y)
        shader.ui.absolutePosition = shader.ui.position

        x = x + size.x
        if x + size.x > WIDTH  then
            x = 0
            y = y - size.y
        end
    end

    x = 0
    y = y - minSize.y

    if currentActiveShader then
        local size = currentActiveShader.zoom.size
        currentActiveShader.zoom.canvas:draw(x, y - size.y)
    end
end

function touched(touch)
    if touch.state == BEGAN then
        loadNext = true

        local currentActiveShader, nextActiveShader
        for i,shader in ipairs(shaders) do
            if shader.active then
                currentActiveShader = shader
            end
            if Rect.contains(shader.ui, touch) then
                loadNext = false
                nextActiveShader = shader
            end
        end

        if nextActiveShader then
            if currentActiveShader then
                initShader(currentActiveShader, false)
            end

            initShader(nextActiveShader, true)
        end
    end
end
