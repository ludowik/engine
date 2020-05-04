function decore(f, callback)
    return function (...)
        callback()
        return f(...)
    end
end
