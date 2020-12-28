graphics = graphics or class('graphics')

function graphics.background(...)
    local clr = Color.from(...)

    gl.glClearColor(clr.r, clr.g, clr.b, clr.a)
    gl.glClearDepth(1)

    gl.glClear(
        gl.GL_COLOR_BUFFER_BIT +
        gl.GL_DEPTH_BUFFER_BIT)
end

local currentBlendMode
function graphics.blendMode(mode)
    if mode then
        if currentBlendMode ~= mode then
            currentBlendMode = mode
            graphics.style.blendMode = mode

            if mode == NORMAL then
                gl.glEnable(gl.GL_BLEND)
                gl.glBlendEquation(gl.GL_FUNC_ADD)
--                gl.glBlendFunc(gl.GL_SRC_ALPHA, gl.GL_ONE_MINUS_SRC_ALPHA)
                gl.glBlendFuncSeparate(
                    gl.GL_SRC_ALPHA, gl.GL_ONE_MINUS_SRC_ALPHA, 
                    gl.GL_ONE, gl.GL_ONE_MINUS_SRC_ALPHA)

            elseif mode == ADDITIVE then
                gl.glEnable(gl.GL_BLEND)
                gl.glBlendEquation(gl.GL_FUNC_ADD)
                gl.glBlendFunc(gl.GL_ONE, gl.GL_ONE)

            elseif mode == MULTIPLY then
                gl.glEnable(gl.GL_BLEND)
                gl.glBlendEquation(gl.GL_FUNC_ADD)
                gl.glBlendFuncSeparate(
                    gl.GL_DST_COLOR, gl.GL_ZERO,
                    gl.GL_DST_ALPHA, gl.GL_ZERO)

            else
                assert(false, mode)
            end
        end
    end
    return graphics.style.blendMode
end

local currentCullingMode
function graphics.cullingMode(mode)
    if mode ~= nil then
        if currentCullingMode ~= mode then
            currentCullingMode = mode
            graphics.style.cullingMode = mode

            -- Activation du Culling
            if mode == 'none' then
                gl.glDisable(gl.GL_CULL_FACE)

            else
                gl.glEnable(gl.GL_CULL_FACE)

                gl.glFrontFace(gl.GL_CCW)
                if mode == 'back' then
                    gl.glCullFace(gl.GL_BACK)
                else
                    gl.glCullFace(gl.GL_FRONT)
                end
            end
        end
    end
    return graphics.style.cullingMode
end

local currentDepthMode
function graphics.depthMode(mode)
    if mode ~= nil then
        if currentDepthMode ~= mode then
            currentDepthMode = mode
            graphics.style.depthMode = mode

            if mode == true then
                gl.glEnable(gl.GL_DEPTH_TEST)
                gl.glDepthFunc(gl.GL_LEQUAL)
            else
                gl.glDisable(gl.GL_DEPTH_TEST)
            end
        end
    end
    return graphics.style.depthMode
end

function graphics.points(...)
    local points = {...}

    local strokeWidth = strokeWidth()

    for i=1,#points,2 do
        circle(
            points[i], points[i+1],
            strokeWidth,
            CENTER)
    end
end

function graphics.clip(...)
    if x then
        gl.glEnable(gl.GL_SCISSOR_TEST)
        gl.glScissor(x, y, w, h)        
    else
        gl.glDisable(gl.GL_SCISSOR_TEST)
    end
end

function graphics.noClip()
    graphics.clip()
end
