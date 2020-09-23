--- calc

Calc = class('calc')

function Calc:init()
    self:ac()
end

function Calc:ac()
    self.acc1 = 0
    self.acc2 = 0

    self.accOperator = ''

    self.intPart = 0
end

function Calc:number(number)
    if type(number) == 'string' then
        for v in number:gmatch('.') do
            self:number(tonumber(v))
        end
    end

    if self.intPart == 0 then
        self.acc1 = self.acc1 * 10 + number
    else
        self.acc1 = self.acc1 + number * self.intPart
        self.intPart = self.intPart * 0.1
    end
end

function Calc:decimal()
    self.intPart = 0.1
end

function Calc:sign()
    self.acc1 = -self.acc1
end

function Calc:operator(operator)
    self.intPart = 0

    if self.accOperator == '' then
        self.acc2 = self.acc1
    elseif self.accOperator == '+' then
        self.acc2 = self.acc2 + self.acc1
    elseif self.accOperator == '-' then
        self.acc2 = self.acc2 - self.acc1
    elseif self.accOperator == 'X' then
        self.acc2 = self.acc2 * self.acc1
    elseif self.accOperator == '/' then
        self.acc2 = self.acc2 / self.acc1
    elseif self.accOperator == '=' then
    end

    if operator == '=' then
        self.accOperator = operator
        self.acc2 = self.acc1
        self.acc1 = 0
    else
        self.accOperator = operator
        self.acc1 = 0
    end
end

function Calc:test()
    local calc = Calc()

    calc:ac()    
    lib:assert('reset', calc.acc1 == 0)

    calc:number(1)
    calc:number(2)
    calc:number(3)
    lib:assert('123', calc.acc1 == 123)

    calc:operator('+')
    calc:number(1)
    calc:number(2)
    calc:number(3)
    calc:operator('=')
    lib:assert('246', calc.acc2 == 246)

    calc:operator('/')
    calc:number('123')
    calc:operator('=')
    lib:assert('2', calc.acc2 == 2)
end
