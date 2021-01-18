App('Cube')

local tileSize = 5
local size = tileSize * 10

function Cube:init()
    Application.init(self)

    self:createTexture()
    
    self.box = Model.box()
    self.box.inst_pos = Buffer('vec3')
    self.box.inst_pos:resize(1024)

    camera(0, 0, 10)
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
                        fill(color.random(clr, 0.1))
                        rect(x, y, tileSize, tileSize)
                    end
                end
                popMatrix()
            end

            face(size*0, size, green)
            face(size*1, size, orange)
            face(size*2, size, blue)
            face(size*3, size, red)
            face(size*1, size*2, white)
            face(size*1, size*0, yellow)
        end,
        self.aaa)
end

function Cube:draw()
    background(51)

    perspective()
    
    self.box.inst_pos:reset()
    for x=1,100 do
        for z=1,100 do
            self.box.inst_pos:add(vec3(x,0,z))
        end
    end
    
    self.box.texture = self.aaa
    self.box:drawInstanced(#self.box.inst_pos)
    box(1, 1, 1, self.aaa)

    resetMatrix(true)
    spriteMode(CORNER)
    sprite(self.aaa, 0, 0)
end
