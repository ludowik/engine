--[[--
  Use this file to specify **User** preferences.
  Review [examples](+C:/Program Files (x86)/ZeroBraneStudio/cfg/user-sample.lua) or check [online documentation](http://studio.zerobrane.com/documentation.html) for details.
--]]--

-- no TABs stored in the file
editor.usetabs = false

-- to have 4 spaces when TAB is used in the editor
editor.tabwidth = 4

-- to automatically open files requested during debugging
editor.autoactivate = true

-- to disable wrapping of long lines in the editor
editor.usewrap = false

-- to disable zoom with mouse wheel as it may be too sensitive on OSX
editor.nomousezoom = true

-- save modified files before executing Run/Debug commands
editor.saveallonrun = true

-- to force execution to continue immediately after starting debugging;
-- set to `false` to disable (the interpreter will stop on the first line or
-- when debugging starts); some interpreters may use `true` or `false`
-- by default, but can be still reconfigured with this setting.
debugger.runonstart = true

-- keymap
ide.config.keymap[ID.STEPOVER] = 'F10'
ide.config.keymap[ID.STEP]     = 'F11'
ide.config.keymap[ID.STEPOUT]  = 'Shift-F11'
ide.config.keymap[ID.RUNTO]    = 'Shift-F10'

-- font size
local size
if jit.os == 'Windows' then
    size = 9
else
    size = 13
end

editor.fontsize = size
output.fontsize = size

console.fontsize = size

filetree.fontsize = size

-- exclude files
binarylist['*.obj'] = true

excludelist['*.obj'] = false

-- interpreter
if jit.os == 'Windows' then
    path.lua = 'C:/Users/lmilhau/Documents/#Persos/Mes Projets Persos/Libraries/luajit-2.1/src/luajit.exe'
    path.love = 'C:/Programes Files (x86)/LOVE/love.exe'
else
    path.lua = '/Users/ludo/Projets/Libraries/luajit-2.1/src/luajit'
    path.lua = '/Users/ludo/Projets/Xcode/Lca/bin/Lca'
    path.love = '/Applications/love'
end
