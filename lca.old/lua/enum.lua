function enum(enumType)
    local enumInstance = class(enumType, Attribs)
    return function (constants)
        enumInstance:attribs(constants)
        Attribs.attribs(_G, constants)
    end
end
