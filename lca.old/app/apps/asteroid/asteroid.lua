class('Asteroid', MeshObject)

function Asteroid:init(asteroid, part)
    MeshObject.init(self)

    if asteroid then
        self.radius = asteroid.radius / 2
    else
        self.radius = random(app.objectSize, app.objectSize*2)
    end

    local n = randomInt(5, 7)

    self.mesh = mesh()

    local vertices = {}
    for i=1,n do
        local len = random(self.radius/2, self.radius)
        vertices[i] = vec3(
            len * cos(2*pi*i/n),
            len * sin(2*pi*i/n))
    end
    
    self.mesh.vertices = vertices
    self.vertices = vertices

    self:addToPhysics(DYNAMIC)

    if asteroid then
        self.body.position = asteroid.body.position
        local dir = asteroid.body.linearVelocity:normalize() * self.radius
        if part == 1 then 
            self.body.linearVelocity = dir *2
            self.body.position = self.body.position + dir
        else
            self.body.linearVelocity = -dir*2
            self.body.position = self.body.position - dir
        end

    else
        self.body.position = vector(random(WIDTH), random(HEIGHT))
        self.body.linearVelocity = vec2.random(50)
    end

    self.body.linearDamping = 0

    self.body.angularVelocity = deg( random(-pi, pi))

    self.keepInArea = true
end

function Asteroid:draw()
    stroke(white)

    noFill()
    strokeWidth(5)
    
    lineCapMode(ROUND)
    
    rotate(self.body.angle)

    polygon(self.vertices)
end
