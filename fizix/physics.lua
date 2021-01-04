class('Physics')

function Physics.setup()
end

function Physics:init(instance)
    env.physics = self

    self.instance = instance or Fizix()

    self.pause = function(...)
        return self.instance:pause(...)
    end

    self.resume = function(...)
        return self.instance:resume(...)
    end

    self.gravity = function (...)
        return self.instance:gravity(...)
    end

    self.body = function (...)
        return self.instance:body(...)
    end

    self.joint = function (...)
        return self.instance:joint(...)
    end

    self.update = function(dt)
        return self.instance:update(dt)
    end

    self.raycast = function (from, to, category1, category2)
        return self.instance:raycast(from, to, category1, category2)
    end

    self.raycastAll = function (from, to, category1, category2)
        return self.instance:raycastAll(from, to, category1, category2)
    end

    self.queryAABB = function (lowerLeft, upperRight, category1, category2)
        return self.instance:queryAABB(lowerLeft, upperRight, category1, category2)
    end
    
    self.setArea = function (x, y, w, h)
        return self.instance:setArea(x, y, w, h)
    end

end

function Physics.properties.get:deltaTime()
    return self.instance.deltaTime
end

function Physics.properties.get:elapsedTime()
    return self.instance.elapsedTime
end

function Physics.properties.get:bodies()
    return self.instance.bodies
end
