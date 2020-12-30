-- console

-- TODO or TODEL

Console = Class('Console', Object)

Console.ALPHA_VALUE = 255
Console.ALPHA_SPEED = 64

function Console:init(title, left)
    public(self, Object)
    
    self.logs = Table()
    
    self.left = left
    
    self.autoScroll = true
    
    self.alpha = Console.ALPHA_VALUE
    self.alphaSpeed = Console.ALPHA_SPEED
                
    self.dy = 0
end

function Console:clear()
    self.logs = Table()
    output.clear()
end

function Console:update(deltaTime)
    self.alpha = component(self.alpha - self.alphaSpeed * deltaTime)
end

function Console:draw()
    local x = 0
    local y = 0
    
    local ws = ws()
    
    resetMatrix()
                    
    rectMode(CORNER)
    
    self.htot = 0   
    self.logs:forEach(function (str, i)
        split(str, NL):forEach(function (str, i)            
            local w, h = textSize(str)   
            local x = self.left and 0 or ( ws - w )
            
            fill(alpha(white, self.alpha))
            text(str, x, y)
            
            y = y + h
            self.htot = self.htot + h
        end)
    end)
        
    if self.autoScroll then
        if self.htot >= hs() then
            self.dy = self.htot - hs()
        end
    end
end

function Console:toggleShow()
    if self.alphaSpeed > 0 then
        self.alpha = Console.ALPHA_VALUE
        self.alphaSpeed = 0
    else
        self.alphaSpeed = Console.ALPHA_SPEED
    end
end

function consoleInit()
    local function print(...)
        local s = ''
        table.forEach({...}, function (var, i)
            s = s .. print_param(var) .. ' '
        end)
        Console.print.logs:add(s)
    end
    
    local function printv(o, k)
        print(k.." = "..tostring(o[k]))
    end
    
    function log_item(var, i)
        Console.log.logs:add(print_param(var))
        Console.log.autoScroll = true
        Console.log.alpha = Console.ALPHA_VALUE
    end
    
    local function log(...)
        table.forEach({...}, log_item)
    end
    
    local function logv(o, k)
        log(k.." = "..tostring(o[k]))
    end
    
    local function print_param(var)
        local varType = type(var)
        
        local s = ''
        if varType == 'boolean' then
            s = s..(var and 'true' or 'false')
        else
            s = s..tostring(var)
        end
        
        return s
    end
    
    Console.print = Console('print', true)
    Console.log = Console('log', false)
end