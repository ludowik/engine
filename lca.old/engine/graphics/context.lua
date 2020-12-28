local currentContext, previousContext

function setContext(ctx)
    if meshManager then
        meshManager:flush()
    end
    
    previousContext = currentContext

    if ctx then
        currentContext = ctx
        assert(typeOf(ctx) == 'image')
        if typeOf(ctx) == 'image' then
            ctx = ctx:getContext()
        end
        graphics.setCanvas(ctx)
                
        ortho()
    else
        currentContext = nil
        graphics.setCanvas(engine.ctx)
        
        ortho()
    end

    graphics.setBlendMode('alpha')

    if typeOf(previousContext) == 'image' then
        previousContext:resetContext()
    end
end
