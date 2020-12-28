function setup()
    physicsInstance = PhysicsInstance()
    
    physicsInstance.debug = true

    local ground = Rect(WIDTH/2, 0, WIDTH, 100)
    app.scene:add(ground)
    
    physicsInstance:add(ground, STATIC, RECT, ground.size.x, ground.size.y)

    for i=1,10 do
        local object = Object():setPosition(
            math.random(WIDTH),
            math.random(HEIGHT))

        app.scene:add(object)
        physicsInstance:add(object, DYNAMIC, table.random({RECT, CIRCLE, POLYGON}))
    end

    parameter.watch("#fizix.bodies")
    parameter.watch("#fizix.contacts")
    
    app.scene:add(physicsInstance)
end

function touched(touch)
    if touch.state == BEGAN then
        for i,body in physicsInstance.bodies:iterator() do
            if body:testPoint(touch) then
                currentObject = body
                break
            end
        end

    elseif touch.state == MOVING and currentObject then
        currentObject:touched(touch)

    else
        currentObject = nil

    end
end
