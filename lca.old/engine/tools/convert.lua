function xyz(x, y, z)
    if typeOf(x) == 'vector'  then
        return x.x, x.y, x.z
    end
    return x, y, z
end

function vectors2vertices(vectors)
    local vertices
    local typeOf = typeOf(vectors[1])
    if typeOf == 'number' then
        vertices = vectors

    elseif typeOf == 'vector' or typeOf == 'vector2' or typeOf == 'vector3' then
        vertices = {}
        for i,v in ipairs(vectors) do
            table.insert(vertices, v.x)
            table.insert(vertices, v.y)
        end
    end

    return vertices
end

function vectors2triangles(vectors)
    local triangles = Array()
    for i=1,#vectors,3 do
        local triangle = Array()
        triangle:add(vectors[i+0].x)
        triangle:add(vectors[i+0].y)
        triangle:add(vectors[i+1].x)
        triangle:add(vectors[i+1].y)
        triangle:add(vectors[i+2].x)
        triangle:add(vectors[i+2].y)

        triangles:add(triangle)
    end
    return triangles
end

function vertices2vectors(vertices)
    local vectors = {}
    for i=1,#vectices,2 do
        table.insert(vectors, vector(vertices[i], vertices[i+1]))
    end
    return vectors
end
