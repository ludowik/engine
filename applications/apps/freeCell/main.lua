App('AppFreeCell')

function AppFreeCell.setup()
    SPADE   = 1 -- PIQUE
    HEART   = 2 -- COEUR
    DIAMOND = 3 -- CARREAU
    CLUB    = 4 -- TREFLE

    suitLabels = {}
    suitLabels[SPADE]   = 'PIQUE'
    suitLabels[HEART]   = 'COEUR'
    suitLabels[DIAMOND] = 'CARREAU'
    suitLabels[CLUB]    = 'TREFLE'

    suitColor = {}
    suitColor[SPADE]   = black
    suitColor[HEART]   = red
    suitColor[DIAMOND] = red
    suitColor[CLUB]    = black

    values = {
        'A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'V', 'Q', 'K'
    }

    local ratio
    if WIDTH > HEIGHT then
        ratio = 1
    else
        ratio = 1.4
    end

    CARD_WIDTH  = floor(ws(1)*ratio)
    CARD_HEIGHT = floor(ws(1.52)*ratio)

    DESK_MARGE = floor(ws(0.1))
    CARD_MARGE = floor(hs(0.5))
end

function AppFreeCell:init()
    Application.init(self)

    self.clrBkg = green

    self:createSuits()

    self.lists = Piles(Pile, 8, 0, DESK_MARGE*2)
    self.temps = Piles(Temp, 4)
    self.suits = Piles(Suit, 4)
    self.moves = Piles(Pile, 1)

    self.usable_desks = {
        self.lists,
        self.temps,
        self.suits
    }

    self.coroutine = coroutine.create(function (dt)
            self:distrib()
        end)
end

function AppFreeCell:createSuits()
    self.deck = Pile(900, 100)

    function createSuit(suit)
        for i = 1, #values do
            self.deck:add(Card(i, suit))
        end
    end

    createSuit(SPADE)
    createSuit(HEART)
    createSuit(DIAMOND)
    createSuit(CLUB)

    self.deck:mix()
end

function AppFreeCell:draw()
    background(51)

    self.deck:draw()

    self.temps:forEach(function (v, i)
            v:draw(i*(CARD_WIDTH+DESK_MARGE), CARD_MARGE)
        end)

    self.suits:forEach(function (v, i)
            v:draw((i+3)*(CARD_WIDTH+DESK_MARGE), CARD_MARGE)
        end)

    self.lists:forEach(function (v, i)
            v:draw((i-1)*(CARD_WIDTH+DESK_MARGE), hs(3))
        end)

    self.moves:forEach(function (v)
            v:draw()
        end)
end

function AppFreeCell:touchedAddDelta(o, t)
    o.x = o.x + t.deltaX
    o.y = o.y + t.deltaY
end

function AppFreeCell:touchDesk(touch)
    for _, desks in ipairs(self.usable_desks) do
        for _, desk in ipairs(desks) do
            if desk:contains(touch) then
                return desk
            end
        end
    end

    if self.deck:contains(touch) then
        return self.deck
    end
end

function AppFreeCell:move(from, to)
    local i,card = to:canCardsMoveTo(from)
    if i ~= nil then
        from:remove(i)

        self.moves:add(card)

        function endMove(card, to)
            self.moves:removeItem(card)
            to:add(card)
        end

        local x = to.nodes:last() and to.nodes:last().x or to.x
        local y = to.nodes:last() and to.nodes:last().y or to.y

        tween(0.5, card, {
                x = x,
                y = y
                }, tween.easing.sine, endMove, card, to)
    end
end

function AppFreeCell:resetFocus()
    self.deskFrom.focus = false
    self.deskFrom = nil
    self.deskTo = nil
end

function AppFreeCell:touched(touch)
    if touch.state == ENDED then
        if not self.deskFrom then
            self.deskFrom = self:touchDesk(touch)
            if self.deskFrom then
                self.deskFrom.focus = true
            end
        else
            self.deskTo = self:touchDesk(touch)
            if self.deskTo == self.deskFrom or self.deskTo == nil then
                self:resetFocus()
                return
            end
        end

        if self.deskFrom and self.deskTo then
            self:move(self.deskFrom, self.deskTo)
            self:resetFocus()
        end
    end
end

function AppFreeCell:distrib()
    local p = 0
    for i = 1, #self.deck.nodes do
        self.lists:get(p+1):add(self.deck.nodes:pop())
        p = (p+1) % #self.lists
        if self.coroutine then
            coroutine.yield()
        end
    end
