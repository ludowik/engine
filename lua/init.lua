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

os.name = os.getenv("HOME") and os.getenv("HOME"):sub(1, 1) == '/' and 'osx' or 'windows'

function format_ram(ram)
    return string.format('%.2f mo', ram / 1024 / 1024)
end
