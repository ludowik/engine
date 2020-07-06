function __FILE__(level) return debug.getinfo(level or 1, 'S').short_src end
function __LINE__(level) return debug.getinfo(level or 1, 'l').currentline end
function __FUNC__(level) return debug.getinfo(level or 1).name end

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
