function suspend()
    app.scene = Scene()
end

function resume()
    setup()
end

function setup()
    supportedOrientations(LANDSCAPE_ANY)
    
    local m = mesh()

    local index = 0

    local n = 500
    
    local x, z, z = 0, 0, 0
    local w, h, d = 10, 10, 10
    
    for i=0,n-1 do
        x = i*w
        
        for j=0,n-1 do
            z = j*w

            m.vertices[index+1] = vector( w/2, 0, -h/2):add(x, 0, z)
            m.vertices[index+2] = vector(-w/2, 0, -h/2):add(x, 0, z)
            m.vertices[index+3] = vector( w/2, 0,  h/2):add(x, 0, z)
            
            m.vertices[index+4] = vector( w/2, 0,  h/2):add(x, 0, z)
            m.vertices[index+5] = vector(-w/2, 0, -h/2):add(x, 0, z)
            m.vertices[index+6] = vector(-w/2, 0,  h/2):add(x, 0, z)

            index = index + 6
        end        
    end

    fill(white)

    app.scene.camera = camera(50, 200, -50, 100, 0, 100)
    app.scene:add(MeshObject(m))
    
    index = 0
    for i=0,n-1 do
        x = i*w
        
        for j=0,n-1 do
            z = j*w

            m.vertices[index+1].y = noise(x, z) * w
            m.vertices[index+2].y = noise(x, z) * w
            m.vertices[index+3].y = noise(x, z) * w
            m.vertices[index+4].y = noise(x, z) * w
            m.vertices[index+5].y = noise(x, z) * w
            m.vertices[index+6].y = noise(x, z) * w

            index = index + 6
        end        
    end
end

