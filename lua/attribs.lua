class 'Attribs'

function Attribs:init()
end

function Attribs:attribs(args)
    if args == nil then return end

    for k,v in pairs(args) do
        self[k] = v
    end
    return self
end
