if arg[#arg] == '-debug' then
    debugger.start()
    debugging = true
end

print(jit.version)

require 'engine'
Engine():run('dots')
