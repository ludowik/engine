class 'ut'

function ut.assert(name, expression, level)
    if not expression then
        error(name, level or 2)
    end
end

function ut.assertEqual(name, expression, value)
    ut.assert(name..': '..tostring(expression)..'<>'..tostring(value), expression == value, 3)
end

function ut.assertBetween(name, expression, min, max)
    ut.assert(name, min <= expression and expression <= max, 3)
end

function ut.run()
    call('test')
end

function ut.test()
    ut.assert('assert', true)

    ut.assertEqual('assertEqual', 1, 1)
    ut.assertEqual('assertEqual', nil, nil)
    ut.assertEqual('assertEqual', 'test', 'test')

    ut.assertBetween('assertBetween', 1, 1, 3)
    ut.assertBetween('assertBetween', 2, 1, 3)
    ut.assertBetween('assertBetween', 3, 1, 3)
end
