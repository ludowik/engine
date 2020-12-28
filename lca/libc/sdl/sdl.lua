local srcPath, lib, libImage = ...
if osx then
    lib = 'SDL2.framework/SDL2'
    libImage = 'SDL2_image.framework/SDL2_image'
else
    lib = 'SDL2'
    libImage = 'SDL2_image'
end

local content = [[
    #define __attribute__(_)
    #define __declspec(_)
        
    #define _Nullable
    #define _Nonnull
    #define _Null_unspecified

    #define __unaligned
    #define __forceinline
    #define __compar
    #define __inline__

    #define _Bool bool
            
    #define APIENTRY

    #define GL_GLEXT_PROTOTYPES 1
    #define GL3_PROTOTYPES 1
    #define GL_SILENCE_DEPRECATION        

    #include <OpenGL/gl3.h>

    #include <sdl2/sdl.h>
    #include <sdl2_image/sdl_image.h>
    #include <sdl2_ttf/sdl_ttf.h>

    //#include <vulkan/vulkan.h>
]]

sdl = Lib(srcPath, 'SDL', lib, content)

function sdl.initialize()
    sdl.image = Lib(srcPath, 'sdl_image', libImage)
    sdl.image:loadLib()

    -- Initialisation de la SDL
    if sdl.SDL_Init(sdl.SDL_INIT_VIDEO) == false then
        assert(false, sdl.getError())
        sdl.SDL_Quit()
        return false
    end

    gl.majorVersion = 2
    gl.minorVersion = 1

    if gl.majorVersion > 2 then
        sdl.SDL_GL_SetAttribute(sdl.SDL_GL_CONTEXT_PROFILE_MASK, sdl.SDL_GL_CONTEXT_PROFILE_CORE)
    end

    sdl.SDL_GL_SetAttribute(sdl.SDL_GL_CONTEXT_MAJOR_VERSION, gl.majorVersion)
    sdl.SDL_GL_SetAttribute(sdl.SDL_GL_CONTEXT_MINOR_VERSION, gl.minorVersion)

    if osx then
        assert(sdl.SDL_GL_LoadLibrary(NULL) == 0)
    end

    -- Double Buffer
    sdl.SDL_GL_SetAttribute(sdl.SDL_GL_DOUBLEBUFFER, 1)
    sdl.SDL_GL_SetAttribute(sdl.SDL_GL_DEPTH_SIZE, 24)

    -- Multi Sampling :
    msaa = 0 -- The number of antialiasing samples
    if msaa > 0 then
        sdl.SDL_GL_SetAttribute(sdl.SDL_GL_MULTISAMPLEBUFFERS, 1)
        sdl.SDL_GL_SetAttribute(sdl.SDL_GL_MULTISAMPLESAMPLES, msaa)
    end

    -- Creation de la fenêtre
    sdl.wndMain = sdl.createWindow()
    sdl.setWindow(sdl.wndMain)

    return true
end

function sdl.getVersion()
    local SDL_version = ffi.new('SDL_version')
    sdl.SDL_GetVersion(SDL_version)
    return SDL_version.major..'.'..SDL_version.minor..'.'..SDL_version.patch
end

function sdl.createWindow(x, y, w, h)
    local ref = {}

    ref.x = x or 0
    ref.y = y or 0

    ref.w = w or 640
    ref.h = h or 480

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
                + (config.highDPI    and sdl.SDL_WINDOW_ALLOW_HIGHDPI or 0)
                + (config.fullScreen and sdl.SDL_WINDOW_FULLSCREEN or 0)
            )
        end
        if ref.wnd == NULL then
            assert(false, tostring(sdl.SDL_GetError()))
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
            assert(false, tostring(sdl.SDL_GetError()))
            sdl.SDL_DestroyWindow(ref.wnd)
            sdl.SDL_Quit()
            return false
        end
    end

    return ref
end

function sdl.setWindowSize(ref, w, h)
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

local displayMode
function sdl.getCurrentDisplayMode()
    displayMode = displayMode or ffi.new('SDL_DisplayMode')
    sdl.SDL_GetCurrentDisplayMode(0, displayMode)
    return displayMode
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
