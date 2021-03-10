function draw()
    background()

    a_line = Buffer('vec3')

    for x=1,1000 do
        a_line:add(vec3(x,100+10*noise(x/100)))
    end

    lines(a_line)
end
