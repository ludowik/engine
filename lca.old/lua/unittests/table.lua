ut:add('table', function (lib)
    local array = {}
    
    lib:assert('exist', Table)
    lib:assert('new', Table())
    lib:assert('new(array)', Table(array) == array)
    
    local t1 = Table()
    lib:assert('add(item)', t1:add('item') == t1)
    lib:assert('getn', t1:getn() == 1)
end)
