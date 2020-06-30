logo = class('Logo')

function logo.reset()
    logo.home()
    logo.showturtle()
    logo.pendown()
    logo.scale(1)

    strokeWidth(1)
end

function logo.home()
    translate(W/2, H/2)
end

function logo.pendown()
    logo.pen = 'down'
end

function logo.penup()
    logo.pen = 'up'
end

function logo.showturtle()
    logo.turtle = 'show'
end

function logo.hideturtle()
    logo.turtle = 'hide'
end

function logo.scale(n)
    logo.ratio = n
end

function logo.forward(n)
    n = n * logo.ratio
    if logo.pen == 'down' then
        line(0, 0, n, 0)
    end
    translate(n, 0)
end

function logo.back(n)
    logo.forward(-n)
end

function logo.right(n)
    rotate(n) 
end

function logo.left(n)
    logo.right(-n) 
end

function logo.repeatn(n, f)
    for i=1,n do
        f()
    end
end

function logo.setcolor(clr)
    stroke(clr)
end

function logo.pick(...)
    local args = {...}
    return table.random(args)
end

function draw()
    line(0, 0, 100, 100)
    dist = distFromPoint2Segment(mouse.x, mouse.y, 0, 0, 100, 100)

    logo.reset()

    logo.scale(4)

    logo.setcolor(logo.pick(red, blue, green))

    logo.repeatn(20,
        function ()
            logo.repeatn(180,
                function ()
                    logo.forward(1)
                    logo.right(2)
                end)
            logo.right(18)
        end)
end
