local function createFont(font)    
    if font.fontName then
        local fontPath = 'res/font/'..font.fontName..'.'..font.fontExt
        if isFile(fontPath) then
            return love.graphics.newFont(fontPath, font.fontSize)
        else
            return createFont{
                fontName = DEFAULT_FONT_NAME,
                fontSize = DEFAULT_FONT_SIZE,
                fontExt = 'ttf'
            }
        end
    else
        return love.graphics.newFont(font.fontSize)
    end
end

local function releaseFont(font)
    font:release()
end

local CurrentFont

function getFont()
    return CurrentFont or setFont()
end

function setFont(name, size)
    name = name or graphics.style.fontName -- font()
    size = size or graphics.style.fontSize -- fontSize()

    CurrentFont = resources.get('font', 
        RefFont(name, size, fontExt),
        createFont,
        releaseFont,
        false)
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
