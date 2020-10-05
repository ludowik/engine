local code, defs = Library.precompile(io.read('libc/sdl/sdl.c'))
ffi.cdef(code)

class 'Sdl' : extends(Component) : meta(windows and Library.load('SDL2') or ffi.C)

function Sdl:initialize()
    self.window = NULL
    self.context = NULL

    if ios then
        -- TODO : make a function
        self.window = sdl.SDL_GL_GetCurrentWindow()
        if self.window ~= NULL then
            self.context = sdl.SDL_GL_GetCurrentContext()
            if self.context ~= NULL then
                local res = self.SDL_GL_MakeCurrent(self.window, self.context)
                assert(res == 0)

                --                self.SDL_GL_SetSwapInterval(0)

                local ddpi, hdpi, vdpi = ffi.new('float[1]'), ffi.new('float[1]'), ffi.new('float[1]')
                self.SDL_GetDisplayDPI(0,
                    ddpi,
                    hdpi,
                    vdpi)

                self.ddpi, self.hdpi, self.vdpi = ddpi[0], hdpi[0], vdpi[0]
            end
        end
        
    elseif self.SDL_Init(self.SDL_INIT_VIDEO) == 0 then
        self:setCursor(sdl.SDL_SYSTEM_CURSOR_WAIT)

--        self.SDL_SetThreadPriority(self.SDL_THREAD_PRIORITY_HIGH)

        if self.SDL_GL_LoadLibrary(ffi.NULL) == 1 then
            assert(false, 'SDL_GL_LoadLibrary')
            self.SDL_Log("SDL_GL_LoadLibrary: %s", self.SDL_GetError())
        end

        if ios then
            sdl.SDL_GL_SetAttribute(sdl.SDL_GL_CONTEXT_PROFILE_MASK, sdl.SDL_GL_CONTEXT_PROFILE_ES)

            sdl.SDL_GL_SetAttribute(sdl.SDL_GL_CONTEXT_MAJOR_VERSION, 2)
--            sdl.SDL_GL_SetAttribute(sdl.SDL_GL_CONTEXT_MINOR_VERSION, 1)

        elseif config.glMajorVersion == 4 then
            self.SDL_GL_SetAttribute(self.SDL_GL_CONTEXT_PROFILE_MASK, self.SDL_GL_CONTEXT_PROFILE_CORE)

            self.SDL_GL_SetAttribute(self.SDL_GL_CONTEXT_MAJOR_VERSION, config.glMajorVersion)
            self.SDL_GL_SetAttribute(self.SDL_GL_CONTEXT_MINOR_VERSION, config.glMinorVersion)

        else
            self.SDL_GL_SetAttribute(self.SDL_GL_CONTEXT_PROFILE_MASK, self.SDL_GL_CONTEXT_PROFILE_COMPATIBILITY)

            self.SDL_GL_SetAttribute(self.SDL_GL_CONTEXT_MAJOR_VERSION, config.glMajorVersion)
            self.SDL_GL_SetAttribute(self.SDL_GL_CONTEXT_MINOR_VERSION, config.glMinorVersion)
        end

        self.SDL_GL_SetAttribute(self.SDL_GL_DOUBLEBUFFER, 1)
        self.SDL_GL_SetAttribute(self.SDL_GL_DEPTH_SIZE, 24)

        local w, h = W_INFO + W, H

        window = self.SDL_CreateWindow('Engine',
            0, 0,
            w, h,
            --            self.SDL_WINDOW_FULLSCREEN +
            --            self.SDL_WINDOW_SHOWN +

            self.SDL_WINDOW_OPENGL +

            --            self.SDL_WINDOW_BORDERLESS +
            --            self.SDL_WINDOW_RESIZABLE +
            --            self.SDL_WINDOW_MAXIMIZED +

            0)

        if window then            
            self.SDL_MaximizeWindow(window)

            self.SDL_SetWindowSize(window, w, h)
            self.SDL_SetWindowPosition(window, sdl.SDL_WINDOWPOS_CENTERED, sdl.SDL_WINDOWPOS_CENTERED)        

            self.SDL_ShowWindow(window)

            local r = ffi.new('SDL_Rect');

            if self.SDL_GetDisplayBounds(0, r) ~= 0 then
                self.SDL_Log("SDL_GetDisplayBounds failed: %s", self.SDL_GetError())
                return
            end

            context = self.SDL_GL_CreateContext(window)

            if context then
                self.window = window
                self.context = context

                local res = self.SDL_GL_MakeCurrent(self.window, self.context)
                assert(res == 0)

                --                self.SDL_GL_SetSwapInterval(0)

                local ddpi, hdpi, vdpi = ffi.new('float[1]'), ffi.new('float[1]'), ffi.new('float[1]')
                self.SDL_GetDisplayDPI(0,
                    ddpi,
                    hdpi,
                    vdpi)

                self.ddpi, self.hdpi, self.vdpi = ddpi[0], hdpi[0], vdpi[0]
            end
        end
    end

    if self.context ~= NULL then
        local res = self.SDL_GL_MakeCurrent(self.window, self.context)
        assert(res == 0)

        --                self.SDL_GL_SetSwapInterval(0)

        local ddpi, hdpi, vdpi = ffi.new('float[1]'), ffi.new('float[1]'), ffi.new('float[1]')
        self.SDL_GetDisplayDPI(0,
            ddpi,
            hdpi,
            vdpi)

        self.ddpi, self.hdpi, self.vdpi = ddpi[0], hdpi[0], vdpi[0]
    end

    sdl.image = class 'SdlImage' : meta(windows and Library.load('SDL2_image') or ffi.C)
