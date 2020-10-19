function setup()
    y = 1
end

function draw()
    background(51)
    
    for i = 1,24 do
        fontSize(i)
        
        local w, h = textSize('font')
        print(w, h)
        
        textMode(CORNER)
        text('font '..font()..' size '..fontSize()..' w='..w..' h='..h)
    end
end
