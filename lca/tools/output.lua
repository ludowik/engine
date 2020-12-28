class('output')

decorate('print', function (f, ...)
        f(...)
        io.stdout:flush()
    end)

function output.setup()
    output.__print = print

    print = output.print
    log = output.log

    output.clear()
end

function output.clear()
    output.logs = Table()
end

function output.print(...)
    output.log(...)
    output.__print(...)
end

function output.log(...)
    local args = {...}

    for i,value in ipairs(args) do
        output.logs:add(tostring(value))
    end

    while #output.logs > 20 do
        output.logs:remove(1)
    end
end

function output.draw(x, y)
    local previousValue = nil
    for i=1,#output.logs do
        local value = output.logs[i]
        if value ~= previousValue then
            local w, h = textSize(value)
            text(value, 0, y-h)
            y = y - h
            previousValue = value
        end
    end
end
