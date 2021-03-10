class 'Styles'

s0 = 0.01
s1 = 1.01
for i = 2, 20 do
    _G['s'..i] = i
end

function Styles.setup()
    CENTER = 'center'
    CORNER = 'corner'

    SQUARE = 0
    ROUND = 1
    PROJECT = 2
    
    DEGREES = 'degrees'
    RADIANS = 'radians'
end

function Styles:init()
    self.attributes = {
        fill = white,

        stroke = white,
        strokeWidth = 1,

        tint = white,

        rectMode = CORNER,

        ellipseMode = CENTER,
        circleMode = CENTER,

        textMode = CENTER,

        spriteMode = CENTER,

        lineCapMode = ROUND,
        
        angleMode = DEGREES,
        
        light = false
    }
end

function Styles:setAttribute(attribute_name, value, reset)
    if value or reset then
        self.attributes[attribute_name] = value
    end
    return self.attributes[attribute_name]
end

function Styles:setAttributeColor(attribute_name, clr, ...)
    if clr then
        self.attributes[attribute_name] = Color.args(clr, ...):clone()
    end
    return self.attributes[attribute_name]
end

function Styles:getAttribute(attribute_name)
    return self.attributes[attribute_name]
end

function resetTextNextY()
    TEXT_NEXT_Y = screen.H
end

function resetStyle(blend, depth, culling)
    styles = Styles()

    resetTextNextY()

    blendMode(blend or NORMAL)
    depthMode(value(depth, true))

    cullingMode(value(culling, false))

    font()
    fontSize()

    noClip()
end

function pushStyle()
    push('__style', styles:clone())
end

function popStyle()
    styles = pop('__style')

    blendMode(styles.attributes.blendMode)
    depthMode(styles.attributes.depthMode)

    cullingMode(styles.attributes.cullingMode)

    font()
    fontSize()

    noClip()
end

function style(size, clr1, clr2)
    assert(size)

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
    assert(size)

    fontSize(size)
    if clr and clr ~= transparent then
        fill(clr)
    else
        noFill()
    end
    textMode(mode)
end

function stroke(...)
    return styles:setAttributeColor('stroke', ...)
end

function strokeWidth(width)
    return styles:setAttribute('strokeWidth', width)
end

function noStroke()
    return styles:setAttribute('stroke', nil, true)
end

function lineCapMode(mode)
    return styles:setAttribute('lineCapMode', mode)
end

function fill(...)
    return styles:setAttributeColor('fill', ...)
end

function noFill()
    return styles:setAttribute('fill', nil, true)
end

function tint(...)
    return styles:setAttributeColor('tint', ...)
end

function noTint()
    return styles:setAttribute('tint', nil, true)
end

function light(...)
    return styles:setAttribute('light', ...)
end

function noLight()
    return styles:setAttribute('light', nil, true)
end

function rectMode(mode)
    return styles:setAttribute('rectMode', mode)
end

function ellipseMode(mode)
    return styles:setAttribute('ellipseMode', mode)
end

function circleMode(mode)
    return styles:setAttribute('circleMode', mode)
end

function spriteMode(mode)
    return styles:setAttribute('spriteMode', mode)
end

function font(name)
    return styles:setAttribute('fontName', ft:setFontName(name or styles:setAttribute('fontName')))
end

function fontSize(size)
    return styles:setAttribute('fontSize', ft:setFontSize(size or styles:setAttribute('fontSize')))
end

function textMode(mode)
    return styles:setAttribute('textMode', mode)
end

-- TODO : textWrapWidth
function textWrapWidth(width)
    return styles:setAttribute('textWrapWidth', width)
end

-- TODO : textAlign
function textAlign(mode)
    return styles:setAttribute('textAlign', mode)
end

-- TODO : smooth
function smooth(mode)
    return styles:setAttribute('smooth', mode)
end

function noSmooth()
    return styles:setAttribute('smooth', nil, true)
end

function clip(x, y, w, h)
    renderer:clip(x, y, w, h)
end

function noClip()
    clip()
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
LANDSCAPE = 0
LANDSCAPE_LEFT = 1
LANDSCAPE_RIGHT = 2
LANDSCAPE_ANY = LANDSCAPE_LEFT + LANDSCAPE_RIGHT

PORTRAIT = 4
PORTRAIT_UPSIDE_DOWN = 8
PORTRAIT_ANY = PORTRAIT + PORTRAIT_UPSIDE_DOWN

ANY = LANDSCAPE_ANY + PORTRAIT_ANY

function supportedOrientations(mode)
    if mode then
        env.__orientation = mode

        if not bitAND(mode, LANDSCAPE_ANY) then
            engine:portrait()
        end
        if not bitAND(mode, PORTRAIT_ANY) then
            engine:landscape()
        end
    end
    return styles:setAttribute('supportedOrientations', mode)
end

function displayMode(mode)
    assert(mode)
end

function angleMode(mode)
    return styles:setAttribute('angleMode', mode)
end
