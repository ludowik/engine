class 'ComponentManager' : extends(Node)

function ComponentManager:init(...)
    Node.init(self, ...)
    
    self.componentsToInitialize = Array()
    self.componentsToUpdate = Array()
    self.componentsToDraw = Array()
end

function ComponentManager:add(component)
    Node.add(self, component)
    
    if attributeof('initialize', component) then
        self.componentsToInitialize:add(component)
    end
    
    if attributeof('update', component) then
        self.componentsToUpdate:add(component)
    end
    
    if attributeof('draw', component) then
        self.componentsToDraw:add(component)
    end
end

function ComponentManager:initialize(dt)
    self.componentsToInitialize:callWithLog('initialize')
end

function ComponentManager:update(dt)
    self.componentsToUpdate:call('update', dt)
end

function ComponentManager:draw()
    self.componentsToDraw:call('draw', dt)
end
