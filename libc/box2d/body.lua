local b2Body_index = {
    destroy = function (self)
        box2d.b2Body_gc(physics, self)
    end,

    applyForce = function (self, force, worldPoint)
        if worldPoint then
            box2d.b2Body_applyForce(self,
                b2Vec2(force.x, force.y, ptmRatio),
                b2Vec2(worldPoint.x, worldPoint.y, ptmRatio))
        else
            box2d.b2Body_applyForceToCenter(self,
                b2Vec2(force.x, force.y, ptmRatio))
        end
    end,

    applyLinearImpulse = function (self, impulse)
        box2d.b2Body_applyLinearImpulse(self,
            b2Vec2(impulse.x, impulse.y, ptmRatio))
    end,

    applyTorque = function (self, torque)
        box2d.b2Body_applyTorque(self, torque)
    end,

    applyAngularImpulse = function (self, impulse)
        box2d.b2Body_applyAngularImpulse(self, impulse)
    end,

    testPoint = function (self, worldPoint)
        return box2d.b2Body_testPoint(self,
            b2Vec2(worldPoint.x, worldPoint.y, ptmRatio))
    end,

    testOverlap = function (self, otherBody)
        return box2d.b2Body_testOverlap(self, otherBody)
    end,

    getLocalPoint = function (self, worldPoint)
        local localPoint = box2d.b2Body_getLocalPoint(self,
            b2Vec2(
                worldPoint.x,
                worldPoint.y,
                ptmRatio))
        return vec3(localPoint):mul(mtpRatio)
    end,

    getWorldPoint = function (self, localPoint)
        local worldPoint = box2d.b2Body_getWorldPoint(self,
            b2Vec2(
                localPoint.x,
                localPoint.y,
                ptmRatio))
        return vec3(worldPoint):mul(mtpRatio)
    end,

    getLinearVelocityFromWorldPoint = function (self, worldPoint)
        local velocity = box2d.b2Body_getLinearVelocityFromWorldPoint(self,
            b2Vec2(
                worldPoint.x,
                worldPoint.y,
                ptmRatio))
        return vec3(velocity.x, velocity.y):mul(mtpRatio)
    end,
}

