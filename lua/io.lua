io.read = function (fileName)
    local f = io.open(fileName)
    if f then
        res = f:read('*a')
        f:close()
        return res
    end
end

io.write = function (fileName, content)
    local f = io.open(fileName, "wt")
    if f then
        res = f:write(content)
        f:close()
        return res
    end
end
