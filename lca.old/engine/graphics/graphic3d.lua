class('graphics3d')

function graphics3d.setup()
    meshPlane = Model.plane()
    
    meshBox = Model.box()
    
    meshBoxBorder = Model.box2()
    meshBoxBorder.drawBorder = 1
    
    meshSphere = Model.sphere()
    meshSphere.drawBorder = 2
    meshSphere.shader = shaders['terrain']
    
    meshPyramid = Model.pyramid()
end

local function drawModel(mesh, w, h, e, texture)
    pushMatrix()
    do
        scale(w, h, e)
        
        if texture and mesh.texture ~= texture then
            mesh.texture = texture
            mesh.needUpdate = true
        end
        
        mesh:draw()
    end
    popMatrix()
end

function plane(w, h, e, texture)
    drawModel(meshPlane, w, h, e, texture)
end

function box(w, h, e, texture)
    drawModel(meshBox, w, h, e, texture)    
    drawModel(meshBoxBorder, w, h, e)
end

function sphere(w, h, e, texture)
    drawModel(meshSphere, w, h, e, texture)
end

function pyramid(w, h, e, texture)
    drawModel(meshPyramid, w, h, e, texture)
end
