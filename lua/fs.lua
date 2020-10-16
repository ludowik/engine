fs = {}

-- TODO : fs.

function splitPath(path)
    local j = path:findLast('/')

    local name = j and path:sub(j+1) or path
    local directory = j and path:sub(1, j) or ''

    return name, directory
end

function isApp(path)
    if (
        isFile(path..'/#.lua') or
        isFile(path..'/main.lua') or
        isFile(path..'.lua'))
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
    local info = fs.getInfo(path, mode)
    return info and true or false
end

function exists(path)
    return fs.getInfo(path) and true or false
end

function fs.getInfo(path, mode)
    local info = lfs.attributes(getReadPath(path))
    if info then
        if mode == nil or mode == info.mode then
            info.type = info.mode
            return info
        end
    end
end

function fs.getLastModifiedTime(path)
    local info = fs.getInfo(path)
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

-- TODO : duplicate with io.read
function fs.read(path)
    local file = io.open(getReadPath(path), 'r')
    if file then
        local content = file:read('*all')
        file:close()
        return content
    end
end

function fs.write(path, content, mode)
    local file = io.open(getSavePath(path), mode or 'w')
    if file then
        file:write(content)
        file:close()
    end
end

-- TODO
function save(path, content, mode)
    return fs.write(path, content, mode)
end

function load(path)
    return fs.read(path)
end

function fs.mkdir(path)
    local fullPath = getSavePath(path)
    lfs.mkdir(fullPath)
end

function dir(path, checkType, recursivly, list, subPath)
    assert(subPath == nil)

    list = list or Array()
    for file in lfs.dir(path) do
        if not file:startWith('.') then
            if checkType(path..'/'..file) then
                --                table.insert(list, subPath and (subPath..'/'..file) or file)
                table.insert(list, path..'/'..file)
            end

            if recursivly and isDirectory(path..'/'..file) then
                --                dir(path..'/'..file, checkType, recursivly, list, subPath and (subPath..'/'..file) or file)
                dir(path..'/'..file, checkType, recursivly, list)
            end
        end
    end
    return list
end

function dirApps(path, recursivly, list, subPath)
    return dir(path, isApp, recursivly, list, subPath)
end

function dirFiles(path, recursivly, list, subPath)
    return dir(path, isFile, recursivly, list, subPath)
end

function dirDirectories(path, recursivly, list, subPath)
    return dir(path, isDirectory, recursivly, list, subPath)
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

function fs.splitFilePath(fpath)
    -- Returns the Path, Filename, and Extension as 3 values
    if lfs.attributes(fpath, 'mode') == 'directory' then
        local strPath = fpath:gsub("[\\/]$", "")
        return strPath.."\\", "", ""
    end

    fpath = fpath.."."
    return fpath:match("^(.-)([^\\/]-%.([^\\/%.]-))%.?$")
end
