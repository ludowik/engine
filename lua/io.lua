if love then
    function io.read(path)
        path = path:gsub('%./', '')
        local content, size = love.filesystem.read(
            path)
        return content
    end
    
    function io.write(path, content, mode)
        path = path:gsub('%./', '')
        local res = love.filesystem.write(
            path, content)
        return res
    end
    
else
    function io.read(path)
        local file = io.open(path, 'r')
        if file then
            local content = file:read('*a')
            file:close()
            return content
        end
    end

    function io.write(path, content, mode)
        local file = io.open(path, mode or 'wt')
        if file then
            local res = file:write(content)
            file:close()
            return res
        end
    end
end
