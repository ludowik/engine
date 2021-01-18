class('Dashboard', UI)

function Dashboard:init(array, columnsName, columnsConvert)
    UI.init(self)

    self.array = array

    self.columnsSize = {}
    self.columnsName = columnsName
    self.columnsConvert = columnsConvert or {}

    self.offset = 0
end

function Dashboard:setSortFunction(f)
    self.sortFunction = f
end

function Dashboard:wheelmoved(mouse)
    self.offset = self.offset + mouse.deltaY * 10
end

function Dashboard:draw()
    local w, h = textSize('Dashboard')
    TEXT_NEXT_Y = screen.H - h - self.offset

    font(DEFAULT_FONT_NAME)
    fontSize(10)

    fill(white)

    textMode(CORNER)

    strokeWidth(1)
    stroke(gray)

    local columnsName = self.columnsName
    local columnsSize = self.columnsSize
    local columnsConvert = self.columnsConvert

    local area = Rect(0, 0, screen.W, screen.H)

    if self.sortFunction then
        table.sort(self.array, self.sortFunction)
    end

    local x = self.position.x
    local y = TEXT_NEXT_Y

    function drawCell(columnName, value)
        value = tostring(value)

        local w, h = textSize(value)
        columnsSize[columnName] = max(columnsSize[columnName] or 0, w)

        if area:contains(x, y) then -- and fData.stat.count > 0 then
            line(x, y+h, x+columnsSize[columnName], y+h)
            line(x, y, x, y+h)

            text(value, x+columnsSize[columnName]-w, y)
        else
            TEXT_NEXT_Y = y - h
        end

        x = x + columnsSize[columnName]
    end

    for _,columnName in ipairs(columnsName) do
        local attrPath = columnName:split('.')
        columnName = attrPath[#attrPath]

        drawCell(columnName, columnName)
    end

    for _,object in ipairs(self.array) do
        if attributeof('__bases', object) then
            x = self.position.x
            y = TEXT_NEXT_Y

            if attributeof('focusOn', object) then
                fill(orange)
            else
                fill(white)
            end

            for _,columnName in ipairs(columnsName) do
                local attrPath = columnName:split('.')
                columnName = attrPath[#attrPath]

                local value = object
                for _,v in ipairs(attrPath) do
                    if value == nil then break end
                    value = attributeof(v, value)
--                    if value and type(value) == 'table' and #value > 0 then
--                        value = value[1]
--                    end
                end

                if value then
                    if columnsConvert[columnName] then
                        value = columnsConvert[columnName](value)
                    end

                    if type(value) == 'table' and #value > 0 then
                        for _,info in ipairs(value) do
                            x = columnsSize[columnName]

                            drawCell(columnName, info)
                            y = TEXT_NEXT_Y
                        end

                    elseif columnName == 'callers' then
                        if Profiler.detail and object.callers then
                            local callers = Table()
                            for caller,info in pairs(object.callers) do
                                callers:add(info)
                            end
                            callers:sort(function (a, b)
                                    return a.count > b.count
                                end)

                            for _,info in ipairs(callers) do
                                x = columnsSize['name']
                                y = TEXT_NEXT_Y

                                drawCell('count', info.count)
                                drawCell('caller', info.caller)
                            end
                        end
                    else
                        drawCell(columnName, value)
                    end
                end
            end
        end
    end
end
