class 'Memory' : extends(Component)

function Memory:initialize()
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
    gc()
    
    self.ram.release = ram()

    print('memory at start  : '..format_ram(self.ram.init))
    print('memory min       : '..format_ram(self.ram.min))
    print('memory max       : '..format_ram(self.ram.max))
    print('memory variation : '..format_ram(self.ram.max - self.ram.min))
    print('memory at end    : '..format_ram(self.ram.release))
end
