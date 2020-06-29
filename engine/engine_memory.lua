class 'Memory' : extends(Component)

function Memory:setup()
    Component.init(self)

    self.ram = {
        init = ram()
    }

    self.ram.current = self.ram.init
    self.ram.min = self.ram.init
    self.ram.max = self.ram.init
    self.ram.release = self.ram.init
end

function Memory:update(dt)
    self.ram.current = ram()

    self.ram.min = math.min(self.ram.min, self.ram.current)
    self.ram.max = math.max(self.ram.max, self.ram.current)
end

function Memory:release()
    self.ram.release = ram()

    log('memory at init    : '..format_ram(self.ram.init))
    log('memory min        : '..format_ram(self.ram.min))
    log('memory max        : '..format_ram(self.ram.max))
    log('memory variation  : '..format_ram(self.ram.max - self.ram.min))
    log('memory at release : '..format_ram(self.ram.release))
end
