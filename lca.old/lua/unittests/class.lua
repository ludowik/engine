ut:add('class', function (lib)
    lib:assert('exist', class)
    lib:assert('new', class())
    
    local t1 = class("test")
    function t1:f() end
    lib:assert('className.class', t1.className == "test")
    lib:assert('className.instance', t1().className == "test")
    lib:assert('className.f1', t1().f == t1.f)
    
    local t2 = class("test2", t1)
    function t2:f() end
    lib:assert('className.derived.class', t2.className == "test2")
    lib:assert('className.derived.instance', t2().className == "test2")
    lib:assert('className.f2', t2().f == t2.f)
    
    local t3 = class("test3", t1)
    lib:assert('className.f3', t3().f == t1.f)
end)
