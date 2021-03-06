class('Context')

function Context.setup()
    Context.currentContext = nil
end

function setContext(context)
    if context then
        Context.setContext(context)
    else
        Context.resetContext()
    end
end

function Context.setContext(context)
    if context == nil then return end

    if context == Context.currentContext then return end

    local renderFrame = RenderFrame.getRenderFrame()

    if context ~= renderFrame then
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

        background(transparent)

    else
        renderer:bind(context.framebufferName)
    end

    Context.viewport(0, 0, context.width, context.height)

    ortho(0, context.width, 0, context.height)
end

function Context.closeCurrentContext()
    local renderFrame = RenderFrame.getRenderFrame()
    if Context.currentContext and Context.currentContext ~= renderFrame then
        Context.currentContext:readPixels()
    end
    Context.currentContext = nil
end

function Context.resetContext()
    local renderFrame = RenderFrame.getRenderFrame()
    if renderFrame then
        Context.setContext(renderFrame)
    else
        Context.noContext()
    end
end

function Context.noContext(id)
    Context.closeCurrentContext()

    renderer:defaultContext()

    Context.viewport(0, 0, screen.w, screen.h, config.highDPI)

    ortho(0, screen.w, 0, screen.h)
end

function Context.viewport(x, y, w, h, highDPI)
    if highDPI and ( osx or ios ) then
        renderer:viewport(x, y, w*2, h*2)
    else
        renderer:viewport(x, y, w, h)
    end
end
