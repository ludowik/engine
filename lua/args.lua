class('args')

function args:init(...)
    self.args = {...}
end

function args:get(...)
    local parameters = {}

    for _,paramType in ipairs({...}) do
        if typeof(self.args[1]) == paramType[1] then
            table.insert(parameters, self.args[1])
            table.remove(self.args, 1)
        else
            table.insert(parameters, paramType[2])
        end
    end

    table.insert(parameters, self.args)

    return unpack(parameters)
end
