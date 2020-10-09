Test2 = class()

function Test2:name()
    return "3D Blocks"
end

function Test2:init()
    -- all the unique vertices that make up a cube
    local vertices = {
      vec3(-0.5, -0.5,  0.5), -- Left  bottom front
      vec3( 0.5, -0.5,  0.5), -- Right bottom front
      vec3( 0.5,  0.5,  0.5), -- Right top    front
      vec3(-0.5,  0.5,  0.5), -- Left  top    front
      vec3(-0.5, -0.5, -0.5), -- Left  bottom back
      vec3( 0.5, -0.5, -0.5), -- Right bottom back
      vec3( 0.5,  0.5, -0.5), -- Right top    back
      vec3(-0.5,  0.5, -0.5), -- Left  top    back
    }

    -- now construct a cube out of the vertices above
    local cubeverts = {
      -- Front
      vertices[1], vertices[2], vertices[3],
      vertices[1], vertices[3], vertices[4],
      -- Right
      vertices[2], vertices[6], vertices[7],
      vertices[2], vertices[7], vertices[3],
      -- Back
      vertices[6], vertices[5], vertices[8],
      vertices[6], vertices[8], vertices[7],
      -- Left
      vertices[5], vertices[1], vertices[4],
      vertices[5], vertices[4], vertices[8],
      -- Top
      vertices[4], vertices[3], vertices[7],
      vertices[4], vertices[7], vertices[8],
      -- Bottom
      vertices[5], vertices[6], vertices[2],
      vertices[5], vertices[2], vertices[1],
    }

    -- all the unique texture positions needed
    local texvertices = { vec2(0.03,0.24),
                          vec2(0.97,0.24),
                          vec2(0.03,0.69),
                          vec2(0.97,0.69) }

    -- apply the texture coordinates to each triangle
    local cubetexCoords = {
      -- Front
      texvertices[1], texvertices[2], texvertices[4],
      texvertices[1], texvertices[4], texvertices[3],
      -- Right
      texvertices[1], texvertices[2], texvertices[4],
      texvertices[1], texvertices[4], texvertices[3],
      -- Back
      texvertices[1], texvertices[2], texvertices[4],
      texvertices[1], texvertices[4], texvertices[3],
      -- Left
      texvertices[1], texvertices[2], texvertices[4],
      texvertices[1], texvertices[4], texvertices[3],
      -- Top
      texvertices[1], texvertices[2], texvertices[4],
      texvertices[1], texvertices[4], texvertices[3],
      -- Bottom
      texvertices[1], texvertices[2], texvertices[4],
      texvertices[1], texvertices[4], texvertices[3],
    }

    -- now we make our 3 different block types
    self.ms = mesh()
    self.ms.vertices = cubeverts
    self.ms.texture = "Planet Cute:Stone Block"
    self.ms.texCoords = cubetexCoords
    self.ms:setColors(255,255,255,255)

    self.md = mesh()
    self.md.vertices = cubeverts
    self.md.texture = "Planet Cute:Dirt Block"
    self.md.texCoords = cubetexCoords
    self.md:setColors(255,255,255,255)

    self.mg = mesh()
    self.mg.vertices = cubeverts
    self.mg.texture = "Planet Cute:Grass Block"
    self.mg.texCoords = cubetexCoords
    self.mg:setColors(255,255,255,255)

    -- currently doesnt work properly without backfaces
    self.mw = mesh()
    self.mw.vertices = cubeverts
    self.mw.texture = "Planet Cute:Water Block"
    self.mw.texCoords = cubetexCoords
    self.mw:setColors(255,255,255,100)

    -- stick 'em in a table
    self.blocks = { self.mg, self.md, self.ms }

    -- our scene itself
    -- numbers correspond to block positions in the blockTypes table
    --             bottom      middle      top
    self.scene = {   { {3, 3, 0}, {2, 0, 0}, {0, 0, 0} },
                     { {3, 3, 3}, {2, 2, 0}, {1, 0, 0} },
                     { {3, 3, 3}, {2, 2, 2}, {1, 1, 0} } }
end

function Test2:draw()
    pushMatrix()
    pushStyle()

    -- Make a floor
    translate(0,-lSize/2,0)
    rotate(Angle,0,1,0)
    rotate(90,1,0,0)
    sprite("SpaceCute:Background", 0, 0, 300, 300)

    -- render each block in turn
    for zi,zv in ipairs(self.scene) do
        for yi,yv in ipairs(zv) do
            for xi, xv in ipairs(yv) do
                -- apply each transform  need - rotate, scale, translate to the correct place
                resetMatrix()
                rotate(Angle,0,1,0)

                local s = lSize*0.25
                scale(s,s,s)

                translate(xi-2, yi-2, zi-2)    -- renders based on corner
                                               -- so -2 fudges it near center

                if xv > 0 then
                    self.blocks[xv]:draw()
                end
            end
        end
    end

    popStyle()
    popMatrix()
end

function Test2:touched(touch)
    -- Codea does not automatically call this method
end