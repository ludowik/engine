function system.clip(...)
    if gl == nil then return end
    local deferredDraw
    clip = function(x, y, w, h)
        if x then
            gl.glEnable(gl.GL_SCISSOR_TEST)
            gl.glScissor(x, y, w, h)        

            deferredDraw = config.deferredDraw
            config.deferredDraw = false
        else
            gl.glDisable(gl.GL_SCISSOR_TEST)

            if deferredDraw ~= nil then
                config.deferredDraw = deferredDraw
            end
        end
    end
    return clip(...)
end

function system.noClip()
    system.clip()
end
