App('Cube')

local tileSize = 5
local size = tileSize * 10

function Cube:init()
    Application.init(self)

    self:myTexture2()

    camera(0, 0, 10)
end

function Cube:myTexture2()
    self.aaa = image(size*4, size*3)

    render(self.aaa, function ()
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
        end)
end

function Cube:draw()
    background(51)

    spriteMode(CORNER)
    sprite(self.aaa, 0, 0)

    perspective()
    camera(2, 3, 10)

    box(1, 1, 1, self.aaa)
end
