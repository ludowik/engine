function MeshAxes(...)
    local cylinder = Model.cylinder(1, 1, 10000):center()

    MeshAxes = function (x, y, z)
        x, y, z = xyz(x, y, z)

        pushMatrix()
        do
            translate(x, y, z)
            
            scale(0.01, 0.01, 0.01)
            
            rotate(90, 0, 1, 0)
            cylinder:setColors(red)
            cylinder:draw()
            
            rotate(-90, 1, 0, 0)
            cylinder:setColors(green)
            cylinder:draw()

            rotate(90, 0, 1, 0)
            cylinder:setColors(blue)
            cylinder:draw()
        end
        popMatrix()
    end
    MeshAxes(...)
end
