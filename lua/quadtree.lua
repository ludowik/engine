require 'maths.rect'

class 'Quadtree' : extends(Rect)

function Quadtree:init(AREA_SIZE, QUAD_SIZE)
    Rect.init(self,
        -AREA_SIZE,
        -AREA_SIZE,
        AREA_SIZE*2,
        AREA_SIZE*2)
    
    self.QUAD_SIZE = QUAD_SIZE
end

function Quadtree:add(node, root)
    if not Rect.intersect(self, node) then return end

    root = root or self
    
    if self.items then
        self.items:add(node)
    else
        if not self.sw then
            local x = self.position.x
            local y = self.position.y
            local w = self.size.x / 2
            local h = self.size.y / 2
            self.sw = QuadtreeNode(root, x  , y  , w, h)
            self.se = QuadtreeNode(root, x+w, y  , w, h)
            self.nw = QuadtreeNode(root, x  , y+h, w, h)
            self.ne = QuadtreeNode(root, x+w, y+h, w, h)
        end

        self.sw:add(node, root)
        self.se:add(node, root)
        self.nw:add(node, root)
        self.ne:add(node, root)
    end
end

function Quadtree:draw()
    stroke(gray)
    strokeWidth(1)
    noFill()
    rectMode(CORNER)
    rect(self.position.x, self.position.y, self.size.x, self.size.y)

    stroke(red)
    
    if self.items then
        for i,item in ipairs(self.items) do
            item:draw()
        end
    else
        if self.sw then
            self.sw:draw()
            self.se:draw()
            self.nw:draw()
            self.ne:draw()
        end
    end
end

class 'QuadtreeNode' : extends(Quadtree)

function QuadtreeNode:init(root, x, y, w, h)
    Rect.init(self, x, y, w, h)

    if w <= root.QUAD_SIZE then
        self.items = Array()
    end
end
