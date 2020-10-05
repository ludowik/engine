Test5 = class()
Test5.runSetup = false

function Test5:init()
    -- you can accept and set parameters here
    self.title = "filtering"
end

function Test5:setup()
    createGround()
    local box = createBox(WIDTH/2, 100, 50, 50)
    local circle = createCircle(WIDTH/2, 100, 25)
    local box2 = createBox(WIDTH/2, 150, 100, 10)
    
    box.categories = {1}
    box.mask = {0,3}
    
    circle.categories = {2}
    circle.mask = {0,3}
    
    box2.categories = {3}
    box2.mask = {0,1,2}
    
    for k,v in ipairs(box2.categories) do
        print(k,v)
    end
end

function Test5:draw()
    -- Codea does not automatically call this method
end

function Test5:touched(touch)
    -- Codea does not automatically call this method
end
