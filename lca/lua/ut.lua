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
