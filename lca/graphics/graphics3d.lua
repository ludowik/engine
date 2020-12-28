class('graphics3d')

graphics3d.debugSetup = false

function graphics3d.setup()
    meshPlane = Model.plane()
    meshBox = Model.box()
    meshSphere = Model.sphere()
    meshPyramid = Model.pyramid()
    meshCylinder = Model.cylinder(1, 1, 10000):center()
end

local function drawModel(mesh, w, h, e, texture)
    w = w or 1
    h = h or w
    e = e or w

    pushMatrix()
    do
        scale(w, h, e)

        light(true)

        mesh.texture = texture
        mesh.shader = mesh.shader or Shader.shaders['mesh']
        mesh:draw()
    end
    popMatrix()
end

function plane(w, h, e, texture)
    drawModel(meshPlane, w, h, e, texture)
end

function box(w, h, e, texture)
    drawModel(meshBox, w, h, e, texture)
end

function sphere(w, h, e, texture)
    drawModel(meshSphere, w, h, e, texture)
end

function pyramid(w, h, e, texture)
    drawModel(meshPyramid, w, h, e, texture)
end

function MeshAxes(x, y, z)
    x, y, z = xyz(x, y, z)

    pushMatrix()
    do
        translate(x, y, z)

        scale(0.01, 0.01, 0.01)

        rotate(90, 0, 1, 0)
        meshCylinder:setColors(red)
        meshCylinder:draw()

        rotate(-90, 1, 0, 0)
        meshCylinder:setColors(green)
        meshCylinder:draw()

        rotate(90, 0, 1, 0)
        meshCylinder:setColors(blue)
        meshCylinder:draw()
    end
    popMatrix()
end

