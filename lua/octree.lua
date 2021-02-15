require 'maths.rect'

class 'Octree' : extends(Cube)

function Octree:init(AREA_SIZE, CUBE_SIZE)
    Cube.init(self,
        -AREA_SIZE,
        -AREA_SIZE,
        -AREA_SIZE,
        AREA_SIZE*2,
        AREA_SIZE*2,
        AREA_SIZE*2)

    self.CUBE_SIZE = CUBE_SIZE
end

function Octree:add(node, root)
    if not Cube.intersect(self, node) then return end

    root = root or self

    if self.items then
        self.items:add(node)
    else
        if not self.swf then
            local x = self.position.x
            local y = self.position.y
            local z = self.position.z
            local w = self.size.x / 2
            local h = self.size.y / 2
            local d = self.size.z / 2
            self.swf = OctreeNode(root, x  , y  , z  , w, h, d)
            self.sef = OctreeNode(root, x+w, y  , z  , w, h, d)
            self.nwf = OctreeNode(root, x  , y+h, z  , w, h, d)
            self.nef = OctreeNode(root, x+w, y+h, z  , w, h, d)
            self.swr = OctreeNode(root, x  , y  , z+d, w, h, d)
            self.ser = OctreeNode(root, x+w, y  , z+d, w, h, d)
            self.nwr = OctreeNode(root, x  , y+h, z+d, w, h, d)
            self.ner = OctreeNode(root, x+w, y+h, z+d, w, h, d)
        end

        self.swf:add(node, root)
        self.sef:add(node, root)
        self.nwf:add(node, root)
        self.nef:add(node, root)
        self.swr:add(node, root)
        self.ser:add(node, root)
        self.nwr:add(node, root)
        self.ner:add(node, root)
    end
end

function Octree:draw()
    stroke(gray)
    strokeWidth(1)

    if not self.buffer then
        local x, y, z, w, h, d = self.position.x, self.position.y, self.position.z, self.size.x, self.size.y, self.size.z

        self.buffer = Buffer('vec3',
            {
                vec3(x  , y  , z), vec3(x+w, y  , z),
                vec3(x+w, y  , z), vec3(x+w, y+h, z),
                vec3(x+w, y+h, z), vec3(x  , y+h, z),
                vec3(x  , y+h, z), vec3(x  , y  , z),

                vec3(x  , y  , z+d), vec3(x+w, y  , z+d),
                vec3(x+w, y  , z+d), vec3(x+w, y+h, z+d),
                vec3(x+w, y+h, z+d), vec3(x  , y+h, z+d),
                vec3(x  , y+h, z+d), vec3(x  , y  , z+d),

                vec3(x  , y  , z), vec3(x  , y  , z+d),
                vec3(x+w, y  , z), vec3(x+w, y  , z+d),
                vec3(x+w, y+h, z), vec3(x+w, y+h, z+d),
                vec3(x  , y+h, z), vec3(x  , y+h, z+d)
            })
    end

    lines3D(self.buffer)

    stroke(red)

    if self.items then
        for i,item in ipairs(self.items) do
            item:draw()
        end
    else
        if self.swf then
            self.swf:draw()
            self.sef:draw()
            self.nwf:draw()
            self.nef:draw()
            self.swr:draw()
            self.ser:draw()
            self.nwr:draw()
            self.ner:draw()
        end
    end
end

class 'OctreeNode' : extends(Octree)

function OctreeNode:init(root, x, y, z, w, h, d)
    Cube.init(self, x, y, z, w, h, d)

    if w <= root.CUBE_SIZE then
        self.items = Array()
    end
end
