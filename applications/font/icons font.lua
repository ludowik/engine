function draw()
    background()

    font('Foundation-Icons')
    fontSize(22)

    textMode(CORNER)

    local wMax, hMax, n = 0, 0, 314
    for i=0,n do
        local w, h = textSize(''..utf8.char(0xF100+i))
        wMax = max(w, wMax)
        hMax = max(h, hMax)
    end

    local i = 0

    local col = tointeger((WIDTH -2*wMax) / wMax)
    local row = tointeger(n/col)

    translate(WIDTH/2, -HEIGHT/2)
    translate(-col*wMax/2, row*hMax/2)

    for row=0,row-1 do
        for col=0,col-1 do
            text(''..utf8.char(0xF100+i), col*wMax, HEIGHT-row*hMax)
            i = i + 1
        end
    end
end
