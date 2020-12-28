-- luajit system

system = system or {}

function system.load(restart)
    sdl = require(osLibPath..'.sdl.sdl')
    gl  = require(osLibPath..'.opengl.opengl')
    al  = require(osLibPath..'.openal.openal')
    ft  = require(osLibPath..'.ft.freetype')
    --ttf = require(osLibPath..'.ttf.ttf')

    sdl.load()
    sdl.init()

    gl.load()
    gl.init()

    al.load()
    al.init()

    ttf = ft.load()  

    resetStyle()

    system.wait = sdl.SDL_Delay
end

function system.release(restart)
    ttf.release()
    al.release()
    gl.release()
    sdl.releaseSDL()
end

function system.getTicks()
    return sdl.SDL_GetTicks()
end

function system.sleep(n)
    tools.sleep(n*1000)
end

function system.beforeDraw()
    system.initMode()
end

function system.afterDraw()
end 

function system.swap()
    sdl.SDL_GL_SwapWindow(sdl.wndMain.wnd)
end

local currentContext = nil
local previousContext = {}

function system.setContext(context)
    meshManager:flush()

    if context then
        if currentContext == nil then
            local viewport = ffi.new('GLfloat[4]', {0, 0, 0, 0})
            gl.glGetFloatv(gl.GL_VIEWPORT, viewport)

            previousContext.x = viewport[0]
            previousContext.y = viewport[1]
            previousContext.w = viewport[2]        
            previousContext.h = viewport[3]
        end

        currentContext = context

        currentContext.framebufferName = Image:createFramebuffer()
        Image:attachTexture2D(context.ids.tex)
        currentContext.depthrenderbuffer = Image:attachRenderbuffer(context.width, context.height)

        if gl.glCheckFramebufferStatus(gl.GL_FRAMEBUFFER) ~= gl.GL_FRAMEBUFFER_COMPLETE then
            assert(false)
        end

        gl.glBindFramebuffer(gl.GL_FRAMEBUFFER, currentContext.framebufferName)
        gl.glViewport(0, 0, context.width, context.height)

        ortho(0, context.width, 0, context.height)

        if context.initialized == nil then
            background(transparent)
            context.initialized = true
        end

    elseif currentContext then        
        gl.glBindFramebuffer(gl.GL_FRAMEBUFFER, 0)

        gl.glDeleteRenderbuffer(currentContext.depthrenderbuffer)
        gl.glDeleteFramebuffer(currentContext.framebufferName)

        currentContext = nil

        gl.glViewport(
            previousContext.x,
            previousContext.y,
            previousContext.w,
            previousContext.h)
    end
end

function system.blendMode(mode)
    if mode == NORMAL then
        gl.glEnable(gl.GL_BLEND)
        gl.glBlendFunc(gl.GL_SRC_ALPHA, gl.GL_ONE_MINUS_SRC_ALPHA)

    elseif mode == ADDITIVE then
        gl.glEnable(gl.GL_BLEND)
        gl.glBlendFunc(gl.GL_ONE, gl.GL_ONE)

    elseif mode == MULTIPLY then
        gl.glEnable(gl.GL_BLEND)
        gl.glBlendFuncSeparate(gl.GL_DST_COLOR, gl.GL_ZERO, gl.GL_DST_ALPHA, gl.GL_ZERO)

    else
        assert()

    end
end

function system.quit(restartMode)
end

function system.getProcessorCount()
    return 1
end

function system.getPowerInfo()
    return 'charge', 34, 12000
end

function system.window(w, h)
    xLEFT = (screenResolution.x - w) / 2
    yTOP  = (screenResolution.y - h) / 2

    sdl.SDL_SetWindowSize(sdl.wndMain.wnd,
        w,
        h)

    sdl.SDL_SetWindowPosition(sdl.wndMain.wnd,
        xLEFT,
        yTOP)

    sdl.SDL_ShowWindow(sdl.wndMain.wnd)

    gl.glViewport(0, 0,
        w,
        h)
