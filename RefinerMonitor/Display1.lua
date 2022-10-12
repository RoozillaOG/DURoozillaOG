
require "../Ui/UiTable.lua"

local json = require("dkjson")

local layer = createLayer()
local sx,sy = getResolution()

logMessage("Display data:")
logMessage(json.encode(getInput())) 

local dataTable = UiTable(layer, 20.0, 20.0, sx - 20.0, sy - 20.0, json.decode(getInput()))  
dataTable.gridLines = true
dataTable.oddRowColor = ColorRGBA().LightGreen()
dataTable.evenRowColor = ColorRGBA().LightBlue()
dataTable.Draw()

requestAnimationFrame(100)


