ut:add('octree',
    function (lib)
        local octree = Octree()
        lib:assert('octree', octree)
        
        for i=1,100 do
            local v = vec3.random()
            local value = random()
            lib:assertEqual('set', octree:set(v.x, v.y, v.z, value), value)
            lib:assertEqual('get', octree:get(v.x, v.y, v.z), value)
        end        
    end)
