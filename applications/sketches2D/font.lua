function setup()
    fonts = dir('res/fonts')
    fontNameIndex = 1
    
    alphabet = ''
    for i=0,255 do
        if i%32 == 0 and i~= 0 then
            alphabet = alphabet..NL
        end
        alphabet = alphabet..utf8char.char(i)
    end
end

function draw()
    background(51)

    textMode(CORNER)

    resetTextNextY()
    local _, fontNameRandom = splitFilePath(fonts[fontNameIndex]) -- :random())
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
    fontSize(12)
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
