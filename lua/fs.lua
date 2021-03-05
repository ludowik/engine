if love then
    lfs = {}

    lfs.attributes = function (name)
        local info = love.filesystem.getInfo(name)
        if info then
            return {
                mode = info.type,
                modification = info.modtime
            }
        end
    end

    lfs.currentdir = function ()
        return love.filesystem.getWorkingDirectory()
    end

    lfs.mkdir = function (name)
        love.filesystem.createDirectory(name)
    end

    lfs.dir = function (path)
        local files = Table()
        local items = love.filesystem.getDirectoryItems(path)
        for i,item in ipairs(items) do
            files:add(item)
        end
        local i = 0
        return function ()
            if i == #files then return nil end
            i = i + 1
            return files[i]
        end
    end

else
    lfs = require 'lfs'
end

function splitPath(path)
    local j = path:findLast('/')

    local name = j and path:sub(j+1) or path
    local directory = j and path:sub(1, j) or ''

    return directory, name
end

function splitFilePath(strFilename)
    -- Returns the Path, Filename, and Extension as 3 values
    if lfs.attributes(strFilename, 'mode') == 'directory' then
        local strPath = strFilename:gsub('[\\/]$', '')
        return strPath..'\\', '', ''
    end
    strFilename = strFilename..'.'
    return strFilename:match('^(.-)([^\\/]-)%.([^\\/%.]-)%.?$')
end

function isApp(path)
    local directory, filename = splitPath(path)
    local _, _, ext = splitFilePath(path)
    if (
        ( 
            (
                ( 
                    isFile(path) and
                    ext == 'lua'
                    ) or
                isFile(path..'.lua')
                ) and
            not isFile(directory..'/#.lua') and
            not isFile(directory..'/main.lua')
            ) or
        isFile(path..'/#.lua') or
        isFile(path..'/main.lua') or
        isFile(path..'/'..filename..'.lua'))
    then
        return true
    end

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
    local info = getInfo(path, mode)
    return info and true or false
end

function exists(path)
    return getInfo(path) and true or false
end

function getInfo(path, mode)
    local info = lfs.attributes(getReadPath(path))
    if info then
        if mode == nil or mode == info.mode then
            info.type = info.mode
            return info
        end
    end
end

function getLastModifiedTime(path)
    local info = getInfo(path)
    return info and info.modification
end

function getDirectoryItems(path)
    local lists = {}
    for fname in lfs.dir(getReadPath(path)) do
        if fname ~= '.' and fname ~= '..' then
            table.insert(lists, fname)
        end
    end
    table.sort(lists, sort)
    return lists
end

function mkdir(path)
    local fullPath = getSavePath(path)
    lfs.mkdir(fullPath)
end

function save(path, content, mode)
    if love then
        return io.write(path, content, mode)
    else
        return io.write(getSavePath(path), content, mode)
    end
end

function load(path)
    return io.read(getReadPath(path))
end

-- TODO : clean code, usefull subPath
function dir(path, checkType, recursivly, list, subPath)
    assert(subPath == nil)

    list = list or Array()
    for file in lfs.dir(path) do
        if not file:startWith('.') then
            if recursivly and isDirectory(path..'/'..file) then
--                dir(path..'/'..file, checkType, recursivly, list, subPath and (subPath..'/'..file) or file)
                dir(path..'/'..file, checkType, recursivly, list)

            elseif not checkType or checkType(path..'/'..file) then
--                table.insert(list, subPath and (subPath..'/'..file) or file)
                table.insert(list, path..'/'..file)
            end
        end
    end
    list:sort()

    return list
end

function dirApps(path, recursivly, list, subPath)
    -- TODO : clean code, usefull subPath
    return dir(path, isApp, recursivly, list, subPath)
end

function dirFiles(path, recursivly, list, subPath)
    -- TODO : clean code, usefull subPath 
    return dir(path, isFile, recursivly, list, subPath)
end

function dirDirectories(path, recursivly, list, subPath)
    -- TODO : clean code, usefull subPath
    return dir(path, isDirectory, recursivly, list, subPath)
end

function loadFile(file, filesPath)
    assert(file)

    local code = nil
    local path = filesPath and filesPath..'/'..file or file
    if isFile(path) then
        code = load(path)
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
            code = code..NL..subcode
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
    local currentTime = getLastModifiedTime(path)

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
