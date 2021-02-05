App('Cube')

local tileSize = 5
local size = tileSize * 10

local chunkSize = 256

function Cube:init()
    Application.init(self)

    self:createTexture()

    self.chunks = Array()

    local n = 3
    for x=-n,n do
        for y=-n,n do
            local chunk = Model.box()
            chunk.inst_pos = Buffer('vec3')
            chunk.inst_pos:resize(1024^2)    
            chunk.needUpdate = true
            chunk.position = vec3(x*chunkSize, 0, y*chunkSize)
            self.chunks:add(chunk)
        end
    end

    camera(0, 1.7, 0, 0, 0, 30)
end

function Cube:createTexture()
    self.aaa = image(size*4, size*3)

    renderFunction(function ()
            noStroke()
            rectMode(CORNER)

            local function face(x, y, clr)
                pushMatrix()
                translate(x, y)
                seed(x)

                for x=0,size-tileSize,tileSize do
                    for y=0,size-tileSize,tileSize do
                        fill(color.random(clr))
                        rect(x, y, tileSize, tileSize)
                    end
                end
                popMatrix()
            end

            face(size*0, size, brown)
            face(size*1, size, brown)
            face(size*2, size, brown)
            face(size*3, size, brown)
            face(size*1, size*2, rgb(58, 157, 35))
            face(size*1, size*0, brown)
        end,
        self.aaa)
end

function Cube:update(dt)
    local position
    for i,chunk in ipairs(self.chunks) do
        if chunk.needUpdate == true then
            position = chunk.position

            chunk.needUpdate = false
            chunk.inst_pos:reset()
            
            chunk.inst_pos.idBuffer = gl.glGenBuffer()
            
            for x=0,chunkSize-1 do
                for z=0,chunkSize-1 do
                    chunk.inst_pos:add(vec3(
                            position.x+x,
                            0,
                            position.z+z))
                end
            end
        end
    end
end

function Cube:draw()
    background(51)

    perspective()

    for i,chunk in ipairs(self.chunks) do
        chunk.texture = self.aaa
        chunk:drawInstanced(#chunk.inst_pos)
    end

--    resetMatrix(true)
--    spriteMode(CORNER)
--    sprite(self.aaa, 0, 0)
end
