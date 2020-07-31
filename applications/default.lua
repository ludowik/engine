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
        local n = 0
        for k,v in content:gfind("TODO[ :](.-)\n") do
            if n == 0 then
                print(file)
            end
            n = n + 1
            print(k)
        end
    end
    quit()
end
