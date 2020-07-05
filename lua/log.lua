__print = print
function print(str, ...)
    assert(str~='memory')
    __print(str, ...)
end
