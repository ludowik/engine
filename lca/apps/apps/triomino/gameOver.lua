function GameOver()
    local scene = UIScene():attribs{alignment='v-center, h-center'}
    scene:add(Label('Game Over'))
    scene.touched = function ()
        app.gameScene.grid:reset()
        app:popScene()
    end
    return scene
end
