-- SDL

sdl = sdl or class()

function sdl.load()
    if sdl.loaded then return end
    sdl.loaded = true

    if osx then
        local content = [[
            #define _Nullable 
            #define _Nonnull
            #define GL_GLEXT_PROTOTYPES 1
            #define GL3_PROTOTYPES 1            
            #include <OpenGL/gl3.h>
            #include <sdl2/sdl.h>
            #include <sdl2_image/sdl_image.h>
            #include <sdl2_ttf/sdl_ttf.h>
            ]]
            
        save(osLibPath..'/sdl/src/stub.c', content)

        os.execute(
            "gcc -F/Library/Frameworks     -E '"..osLibPath.."/sdl/src/stub.c' | grep -v '^#' > '"..osLibPath.."/sdl/src/ffi_SDL.c';"..
            "gcc -F/Library/Frameworks -dM -E '"..osLibPath.."/sdl/src/stub.c'                > '"..osLibPath.."/sdl/src/ffi_SDL.h';")
    end

    cload(sdl,
        'SDL2',
        nil,
        osLibPath..'/sdl/src/ffi_SDL.h',
        osLibPath..'/sdl/src/ffi_SDL.c')

    sdl.image = class()
    cload(sdl.image, 'SDL2_image')
end

function sdl.init()
    -- Initialisation de la SDL
    if sdl.SDL_Init(sdl.SDL_INIT_VIDEO) == false then
        assert(false, sdl.getError())
        sdl.SDL_Quit()
        return false
    end

    -- Version OpenGL (4.1 max pour osx)
    sdl.SDL_GL_SetAttribute(sdl.SDL_GL_CONTEXT_MAJOR_VERSION, 4)
    sdl.SDL_GL_SetAttribute(sdl.SDL_GL_CONTEXT_MINOR_VERSION, 1)

    sdl.SDL_GL_SetAttribute(sdl.SDL_GL_CONTEXT_PROFILE_MASK, sdl.SDL_GL_CONTEXT_PROFILE_CORE)

    -- Double Buffer
    sdl.SDL_GL_SetAttribute(sdl.SDL_GL_DOUBLEBUFFER, 1)
    sdl.SDL_GL_SetAttribute(sdl.SDL_GL_DEPTH_SIZE, 16)

    -- Creation de la fenêtre
    sdl.wndMain = sdl.createWindow(0, 0, WIDTH, HEIGHT)

    sdl.setWindow(sdl.wndMain)

    return true
end

function sdl.createWindow(x, y, w, h)
    local ref = {}

    ref.x = x --+ xLEFT
    ref.y = osx and y or 0 --+ yTOP

    ref.w = w or WIDTH
    ref.h = h or HEIGHT

    if sdl.SDL_GetNumVideoDisplays() > 1 then
        local rect = ffi.new('SDL_Rect')
        sdl.SDL_GetDisplayBounds(0, rect)
        ref.x = ref.x + rect.x 
    end

    do
        ref.wnd = sdl.SDL_GL_GetCurrentWindow()
        if ref.wnd == NULL then
            ref.wnd = sdl.SDL_CreateWindow('Codea', ref.x, ref.y, ref.w, ref.h, 0
                + sdl.SDL_WINDOW_OPENGL
                + sdl.SDL_WINDOW_HIDDEN
                + sdl.SDL_WINDOW_RESIZABLE
                --+sdl.SDL_WINDOW_FULLSCREEN
                --+sdl.SDL_WINDOW_ALLOW_HIGHDPI
            )
        end
        if ref.wnd == NULL then
            assert(false, sdl.SDL.SDL_GetError())
            sdl.SDL_Quit()
            return false
        end
    end

    do
        ref.contextOpenGL = sdl.SDL_GL_GetCurrentContext()
        if ref.contextOpenGL == NULL then
            ref.contextOpenGL = sdl.SDL_GL_CreateContext(ref.wnd)
        end
        if ref.contextOpenGL == NULL then
            assert(false, sdl.SDL_GetError())
            sdl.SDL_DestroyWindow(ref.wnd)
            sdl.SDL_Quit()
            return false
        end
    end

    return ref
end

function sdl.setWindow(ref)
    sdl.wndMain = ref
    sdl.SDL_GL_MakeCurrent(
        ref.wnd,
        ref.contextOpenGL)
end

function sdl.releaseWindow(ref)
    sdl.SDL_GL_DeleteContext(ref.contextOpenGL)
    sdl.SDL_DestroyWindow(ref.wnd)
end

function sdl.releaseSDL()
    sdl.releaseWindow(sdl.wndMain)
    sdl.SDL_Quit()
end

local event
function sdl.waitEvent(timeOut)
    event = event or ffi.new('SDL_Event')
    sdl.SDL_WaitEventTimeout(event, timeOut)
    return event
end

function sdl.keys2SDL(keys)
    local newKeys = {}

    for k,v in pairs(keys) do
        local scanName = sdl.SDL_GetScancodeName(sdl.scancode[k])

        if scanName ~= k then
            newKeys[scanName] = v
        end
    end

    table.addKeys(keysKeys, newKeys)
end

function sdl.loadWav(file)
    local wavspec = ffi.new('SDL_AudioSpec[1]')
    local wavbuf = ffi.new('uint8_t*[1]')
    local wavlen = ffi.new('uint32_t[1]')

    wavspec = sdl.SDL_LoadWAV_RW(sdl.SDL_RWFromFile(file, "rb"), 1, wavspec, wavbuf, wavlen)
    return wavspec, wavbuf, wavlen
end

function sdl.SDL_BUTTON(x)
    return (x-1)^2
end

return sdl
