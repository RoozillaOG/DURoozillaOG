
local json = require("dkjson")
require "./DisplayData.lua"
require "../Utils/ContainerContents.lua"
require "../Utils/DuElements.lua"
require "../Utils/IndustryState.lua"

unit.setTimer("Update", 10)

local displayData = DisplayData(Refiner)
displayData.Update()


