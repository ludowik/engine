class('GridSudoku', Grid)

function GridSudoku:init()
    Grid.init(self, 9, 9)
end

function GridSudoku:clear()
    Grid.clear(self)
    self.resolvedNotified = false
end

function GridSudoku:newCell(i, j, value)
    local cell = Grid.newCell(self, i, j, value)
    cell.numbers = {}
    return cell
end

function GridSudoku:next()
    GridSudoku.current = GridSudoku.current + 1
    if GridSudoku.current > #GridSudoku.grids then
        GridSudoku.current = 1
    end

    self:loadFromString(GridSudoku.grids[GridSudoku.current])
    self:save()

    self.resolvedNotified = false
end

function GridSudoku:loadFromString(str)
    local index = 1
    for i = 1, self.w do
        for j = 1, self.h do
            local value = tonumber(str:mid(index, 1))
            if value >= 1 and value <= 9 then
                self:set(i, j, value)
            else
                self:set(i, j, nil)
            end

            index = index + 1
        end
    end
end

function GridSudoku:first()
    GridSudoku.current = 0
    self:next()
end

function GridSudoku:for_cells(f)
    local all = true

    local one = false

    for i = 1, self.w do
        for j = 1, self.h do
            local result = f(self, i, j)
            all = all and result
            one = one or result
        end
    end

    return all, one
end

function GridSudoku:help()
end

function GridSudoku:resolve()
    local resolve_cell = false

    self:clear()

    repeat
        resolve_cell = false

        self:check_grid()

        self:for_cells(function (self, i, j)
                local cell = self:cell(i, j)
                local only_one_candidate, value = self:check_cell_1candidate(i, j)
                if only_one_candidate and cell.system == false and cell.value == nil then
                    self:set(i, j, value, false)
                    self:check_grid()

                    resolve_cell = true
                end
            end)
    until not resolve_cell

    self:check_grid()
    self:save()

    return self:resolved()
end

function GridSudoku:resolved()
    return self:for_cells(function (self, i, j)
            local cell = self:cell(i, j)
            local only_one_candidate, value = self:check_cell_1candidate(i, j)

            if not only_one_candidate or value ~= cell.value then
                return false
            end

            return true
        end)
end

function GridSudoku:check_grid()
    self.numbersCount = {}
    for i = 1, self.w do
        self.numbersCount[i] = 0
    end

    self:for_cells(self.check_cell)
end

function GridSudoku:check_cell(i, j)
    local current_cell = self:cell(i, j)

    local numbers = current_cell.numbers

    if current_cell.value and current_cell.value > 0 and current_cell.value <= self.w then
        self.numbersCount[current_cell.value] = self.numbersCount[current_cell.value] + 1
    end

    if current_cell.value and current_cell.system == true then
        numbers[current_cell.value] = true
        return
    end

    for i = 1, self.w do
        numbers[i] = true
    end

    -- dans la ligne
    for i = 1, self.w do
        local cell = self:cell(i, j)
        if cell ~= current_cell and cell.value then
            numbers[cell.value] = nil
        end
    end

    -- dans la colonne
    for j = 1, self.h do
        local cell = self:cell(i, j)
        if cell ~= current_cell and cell.value then
            numbers[cell.value] = nil
        end
    end

    -- dans le bloc
    local ib = math.modf( (i - 1) / self.w ) * self.w + 1
    local jb = math.modf( (j - 1) / self.h ) * self.h + 1

    for i = ib, ib+(self.w-1) do
        for j = jb, jb+(self.h-1) do
            local cell = self:cell(i, j)
            if cell ~= current_cell and cell.value then
                numbers[cell.value] = nil
            end
        end
    end

    return #numbers
end

function GridSudoku:check_cell_1candidate(i, j)
    local numbers = self:cell(i, j).numbers

    local only_one_candidate = false
    local value = nil

    for i = 1, self.w do
        if numbers[i] then
            if only_one_candidate then
                return false, nil
            end
            only_one_candidate = true
            value = i
        end
    end

    return only_one_candidate, value
