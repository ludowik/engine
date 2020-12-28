function theme(theme)
    resetStyle()
    
    if theme == "bot" then
        stroke(75, 113, 198, 255)
        strokeWidth(2)   
        fill(119, 192, 96, 255)
        
    elseif theme == "area" then
        fill(61, 255, 0, 131)    
        
    elseif theme == "way" then
        stroke(75, 113, 198, 255)
        strokeWidth(1)
        
    elseif theme == "wayPath" then
        stroke(198, 75, 74, 255)
        strokeWidth(3)
        
    else assert() end
end
