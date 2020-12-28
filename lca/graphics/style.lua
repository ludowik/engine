class('Style')

function Style.setup()
    Style.backgroundColor = color(51)
    
    Style.strokeWidth = 2
    Style.strokeColor = color(210)
    
    Style.fillColor = color(210)
    
    Style.tintColor = color(1)
    
    CENTER = 'center'
    CORNER = 'corner'
    
    s0 = 0.01
    s1 = 1.01
    for i = 2, 20 do
        _G['s'..i] = i
    end
    
    resetStyle()
end

function Style:init()
    self.backgroundColor = Style.backgroundColor
    
    self.strokeWidth = Style.strokeWidth
    self.strokeColor = Style.strokeColor
    
    self.fillColor = Style.fillColor
    
    self.tintColor = Style.tintColor
    
    self.lineCapMode = SQUARE
    self.polylineMode = CENTER
    self.rectMode = CORNER
    self.circleMode = CENTER
    self.ellipseMode = CENTER
    self.textMode = CENTER
    self.spriteMode = CENTER
    
    self.displayMode = NORMAL
    
    self.fontName = DEFAULT_FONT_NAME
    self.fontSize = DEFAULT_FONT_SIZE
    
    self.lightMode = false
    
    self.blendMode = NORMAL
    
    self.cullingMode = 'none'
    self.depthMode = false
end

function Style:clone()
    local clone = Style:__new()
    
    clone.backgroundColor = self.backgroundColor
    
    clone.strokeWidth = self.strokeWidth
    clone.strokeColor = self.strokeColor
    
    clone.fillColor = self.fillColor
    
    clone.tintColor = self.tintColor
    
    clone.lineCapMode = self.lineCapMode
    clone.polylineMode = self.polylineMode
    clone.rectMode = self.rectMode
    clone.circleMode = self.circleMode
    clone.ellipseMode = self.ellipseMode
    clone.textMode = self.textMode
    clone.spriteMode = self.spriteMode
    
    clone.displayMode = self.displayMode
    
    clone.fontName = self.fontName
    clone.fontSize = self.fontSize
    
    clone.lightMode = self.lightMode
    
    clone.blendMode = self.blendMode

    clone.cullingMode = self.cullingMode
    clone.depthMode = self.depthMode
    
    return clone
end

function resetStyle()
    graphics.style = Style()
    
    blendMode(graphics.style.blendMode)
    
    cullingMode(graphics.style.cullingMode)
    depthMode(graphics.style.depthMode)
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
