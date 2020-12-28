Lib = class('Lib')

osLibPath = 'libc'

if osx then
    osLibDir = 'osx'
else
    osLibDir = 'win'
end

function Lib:init(srcPath, libName, lib, content, prefix, loadHeader, loadDef, compileContent)
    Lib.ctypeUINT = Lib.ctypeUINT or ffi.typeof("unsigned int")

    self.libName = libName
    self.lib = lib or self:getLib(self.libName)
    self.content = content
    self.prefix = prefix

    self.loadHeader = loadHeader  == nil and true or loadHeader
    self.loadDef = loadDef == nil and true or loadDef

    self.compileContent = compileContent == nil and true or compileContent

    if osx then
        self.sdk = '/Library/Frameworks'
    end

    self.libPath = srcPath:gsub('/', '.'):gmatch('(.*)%..*$')():gsub('%.', '/') -- osLibPath..'/'..self.libName
    self.mainFile = self.libPath..'/src/'..self.libName..'.cpp'
end

function Lib:getLib(libName)
    local lib = osLibPath..'/bin/'..osLibDir..'/'..libName
    if osx then
        lib = lib..'.so'
    else
        lib = lib..'.dll'
    end
    return lib
end

function Lib:loadLib()
    if self.loaded then return end
    self.loaded = true

    local hFile
    local cFile

    if self.content then
        if self.compileContent then
            local srcPath = self.libPath..'/src'

            local stub = srcPath..'/stub.c'

            hFile = srcPath..'/ffi_'..self.libName..'.h'
            cFile = srcPath..'/ffi_'..self.libName..'.c'

            fs.write(stub, self.content)

            if osx then
                os.execute(
                    "gcc -F"..self.sdk.." -E     '"..stub.."' | grep -v '^#' > '"..cFile.."';"..
                    "gcc -F"..self.sdk.." -dM -E '"..stub.."'                > '"..hFile.."';")
            elseif windows then
                --            os.execute(
                --                'clang -I'..self.sdk..' -w -E -P  "'..stub..'" -o"'..cFile..'";'..
                --                'clang -I'..self.sdk..' -w -E -dM "'..stub..'" -o"'..hFile..'";')
            end
        end
    end

    return self:cload(
        self.lib,
        self.prefix,
        hFile,
        cFile)
end

function Lib:initialize()
end

function Lib:getVersion()
    return '?'
end

function Lib:cload(framework, prexif, header, def, overDef, dontLoad)
    if self.loadHeader and self.content and header then
        if self.compileContent then
            self:cmacro(header, prexif, self)
        end
    end

    if self.loadDef then
        if self.compileContent then
            self:cdef(def)
        else
            ffi.cdef(self.content)
        end
    end

    if not dontLoad then
        self.defsLoaded = ffi.load(framework)
    else
        self.defsLoaded = {}
    end

    self.defs = {initialize=self.initialize}
    self.defs.__index = self.defs

    setmetatable(self, self.defs)

    if overDef == nil then
        setmetatable(self.defs, {
                __index = self.defsLoaded
            })
    end

    self:initialize()

    return self
end

function Lib:cmacro(file, prefix, t)
    local function replace(name, value)
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
            t[name] = t[name] or Lib.ctypeUINT(num)
        end
    end

    local macros = fs.read(file)
    if macros then
        macros:gsub("#define%s+(%S+)%s+(%S+)[\r\n]", replace)
        macros:gsub("#define%s+(%S+)%s+(%S+)[\r\n]", replace)
    end
end

function Lib:cdef(code)
    if code == nil then
        code = fs.read(self.mainFile)
        if code then
            code = code:match('.*extern.*"C".-{(.*).*}.*'):replace("EXPORT", "")
        end
    else
        code = code and fs.read(code) or code
    end

    if code then
        code = code
        :gsub('%^', '*')
        :gsub('__signed', '')
        :gsub('__attribute__%(%(__noescape__%)%)', '')
        :gsub('__attribute__%s*%(%S+%)', '')
        :gsub('(%S+):%d+', '%1')
        :gsub('(%d)L', '%1')
        :gsub('(%d)UL', '%1')
        :gsub('(%d)ull', '%1')
        :gsub(' signed long', ' int')

        ffi.cdef(code)
    end
end
