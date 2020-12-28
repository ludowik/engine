-- output
class('output')

function output.clear()
end

function setInstructionLimit()
end

function getProjectDataPath(dataType)
    local appName = config.appName:sub(config.appName:findLast('/')+1)
    return getDataPath()..'/'..appName..'.'..dataType
end

function getGlobalDataPath(dataType)
    return getDataPath()..'/'..dataType
end

-- data
local function readData(dataPath, key, default)
    local projectData = table.load(dataPath)
    if projectData then
        if projectData[key] ~= nil then
            return projectData[key]
        end
    end
    return default
end

local function saveData(dataPath, key, value)
    local projectData = table.load(dataPath) or {}
    projectData[key] = value

    table.save(projectData, dataPath)
end

local function clearData(dataPath)
    os.remove(dataPath)
end

-- local data
function readLocalData(key, default)
    return readData(getProjectDataPath('localData'), key, default)
end

function saveLocalData(key, value)
    return saveData(getProjectDataPath('localData'), key, value)
end

function clearLocalData()
    clearData(getProjectDataPath('localData'))
end

-- project data
function readProjectData(key, default)
    return readData(getProjectDataPath('projectData'), key, default)
end

function saveProjectData(key, value)
    return saveData(getProjectDataPath('projectData'), key, value)
end

function clearProjectData()
    clearData(getProjectDataPath('projectData'))
end

-- global data
function readGlobalData(key, default)
    return readData(getGlobalDataPath('globalData'), key, default)
end

function saveGlobalData(key, value)
    return saveData(getGlobalDataPath('globalData'), key, value)
end

function clearGlobalData()
    clearData(getProjectDataPath('globalData'))
end

-- recording
do
    local recording = false

    function startRecording()
        recording = true
    end

    function stopRecording()
        recording = false
    end

    function isRecording()
        return recording
    end
end

-- keyboard
function showKeyboard()
    lca.keyboard.setTextInput(true)
end

function hideKeyboard()
    lca.keyboard.setTextInput(false)
end

function isKeyboardShowing()
    return lca.keyboard.hasTextInput()
end

-- random
noise = love.math.noise
