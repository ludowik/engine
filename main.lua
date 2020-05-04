if arg[#arg] == '-debug' then
    debugger.start()
end

require 'applications.stars'
require 'lib'

if not love then
    Engine():run()
end
