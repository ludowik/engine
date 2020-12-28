--require 'physics.box2d'
require 'physics.fizix'

function newPhysics()
--    return Fizix()
    return box2dRef.Physics()
end
