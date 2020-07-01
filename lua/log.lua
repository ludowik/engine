__print = print
function log(str, ...)
    assert(str ~= 'node')
    __print(str, ...)
end

print = function ()
    error('use log instead of print', 2)
end
