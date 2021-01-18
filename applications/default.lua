function setup()
    app.ui:add(
        Tabs('tabs'):add(
            Tab('tab'):add{
                Label('hello'),
                Button('hello'),
                Label('hello'),
                Label('hello'),
                Label('hello')
            }))
end

function update(dt)
end
