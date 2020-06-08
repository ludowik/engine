if arg[#arg] == '-debug' then
    debugger.start()
    debugging = true
end

print(jit.version)

require 'engine.#'

gl.majorVersion = 4
gl.minorVersion = 1

Engine():run('dots')
