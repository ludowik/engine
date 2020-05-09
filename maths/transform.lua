function resetMatrix()
    if love then
        transform = love.math.newTransform()
    else
        transform = Transform()
    end
end

function translate(x, y, z)
    transform:translate(x, y)
end

class 'Transform'

function Transform:init()
    self:reset()
end

function Transform:reset()
    self.x = -W/2
    self.y = -H/2
    self.z = 0

    self.w = W/2
    self.h = H/2
    self.d = 1
end

function Transform:translate(x, y, z)
    self.x = self.x + x
    self.y = self.y + y
    self.z = self.z + (z or 0)
end
