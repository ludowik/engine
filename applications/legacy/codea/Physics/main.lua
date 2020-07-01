_G.physics = box2dRef.Physics()

--# addRect
addRect = class()

function addRect:init(x,y,endX,endY)
    -- you can accept and set parameters here
    local w,h = endX-x,endY-y
    self.body = physics.body(POLYGON,vec2(w/2,h/2),vec2(w/2,-h/2),vec2(-w/2,-h/2),vec2(-w/2,h/2))
    self.body.x = (x + endX)/2
    self.body.y = (y + endY)/2
    self.m = mesh()
    self.m.vertices = triangulate(self.body.points)
    self.m:setColors(255,255,255)
    self.body.fixedRotation = false
    self.body.friction = 0.2
    self.body.restitution = 0.0
    self.body.angle = 0
end

function addRect:draw()
    -- Codea does not automatically call this method
    pushMatrix()
    translate(self.body.x,self.body.y)
    rotate(self.body.angle)
    self.m:draw()
    popMatrix()
end

function addRect:touched(touch)
    -- Codea does not automatically call this method
end

--# Main
-- Creations testing

-- Use this function to perform your initial setup
function setup()
    supportedOrientations(LANDSCAPE_ANY)
    
    objects = {}
    local a = generateWorld()
    m = mesh()
    m.vertices = triangulate(a)
    m:setColors(0,255,0)
    ground = physics.body(CHAIN, true, unpack(a))
    touchesP = {}
    tId = nil
    initPos = nil
    noSmooth()
    frame = 1
end

-- This function gets called once every frame
function draw()
    -- This sets a dark background color 
    background(40, 40, 50)

    -- This sets the line thickness
    noStroke()
    fill(255)
    
    -- Do your drawing here
    m:draw()
    if tId then
        if touchesP[tId].state==ENDED then
            if touchesP[tId].x ~= initPos.x and touchesP[tId].y ~= initPos.y then
                objects[#objects+1] = addRect(initPos.x,initPos.y,touchesP[tId].x,touchesP[tId].y)
                tId = nil
                initPos = nil
            end
        else
            rect(initPos.x,initPos.y,touchesP[tId].x-initPos.x,touchesP[tId].y-initPos.y)
        end
    end
    for i,v in pairs(objects) do
        v:draw()
    end
    text(math.floor(1/DeltaTime),WIDTH-10,HEIGHT-10)
    frame = frame + 1
end

function generateWorld()
    local verts = {}
    local control = math.random(0,100)
    for x=WIDTH,0,-5 do
        verts[#verts+1] = vec2(x,noise(x/100,control)*100+100)
    end
    --verts[#verts+1] = vec2(0,verts[#verts].y)
    verts[#verts+1] = vec2(0,0)
    verts[#verts+1] = vec2(WIDTH,0)
    return verts
end

function touched(t)
    if not initPos and t.state==BEGAN then
        initPos = vec2(t.x,t.y)
        tId = t.id
    end
    touchesP[t.id] = t
end