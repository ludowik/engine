class 'Style'

function Style:init()
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

function Style:setAttribute(attribute_name, value, reset)
    if value or reset then
        self.attributes[attribute_name] = value
    end
    return self.attributes[attribute_name]
end

function pushStyle()
    push('__style', style:clone())
end

function popStyle()
    style = pop('__style')
    
    blendMode(style.blendMode)
    cullingMode(style.cullingMode)
    depthMode(style.depthMode)
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

function tint(...)
    return style:setAttribute('tint', Color.args(...):clone())
end

function strokeWidth(width)
    return style:setAttribute('strokeWidth', width)
end

CENTER = 'center'
CORNER = 'corner'

function rectMode(mode)
    return style:setAttribute('rectMode', mode)
end

function ellipseMode(mode)
    return style:setAttribute('ellipseMode', mode)
end

function circleMode(mode)
    return style:setAttribute('circleMode', mode)
end

function spriteMode(mode)
    return style:setAttribute('spriteMode', mode)
end

function textMode(mode)
    return style:setAttribute('textMode', mode)
end

function light(mode)
    return style:setAttribute('light', mode)
end

function supportedOrientations()
end
