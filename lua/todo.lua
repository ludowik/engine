function scanTODO()
    local todoList = Array()
    
    local list = dirFile(Path.sourcePath)
    for i,file in ipairs(list) do
        local content = fs.read(file)
        if content then
            local lines = content:split(NL)
            if lines then
                for iline,line in ipairs(lines) do
                    local i,j,v = line:find("TODO[ :](.*)")
                    if i then
                        todoList:insert(file..':'..iline..': '..v)
                    end
                end
            end
        end
    end
    
    local todoText = todoList:concat(NL)
    print(todoText)
    
    fs.write('todo', todoText)
    
    exit()
end
