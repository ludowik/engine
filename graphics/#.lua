require 'graphics.color'
require 'graphics.style'
require 'graphics.shader'
require 'graphics.mesh'
require 'graphics.model'
require 'graphics.image'
require 'graphics.shape'
require 'graphics.context'
require 'graphics.graphics'
require 'graphics.drawing'

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
