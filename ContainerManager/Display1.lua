
require "../Ui/UiTable.lua"
require "../Ui/ColorRGBA.lua"

local json = require("dkjson")

local layer = createLayer()
local sx,sy = getResolution()

logMessage("Display data:")
logMessage(json.encode(getInput())) 

local font = loadFont("Play", 70)
local x = getFontSize(font)

setNextTextAlign(layer, AlignH_Left, AlignV_Top)
local color = ColorRGBAWhite
setNextStrokeColor(layer, color.r, color.g, color.b, color.a)
addText(layer, font, "Refiner", 0.0, 0.0)

local dataTable = UiTable(layer, 20.0, x, sx - 20.0, sy - 20.0, json.decode(getInput()))  
dataTable.gridLines = true
dataTable.oddRowColor = ColorRGBALightGreen
dataTable.evenRowColor = ColorRGBALightBlue
dataTable.Draw()

requestAnimationFrame(100)