end

function GridSudoku:check_cell_candidates(i, j)
    if table.maxn(self:cell(i, j).numbers) > 0 then
        return true
    end
    return false
end

function GridSudoku:generate()
    self:clear()
    self:check_grid()

    for k = 1, self.w * self.h * self.w * self.h do
        local i = math.random(1, self.w)
        local j = math.random(1, self.h)

        local cell = self:cell(i, j)

        if cell.value == nil then

            local value = math.random(1, self.w)

            if cell.numbers[value] then
                self:set(i, j, value, true)
                self:check_grid()

                if self:for_cells(GridSudoku.check_cell_candidates) == false then
                    self:set(i, j, nil, false)
                    self:check_grid()
                end
            else
                for value = 1, self.w do
                    if cell.numbers[value] then
                        self:set(i, j, value, true)
                        self:check_grid()

                        if self:for_cells(GridSudoku.check_cell_candidates) == false then
                            self:set(i, j, nil, false)
                            self:check_grid()
                        end
                    end
                end
            end
        end
    end

    self:save()
end

GridSudoku.current = 1
GridSudoku.grids = {
    -- Facile
    "005107600".."040050090".."600090003".."500010008".."089374510".."000980007".."008030002".."030060040".."900002300",
    "000020000".."032050980".."600431005".."500060007".."900104006".."800509001".."700302008".."060090010".."005706400",
    "000419000".."003000200".."581720090".."602030040".."809040100".."174250600".."700090020".."300080007".."096300005",
    "005719800".."010030040".."802040700".."500407008".."046381920".."000265000".."000953000".."000178000".."008020100",
    "000008300".."001345600".."030000040".."306109407".."405607103".."100000009".."708903204".."902504801".."503800006",
    "000000000".."048719320".."003654190".."000576980".."000083460".."386402570".."017300640".."004800010".."000900000",
    "082401930".."400030008".."100000004".."905000802".."700102009".."030070060".."004000100".."000706000".."000050000",
    "000284000".."004000700".."060000090".."273819645".."000706000".."009040200".."006901500".."001030970".."000562008",
    "520070000".."870023000".."000450900".."007030010".."053281796".."000040000".."932864571".."040000060".."006597200",
    "000306000".."700040008".."200000009".."507412603".."600050001".."194060582".."305020806".."406030907".."908070205",
    "093060002".."085040003".."076080005".."900801060".."300200100".."700600300".."500300700".."800400200".."634708950",
    "500080009".."000105000".."003000400".."040672010".."207000905".."060903070".."006040300".."000509000".."300020007",
    "000098000".."896000200".."173000480".."460000370".."718365924".."900000001".."300000002".."241537896".."059002700",
    "000000000".."049357610".."603482507".."090000050".."050743080".."080295070".."060578020".."070000060".."035126740",
    "001000000".."070500000".."389100000".."007800005".."032754819".."800000204".."500421007".."700000003".."028375640",
    "006318900".."030000020".."800902003".."300020005".."600040009".."702000408".."060195080".."004000100".."000674000",
    -- Ing
    "100000067".."200054000".."003000008".."000405600".."081000040".."000607000".."005002700".."000090580".."600000009",
    "040600020".."900300050".."100700040".."008020400".."003000900".."005080600".."050009007".."060004008".."020001030",
    "700000620".."080090000".."056000790".."000000500".."100700200".."040001000".."028500000".."001040000".."007030900",
    -- Moyen
    "028600000".."070082040".."006194070".."030006905".."160000037".."205700060".."090847200".."080320090".."000005380",
    -- Difficile
    "219305700".."040000000".."806700020".."000072030".."060000070".."020410000".."070006203".."000000090".."001504687",
    "000400000".."800020090".."047080601".."370000142".."000102000".."612000035".."704060210".."090010008".."000004000",
    "000000000".."000000000".."000000000".."000000000".."000000000".."000000000".."000000000".."000000000".."000000000"
}
