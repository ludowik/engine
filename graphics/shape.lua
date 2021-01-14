class 'Shape'

function Shape:init()
    self.vertices = Buffer('vec3')
end

function Shape:draw()
    if self.mode == LINES then
        lines(self.vertices)
    elseif self.mode == CLOSE then
        polygon(self.vertices)
    else
        polyline(self.vertices)
    end
end

CLOSE = 'close'
LINES = 'lines'

local shape

function beginShape()
    shape = Shape()
end

local v = vec3()
function vertex(x, y, z)
    v.x = x
    v.y = y
    v.z = z or 0
    
    shape.vertices[#shape.vertices+1] = v
end

function endShape(mode)
    shape.mode = mode
    shape:draw()
    
    return shape
end
