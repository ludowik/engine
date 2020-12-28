-- Unit testing

UnitTest = class('UnitTest')
UnitTest.newTest = class('Test')

function UnitTest:init()
    self.libTestArray = {}
    self.isActiveLog = true
    return self
end

function UnitTest:add(libName, f)
    local test = self.newTest(libName, f)
    test.functionLocation = getFileLocation()
    table.insert(self.libTestArray, test)
    return self
end

function UnitTest:run()
    self:checkAll()
    return self
end

function UnitTest:checkAll()
    local resultTests = true
    for i,libTest in ipairs(self.libTestArray) do
        if self:checkModule(libTest) == false then
            resultTests = false
        end
    end

    if not resultTests then
        self:log('UT => '..(resultTests and 'OK' or 'KO'))
    end

    return resultTests
end

function UnitTest:checkModule(libTest)
    libTest:f(libTest)

    local resultLib = true
    table.forEach(libTest.tests, function (result)
            if not result.result then
                resultLib = false
                self:log(result.functionLocation..': '..'UT('..libTest.libName..','..result.name..') = '..tostring(result.info)..' => KO')
            end
        end)

    if not resultLib then
        self:log(libTest.functionLocation..': '..'UT('..libTest.libName..') => '..(resultLib and 'OK' or 'KO'))
    end

    return resultLib
end

function UnitTest:log(str)
    if self.isActiveLog == false then return end
    log(str)
end

function Test:init(libName, f)
    self.libName = libName
    self.f = f

    self.tests = {}
end

function Test:assert(testName, result)
    if type(testName) ~= 'string' then
        result = testName
        testName = getFileLocation()
    end

    table.insert(self.tests, {
            name = testName,
            result = result,
            info = tostring(result),
            functionLocation = getFileLocation()
        })
    return result
end

function Test:assertNotNil(testName, value)
    local result = value ~= nil
    return self:assert(testName, result)
end

function Test:assertEqual(testName, value, expectedValue)
    local result = value == expectedValue
    return self:assert(testName, result)
end

function Test:assertBetween(testName, value, min, max)
    local result = min <= value and value <= max
    return self:assert(testName, result)
end

ut = UnitTest()

ut:add('test', function (lib)
        local ut = UnitTest()
        lib:assert('new', ut ~= nil)

        ut.isActiveLog = false

        ut:add('ut.test', function (lib)
                lib:assert('true', true)
            end)
        lib:assert('check true', ut:checkAll())

        ut:add('ut.test', function (lib)
                lib:assert('false', false)
            end)
        lib:assert('check false', ut:checkAll() == false)
    end)
