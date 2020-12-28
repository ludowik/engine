decorate('print', function (f, ...)
        f(...)
        io.stdout:flush()
    end)

