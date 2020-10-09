class('Octree')

local function minLevel(v)
    if v == nil then return 2 end

    local level = 1
    repeat
        level = level * 2
    until level > v
    return level
end

assert(minLevel(1) == 2)
assert(minLevel(3) == 4)
assert(minLevel(500) == 512)
assert(minLevel(513) == 1024)

function Octree:init(w, h, d)
    self.w = minLevel(w)
    self.h = minLevel(h)
    self.d = minLevel(d)

    self.data = {}
end

function Octree:key(x, y, z)
    local key = x..y..z
    return key
end

function Octree:get(x, y, z)
    local key = self:key(x, y, z)
    return self.data[key]
end

function Octree:set(x, y, z, value)
    local key = self:key(x, y, z)
    self.data[key] = value
    return value
end

function Octree:update(dt)
end

function Octree:draw()
end

function Octree:test()
    local octree = Octree()
    assert(octree, 'octree')

    for i=1,100 do
        local v = vec3.random()
        local value = random()
        assert(octree:set(v.x, v.y, v.z, value) == value, 'set')
        assert(octree:get(v.x, v.y, v.z) == value, 'get')
    end
end
