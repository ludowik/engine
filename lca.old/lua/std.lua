lua = {}

local function references()
    for k,v in pairs(_G) do
        lua[k] = v
    end
end

references()
