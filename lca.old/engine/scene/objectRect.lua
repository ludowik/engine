class('RectObject', Object)

function RectObject:init(...)
    Object.init(self, ...)
end

function RectObject:addToPhysics(bodyType)
    currentEnv.physics:addItem(self, bodyType or DYNAMIC, 'rect')
end
