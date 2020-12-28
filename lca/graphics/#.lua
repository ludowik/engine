requireLib(
    'color',
    'context',
    'opengl',
    'model',
    'modelLoader',
    'shape',
    'geometry',
    'graphics',
    'style',
    'font',
    'graphics3d',
    'mesh',
    'drawing',
    'render',
    'light',
    'material',
    'transformation')

local N = 12
function ws(i, n)
    n = n or N
    return W / N * (i or 1)
end

function hs(i, n)
    n = n  or N
    return H / N * (i or 1)
end

function size(i, j)
    return vec2(ws(i), hs(j))
end
