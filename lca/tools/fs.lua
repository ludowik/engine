lfs = require 'lfs'

fs = {}

function isApp(path)
    if isFile(path..'.lua') then return true end

    if isFile(path..'/main.lua') then return true end
    if isFile(path..'/#.lua') then return true end

    return false
end

function isLuaFile(path)
    return isFile(path) and path:lower():find('%.lua') and true or false
end

function isFile(path)
    return isFileMode(path, 'file')
end

function isDirectory(path)
    return isFileMode(path, 'directory')
end

function isFileMode(path, mode)
    if not path then return false end
    local info = fs.getInfo(path, mode)
    return info and true or false
end

function fs.getInfo(path, mode)
    local info = lfs.attributes(path)
    if info then
        if mode == nil or mode == info.mode then
            info.type = info.mode
            return info
        end
    end
end

function fs.getLastModifiedTime(src)
    local info = fs.getInfo(src)
    return info and info.modification
end

function fs.getDirectoryItems(path)
    local lists = {}
    for fname in lfs.dir(getReadPath(path)) do
        if fname ~= '.' and fname ~= '..' then
            table.insert(lists, fname)
        end
    end
    table.sort(lists, sort)
    return lists
end

function fs.read(src)
    local file = io.open(getReadPath(src), 'r')
    if file then
        local content = file:read('*all')
        file:close()
        return content
    end
end

function fs.write(src, content, mode)
    local file = io.open(getSavePath(src), mode or 'w')
    if file then
        file:write(content)
        file:close()
    end
end

function save(file, content, mode)
    return fs.write(file, content)
end

function load(file)
    return fs.read(file)
end

function fs.mkdir(path)
    if love then
        love.filesystem.createDirectory(path)
    else
        local fullPath = getSavePath(fil)
        lfs.mkdir(fullPath)
    end
end

function loadFile(file, filesPath)
    assert(file)

    local code = nil
    local path = filesPath and filesPath..'/'..file or file
    if isFile(path) then
        code = fs.read(path)
    else
        code = file
    end
    return code
end

function loadFiles(files, filesPath)
    if files == nil then return end
    
    local lines = {}

    local code = nil
    if type(files) == 'table' then
        code = ""
        for i,file in ipairs(files) do
            local subcode = loadFile(file, filesPath)
            code = code..'\n'..subcode
            lines[#lines+1] = #subcode:split(NL)
        end
    else
        code = loadFile(files, filesPath)
        lines[#lines+1] = #code:split(NL)
    end

    return code, lines
end

local function checkFile(file, filesPath, time)
    assert(file)

    local path = filesPath and filesPath..'/'..file or file
    local currentTime = fs.getLastModifiedTime(path)

    return max(currentTime or 0, time)
end

function checkFiles(files, filesPath, time)
    if files == nil then return end

    if type(files) == 'table' then
        for i,file in ipairs(files) do
            time = checkFile(file, filesPath, time)
        end
    else
        time = checkFile(files, filesPath, time)
    end

    return time
end
