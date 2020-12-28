function setupTouch()
    onTouch = {
        [BEGAN] = touchedBegan,
        [MOVING] = touchedMoving,
        [ENDED] = touchedEnded,
        [CANCELLED] = touchedCancelled
    }
end

function touched(touch)
    onTouch[touch.state](touch)
end

function touchedBegan(touch)
    touchedMoving(touch)
end

function touchedMoving(touch)
    touchs[touch.id] = touchs[touch.id] or Table()
    
    local v = vec2(touch.x, touch.y)
    touchs[touch.id]:insert(v)
end

function touchedEnded(touch)
    touchedMoving(touch)
    if addWayOrArea then
        addWay(touchs[touch.id])
    else
        addArea(touchs[touch.id])
    end
    touchs[touch.id] = nil
    
--    save()
end

function touchedCancelled(touch)
    touchs[touch.id] = nil
end

function addWay(touchs)
    local n = #touchs
    if n >= 3 then
        ways:insert(Way(touchs))
    end
end

function addArea(touchs)
    local n = #touchs   
    if n >= 2 then
        local f = touchs:first()
        local t = touchs:last()
        areas:insert(Area(f.x, f.y, t.x-f.x, t.y-f.y, vec2()))
    end
end
