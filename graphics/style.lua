class 'Style'

function Style:init()
    self.attributes = {
        fill = white,

        stroke = white,
        strokeWidth = 1,

        rectMode = CORNER,
        textMode = CORNER,

        spriteMode = CORNER,
    }
end

function Style:setAttribute(attribute_name, value, reset)
    if value or reset then
        self.attributes[attribute_name] = value
    end
    return self.attributes[attribute_name]
end

function resetStyle()
    style = Style()

    TEXT_NEXT_Y = H

    blendMode(NORMAL)
    depthMode(false)
    cullingMode(true)

    fontSize(12)
end

function fill(...)
    return style:setAttribute('fill', Color.args(...):clone())
end

function noFill()
    return style:setAttribute('fill', nil, true)
end

function stroke(...)
    return style:setAttribute('stroke', Color.args(...):clone())
end

function noStroke()
    return style:setAttribute('stroke', nil, true)
end

function strokeWidth(width)
    return style:setAttribute('strokeWidth', width)
end

CENTER = 'center'
CORNER = 'corner'

function textMode(mode)
    return style:setAttribute('textMode', mode)
end

function rectMode(mode)
    return style:setAttribute('rectMode', mode)
end

function spriteMode(mode)
    return style:setAttribute('spriteMode', mode)
end

CENTER = 'center'
CORNER = 'corner'

function rectMode(mode)
    return style:setAttribute('rectMode', mode, CENTER)
end

function spriteMode(mode)
    return style:setAttribute('spriteMode', mode, CENTER)
end

function textMode(mode)
    return style:setAttribute('textMode', mode, CENTER)
end
