App('appTriomino')

function appTriomino:init()
    Application.init(self)

    supportedOrientations(PORTRAIT)

    self.gameScene = GameScene()
    self.scene = self.gameScene
end
