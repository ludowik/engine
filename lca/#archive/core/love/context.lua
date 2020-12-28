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

    love.graphics.setCanvas({
            context:getContext(),
            depthstencil = true,
            depth = true
        })

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

    love.graphics.reset()

    ortho(0, W_INFO + W, 0, H)
end
