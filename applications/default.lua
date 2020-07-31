function setup()
    scanTODO()
end

function update(dt)
end

function draw()
end

function scanTODO()
    local list = dirFile(Path.sourcePath)
    for i,file in ipairs(list) do        
        local content = fs.read(file)
        if content then
            local lines = content:split(NL)
            if lines then
                for iline,line in ipairs(lines) do
                    local i,j,v = line:find("TODO[ :](.*)")
                    if i then                    
                        print(file..':'..iline..': '..v)
                    end
                end
            end
        end
    end
end
