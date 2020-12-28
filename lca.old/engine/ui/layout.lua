class('Layout')

Layout.outerMarge = 6
Layout.innerMarge = 3

function Layout:flow(flow, xParent, yParent, n)
    local maxSize = vec2()

    local outerMarge = self.outerMarge or Layout.outerMarge
    local innerMarge = self.innerMarge or Layout.innerMarge

    if xParent then
        self.position.x = xParent
        if self.verticalDirection == 'up' then
            self.position.y = yParent
        else
            self.position.y = 0
        end
    else
        xParent = self.position.x
        yParent = self.position.y
    end

    local x, y = 0, 0
    x = x + outerMarge
    y = y + outerMarge

    local w, h = outerMarge*2, outerMarge*2
    self.size.x = w
    self.size.y = h

    local marge = innerMarge
    for i,v in ipairs(self.nodes) do
        if v.visible then
            if i == #self then
                marge = 0
            end

            -- layout
            if v.layoutProc then
                v:layoutProc(x, y + v.size.y, v.layoutParam)
            else
                if v.fixedSize then
                    v.size.x = v.fixedSize.x
                    v.size.y = v.fixedSize.y
                else
                    v:computeSize()
                end
            end

            if v.scaling and v.fixedSize == nil then
                v.size.x = v.size.x * v.scaling.x
                v.size.y = v.size.y * v.scaling.y
            end

            -- max size
            maxSize.x = max(maxSize.x, v.size.x)
            maxSize.y = max(maxSize.y, v.size.y)

            -- current position
            v.position.x = x
            v.position.y = y

            -- next position
            if flow == 'row' then

                -- max width
                local wMax = self.fixedSize and self.fixedSize.x or WIDTH

                if (n and i % n == 1) or x + v.size.x + marge >= wMax then
                    -- position
                    x = outerMarge
                    y = y + maxSize.y + marge

                    -- size
                    h = h + maxSize.y + marge
                    maxSize.y = 0
                    w = 0

                    v.position.x = x
                    v.position.y = y
                end

                -- node size
                self.size.x = max(self.size.x, w + v.size.x + marge)

                -- item position
                x = x + v.size.x + marge

                -- item size
                self.size.y = max(self.size.y, h + v.size.y + marge)
                w = w + v.size.x + marge

            elseif flow == 'column' then

                -- max height
                local hMax = self.fixedSize and self.fixedSize.y or HEIGHT

                if (n and i % n == 1) or y + v.size.y + marge >= hMax then
                    -- position
                    x = x + maxSize.x + marge
                    y = outerMarge

                    -- size
                    w = w + maxSize.x + marge
                    maxSize.x = 0
                    h = 0

                    v.position.x = x
                    v.position.y = y
                end

                -- node size
                self.size.y = max(self.size.y, h + v.size.y + marge)

                -- item position
                y = y + v.size.y + marge

                -- item size
                self.size.x = max(self.size.x, w + v.size.x + marge)
                h = h + v.size.y + marge

            else assert(false) end
        end
    end
end

function Layout:row(x, y, n)
    Layout.flow(self, 'row', x, y, n)
end

function Layout:column(x, y, n)
    Layout.flow(self, 'column', x, y, n)
end

function Layout:grid(x, y, n)
    Layout.row(self, x, y, n or self.n)
end

function Layout:grid2(x, y, n)
    Layout.column(self, x, y, n or self.n)
end

function Layout:reverse()
    local WIDTH, HEIGHT = currentDef()
    local h = self.parent == nil and HEIGHT or self.parent.size.y
    self.position.y = h - self.position.y - self.size.y

    if self.nodes and self.layoutProc then
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

    if self.nodes and self.layoutProc then
        for i,v in ipairs(self.nodes) do
            if v.position then
                Layout.computeAbsolutePosition(v,
                    x + v.position.x,
                    y + v.position.y)
            end
        end
    end
end

function Layout:alignment()
    if self.nodes and self.layoutProc then
        for i,v in ipairs(self.nodes) do
            --            Layout.alignmentProc(v)
            --            Layout.alignment(v)
        end
        Layout.alignmentProc(self)
    end
end

function Layout:alignmentProc()
    local WIDTH, HEIGHT = currentDef()
    local w = self.parent == nil and WIDTH  or self.parent.size.x
    local h = self.parent == nil and HEIGHT or self.parent.size.y

    if self.alignment then
        local alignments = self.alignment:split(',')
        if alignments:findItem('right') then
            self.position.x = self.position.x + (w - self.size.x)
            --            for i,v in ipairs(self.nodes) do
            --                v.position.x = v.position.x + (w - self.size.x)
            --            end
        end

        if alignments:findItem('center') or alignments:findItem('h-center') then
            self.position.x = self.position.x + (w - self.size.x) / 2
        end

        if alignments:findItem('v-center') then
            self.position.y = self.position.y + (h - self.size.y) / 2
        end
    end
end
