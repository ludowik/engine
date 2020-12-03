function getOS()
    local name = ''

    if love then
        name = love.system.getOS():lower():gsub(' ', '')

    elseif jit then
        name = jit.os

    else
        local env = os.getenv('HOME')
        if env then
            if env:sub(1, 1) == '/' then
                if env:find('mobile') then
                    name = 'ios'
                else
                    name = 'osx'
                end
            else
                name = 'windows'
            end
        else
            warning('unknown OS')
        end
    end

    name = name:lower():gsub(' ', '')

    return name
end

function initOS(name)
    os.name = name or os.name or getOS()

    osx = os.name == 'osx'
    ios = os.name == 'ios'
    windows = os.name == 'windows'
    unix = os.name == 'unix'
end

initOS()
