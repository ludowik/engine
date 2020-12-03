appPath = 'applications/shadertoy'

function setup()
    supportedOrientations(LANDSCAPE_ANY)

    shaders = Table()

    local wmin = ws(1, 16)
    local wmax = ws(8, 12)

    minSize = vec2(wmin, wmin*9/16):round()
    maxSize = vec2(wmax, wmax*9/16):round()

    mesh = Model.rect()

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
        depthMode(false)

        mesh.shader = shader

        shader.uniforms.iResolution = vec3(
            ui.size.x,
            ui.size.y,
            1)

        shader.uniforms.iTime = shader.uniforms.iTime + DeltaTime
        shader.uniforms.iTimeDelta = DeltaTime

        shader.uniforms.iFrame = shader.uniforms.iFrame + 1
        shader.uniforms.iFrameRate = 60

        local touch = mouse:transform()
        if Rect.contains(ui, touch) then
            local x, y = touch:unpack()

            x = x - shader.ui.absolutePosition.x
            y = y - shader.ui.absolutePosition.y

            shader.uniforms.iMouse.x, shader.uniforms.iMouse.y = x, y

            if isButtonDown(BUTTON_LEFT) then
                shader.uniforms.iMouse.z, shader.uniforms.iMouse.w = x, y
            else
                shader.uniforms.iMouse.z, shader.uniforms.iMouse.w = -1, -1
            end
        end

        for k,v in pairs(shaderChannel) do
            shader.texture = shaderChannel[0]
            shader.uniforms.iChannel0 = 0
        end

        mesh.uniforms = shader.uniforms

        mesh:draw(nil, 0, 0, 0, ui.size.x, ui.size.y, 1)
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
    local w, h = textSize()

    for i,shader in ipairs(shaders) do
        if shader.active then
            currentActiveShader = shader
        end

        local size = shader.ui.size

        shader.ui.canvas:draw(x, y - size.y)

        if shader.active then
            stroke(red)
        else
            stroke(white)
        end
        noFill()

        rectMode(CORNER)
        rect(x, y - size.y, size.x, size.y)

        fill(white)

        fontSize(8)

        local path, name, ext = fs.splitFilePath(shader.name)
        textMode(CENTER)
        text(name, x+size.x/2, y-size.y-h/2)

        shader.ui.position = vec2(x, y - size.y)
        shader.ui.absolutePosition = shader.ui.position

        x = x + size.x
        if x + size.x > WIDTH  then
            x = 0
            y = y - size.y - h
        end
    end

    x = 0
    y = y - minSize.y - h

    if currentActiveShader then
        local size = currentActiveShader.zoom.size

        spriteMode(CENTER)
        sprite(currentActiveShader.zoom.canvas, W/2, y-y/2)
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
