graphics = graphics or class('graphics')

function graphics.setup()
    Model.setup()
    
    NORMAL = 'normal'
    ADDITIVE = 'additive'
    MULTIPLY = 'multiply'
    
    graphics:push2Global()
    
    stylesHeap = newHeap('styles')
end

--- display mode
enum 'DisplayMode' {
    STANDARD = 0,
    OVERLAY = 1,
    FULLSCREEN = 2,
    FULLSCREEN_NO_BUTTONS = 3
}

RETAINED = 1

--- orientation
LANDSCAPE_LEFT = 1
LANDSCAPE_RIGHT = 2
LANDSCAPE_ANY = LANDSCAPE_LEFT + LANDSCAPE_RIGHT

PORTRAIT = 4
PORTRAIT_UPSIDE_DOWN = 8
PORTRAIT_ANY = PORTRAIT + PORTRAIT_UPSIDE_DOWN

ANY = LANDSCAPE_ANY + PORTRAIT_ANY

function graphics.initMode(culling, depth)
    cullingMode(culling)
    depthMode(depth)
end

function graphics.supportedOrientations(mode)
    -- TODO : exploiter l'orientation pour la création et la mise à jour de la fenêtre
    if mode then
        if not bitAND(mode, LANDSCAPE_ANY) then
            config.orientation = 'portrait'
        end
        if not bitAND(mode, PORTRAIT_ANY) then
            config.orientation = 'landscape'
        end
    end
    return graphics.attribute('supportedOrientations', mode)
end

function graphics.attribute(attribute, value)
    if value then
        graphics.style[attribute] = value
    end
    return graphics.style[attribute]
end

function graphics.reset()
    resetMatrix(true)
    resetStyle()

--    ortho()

    font(DEFAULT_FONT_NAME)
    fontSize(DEFAULT_FONT_SIZE)
    
    graphics.drawcalls = 0
    graphics.texturememory = 0
end

function graphics.center(mode, x, y, w, h)
    x = x or 0
    y = y or 0
    if mode == CENTER then
        x = x - w / 2
        y = y - h / 2
    end
    return x, y
end

function graphics.corner(mode, x, y, w, h)
    x = x or 0
    y = y or 0
    if mode == CORNER then
        x = x + w / 2
        y = y + h / 2
    end
    return x, y
end

function graphics.pushStyle()
    stylesHeap:push(graphics.style:clone())
end

function graphics.popStyle()
    graphics.style = stylesHeap:pop()
    
    blendMode(graphics.style.blendMode)

    cullingMode(graphics.style.cullingMode)
    depthMode(graphics.style.depthMode)
end

function graphics.stroke(strokeColor, ...)
    if strokeColor then
        graphics.style.strokeColor:set(strokeColor, ...)
    end
    return graphics.style.strokeColor
end

function graphics.strokeWidth(strokeWidth)
    if strokeWidth then
        graphics.style.strokeWidth = strokeWidth
    end
    return graphics.style.strokeWidth
end

function graphics.noStroke()
    graphics.style.strokeColor.a = 0
end

function graphics.fill(fillColor, ...)
    if fillColor then
        graphics.style.fillColor:set(fillColor, ...)
    end
    return graphics.style.fillColor
end

function graphics.noFill()
    graphics.style.fillColor.a = 0
end

--- line style
ROUND = 0
SQUARE = 1
PROJECT = 2

function graphics.lineCapMode(lineCapMode)
    if lineCapMode then
        graphics.style.lineCapMode = lineCapMode
    end
    return graphics.style.lineCapMode
end

function graphics.rectMode(rectMode)
    if rectMode then
        graphics.style.rectMode = rectMode
    end
    return graphics.style.rectMode
end

function graphics.ellipseMode(ellipseMode)
    if ellipseMode then
        graphics.style.ellipseMode = ellipseMode
    end
    return graphics.style.ellipseMode
end

function graphics.circleMode(circleMode)
    if circleMode then
        graphics.style.circleMode = circleMode
    end
    return graphics.style.circleMode
end

function graphics.tint(tintColor, ...)
    if tintColor then
        graphics.style.tintColor:set(tintColor, ...)
    end
    return graphics.style.tintColor
end

function graphics.noTint()
    graphics.style.tintColor:set(white)
end

function graphics.spriteMode(spriteMode)
    if spriteMode then
        graphics.style.spriteMode = spriteMode
    end
    return graphics.style.spriteMode
end

function graphics.spriteSize(img)
    if type(img) == 'string' then
        img = image(img)
    end
    return img.width, img.height
end

function graphics.textMode(textMode)
    if textMode then
        graphics.style.textMode = textMode
    end
    return graphics.style.textMode
end

function graphics.polylineMode(polylineMode)
    if polylineMode then
        graphics.style.polylineMode = polylineMode
    end
    return graphics.style.polylineMode
end

function graphics.displayMode(displayMode)
    if displayMode then
        graphics.style.displayMode = displayMode
    end
    return graphics.style.displayMode
end

function graphics.light(lightMode)
    if lightMode then
        graphics.style.lightMode = lightMode
    end
    return graphics.style.lightMode
end

function graphics.noLight()
    graphics.style.lightMode = false
end

function graphics.smooth(smoothMode)
    if smoothMode then
        graphics.style.smoothMode = smoothMode
    end
    return graphics.style.smoothMode
end

function graphics.noSmooth()
    graphics.style.smooth = nil
end

function graphics.textAlign(textAlign)
    if textAlign then
        graphics.style.textAlign = textAlign
    end
    return graphics.style.textAlign
end

function graphics.textWrapWidth(textWrapWidth)
    if textWrapWidth then
        graphics.style.textWrapWidth = textWrapWidth
    end
    return graphics.style.textWrapWidth
end

function graphics.font(fontName, fontExt)
    if fontName then
        graphics.style.fontName = fontName
        setFont()
    end
    return graphics.style.fontName
end

function graphics.fontSize(fontSize)
    if fontSize then
        graphics.style.fontSize = fontSize
        setFont()
    end
    return graphics.style.fontSize
end
