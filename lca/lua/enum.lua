class('Enum', Attribs)

function Enum:next(value)
    return table.next(self.constants, value)
end

function enum(enumType)
    local enumInstance = class(enumType, Enum)
    return function (constants)
        enumInstance.constants = constants        
        Attribs.attribs(_G, constants)
    end
end

enum 'Wireframe' {
    'fill',
    'line',
    'fill&line'
}
