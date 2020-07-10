function getOS()
    local os = ''
    
    if love then
        os = love.system.getOS()
    elseif jit then
        os = jit.os
    else
        os = 'osx'
    end
    
    os = os:lower(os):gsub(' ', '')
    
    return os
end

osx = getOS() == 'osx'
windows = getOS() == 'windows'
