graphics = graphics or class('graphics')

function graphics.background(clr, ...)
    if clr then
        graphics.style.backgroundColor:set(clr, ...)
    end
    love.graphics.clear(graphics.style.backgroundColor:unpack())
end

function graphics.blendMode(mode)
    if mode then 
        graphics.style.blendMode = mode

        if mode == NORMAL then
            love.graphics.setBlendMode('alpha')

        elseif mode == ADDITIVE then
            love.graphics.setBlendMode('add')

        elseif mode == MULTIPLY then
            love.graphics.setBlendMode('multiply', 'premultiplied')

        else
            assert()
        end
    end
    return graphics.style.blendMode
end

function graphics.cullingMode(mode)
    if mode ~= nil then
        graphics.style.cullingMode = mode

        -- Activation du Culling
        if mode == 'none' then
            love.graphics.setMeshCullMode('none')
        else
            --love.graphics.setFrontFaceWinding('cw') -- CCW but rendering to flip canvas
            love.graphics.setMeshCullMode(mode)
        end
    end
    return graphics.style.cullingMode
end

function graphics.depthMode(mode)
    if mode ~= nil then
        graphics.style.depthMode = mode

        -- Activation du Depth Buffer
        if mode == true then
            love.graphics.setDepthMode('lequal', true)
        else
            love.graphics.setDepthMode()
        end
    end
    return graphics.style.depthMode
end
