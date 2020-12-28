ut:add('string', function (lib)    
    lib:assert('lower', string.lower('TEST') == 'test')
    lib:assert('upper', string.upper('test') == 'TEST')
    
    lib:assert('left', string.left('test', 2) == 'te')
    lib:assertEqual('right', string.right('right', 2), 'ht')
    
    lib:assert('rep', string.rep('t', 4) == 'tttt')
    
    lib:assert('proper', string.proper('test test') == 'Test test')
    
    lib:assert('startWith=true', string.startWith('test', 'te') == true)
    lib:assert('startWith=false', string.startWith('test', 'et') == false)
    
    lib:assert('contains=true', string.contains('test', 'es') == true)
    lib:assert('contains=false', string.contains('test', 'et') == false)
    
    lib:assert('replace', string.replace('test', 'e', 'E') == 'tEst')
end)
