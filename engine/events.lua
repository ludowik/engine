function Engine:initEvents()
    self.onEvents = {
        buttondown = {
        },

        buttonup = {
            [BUTTON_X1] = callback('next application', self, Engine.nextApp),
            [BUTTON_X2] = callback('previous application', self, Engine.previousApp),
        },

        keyup = {
            ['r'] = callback('restart', self, Engine.restart),
            ['escape'] = callback('quit', self, Engine.quit),

            ['t'] = callback('todos', self, scanTODO),

            ['d'] = callback('default application', self, Engine.defaultApp),
            ['a'] = callback('applications', self, Engine.managerApp),

            ['n'] = callback('next application', self, Engine.nextApp),
            ['b'] = callback('previous application', self, Engine.previousApp),

            ['v'] = callback('loop 0', self, Engine.loopApp, 0),
            ['c'] = callback('loop 2', self, Engine.loopApp, 2),

            ['f'] = callback('flip screen', self, Engine.flip),

            ['w'] = callback('wireframe', self, Engine.wireframe),
            
            ['m'] = callback('portrait/landscape', self, Engine.flip),

            [','] = callback('introspection', self, Engine.introspection),

            ['f1'] = callback('help', self, Engine.toggleHelp),
            ['f2'] = callback('opengl or opengl es', self, Engine.toggleRenderVersion),

            ['f11'] = callback('fullscreen', self, Sdl.toggleWindowDisplayMode),

            ['tab'] = callback('next focus', self,
                function ()
                    if self.app then
                        self.app.ui:nextFocus()
                    end
                end),

            ['p'] = callback('profiler', self,
                function()
                    Profiler.resetClasses()

                    if not Profiler.running then
                        Profiler.init()
                        Profiler.start()

                        reporting = Reporting()
                    else
                        Profiler.stop()
                    end
                end),

            ['l'] = callback('light', function ()
                    config.light = not config.light
                end),

            ['i'] = callback('emulate ios', self,
                function ()
                    initOS('ios')
                    self:restart()
                end),

            [KEY_FOR_ACCELEROMETER] = callback('emulate accelerometer', self,
                function (_, _, isrepeat)
                    if not isrepeat then
                        Gravity = vec3(0, -9.8, 0)
                    end
                end),

            [KEY_FOR_ACCELEROMETER] = function ()
                Gravity = vec3(0, -9.8, 0)
            end,
        }
    }

    engine:on('keydown', 'u',
        callback('ui test', self,
            function()
                engine:on('update', function()
                        mouse:mouseEvent(0, BEGAN, screen.MARGE_X + math.random(W), math.random(H), 0, 0, true, false)
                        mouse:mouseEvent(0, ENDED, screen.MARGE_X + math.random(W), math.random(H), 0, 0, false, false)
                    end)
            end))
end
