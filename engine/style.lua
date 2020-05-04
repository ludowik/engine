class 'Style'

function Style:init()
    self.attributes = {}
end

function Style:setAttribute(attribute_name, value, reset)
    if value or reset then
        self.attributes[attribute_name] = value
    end
    return self.attributes[attribute_name]
end

style = Style()

function stroke(clr)
    return style:setAttribute('stroke', clr)
end

function noStroke()
    return style:setAttribute('stroke', nil, true)
end

function fill(clr)
    return style:setAttribute('fill', clr)
end

function noFill()
    return style:setAttribute('fill', nil, true)
end

function strokeWidth(width)
    local res = style:setAttribute('strokeWidth', width)
    applyStyle()
    return res
end

function applyStyle()
    if love then
        love.graphics.setPointSize(style.strokeWidth)
    end
end