end

function system.initMode(culling, cullingFace, depthBuffer)
    culling = value(culling, config.culling)
    cullingFace = value(cullingFace, config.cullingFace)
    depthBuffer = value(depthBuffer, config.depthBuffer)

    -- Activation du Culling
    if culling and not config.appName:contains('codea') then
        gl.glEnable(gl.GL_CULL_FACE)
        gl.glFrontFace(gl.GL_CCW)
        if cullingFace == 'back' then
            gl.glCullFace(gl.GL_BACK)
        else
            gl.glCullFace(gl.GL_FRONT)
        end
    else
        gl.glDisable(gl.GL_CULL_FACE)
    end

    -- Activation du Depth Buffer
    if depthBuffer then
        gl.glEnable(gl.GL_DEPTH_TEST)
        gl.glDepthFunc(gl.GL_LEQUAL)
    else
        gl.glDisable(gl.GL_DEPTH_TEST)
    end

    -- vertical sync
    assert(sdl.SDL_GL_SetSwapInterval(config.frameSync and 1 or 0) == 0)
end

function system.processEvents()
    local event = ffi.new('SDL_Event')

    local keys = {}
    local function onKeyEvent(event, f)
        local key = ffi.string(sdl.SDL_GetScancodeName(event.key.keysym.scancode))
        if key:len() <= 1 then
            key = ffi.string(string.char(event.key.keysym.sym))
        end

        key = key:lower()

        if event.type == sdl.SDL_KEYDOWN then
            keys[key] = true
        else
            keys[key] = nil
        end

        f(key)
    end

    system.processEvents = function()
        while sdl.SDL_PollEvent(event) == 1 do
            if event.type == sdl.SDL_WINDOWEVENT then
                if event.window.event == sdl.SDL_WINDOWEVENT_CLOSE then
                    system.close()

                elseif event.window.event == sdl.SDL_WINDOWEVENT_RESIZED then
                    saveLocalData('WIDTH', event.window.data1)
                    saveLocalData('HEIGHT', event.window.data2)

                end
            elseif event.type == sdl.SDL_TEXTINPUT then
--                onKeyEvent(event, engine.keyboard)

            elseif event.type == sdl.SDL_KEYDOWN then
                onKeyEvent(event, engine.keyboard)
--                onKeyEvent(event, keypressed)

            elseif event.type == sdl.SDL_KEYUP then
--                onKeyEvent(event, keyreleased)

--            elseif event.type == sdl.SDL_FINGERDOWN then
--                mousepressed(event.tfinger.touchId,
--                    event.tfinger.x, event.tfinger.y,
--                    0, 0,
--                    event.tfinger.pressure)

--            elseif event.type == sdl.SDL_FINGERMOTION then
--                mousemoved(event.tfinger.touchId,
--                    event.tfinger.x, event.tfinger.y,
--                    event.tfinger.dx, event.tfinger.dy,
--                    event.tfinger.pressure)

--            elseif event.type == sdl.SDL_FINGERUP then
--                mousereleased(event.tfinger.touchId,
--                    event.tfinger.x, event.tfinger.y,
--                    0, 0,
--                    0)

            elseif event.type == sdl.SDL_MOUSEBUTTONDOWN then
                mousepressed(1,
                    event.motion.x, event.motion.y,
                    0, 0,
                    1)

            elseif event.type == sdl.SDL_MOUSEMOTION then
                mousemoved(1,
                    event.motion.x, event.motion.y,
                    event.motion.xrel, event.motion.yrel,
                    1)

            elseif event.type == sdl.SDL_MOUSEBUTTONUP then
                mousereleased(1,
                    event.motion.x, event.motion.y,
                    0, 0,
                    event.button.button)

            elseif event.type == sdl.SDL_MOUSEWHEEL  then
                wheelmoved(1, event.wheel.x, event.wheel.y)
            end
        end
    end

    system.processEvents()
end
