Test7 = class()
Test7.runSetup = false

function Test7:init()
    -- you can accept and set parameters here
    self.title = "raycasting and aabb queries"
    self.point1 = vec2(WIDTH/2, 0)
    self.point2 = vec2(WIDTH/2, HEIGHT/4)
    
    self.point3 = vec2(0, 30)
    self.point4 = vec2(WIDTH/2-10, 30)
    
    self.aabb = {vec2(500,25), vec2(600,125)}
end

function Test7:draw()
    -- Codea does not automatically call this method
    result = physics.raycast(self.point1, self.point2)
    pushStyle()
    stroke(0, 255, 0, 255)
    strokeWidth(5)
    if result then    
        line(self.point1.x, self.point1.y, result.point.x, result.point.y)
        result.body:applyForce(vec2(0,25))
    else
        line(self.point1.x, self.point1.y, self.point2.x, self.point2.y)
    end
    
    line(self.point3.x, self.point3.y, self.point4.x, self.point4.y)
    
    fill(255, 0, 0, 255)
    results = physics.raycastAll(self.point3, self.point4)
    for k,v in ipairs(results) do
        ellipse(v.point.x, v.point.y, 10, 10)
        v.body:applyForce(vec2(2,0))
    end
        
    strokeWidth(5)
    noFill()
    if #physics.queryAABB(self.aabb[1], self.aabb[2]) > 0 then
        stroke(255, 0, 255, 255)
    else
        stroke(194, 194, 194, 128)
    end
    rectMode(CORNERS)
    rect(self.aabb[1].x, self.aabb[1].y, self.aabb[2].x, self.aabb[2].y)
    
    popStyle()
end

function Test7:setup()
    createGround()
    createBox(WIDTH/2,HEIGHT - 50,25,25)
    createCircle(50, 50, 25)
    createCircle(75, 50, 12.5)
end

function Test7:cleanup()
end

function Test7:touched(touch)
end