end

class('Card', Object)

function Card:init(value, suit)
    Object.init(self)

    local w = CARD_WIDTH
    local h = CARD_HEIGHT

    self.size = vec2(w, h)

    self.value = value
    self.suit = suit
end

function Card:draw()
    if false then
        self:makeImage(self.position.x, self.position.y)
    else
        if not self.sprite then
            self.sprite = image(self.size.x, self.size.y)

            setContext(self.sprite)
            self:makeImage(0, 0)
            setContext()
        end

        spriteMode(CORNER)
        sprite(self.sprite, self.position.x, self.position.y)
    end
end

function Card:makeImage(x, y)
    style(s1, red, white)

    rectMode(CORNER)
    rect(
        x,
        y,
        self.size.x,
        self.size.y)

    local val = values[self.value]
    local clr = suitColor[self.suit]

    textStyle(s16, clr, CENTER)
    text(val, self:x1()-x+s20/2, self:y1()-y+s20/2)
    text(val, self:x2()-x-s20/2, self:y2()-y-s20/2)

--    textStyle(s10, clr, CENTER)
--    text(suitLabels[self.suit],
--        self:xc()-x,
--        self:yc()-y)

    spriteMode(CENTER)
    sprite('cards:'..suitLabels[self.suit],
        self:xc()-x,
        self:yc()-y, 25, 25)
end

class('Pile', Scene)

function Pile:init(x, y, dx, dy)
    Scene.init(self)

    self.dx = dx or 0
    self.dy = dy or 0
end

function Pile:mix()
    for i = 1, randomInt(200,300) do
        local j = randomInt(1, #self.nodes)
        local k = randomInt(1, #self.nodes)

        self.nodes[j], self.nodes[k] = self.nodes[k], self.nodes[j]
    end
end

function Pile:draw(x, y)
    local dx = 0
    local dy = 0

    if x then
        self.position.x = x
        self.position.y = y
    end

    self.size.x = CARD_WIDTH
    self.size.y = CARD_HEIGHT

    self.nodes:forEach(function (card)
            card.position.x = self.position.x + dx
            card.position.y = self.position.y + dy

            dx = dx + self.dx
            dy = dy + self.dy

            card:draw()

            self.size.x = card:x2() - self:x1()
            self.size.y = card:y2() - self:y1()
        end)

    if self.focus then
        local last = self.nodes:last()
        stroke(green)
        rectMode(CORNER)
        rect(last.position.x, last.position.y, CARD_WIDTH, CARD_HEIGHT)
    end

    style(self.focus and s2 or s1,
        self.focus and red or blue,
        transparent)

    rectMode(CORNER)
    rect(self.position.x, self.position.y, self.size.x, self.size.y)
end

function Pile:touchCard(touch)
    for i,card in ipairs(self.nodes) do
        if card:contains(touch) then
            return card
        end
    end
end

function Pile:canCardsMoveTo(from)
    for i,card in ipairs(from.nodes) do
        local res = self:canCardMoveTo(card)
        if res == true then
            return i,card
        end
    end
end

function Pile:canCardMoveTo(fromCard)
    if #self.nodes == 0 then
        return true
    else
        local toCard = self.nodes:last()
        if toCard.value == fromCard.value + 1 and suitColor[toCard.suit] ~= suitColor[fromCard.suit] then
            return true
        end
    end
    return false
end

class('Temp', Pile)

function Temp:init()
    Pile.init(self)
end

function Temp:canCardMoveTo(card)
    if #self.nodes == 0 then
        return true
    end
    return false
end

class('Suit', Temp)

function Suit:init()
    Temp.init(self)
end

function Suit:canCardsMoveTo(from)
    local fromCard = from.nodes:last()
    if fromCard and self:canCardMoveTo(fromCard) then
        return from.nodes:count(),fromCard
    end
end

function Suit:canCardMoveTo(fromCard)
    if #self.nodes == 0 then
        if fromCard.value == 1 then
            return true
        end
    else
        local toCard = self.nodes:last()
        if toCard and toCard.value == fromCard.value - 1 and suitColor[toCard.suit] == suitColor[fromCard.suit] then
            return true
        end
    end
    return false
end

function Piles(constructor, n, dx, dy)
    local lists = Table()
    for i=1,n do
        lists:add(constructor(0, 0, dx, dy))
    end
    return lists
end
