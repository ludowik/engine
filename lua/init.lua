require 'lua.class'
require 'lua.array'
require 'lua.range'
require 'lua.math'
require 'lua.random'
require 'lua.decorator'

function ram()
    return collectgarbage('count') * 1024
end

function gc()
    collectgarbage('collect')
end
