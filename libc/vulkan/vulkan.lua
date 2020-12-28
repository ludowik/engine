-- TODO : autogenerate header for library

libDir = '/Users/Ludo/Projets/Libraries/'..'Vulkan'
stub = "libc/vulkan/stuc.c"

command =  "gcc -F"..libDir.." -E     '"..stub.."' | grep -v '^#' > '"..'libc/vulkan/vulkan.out'.."';"
os.execute(command)

command = "gcc -F"..libDir.." -dM -E '"..stub.."'                > '"..'libc/vulkan/vulkan.macro'.."';"
os.execute(command)

local code, defs = Library.precompile(io.read('libc/vulkan/vulkan.out'))
ffi.cdef(code)

code, defs = Library.precompile(io.read('libc/vulkan/vulkan.macro'))
--ffi.cdef(code)

class 'Vulkan' : extends(Component) : meta(not loaded and Library.load('Vulkan') or ffi.C)

function Vulkan:load()
    self.flag = sdl.SDL_WINDOW_VULKAN
end

function Vulkan:createContext(window)
    return sdl.SDL_GL_CreateContext(window)
end

function Vulkan:initialize()
    for k,v in pairs(defs) do
        self[k] = v
    end

    appInfo = ffi.new('VkApplicationInfo')

    appInfo.sType = self.VK_STRUCTURE_TYPE_APPLICATION_INFO
    appInfo.pApplicationName = "Hello Triangle"
    appInfo.applicationVersion = VK_MAKE_VERSION(1, 0, 0)
    appInfo.pEngineName = "No Engine"
    appInfo.engineVersion = VK_MAKE_VERSION(1, 0, 0)
    appInfo.apiVersion = VK_MAKE_VERSION(1, 0, 0)
    
    createInfo = ffi.new('VkInstanceCreateInfo')
    createInfo.sType = self.VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO
    createInfo.pApplicationInfo = appInfo
    
    local result = self.vkCreateInstance(createInfo, ffi.NULL, instance)
    
    if result ~= self.VK_SUCCESS then
        error('init vulkan ko')
    end
    print('init vulkan ok')
end

function Vulkan:release()
end

local function lshift(value, n)
    return value * 2^n
end

function VK_MAKE_VERSION(major, minor, patch)
    return lshift(major, 22) + lshift(minor, 12) + patch
end