end

function Sdl:setCursor(cursorId)
    local cursor = sdl.SDL_CreateSystemCursor(cursorId)
    sdl.SDL_SetCursor(cursor)
end

function Sdl:toggleWindowDisplayMode()
    sdl.SDL_SetWindowFullscreen(sdl.window, sdl.SDL_WINDOW_FULLSCREEN)
end

function Sdl:release()
    if self.context then
        self.SDL_GL_DeleteContext(self.context)
        if self.window then
            self.SDL_DestroyWindow(self.window)
        end
        self.SDL_GL_UnloadLibrary()
    end
    self.SDL_Quit()
end

function Sdl:scancode2key(event)
    local key = ffi.string(self.SDL_GetScancodeName(event.key.keysym.scancode))
    if key:len() <= 1 then
        key = ffi.string(self.SDL_GetKeyName(event.key.keysym.sym))
    end
    key = key:lower()
    key = mapKey(key, true)
    return key
end

local event = ffi.new('SDL_Event')
function Sdl:event()
    while self.SDL_PollEvent(event) == 1 do
        if event.type == self.SDL_WINDOWEVENT then
            if event.window.event == self.SDL_WINDOWEVENT_CLOSE then
                engine:quit()

            elseif event.window.event == sdl.SDL_WINDOWEVENT_RESIZED then
                -- TODO
            end

        elseif event.type == self.SDL_KEYDOWN or event.type == sdl.SDL_TEXTINPUT then
            engine:keydown(self:scancode2key(event), event.key.isrepeat)

        elseif event.type == sdl.SDL_KEYUP then
            engine:keyup(self:scancode2key(event), event.key.isrepeat)

        elseif event.type == sdl.SDL_MOUSEBUTTONDOWN then
            if event.button.button == self.SDL_BUTTON_LEFT then
                mouse:mouseEvent(
                    0,
                    BEGAN,
                    event.button.x, event.button.y,
                    0, 0,
                    true,
                    event.button.clicks)
            end

        elseif event.type == sdl.SDL_MOUSEMOTION then
            local isTouch = bitAND(event.motion.state, self.SDL_BUTTON_LMASK)
            if isTouch then
                mouse:mouseEvent(
                    0,
                    MOVING,
                    event.motion.x, event.motion.y,
                    event.motion.xrel, event.motion.yrel,
                    isTouch)
            else
                mouse:mouseMove(
                    0,
                    MOVING,
                    event.motion.x, event.motion.y,
                    event.motion.xrel, event.motion.yrel,
                    isTouch)
            end

        elseif event.type == sdl.SDL_MOUSEBUTTONUP then
            if event.button.button == self.SDL_BUTTON_LEFT then
                mouse:mouseEvent(
                    0,
                    ENDED,
                    event.button.x, event.button.y,
                    0, 0,
                    false)
            end

        elseif event.type == sdl.SDL_MOUSEWHEEL  then
            mouse:mouseWheel(1, event.wheel.x, event.wheel.y)

        end
    end
end

function Sdl:swap()
    self.SDL_GL_SwapWindow(self.window)
end
