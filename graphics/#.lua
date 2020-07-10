require 'graphics.color'
require 'graphics.style'
require 'graphics.shader'
require 'graphics.meshRender'
require 'graphics.mesh'
require 'graphics.model'
require 'graphics.modelLoader'
require 'graphics.image'
require 'graphics.shape'
require 'graphics.context'
require 'graphics.graphics'
require 'graphics.material'
require 'graphics.drawing'
require 'graphics.render'
require 'graphics.geometry'
require 'graphics.camera'

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


--x,y,z,w	Useful for points, vectors, normals
--r,g,b,a	Useful for colors
--s,t,p,q	Useful for texture coordinates

