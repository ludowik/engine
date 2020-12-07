function Engine:initEvents()
    self.onEvents = {
        buttondown = {
        },

        buttonup = {
            [BUTTON_X1] = callback('next application', applicationManager, ApplicationManager.nextApp),
            [BUTTON_X2] = callback('previous application', applicationManager, ApplicationManager.previousApp),
        },

        keyup = {
            ['r'] = callback('restart', self, Engine.restart),
            ['escape'] = callback('quit', self, Engine.quit),

            ['t'] = callback('todos', self, scanTODO),

            ['d'] = callback('default application', applicationManager, ApplicationManager.defaultApp),
            ['a'] = callback('applications', applicationManager, ApplicationManager.managerApp),

            ['n'] = callback('next application', applicationManager, ApplicationManager.nextApp),
            ['b'] = callback('previous application', applicationManager, ApplicationManager.previousApp),

            ['v'] = callback('loop 0', applicationManager, ApplicationManager.loopApp, 0),
            ['c'] = callback('loop 2', applicationManager, ApplicationManager.loopApp, 2),

            ['f'] = callback('flip screen', self, Engine.flip),

            ['w'] = callback('wireframe', self, Engine.wireframe),

            ['m'] = callback('portrait/landscape', self, Engine.flip),

            [','] = callback('introspection', self, Engine.introspection),
            
            ['s'] = callback('vsync', self, Engine.vsync),

            ['f1'] = callback('help', self.info, Info.toggleHelp),
            ['f2'] = callback('opengl or opengl es', self, Engine.toggleRenderVersion),

            ['f11'] = callback('fullscreen', self, Sdl.toggleWindowDisplayMode),

            ['tab'] = callback('next focus', self,
                function ()
                    if self.app then
                        self.app.ui:nextFocus()
                    end
                end),

            ['f2'] = callback('timeit', self,
                function ()
                    Performance.run()
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
                        local x = screen.MARGE_X + math.random(screen.W) * screen.ratio
                        local y = screen.MARGE_Y + math.random(screen.H) * screen.ratio
                        
                        mouse:mouseEvent(0, BEGAN, x, y, 0, 0, true, false)
                        mouse:mouseEvent(0, ENDED, x, y, 0, 0, false, false)
                    end)
            end))
end
