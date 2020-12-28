debugger = {}

debugger.start = function ()
    debugger.running = true
    debugger.mob = require('mobdebug')

    debugger.mob.start()
end

debugger.pause = function ()
    debugger.mob.pause()
end

debugger.on = function ()
    if debugging() then
        debugger.mob = require('mobdebug')
        debugger.running = true
        debugger.mob.on()
    end
end

debugger.off = function ()
    if debugging() then
        debugger.mob = require('mobdebug')
        debugger.running = true
        debugger.mob.off()
    end
end

debugger.getinfo = function (...)
    return lua.debug.getinfo(...)
end

if arg[#arg] == '-debug' then
    debugger.start()
end

function pause()
    debugger.start()
    debugger.mob.pause()
end

function debugging()
    local f, mask, count = debug.gethook()
    return debugger.running or looping or f
end

function __FILE__(level) return lua.debug.getinfo(level or 1, 'S').short_src end
function __LINE__(level) return lua.debug.getinfo(level or 1, 'l').currentline end
function __FUNC__(level) return lua.debug.getinfo(level or 1).name end

function getFileLocation(msg, level)
    level = 3 + (level or 1)

    if __FUNC__(level) then
        msg = msg and tostring(msg) or ''

        local file = __FILE__(level) or ''
        local line = __LINE__(level) or ''

        return file..':'..line
    end
end

function getFunctionLocation(msg, level)
    level = level or 0

    local fileLocation = getFileLocation(msg, level + 2)
    if fileLocation then
        msg = msg and tostring(msg) or ''

        local func = __FUNC__(level + 4) or ''

        return fileLocation..': '..msg..' '..func
    end
end
