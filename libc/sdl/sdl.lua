local code, defs = Library.precompile(io.read('./libc/sdl/sdl.c'))
ffi.cdef(code)

class 'Sdl' : extends(Component) : meta(Library.load('SDL2'))

function Sdl:initialize()
    if self.SDL_Init(self.SDL_INIT_VIDEO) == 0 then
        self.SDL_SetThreadPriority(self.SDL_THREAD_PRIORITY_HIGH)

        if self.SDL_GL_LoadLibrary(ffi.NULL) == 1 then
            assert(false, 'SDL_GL_LoadLibrary')
            self.SDL_Log("SDL_GL_LoadLibrary: %s", self.SDL_GetError())
        end

        self.SDL_GL_SetAttribute(self.SDL_GL_CONTEXT_MAJOR_VERSION, config.glMajorVersion)
        self.SDL_GL_SetAttribute(self.SDL_GL_CONTEXT_MINOR_VERSION, config.glMinorVersion)

        if config.glMajorVersion == 4 then
            self.SDL_GL_SetAttribute(self.SDL_GL_CONTEXT_PROFILE_MASK, self.SDL_GL_CONTEXT_PROFILE_CORE)
--            self.SDL_GL_SetAttribute(self.SDL_GL_CONTEXT_PROFILE_MASK, self.SDL_GL_CONTEXT_PROFILE_COMPATIBILITY)
        end

        self.SDL_GL_SetAttribute(self.SDL_GL_DOUBLEBUFFER, 1)
        self.SDL_GL_SetAttribute(self.SDL_GL_DEPTH_SIZE, 24)

        local w, h = W_INFO + W, H
        
        window = self.SDL_CreateWindow('Engine',
            0, 0,
            w, h,
--            self.SDL_WINDOW_SHOWN +
            self.SDL_WINDOW_OPENGL +
--            self.SDL_WINDOW_FULLSCREEN +
            0)
        
        self.SDL_SetWindowPosition(window, sdl.SDL_WINDOWPOS_CENTERED, sdl.SDL_WINDOWPOS_CENTERED)
        self.SDL_SetWindowSize(window, w, h)
        
        self.SDL_ShowWindow(window)

        if window then
            local r = ffi.new('SDL_Rect');

            if self.SDL_GetDisplayBounds(0, r) ~= 0 then
                self.SDL_Log("SDL_GetDisplayBounds failed: %s", self.SDL_GetError())
                return
            end

            context = self.SDL_GL_CreateContext(window)

            if context then
                self.window = window
                self.context = context

                self.SDL_GL_MakeCurrent(window, context)
                self.SDL_GL_SetSwapInterval(0)
                
                local ddpi, hdpi, vdpi = ffi.new('float[1]'), ffi.new('float[1]'), ffi.new('float[1]')
                self.SDL_GetDisplayDPI(0,
                      ddpi,
                      hdpi,
                      vdpi)
                  
                self.ddpi, self.hdpi, self.vdpi = ddpi[0], hdpi[0], vdpi[0]
            end
        end
    end

    sdl.image = class 'SdlImage' : meta(Library.load('SDL2_image'))
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
function Sdl:update(dt)
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
                    1,
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
                    1)
            end

        elseif event.type == sdl.SDL_MOUSEBUTTONUP then
            if event.button.button == self.SDL_BUTTON_LEFT then
                mouse:mouseEvent(
                    0,
                    ENDED,
                    event.button.x, event.button.y,
                    0, 0,
                    0)
            end

        elseif event.type == sdl.SDL_MOUSEWHEEL  then
            mouse:mouseWheel(1, event.wheel.x, event.wheel.y)

        end
    end
end

function Sdl:swap()
    self.SDL_GL_SwapWindow(self.window)
end
