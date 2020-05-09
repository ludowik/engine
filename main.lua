if arg[#arg] == '-debug' then
    debugger.start()
end

if false then
    require 'applications.stars'

    if not love then
        require 'lib'
        Engine():run()
    end

else

    require 'engine'
    
    t = Buffer()

    for i=1,1000 do
        t[i] = i
    end

    for i=1,#t do
        print(t[i])
    end

    print(#t)
    
    buffer_meta.__gc(t)
end

