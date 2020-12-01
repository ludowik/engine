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
            node.fixedSize.y,
            0)

    elseif node.gridSize then
        node.size:set(
            ws(node.gridSize.x),
            hs(node.gridSize.y),
            0)
    end
end

function Layout:layout(mode, n)
    local outerMarge = self.outerMarge or Layout.outerMarge
    local innerMarge = self.innerMarge or Layout.innerMarge

    local position = vec2(outerMarge, outerMarge)
    local size = vec2()

    self.rowSize = self.rowSize or {}
    self.colSize = self.colSize or {}
    
    self.nodeSize = self.nodeSize or vec2()

    local i, j = 1, 1
    for index=1,#self.nodes do
        local node = self.nodes[index]
        
        node.position.x = position.x
        node.position.y = position.y

        Layout.computeNodeSize(self, node)

        self.colSize[i] = self.colSize[i] or vec2()
        self.rowSize[j] = self.rowSize[j] or vec2()
        
        self.colSize[i].x = max(self.colSize[i].x, node.size.x)
        self.colSize[i].y = max(self.colSize[i].y, node.size.y)

        self.rowSize[j].x = max(self.rowSize[j].x, node.size.x)
        self.rowSize[j].y = max(self.rowSize[j].y, node.size.y)
        
        self.nodeSize.x = max(self.nodeSize.x, node.size.x)
        self.nodeSize.y = max(self.nodeSize.y, node.size.y)

        if mode == 'row' then
            position.x = position.x + node.size.x + innerMarge
            i = i + 1

        elseif mode == 'column' then
            position.y = position.y + node.size.y + innerMarge
            j =j + 1

        elseif mode == 'grid' then
            node.size.x = self.nodeSize.x
            if i == n then
                position.x = outerMarge
                i = 1

                position.y = (position.y +
                    self.nodeSize.y +
                    innerMarge)
                j = j + 1

            else
                position.x = (position.x +
                    node.size.x +
                    innerMarge)
                i = i + 1
            end
        end
        
        size.x = max(size.x, node.position.x + node.size.x + outerMarge)
        size.y = max(size.y, node.position.y + node.size.y + outerMarge)
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
    local h = self.parent == nil and screen.H or self.parent.size.y
    self.position.y = h - self.position.y - self.size.y
    self.absolutePosition.y = screen.H - self.absolutePosition.y - self.size.y

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
    local w = self.parent == nil and screen.W  or self.parent.size.x
    local h = self.parent == nil and screen.H or self.parent.size.y

    local alignments = self.alignment:split(',')
    if alignments:findItem('center') or alignments:findItem('h-center') then
        self.position.x = self.position.x + (w - self.size.x) / 2
    end

    if alignments:findItem('center') or alignments:findItem('v-center') then
        self.position.y = self.position.y + (h - self.size.y) / 2
    end
end
