-- Touch

KEY_FOR_MOUSE_MOVING = 'lshift'

DIR_NONE   = 0
DIR_LEFT   = 1
DIR_RIGHT  = 2
DIR_TOP    = 4
DIR_BOTTOM = 8

DIR_WEST  = DIR_LEFT
DIR_EAST  = DIR_RIGHT
DIR_NORTH = DIR_TOP
DIR_SOUTH = DIR_BOTTOM

DIR_NE = DIR_NORTH + DIR_EAST
DIR_NW = DIR_NORTH + DIR_WEST
DIR_SE = DIR_SOUTH + DIR_EAST
DIR_SW = DIR_SOUTH + DIR_WEST

DIR_UNKNOWN = 99

function ratio(a)
    return cos(90-a) / cos(a)
end

function isDownDirection(direction)
    if CurrentTouch.state == BEGAN or CurrentTouch.state == MOVING then
        if direction == 'up' and CurrentTouch.x > WIDTH/2 then
            return true
        elseif direction == 'down' and CurrentTouch.x <= WIDTH/2 then
            return true
        end
    end
    return false
end

function touchDirection(touch)
    local x = touch.totalX
    local y = touch.totalY
    
    if abs(x) < 10 and abs(y) < 10 then
        return DIR_NONE
    end

    if x == 0 then
        if y < 0 then
            return DIR_SOUTH
        else
            return DIR_NORTH
        end
    end

    if y == 0 then
        if x < 0 then
            return DIR_WEST
        else
            return DIR_EAST
        end
    end

    if abs(x) > abs(y) then
        if x > 0 then
            local r = abs(x/y)
            if r > ratio(67.5) then
                return DIR_EAST,DIR_EAST
            else
                if y < 0 then
                    return DIR_EAST,DIR_SE
                else
                    return DIR_EAST,DIR_NE
                end
            end
        else
            local r = abs(x/y)
            if r > ratio(67.5) then
                return DIR_WEST,DIR_WEST
            else
                if y < 0 then
                    return DIR_WEST,DIR_SW
                else
                    return DIR_WEST,DIR_NW
                end
            end
        end
    else
        if y < 0 then
            local r = abs(y/x)
            if r > ratio(67.5) then
                return DIR_SOUTH,DIR_SOUTH
            else
                if x > 0 then
                    return DIR_SOUTH,DIR_SE
                else
                    return DIR_SOUTH,DIR_SW
                end
            end
        else
            local r = abs(y/x)
            if r > ratio(67.5) then
                return DIR_NORTH,DIR_NORTH
            else
                if x > 0 then
                    return DIR_NORTH,DIR_NE
                else
                    return DIR_NORTH,DIR_NW
                end
            end
        end
    end

    return DIR_UNKNOWN
end
