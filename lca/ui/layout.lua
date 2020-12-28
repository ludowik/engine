class('Layout')

function Layout.setup()
    Layout.outerMarge = 5
    Layout.innerMarge = 2
end

function Layout:computeNodeSize(node)
    node:computeSize()

    if node.fixedSize then
        node.size:set(
            node.fixedSize.x,
            node.fixedSize.y)
        
    elseif node.gridSize then
        node.size:set(
            ws(node.gridSize.x),
            hs(node.gridSize.y))
    end
end

function Layout:layout(mode, n)
    local outerMarge = self.outerMarge or Layout.outerMarge
    local innerMarge = self.innerMarge or Layout.innerMarge
    
    local position = vec2(outerMarge, outerMarge)
    local size = vec2()

    self.rowSize = self.rowSize or {}
    self.colSize = self.colSize or {}

    local i, j = 1, 1
    for index=1,#self.nodes do
        local node = self.nodes[index]
        node.position.x = position.x
        node.position.y = position.y

        Layout.computeNodeSize(self, node)

        size.x = max(size.x, position.x + node.size.x + outerMarge)
        size.y = max(size.y, position.y + node.size.y + outerMarge)

        if mode == 'row' then
            position.x = position.x + node.size.x + innerMarge

        elseif mode == 'column' then
            position.y = position.y + node.size.y + innerMarge

        elseif mode == 'grid' then
            self.colSize[i] = self.colSize[i] or vec2()
            self.colSize[i].x = max(self.colSize[i].x, node.size.x)

            self.rowSize[j] = self.rowSize[j] or vec2()
            self.rowSize[j].y = max(self.rowSize[j].y, node.size.y)

            if i == n then
                position.x = outerMarge
                i = 1

                position.y = (position.y +
                    max(node.size.y, self.colSize[i].y) +
                    innerMarge)

                j = j + 1
            else
                position.x = (position.x +
                    max(node.size.x, self.colSize[i].x) +
                    innerMarge)

                i = i + 1
            end            
        end
    end
    
    self.size = size
end

function Layout:row()
    return Layout.layout(self, 'row')
end

function Layout:column()
    return Layout.layout(self, 'column')
end

function Layout:grid(n)
    return Layout.layout(self, 'grid', n or self.n)
end

function Layout:reverse()
    local h = self.parent == nil and H or self.parent.size.y
    self.position.y = h - self.position.y - self.size.y
    self.absolutePosition.y = H - self.absolutePosition.y - self.size.y

    if self.nodes and self.layoutFlow then
        for i,v in ipairs(self.nodes) do
            Layout.reverse(v)
        end
    end
end

function Layout:computeAbsolutePosition(x, y)
    x = x or self.position.x
    y = y or self.position.y

    self.absolutePosition.x = x
    self.absolutePosition.y = y

    if self.translation then
        self.absolutePosition.x = self.absolutePosition.x + self.translation.x
        self.absolutePosition.y = self.absolutePosition.y + self.translation.y
    end

    if self.nodes and self.layoutFlow then
        for i,v in ipairs(self.nodes) do
            if v.position then
                Layout.computeAbsolutePosition(v,
                    x + v.position.x,
                    y + v.position.y)
            end
        end
    end
end

function Layout:align()
    local w = self.parent == nil and WIDTH  or self.parent.size.x
    local h = self.parent == nil and HEIGHT or self.parent.size.y

    local alignments = self.alignment:split(',')
    if alignments:findItem('center') or alignments:findItem('h-center') then
        self.position.x = self.position.x + (w - self.size.x) / 2
    end

    if alignments:findItem('v-center') then
        self.position.y = self.position.y + (h - self.size.y) / 2
    end
end
