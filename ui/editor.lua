class('Editor', UI)

function Editor:init()
    UI.init(self)
end

function Editor:touched(touch)
    self.focus = not self.focus
    
    if self.focus then
        showKeyboard()
    else
        hideKeyboard()
    end
end

function Editor:keypressed(key)
    self.label = self.label or ''

    if key == 'space' then
        self.label = self.label..' '

    elseif key == 'backspace' then
        if #self.label > 0 then
            self.label = self.label:left(#self.label-1)
        end

    else
        self.label = self.label..key
    end
end
