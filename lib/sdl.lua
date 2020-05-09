require 'ffi'

local code, defs = precompile(io.read('./lib/sdl.c'))
ffi.cdef(code)

local lib_path
if os.name == 'osx' then 
    lib_path = 'SDL2.framework/SDL2'
else
    lib_path = '../../Libraries/bin/SDL2'
end

class 'Sdl' : meta(ffi.load(lib_path))

sdl = Sdl()

function Sdl:setup()
    if self.SDL_Init(self.SDL_INIT_VIDEO) == 0 then
        self.SDL_SetThreadPriority(self.SDL_THREAD_PRIORITY_HIGH)

        local attributes = self.SDL_WINDOW_RESIZABLE + self.SDL_WINDOW_OPENGL

        self.SDL_GL_SetAttribute(self.SDL_GL_CONTEXT_MAJOR_VERSION, 2)
        self.SDL_GL_SetAttribute(self.SDL_GL_CONTEXT_MINOR_VERSION, 1)

        if self.SDL_GL_LoadLibrary(ffi.NULL) == 1 then
            assert(false, 'SDL_GL_LoadLibrary')
        end

        self.SDL_GL_SetAttribute(self.SDL_GL_DOUBLEBUFFER, 1)
        self.SDL_GL_SetAttribute(self.SDL_GL_DEPTH_SIZE, 24)

        W = 1280
        H = math.floor(W*9/16)

        local window, context

        window = self.SDL_CreateWindow('resurection',
            0, 0,
            W, H,
            attributes)

        if window then
            local nDisplays = self.SDL_GetNumVideoDisplays()

            local r = ffi.new('SDL_Rect');
            if self.SDL_GetDisplayBounds(nDisplays==1 and 0 or 1, r) ~= 0 then
                self.SDL_Log("SDL_GetDisplayBounds failed: %s", self.SDL_GetError())
                return
            end

            self.SDL_SetWindowPosition(window, r.x+100, r.y+100)
            self.SDL_ShowWindow(window)

            context = self.SDL_GL_CreateContext(window)

            if context then
                self.window = window
                self.context = context
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
