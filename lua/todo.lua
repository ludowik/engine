function scanTODO()
    local function scan(todos)
        local todoLists = {}
        for _,todoName in ipairs(todos) do
            todoLists[todoName] = Array()
        end

        local list = dirFiles(Path.sourcePath, true)
        for i,file in ipairs(list) do

            local content = load(file)
            if content then

                local lines = content:split(NL)
                if lines then
                    for iline,line in ipairs(lines) do

                        for _,todoName in ipairs(todos) do
                            local i,j,v = line:find('([ -]'..todoName..'[ :]*.*)')
                            if i then
                                local ref = file:gsub(Path.sourcePath..'/', '')
                                todoLists[todoName]:insert(ref..':'..iline..': '..v)
                            end
                        end

                    end
                end

            end
        end

        for _,todoName in ipairs(todos) do
            if #todoLists[todoName] > 0 then
                local data = todoLists[todoName]:concat(NL)
                
                print(todoName)
                print(data)

                save('todo', data, 'at')
            end
        end
    end
    
    save('todo', '', 'wt')

    scan{
        'TODO',
        'TODEL',
        'TOFIX',
        'TOTEST'
    }

    exit()
end
