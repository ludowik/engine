function ram()
    return collectgarbage('count') * 1024
end

function gc()
    collectgarbage('collect')
end

function format_ram(ram)
    return string.format('%.2f mo', ram / 1024 / 1024)
end
