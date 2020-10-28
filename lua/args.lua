class 'args'

function args:init(...)
    self.args = {...}
end

function args:get(...)
    local parameters = {}

    for i,paramType in ipairs({...}) do
        if type(self.args[1]) == paramType[1] then
            parameters[i] = self.args[1]
            table.remove(self.args, 1)
        else
            parameters[i] = paramType[2]
        end
    end

    table.insert(parameters, self.args)

    return unpack(parameters)
end
