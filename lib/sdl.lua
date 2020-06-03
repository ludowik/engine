local code, defs = precompile(io.read('./lib/sdl.c'))
ffi.cdef(code)

local lib_path
if os.name == 'osx' then 
    lib_path = 'SDL2.framework/SDL2'
else
    --lib_path = '../../Libraries/bin/SDL2'
    lib_path = 'SDL2'
end

class 'Sdl' : meta(ffi.load(lib_path))

sdl = Sdl()

function Sdl:setup()
    if self.SDL_Init(self.SDL_INIT_VIDEO) == 0 then
        self.SDL_SetThreadPriority(self.SDL_THREAD_PRIORITY_HIGH)

        if self.SDL_GL_LoadLibrary(ffi.NULL) == 1 then
            assert(false, 'SDL_GL_LoadLibrary')
            self.SDL_Log("SDL_GL_LoadLibrary: %s", self.SDL_GetError())
        end

        self.SDL_GL_SetAttribute(self.SDL_GL_CONTEXT_MAJOR_VERSION, gl.majorVersion)
        self.SDL_GL_SetAttribute(self.SDL_GL_CONTEXT_MINOR_VERSION, gl.minorVersion)

        if gl.majorVersion == 4 then
            sdl.SDL_GL_SetAttribute(sdl.SDL_GL_CONTEXT_PROFILE_MASK, sdl.SDL_GL_CONTEXT_PROFILE_CORE)
        end
        
        self.SDL_GL_SetAttribute(self.SDL_GL_DOUBLEBUFFER, 1)
        self.SDL_GL_SetAttribute(self.SDL_GL_DEPTH_SIZE, 24)

        window = self.SDL_CreateWindow('resurection',
            0, 0,
            W, H,
            self.SDL_WINDOW_SHOWN +
            self.SDL_WINDOW_OPENGL)

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

                self.SDL_SetWindowPosition(window, r.x+100, r.y+100)
                self.SDL_SetWindowSize(window, W, H)

                self.SDL_ShowWindow(window)
            end
        end
    end
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

local event = ffi.new('SDL_Event')
function Sdl:update(dt)
    while self.SDL_PollEvent(event) == 1 do
        if event.type == self.SDL_WINDOWEVENT then
            if event.window.event == self.SDL_WINDOWEVENT_CLOSE then
                engine.quit()
            end

        elseif event.type == self.SDL_KEYDOWN then
            local key = ffi.string(self.SDL_GetScancodeName(event.key.keysym.scancode))
            if key:len() <= 1 then
                key = ffi.string(self.SDL_GetKeyName(event.key.keysym.sym))
            end
            key = key:lower()
            engine:keydown(key)

        elseif event.type == self.SDL_MOUSEMOTION then
            mouse.x = event.motion.x
            mouse.y = H - event.motion.y

            mouse.dx = event.motion.xrel
            mouse.dy = event.motion.yrel

            mouse.isTouch = (event.motion.state - self.SDL_BUTTON_LMASK) ~= event.motion.state

        end
    end
end

function Sdl:draw()
    self.SDL_GL_SwapWindow(self.window)
end
