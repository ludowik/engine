class 'ComponentManager' : extends(Node)

function ComponentManager:init(...)
    Node.init(self, ...)
    
    self.componentsToInitialize = Array()
    self.componentsToUpdate = Array()
end

function ComponentManager:add(component)
    Node.add(self, component)
    
    if attributeof('initialize', component) then
        self.componentsToInitialize:add(component)
    end
    
    if attributeof('update', component) then
        self.componentsToUpdate:add(component)
    end
end

function ComponentManager:initialize(dt)
    self.componentsToInitialize:call('initialize')
end

function ComponentManager:update(dt)
    self.componentsToUpdate:call('update', dt)
end

function ComponentManager:draw()
    assert()
end