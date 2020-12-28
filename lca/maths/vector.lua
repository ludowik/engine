function xyz(x, y, z)
    if typeof(x) == 'vec3'  then
        return x.x, x.y, x.z
    end
    return x, y, z
end

function vertices2vectors(vertices)
    local vectors = {}
    local typeof = typeof(vertices[1])
    if typeof == 'number' then
        vectors = {}
        for i=1,#vertices,2 do
            table.insert(vectors, vec2(vertices[i], vertices[i+1]))
        end

    elseif typeof == 'vec2' or typeof == 'vec3' then
        vectors = vertices
    end

    return vectors
end

function vectors2vertices(vectors)
    local vertices
    local typeof = typeof(vectors[1])
    if typeof == 'number' then
        vertices = vectors

    elseif typeof == 'vec2' or typeof == 'vec3' then
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
