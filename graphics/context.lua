function setContext(context)
    if context then
        Context.setContext(context)
    else
        Context.resetContext()
    end
end

class('Context')

function Context.setup()
    Context.currentContext = nil
end

function Context.setContext(context)
    if context == nil then return end

    if Context.currentContext == context then return end

    if context ~= engine.renderFrame then
        pushMatrix(true)
        resetMatrix(true)

    elseif Context.currentContext then
        popMatrix(true)
    end

    Context.closeCurrentContext()

    Context.currentContext = context

    if context.framebufferName == nil then
        context:createFramebuffer()

--        context:createColorBuffer(context.width, context.height)
        context:createDepthBuffer(context.width, context.height)

        context:attachTexture2D(context.texture_id)

        if gl.glCheckFramebufferStatus(gl.GL_FRAMEBUFFER) ~= gl.GL_FRAMEBUFFER_COMPLETE then
            assert(false)
        end

        background(transparent)
        
    else
        gl.glBindFramebuffer(gl.GL_FRAMEBUFFER, context.framebufferName)
    end

    Context.viewport(0, 0, context.width, context.height)

    ortho(0, context.width, 0, context.height)
end

function Context.closeCurrentContext()
    if Context.currentContext and Context.currentContext ~= engine.renderFrame then
        Context.currentContext:readPixels()
    end
    Context.currentContext = nil
end

function Context.resetContext()
    if engine.renderFrame then
        Context.setContext(engine.renderFrame)
    else
        Context.noContext()
    end
end

function Context.noContext(id)
    Context.closeCurrentContext()

    gl.glBindFramebuffer(gl.GL_FRAMEBUFFER, engine.defaultFrameBuffer or 0)
    gl.glBindRenderbuffer(gl.GL_RENDERBUFFER, engine.defaultRenderBuffer or 0)

    Context.viewport(0, 0, screen.w, screen.h, config.highDPI)

    ortho(0, screen.w, 0, screen.h)
end

function Context.viewport(x, y, w, h, highDPI)
    if highDPI and ( osx or ios ) then
        gl.glViewport(x, y, w*2, h*2)
    else
        gl.glViewport(x, y, w, h)
    end
end
