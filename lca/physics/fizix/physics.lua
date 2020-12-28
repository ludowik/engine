class('Physics')

function Physics.setup()
    Physics.instance = newPhysics()  
end

function Physics:init(instance)
    Physics.instance = instance or Physics.instance
    return Physics
end

function Physics.gravity(...)
    return Physics.instance:gravity(...)
end

function Physics.pause()
    return Physics.instance:pause()
end

function Physics.resume()
    return Physics.instance:resume()
end

function Physics.body(...)
    return Physics.instance:body(...)
end

function Physics.joint(...)
    return Physics.instance:joint(...)
end

function Physics.update(dt)
    return Physics.instance:update(dt)
end

function Physics.raycast(from, to, category1, category2)
    return Physics.instance:raycast(from, to, category1, category2)
end

function Physics.raycastAll(from, to, category1, category2)
    return Physics.instance:raycastAll(from, to, category1, category2)
end

function Physics.queryAABB(lowerLeft, upperRight, category1, category2)
    return Physics.instance:queryAABB(lowerLeft, upperRight, category1, category2)
end
