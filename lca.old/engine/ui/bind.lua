class('Bind')

function Bind:init()
end

function Bind:bind(object, attrib, default, callback)
    if object and type(object) == 'table' and attrib and type(attrib) == 'string' then
        self.binding = {
            object = object,
            attrib = attrib,
            default = default or 0,
            callback = callback
        }

    elseif object and type(object) == 'string' then
        if object:find('%.') then
            local words = object:split('.')
            self.binding = {
                object = evalExpression(words[1]),
                attrib = words[2],
                default = attrib or 0,
                callback = default
            }
            
        else
            self.binding = {
                object = _G.currentEnv or _G,
                attrib = object,
                default = attrib or 0,
                callback = default
            }
        end
    end

    if self:getValue() == nil and self.binding then
        self:setValue(self.binding.default)
    end

    return self
end

function Bind:getValue()
    if self.binding then
        return self.binding.object[self.binding.attrib]
    end
end

function Bind:setValue(value)
    if self.binding then
        self.binding.object[self.binding.attrib] = value

        if self.binding.callback then
            self.binding.callback(value)
        end
    end
end
