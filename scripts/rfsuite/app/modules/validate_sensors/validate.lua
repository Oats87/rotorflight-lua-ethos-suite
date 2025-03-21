local fields = {}
local labels = {}

local enableWakeup = false

local w, h = rfsuite.utils.getWindowSize()
local buttonW = 100
local buttonWs = buttonW - (buttonW * 20) / 100
local x = w - 15

local displayPos = {x = x - buttonW - buttonWs - 5 - buttonWs, y = rfsuite.app.radio.linePaddingTop, w = 100, h = rfsuite.app.radio.navbuttonHeight}

local invalidSensors = rfsuite.tasks.telemetry.validateSensors()

function sortSensorListByName(sensorList)
    table.sort(sensorList, function(a, b)
        return a.name:lower() < b.name:lower()
    end)
    return sensorList
end

local sensorList = sortSensorListByName(rfsuite.tasks.telemetry.listSensors())

local function openPage(pidx, title, script)
    enableWakeup = true
    rfsuite.app.triggers.closeProgressLoader = true

    form.clear()

    rfsuite.app.lastIdx = idx
    rfsuite.app.lastTitle = title
    rfsuite.app.lastScript = script

    rfsuite.app.ui.fieldHeader(rfsuite.i18n.get("app.modules.validate_sensors.name"))

    rfsuite.session.formLineCnt = 0
    local posText = {x = x - 5 - buttonW - buttonWs, y = rfsuite.app.radio.linePaddingTop, w = 200, h = rfsuite.app.radio.navbuttonHeight}
    for i, v in ipairs(sensorList) do

        rfsuite.session.formLineCnt = rfsuite.session.formLineCnt + 1
        rfsuite.app.formLines[rfsuite.session.formLineCnt] = form.addLine(v.name)
        rfsuite.app.formFields[v.key] = form.addStaticText(rfsuite.app.formLines[rfsuite.session.formLineCnt], posText, "-")

    end

end

function sensorKeyExists(searchKey, sensorTable)
    for _, sensor in pairs(sensorTable) do if sensor['key'] == searchKey then return true end end
    return false
end

local function postLoad(self)
    rfsuite.utils.log("postLoad","debug")
end

local function postRead(self)
    rfsuite.utils.log("postRead","debug")
end

local function wakeup()

    -- prevent wakeup running until after initialised
    if enableWakeup == false then return end

    -- check for updates
    invalidSensors = rfsuite.tasks.telemetry.validateSensors()

    for i, v in ipairs(sensorList) do
        if sensorKeyExists(v.key, invalidSensors) then
            if v.mandatory == true then
                rfsuite.app.formFields[v.key]:value(rfsuite.i18n.get("app.modules.validate_sensors.invalid"))
                rfsuite.app.formFields[v.key]:color(ORANGE)
            else
                rfsuite.app.formFields[v.key]:value(rfsuite.i18n.get("app.modules.validate_sensors.invalid"))
                rfsuite.app.formFields[v.key]:color(RED)
            end
        else
            rfsuite.app.formFields[v.key]:value(rfsuite.i18n.get("app.modules.validate_sensors.ok"))
            rfsuite.app.formFields[v.key]:color(GREEN)
        end
    end

end

return {
    reboot = false,
    eepromWrite = false,
    minBytes = 0,
    wakeup = wakeup,
    refreshswitch = false,
    simulatorResponse = {},
    postLoad = postLoad,
    postRead = postRead,
    openPage = openPage,
    navButtons = {
        menu = true,
        save = false,
        reload = false,
        tool = false,
        help = true
    },
    API = {},
}
