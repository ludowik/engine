function release()
    app.scene = Scene()
end

function resume()
    setup()
end

function setup()
    supportedOrientations(LANDSCAPE_ANY)

    local index = 0

    local n = (debugging() and 20) or 50 -- 500

    local v = vec3()

    local w, h, d = 10, 10, 10

    local m = mesh()
    m.shader = Shader('default')

    for i=0,n-1 do
        v.x = i*w

        for j=0,n-1 do
            v.z = j*w

            m.vertices[index+1] = vec3( w/2, 0, -h/2):add(v)
            m.vertices[index+2] = vec3(-w/2, 0, -h/2):add(v)
            m.vertices[index+3] = vec3( w/2, 0,  h/2):add(v)

            m.vertices[index+4] = vec3( w/2, 0,  h/2):add(v)
            m.vertices[index+5] = vec3(-w/2, 0, -h/2):add(v)
            m.vertices[index+6] = vec3(-w/2, 0,  h/2):add(v)

            index = index + 6
        end
    end

    fill(white)

    app.scene.camera = Camera(50, 200, -50, 100, 0, 100)
    
    app.scene:add(MeshObject(m))

    index = 0
    for i=0,n-1 do
        x = i*w

        for j=0,n-1 do
            z = j*w

            m.vertices[index+1].y = noise(x+w, z  ) * w
            m.vertices[index+2].y = noise(x  , z  ) * w
            m.vertices[index+3].y = noise(x+w, z+w) * w
            m.vertices[index+4].y = noise(x+w, z+w) * w
            m.vertices[index+5].y = noise(x  , z  ) * w
            m.vertices[index+6].y = noise(x  , z+w) * w

            index = index + 6
        end
    end
    
    m.normals = Model.computeNormals(m.vertices)
    assert(m.normals)
end
