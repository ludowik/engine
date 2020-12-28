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
    assert(typeof(context) == 'image')

    if Context.currentContext == context then return end
    if meshManager then meshManager:flush() end    

    if context ~= renderFrame then
        pushMatrix(true)
        resetMatrix(true)
    elseif Context.currentContext then
        popMatrix(true)
    end

    Context.currentContext = context

    if context.framebufferName == nil then
        context.framebufferName = image.createFramebuffer()
        context.depthrenderbuffer = image.attachRenderbuffer(context.width, context.height)

        image.attachTexture2D(context.ids.tex)

        if gl.glCheckFramebufferStatus(gl.GL_FRAMEBUFFER) ~= gl.GL_FRAMEBUFFER_COMPLETE then
            assert(false)
        end

        background(transparent)
    end

    gl.glBindFramebuffer(gl.GL_FRAMEBUFFER, context.framebufferName)
    Context.viewport(0, 0, context.width, context.height)

    ortho(0, context.width, 0, context.height)
end

function Context.resetContext()
    if renderFrame then
        Context.setContext(renderFrame)
    else
        Context.noContext()
    end
end

function Context.noContext()
    Context.currentContext = nil

    gl.glBindFramebuffer(gl.GL_FRAMEBUFFER, 0)
    Context.viewport(0, 0, W_INFO + W, H, config.highDPI)

    ortho(0, W_INFO + W, 0, H)
end

function Context.viewport(x, y, w, h, highDPI)
    if highDPI and osx then
        gl.glViewport(x, y, w*2, h*2)
    else
        gl.glViewport(x, y, w, h)
    end
end
