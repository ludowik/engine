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

style = Style()

function fill(clr)
    return style:setAttribute('fill', clr)
end

function noFill()
    return style:setAttribute('fill', nil, true)
end

function stroke(clr)
    return style:setAttribute('stroke', clr)
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
