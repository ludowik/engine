function dir(path)
    path = path or '.'

    local items = fs.getDirectoryItems(path)

    local paths = Table()
    for _,item in ipairs(items) do
        paths:add(path..'/'..item)
    end

    return paths
end

function dirApp(path)
    path = path or '.'

    local items = fs.getDirectoryItems(path)

    local paths = Table()
    for _,item in ipairs(items) do
        if isLuaFile(path..'/'..item) or isDirectory(path..'/'..item) then
            item = item:replace('%.lua', '')
            if paths:findItem(path..'/'..item) == nil then
                paths:add(path..'/'..item)
            end
        end
    end

    return paths
end

function exists(path)
    return isFile(path) or isDirectory(path)
end

function isFile(path)
    return isFileMode(path, 'file')
end

function isLuaFile(path)
    return isFile(path) and path:lower():find('%.lua') and true or false
end

function isDirectory(path)
    return isFileMode(path, 'directory')
end

function isFileMode(path, mode)
    if not path then return false end
    local info = fs.getInfo(path, mode)
    return info and true or false
end

function isApp(path)
    if isFile(path..'.lua') then return true end

    if isFile(path..'/main.lua') then return true end
    if isFile(path..'/#.lua') then return true end

    return false
end
