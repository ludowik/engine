ut:add('math', function (lib)
    lib:assertEqual('min', min(1,9), 1)
    lib:assertEqual('max', max(1,9), 9)
    
    lib:assertEqual('tointeger', tointeger(1.9), 1)
    
    lib:assertEqual('round.down', round(1), 1)
    lib:assertEqual('round.down', round(1.4), 1)
    
    lib:assertEqual('round.up', round(1.5), 2)
    lib:assertEqual('round.up', round(1.9), 2)
    lib:assertEqual('round.up', round(2), 2)
        
    lib:assertEqual('tau', tau, math.pi * 2)
    
    lib:assertBetween('random', random(), 0, 1)
end)
