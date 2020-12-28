class('Module', Lib)

function Module:init(srcPath, libName, defs)
    Lib.init(self, srcPath, libName, nil, defs)

    self:make()    
    self:loadLib()    
end

function Module:make()
    local timeSrc = fs.getLastModifiedTime(self.mainFile)
    local timeLib = fs.getLastModifiedTime(self.lib)

    if config.forceCompilation or timeLib == nil or timeSrc > timeLib then
        print(self.libName..' need to be updated')

        local currentdir = lfs.currentdir()
        lfs.chdir(self.libPath)
        do
            local result
            if osx then
                result = os.execute('make -f make/makefile.osx')
            else
                result = os.execute('"'..currentdir..'\\libc\\bin\\make\\make.cmd"')
            end
            assert(result == 0, result)
        end
        lfs.chdir(currentdir)
    else
        print(self.libName..' is up to date')
    end
end
