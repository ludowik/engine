class 'RenderFrame'

function RenderFrame.getRenderFrame()
    engine.renderFrame = RenderFrame.aRenderFrame(engine.renderFrame)
    engine.renderFrameInfo = RenderFrame.aRenderFrame(engine.renderFrameInfo)

    return engine.renderFrame
end

function RenderFrame.aRenderFrame(renderFrame)
    if renderFrame == nil then
        renderFrame = Image(screen.W, screen.H)

    elseif renderFrame.width ~= screen.W then
        renderFrame:release()
        renderFrame:create(screen.W, screen.H)
    end

    return renderFrame
end

function RenderFrame.release()
    if engine.renderFrame then
        engine.renderFrame:release()
        engine.renderFrame = nil
    end
    
    if engine.renderFrameInfo then
        engine.renderFrameInfo:release()
        engine.renderFrameInfo = nil
    end
end
