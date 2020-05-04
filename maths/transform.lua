function resetMatrix()
    transform:reset()
end

function translate(x, y, z)
    transform:translate(x, y)
end

class 'Transform'

function Transform:reset()
end

function Transform:translate(x, y, z)
end

transform = Transform()
