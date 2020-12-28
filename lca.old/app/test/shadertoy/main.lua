local shaders, mesh
local resolution = vector(16, 9):normalize() * 100

function setup()
    supportedOrientations(LANDSCAPE_ANY)

    shaders = Table()

    app.coroutine = coroutine.create(function (dt)
              loadShaders()
      end)

    mesh = Model.rect(resolution.x, resolution.y)
    mesh:update()
end

function suspend()
    for i,shader in ipairs(shaders) do
        shader.shader:release()
    end
    
    gc()
end

--[[
uniform vec3 iResolution;
uniform float iTime;
uniform float iTimeDelta;
uniform float iFrame;
uniform float iChannelTime[4];
uniform vec4 iMouse;
uniform vec4 iDate;
uniform float iSampleRate;
uniform vec3 iChannelResolution[4];
uniform samplerXX iChanneli;
]]

local shaderChannel = {
    [0] = graphics.newImage("app/test/shadertoy/channel/cube00_0.jpg")
}

function loadShaders(all)
    local list = dir("app/test/shadertoy/shader")

    for i,shaderFileName in ipairs(list) do
        local shader = loadShader(shaderFileName)
        shaders:add(shader)

        if shader.iFrameRate then
            shader.shader:send("iFrameRate", shader.iFrameRate)
        end

        if shader.iResolution then
            shader.shader:send("iResolution", shader.iResolution)
        end

        if shader.iChannel then
            for k,v in pairs(shaderChannel) do
                shader.shader:send("iChannel"..k, v)
            end
        end

        shader.active = false

        if all ~= true then
            while true do
                if coroutine.yield() == nil or loadNext then
                    loadNext = false
                    break
                end
            end
        end
    end
end

function loadShader(path)
    local shader = UI()

    local header = [[
    ]]

    local ender = [[        
        vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords) {
            vec2 fragCoord = texture_coords * iResolution.xy;
            mainImage(color, fragCoord);
            return color;
        }
    ]]

    local file = fs.newFile(path)
    file:open("r")

    local code = file:read()    
    :replace("texture2D", "Texel")
    :replace("textureCube", "Texel")
    :replace("texture", "Texel")
    :replace("precision", "")    
    
    file:close()

    if string.find(code, "iFrameRate") then
        shader.iFrameRate = 60
        header = "extern number iFrameRate;\n"..header
    end

    if string.find(code, "iTime") then
        shader.iTime = 0
        header = "extern number iTime;\n"..header
    end

    if string.find(code, "iChannel") then
        shader.iChannel = {}
        for k=0,3 do
            if string.find(code, "iChannel"..k) then
                header = "extern Image iChannel"..k..";\n"..header
            end
        end
    end

    if string.find(code, "iMouse") then
        shader.iMouse = {
            0,
            0,
            0,
            0
        }
        header = "extern vec4 iMouse;\n"..header
    end

    shader.iResolution = {
        resolution.x,
        resolution.y,
        1
    }
    header = "extern vec3 iResolution;\n"..header

    shader.code = header..code..ender

    shader.shader = graphics.newShader(shader.code)

    return shader
end

function update(dt)
    for i,shader in ipairs(shaders) do
        if shader.active then
            if shader.iTime then
                shader.iTime = shader.iTime + dt
                shader.shader:send("iTime", shader.iTime)
            end

            if shader.iMouse then
                shader.iMouse[1], shader.iMouse[2] = mouse.getPosition()

                if mouse.isDown(1) then
                    if shader.iMouse[3] < 0 then
                        shader.iMouse[3], shader.iMouse[4] = mouse.getPosition()
                    end
                    shader.shader:send("iMouse", shader.iMouse)
                else
                    shader.iMouse[3], shader.iMouse[4] = -1, -1
                end
            end
        end
    end
end

function draw()
    background(51)

    for i,shader in ipairs(shaders) do
        if shader.canvas == nil or shader.active then
            if shader.canvas == nil then
                shader.canvas = image(resolution.x, resolution.y)
            end

            setContext(shader.canvas)

            ortho()

            noFill()

            translate(resolution.x/2, resolution.y/2)
            scale(resolution.x, resolution.y)

            mesh.shader = shader
            mesh:render(resolution.x/2, resolution.y/2, 0, resolution.x, resolution.y)

            setContext()
        end
    end

    local x, y = 0, HEIGHT - resolution.y * 2
    for i,shader in ipairs(shaders) do
        shader.canvas:draw(x, y)

        shader.position = vector(x, y)
        shader.size = vector(resolution.x, resolution.y)

        x = x + resolution.x
        if x + resolution.x > WIDTH  then
            x = 0
            y = y - resolution.y
        end
    end
end

function touched(touch)
    loadNext = true

    if touch.state == BEGAN then
        loadNext = true

        local currentActiveShader, nextActiveShader
        for i,shader in ipairs(shaders) do
            if shader.active then
                currentActiveShader = shader
            end
            if Rect.contains(shader, touch) then
                nextActiveShader = shader
            end
        end

        if nextActiveShader then
            if currentActiveShader then
                currentActiveShader.active = false
            end
            nextActiveShader.active = true
        end
    end
end
