if arg[#arg] == "-debug" then
    require("mobdebug").start()
    debugging = true
end

function pause()
    require("mobdebug").start()
    require("mobdebug").pause()
end

function __FILE__(level) return lua.debug.getinfo(level or 1, 'S').short_src end
function __LINE__(level) return lua.debug.getinfo(level or 1, 'l').currentline end
function __FUNC__(level) return lua.debug.getinfo(level or 1).name end

function getFileLocation(msg, level)
    level = 3 + (level or 1)

    if lua.debug.getinfo and lua.debug.getinfo(level) then
        msg = tostring(msg) or ''

        local file = __FILE__(level) or ''
        local line = __LINE__(level) or ''

        return file..':'..line
    end
end

function getFunctionLocation(msg, level)
    local fileLocation = getFileLocation(msg, level or 2)

    if fileLocation then
        msg = tostring(msg) or ''

        local func = __FUNC__(level or 4) or ''

        return fileLocation..': '..msg..' '..func
    end
end
