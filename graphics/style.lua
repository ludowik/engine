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

function pushStyle()
    push('__style', styles:clone())
end

function popStyle()
    styles = pop('__style')

    blendMode(styles.blendMode)
    cullingMode(styles.cullingMode)
    depthMode(styles.depthMode)
end

function resetStyle()
    styles = Styles()

    TEXT_NEXT_Y = H

    blendMode(NORMAL)
    depthMode(false)
    cullingMode(true)

    fontSize(12)
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
    return styles:setAttribute('fill', Color.args(...):clone())
end

function noFill()
    return styles:setAttribute('fill', nil, true)
end

function stroke(...)
    return styles:setAttribute('stroke', Color.args(...):clone())
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
    return styles:setAttribute('tint', Color.args(...):clone())
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

function textMode(mode)
    return styles:setAttribute('textMode', mode)
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
    log('not implemented')
end

function displayMode()
    log('not implemented')
end
