ffi.cdef[[
    void sleep(unsigned long delay)
]]

local tools
if osx then
    tools = ffi.load(osLibPath..'/bin/'..osLibDir..'/tools.so')
else
    tools = ffi.load(osLibPath..'/bin/'..osLibDir..'/tools.dll')
end

return tools
