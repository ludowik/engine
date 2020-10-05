function setup()
    parameter.watch('#app.emitter.particles')

    app.emitter = Emitter()
    app.scene:add(app.emitter)
end

function touched(touch)
    app.emitter:touched(touch)
end
