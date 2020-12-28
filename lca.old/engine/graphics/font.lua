DEFAULT_FONT_NAME = 'Arial'
DEFAULT_FONT_SIZE = 12

local CurrentFont

function font(fontName, fontExt)
    if fontName then
        attribute(getStyle(), 'fontName', fontName)
        setFont()
    end
    return attribute(getStyle(), 'fontName') or DEFAULT_FONT_NAME
end

function fontSize(size)
    if size then
        attribute(getStyle(), 'fontSize', size)
        setFont()
    end
    return attribute(getStyle(), 'fontSize') or DEFAULT_FONT_SIZE
end

local function createFont(font)
    if font.fontName then
        local fontPath = 'res/font/'..font.fontName..'.'..font.fontExt
        return graphics.newFont(fontPath, font.fontSize)
    else
        return graphics.newFont(font.fontSize)
    end
end

function getFont()
    return CurrentFont
end

function setFont()
    CurrentFont = resources.get('font', 
        RefFont(font(), fontSize(), fontExt),
        createFont)
end

class('RefFont')

function RefFont:init(name, size, ext)
    self.fontName = name or font()
    self.fontSize = size
    self.fontExt = ext or 'ttf'
end

function RefFont:__tostring()
    return self.fontName..'.'..self.fontSize
end
