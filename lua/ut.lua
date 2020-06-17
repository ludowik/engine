class('ut')

function ut.assert(name, expression)
    assert(expression, name)
end

function ut.assertEqual(name, expression, value)
    assert(expression == value, name)
end

function ut.assertBetween(name, expression, min, max)
    assert(min <= expression and expression <= max, name)
end

function ut.testAll()
    for k,v in pairs(_G) do
        if type(v) == 'table' then
            local test = rawget(v, 'test')
            if test then
                test()
            end
        end
    end
end
