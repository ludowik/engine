do 
    local logs = {}
    
    function log(txt)
        if logs[txt] == nil then
            logs[txt] = 1
            print(txt)
        else
            logs[txt] = logs[txt] + 1
        end
    end
end

function todo(action)
    log(getFunctionLocation(action or 'implement'))
end
