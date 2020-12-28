function setFont()
    ft:setFont()
end

function getFont()
    return ft:getFont() or setFont()
end
