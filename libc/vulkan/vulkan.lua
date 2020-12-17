-- TODO : autogenerate header for library

function Library.makeHeader(srcName, moduleName)
    if osx then
        libDir = libDir or ('/Users/Ludo/Projets/Libraries/'..moduleName)
    else
        libDir = libDir or ('/Windows/System32')
    end
    
    stub = 'libc/'..moduleName..'/'..srcName
    
    local headerFile = 'libc/'..moduleName..'/'..moduleName..'.header'
    local macroFile = 'libc/'..moduleName..'/'..moduleName..'.macro'
    
    local compiler = [[
            set PATH=C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Tools\Llvm\bin;%%PATH%%;
            clang.exe]]

    command =  compiler.." -F"..libDir.." -E     '"..stub.."' | grep -v '^#' > '"..headerFile.."';"
    
    io.write('libc/bin/make_header.bat', command)
    os.execute('"libc\\bin\\make_header.bat" > libc\\bin\\make_header.log')

    command = compiler.." -F"..libDir.." -dM -E '"..stub.."'                > '"..macroFile.."';"
    
    io.write('libc/bin/make_macro.bat', command)
    os.execute('"libc\\bin\\make_macro.bat" > libc\\bin\\make_macro.log')
end

Library.makeHeader('stub.c', 'Vulkan')

local code, defs = Library.precompile(io.read('libc/vulkan/vulkan.out'))
ffi.cdef(code)

code, defs = Library.precompile(io.read('libc/vulkan/vulkan.macro'))
--ffi.cdef(code)

class 'Vulkan' : extends(Component) : meta(not loaded and Library.load('Vulkan') or ffi.C)

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

function lshift(value, n)
    return value * 2^n
end

function VK_MAKE_VERSION(major, minor, patch)
    return lshift(major, 22) + lshift(minor, 12) + patch
end
