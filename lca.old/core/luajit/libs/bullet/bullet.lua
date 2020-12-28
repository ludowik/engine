ffi.cdef[[
    typedef struct btDiscreteDynamicsWorld World;
    World* world_new();    
    void world_gc(World* world);
    
    void world_step(World* world, float dt);
]]

local bullet
if osx then
    bullet = ffi.load(osLibPath..'/bin/'..osLibDir..'/bullet.so')
else
    bullet = ffi.load(osLibPath..'/bin/'..osLibDir..'/bullet.dll')
end

function newPhysics3D()
    return nil 
--    return ffi.gc(
--        bullet.world_new(),
--        function (world)
--            bullet.world_gc(world)
--        end)
end

local world_index = {
    update = function (self, dt)
        self:step(dt)
    end,

    step = function (self, dt)
        return bullet.world_step(self, dt)
    end
}

local b2World_mt = ffi.metatype('World', {
        __newindex = function (tbl, key, value)
            if key == 'param' then
            else
                rawset(world_index, key, value)
            end
        end,
        __index = function (tbl, key)
            if key == 'param' then
            else
                return rawget(world_index, key)
            end
        end
    })

return newPhysics3D()
