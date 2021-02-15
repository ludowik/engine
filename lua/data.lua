function getProjectDataPath(dataType)
    return getDataPath()..'/'..applicationManager.appName..'.'..dataType
end

function getGlobalDataPath(dataType)
    return getDataPath()..'/#.'..dataType
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

-- paths
local localDataPath = 'localData'
local projectDataPath = 'projectData'
local globalDataPath = 'globalData'

-- local data
function readLocalData(key, default)
    return readData(getProjectDataPath(localDataPath), key, default)
end

function saveLocalData(key, value)
    return saveData(getProjectDataPath(localDataPath), key, value)
end

function clearLocalData()
    clearData(getProjectDataPath(localDataPath))
end

-- project data
function readProjectData(key, default)
    return readData(getProjectDataPath(projectDataPath), key, default)
end

function saveProjectData(key, value)
    return saveData(getProjectDataPath(projectDataPath), key, value)
end

function clearProjectData()
    clearData(getProjectDataPath(projectDataPath))
end

-- global data
function readGlobalData(key, default)
    return readData(getGlobalDataPath(globalDataPath), key, default)
end

function saveGlobalData(key, value)
    return saveData(getGlobalDataPath(globalDataPath), key, value)
end

function clearGlobalData()
    clearData(getProjectDataPath(globalDataPath))
end
