class 'Love2dSDL' : extends(MediaInterface)

function Love2dSDL.setup()
    love.keypressed = function(key, scancode, isrepeat)
        engine:keydown(key, isrepeat)
    end

    love.keyreleased = function(key, scancode)
        engine:keyup(key)
    end
end

function Love2dSDL:setWindowTitle(title)
    love.window.setTitle(title)
end

function Love2dSDL:setWindowSize(screen)
    love.window.setMode(screen.w, screen.h)
end

--function Love2dSDL:setCursor(cursor)
--end

function Love2dSDL:event()
    if engine.active == 'stop' then
        love.event.quit()
    end
end

function Love2dSDL:isDown(key)
    return love.keyboard.isDown(key)
end

function Love2dSDL:isButtonDown(button)
    return love.mouse.isDown(button)
end

function Love2dSDL:getTicks()
    return love.timer.getTime() * 1000
end

function Love2dSDL:loadImage(path)
end


MeshRender = class 'RendererInterface.Love2d' : extends(RendererInterface)
Love2dRenderer = MeshRender 

function Love2dRenderer.glGenBuffer()
    return -1
end

function Love2dRenderer:render(shader, drawMode, img, x, y, z, w, h, d, nInstances)
    if x and y and w and h then
        local t = love.math.newTransform()
        
        t:setMatrix('row', modelMatrix():unpack())
        love.graphics.replaceTransform(t)
        
        t:setMatrix('row', pvMatrix():unpack())
        love.graphics.applyTransform(t)
        
        love.graphics.setLineWidth(strokeWidth())
        love.graphics.line(x, y, x+w, y+h)
    end
end
