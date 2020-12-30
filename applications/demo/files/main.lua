if getOS() == 'ios' then return end
    
lfs = lfs or require('lfs')

class('Directory', Table)

function Directory:init(fpath)
    self.nbFiles = 0
    self.size = 0
    self.fpath = fpath
end

class('Coroutine')

function Coroutine:init(f)
    self.f = f
    self.coroutine = coroutine.create(f)
end

function Coroutine:resume()
    coroutine.resume(self.coroutine)
end

function setup()
    disk = Directory('/')

    nbFilesTot = 0
    sizeTot = 0

    app.coroutine = coroutine.create(function ()
            scanDisk(disk)
--            disk:sort(function (a, b)
--                    return a.size > b.size
--                end)
        end)
end

function scanDisk(directory)
    return scanDiskProc(directory, 0)
end

function sortStrings(a, b)
    return a:lower() < b:lower()
end

local function dir(directory)
    local lists = {}
    for fname in lfs.dir(directory.fpath) do
        table.insert(lists, fname)
    end
    table.sort(lists, sortStrings)
    return lists
end

function scanDiskProc(directory, level)
    local res, lists = pcall(dir, directory)
    if res == false then return end

    local nbFiles, size = 0, 0
    for i=1,#lists do
        local fname = lists[i]
        if fname ~= '.' and fname ~= '..' then
            local fpath = directory.fpath..'/'..fname
            fpathCurrent = fpath

            local attr = lfs.symlinkattributes(fpath)

--            local app = fname:right(4)
--            if app == '.app' then
--                print(fname..':'..attr.size)
--                attr.mode = 'app'
--            end

            if attr.mode == 'directory' then
                local subDirectory = {
                    mode = 'directory',
                    fname = fname,
                    fpath = fpath,
                    nbFiles = 0,
                    size = 0
                }
                table.insert(directory, subDirectory)

                scanDiskProc(subDirectory, level+1)

                directory.size = directory.size + subDirectory.size

            elseif attr.mode == 'file' then
                directory.nbFiles = directory.nbFiles + 1
                directory.size = directory.size + attr.size

                nbFilesTot = nbFilesTot + 1
                sizeTot = sizeTot + attr.size

            else
                --print(attr.mode..':'..fname..' ('..attr.size..')')
                
            end

            if nbFilesTot % 500 == 0 then
                coroutine.yield()
            end
        end
    end
end

function draw()
    background(0)
    
    fontSize(12)

    textMode(CORNER)
    
    text(convertNumber(nbFilesTot), 0, HEIGHT-200)
    text(convertMemory(sizeTot), 0, NEXTY)

    text(#disk, 0, NEXTY)

    if fpathCurrent then
        text(fpathCurrent, 0, NEXTY)
    end

    --    for i,file in ipairs(disk) do
    --        if file.mode == 'directory' then
    --            text(file.fpath..':'..convertSize(file.size), 0, NEXTY)
    --        end
    --    end

    local x, y = WIDTH/2, HEIGHT/2

    stroke(white)
    strokeWidth(1)

    fill(pastelRed)

    local size, pct = 0, 0
    local radius = 100

    text("", x + radius * 2, y + radius * 2)

    for i,file in ipairs(disk) do
        if file.mode == 'directory' then
            file.pct = file.size / disk.size

            arc(x, y, radius, pct * tau, (pct + file.pct) * tau)

            pct = pct + file.pct

            text(file.fname, x + radius, NEXTY)
        end
    end
end
