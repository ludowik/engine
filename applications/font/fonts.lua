function setup()
--    setFontPath('/System/Library/Fonts')
    
    fonts = dir(getFontPath())
    fontNameIndex = 1
    
    size = 12
    
    alphabet = ''
    for i=32,127 do
        if i%size == 0 and #alphabet > 0 then
            alphabet = alphabet..NL
        end
        alphabet = alphabet..string.char(i)
    end
end

function draw()
    background(51)

    textMode(CORNER)

    resetTextNextY()
    
--    fontNameIndex = randomInt(#fonts)
    
    local _, fontNameRandom = splitFilePath(fonts[fontNameIndex])
    font(fontNameRandom)    
    for i = 1,24 do
        fontSize(i)
        text(font()..' '..fontSize(), W/3)
    end

    local w, h
    resetTextNextY()
    fontSize(12)
    stroke(red)
    for i,v in ipairs(fonts) do
        local _, fontName = splitFilePath(v)
        font(fontName)

        fill(white)

        w, h = text(font()..' '..fontSize())

        if fontNameRandom == fontName then
            noFill()
            rect(0, TEXT_NEXT_Y, w, h)
        end
    end
    
    resetTextNextY()
    fontSize(24)
    font(fontNameRandom)
    fill(white)
    text(alphabet, W*2/3)
end

function keyboard(key)
    if key == 'down' then
        fontNameIndex = (fontNameIndex + 1) % #fonts
    elseif key == 'up' then
        fontNameIndex = (fontNameIndex - 1) % #fonts
    end
    
    if fontNameIndex > #fonts then 
        fontNameIndex = 1
    elseif fontNameIndex < 1 then
        fontNameIndex = #fonts
    end
end
