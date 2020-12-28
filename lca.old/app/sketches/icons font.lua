function draw()
    background()

    font('foundation-icons')
    fontSize(22)

    textMode(CORNER)

    local wMax, hMax = 0, 0
    range(1, 300):forEach(function (i)
            local w, h = textSize(''..utf8.char(0xF100+i))
            wMax = max(w, wMax)
            hMax = max(h, hMax)
        end)

    local i = 0

    local col = tointeger((WIDTH -2*wMax) / wMax)
    local row = tointeger(300/col)

    translate(WIDTH/2, -HEIGHT/2)
    translate(-col*wMax/2, row*hMax/2)
    
    range(0, row-1):forEach(function (row)
            range(0, col-1):forEach(function (col)
                    text(''..utf8.char(0xF100+i), col*wMax, HEIGHT-row*hMax)
                    i = i + 1
                end)
        end)
end
