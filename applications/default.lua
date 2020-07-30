function setup()
    scanTODO()
end

function update(dt)
end

function draw()
end

function scanTODO()
    local list = dirFile('C:/Users/lmilhau/Documents/#Persos/Mes Projets Persos/Lua/Engine')
    for i,file in ipairs(list) do
        local content = fs.read(file)
        for k,v in content:gfind("TODO (%.*)\n") do
            print(k)
        end
    end
    quit()
end