local b2Body_mt = ffi.metatype('b2Body', {
        __newindex = function (tbl, key, value)
            if key == 'type' then
                box2d.b2Body_set_type(tbl, e_bodiesType[value])

            elseif key == 'bullet' then
                box2d.b2Body_set_bullet(tbl, value)

            elseif key == 'position' then
                box2d.b2Body_set_position(tbl, b2Vec2(value.x, value.y, ptmRatio))

            elseif key == 'sensor' then
                box2d.b2Body_set_sensor(tbl, value)

            elseif key == 'x' then
                local position = box2d.b2Body_get_position(tbl)
                box2d.b2Body_set_position(tbl, b2Vec2(value * ptmRatio, position.y))

            elseif key == 'y' then
                local position = box2d.b2Body_get_position(tbl)
                box2d.b2Body_set_position(tbl, b2Vec2(position.x, value * ptmRatio))

            elseif key == 'angle' then
                box2d.b2Body_set_angle(tbl, rad(value))

            elseif key == 'radius' then
                box2d.b2Body_set_radius(tbl, value * ptmRatio)

            elseif key == 'mass' then
                box2d.b2Body_set_mass(tbl, value)

            elseif key == 'density' then
                box2d.b2Body_set_density(tbl, value)

            elseif key == 'gravityScale' then
                box2d.b2Body_set_gravityScale(tbl, value)

            elseif key == 'friction' then
                box2d.b2Body_set_friction(tbl, value)

            elseif key == 'fixedRotation' then
                box2d.b2Body_set_fixedRotation(tbl, value)

            elseif key == 'restitution' then
                box2d.b2Body_set_restitution(tbl, value)

            elseif key == "linearVelocity" then
                box2d.b2Body_set_linearVelocity(tbl, b2Vec2(value.x, value.y, ptmRatio))

            elseif key == "angularVelocity" then
                box2d.b2Body_set_angularVelocity(tbl, rad(value))

            elseif key == "linearDamping" then
                box2d.b2Body_set_linearDamping(tbl, value)

            elseif key == "angularDamping" then
                box2d.b2Body_set_angularDamping(tbl, value)

            elseif key == 'interpolate' then
                 b2World.b2Body_set_interpolate(value)

            elseif key == 'sleepingAllowed' then
                box2d.b2Body_set_sleepingAllowed(tbl, value)

            elseif key == 'categories' then
                local categoryBits = 0
                for i,category in ipairs(value) do
                    categoryBits = categoryBits + 2^category
                end
                box2d.b2Body_set_categoryBits(tbl, categoryBits)

            elseif key == 'mask' then
                local maskBits = 0
                for i,mask in ipairs(value) do
                    maskBits = maskBits + 2^mask
                end
                box2d.b2Body_set_maskBits(tbl, maskBits)

            else
                box2d.userdata[box2d.b2Body_getId(tbl)][key] = value
--                rawset(tbl, key, value)
            end
        end,

        __index = function (tbl, key)
            if key == 'type' then
                return e_bodiesType[box2d.b2Body_get_type(tbl)]

            elseif key == 'bullet' then
                return box2d.b2Body_get_bullet(tbl)

            elseif key == 'shapeType' then
                return e_shapesType[box2d.b2Body_get_shape_type(tbl)]

            elseif key == 'position' then
                local position = box2d.b2Body_get_position(tbl)
                return vec3(position.x, position.y):mul(mtpRatio)

            elseif key == 'sensor' then
                return box2d.b2Body_get_sensor(tbl)

            elseif key == 'x' then
                local position = box2d.b2Body_get_position(tbl)
                return position.x * mtpRatio

            elseif key == 'y' then
                local position = box2d.b2Body_get_position(tbl)
                return position.y * mtpRatio

            elseif key == 'angle' then
                return deg(box2d.b2Body_get_angle(tbl))

            elseif key == 'radius' then
                return box2d.b2Body_get_radius(tbl) * mtpRatio

            elseif key == 'mass' then
                return box2d.b2Body_get_mass(tbl)

            elseif key == 'density' then
                return box2d.b2Body_get_density(tbl)

            elseif key == 'gravityScale' then
                return box2d.b2Body_get_gravityScale(tbl)

            elseif key == 'friction' then
                return box2d.b2Body_get_friction(tbl)

            elseif key == 'fixedRotation' then
                return box2d.b2Body_get_fixedRotation(tbl)

            elseif key == 'restitution' then
                return box2d.b2Body_get_restitution(tbl)

            elseif key == "linearVelocity" then
                local vel = box2d.b2Body_get_linearVelocity(tbl)
                return vec3(vel.x, vel.y):mul(mtpRatio)

            elseif key == "angularVelocity" then
                return deg(box2d.b2Body_get_angularVelocity(tbl))

            elseif key == "linearDamping" then
                return box2d.b2Body_get_linearDamping(tbl)

            elseif key == "angularDamping" then
                return box2d.b2Body_get_angularDamping(tbl)

            elseif key == 'interpolate' then
                --				return b2World.b2Body_get_interpolate()

            elseif key == 'sleepingAllowed' then
                return box2d.b2Body_get_sleepingAllowed()

            elseif key == 'points' then
                local vertices = {}
                local nf = box2d.b2Body_get_fixture_count(tbl)
                for j=1,nf do
                    local nv = box2d.b2Body_get_vertex_count(tbl, j-1)
                    for i=1,nv do
                        local vertex = box2d.b2Body_get_vertex(tbl, j-1, i-1)
                        vertices[#vertices+1] = vec3(
                            vertex.x,
                            vertex.y):mul(mtpRatio)
                    end
                end
                return vertices

            elseif key == 'categories' then
                local categoryBits = box2d.b2Body_get_categoryBits(tbl)
                local categories = {}
                for i=0,15 do
                    if bitAND(categoryBits, 2^i) then
                        table.add(categories, i)
                    end
                end
                return categories

            elseif key == 'mask' then
                local maskBits = box2d.b2Body_get_maskBits(tbl)
                local mask = {}
                for i=0,15 do
                    if bitAND(maskBits, 2^i) then
                        table.add(mask, i)
                    end
                end
                return mask

            else
                local result = rawget(b2Body_index, key)
                if result == nil then
                    result = box2d.userdata[box2d.b2Body_getId(tbl)][key]
                end
                return result
            end
        end
    })
