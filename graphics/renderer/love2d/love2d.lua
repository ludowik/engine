class 'Love2dSDL' : extends(MediaInterface)

function Love2dSDL.setup()
    love.keypressed = function (key, scancode, isrepeat)
        engine:keydown(key, isrepeat)
    end

    love.keyreleased = function (key, scancode)
        engine:keyup(key)
    end

    love.mousepressed = function (x, y, button, istouch, presses)
        mouse:mouseEvent(
            0,
            BEGAN,
            x, y,
            0, 0,
            true,
            istouch)
    end

    love.mousemoved = function (x, y, dx, dy, istouch)
        mouse:mouseEvent(
            0,
            MOVING,
            x, y,
            dx, dy,
            istouch)
    end

    love.mousereleased = function (x, y, button, istouch, presses)
        mouse:mouseEvent(
            0,
            ENDED,
            x, y,
            0, 0,
            false)
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

function Love2dRenderer:init()
    self.GL_TRIANGLES = 'triangles'
    self.GL_TRIANGLE_STRIP = 'triangleStrip'
end

function Love2dRenderer.glGenBuffer()
    return -1
end

function Love2dRenderer:viewport(x, y, w, h)
end

function Love2dRenderer:clear(clr)
--    love.graphics.clear(clr.r, clr.g, clr.b, clr.a)
end

local t = love.math.newTransform()

function Love2dRenderer:render(shader, drawMode, img, x, y, z, w, h, d, nInstances)
    local vertices = self.vertices
    local indices = self.indices

    x = x or 0
    y = y or 0
    z = z or 0

    w = w or 1
    h = h or 1
    d = d or 1

    love.graphics.origin()
    
    t:setMatrix('row', (
            matrix():translate(0, screen.h) * 
            matrix():scale(screen.w/2, -screen.h/2) * 
            matrix():translate(1, 1) * 
            pvMatrix() *
            modelMatrix()):unpack())
    
    love.graphics.applyTransform(t)

    love.graphics.setLineWidth(strokeWidth())

    local stroke = stroke()
    if stroke then
        love.graphics.setColor(stroke.r, stroke.g, stroke.b, stroke.a)
    end

    if drawMode == self.GL_TRIANGLES or drawMode == self.GL_TRIANGLE_STRIP then
        local n
        if drawMode == self.GL_TRIANGLES then
            if indices and #indices > 0 then
                n = #indices / 3
            else
                n = #vertices / 3
            end
        elseif drawMode == self.GL_TRIANGLE_STRIP then
            if indices and #indices > 0 then
                n = #indices - 2
            else
                n = #vertices - 2
            end
        end

        local a, b, c
        for i=0,n-1 do
            if drawMode == self.GL_TRIANGLES then
                if indices and #indices > 0 then
                    a = vertices[indices[i*3+1]+1]
                    b = vertices[indices[i*3+2]+1]
                    c = vertices[indices[i*3+3]+1]
                else
                    a = vertices[i*3+1]
                    b = vertices[i*3+2]
                    c = vertices[i*3+3]
                end
            elseif drawMode == self.GL_TRIANGLE_STRIP then
                if indices and #indices > 0 then
                    a = vertices[indices[i+1]+1]
                    b = vertices[indices[i+2]+1]
                    c = vertices[indices[i+3]+1]
                else
                    a = vertices[i+1]
                    b = vertices[i+2]
                    c = vertices[i+3]
                end
            end

            love.graphics.line(
                x + a.x * w,
                y + a.y * h,
                x + b.x * w,
                y + b.y * h)

            love.graphics.line(
                x + b.x * w,
                y + b.y * h,
                x + c.x * w,
                y + c.y * h)

            love.graphics.line(
                x + c.x * w,
                y + c.y * h,
                x + a.x * w,
                y + a.y * h)
        end
    end
end
