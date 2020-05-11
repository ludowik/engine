if arg[#arg] == '-debug' then
    debugger.start()
end

if true then
    require 'applications.surface'

    if not love then
        require 'lib'
        Engine():run()
    end

else

    require 'engine'
    
    t = Buffer('int')

    for i=1,1000 do
        t[i] = i
    end

    for i=1,#t do
        print(t[i])
    end

    print(#t)
    
    buffer_meta.__gc(t)
end

