glm = nil
if osx then
    glm = ffi.load(osLibPath..'/bin/'..osLibDir..'/glm.so')
else
    glm = ffi.load(osLibPath..'/bin/'..osLibDir..'/glm.dll')
end

require(osLibPath..'/glm/matrix')
require(osLibPath..'/glm/vec2')

return glm
