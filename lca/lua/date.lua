date = class('Date')

function Date:init()
    self:attribs(os.date('*t'))
end

function Date:__tostring()
    return self.day..'/'..self.month..'/'..self.year
end
