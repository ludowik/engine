-- macro
ffi = require 'ffi'

function loadLib(libName, libPath, content)    
    ffi.cdef([[
        void* memset(void* ptr, int value, size_t num);
        void* memcpy(void* destination, const void* source, size_t num);
    ]])

    lfs.chdir('system/ffi')

    local source = libName..'.c'

    lfs.write(source, content)

    local hFile = 'ffi_'..libName..'.h'
    local cFile = 'ffi_'..libName..'.c'

    os.execute(
        "gcc -E     "..source.." | grep -v '^#' > "..cFile..";"..
        "gcc -dM -E "..source.." > "..hFile..";"
    )

    lfs.chdir('../..')

    local lib = cload(
        libPath,
        libName..'_',
        hFile,
        cFile)

    return lib
end

function cload(self, framework, prexif, header, def, overDef)
    if osx then
        framework = framework..'.framework/'..framework
    end

    self = self or {}
    if header then
        cmacro(header, prexif, self)
    end

    if def then
        cdef(def)
    end

    self.defsLoaded = ffi.load(framework)
    self.defs = {}

    setmetatable(self, {
            __index = self.defs
        })

    if overDef == nil then
        setmetatable(self.defs, {
                __index = self.defsLoaded
            })
    end

    return self
end

function cmacro(file, prefix, t)
    local function replace(name, value)
        macroReplace(prefix, name, value, t)
    end

    local macros = load(file)

    macros:gsub("#define (%S+)%s+(%S+)\n", replace)
    macros:gsub("#define (%S+)%s+(%S+)\n", replace)
end

function cdef(file)
    local header = load(file)

    :gsub('%^', '*')
    :gsub('__attribute__%s*%(%S+%)', '')

    ffi.cdef(header)
end

local ctype = ffi.typeof("unsigned int")

function macroReplace(prefix, name, value, t)
    if t[name] or prefix and not name:find(prefix) then
        return
    end

    local num = tonumber(value)
    if not num then
        if t[value] then
            num = tonumber(t[value])

        elseif (value:match("ull$")) then
            num = tonumber(evalExpression(value))

        elseif (value:match("u$")) then
            value = value:gsub("u$", "")
            num = tonumber(value)

        end
    end

    if num then
        t[name] = t[name] or ctype(num)
    end
end
