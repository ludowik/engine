-- attributes
function attribute(attributes, name, value)
    if value ~= nil then
        attributes[name] = value
    end
    return attributes[name]
end

function resetAttribute(attributes, name)
    attributes[name] = nil
end

-- styles
local styles

function resetStyle()
    styles = {}

    stroke(white)
    strokeWidth(1)

    fill(white)

    tint(white)
    blendMode(NORMAL)

    font(DEFAULT_FONT_NAME)
    fontSize(22)

    textMode(CENTER)

    circleMode(CENTER)
    ellipseMode(CENTER)

    rectMode(CORNER)

    spriteMode(CENTER)

    lineCapMode(ROUND)
end

function getStyle()
    return styles
end

function pushStyle()
    push('styles', table.clone(styles))
end

function popStyle()
    styles = pop('styles')
end

function pushState()
    pushStyle()
    pushMatrix()
end

function popState()
    popMatrix()
    popStyle()
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

local screenAttributes = {}
function displayMode(mode)
    return attribute(screenAttributes, 'displayMode', mode)
end

function backingMode(mode)
    todo()
    return attribute(screenAttributes, 'backingMode', mode)
end

print(bitAND(PORTRAIT_ANY, LANDSCAPE_LEFT))

function supportedOrientations(mode)
    if mode then
        if not bitAND(mode, LANDSCAPE_ANY) then
            config.orientation = 'portrait'
            initWindow()
        end
        if not bitAND(mode, PORTRAIT_ANY) then
            config.orientation = 'landscape'
            initWindow()
        end
    end
    return attribute(screenAttributes, 'supportedOrientations', mode)
end

-- colors
local strokeColor, fillColor, tintColor = color(), color(), color()
function stroke(clr, ...)
    if clr then
        strokeColor:init(clr, ...)
        clr = strokeColor
    end
    return attribute(styles, 'strokeColor', clr)
end

function noStroke()
    attribute(styles, 'strokeWidth', 0)
    return resetAttribute(styles, 'strokeColor')
end

function fill(clr, ...)
    if clr then
        fillColor:init(clr, ...)
        clr = fillColor
    end
    return attribute(styles, 'fillColor', clr)
end

function noFill()
    return resetAttribute(styles, 'fillColor')
end

function tint(clr, ...)
    if clr then
        tintColor:init(clr, ...)
        clr = tintColor
    end
    return attribute(styles, 'tintColor', clr)
end

function noTint()
    return resetAttribute(styles, 'tintColor')
end

function smooth()
    return attribute(styles, 'smooth', true)
end

function noSmooth()
    return attribute(styles, 'smooth', false)
end

function clip(x, y, w, h)
    todo()
end

function noClip()
    todo()
end

function light(mode)
    return attribute(styles, 'lightMode', mode)
end

function noLight()
    return resetAttribute(styles, 'lightMode')
end

function strokeWidth(width)
    return attribute(styles, 'strokeWidth', width)
end

-- modes
local modes = {}

function rectMode(...)
    return attribute(modes, 'rectMode', ...)
end

function ellipseMode(...)
    return attribute(modes, 'ellipseMode', ...)
end

function circleMode(...)
    return attribute(modes, 'ellipseMode', ...)
end

function spriteMode(...)
    return attribute(modes, 'spriteMode', ...)
end

function textMode(...)
    return attribute(modes, 'textMode', ...)
end

function textWrapWidth(...)
    return attribute(modes, 'textWrapWidth', ...)
end

-- text align
LEFT = 0
RIGHT = 2

function textAlign(...)
    todo()
    return attribute(modes, 'textAlign', ...)
end

function polylineMode(...)
    return attribute(modes, 'polylineMode', ...)
end

--- line style
ROUND = 0
SQUARE = 1
PROJECT = 2

function lineCapMode(...)
    return attribute(modes, 'lineCapMode', ...)
end

NORMAL = 'normal'
ADDITIVE = 'additive'
MULTIPLY = 'multiply'

function blendMode(mode)
    if mode == NORMAL then
        graphics.setBlendMode('alpha')

    elseif mode == ADDITIVE then
        graphics.setBlendMode('add')

    elseif mode == MULTIPLY then
        graphics.setBlendMode('multiply', 'premultiplied')

    end

    return graphics.getBlendMode()
end

function style(size, clr1, clr2)
    strokeWidth(size)
    if clr1 and clr1 ~= transparent then
        stroke(clr1)
    else
        noStroke()
    end

    if clr2 and clr2 ~= transparent then
        fill(clr2)
    else
        noFill()
    end
end

function textStyle(size, clr, mode)
    fontSize(size)
    if clr and clr ~= transparent then
        fill(clr)
    else
        noFill()
    end
    textMode(mode)
end
