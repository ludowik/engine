class 'Styles'

s0 = 0.01
s1 = 1.01
for i = 2, 20 do
    _G['s'..i] = i
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
        textMode = CORNER,

        spriteMode = CORNER,

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

function pushStyle()
    push('__style', styles:clone())
end

function popStyle()
    styles = pop('__style')

    blendMode(styles.blendMode)
    cullingMode(styles.cullingMode)
    depthMode(styles.depthMode)
    
    font()
    fontSize()
end

function resetStyle()
    styles = Styles()

    TEXT_NEXT_Y = H

    blendMode(NORMAL)
    depthMode(false)
    cullingMode(true)

    font()
    fontSize()
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

function fill(...)
    return styles:setAttributeColor('fill', ...)
end

function noFill()
    return styles:setAttribute('fill', nil, true)
end

function stroke(...)
    return styles:setAttributeColor('stroke', ...)
end

function noStroke()
    return styles:setAttribute('stroke', nil, true)
end

function light(mode)
    return styles:setAttribute('light', mode)
end

function noLight()
    return styles:setAttribute('light', nil, true)
end

function tint(...)
    return styles:setAttributeColor('tint', ...)
end

function noTint()
    return styles:setAttribute('tint', nil, true)
end

function strokeWidth(width)
    return styles:setAttribute('strokeWidth', width)
end

CENTER = 'center'
CORNER = 'corner'

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
    return styles:setAttribute('fontName', ft:setFontName(name))
end

function fontSize(size)
    return styles:setAttribute('fontSize', ft:setFontSize(size))
end

function textMode(mode)
    return styles:setAttribute('textMode', mode)
end

function textWrapWidth(width)
    return styles:setAttribute('textWrapWidth', width)
end

function textAlign(mode)
    return styles:setAttribute('textAlign', mode)
end

function lineCapMode(mode)
    return styles:setAttribute('lineCapMode', mode)
end

function smooth(mode)
    return styles:setAttribute('smooth', mode)
end

function noSmooth()
    return styles:setAttribute('smooth', nil, true)
end

function supportedOrientations()
    functionNotImplemented()
end

function displayMode()
    functionNotImplemented()
end
