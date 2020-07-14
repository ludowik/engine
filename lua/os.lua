function getOS()    
    local name = ''
    
    if love then
        name = love.system.getOS()
        
    elseif jit then
        name = jit.os
        
    else
        name = os.getenv("HOME") and os.getenv("HOME"):sub(1, 1) == '/' and 'osx' or 'windows'
    end
    
    name = name:lower():gsub(' ', '')
    
    return name
end

os.name = getOS()

osx = os.name == 'osx'
windows = os.name == 'windows'
unix = os.name == 'unix'
