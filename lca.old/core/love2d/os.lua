function getOS()
    local os = ''
    
    if love then
        os = love.system.getOS()
    elseif jit then
        os = jit.os
    end
    
    os = os:lower(os):gsub(' ', '')
    
    return os
end
