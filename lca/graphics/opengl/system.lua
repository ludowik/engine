system = system or {}

function system.release()
    ft:release()
    al.release()
    gl.release()
    sdl.releaseSDL()
end

function system.reset()
    graphics.reset()
end

function system.window(w, h)
    assert(w and h)
    
    W, H = w, h or w
    WIDTH, HEIGHT = W, H

    local dm = sdl.getCurrentDisplayMode()

    xLEFT = (dm.w - w) / 2 - W_INFO / 2
    yTOP  = (dm.h - h) / 2

    sdl.SDL_SetWindowPosition(sdl.wndMain.wnd,
        xLEFT,
        yTOP)

    sdl.SDL_SetWindowSize(sdl.wndMain.wnd,
        W_INFO + w,
        h)

    sdl.SDL_ShowWindow(sdl.wndMain.wnd)
end

function system.setTitle(appPath)
    sdl.SDL_SetWindowTitle(sdl.wndMain.wnd, appPath)
end

function system.getTicks()
    return sdl.SDL_GetTicks()
end

function system.getTime()
    return sdl.SDL_GetTicks() * 0.001
end

function system.sleep(n)
    sdl.SDL_Delay(n * 1000)
end

function system.swap()
    sdl.SDL_GL_SwapWindow(sdl.wndMain.wnd)
end

function system.quit(restartMode)
end

local touchId = 0
function system.processEvents()
    local event = ffi.new('SDL_Event')

    local keys = {}
    local function onKeyEvent(event, f)
        local key = ffi.string(sdl.SDL_GetScancodeName(event.key.keysym.scancode))
        if key:len() <= 1 then
            key = ffi.string(sdl.SDL_GetKeyName(event.key.keysym.sym))
        end

        key = key:lower()

        key = mapKey(key, true)

        if event.type == sdl.SDL_KEYDOWN then
            keys[key] = true
        else
            keys[key] = nil
        end

        f(key, event.key.keysym.scancode, event.key['repeat'])
    end

    system.processEvents = function()
        while sdl.SDL_PollEvent(event) == 1 do
            if event.type == sdl.SDL_WINDOWEVENT then
                if event.window.event == sdl.SDL_WINDOWEVENT_CLOSE then
                    lca.keypressed('escape')
                elseif event.window.event == sdl.SDL_WINDOWEVENT_RESIZED then
                    -- TODO gérer le resize
                    --                    saveLocalData('WIDTH', event.window.data1)
                    --                    saveLocalData('HEIGHT', event.window.data2)
                end

            elseif event.type == sdl.SDL_TEXTINPUT then
                onKeyEvent(event, lca.keypressed)

            elseif event.type == sdl.SDL_KEYDOWN then
                onKeyEvent(event, lca.keypressed)

            elseif event.type == sdl.SDL_KEYUP then
                onKeyEvent(event, lca.keyreleased)

                -- TODO gérer les "fingers"
                --            elseif event.type == sdl.SDL_FINGERDOWN then
                --                lca.mouseEvent(BEGAN,
                --                    event.tfinger.touchId,
                --                    event.tfinger.x, event.tfinger.y,
                --                    0, 0,
                --                    event.tfinger.pressure)

                --            elseif event.type == sdl.SDL_FINGERMOTION then
                --                lca.mouseEvent(MOVING,
                --                    event.tfinger.touchId,
                --                    event.tfinger.x, event.tfinger.y,
                --                    event.tfinger.dx, event.tfinger.dy,
                --                    event.tfinger.pressure)

                --            elseif event.type == sdl.SDL_FINGERUP then
                --                lca.mouseEvent(ENDED,
                --                    event.tfinger.touchId,
                --                    event.tfinger.x, event.tfinger.y,
                --                    0, 0,
                --                    0)

            elseif event.type == sdl.SDL_MOUSEBUTTONDOWN then
                touchId = touchId + 1                
                lca.mouseEvent(BEGAN,
                    tonumber(event.tfinger.touchId),
                    event.button.x, event.button.y,
                    0, 0,
                    1,
                    event.button.clicks)

            elseif event.type == sdl.SDL_MOUSEMOTION then
                lca.mouseEvent(MOVING,
                    tonumber(event.tfinger.touchId),
                    event.motion.x, event.motion.y,
                    event.motion.xrel, event.motion.yrel,
                    1)

            elseif event.type == sdl.SDL_MOUSEBUTTONUP then
                lca.mouseEvent(ENDED,
                    tonumber(event.tfinger.touchId),
                    event.button.x, event.button.y,
                    0, 0,
                    event.button.button)

            elseif event.type == sdl.SDL_MOUSEWHEEL  then
                lca.wheelmoved(1, event.wheel.x, event.wheel.y)
            end
        end
    end

    system.processEvents()
end

local fps, frame, previousTime, dt
function system.getFPS()
    if fps == nil then
        fps = config.framerate or 60
        frame = 0
        previousTime = system.getTime()
    else
        if frame < lca.frame then
            frame = lca.frame
            local currentTime = system.getTime()
            dt = currentTime - previousTime
            previousTime = system.getTime()
            fps = fps * 0.9 + 1 / dt * 0.1
        end
    end

    return math.round(fps)
end

function system.frameSyncMode(mode)
    assert(sdl.SDL_GL_SetSwapInterval(mode and 1 or 0) == 0)
end

