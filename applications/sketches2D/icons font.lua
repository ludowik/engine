-- TOFIX ne fonctionne pas sans UTF8

local function char(i)
    if love then
        return utf8.char(0xF100+i)
    end
    return utf8.char(0xF100+i)
end

function draw()
    background()

    font('Foundation-icons')
    fontSize(22)

    textMode(CORNER)

    local wMax, hMax = 0, 0
    for i=1,255 do
        local w, h = textSize(''..char(i))
        wMax = max(w, wMax)
        hMax = max(h, hMax)
    end

    local i = 0

    local col = tointeger((WIDTH -2*wMax) / wMax)
    local row = tointeger(300/col)

    translate(WIDTH/2, -HEIGHT/2)
    translate(-col*wMax/2, row*hMax/2)

    for row=0,row-1 do
        for col=0,col-1 do
            text(''..char(i), col*wMax, HEIGHT-row*hMax)
            i = i + 1
        end
    end
end
