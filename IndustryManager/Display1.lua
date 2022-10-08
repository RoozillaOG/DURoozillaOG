
require "../Ui/UiTable.lua"

local json = require("dkjson")

local layer = createLayer()
local sx,sy = getResolution()

local dataGrid = DataGrid()
dataGrid.FromData(getInput())
local dataTable = UiTable2(layer, 20.0, 20.0, sx - 20.0, sy - 20.0, dataGrid)
dataTable.gridLines = true
dataTable.Draw()

requestAnimationFrame(100)


