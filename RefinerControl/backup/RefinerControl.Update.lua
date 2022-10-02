
local json = require("dkjson")
require "../Mock/industry.lua"
require "../Mock/screenunit.lua"
require "../Utils/ContainerContents.lua"
require "./DisplayData.lua"

local displayData = DisplayData(Refiner)
local containerData = ContainerContents(OutputContainer1)
for k, v in pairs(containerData.GetContents()) do
  system.print("Data = " .. json.encode(v))
  displayData[#displayData + 1] = {v["name"],v["quantity"]}
end

local containerData = ContainerContents(OutputContainer2)
for k, v in pairs(containerData.GetContents()) do
  displayData[#displayData + 1] = {v["name"],v["quantity"]}
end
local displayJson = json.encode(displayData)

Display.setScriptInput(displayJson)