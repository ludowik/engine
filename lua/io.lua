io.read = function (fileName)
    local f = io.open(fileName)
    if f then
        local res = f:read('*a')
        f:close()
        return res
    end
end

if love then
    io.read = function(fileName)
        fileName = fileName:gsub('%./', '')
        local contents, size = love.filesystem.read(
            fileName)
        return contents
    end
end

io.write = function (fileName, content)
    local f = io.open(fileName, "wt")
    if f then
        local res = f:write(content)
        f:close()
        return res
    end
end
