function unrefJoin(joint)
    physicsBox2d.joints[ffi.cast('b2Joint*', joint)] = nil
end

local b2Joint_index = {
    destroy = function (self)
        if physicsBox2d.joints[ffi.cast('b2Joint*', self)] then
            physicsBox2d.joints[ffi.cast('b2Joint*', self)] = nil
            box2d.b2Joint_gc(physicsBox2d, self)
        end
    end,
}

local b2Joint_mt = ffi.metatype('b2Joint', {
        __newindex = function (tbl, key, value)
            if key == 'maxMotorTorque' then
                box2d.b2Joint_set_maxMotorTorque(tbl, value)

            elseif key == 'enableMotor' then
                box2d.b2Joint_set_enableMotor(tbl, value)

            elseif key == 'motorSpeed' then
                box2d.b2Joint_set_motorSpeed(tbl, value)

            elseif key == 'enableLimit' then
                box2d.b2Joint_set_enableLimit(tbl, value)

            elseif key == 'lowerLimit' then
                box2d.b2Joint_set_lowerLimit(tbl, value * ptmRatio)

            elseif key == 'upperLimit' then
                box2d.b2Joint_set_upperLimit(tbl, value * ptmRatio)

            else
                assert()
                --rawset(tbl, key, value)
            end
        end,
        __index = function (tbl, key)
            if key == 'maxMotorTorque' then
                return box2d.b2Joint_get_maxMotorTorque(tbl)

            elseif key == 'enableMotor' then
                return box2d.b2Joint_get_enableMotor(tbl)

            elseif key == 'motorSpeed' then
                return box2d.b2Joint_get_motorSpeed(tbl)

            elseif key == 'enableLimit' then
                return box2d.b2Joint_get_enableLimit(tbl)

            elseif key == 'lowerLimit' then
                return box2d.b2Joint_get_lowerLimit(tbl) * mtpRatio

            elseif key == 'upperLimit' then
                return box2d.b2Joint_get_upperLimit(tbl) * mtpRatio

            elseif key == 'anchorA' then
                return box2d.b2Joint_get_anchorA(tbl)

            elseif key == 'anchorB' then
                return box2d.b2Joint_get_anchorB(tbl)

            else
                return rawget(b2Joint_index, key)
            end
        end
    })
